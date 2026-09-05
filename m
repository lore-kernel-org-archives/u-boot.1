Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67379C624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30B1C81184;
	Sat,  5 Sep 2026 09:15:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T3M8t0tr6iOp; Sat,  5 Sep 2026 09:14:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DF204810F1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599699;
	b=AIxTqUe5gJdtHbsAz848QEfqDG2bzYpD+za6H2suJVyAGub0RKxg23w5+zdGJI+5QmVB
	 NwuEy418mciA8NEfaVKO+jxf6nsUe/3HX1OQwAXgrtwPOJsoMuOdiit8vUzo79/fDL9jF
	 M42s5ybzEA1mPl68rzx3E1IypUcD0MQoLLvJ9apRIHeevmThlSfr5RB4d76q93AMa6SJ3
	 C0chNkGoO4BOK6jjq/bAlomopHgWs7RvAcF7CXLizkszWNNppJvYro2ThPvXMRA4pR35R
	 naEDFbSSgIMJBvJ/eORudeQCTwUbBvcQl9xOwa5E0aFluexHHA/zVbw24zuZBDk6DtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1pvBEDdciSg6TiqtaJq0E+tzPWj6bO+yEQ9qdahn0w8=;
	b=Iiwji3cwHc1EmsCEcYYMs6fdlKZdAeGzHAdSdGnvWE/gcL9JlxcN4WXCjzfxSdG+N1+x
	 w7J/+za0SyDxIz4GUZudnS3ihoVm9uP4MLoroNQxGFOXLW0J2m9GEbJbnd2slloSCHaVd
	 RpDbzKM57kVARmSFEwd2A49beqOq2n8RZwLfH/wnlK8DJz3ocBBzK3GvFRCgie9u55H9A
	 Js4PuPTrMxIraqZWoKwvgdo4jhs8s3MeqbzhOQ2dH61wI1/DHZjfNU6bONB08eVsQpLob
	 9X01bgyF4RZblrvBXUkueI8ZwgQPvRwqI4rukShgIvTi7c1BeaJlEcaJ5lVR+IoBr3g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599699;
	bh=1pvBEDdciSg6TiqtaJq0E+tzPWj6bO+yEQ9qdahn0w8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cTdtuUnw/K45eUKmXZ/W8QbTt/ueuN0YFByZqjqSg0iEWzUHmZ5eDBD+rSSjaYF7L
	 gqN5pedrKP4XdbsnNi1V0R2RwMGxn2uMxzoqLyuU5/KgEJDf+clDLKr8q329tGsAva
	 ohDIi8LyWxLP3dzGuQIcnRp28x1ow89WqxMFcJaevaM2f2fNR5XGeS22a16R/1cmlQ
	 2Dzi9AaTzHqKs97mHRW9SchmZIqIvBHTpqQ37hib8vd4wH9uQjut1n2ZjdzPj/j9RG
	 xQFF3CoPxgUOnL52JBG7Q2jKgXml2rDb88NOJb78dpLcQBacqnAI1Ho7i1eb1uE5ER
	 z2K2TWSIuDZmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF204810F1;
	Sat,  5 Sep 2026 09:14:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BC802FC
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F19B340051
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-0Zz68lM_2J for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:14:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EC82140024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599696;
 b=iiJmdCRyR0qYYG4Ri5S2kRcNceOesPrA2mCJRo1JaFfzJCYRjsOdpWi6n2vLRM6p3Vw1
 vvRjCSn+JkOEhMDKiSmhLoE0RAPswI7GagFgtG6OMTAksImN5PMths4ENzWU7sezj5Ie4
 1psZ+qzINzHrHbDSFA2VJBlzcWDQXXycFR24n8mxyAprmNt2MkDvA0E77gAq5TVp7IGHT
 ZXkvMfOYNjH39b3YIJtDXXJjtNl7FaB10h6m+YItleYQZENek45VmCb+U91fMUHnmXCFX
 CsANNYcSr8I4IoRbnZWMn5RUIOYV6nrWY35ZtcnMo2oYCT82NjgwL9SCPjh1fvyUI3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599696;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=1pvBEDdciSg6TiqtaJq0E+tzPWj6bO+yEQ9qdahn0w8=;
 b=O1yWBUzYSSgLosAzk2VGmA90hEBHjiWkQ6n4DB61xJB0CtPkqmwSjS+uqg4zYuHII5ua
 QAwbuhWUyO8QQeMe0BJmSwnKJ1XfqOObHqOdv2qiPrwgQkDbZjouuIAWI7mI6gO5G+ovc
 hG9o+5+dLBVCY7F8Wks3MJexhq1W1iPIYKkLZWzkIjg9Ar46kg+5DIaiJF7tcXeA2Co1R
 WMVATKXEXFspAyN2vkuhqyFIoUSYW1npcgzJp3nRKrEWnDBvS22u2/xa6ZIKfAlijafwH
 iGy3qsf9e+shrRYiOGPPzd/gW6xn4JQoj7VWVPSnPoR6WJMavEa1rMSLacJxSJ3OqQw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=dJMkfb0A; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=dJMkfb0A
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC82140024
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:55 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso2279248a91.2
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599695; x=1789204495;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1pvBEDdciSg6TiqtaJq0E+tzPWj6bO+yEQ9qdahn0w8=;
 b=dJMkfb0AlZlgfYpUuluLX3tQYkGZ6Ei7zgcQCt5ZxwmoRVkFqyMoJi8sbHh4R0qV6C
 hjki+R3aqMgauzGTi7S3qjEbBBOlGZk1AX+T4YyShWLi2oUeVOZg4PQ3X81H6IswUR14
 6j27br2Nx8uN+aH2GKjbN9UG7JGBZtrL3jcrOv7xkzGX/xBz3tpRpvsxYljzVeC63GA9
 r6A3WTLfh9ILBd+uCSs8jDLS1RCSn2JZP4qKZ5x/rT7or8Po34iItWoSTb4n1fiv94Hn
 zUz3MwQW3DpoyxAlgnblMF0CJ7kKogCiU2KqIAYTU7OctawgzM0ZOW3eAGFttaY9AJQZ
 A5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599695; x=1789204495;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1pvBEDdciSg6TiqtaJq0E+tzPWj6bO+yEQ9qdahn0w8=;
 b=c5eiD/EyH32n96UXheyof06WzBhoInvooLyWqIzVRedMrzyU4oLhREXlWLc6taQsh6
 rvPQf3zA1ETGEGtKCr6w8CK2+g/S4aRnpIYttO5PU4DSUqg5ani2PL2C3tXLJl6JMxoL
 KZTOA+oz2gUwvH/e0FWSKJa1cuv1iHN2xp4exeU4qAyCeHe3dtNoVjeXxru8So75h9FF
 dojiJvWARrb7nGmdwxhlZktm8wCW0iEzaDwguMvsFejy4e6pfH0XBdRx6NDQweWYajLX
 qcxFbs64uYq+StdRST4+9gcIIEJBq8h5NQffihFuqLj6TJI2gSqFRHvm6OkPpKFH9y14
 J8UA==
X-Forwarded-Encrypted: i=1;
 AKwUvBybXiyxPiPspg80U/fV8UqSzrZmXxzFBJwsBqgClkZ9vn2GxKGwVtbtjYdzePhaVOkFoHqgMwU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kbFyJU2PxLW1h7Ng2lnMHTNd0b6fwMY88qbNRrUZNmuyoPcHf1
 r2kQ/Ph0FVsJZ6ibMUcZPAP0hX4uu4hzTHULySenez55Z+jracJ5CKkcxnZmAHQ0aOI=
X-Gm-Gg: AYBFou20pa3FJbmza+ngQi6vnRC1oK8nQJyFfAZjzbEm7rA59sEkh+UIUTkijLTi4Mx
 Ao09SzAG2igukqLCjjPGots3H5KLJN4F1zFz01pajtUTTwRcx5o7q3IhX2uIODMmQThFFH+kSXa
 X3qX5iJD8ByV0MH2xiRrC1EqestEn5wuyAiXQIlA9HuL/tLWfoh2aTaEqdt7XeWLfwRn03Ud/GS
 flk2PBQSRY+BRGS7ZYWwagtxfgUrHiY0FXHWzWRibIQnYFfUQRgK+4UKg8C6yTBISTD/GI280aB
 BDeOc36ygmCXPjQe9CrSZ5eUoRk49AzuuE5KvBHoRzxfh+/KQ44J+UUlDHTBTGXb4P3eTh6NnyH
 LYlKYKtV0nJ9zybR66Rg2LsDSSp1wwz3dIExBg3321mbFMdHK5KaQdk2JUKg3AEVe4TgpphT/eO
 r85SSgJ1P1mJgufgpBui9OnpDYcsW+2F+VXH8NU72WyXMXoggrM9U2xKvPH67rvHVB7nA6xjSTz
 OLRxGqocT5YGoA5kfmJygRtbunHdeo2hGl3pjkEcUFkIPIX+7/kg/I4hiis1SnGSA1AmMnR9lFg
 WRGSIrs3lhhB/OVV9uiU6omOT4dqr5bQL5Ix
X-Received: by 2002:a17:90a:64f:b0:39b:370e:c807 with SMTP id
 98e67ed59e1d1-39b370eca6fmr6583727a91.17.1788599694768; 
 Sat, 05 Sep 2026 02:14:54 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:14:54 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:25 +0800
Subject: [PATCH v11 12/17] riscv: dts: spacemit: k1-musepi-pro: add SD card
 support with UHS modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-12-235eacd94fe0@riscstar.com>
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
In-Reply-To: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Trevor Gamblin <tgamblin@baylibre.com>

Update the Muse Pi Pro devicetree with SD card support to match what
was done for the OrangePi RV2 in [1]. More precisely:

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with internal pull-up support
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes
- Add stable MMC device aliases (mmc0 = eMMC, mmc1 = SD card)

[1] https://lore.kernel.org/linux-riscv/20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com/T/#

Tested-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Signed-off-by: Andre Heider <a.heider@gmail.com>
Link: https://lore.kernel.org/linux-riscv/20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com/T/#
Link: https://patch.msgid.link/20260520130624.1763487-1-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 85e4c5733cd7efa39f10d7200095c016ce4a2815 ]

(cherry picked from commit 9f9e7116bf6057433905f05a6ea06dd17a4b41c4)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index 4aef287353ca..0d809e4ad3b1 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -19,6 +19,8 @@
 		serial0 = &uart0;
 		i2c2 = &i2c2;
 		i2c8 = &i2c8;
+		mmc0 = &emmc;
+		mmc1 = &sdhci0;
 	};
 
 	chosen {
@@ -218,7 +220,7 @@
 				regulator-always-on;
 			};
 
-			aldo1 {
+			aldo1: aldo1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -384,3 +386,21 @@
 		reset-gpios = <&gpio K1_GPIO(123) GPIO_ACTIVE_LOW>; /* HUB_RST */
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&buck4_3v3>;
+	vqmmc-supply = <&aldo1>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};

-- 
2.51.0

