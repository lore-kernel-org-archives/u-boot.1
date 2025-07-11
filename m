Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DBBC83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65A983018;
	Fri, 11 Jul 2025 17:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q3o/U0XC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F404983018; Fri, 11 Jul 2025 17:20:30 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC59C83192
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-40a4bf1ebb7so1153301b6e.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752247227; x=1752852027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5H3ElZ08aNsBRSxvMNHkUh0PITGDl+yuq/VHRuMaJ7k=;
 b=Q3o/U0XCCp6ZLFN+a9NqpvUsHGzAG162u9ArN5gk5FEGv/qtdA1xFQYqDHWgOh/6Jp
 HC26WG47g5/PLv0xWdVwtUuj2LHRsOxt6G1IX5CLkNGFFp5lz5puMZVhgmeMPYN9lRnO
 hiHfvn6Q0RJLwHQIaPIoQdegW/8kmGgy/hCH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752247227; x=1752852027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5H3ElZ08aNsBRSxvMNHkUh0PITGDl+yuq/VHRuMaJ7k=;
 b=vNWyiQl1MqWHDb1CCrqAlkYqkPd3BksbiWsjhXM2szq6hiHZLCmDQiNYWJaXhKszU9
 EctGjcLyb2E1ij1WeJNfNyrDQIDBtHrjYtvimH9+pw53uCI9ILZn8FNzqMBnW0ZhppeC
 ZOEQ3D0V55JkTndgqi8AD289YOFrbo9oAumrAv2T4djWO4k7Fp/TqWrYhGLtxWV0WuPR
 /vz9iphMn4yMr4juEF9HP/nqK5EqmcgE8CxZaHtT8JYqQk44KQCPhE4PY7zCO9eTBddf
 GY3PqRCd6wZfNafR4bw/PtbD/sjmXDdOcek2UVxl31EkUtjml/wgEQisH8DXtfor3Qty
 pd3w==
X-Gm-Message-State: AOJu0YxhY8GpObYai4S1hoOJHf4QNg5S9CtuyxCNhGPH/0fHq2VqNKeh
 eySb5p7D3n7l3sH/dqQ+oT+aM9TCXw9Mbg2vyNPJDcCTpefYsqjowf+qGCCNKO+omFduWaIJ/4X
 LswTRZ3A=
X-Gm-Gg: ASbGncuV+n+fH72mtQ9eHGgIxYOATBuxS9xipCzAm8Tyk/80E7iywbnhqJhGNNzy1XR
 hVAJpE4YzBKPne1loTUAcTckahUs+rhkFsPu22eU4mePqeBHzJvK0juEKt4kW0lryDnTSo74zZb
 2AkZDRgn4s0pVJ6W+qfDZHaeUthQbd4O92u7WgoOabbZPjVbkmPifbEneDUPNswnXoSV1KL3Ie/
 6dHP6eoazj8b3/N8bbz6fw7Fz74NCveutZSXstklymaBARG++qMp6CaQG0A5dUFP1/eOaBGCAIp
 c1XJT0OMlJ7OP37Co+n7T2NlIldyem5HxMxi5ctB1fabG1gUJ5MW/NkJBjXIZDzvAPbt/3i6Fa4
 Ch8EC6LM6H8iNkzasIw2/D8r2SZQoMUylUI22x67x5SL7DhBtxWyDcDfAPz0=
X-Google-Smtp-Source: AGHT+IHtM7Lf6qbNqziKVKEBDwbF4RJKRSXMMEqRykZn2Kc7IkQAlksAA+tGwSix9MUWeqfgMvBieg==
X-Received: by 2002:a05:6808:4f07:b0:3fa:3a0:137b with SMTP id
 5614622812f47-41539aa3e79mr2068660b6e.29.1752247227190; 
 Fri, 11 Jul 2025 08:20:27 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-41418c0b8a6sm548647b6e.3.2025.07.11.08.20.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:20:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] nxp: Move FSL_SEC_MON related options to arch/Kconfig.nxp
Date: Fri, 11 Jul 2025 09:20:25 -0600
Message-ID: <20250711152025.2225590-1-trini@konsulko.com>
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

The options related to FSL_SEC_MON are part of the chain of trust
related options and should be under that menu, so move it there.
Furthermore we don't need to prompt for the driver itself but do need to
allow for configuration of the monitor endianess.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/Kconfig.nxp     | 22 ++++++++++++++++++++++
 drivers/misc/Kconfig | 22 ----------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/Kconfig.nxp b/arch/Kconfig.nxp
index 5a8c382ed753..ef9087d01973 100644
--- a/arch/Kconfig.nxp
+++ b/arch/Kconfig.nxp
@@ -84,6 +84,28 @@ config SYS_FSL_SFP_VER_3_4
 
 endchoice
 
+config FSL_SEC_MON
+	bool
+	help
+	  Freescale Security Monitor block is responsible for monitoring
+	  system states.
+	  Security Monitor can be transitioned on any security failures,
+	  like software violations or hardware security violations.
+
+choice
+	prompt "Security monitor interaction endianess"
+	depends on FSL_SEC_MON
+	default SYS_FSL_SEC_MON_BE if PPC
+	default SYS_FSL_SEC_MON_LE
+
+config SYS_FSL_SEC_MON_LE
+	bool "Security monitor interactions are little endian"
+
+config SYS_FSL_SEC_MON_BE
+	bool "Security monitor interactions are big endian"
+
+endchoice
+
 config SPL_UBOOT_KEY_HASH
 	string "Non-SRK key hash for U-Boot public/private key pair"
 	depends on SPL
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index c4a4510f9687..d7433120b75a 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -294,28 +294,6 @@ config FSL_IIM
 	bool "Enable FSL IC Identification Module (IIM) driver"
 	depends on ARCH_MX5
 
-config FSL_SEC_MON
-	bool "Enable FSL SEC_MON Driver"
-	help
-	  Freescale Security Monitor block is responsible for monitoring
-	  system states.
-	  Security Monitor can be transitioned on any security failures,
-	  like software violations or hardware security violations.
-
-choice
-	prompt "Security monitor interaction endianess"
-	depends on FSL_SEC_MON
-	default SYS_FSL_SEC_MON_BE if PPC
-	default SYS_FSL_SEC_MON_LE
-
-config SYS_FSL_SEC_MON_LE
-	bool "Security monitor interactions are little endian"
-
-config SYS_FSL_SEC_MON_BE
-	bool "Security monitor interactions are big endian"
-
-endchoice
-
 config IRQ
 	bool "Interrupt controller"
 	help
-- 
2.43.0

