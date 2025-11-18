Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBE3CEBF93
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 06:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EAC083C8C;
	Tue, 18 Nov 2025 07:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E1K0S6QF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6035083C72; Tue, 18 Nov 2025 07:40:42 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B04383C6D
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-786943affbaso41875427b3.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 22:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763448039; x=1764052839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xT1PkRZkPoSY/05kWilZPcaAy03rBdQEs8MCVxtguD4=;
 b=E1K0S6QFffIw/g1O4N5jpt85s3mhNcaaxLY7RtDpaChMqVbGqgKCBtGrLjMvILnjoQ
 GmJ9ICtnThdisVL4+tPKZUFgrQsAfFMzJSzQHJfH5CeqcxTC7QTHMT4OBR0u/VTgrER0
 wfJZjrDfcFWfJA+Rmo7yb4LLO0PM1NxcvURaulC3C67A2PjdtErEcqv15YM1J359Bp8B
 LyeBuhHVDTPT/t6tPInn9pHq55NJ3MkFu4mbRKFiq9P3EEYqblny4zqWrC1OUpx6U8vX
 t1dz9K8rgrAnltn9SdNzYVzVzxvkz8nuzsKyre2fMT/DCAHhQLi/e9XxZGPudcku8GX0
 UHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763448039; x=1764052839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xT1PkRZkPoSY/05kWilZPcaAy03rBdQEs8MCVxtguD4=;
 b=hIIArwR8HHgP9epZ1jBuyPOHkwKjfBLdQJoPRUEzU+YCLQSZlbl5vcqhvasS2Qbz1R
 jMRAWZI6CWZr2eksDRRalKZQhtRdXrLN5OVkR4zS/Ap7jVmkwRVLzj3T6ieldhvuDpmc
 Y17sGD9w9Ccb3i6F1Qdrx6c6gTVec69TvaL4u6xcCnnpZM0gFvhfXmlk3Q1SFVPIFDfj
 4of+gvqq9bFdrhZ4YrTpEB9eSav4P1ineYorSLHqj8SbClJAXLsetRqEv4qrQVgVNndN
 DXrUxudWQmh+5tlL0S82Uhwx1vcMIc7L0vwJ6+7doHGY7AzgNG3p1tlK3gB+QNoUayeN
 +Q1w==
X-Gm-Message-State: AOJu0YzMTFKj33p8YOEuz4FYDbLPI4RigIr34tDBVzE1TA1Bt81VmeHB
 RPk47pvD2spHxq72eiEfyct/Copyc8CwnPACX4eMhFBH2XeDwWsQjChvQ0uY
X-Gm-Gg: ASbGnctJQ3JozIyDPBfiMPAPvHP/r6Kbz6zg+uvNPRclcMK071iy4zRZQM/h0EmJ/wa
 YadSUUikaFjGcNPMQ8aghMEMSkDRseVIVpah12jF6+xWriynQEqs+WGfgQnj5OsUWLeT/1Rt01q
 gAmd5uroLiyxoH4M7ZH9ObKTvXMWfIS2UlUi0LmRyJsr935RhDRP5Y82yev2vBwblCb9HOnvNvv
 2B4o9ipaa1rfF5/UL/JlUPnDWrUqrtJ8CaDNmFd6XueglQJx9b/3DS6QO3ACO3az9Mkqh6mg/TE
 9SduHA1C1Y+y/sAq3PspAhlMGjckjAzB5lH+e+m36k/QS/jJoFy8BiRWPorQirzpwbWskg2Cif/
 7CQFm7T2VGCmaxmsZMU4JTEXOEcW2uePwfJCYQzTA7x2tC3FFJUP4+SHZEpAraadhTNANgdeToN
 n30XVP/tqgRAg/jvY=
X-Google-Smtp-Source: AGHT+IE7PaaWXJXqzT3YXxcDqruv813vQ+9KT6HPDlnb5k37mUQzAqOkpPiX5otKJ8/Y3WSrky4puA==
X-Received: by 2002:a05:690c:630f:b0:788:1cde:cad6 with SMTP id
 00721157ae682-78929e32b10mr125995217b3.15.1763448038710; 
 Mon, 17 Nov 2025 22:40:38 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78822128160sm49781967b3.32.2025.11.17.22.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 22:40:38 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Tom Rini <trini@konsulko.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 01/12] mach-sc5xx: Introduce Kconfig symbols for image
 addresses
Date: Tue, 18 Nov 2025 01:39:34 -0500
Message-ID: <20251118064000.14613-2-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251118064000.14613-1-malysagreg@gmail.com>
References: <20251118064000.14613-1-malysagreg@gmail.com>
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

(no changes since v1)


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
2.49.1

