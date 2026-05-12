Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01476CD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 17:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B3A083FEC;
	Tue, 12 May 2026 19:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="b9Nt4t9C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2794384255; Tue, 12 May 2026 19:40:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0952683E81
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 19:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC8BA1684;
 Tue, 12 May 2026 10:40:48 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.18.174])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFD633F85F;
 Tue, 12 May 2026 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778607654; bh=0QFhrmxs4EgwCzCs8LhQUQlhiA4C6TL5PNR49/Kp7YI=;
 h=From:Subject:Date:To:Cc:From;
 b=b9Nt4t9C67Qe43qLPsF0yVRTNjrq9Y9K/crdzn6iPf1GLKMLc0hWg8ONSy66GbAaV
 JvCmIuoVHeiL9z/2VR/ccH5upC5uWwyjhZlCvz4/PucJXn+Q2VCrs4wXF3wYVGYz/H
 I/dy324bb6o2KR4sTK+HVlk7+eYhFonNKj8MorPc=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 0/2] efi: fix and test hii keyboard layout pointer computation
Date: Tue, 12 May 2026 19:40:32 +0200
Message-Id: <20260512-layout-pointer-v1-0-c0981e907274@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABBmA2oC/x3MQQqAIBBA0avErBN0wKKuEi1CpxoIjbGiCO+et
 HyL/19IJEwJ+uoFoYsTx1Bg6grcOoWFFPtiQI2NtgbVNj3xPNQeORwkCjtvnLfodKuhRLvQzPc
 /HMacP5wPPQhgAAAA
X-Change-ID: 20260512-layout-pointer-29d1cd52c070
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

- Fix one scaled pointer arithmetic bug in EFI Loader HII implementation.
- Enhance the existing EFI HII unit test to catch the bug.

The unit test can run on the sandbox with the following command:

  ./u-boot -T -c "setenv efi_selftest HII database protocols; \
		  bootefi selftest"

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
---
Vincent Stehlé (2):
      efi_loader: fix hii keyboard layout pointer computation
      efi_selftest: test hii keyboard layouts more

 lib/efi_loader/efi_hii.c                 |  3 +-
 lib/efi_selftest/efi_selftest_hii.c      | 67 ++++++++++++++++++--------------
 lib/efi_selftest/efi_selftest_hii_data.c | 12 ++++++
 3 files changed, 51 insertions(+), 31 deletions(-)
---
base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
change-id: 20260512-layout-pointer-29d1cd52c070

Best regards,
-- 
Vincent.

