Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1B5EE498B
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 17:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B979D83F98;
	Tue, 30 Dec 2025 18:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D0hyZr3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA02683F9C; Tue, 30 Dec 2025 18:10:43 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3DAC83F93
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 18:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3e7f68df436so7443115fac.1
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 09:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767114640; x=1767719440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WTYCWgJjK6lAj+GVkpfK3P9YZ4/tC8XoKyKSf7VDSzc=;
 b=D0hyZr3taEDSYapjUCoEfps7B68sRMS2FSMH7Cv/pXSpOkn0qxQBAfNIekS26qwypK
 l7YYyzPqc0yTu4NYDCh7M62L+kZw73oN72EjJsGdaBNpbKJT0lZhaReUsFBk94uCCOy4
 Me3CdVRwDDL55bmIcfTpa6AbmdlHSAHizrqx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767114640; x=1767719440;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WTYCWgJjK6lAj+GVkpfK3P9YZ4/tC8XoKyKSf7VDSzc=;
 b=NPqgskeEIF8rIxH5IWlRDNfeJ9Mk7q8jcmvEYewW/4vazeMZyUu7K99Vz6/kR6E8pa
 DGc6DwIgYJG81jH/Kcodx+tPcSoz4QL1bkhJ2QUmIgRqpjtVNHt/tlmDtMTX5HzFTYBn
 ObYYAwFBWCPD4FBb4MIDn7FtUlIl52kkZCWK+NCqwfznI83W2WfK17CGJ3OqSyRiaBlX
 uZtq1NbpTB9RzOa5Gk6Yh9mMKZt0fycpbdaBW+tIdIDQ8bvPPk3hOghY3r1NiOZ5sJEK
 GPnbKhF1hS4JLmwn+5UgoEH6NJatPkeZLLCReYCurKlSQ5b1V4BgZANj0aeW2t2KvFgv
 of3g==
X-Gm-Message-State: AOJu0Yyo3Eg9A8FUWD+bZ57xKgHfqhlRhgJYIzMGWPM1Po4pgoDHNllr
 GVxMJuY3vt1hl/70l9oCHJ6l0w9AoaoFAEHY6KQKycw+YJBGHd4Hddiv4V3sGTdm+j8VxQLhYa2
 YII7Fp5E=
X-Gm-Gg: AY/fxX6/JZmtijcCm7jwtAgXwLTQami40K8hKZT9W2mnHR7S6DTp2VhIE3Bs9dfu8GV
 GwLUYNZGwE1affzK4HOXQqRXBrqnlZBii4skZVBfgguZGyhewcd/4DhKj1Xx64aooq7dQLcCGj3
 BB9J6aUVEFxWfgB3wezGZsrY7TWppByICBQA9jOiTpbyOY8Hgv2xgC0mGgz+EUJmBivqcwzn6f9
 xVFWN021cyi27oK3FHOmRuqjoGih3yiF46P+J8i0XfMt8jV5J20kvoJW5IjWv/eCKjMBtz4OP0C
 sdA4hg0h1bs1fnTDi2nGYnna9gcMnSv6TgOm7JaKKRMet69ikZUCTSBvoKjuJzbi8WPxLLWKEPJ
 ThuoZovirfEpU02XpH6bBAg8biYZSHyFB7OnNZjDRcD6yYz4gesb91UcXJrEYR2eiF4WwgBPIVR
 p2QR83Arwn7i/c1KSDQM+2nETYJ8s4ZhAOA/po4tcjlFARuKszToZSFkaC4LKdzZ3eITNosdlTj
 pWt4oUW6PomlZwsTjOTwnsEuiTsF7Q38G3uvECXIA==
X-Google-Smtp-Source: AGHT+IExCyuOdW1X9+GC1YuLXiefXxnZoYpTU0oo+8VsJXh3ap9wjyT3cTqWn3Ca4gmqm19g4mN0yA==
X-Received: by 2002:a05:6870:a44f:b0:3e8:8e57:a40a with SMTP id
 586e51a60fabf-3fa16b8d74emr17655605fac.26.1767114640150; 
 Tue, 30 Dec 2025 09:10:40 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d44fdsm20309462fac.3.2025.12.30.09.10.39
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 09:10:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] spi: Correct dependencies on AIROHA_SNFI_SPI
Date: Tue, 30 Dec 2025 11:10:38 -0600
Message-ID: <20251230171038.4155709-1-trini@konsulko.com>
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

This driver is only possible to build on ARCH_AIROHA, so update the
dependencies.

Fixes: 6134e4efd432 ("spi: airoha: Add Airoha SPI NAND driver")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e31db9d4e31b..63d61ccf8ed2 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -61,7 +61,7 @@ config ADI_SPI3
 
 config AIROHA_SNFI_SPI
 	bool "Airoha SPI memory controller driver"
-	depends on SPI_MEM
+	depends on SPI_MEM && ARCH_AIROHA
 	help
 	  Enable the Airoha SPI memory controller driver. This driver is
 	  originally based on the Airoha SNFI IP core. It can only be
-- 
2.43.0

