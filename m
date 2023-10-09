Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1F4E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 14:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2834886DC8;
	Mon,  9 Oct 2023 16:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="Mu4DJEus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EAE886D80; Mon,  9 Oct 2023 16:42:13 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9276D8667A
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 16:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5031ccf004cso5487560e87.2
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1696862531; x=1697467331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sA6K9amLZoOgmhtrG1zU3JIgWFhGLhU54NSsbQ4n5ok=;
 b=Mu4DJEuspbykd5fhNkX6Z/h/XpAKW0J+IxfBozr9taIjJ5lxD098JyZUu0mVrf08wi
 lxkso4AKfW4dh4toLNmuoFMp5vBclgz386lvZQ4OJYDFaOOR+rIo/D3nWWylApWgMqCH
 mKUcVOu9OnylkcbhQCAi2Xt6PJcuyClOrBcu3YdMVdEhCWHYXbg1+MVOHFS5AgMFG6nC
 TbBdrROBHF4c7YmIGDJu5jrwQml8Z+DEcC8Ytnbbd4BNMxoozmyqLeiYY8VURPagR8RQ
 LTjRusvStmm/nKb5QDXwx3u8zWTmo0TSLBrrj53cHQNKs0txxTESpHySros61R/xBzrq
 /aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862531; x=1697467331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sA6K9amLZoOgmhtrG1zU3JIgWFhGLhU54NSsbQ4n5ok=;
 b=t9BXKeb+EMcjJfVuxqYo4jwAKPZI5LAusCnA0aZnuCyn42GNRDHqIh0Ga53+V+l934
 PBzPxNc4axlhnw3OOpDS8Pwr+bXv58bfygtqnTf1UimC+QBADz8PfKVHqdXdzwti/x6W
 zKuV63fnNKtafO46/h2XrvxmRAyoN+DHlNia88QXJquwb4euePnWirE4m9Wr6CGx2leE
 gxLTIsy6DJm1NJXlvDBb0V6V8XXnDsmJMDIq069hdbUIRRgsiaT9GylAIomZKyDHeCti
 NdAZ/ktUjCWdMpoaamLvVJbP0wEwuU0DxhzzLzAhdf3+PcMsyBeBaQGDO3wMubE7ZBF+
 8dlA==
X-Gm-Message-State: AOJu0YzfwPSSIH62rmdZAqg42t/SXRqzWEecu1qbNXxBR3gh4qMEgqIJ
 tAc8pmAe2BoOojP1YtEEvRUv6Q==
X-Google-Smtp-Source: AGHT+IGEF9/9yQ5EYGREAnk1/gjKSCMxTthvKdARoeS5c7AVZtbIlXOb+RObCy2jMn9GHamyPo+SPQ==
X-Received: by 2002:a19:ca07:0:b0:503:108:8602 with SMTP id
 a7-20020a19ca07000000b0050301088602mr11693551lfg.9.1696862530879; 
 Mon, 09 Oct 2023 07:42:10 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 f19-20020ac25333000000b005045bb669d7sm1464733lfh.62.2023.10.09.07.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 07:42:10 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Simon Glass <sjg@chromium.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jakub Klama <jakub@conclusive.pl>, Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v4 3/4] arm: dts: at91: sama5: Add flexcom4 node
Date: Mon,  9 Oct 2023 16:41:50 +0200
Message-ID: <20231009144151.773721-4-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009144151.773721-1-artur@conclusive.pl>
References: <20231009144151.773721-1-artur@conclusive.pl>
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

Set up flexcom4 for Microchip SAMA5D27 SoC and prepare it for usage in
I2C mode.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
---
v3-v4: no change

v2: new patch

 arch/arm/dts/sama5d2.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/sama5d2.dtsi b/arch/arm/dts/sama5d2.dtsi
index dd6468ed96aa..819564fdd5bb 100644
--- a/arch/arm/dts/sama5d2.dtsi
+++ b/arch/arm/dts/sama5d2.dtsi
@@ -781,6 +781,26 @@
 				status = "disabled";
 			};
 
+			flx4: flexcom@fc018000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xfc018000 0x200>;
+				clocks = <&flx4_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xfc018000 0x800>;
+				status = "disabled";
+
+				i2c6: i2c@600 {
+					compatible = "atmel,sama5d2-i2c";
+					reg = <0x600 0x200>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&flx4_clk>;
+					clock-names = "i2c6_clk";
+					status = "disabled";
+				};
+			};
+
 			aic: interrupt-controller@fc020000 {
 				#interrupt-cells = <3>;
 				compatible = "atmel,sama5d2-aic";
-- 
2.42.0

