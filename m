Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26366E7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 04:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20DE380658;
	Sat, 11 Jan 2025 05:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="Z6Qynz/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54AF3801B0; Sat, 11 Jan 2025 02:56:04 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3BD18036B
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 02:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.lin@sifive.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21661be2c2dso43406745ad.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 17:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736560560; x=1737165360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DfC/i21afPfCmXaJVWPT1N4jUmsSaERssCahNdCfdOg=;
 b=Z6Qynz/NYfiT7RMh6axSfzRoke3yFXK2pz7LrygEUIGQH0eAkm6zf/w6LjOjFCLfXc
 Fk3ZwFuTELuY/9PqO2p7w0OLz01bRDkCdj+VhC5uyVi0zwv56PU5dPOsgKX4toCb6RaV
 cm0+9DRQCOtvEDfnMl5CrEbqHO9DbTWa633g45WFRgAwQUQVuV0ysu+I8uel+8X4QiW+
 W2mHmzHh/nRb6UuNRsrG2Eq8LghLcQBP+CSGLxXnUr1aMWRN7fla1AABjUENWzfZwCAI
 6HnJDHTvn4gMUS5dIYQ69asXltS3LJk6O38ouUkB16X0//b98M9RPSF/mlV5nUmZsepL
 YQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736560560; x=1737165360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DfC/i21afPfCmXaJVWPT1N4jUmsSaERssCahNdCfdOg=;
 b=mGOyTd+VdKsSfWdUbSUwymSclL7z+Jene6ugx2n5EOMRVZTfhJOWKFnKfF/+ZB4Pcl
 s/RxDkbUd3DKU3NbcvIDzZlVasNz/p6lC3kjinMVi0mzzc/YVYzSolaAq0xdHaNpPpCj
 S4oQSPwqB0lW0tFL1f/4kkr0NS/msId2hAsj3yQ/orc+jBibILJ/NSBGLFATosF4PWMa
 5edmV+ZXrCaDRkVS41NJAON0nqlkOHOYniwCdQixzftf4OQAlDiwmJOpcbJyRGAw2ECD
 4Jq3MgbSBk3/HH08LXOsJmhAB+/NFbp40LpcH8vEPUv/SEj/PloSwPbJTnms0if1yjoq
 6i1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4aWcOybvcYWi9K+mXMPgbXuWjRhdviXcn5QXKplL9gEZ+Xx2G5v13qYA8r0HQBK/tEzK7GfQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6H1tDLqNjOL3pn2hcZ9pgOvL7Xqp7SDSgZzqaqu+8ZJ/NLGxq
 7g5xuDL57htaPMLKMv57EBV+nSXVDXf8eT09Eql2nnDdqUTL1dQ44Mh719VVQoY=
X-Gm-Gg: ASbGncuHvSfsp+mie3IGBdZPTSokOIAzNH8VNYuRrDQG54qF9EcjrKXowhSxR3b8jK1
 q9k0yQFSvMwumb/hDrT/LwXHYyY01pz3ES4qGkjziQQAb0k1/aYk04Qkx6F8F7gDWsXTrYsg4Pp
 eiR6/b7zkuRly+V5rKMaMmvP63dpKI+0UiZ/ja24OcfwkrQfWyLNjH0ENyJAzS89Q01cmztw+Km
 WDWE7WJncgVEt5P73Yfz/vTkoPSCr6OrKM74VxarNs78xccip0RhyPY6MInHuJivWuHaZM711Kb
 TCc8CmOf9hMAmIBGxoGef6Id23sulbrRs5f/nYfw7xo++dpr3WaLr8F36LrjwFg=
X-Google-Smtp-Source: AGHT+IFNj8RQn8KgJLk6Z+59Zo4+tq5N0qX2ipqyUR6nYFaK4hR1Ky7y8wHn69+Wg3fZT8d+mfVQPw==
X-Received: by 2002:a17:902:e808:b0:215:44fe:163e with SMTP id
 d9443c01a7336-21a83f36f46mr216774045ad.1.1736560560228; 
 Fri, 10 Jan 2025 17:56:00 -0800 (PST)
Received: from peterlin-1873.internal.sifive.com
 (111-254-79-27.dynamic-ip.hinet.net. [111.254.79.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10e0c4sm18901555ad.24.2025.01.10.17.55.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 17:55:59 -0800 (PST)
From: Yu-Chien Peter Lin <peter.lin@sifive.com>
To: ycliang@andestech.com, trini@konsulko.com, xypron.glpk@gmx.de,
 seashell11234455@gmail.com, dan.carpenter@linaro.org,
 mchitale@ventanamicro.com, ben.dooks@codethink.co.uk, u-boot@lists.denx.de
Cc: Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [RFC PATCH 2/2] riscv: dts: binman.dtsi: Include OP-TEE OS image
Date: Sat, 11 Jan 2025 09:55:27 +0800
Message-Id: <20250111015527.35528-3-peter.lin@sifive.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250111015527.35528-1-peter.lin@sifive.com>
References: <20250111015527.35528-1-peter.lin@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Jan 2025 05:43:13 +0100
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

The following diagram illustrates the boot flow for OP-TEE OS
initialization on RISC-V.

    (1)-----------+
     | U-Boot SPL |
     +------------+
         |
         v
    (2)-------------------------------------------------------------+
     | OpenSBI (fw_dynamic.bin)                                     |
     |                (4)------------------------+                  |
     |                 | optee dispatcher driver |                  |
     +-----------------+-------^---------|-------+------------------+
M-mode   |                     |         |
---------+--[trusted domain]---+----.----+--[untrusted domain]-------
S-mode   |  (coldboot domain)  |    |    |
         v                     |    |    v
    (3)---------------------------+ |(5)----------------------------+
     | OP-TEE OS (tee.bin)        | | | U-Boot (u-boot-nodtb.bin)   |
     +----------------------------+ | +-----------------------------+
                                    |    |
                                    |    v
                                    |(6)----------------------------+
                                    | | Linux                       |
                                    | +-----------------------------+

This patch enables the inclusion of the OP-TEE binary within the
U-Boot ITB, allowing it to be loaded to a platform defined address
by U-Boot SPL.

Signed-off-by: Yu-Chien Peter Lin <peter.lin@sifive.com>
---
 arch/riscv/dts/binman.dtsi | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 9271de0ddfc..0405faca574 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -53,6 +53,19 @@
 					};
 				};
 #endif
+#ifdef CONFIG_OPTEE
+				tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = "riscv";
+					compression = "none";
+					os = "tee";
+					load = /bits/ 64 <CONFIG_SPL_OPTEE_LOAD_ADDR>;
+					tee_blob: tee-os {
+						filename = "tee.bin";
+					};
+				};
+#endif
 
 				opensbi {
 					description = "OpenSBI fw_dynamic Firmware";
@@ -88,11 +101,20 @@
 #endif
 					description = "NAME";
 					firmware = "opensbi";
-#ifndef CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT
-					loadables = "uboot";
+#ifdef CONFIG_OPTEE
+#ifdef CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT
+					loadables = "linux", "tee";
 #else
+					loadables = "uboot", "tee";
+#endif
+#else /* !CONFIG_OPTEEE */
+#ifdef CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT
 					loadables = "linux";
+#else
+					loadables = "uboot";
 #endif
+#endif /* CONFIG_OPTEE */
+
 #ifndef CONFIG_OF_BOARD
 					fdt = "fdt-SEQ";
 #endif
-- 
2.39.3

