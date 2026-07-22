Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F9EC4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 19:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 493CE80FFE;
	Wed, 22 Jul 2026 19:47:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P4Hskz61VIZR; Wed, 22 Jul 2026 19:46:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2019980FF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784749619;
	bh=GGMEsMq/rRo3/FfGFRE5K6y0vWIdMsFwjU6qouHX2DE=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oQ/Dx0GTyn+rSNH2LhDG4R4V6DZ12AL6ijxCzrQjN1eLJfQOw3gIEHD9fWrnvXo6D
	 I1X+e46rytAovuTHaTGZZFWq5gGkMa5faNziVChwz8MGzSZgEVMgDcEV1SgKqyke39
	 37VhW/x6+Q5T33p310V90Trba4JUCHSmBGEQR68An4vc+iFfl4VKZCQFzmxn6yGqWp
	 0CZYMBVaPjA/HN1tQYRevFdmdaeVB/gbRRrI11q6BKICU+b8tnDJSzm8v9pswZsh2P
	 6OobR1J47gxUc+sBy3r9SeWSO1KFozUq+H1ZuEfBHj+H2Z+NJb41KyPFRCsj4+JeLR
	 7xGzc27W0gQEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2019980FF9;
	Wed, 22 Jul 2026 19:46:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9529E2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 873CF40A86
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:46:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wB7RQMWTmisl for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 19:46:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E5DEF40A84
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5DEF40A84
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5DEF40A84
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:46:56 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so10687337a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784749616; x=1785354416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GGMEsMq/rRo3/FfGFRE5K6y0vWIdMsFwjU6qouHX2DE=;
 b=iM5dV/Eb2mcXwt1v/0nTlB0VGR3WWhMFk1W8fRFrGD8qwdKiM8OAuCe5be1ZW7dH3W
 +jj75QWvbYTvKpyRJFeD7hkTI3NnXhdvVJo7KUKDjZh0UwRpeEazmrgMnOaQA9pxSuLJ
 zZJ7OK4B1g2g2BG2KmC0Vr/0ab0v04G99OhiAetquur0ssW2waV4XtkIGgvRiZdTKPD3
 ylh08WZ59orKi1fNVevNaTqwd0r+Zb3MaQ10TJi3bh/ynOX5KMHoECWgh7dYtc0xDPKC
 CLjWfZigA1HpoFuU0WIsOnCrSEGJZ3PaRuBNzSrDS4iMtWINoVSHsGT9j8VpttbLLaPZ
 f0sA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpp0ijC2ZVI4oKw9rxb3oRy6dIpQQnja4BisfvL8PKRCsK8lSqNZ0jEl1+sHuPVFghkbnFpBzY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxDMByeFX+Bt6jz0PRJH9AX8G+VE5nfvDWQSJvjymMjiKBm1pT8
 Te3sKEt/ZPgDot993BZYdqeY3pG09o1h0nnLLec7T1PtwHKKK/7oEGjw
X-Gm-Gg: AR+sD11nzfczChVGXpuQzgzqSG+If3SeZgP/LjuK2wqWvG+FLK3RNd/48izCFUFZWOR
 EuGqSr4JeAN6wkC1ONw7j6OnLx2SRXsFGrx0gQ+hgsUPVgae50nYHXjGOa7Ur0gJ3HKbXOVLXij
 7u+EgPrwrKrV9h+a7aAZ9epPRHHfm9P+aeps8Ol6BGa5aVo/ueuj6vIFGyHybjsj7yxvaPEcP43
 Ms0DspNGnMCA1uyEipGyHgLb3xfFyoD1XOlNd/L8MW6Owii6iThN8F0pB7jqO+umvnqSZFx2O13
 aig7XuMq/U9SAlk32h/RHJ0wXr8zs0AfAtJuq88BUDw9arM0/1PF16Z3Uxm2/HU+NfdEaYjdNAb
 xNFljsh5Nov/SYdxZcLAdX3beeR8Y+9wTZD6EhF2ZV30Et030S42jJB+XFWnbSLk6/JMD8YmkHW
 bAoheTywj22heq9KUn62V+l6bCSf49kYpWapfuoHGku92QAqc=
X-Received: by 2002:a17:90b:2b47:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-38ec6453e68mr112425a91.2.1784749615878; 
 Wed, 22 Jul 2026 12:46:55 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a801:a24:3a9b:51ad:2c34:1075])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130f42bbsm9287280c88.14.2026.07.22.12.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 12:46:55 -0700 (PDT)
To: u-boot@0leil.net
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 2/4] rockchip: rk3399: Remove ROC-PC regulator overrides
Date: Wed, 22 Jul 2026 16:46:36 -0300
Message-ID: <20260722194638.1285159-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722194638.1285159-1-festevam@gmail.com>
References: <20260722194638.1285159-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784749616; x=1785354416;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GGMEsMq/rRo3/FfGFRE5K6y0vWIdMsFwjU6qouHX2DE=;
 b=FA+GHo2E4VFleC+sc++EzEK7vgQw/Zbtj6Ds5Jtrjy01jWIjCuxFyjUsch0y+Vme56
 sdPRsWw6/V4CvALZ95wR7KI7yGLiEqYU17VpbqHmfo4Dze8Jl45PKEoMeU5tAqP7j1wz
 QVY59N4HFwDPfTo74c4ruThbRVHASgElVfsGnU8wAvZkBQuGH8pc8Q44NFeNhV7VpPTG
 hGcg4GgtTgnmjR850DovtMhO/gYmT0nyeJJQc+A1bOmf82AZLp78yJjtqpztYfLU1xnV
 ETI6EtPOevZcLskKeV1aowORFlN8BTQnEguvJYbjR6+MDg3BAfbp1Gfmr4Jomx7fAbof
 5MSg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=FA+GHo2E
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Fabio Estevam via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Fabio Estevam <festevam@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

The upstream devicetree already describes dc_12v as the output of the
MP8859 regulator and drives the USB hub reset through the vcc5v0_host
regulator pinctrl state.

Remove the legacy fixed-regulator overrides and rely on the upstream
regulator descriptions.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes since v3:
- None. Only added Quentin's Reviewed-by tag.

 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
index 883d399a06a3..a85e9549c83e 100644
--- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
@@ -10,30 +10,6 @@
 	config {
 		sysreset-gpio = <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
 	};
-
-	vcc_hub_en: vcc_hub_en-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio2 RK_PA4 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&hub_rst>;
-		regulator-name = "vcc_hub_en";
-		regulator-always-on;
-	};
-};
-
-/*
- * should be placed inside mp8859, but not until mp8859 has
- * its own dt-binding.
- */
-&dc_12v {
-	compatible = "regulator-fixed";
-	regulator-name = "dc_12v";
-	regulator-always-on;
-	regulator-boot-on;
-	regulator-min-microvolt = <12000000>;
-	regulator-max-microvolt = <12000000>;
-	vin-supply = <&vcc_vbus_typec0>;
 };
 
 &gpio4 {
-- 
2.43.0

