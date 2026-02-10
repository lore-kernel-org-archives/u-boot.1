Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544EBEB26F1
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 17:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BCA683CBD;
	Tue, 10 Feb 2026 18:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZKmAKRs3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FA0983A5A; Tue, 10 Feb 2026 18:13:50 +0100 (CET)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A08CE83A47
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 18:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-40970f97638so611923fac.3
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 09:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770743626; x=1771348426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ehkV21j/6IA+7kAXdThXnG2qSCrZWnpnwVVw4LCWuA4=;
 b=ZKmAKRs3kVVxP/4bz6hHqOCne67EOlT6dyXc08J67101d0jYOgcOUbd2snXCJRNESw
 3LDx4K8FDWNsE2SawtG4YIGfQ/KRW92rAuJmchXYsqj5rr2YGogHom/UFspfudXeG1Tw
 Gq7KYbrAv9c7x+QYxdFE5UPo44OuFOt3Q8lJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770743626; x=1771348426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ehkV21j/6IA+7kAXdThXnG2qSCrZWnpnwVVw4LCWuA4=;
 b=hxWIfPp+REu2JCDFKAl4n0nOG9Y5xLaTmyo3Ko3WINelByyR00Kemv/atbE+Fze0v2
 MrM/u2kCA3F8GMiUWxsSrDJPAr63p8bi+alGZNK3aEwCLtc1U7IDBvZiA+CiuqXR0VqT
 um88DQvgCKn2U17wpuPdXCLO1D0/vePy9yde7PmrA8LrfXn4fqtZBQbWl1nKjb1wKmkF
 A3p+6/68Gwvf6BERXq7j9bjgdPEBis2y2VAP3BxvkH5CAdqKAtxoxAkyFjYFqeX/sX+d
 TjExYC+NMPrteWEmKaH8g58/tHbkdIUia9u0oUhDtNSXyBnpzguSzowJ2sWgte/h9fq5
 iLxQ==
X-Gm-Message-State: AOJu0YwUapf4op+RoeeokOcnpwi32R8mqpSNu+IDRlDReKMCC8dbSbjA
 B/oI7NAWWTEfRxUOgdMdzlrMPGpEbdAFA1ysegQB4HtpqVCaGReDYw9MPiBq7Q13H7cUvHGD6Er
 xxhm8
X-Gm-Gg: AZuq6aLkS1YL0SqGphbnIbdGZNYpBlEGwUFZOtKzo41dGBCY/Y2XQwvtPmis6nxnff1
 ZAQ+xnao59jantuS3RTjDftGtXv3Ze5TTCg9CvCVdw3MpCSM0V/GejCRN1+E3679ueX5kSz2VGs
 RlljcQdtf3LfYFhCstCQk9ejZwlr1UmMXL+Me7WF5x5yl6eGxGTR0U91QtXgktFQcjcZRVlp3V0
 7JBbyTBkhFUIYecLtvCK/dGswalOkpJtVFZSZvh2TvNl1vBGlxzbWHfrf8IBL5Jph9KSlTObJMh
 oVbKZlBaxfTiHR7lQEsAbaMCjw22GGwpXeSxR3MZgq3sBK5/K1nfAmcmjScmhWdrSDz42q8HJuF
 IUjksDFprPj7woCQ+QFN+sWi7OcybUPnEdiNYItMKNtG3LkxAdgx4VhHIyj3tFjk88LXamrOShP
 WjPVucn6xSQX36wcGNRFEMQ2/77i2t8Ym1/tqC+nt5UGubaBcYzPHsPUFslgjQwr9o/tTl8jyct
 2Xtr3x5b19NkZ9SLOZ2ObJqPHfNp69Yy7BcwSchJFxUMlcMj51wvypEn/4ZZ9Ki
X-Received: by 2002:a05:6870:9e92:b0:409:4c35:a3ca with SMTP id
 586e51a60fabf-40a96c96a6amr8069575fac.15.1770743626228; 
 Tue, 10 Feb 2026 09:13:46 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a992eebd1sm10720933fac.2.2026.02.10.09.13.45
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 09:13:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] MAINTAINERS: Remove a few inactive people
Date: Tue, 10 Feb 2026 11:13:44 -0600
Message-ID: <20260210171344.2723799-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

It has been a long while since Jagan Teki, Joe Hershberger or Ramon
Fried have been active in the community. We thank them for their time
over the years. Remove them from the active maintainer list and mark a
few things as Orphaned for now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 MAINTAINERS | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 288b892f19b4..f8d4f6ee8b25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -751,7 +751,6 @@ N:	stm
 N:	stm32
 
 ARM SUNXI
-M:	Jagan Teki <jagan@amarulasolutions.com>
 M:	Andre Przywara <andre.przywara@arm.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-sunxi.git
@@ -1147,8 +1146,7 @@ F:	tools/file2include.c
 F:	tools/mkeficapsule.c
 
 ENVIRONMENT
-M:	Joe Hershberger <joe.hershberger@ni.com>
-S:	Maintained
+S:	Orphaned
 F:	env/
 F:	include/env/
 F:	include/env*
@@ -1462,8 +1460,6 @@ F:	drivers/mmc/
 N:	mmc
 
 NETWORK
-M:	Joe Hershberger <joe.hershberger@ni.com>
-M:	Ramon Fried <rfried.dev@gmail.com>
 M:	Jerome Forissier <jerome.forissier@arm.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-net.git
@@ -1549,8 +1545,7 @@ F:	drivers/pci/pcie_dw_imx.c
 F:	drivers/phy/phy-imx8m-pcie.c
 
 PCI Endpoint
-M:	Ramon Fried <rfried.dev@gmail.com>
-S:	Maintained
+S:	Orphaned
 F:	drivers/pci_endpoint/
 F:  include/pci_ep.h
 
@@ -1747,8 +1742,7 @@ S:	Maintained
 F:	drivers/rng/smccc_trng.c
 
 SPI
-M:	Jagan Teki <jagan@amarulasolutions.com>
-S:	Maintained
+S:	Orphaned
 T:	git https://source.denx.de/u-boot/custodians/u-boot-spi.git
 F:	drivers/spi/
 F:	include/spi*
@@ -1762,7 +1756,6 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
 F:	drivers/mtd/nand/spi/
 
 SPI-NOR
-M:	Jagan Teki <jagan@amarulasolutions.com>
 M:	Vignesh R <vigneshr@ti.com>
 R:	Tudor Ambarus <tudor.ambarus@linaro.org>
 S:	Maintained
-- 
2.43.0

