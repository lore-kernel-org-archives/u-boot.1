Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15122C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 11:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA23887D5;
	Wed,  3 Jul 2024 13:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7168C88813; Wed,  3 Jul 2024 13:38:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 068D6882DB
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 13:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68994367;
 Wed,  3 Jul 2024 04:38:30 -0700 (PDT)
Received: from localhost.localdomain (X72Y076X74.nice.arm.com [10.34.125.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 811603F762; Wed,  3 Jul 2024 04:38:04 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 0/2] Respin bootstd cros patch into a series of two
Date: Wed,  3 Jul 2024 13:37:54 +0200
Message-ID: <20240703113756.1293218-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627170629.2696427-1-vincent.stehle@arm.com>
References: <20240627170629.2696427-1-vincent.stehle@arm.com>
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

This is a respin of this patch [1] after discussion [2]. Thanks to
Simon and Heinrich for their reviews.

To use the guidcmp() function, as suggested by Heinrich, we need to
make it available to bootmeth_cros.c and I think that the cleanest way
to do that is (arguably) to move the guid helper functions to efi.h
near the efi_guid_t definition; this is why the original patch has now
become a series of two patches.

The alternative would be to include efi_loader.h from bootmeth_cros.c
but I think this does not sound "right". If this is in fact the
preferred approach just let me know and I will respin.

There is no difference in the sandbox binaries before/after this
series on Arm and on PC, and all the tests I have run on the sandbox
are unchanged.

Best regards,
Vincent.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240627170629.2696427-1-vincent.stehle@arm.com/
[2] https://lists.denx.de/pipermail/u-boot/2024-June/557588.html

Vincent Stehlé (2):
  efi: move guid helper functions to efi.h
  bootstd: cros: store partition type in an efi_guid_t

 boot/bootmeth_cros.c |  6 +++---
 include/efi.h        | 10 ++++++++++
 include/efi_loader.h | 10 ----------
 3 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.43.0

