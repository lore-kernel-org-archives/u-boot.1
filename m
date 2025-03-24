Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E7AC36008
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B845A80F70;
	Mon, 24 Mar 2025 19:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qa3qSR6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B7781B42; Mon, 24 Mar 2025 19:00:57 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D32F80F70
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso33117275e9.1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1742839253; x=1743444053;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UI4vo8J00xZLzvVavnwZoS3tsdfhwA4zMsaYhvBtlK0=;
 b=qa3qSR6XCb3jfPKESpmY/f3/BHXVF6mk4HWYjvdlihafzxpPZ8VvI8yI7wnn9SZyGI
 g5UvCefoYOujpwTYuyiR12iKb2prq/lAdUMOc9KLo7Axsxpxnomj34bekpT2aOyDGNXs
 mqDLExBY5ZE/Jh+ok4KOM1h59ylxMWYzPpoyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742839253; x=1743444053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UI4vo8J00xZLzvVavnwZoS3tsdfhwA4zMsaYhvBtlK0=;
 b=K3AzcTbYMp33aN43Xs8Dxdd2lmOnMrObtSIh0KfUrdHLbiq4KIEIQZ35Ut597lZN5r
 J7ZO18Rb8WiPfBBpKyaGSKnjMebGHjAmQVB/kvOrWos6ziuHvjAbnup+U+ID7oeSrTDG
 sY7JRw4xJUyarI+D5ewLgYPo24l+jHHWWOtaSecmggmXsfgv3RO78yp8/fxLIZv96gZ2
 NhqgDke2N/MB7TLe5i1+ER2xuqUxjm0nPI5T5mbIf899HzEVqtaqm3d7UPEjsz5pN7hk
 WUU2hMVQqq9hWqEbuiMoUBQjxtU2lhsBmEH9j6HnD+SDOwngFBLYnVZFs8jXGc/u6Bn4
 e/hw==
X-Gm-Message-State: AOJu0Yw3UcYpqVq2+BF/dL7pLWEa334u2bEmx1UlWWEE4ukALDImcI6n
 rGUo9lXgtAu44NoxiIDTRdBmsyvzsLFt88TMZj3aSsyuBVrn8D9GT2d8RnlT+3ET+Tumb3VuM/3
 Y
X-Gm-Gg: ASbGnct5WXVwoQOmVFj5zt67qMvZpij4qLsSQpwV19OKefgq2RqjQ9bbWjZ/4RTcJqL
 TICF46ag5fziw7A9NROvFEx8dKMdrT4AazCTDQ3EoRchdammjewmE8VIpTPMoRlNYcZniF26OLh
 ZgAkWfz6LkTMHtEP57M7/uGStA2fXq0CqeszBYBejr0FwfWLU/K9UoErZck8r1pHMZFtgKg0P6K
 lSsJg+qPYn/esnkVC3//0KuRJZDq/CP6PMzI8q2eab/wnEkUf6yZl8+0+6DnbxxlS+afbnsbpVu
 LIW8KQpy138vBsdFfHGvpk/xHcUfAWMh1Z2hsqtTdCwSt239EV5WBq/TUL65CzAZkKxXZgjt5bq
 xsvEuB39VKjnW7ypxx4thjxuX54/qkrA6BGE=
X-Google-Smtp-Source: AGHT+IHTDAyMLIVPRQ6HaASxNC+PvQV4Gz5ujsztBt6JzwvIEusAdmBZtB+8GdVBXs/h9+RTcY4BMw==
X-Received: by 2002:a05:600c:3110:b0:43a:b8eb:9e5f with SMTP id
 5b1f17b1804b1-43d509e38e3mr125490415e9.3.1742839253415; 
 Mon, 24 Mar 2025 11:00:53 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.41.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f556a4sm178289285e9.22.2025.03.24.11.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:00:53 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/6] ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on
 stm32f769-disco
Date: Mon, 24 Mar 2025 19:00:26 +0100
Message-ID: <20250324180047.1571378-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
References: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
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

[backport from Linux commit f1317928fa03203929665af61e6d9ac0e29ea84d]

In the schematics of document UM2033, the power supply for the micro SD
card is the same 3v3 voltage that is used to power other devices on the
board. By generalizing the name of the voltage regulator, it can be
referenced by other nodes in the device tree without creating
misunderstandings.

This patch is preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/dts/stm32f769-disco.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/stm32f769-disco.dts b/arch/arm/dts/stm32f769-disco.dts
index ad1b442055e1..b4e240a8e3eb 100644
--- a/arch/arm/dts/stm32f769-disco.dts
+++ b/arch/arm/dts/stm32f769-disco.dts
@@ -56,9 +56,9 @@
 		clock-names = "main_clk";
 	};
 
-	mmc_vcard: mmc_vcard {
+	vcc_3v3: vcc-3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "mmc_vcard";
+		regulator-name = "vcc_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
@@ -96,7 +96,7 @@
 
 &sdio2 {
 	status = "okay";
-	vmmc-supply = <&mmc_vcard>;
+	vmmc-supply = <&vcc_3v3>;
 	cd-gpios = <&gpioi 15 GPIO_ACTIVE_LOW>;
 	broken-cd;
 	pinctrl-names = "default", "opendrain";
-- 
2.43.0

