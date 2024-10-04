Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DDFCFA751
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 08:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2957589012;
	Fri,  4 Oct 2024 10:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KxUgD77T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C2348901A; Fri,  4 Oct 2024 10:41:29 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7648A88F6B
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 10:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso18860825e9.2
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 01:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728031287; x=1728636087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D8SaGj5GAPIk7rtP6x8uncDWiEmBXqI9qO8h7Y8pnl0=;
 b=KxUgD77TZX16wvS9z2IFTQScrMQK0XfK3bsep2Sl9r/+bqVHtA5/UNoQdEkCx1cgz5
 vHVD315B1a0IbQxrZEV8ddpVvJRPE0JJYKHHwnTxBDk5J2GNMELH6AhPAHeiagNIyKYo
 Vola0mUFVD+TLC21ln1MtrcvI73ByEltyWlADnS1+txEuVmbl6AMuR1EkQMDgJbk/unS
 VbbXcabezccGtbC0DPksLGHk/lVXKlX+RlAlkGBcvkg80YXTlp9HtaPEE+ZWEUTBP+TU
 0haHBHdjiDDF84o7wTXd9cswOU9pBURW0cYVl/p/4/53MSD5rv0phtFT1v37slpLLjMZ
 H/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728031287; x=1728636087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D8SaGj5GAPIk7rtP6x8uncDWiEmBXqI9qO8h7Y8pnl0=;
 b=hQ8zg4/V3hR0HDaOiEuaaEAd+vFMK1fO1KjmMaif6k8DyUr0Czr5HjkDIdsfGk5Ezl
 NhIwb4Y9s2si0ps2GQ1FGuoKSYa1Ai4CZfDr3DhYEMPL9+/qRUpfLytdnpkNmT/cmjZI
 iWX9ttOjFUSHuEO6kIBomvSyj3Y04i4KA9Q0yKnTm08mlyYHPMbvnVmIffkPym2VHfT0
 T4jD8xYinHmMR953NviV28e2W2w+UETa/xlYvDPioUIiPGClTQcFEr4zv+KxrSE7XHO8
 9iBZNZy7KZ0MaiuHNFe9Mg0ewYPvvw5WPeQWRlOcLh9DrDXZgjSLBmn/zGoBLQV+Dh/p
 KGow==
X-Forwarded-Encrypted: i=1;
 AJvYcCU//kSIwgf52aop4vyK8G/v0ngR4qv/vCvRL0963MwIDDeG4kpH2LBP+/0ZVMIEFawljzQII+c=@lists.denx.de
X-Gm-Message-State: AOJu0YwgX7NhBNwDkdiaYk1shitS6RKNDiXICQLZEVvVO+uk5sO8mdH6
 34FAu3Yg4d/uQGH9zsUq/tS9X57Rly430Ns1nOooVyuAQdMZ0Ks5
X-Google-Smtp-Source: AGHT+IHixWOrUWRmKpqLZ5haYwCiu3fYcvOxKWVjsblryTMvwFhi3CyU1fWKVykbZsBK+Ys0xaYNig==
X-Received: by 2002:a05:600c:3ca6:b0:42c:b16e:7a22 with SMTP id
 5b1f17b1804b1-42f85aae4bbmr13157505e9.12.1728031286557; 
 Fri, 04 Oct 2024 01:41:26 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (e.b.8.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681::8be]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-42f86a20589sm9932495e9.20.2024.10.04.01.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 01:41:26 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Matthias Brugger <mbrugger@suse.com>,
	u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] board: rpi: Pass CMA through from firmware DT
Date: Fri,  4 Oct 2024 09:41:20 +0100
Message-ID: <20241004084124.416695-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.46.2
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

For a lot of usecases, such as display, camera, media
the Raspberry Pi needs a lot more CMA than distros
configure as default so we should pass this parameter
through so things work as expected. Fix a spelling
mistake while we're at it.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 board/raspberrypi/rpi/rpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index ab5ea85cf9f..d4dbd96bc96 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -540,7 +540,7 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
 	if (fdt == fw_fdt)
 		return;
 
-	/* The firmware provides a more precie model; so copy that */
+	/* The firmware provides a more precise model; so copy that */
 	copy_property(fdt, fw_fdt, "/", "model");
 
 	/* memory reserve as suggested by the firmware */
@@ -561,6 +561,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
 
 	/* address of the PHY device as provided by the firmware  */
 	copy_property(fdt, fw_fdt, "ethernet0/mdio@e14/ethernet-phy@1", "reg");
+
+	/* copy the CMA memory setting from the firmware DT to linux */
+	copy_property(fdt, fw_fdt, "cma", "size");
 }
 
 int ft_board_setup(void *blob, struct bd_info *bd)
-- 
2.46.2

