Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D11CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C30886FDF;
	Sun, 15 Oct 2023 09:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vtxs3OJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E3B86FCD; Sun, 15 Oct 2023 09:18:26 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D273786F4E
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:17:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41820eecff2so24562711cf.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697354227; x=1697959027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAIUk9LJg+OTKkkphiTkNtsQibxBAnRGq0UnX7iMUaM=;
 b=Vtxs3OJPYIIFqnZ40Zp/MuetwWs43uTeUALhQ3EI+H6PPTnkiEqcOqPKSRTaR7QLTG
 wAk7qi98MfEtADn7hn7lPNhE8sNqzM4XAO9SB2LHnDJLeck6MU8gCTS0JokfjR5+1iNs
 U9lG0KY2QrAUvoEDDfGueM6QR7krp5K8QMlUwil1NTLkwdXY9e3QvIXJ7fBnk8jFLwBQ
 Z1U+/MFH3n6oe60PWsA6OPAAKofCzQfAKkMDEqKDWRgoY3vdnom19KkZXgteFtAEZGp0
 BZ9i2TJ6Bq4EXO5MftmJs/PLJJis4csrQUNn5JL7G0SafNmQziUmHApol1MeabrorTZq
 oQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697354227; x=1697959027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RAIUk9LJg+OTKkkphiTkNtsQibxBAnRGq0UnX7iMUaM=;
 b=TKWMu0X1/ZeYO5NZ56uTpjigcVB9eZlTg8C90CaSN1lyGoHWv7O2iSW9jIyPcVS0ij
 j8CwocGuxSLhuBS8H+Csql2/gn5CBZXOWKv0lLe9eCQFCuj+W7Y9/hZ+GvGLBX5uwdik
 VkWpVK82feUX+RV6pwfaMpafSqOXluSe8hbdoUJtllVgd/TSuIv0mwS5M+Jui+5a6lb5
 OWg2crx9vhHCN2TSZXFKaN021NSnKwVGCoamFZ3Qs6lk9EVUMKbnB3bMZNEJrkkX1ua2
 4XIK17h77xIKffSsoNPPteMpXSLx++h90FTH2Unxr8xP46ccdSROwpnL4aUL/m1ZtCUY
 tiJg==
X-Gm-Message-State: AOJu0Yz+rkV7nduCvvs5EY2ZCfMTTClEc495YijRID+BDxVPM99p8zqw
 Tt0spzsmxvmFuZYRO/fT1gNjKuNkYGnBDQ==
X-Google-Smtp-Source: AGHT+IFXXVsN+0iCnY3yk8Us+TTALVFlkG+TM75vLzJxjhbmjszbP+4x3ab/ZD2neBVxvNOHYuEpcg==
X-Received: by 2002:a0c:8d07:0:b0:65b:232c:1546 with SMTP id
 r7-20020a0c8d07000000b0065b232c1546mr28621608qvb.24.1697316502776; 
 Sat, 14 Oct 2023 13:48:22 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 q1-20020a0cf5c1000000b006648514e276sm1979432qvm.78.2023.10.14.13.48.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:22 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 13/29] fs: ext4: Fix building ext4 in SPL if write is
 enabled
Date: Sat, 14 Oct 2023 16:47:49 -0400
Message-Id: <20231014204805.439009-14-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

If EXT4_WRITE is enabled, write capabilities will be compiled into SPL, but
not CRC16. Add an option to enable CRC16 to avoid linker errors.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/Kconfig | 1 +
 lib/Kconfig        | 6 ++++++
 lib/Makefile       | 1 +
 3 files changed, 8 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index ad574a600e3..6bc4066fad7 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -657,6 +657,7 @@ config SPL_ETH
 
 config SPL_FS_EXT4
 	bool "Support EXT filesystems"
+	select SPL_CRC16 if EXT4_WRITE
 	help
 	  Enable support for EXT2/3/4 filesystems with SPL. This permits
 	  U-Boot (or Linux in Falcon mode) to be loaded from an EXT
diff --git a/lib/Kconfig b/lib/Kconfig
index 79cf9ef0fa3..f6ca559897e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -687,6 +687,12 @@ config SPL_CRC8
 	  checksum with feedback to produce an 8-bit result. The code is small
 	  and it does not require a lookup table (unlike CRC32).
 
+config SPL_CRC16
+	bool "Support CRC16 in SPL"
+	depends on SPL
+	help
+	  Enables CRC16 support in SPL. This is not normally required.
+
 config CRC32
 	def_bool y
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 1c31ad9531e..2a76acf100d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_TPM_V2) += tpm-v2.o
 endif
 
 obj-$(CONFIG_$(SPL_TPL_)CRC8) += crc8.o
+obj-$(CONFIG_$(SPL_TPL_)CRC16) += crc16.o
 
 obj-y += crypto/
 
-- 
2.37.1

