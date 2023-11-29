Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92806C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 10:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD89487550;
	Wed, 29 Nov 2023 11:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="VigM4rcc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6A18754A; Wed, 29 Nov 2023 11:11:22 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB16A869F7
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 11:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a0064353af8so141510766b.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 02:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1701252680; x=1701857480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4JtrIFT6jPxX5BZvbsBOaYK95Syv/6D+VdCiIQxjg8A=;
 b=VigM4rccJf55G8E5xJX6eNBJ7Zwf/v/x99Ki9By0g+0B5wWMbD2OdmGfGdqiw4NWNb
 /oJBratH5S/CalNTBcKlOClDU4KdyB1mAazkYrDia0aENpQrWzMnK6n97rb9kY2Ob2X7
 Uzr7DFc8KaHBglxIeSJTW0l0xTikCV0DL/mOITy3h4aezfUADvX8utbGzIYphYHEd43p
 cJE0MBSexk0bkN4nsPVSGwG2PE1Z001KX57p4KZmGtNgjTqfHhS9z9aPKYuLdXGNK4HJ
 7PuoQi/X9bCJ4zvRkaTh2QSOg6iScJYv+yIw17iz3F5QN/C/EBVneIh4UES/MoXpcCkY
 it+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701252680; x=1701857480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4JtrIFT6jPxX5BZvbsBOaYK95Syv/6D+VdCiIQxjg8A=;
 b=fJZI7vkYFh4hq9zC1YBVfozMOOiNiDAFbaRs+hic+p8Pb/+sNxC7xiCewIXsbMsVR3
 s1x+KvZuT7hDgM1ZyI4Qgv0pU2eFwzP+phpWMwvKhX5u51ktmftXr60C2dLpeSmTX2lE
 VeJR9QQN8n80UGMDNzgg0n7a3dC4z1yDCUiGVimC6U8yp8+/elmvcVhC/hpQN/krOeIx
 itdlUsfx1q/vzKI6BsqEcDyP4dW67M6N8kA9cqhBPoxRGsXMZTvtSi0HHOH24menXA1S
 s1c7dIRtEzTUl9zJ2PMTsdsqkzk9BD4xMc7gkdZwTfPWb3b0JjwtqU0U39QGZhy1IsOA
 OP9g==
X-Gm-Message-State: AOJu0YzL3Dm/v0qcugaonLlGVPgBmFS3wCz5H9ecaMNKndTpycFnkcOZ
 KdFai0GAdobDaRvB11SlLGfiXRD9jAQqBX47LB8=
X-Google-Smtp-Source: AGHT+IFwUD5F4V9a/POPbYWwQhraLanDgt+22b9zKXieCWJn45SZ4zqDK7ohir9k/DYyuvApG9KVCQ==
X-Received: by 2002:a17:906:d7a2:b0:9a9:f0e6:904e with SMTP id
 pk2-20020a170906d7a200b009a9f0e6904emr17151269ejb.16.1701252680150; 
 Wed, 29 Nov 2023 02:11:20 -0800 (PST)
Received: from fedora.. ([213.149.38.84])
 by smtp.googlemail.com with ESMTPSA id
 t17-20020a170906a11100b00a015eac52dcsm7691384ejy.108.2023.11.29.02.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 02:11:19 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: sr@denx.de,
	u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 1/3] arm: mvebu: Espressobin: move FDT fixup into a
 separate function
Date: Wed, 29 Nov 2023 11:11:06 +0100
Message-ID: <20231129101117.60177-1-robert.marko@sartura.hr>
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

Currently, Esspresobin FDT is being fixed up directly in ft_board_setup()
which makes it hard to add support for any other board to be fixed up.

So, lets just move the FDT fixup code to a separate function and call it
if compatible matches, there should be no functional change.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Stefan Roese <sr@denx.de>
---
 board/Marvell/mvebu_armada-37xx/board.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index 04124d8014..1471caa9a6 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -363,18 +363,14 @@ EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 #endif
 
 #ifdef CONFIG_OF_BOARD_SETUP
-int ft_board_setup(void *blob, struct bd_info *bd)
+static int espressobin_fdt_setup(void *blob)
 {
-#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
 	int ret;
 	int spi_off;
 	int parts_off;
 	int part_off;
 
 	/* Fill SPI MTD partitions for Linux kernel on Espressobin */
-	if (!of_machine_is_compatible("globalscale,espressobin"))
-		return 0;
-
 	spi_off = fdt_node_offset_by_compatible(blob, -1, "jedec,spi-nor");
 	if (spi_off < 0)
 		return 0;
@@ -459,6 +455,14 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 		return 0;
 	}
 
+	return 0;
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
+	if (of_machine_is_compatible("globalscale,espressobin"))
+		return espressobin_fdt_setup(blob);
 #endif
 	return 0;
 }
-- 
2.43.0

