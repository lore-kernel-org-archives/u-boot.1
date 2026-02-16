Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E197BE7BD92
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 11:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2893480FA1;
	Mon, 16 Feb 2026 12:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 425288063E; Mon, 16 Feb 2026 12:30:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9BBA083AA9
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 12:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C642150C;
 Mon, 16 Feb 2026 03:30:20 -0800 (PST)
Received: from debian (unknown [10.57.12.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AAF733F632;
 Mon, 16 Feb 2026 03:30:25 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Sathisha Shivaramappa <sathisha.shivaramappa@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] efi: test and fix specific LoadImage() return code
Date: Mon, 16 Feb 2026 12:30:15 +0100
Message-ID: <20260216113017.4135639-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi,

This couple of patches addresses a specific case of LoadImage(), which is
now tested by the SCT [311] and has been sent to me by Sathisha (thanks!)

The first patch fixes the specific return code and the second patch adds a
unit test for this specific case; we do this in that order to avoid
breaking the efi self test.

Best regards,
Vincent.

[311] https://github.com/tianocore/edk2-test/issues/311

Vincent Stehlé (2):
  efi_loader: fix specific LoadImage() return code
  efi_selftest: test specific LoadImage() case

 lib/efi_loader/efi_boottime.c             | 8 ++++++--
 lib/efi_selftest/efi_selftest_loadimage.c | 7 +++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.51.0

