Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5ECC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 14:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A233E88149;
	Thu,  9 May 2024 16:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kgm02nTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60FE8816A; Thu,  9 May 2024 16:38:21 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9781C87FD7
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 16:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-792b8d989e4so67428285a.2
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715265498; x=1715870298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ehx0haR2DDx1Asot1OSvMfhakzN2ADui538Qv0HMaEA=;
 b=Kgm02nTKc5pvEVIyFv+8uQJeWeMVYfickqyq8Zg7EyKyvKjWqWr/HHL4WuwkE3CXNX
 LRF5twhsZhTmgDgKamgI3tgS7mOEo20YUTWsTwbWBYAfCu09Mut8xiPfHXjMqPZJ6Lch
 wLm+5tXka45kUsI2ZTSJ/MSXtxZzgRDumpqn+Om5c9KYHZcfxki7Gj5tRsv03oRw8u0K
 gcUEg7mDO0xtiKaYFbRU4dtm1i66oC5idlbxlCWFNeNBK5OGOm8KdzP6K2RPULDSdFBT
 FYemolcmzSxS7dUWhHFYHSAy9ZILqdgw71/tOLYVqvvsnmQysIWjnONAShhQbr7mLc1D
 lD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715265498; x=1715870298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ehx0haR2DDx1Asot1OSvMfhakzN2ADui538Qv0HMaEA=;
 b=v71DVg6TP3YYSzcdDjxN2r5nUOXIPp4rldF2qQJ7U5Yax72s+ecW8/KyYYByFqlcfc
 i0ogUsrV6H6X3v3p51cEtcmjQS4FjhlDQoFNYrCTnqGTmbyO+XRvIDVpHONdxKVUMErB
 v+QlWR6+4stReEj5AycZAl4bLaHpttMsfP9oqyNHRt2ekgBJwZIhFijLNzBpDKzRtGAs
 MQSEYL46SEYImEta1I3Kgn7Yf6ABLBfuCisS5z036OkV9ZSvZOql9uNaVVsIBTCKlMV2
 AxqI51dr0uFi/K+CfTkl97JyEaVSibmXDaFp6kgf++ycpdVUqNa2x0BQKl+pHjbq3eEo
 VHPA==
X-Gm-Message-State: AOJu0YxeTspgabJ6l3FC6aJ3TVnEUMdkYoA8QviDX7+TwXxq4XHC/TDp
 UNB9tUxLBAQAFlwRPwaI8OrssePtkg3ekG0TyXoSSMTd4Bh5Rh/g+nxLCNaRy7IhI345JNG/ACf
 3
X-Google-Smtp-Source: AGHT+IERHo5rcEDv9VA5dtc2kmQ/xf+ZS3Q+y9EUu6tMnmLbi+7lornLrwpUcbtg1qhCoLNI7MQAUA==
X-Received: by 2002:ae9:f102:0:b0:792:8f3a:b663 with SMTP id
 af79cd13be357-792b2868defmr603289885a.55.1715265498327; 
 Thu, 09 May 2024 07:38:18 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf275b07sm74563685a.24.2024.05.09.07.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 07:38:18 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 4/4] arm: EFI linker script text section alignment
Date: Thu,  9 May 2024 07:37:41 -0700
Message-Id: <20240509143743.1496210-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509143743.1496210-1-raymond.mao@linaro.org>
References: <20240509143743.1496210-1-raymond.mao@linaro.org>
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

Add text section alignment to fix sbsign signing warning
'gaps in the section table may result in different checksums'
which causes a failure of efi_image_verify_diges()

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 arch/arm/lib/elf_aarch64_efi.lds | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/elf_aarch64_efi.lds b/arch/arm/lib/elf_aarch64_efi.lds
index 5dd98091698..bffd9a0447a 100644
--- a/arch/arm/lib/elf_aarch64_efi.lds
+++ b/arch/arm/lib/elf_aarch64_efi.lds
@@ -28,6 +28,7 @@ SECTIONS
 		*(.dynamic);
 		. = ALIGN(512);
 	}
+	. = ALIGN(4096);
 	.rela.dyn : { *(.rela.dyn) }
 	.rela.plt : { *(.rela.plt) }
 	.rela.got : { *(.rela.got) }
-- 
2.25.1

