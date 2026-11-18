Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331EC606A325
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tlQo3+us;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XVS9enOo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E5E340634;
	Wed, 18 Nov 2026 20:30:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gk231WWJaNUj; Wed, 18 Nov 2026 20:30:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 551E8406A5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795033823;
	b=NOcpmS1HnsOcn4BljuNFgyEeynlFbVxn0ihj9xATHfwbHO6QUjdeDjteeIg650G0Eu41
	 4ITiiUrD1HPZHaymhC1vivsQZUgr17z2bcPKrXQmFDWB0Z6KI5kKqaGwPCpDQqPG6Aduo
	 RTiVrpfYIHStGxh45SpGvJpgITkOyAJH1t7PLiNMt7rOS3shvtxsRj9fRTMZ6bjA/6Qte
	 PGOKk437+cR9RKRyx03t3QajkrINeiYJuNwXDg7Mwl1Nyb+NHHXCzPrEDsoDLwfIqSoRb
	 zp8ZZJIJrH/fm5IoWC1KNdllj64zHDdj5HP5KO97lPhHi8ptc8MJJgOOn7nEn+InLgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795033823;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CxPEKvleaFWDDHI16dE3s+g1ChOG42Uu3Xq85Cs59K8=;
	b=b8vjHXHUqjI66arG7yeGXTWKplZIa1OR+yeoRogBAUJ4f5jLl61c/7XnKDP8WFgTS3mP
	 660fvMLD/66Kg3J2ReOBo/8qRV+PgxyPbtr0N6179lts8XEQ+tVrhD6O0oaunls9zHHal
	 WLXWimiTPisEje7kqWHMdI07/txrXdEeJUcR3SHswP/LnmdOAO+2fadxCpi20M0DI6tln
	 QfejWNzeZO1M8PRUfKQDOq67IoBaMhUdKPgAL2+pyPof5b3nU9EKMSRnVgblXXAIsALcL
	 J9mJ2Vgda9uanduQmFRYYTF7n+/GuR1pkqfrOCpSvX9gDZ1BYOBx4IMLvKQ3M7cZp6Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XVS9enOo;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795033823;
	bh=CxPEKvleaFWDDHI16dE3s+g1ChOG42Uu3Xq85Cs59K8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tlQo3+usZas+lMtRIeq7yJgzcekBb6qkLzS17poREZJooqMpkBbFVxQZ0ShpGQEGp
	 GeDGKKxZDVbUs/Lsni6tMP/ybaCjln3fi/Py3z/jsSFQJzaT45aGJO9coUT61d41rM
	 Uah3xsIT5tG1qkTxwXdMGI6upIX2PG9zwpC0fvoBik6uTK+kxCCBW9kks21Hs6ZWRn
	 bDPiJSsbqCCHYN7p8CB+/pulCqqadFXJcrMFzZt3IZE4PE2Q7OTiq/qaKQijUV8vdj
	 oaSzBgN+380eTJttZMaHwXImSdoCgargUMM6W89MNQqU9OcM9ISEI78qTx47XPC/wo
	 jQbxVRe4clXkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 551E8406A5;
	Wed, 18 Nov 2026 20:30:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60F1C49B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46B5E409B2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IjvWVHPD-FWH for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 20:30:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 530B8409AF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XVS9enOo
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 530B8409AF
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:17 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so12385365e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795033816; x=1795638616;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CxPEKvleaFWDDHI16dE3s+g1ChOG42Uu3Xq85Cs59K8=;
 b=XVS9enOo849ODCoA9Obhj0cyqhQ8LCBqLH/n9YXPXQ5p82sSV1hOiNMacVJzkBXo6t
 FDhIo7jhfM7OyApbwfQ7ukih34U3P4KJ1SVZNWrv+YboPxeb/nqs0SxUlkZgu+pLNh+9
 Zyt9sEqrFhVmswzdTJXRLi/WawpdlKh18CELDr6hcme5v9MR5LUZAzvjl4HKY4vzfPlr
 J7b7KcbXKIv89AjdswDOB3ZT25LampxV6+pviu5Zvmx2nX90jXaeE53BnZaYRKz3zJ//
 4aOyTYiO2MefL/1doE5+VnyJzGq/RoWzEI1pSo/wEoBn0tcNt9VHyBEiSGKJwvmo+9w6
 5XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795033816; x=1795638616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CxPEKvleaFWDDHI16dE3s+g1ChOG42Uu3Xq85Cs59K8=;
 b=jgEIjRFhIg7q55yDEr828MMzSTHHwl+4Zg9dHj5o0RpKpCmmCBrySyaRhQ8kxKMEQl
 DQrD+n72b2plz6f733+47hyjNekeiNn2+rQtJIrE3xKxspLLnOGRVrRoHyvlDA/0jFX8
 7Aa74WOscbVp5VAF41aiW4Yx7bYAi0vsZ5T0JcJvbrwAP+UCawcFnkMT4k3awc09cZrV
 /qTN3v+C1cYDiMRtIsMDNSLRDIklcKrDMP+pxVrS567/8GaqOCkxjdO7yc9jbOIgOcKb
 cta0PAEqs1DL7wPl3nzQsoJpLxcFy0nSRc+dcpjqO2Yv+I5CwvrhZyJakzqRIrQfV/iR
 2xUg==
X-Forwarded-Encrypted: i=1;
 AL+hErHRzeepLg/iTQqxW5WApo6AbPFlUG3g2p7HpjtFwTGsuVDJDNCLJrnwBLUJmCTFii3GhfyfE3c=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z84+xXg5+O4xM8L6uVOuIJEWzrtE5MWBEZocXBS0/450FyXKTi/
 5l6tKd9kGjmMcxcbVOnqu1SK/fZwn65e5aO5GrwjJEW0A6FCw3GM865O3h97XIgCo8o=
X-Gm-Gg: AYBFou0uCRM4941oLdmEpKhdvzPEfgjWo8YxSXo9dHrauJ3HT50Ez0zi0BmESa1npJL
 ROnvxNuhPP/GR4rOgfaF0as0mGwjdz2wLfRA2cY13hzlf67CTJSSTIZ4Y4Z2CzTiRnOPqA7feKq
 trMAIwZ93eEDB6/rOKQuv/pVQMJoh7jwGafXd41cTduEw+IUjJtY+SiqyDw8NTE6zymXKo63RdY
 y1FLEv7E4QwpakAWtNJYGMpjCaPHf2OU+tjULPS3uLDGMJH+E4OMRt9Rl+ObAkXKy57Y8HfhYfV
 FWoUQSmcGEcY8vH9PmNyjbG0HurRBa8fipIFmynmE++ITCnU/0JjWN91ff7OK5aYW+BKn9TodAU
 Z7WSev+Q60TR2VGCPmqCwkGBoVsLa8R9YPBIWpbjtXRmqh5Y41Z9WXwPMreevI2b8Qb/A94J4B9
 i/b9CV0wC6HjRPzzssJu34Q5UOjL71B2A5ejITksj/7Us75Y52kJQ7+1BDHvRnPdELIW6xN5pWS
 tG0FHBYkco97eP2cjBJK7DiZt4WbtmL7m4xHD/BJMIharRL4fMBFP+HIYQttIbNOYTHcvHr2QdB
 +zwJbTl5Gf32Sc9PvEEBpH56FA9HVY3xxYONTkRmgjCRFg7ePNqXWqQuKyif91X+1AMTUVZ+2Dn
 vbSQbuiRoBqWY8OOLng==
X-Received: by 2002:a05:600c:4e0d:b0:4a2:47:b79c with SMTP id
 5b1f17b1804b1-4bb7da48c41mr73857385e9.32.1795033816126; 
 Wed, 18 Nov 2026 12:30:16 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8326c332sm13066705e9.15.2026.11.18.12.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:30:15 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 18 Nov 2026 21:29:53 +0100
Subject: [PATCH 7/7] arm: mediatek: enable I2C4 and I2C5 on the Genio 520
 and 720 EVKs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-ccaione-upstream-mtk-g720-i2c-v1-7-916dd6cc8d1a@baylibre.com>
References: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
In-Reply-To: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>, 
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Both EVKs have an MT6375 on I2C4 and an RT1715 on I2C5. Enable the
two buses in their shared board devicetree and the U-Boot i2c command
in their common configuration.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8371-genio-common.dtsi | 32 ++++++++++++++++++++++++++++++++
 configs/mt8189.config                 |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-genio-common.dtsi
index 5b06690620..9190a37707 100644
--- a/arch/arm/dts/mt8371-genio-common.dtsi
+++ b/arch/arm/dts/mt8371-genio-common.dtsi
@@ -12,6 +12,8 @@
 
 / {
 	aliases {
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
 		serial0 = &uart0;
 	};
 
@@ -351,7 +353,37 @@
 	};
 };
 
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
 &pio {
+	i2c4_pins: i2c4-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO59__FUNC_SCL4>,
+				 <PINMUX_GPIO60__FUNC_SDA4>;
+			bias-pull-up;
+		};
+	};
+
+	i2c5_pins: i2c5-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO61__FUNC_SCL5>,
+				 <PINMUX_GPIO62__FUNC_SDA5>;
+			bias-pull-up;
+		};
+	};
+
 	disp_pwm0_pins: disp-pwm0-pins {
 		pins {
 			pinmux = <PINMUX_GPIO29__FUNC_DISP_PWM0>;
diff --git a/configs/mt8189.config b/configs/mt8189.config
index 52d9cfbc4c..2285bc499d 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -17,6 +17,7 @@ CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_PASSAGE_MANDATORY=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_UFS=y
@@ -24,6 +25,8 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CLK=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MTK=y
 # CONFIG_MMC_QUIRKS is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_MTK=y

-- 
2.56.1

