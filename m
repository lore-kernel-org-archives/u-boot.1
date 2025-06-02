Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1FCC5B555
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 19:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FAC8205A;
	Mon,  2 Jun 2025 21:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J70H7iwu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 072C081E25; Mon,  2 Jun 2025 21:47:08 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B49F381E25
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 21:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-70a57a8ffc3so48649707b3.0
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 12:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748893624; x=1749498424; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXd0i+ohwa0+I1NyqIlPJSL9OP15vEzOLM1JmWxHOL8=;
 b=J70H7iwuVm/ImMyl8uzXqsR86YBRI/nusddprUbpN8hHQjFe7zxKyOh0Kkp0mQk2Ha
 2NJPvoD0/txbITg1z89N0lxKYLPU/C4F15HmgR0MTCLXjmeB8589jgPy7TnEuK8unjED
 c7PHJr2n02Wsrvm0CZhA564MyzrZABbHyTJ1x/sKmv/LyM96msTt6ngpVCTPoj9YWE0M
 0Y+7NpRqGoad0sYej3JBZq1+9PIb+LEFdvBCHQV1uVu2JAvbC7bZ34nuzoN1GPyX3ZrS
 KmOcl3IjWP7ObgXDAicfz2SUqmQ4Tra2F72s4GXvqho+Pye9wkFXYd6XMHmjQzmjn+46
 XD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748893624; x=1749498424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mXd0i+ohwa0+I1NyqIlPJSL9OP15vEzOLM1JmWxHOL8=;
 b=DKc5uVIbxCrjWtGzlGfSL7q4lzFB4zIyi/k9Zw+SKWg8SJLWT7vxe/ybJyPZul9WJb
 xFZro2YbTHsnZ9f7vBc5uhhBPIob7iDH2Z9V4J5iGmWV6gRtuC+LveIUTUzPwWMAGKyA
 0hmJID29sNwpRbyVqP+MNDpjJ8yMnOVtwgoQVVf9KH3LgrOcTdwz/igG1PgZsjGjdU22
 xXeWwoMcp+OVsd5MzkCjkwUV4p0B3G26hMLqpfBRSEr9yFKc0PR4b27h5FKKEUrl0lxo
 ITzAH/ffU5wl7jkD6RgSdIU9ZtgqEjL2ROeAR3mRyxgc8RMfu5AbfTtcvX9APmYaPfaI
 Fnaw==
X-Gm-Message-State: AOJu0Yy9mK8NByRkHdudU8X318L6iMyEYvajSfRXxs2mfXum+rwD9yFK
 7DlltwBuF6B917geqz3LHdy8weIlM0Tajc4X+9sAMR33wf6TwmzpSpBB4ut3
X-Gm-Gg: ASbGncsDV+8mxJoDU3qRJ/6TsIE3iXOcl7aRPj5tiAon6K4Iofv9XJ1azKxt+T4FeH6
 nCwUjdkjH53j8SFcmUfFMbff3YI3cE92FRUxP9Wq3dW5v41mGWhRwj1xCwHu3l1t2546RVknuSX
 mk21yigQNYTzaRJ+7jKaEpKm/A7GF+SQzslfW+UYVlubZk/a2BiNMmQufvkuQIb01FxpeUlFIuZ
 /ExGC9OEJH2aLSrIvHEUWp/TlXE3DFGFNHPOMfaIFa/tLriA+HN6mrdSBXgDv0/KShsZ2+gmOrm
 Kz2JSKJTjwSNXsNdshCpav+UZfoubl9OynNDBjz2SAocjTn9qIOAP9ho2jJYtHPiFC/1qVVZnzv
 +/Q==
X-Google-Smtp-Source: AGHT+IEHJcrruKX/5ERlNjUYoAtQdg3V3bgA7TK8AaEpjUlsqpKuOEQJptiXFSMBbzIgZiKhRr+o5g==
X-Received: by 2002:a05:690c:67c5:b0:70d:f673:1412 with SMTP id
 00721157ae682-7104ed509admr192932737b3.0.1748893624036; 
 Mon, 02 Jun 2025 12:47:04 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-70f8ac0f452sm21902867b3.51.2025.06.02.12.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:47:03 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 01/10] mach-sc5xx: Introduce Kconfig symbols for image
 addresses
Date: Mon,  2 Jun 2025 15:44:39 -0400
Message-ID: <20250602194507.15159-2-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250602194507.15159-1-malysagreg@gmail.com>
References: <20250602194507.15159-1-malysagreg@gmail.com>
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

From: Utsav Agarwal <utsav.agarwal@analog.com>

Add Kconfig symbols to parameterize the SPI flash layout used in a
default-ish configuration. This adds more flexibility to the default ADI
environment, enabling customers with boards based on but not identical
to an ezkit to reuse more of the infrastructure. Furthermore it allows
for yocto (the expected default) or binman (to be introduced in this
series) to configure or use the flash layout based on a single
definition of all of the parameters when creating an image.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>

---


---
 arch/arm/mach-sc5xx/Kconfig | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 30444f04fc4..70c7e5e0631 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -117,6 +117,36 @@ endchoice
 
 endif
 
+config SC5XX_UBOOT_SPL_OFFSET
+	hex "SPL offset"
+	default 0x0
+	help
+	  The default offset where the SPL is located.
+
+config SC5XX_UBOOT_OFFSET
+	hex "U-Boot offset"
+	default 0x40000
+	help
+	  The default offset where u-boot is located.
+
+config SC5XX_FITIMAGE_OFFSET
+	hex "FitImage offset"
+	default 0x1a0000
+	help
+	  The default offset where the fitImage is located.
+
+config SC5XX_ROOTFS_OFFSET
+	hex "RootFS offset"
+	default 0x102000
+	help
+	  The default offset where the rootfs is located.
+
+config SC5XX_LOADADDR
+	hex "Load address"
+	default 0x90000000
+	help
+	  The default load address for u-boot.
+
 config ADI_IMAGE
 	string "ADI fitImage type"
 	help
-- 
2.45.2

