Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E31BCD8CAC
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 08:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEE0484704;
	Tue,  9 Jun 2026 10:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ugku/70Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E920E846A7; Tue,  9 Jun 2026 10:07:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C85778466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 10:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F893236D;
 Tue,  9 Jun 2026 01:07:15 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.27.167])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 356BE3F93E;
 Tue,  9 Jun 2026 01:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780992440; bh=9jTAf2lDYsVMc1vpSdECkAboy6CfIV5qHrVYgz8Dm+k=;
 h=From:Subject:Date:To:Cc:From;
 b=ugku/70ZfO3FUm5uDrn9G6sIdWhB/RkWDzNHqtODjEy9E18nB38JyWBDBXTSz211E
 EUMYFvvy9FXj06Ej1Sb18LPWfyWSDTbyrY0LeCpz9mHd1hoR2r0EBXV/buKRk0UDLP
 XFbjyaSpykwChmTsbdXVV9Ozqd5B93JcbJxRNjOI=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 0/2] efi: fix block io revision and test
Date: Tue, 09 Jun 2026 10:07:03 +0200
Message-Id: <20260609-rev-v1-0-0ccae5bf0fc5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKfJJ2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwMLXaAiXXNzo5TUlKQko7SURCWgyoKi1LTMCrAp0bG1tQCyXacMVQA
 AAA==
X-Change-ID: 20260608-rev-772dedbb2fda
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=751; i=vincent.stehle@arm.com; 
 h=from:subject:message-id;
 bh=9jTAf2lDYsVMc1vpSdECkAboy6CfIV5qHrVYgz8Dm+k=; 
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqJ8m2QdjsQ/ZQRYqM25hNENedXiUxBPgSe9DbO
 krakng3sX2JATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaifJtgAKCRDLSfhWdqMG
 lANsB/wIJEIgi56rDosciCEnmCHsZ45kPsmyk/s7pId67dF9bUvicDIlqZ6xRXfozsDJHg8xHEM
 B+eU0E5zfIADvVBDEgyK1NhSzhA7SGtsEZO9boneqRsS2xaPgU3i+pLyVCIRhs8Pes7BsZoB/mE
 QU5wwRQ3dcpuu7da44AJEl9jg77BR0x2DP6typThmlZe23d9uE2FH+EiJ4e2r/YgpRFOVeOf2AB
 fbKiCrjAMq6PJJHV34H85hMbB50BM1zXVFdVbf2m0ekbfGXX+k+dJxut6HiKF8aD7pBi2N2efHo
 ZrQeCDWOa+IgkdU7I9qEMJ31UIv9cXc8Mkv1/ck5AnQhxj+c
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

Make sure we set the Revision field of our EFI_BLOCK_IO_PROTOCOL structures
to a valid value and add a unit test to verify that.

This can be tested on the sandbox with the following command:

  ./u-boot -T -c 'setenv efi_selftest block device; bootefi selftest'

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
---
Vincent Stehlé (2):
      lib/efi_loader: fix block io revision
      lib/efi_selftest: test block io revision

 lib/efi_loader/efi_disk.c                    |  1 +
 lib/efi_selftest/efi_selftest_block_device.c | 50 ++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
---
base-commit: 1a8b7ad50aed5f5f0a4ccbfd455233919c097293
change-id: 20260608-rev-772dedbb2fda

Best regards,
-- 
Vincent.

