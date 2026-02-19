Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56E3E9A05A
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 18:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F0683D2E;
	Thu, 19 Feb 2026 19:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 971B883AC5; Thu, 19 Feb 2026 19:44:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 765B583AC5
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 19:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6642C339;
 Thu, 19 Feb 2026 10:44:13 -0800 (PST)
Received: from debian (unknown [10.57.12.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 872403F62B;
 Thu, 19 Feb 2026 10:44:18 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/5] efi_selftest: manageprotocols fixes and enhancements
Date: Thu, 19 Feb 2026 19:43:55 +0100
Message-ID: <20260219184400.257008-1-vincent.stehle@arm.com>
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

This patch series contains fixes and enhancements for the UEFI Protocols
management test. It is broken down in small steps to ease review; feel free
to squash and/or cherry-pick.

It is possible to verify with valgrind that the first couple of fixes in
this series do indeed remove invalid writes, with the following steps:

1. Modify the efi_allocate_pool() and efi_free_pool() functions to call
   malloc() and free() respectively.

2. Build U-Boot with sandbox_defconfig and CONFIG_VALGRIND=y.
3. Run the following command:

  $ valgrind --suppressions=scripts/u-boot.supp \
      ./u-boot -T -c "setenv efi_selftest manage protocols; \
                      bootefi selftest"

Best regards,
Vincent.


Vincent Stehlé (5):
  efi_selftest: fix buffer overflow
  efi_selftest: fix buffer overflow and memory leak
  efi_selftest: remove unnecessary initializations
  efi_selftest: fix buffer size and count computations
  efi_selftest: cosmetic: fix spelling in comments

 .../efi_selftest_manageprotocols.c            | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

-- 
2.51.0

