Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363B4C88E64
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 23:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F159080D3F;
	Sun, 13 Sep 2026 23:20:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eLh4ptwYHzBQ; Sun, 13 Sep 2026 23:20:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B906D80CD9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789341607;
	b=BLtqehgrleQwFP3D/RwVklFxoQ/CZ76fOB9aJ3LsexOxBtJUYi/MtQHgXHpJGDIKRrPQ
	 8NEqhdvQfs7TvJSAZ898cTDKZ+yQsLQFz58OfDUvOLu3Uo5F9RcrScMWmapc8/ilyT+8M
	 HHdtgbwtwhRHwDU2ZTkkPRweuw3phS8KMp0BMh5MLESwxnVaheDGtWSFai7kEYpjThlgN
	 FKCeiqPlmmsF+Rcs/4UgsnZj0Y33yDzGY5i14hy7hFBEXHzov8IyJUXvECr5ZWYifNRCQ
	 AvGLr/spOVz9hsOoKRwkBWu/qwKI6fKL4tdGSpVSv3dgDOiSpc1jKV05p6hZb1b0vKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789341607;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EaiOdRwxZKE8ubvc214/5wzd08jAVX9fev9UNmmYEX4=;
	b=IoE+7AtOI0ceiztFky/RPVYD4qNsdpZoTe5kPYgbQXEZ7eCE5urW+MKVXPk6DX7VeNrW
	 iHRE9Arfq27twTBoIiVbKsFqVf3dRIiHO6RIPtEx8VRf96F8Zmd798icG7M46sqDNS00x
	 1QofjxjtIOV8FT9s0SPLsoLeKrQz3t2A3Q/ZrwkOqn3Fg0rNpt0cfVfA+FxjEmldiTujU
	 4iLOkxIp8Jl9xtJ7icsvzRrKhzI8AQmJqX0/yEh/huI1ampq/gfG24lAsjGGefK4EihAV
	 Dd64ADHPo5u9Ij5Q7D0Pvb3l6sJ3AU/VxG2mp1ERX+UwMVMJdobYbzotIP+k3mgKrjA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789341607;
	bh=EaiOdRwxZKE8ubvc214/5wzd08jAVX9fev9UNmmYEX4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=z9yzcejUqiF/nIAKvV8qmedazaH/8aq63jpZ6pd5alpGMVqWlJGzSvY/zSdQeTwJl
	 je+nMBuF0Ck6myeoFPHksZd1bfcfA0d5Bxe7X1Rt5208qO0qtqcG0s31sdItePBdDE
	 lzjZbOsUw6IewvjVAj9DCuM/KprM3ciJwb+bVkAXVBgUc0Cvcoh1h2Ry6d7LMVVsEx
	 oYJWrIfDKMC220CmTZENElXVEtt/5Z5SGEdhPKZZHU9YeDxCGLUZg8szmIKLIWPSP2
	 5qLCKge+S9sq1anMvAxnsqrJ5kUWsi5mNaDT0vnVe5gE7P2sTZUpnjOlz6n+GDJKis
	 /btfg8rJGgCig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B906D80CD9;
	Sun, 13 Sep 2026 23:20:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6172F224
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 52F26605F9
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:52:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fsoat94F13rQ for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 15:52:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 50541605CE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789314746;
 b=XmyWAGA0udjke9AINmj2teDOJ5C/iSHMjWoWYB81uWOXf/mxIHivcEae5Ex8sle+6s6H
 aDPkmoB8Cdnbwq8pyo0xJxA/glWIP9AbLFFJvUbryZ4VnxXFvLB8mQkVcl02qkZx71n4i
 Dm8TjT35wjzWH0PDJp6se/VwoGxMEzUrpgMYhMUXxb70dbrNCz0PLCVjhvBwMVI+YkPxL
 KjK11i4q87SANK/AMKF7CDzZfbOkHFwXDdLJKrFUNdWRFxmAOBVgQeZ0ObyzZ0rj8qGTP
 mMN+4uihPcSxP2BMOy5ZZV/g6iJf7Me3KkewLwObLEzi6c8Sj+ULclHSZTU5dPICS2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789314746;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=EaiOdRwxZKE8ubvc214/5wzd08jAVX9fev9UNmmYEX4=;
 b=Dpb9Vx00DCUCqJOnWBxCU/unMhACoML+QF6doutLFTpAUuNOqu1GGdZHlFCmj62gt++D
 KnH/n//5Fk5wrFiwFAgtOX8bdHnNlx01kRkrTaxXjpQ2Myq6xfLiG24Ikzz+gq4t/blZ0
 EjFBd6FLrw+u4BWHstoJijHZMvHNkctkPDFQolRSdbJwihxQN0pZ9aBNi7X/xj9B2ab0o
 M2hA17heElAjk2vfIdtdVpVsOS0q/UkWR59cpbDW/IChJQnTxVV78OwuqDbXTVcX2/voR
 MDCEUmU4iswH8hwzD0bYP+YeHlcUdLVh1it2vWZxSk1gcPTntCAF2lJtSqwp1UlPSaA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=US00Ejxv; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com;
 envelope-from=aford173@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=US00Ejxv
Received: from mail-qk2-x10.google.com (mail-qk2-x10.google.com
 [IPv6:2607:f8b0:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50541605CE
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:52:25 +0000 (UTC)
Received: by mail-qk2-x10.google.com with SMTP id
 af79cd13be357-93a0fd41a7bso93260985a.1
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789314744; x=1789919544;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EaiOdRwxZKE8ubvc214/5wzd08jAVX9fev9UNmmYEX4=;
 b=US00EjxvbggxUcJ19t/FBrjF+KJ6jTLiM8rhFDzH4trqtaiqou693zWMS/b2+nBfgu
 Cex3kGT0ctbaW4O1+uC3fcJmR5YhwoZPWxprNBCAS+3PfvB1k1YasrSS9pvHpWDjPS9z
 JOgZlcIk7GJs5C4e1b2vBnrqcFsLHioxgbgc913rNsDy7eIjLSHxwkYtM+bJvAaRmqAZ
 KrCbzIHSjFztRwc6gFi0bY1+m3IcAxaizLYjhP2N5+nqrShiamANxDHrOrLZOokP/7hz
 KlhnR4+GmA88XalhLh2wk0l+B+AOByOFPfbgF2CDZbK3C5YOUqiKjc3gld+nriJuuaJc
 k5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789314744; x=1789919544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EaiOdRwxZKE8ubvc214/5wzd08jAVX9fev9UNmmYEX4=;
 b=Kq9m30gd/T6E5yWsAMjJH6ImFmY1sg4iIpK4tJTF3uxhCW+Rl3EdqHTc4Tc2/5rGp/
 whNsjxO80TuN6Vtqa80cbioG5wSO82sNrk2K1KVrvyo4oZ9grJ+UxOFtgaOazqhSnDr+
 Xpv/bKBfH1zS1R6Q6agbMk74TUx8tY6JGQDDiTJCzWwmZBenaPx/6PxPhz6YAI0i65tT
 3fE+zdgX4BDx/98SnWRU/pqlfqLgBF2vwCZPvlv1yUK+RQlrxyB52WzjKj/WUa5TVBmz
 oQoSxLRV8h5gIXsRXLNFi30Y3e0JSNbpAy6RTDM78RysJCXEyM7sUcLh62ogSLlTBybi
 ZnWA==
X-Gm-Message-State: AFuF++kMmJejWgx6xYFLGPqy5/tpVur4+8l6EkbxN9N7Wt56G56I1+GX
 5d+ZD379nwNLDioP6uyp8Ihp009jw768QHVZ1li3siNj4pcJ32sruvVqR4K1wg==
X-Gm-Gg: AYBFou1kB+5Xc+XUrV+zCRquJToZ4Gz5+LbgPjL5VOKafvZH5DwXcgnK9U/7kGbSMkp
 G8aQNQGEtfY2KDgSxU4Bhufqg4oQ6ZVHfpSatIGqd3KK2vDsDEhJ08qbMTvaPQCJtX6HWbKeGg4
 sr5eOA9xPrQKhD4W5RuDquAbIwV+aZNchqUt+a8Mu9ZtkjP44T3WiYM273bSA+4cE/IaNp3x5eC
 aLXkhdRmXEsWhSYY5D0SWOGkiMtdkE33Xsj80LUQ3G7Tf8RIJpPAgBEWwB/QyppMilMbkggSqcr
 FBFvZYD286mQTfFlKQNrBXdbuh0e3eORmR1pgt2RFDIq1ByUuPxvE6XknRaQbnOjyGvWrBmqymJ
 zR4nDZ6WNj7mmUGkymFyCvctdUxvpm2NGmxWdZbNkjp9C68nCpGaYejT3tLROIEmJO/O3UmjSye
 ALLpE7ToqNnO3DJxRAKVJZOulYa2J2IxVXBuBlomuGLeQ1O4yka1WWnb3zu4M4Z4GQtmrSGmhJd
 jz3he6HhYS0nNIyTEAIxHN7LW7IwuXNKNwJIHABgUz0t169SkcX
X-Received: by 2002:a05:620a:618f:b0:939:6dbd:de57 with SMTP id
 af79cd13be357-93a03842c90mr1072332585a.32.1789314744107; 
 Sun, 13 Sep 2026 08:52:24 -0700 (PDT)
Received: from aford-System-Version.lan (c-73-94-212-116.hsd1.mn.comcast.net.
 [73.94.212.116]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939eeac7b87sm688215485a.0.2026.09.13.08.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 08:52:23 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adam Ford <aford173@gmail.com>
Subject: [PATCH] board: logicpd: Remove i.MX6 SOM support
Date: Sun, 13 Sep 2026 10:52:17 -0500
Message-ID: <20260913155217.84107-1-aford173@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 23:20:05 +0000
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

Remove the Logic PD i.MX6 SOM board support along with its defconfig,
config header, device tree files and Kconfig target.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/dts/Makefile                    |   1 -
 arch/arm/dts/imx6-logicpd-baseboard.dtsi | 561 -----------------------
 arch/arm/dts/imx6-logicpd-som.dtsi       | 369 ---------------
 arch/arm/dts/imx6q-logicpd-u-boot.dtsi   |  30 --
 arch/arm/dts/imx6q-logicpd.dts           | 130 ------
 arch/arm/mach-imx/mx6/Kconfig            |  15 -
 board/logicpd/imx6/Kconfig               |  12 -
 board/logicpd/imx6/MAINTAINERS           |  10 -
 board/logicpd/imx6/Makefile              |   9 -
 board/logicpd/imx6/README                |  82 ----
 board/logicpd/imx6/imx6logic.c           | 323 -------------
 configs/imx6q_logic_defconfig            | 118 -----
 include/configs/imx6_logic.h             | 121 -----
 13 files changed, 1781 deletions(-)
 delete mode 100644 arch/arm/dts/imx6-logicpd-baseboard.dtsi
 delete mode 100644 arch/arm/dts/imx6-logicpd-som.dtsi
 delete mode 100644 arch/arm/dts/imx6q-logicpd-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx6q-logicpd.dts
 delete mode 100644 board/logicpd/imx6/Kconfig
 delete mode 100644 board/logicpd/imx6/MAINTAINERS
 delete mode 100644 board/logicpd/imx6/Makefile
 delete mode 100644 board/logicpd/imx6/README
 delete mode 100644 board/logicpd/imx6/imx6logic.c
 delete mode 100644 configs/imx6q_logic_defconfig
 delete mode 100644 include/configs/imx6_logic.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index a02dad22f27..37d3b6fd3cc 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -761,7 +761,6 @@ dtb-y += \
 	imx6q-icore-mipi.dtb \
 	imx6q-icore-rqs.dtb \
 	imx6q-kp.dtb \
-	imx6q-logicpd.dtb \
 	imx6q-marsboard.dtb \
 	imx6q-mccmon6.dtb\
 	imx6q-nitrogen6x.dtb \
diff --git a/arch/arm/dts/imx6-logicpd-baseboard.dtsi b/arch/arm/dts/imx6-logicpd-baseboard.dtsi
deleted file mode 100644
index d9de9b4f0c5..00000000000
--- a/arch/arm/dts/imx6-logicpd-baseboard.dtsi
+++ /dev/null
@@ -1,561 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// Copyright (C) 2019 Logic PD, Inc.
-
-/ {
-	keyboard {
-		compatible = "gpio-keys";
-
-		btn0 {
-			gpios = <&pcf8575 0 GPIO_ACTIVE_LOW>;
-			label = "btn0";
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-
-		btn1 {
-			gpios = <&pcf8575 1 GPIO_ACTIVE_LOW>;
-			label = "btn1";
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-
-		btn2 {
-			gpios = <&pcf8575 2 GPIO_ACTIVE_LOW>;
-			label = "btn2";
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-
-		btn3 {
-			gpios = <&pcf8575 3 GPIO_ACTIVE_LOW>;
-			label = "btn3";
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		gen-led0 {
-			label = "led0";
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_led0>;
-			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "cpu0";
-		};
-
-		gen-led1 {
-			label = "led1";
-			gpios = <&pcf8575 8 GPIO_ACTIVE_HIGH>;
-		};
-
-		gen-led2 {
-			label = "led2";
-			gpios = <&pcf8575 9 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-
-		gen-led3 {
-			label = "led3";
-			gpios = <&pcf8575 10 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-on";
-		};
-	};
-
-	reg_usb_otg_vbus: regulator-otg-vbus {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usb_otg>;
-		compatible = "regulator-fixed";
-		regulator-name = "usb_otg_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usb_h1_vbus: regulator-usb-h1-vbus {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usb_h1_vbus>;
-		compatible = "regulator-fixed";
-		regulator-name = "usb_h1_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
-		startup-delay-us = <70000>;
-		enable-active-high;
-	};
-
-	reg_3v3: regulator-3v3 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_3v3>;
-		compatible = "regulator-fixed";
-		regulator-name = "reg_3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
-		startup-delay-us = <70000>;
-		enable-active-high;
-		regulator-always-on;
-	};
-
-	reg_enet: regulator-ethernet {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_enet>;
-		compatible = "regulator-fixed";
-		regulator-name = "ethernet-supply";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>;
-		startup-delay-us = <70000>;
-		enable-active-high;
-		vin-supply = <&sw4_reg>;
-	};
-
-	reg_audio: regulator-audio {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_audio>;
-		compatible = "regulator-fixed";
-		regulator-name = "3v3_aud";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		vin-supply = <&reg_3v3>;
-	};
-
-	reg_hdmi: regulator-hdmi {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_hdmi>;
-		compatible = "regulator-fixed";
-		regulator-name = "hdmi-supply";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		vin-supply = <&reg_3v3>;
-	};
-
-	reg_uart3: regulator-uart3 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_uart3>;
-		compatible = "regulator-fixed";
-		regulator-name = "uart3-supply";
-		gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-		vin-supply = <&reg_3v3>;
-	};
-
-	reg_1v8: regulator-1v8 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_1v8>;
-		compatible = "regulator-fixed";
-		regulator-name = "1v8-supply";
-		gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-		vin-supply = <&reg_3v3>;
-	};
-
-	reg_pcie: regulator-pcie {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_pcie>;
-		regulator-name = "mpcie_3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_mipi: regulator-mipi {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_mipi>;
-		regulator-name = "mipi_pwr_en";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		gpio = <&gpio3 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	sound {
-		compatible = "fsl,imx-audio-wm8962";
-		model = "wm8962-audio";
-		ssi-controller = <&ssi2>;
-		audio-codec = <&wm8962>;
-		audio-routing =
-			"Headphone Jack", "HPOUTL",
-			"Headphone Jack", "HPOUTR",
-			"Ext Spk", "SPKOUTL",
-			"Ext Spk", "SPKOUTR",
-			"AMIC", "MICBIAS",
-			"IN3R", "AMIC";
-		mux-int-port = <2>;
-		mux-ext-port = <4>;
-	};
-};
-
-&audmux {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_audmux>;
-	status = "okay";
-};
-
-&ecspi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	cs-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
-	status = "disabled";
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii-id";
-	phy-reset-duration = <10>;
-	phy-reset-gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
-	phy-supply = <&reg_enet>;
-	interrupt-parent = <&gpio1>;
-	interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-	status = "okay";
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	clock-frequency = <400000>;
-	status = "okay";
-
-	wm8962: audio-codec@1a {
-		compatible = "wlf,wm8962";
-		reg = <0x1a>;
-		clocks = <&clks IMX6QDL_CLK_CKO>;
-		DCVDD-supply = <&reg_audio>;
-		DBVDD-supply = <&reg_audio>;
-		AVDD-supply = <&reg_audio>;
-		CPVDD-supply = <&reg_audio>;
-		MICVDD-supply = <&reg_audio>;
-		PLLVDD-supply = <&reg_audio>;
-		SPKVDD1-supply = <&reg_audio>;
-		SPKVDD2-supply = <&reg_audio>;
-		gpio-cfg = <
-			0x0000 /* 0:Default */
-			0x0000 /* 1:Default */
-			0x0000 /* 2:FN_DMICCLK */
-			0x0000 /* 3:Default */
-			0x0000 /* 4:FN_DMICCDAT */
-			0x0000 /* 5:Default */
-		>;
-	};
-};
-
-&i2c3 {
-	ov5640: camera@10 {
-		compatible = "ovti,ov5640";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ov5640>;
-		reg = <0x10>;
-		clocks = <&clks IMX6QDL_CLK_CKO>;
-		clock-names = "xclk";
-		DOVDD-supply = <&reg_mipi>;
-		AVDD-supply = <&reg_mipi>;
-		DVDD-supply = <&reg_mipi>;
-		reset-gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
-		powerdown-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>;
-
-		port {
-			ov5640_to_mipi_csi2: endpoint {
-				remote-endpoint = <&mipi_csi2_in>;
-				clock-lanes = <0>;
-				data-lanes = <1 2>;
-			};
-		};
-	};
-
-	pcf8575: gpio@20 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcf8574>;
-		compatible = "nxp,pcf8575";
-		reg = <0x20>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		lines-initial-states = <0x0710>;
-		wakeup-source;
-	};
-};
-
-&ipu1_csi1_from_mipi_vc1 {
-	clock-lanes = <0>;
-	data-lanes = <1 2>;
-};
-
-&mipi_csi {
-	status = "okay";
-
-	port@0 {
-		reg = <0>;
-
-		mipi_csi2_in: endpoint {
-			remote-endpoint = <&ov5640_to_mipi_csi2>;
-			clock-lanes = <0>;
-			data-lanes = <1 2>;
-		};
-	};
-};
-
-&pcie {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie>;
-	reset-gpio = <&gpio1 9 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie>;
-	status = "okay";
-};
-
-&pwm3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm3>;
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-&ssi2 {
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
-&usbh1 {
-	vbus-supply = <&reg_usb_h1_vbus>;
-	status = "okay";
-};
-
-&usbotg {
-	vbus-supply = <&reg_usb_otg_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg>;
-	disable-over-current;
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
-	vmmc-supply = <&reg_3v3>;
-	no-1-8-v;
-	keep-power-in-suspend;
-	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_audmux: audmuxgrp {
-		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
-			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x110b0
-			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS 0x130b0
-			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
-		>;
-	};
-
-	pinctrl_ecspi1: ecspi1grp {
-		fsl,pins = <
-			MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK	0x100b1
-			MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI	0x100b1
-			MX6QDL_PAD_KEY_COL1__ECSPI1_MISO	0x100b1
-			MX6QDL_PAD_KEY_ROW1__GPIO4_IO09		0x1b0b0
-		>;
-	};
-
-	pinctrl_enet: enetgrp {
-		fsl,pins = <
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b8b0
-			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
-			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b030
-			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b030
-			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b030
-			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b030
-			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b030
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x100b0
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
-			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
-			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b030
-			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x13030
-			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x13030
-			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b030
-			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x13030
-			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25	0x1b0b0	/* ENET_INT */
-			MX6QDL_PAD_ENET_RX_ER__GPIO1_IO24	0x1b0b0	/* ETHR_nRST */
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D21__I2C1_SCL	0x4001b8b1
-			MX6QDL_PAD_EIM_D28__I2C1_SDA	0x4001b8b1
-		>;
-	};
-
-	pinctrl_led0: led0grp {
-	    fsl,pins = <
-		MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x1b0b0
-	    >;
-	};
-
-	pinctrl_ov5640: ov5640grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D26__GPIO3_IO26	0x1b0b1
-			MX6QDL_PAD_EIM_D27__GPIO3_IO27	0x1b0b1
-		>;
-	};
-
-	pinctrl_pcf8574: pcf8575grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_BCLK__GPIO6_IO31 0x1b0b0
-		>;
-	};
-
-	pinctrl_pcie: pciegrp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_8__GPIO1_IO08 0x1b0b0
-			MX6QDL_PAD_GPIO_9__GPIO1_IO09 0x1b0b0
-		>;
-	};
-
-	pinctrl_pwm3: pwm3grp {
-	    fsl,pins = <
-		MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
-	    >;
-	};
-
-	pinctrl_reg_1v8: reg1v8grp {
-	    fsl,pins = <
-		MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x1b0b0
-	    >;
-	};
-
-	pinctrl_reg_3v3: reg3v3grp {
-	    fsl,pins = <
-		MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b0
-	    >;
-	};
-
-	pinctrl_reg_audio: reg-audiogrp {
-		fsl,pins = <
-			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x1b0b0
-		>;
-	};
-
-	pinctrl_reg_enet: reg-enetgrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D31__GPIO3_IO31	0x1b0b0
-		>;
-	};
-
-	pinctrl_reg_hdmi: reg-hdmigrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D20__GPIO3_IO20	0x1b0b0
-		>;
-	};
-
-	pinctrl_reg_mipi: reg-mipigrp {
-		fsl,pins = <MX6QDL_PAD_EIM_D19__GPIO3_IO19 0x1b0b1>;
-	};
-
-	pinctrl_reg_pcie: reg-pciegrp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_2__GPIO1_IO02	0x1b0b0
-			>;
-	};
-
-	pinctrl_reg_uart3: reguart3grp {
-	    fsl,pins = <
-		MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28	0x1b0b0
-	    >;
-	};
-
-	pinctrl_reg_usb_h1_vbus: usbh1grp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x1b0b0
-		>;
-	};
-
-	pinctrl_reg_usb_otg: reg-usb-otggrp {
-		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D23__UART3_CTS_B		0x1b0b1
-			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
-			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
-			MX6QDL_PAD_EIM_EB3__UART3_RTS_B		0x1b0b1
-		>;
-	};
-
-	pinctrl_usbotg: usbotggrp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__USB_OTG_ID	0xd17059
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1b0b0	/* CD */
-			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17069
-			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10069
-			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17069
-			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17069
-			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17069
-			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17069
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: h100-usdhc2-100mhz {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1b0b0	/* CD */
-			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x170b9
-			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x100b9
-			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
-			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
-			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
-			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: h100-usdhc2-200mhz {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1b0b0	/* CD */
-			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x170f9
-			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x100f9
-			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x170f9
-			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x170f9
-			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x170f9
-			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x170f9
-		>;
-	};
-
-};
diff --git a/arch/arm/dts/imx6-logicpd-som.dtsi b/arch/arm/dts/imx6-logicpd-som.dtsi
deleted file mode 100644
index 547fb141ec0..00000000000
--- a/arch/arm/dts/imx6-logicpd-som.dtsi
+++ /dev/null
@@ -1,369 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// Copyright (C) 2019 Logic PD, Inc.
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-
-/ {
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	memory@10000000 {
-		device_type = "memory";
-		reg = <0x10000000 0x80000000>;
-	};
-
-	reg_wl18xx_vmmc: regulator-wl18xx {
-		compatible = "regulator-fixed";
-		regulator-name = "vwl1837";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio7 0 GPIO_ACTIVE_HIGH>;
-		startup-delay-us = <70000>;
-		enable-active-high;
-	};
-};
-
-&clks {
-	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
-			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
-	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
-				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
-};
-
-&gpmi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
-	status = "okay";
-};
-
-&i2c3 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-
-	pfuze100: pmic@8 {
-		compatible = "fsl,pfuze100";
-		reg = <0x08>;
-
-		regulators {
-			sw1a_reg: sw1ab {
-				regulator-min-microvolt = <725000>;
-				regulator-max-microvolt = <1450000>;
-				regulator-name = "vddcore";
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <6250>;
-			};
-
-			sw1c_reg: sw1c {
-				regulator-min-microvolt = <725000>;
-				regulator-max-microvolt = <1450000>;
-				regulator-name = "vddsoc";
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <6250>;
-			};
-
-			sw2_reg: sw2 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "gen_3v3";
-				regulator-boot-on;
-			};
-
-			sw3a_reg: sw3a {
-				regulator-min-microvolt = <1350000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-name = "sw3a_vddr";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw3b_reg: sw3b {
-				regulator-min-microvolt = <1350000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-name = "sw3b_vddr";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw4_reg: sw4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "gen_rgmii";
-			};
-
-			swbst_reg: swbst {
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5150000>;
-				regulator-name = "gen_5v0";
-			};
-
-			snvs_reg: vsnvs {
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-name = "gen_vsns";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vref_reg: vrefddr {
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vgen1_reg: vgen1 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <1500000>;
-				regulator-name = "gen_1v5";
-			};
-
-			vgen2_reg: vgen2 {
-				regulator-name = "vgen2";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-			};
-
-			vgen3_reg: vgen3 {
-				regulator-name = "gen_vadj_0";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			vgen4_reg: vgen4 {
-				regulator-name = "gen_1v8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-
-			vgen5_reg: vgen5 {
-				regulator-name = "gen_vadj_1";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen6_reg: vgen6 {
-				regulator-name = "gen_2v5";
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-				regulator-always-on;
-			};
-
-			coin_reg: coin {
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-			};
-		};
-	};
-
-	temperature-sensor@49 {
-		compatible = "ti,tmp102";
-		reg = <0x49>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
-		#thermal-sensor-cells = <1>;
-	};
-
-	temperature-sensor@4a {
-		compatible = "ti,tmp102";
-		reg = <0x4a>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_tempsense>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
-		#thermal-sensor-cells = <1>;
-	};
-
-	eeprom@51 {
-		compatible = "atmel,24c64";
-		pagesize = <32>;
-		read-only;	/* Manufacturing EEPROM programmed at factory */
-		reg = <0x51>;
-	};
-
-	eeprom@52 {
-		compatible = "atmel,24c64";
-		pagesize = <32>;
-		reg = <0x52>;
-	};
-};
-
-/* Reroute power feeding the CPU to come from the external PMIC */
-&reg_arm
-{
-	vin-supply = <&sw1a_reg>;
-};
-
-&reg_soc
-{
-	vin-supply = <&sw1c_reg>;
-};
-
-&snvs_poweroff {
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog>;
-
-	pinctrl_gpmi_nand: gpmi-nandgrp {
-		fsl,pins = <
-			MX6QDL_PAD_NANDF_CLE__NAND_CLE		0x0b0b1
-			MX6QDL_PAD_NANDF_ALE__NAND_ALE		0x0b0b1
-			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0x0b0b1
-			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0x0b000
-			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0x0b0b1
-			MX6QDL_PAD_SD4_CMD__NAND_RE_B		0x0b0b1
-			MX6QDL_PAD_SD4_CLK__NAND_WE_B		0x0b0b1
-			MX6QDL_PAD_NANDF_D0__NAND_DATA00	0x0b0b1
-			MX6QDL_PAD_NANDF_D1__NAND_DATA01	0x0b0b1
-			MX6QDL_PAD_NANDF_D2__NAND_DATA02	0x0b0b1
-			MX6QDL_PAD_NANDF_D3__NAND_DATA03	0x0b0b1
-			MX6QDL_PAD_NANDF_D4__NAND_DATA04	0x0b0b1
-			MX6QDL_PAD_NANDF_D5__NAND_DATA05	0x0b0b1
-			MX6QDL_PAD_NANDF_D6__NAND_DATA06	0x0b0b1
-			MX6QDL_PAD_NANDF_D7__NAND_DATA07	0x0b0b1
-		>;
-	};
-
-	pinctrl_hog: hoggrp {
-		fsl,pins = <	/* Enable ARM Debugger */
-			MX6QDL_PAD_CSI0_MCLK__ARM_TRACE_CTL	0x1b0b0
-			MX6QDL_PAD_CSI0_PIXCLK__ARM_EVENTO	0x1b0b0
-			MX6QDL_PAD_CSI0_VSYNC__ARM_TRACE00	0x1b0b0
-			MX6QDL_PAD_CSI0_DATA_EN__ARM_TRACE_CLK	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT4__ARM_TRACE01	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT5__ARM_TRACE02	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT6__ARM_TRACE03	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT7__ARM_TRACE04	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT8__ARM_TRACE05	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT9__ARM_TRACE06	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT10__ARM_TRACE07	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT11__ARM_TRACE08	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT12__ARM_TRACE09	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT13__ARM_TRACE10	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT14__ARM_TRACE11	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT15__ARM_TRACE12	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT16__ARM_TRACE13	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT17__ARM_TRACE14	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT18__ARM_TRACE15	0x1b0b0
-			MX6QDL_PAD_GPIO_0__CCM_CLKO1        0x130b0
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
-			MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
-		>;
-	};
-
-	pinctrl_tempsense: tempsensegrp {
-		fsl,pins = <
-			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x1b0b0
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
-			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX6QDL_PAD_SD3_RST__GPIO7_IO08		0x13059	/* BT_EN */
-			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
-			MX6QDL_PAD_SD4_DAT5__UART2_RTS_B	0x1b0b1
-			MX6QDL_PAD_SD4_DAT6__UART2_CTS_B	0x1b0b1
-			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x170B9
-			MX6QDL_PAD_SD1_CLK__SD1_CLK	0x100B9
-			MX6QDL_PAD_SD1_DAT0__SD1_DATA0	0x170B9
-			MX6QDL_PAD_SD1_DAT1__SD1_DATA1	0x170B9
-			MX6QDL_PAD_SD1_DAT2__SD1_DATA2	0x170B9
-			MX6QDL_PAD_SD1_DAT3__SD1_DATA3	0x170B9
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17049
-			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10049
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17049
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17049
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17049
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17049
-			MX6QDL_PAD_SD3_DAT4__GPIO7_IO01	0x130b0 /* WL_IRQ */
-			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00	0x17059 /* WLAN_EN */
-		>;
-	};
-};
-
-&snvs_poweroff {
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	uart-has-rtscts;
-	status = "okay";
-
-	bluetooth {
-		compatible = "ti,wl1837-st";
-		enable-gpios = <&gpio7 8 GPIO_ACTIVE_HIGH>;
-	};
-};
-
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	non-removable;
-	keep-power-in-suspend;
-	wakeup-source;
-	vmmc-supply = <&sw2_reg>;
-	status = "okay";
-};
-
-&usdhc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	non-removable;
-	cap-power-off-card;
-	keep-power-in-suspend;
-	wakeup-source;
-	vmmc-supply = <&reg_wl18xx_vmmc>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	wlcore: wlcore@2 {
-		  compatible = "ti,wl1837";
-		  reg = <2>;
-		  interrupt-parent = <&gpio7>;
-		  interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
-		  tcxo-clock-frequency = <26000000>;
-	};
-};
diff --git a/arch/arm/dts/imx6q-logicpd-u-boot.dtsi b/arch/arm/dts/imx6q-logicpd-u-boot.dtsi
deleted file mode 100644
index 2b28d36ef11..00000000000
--- a/arch/arm/dts/imx6q-logicpd-u-boot.dtsi
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2019 Logic PD <aford173@gmail.com>
- */
-
-#include "imx6qdl-u-boot.dtsi"
-
-&uart1 {
-	bootph-pre-ram;
-};
-
-&usdhc1 {
-	bootph-pre-ram;
-};
-
-&usdhc2 {
-	bootph-pre-ram;
-};
-
-&pinctrl_uart1 {
-	bootph-pre-ram;
-};
-
-&pinctrl_usdhc1 {
-	bootph-pre-ram;
-};
-
-&pinctrl_usdhc2 {
-	bootph-pre-ram;
-};
diff --git a/arch/arm/dts/imx6q-logicpd.dts b/arch/arm/dts/imx6q-logicpd.dts
deleted file mode 100644
index 46a4ddedb42..00000000000
--- a/arch/arm/dts/imx6q-logicpd.dts
+++ /dev/null
@@ -1,130 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// Copyright (C) 2019 Logic PD, Inc.
-
-/dts-v1/;
-#include "imx6q.dtsi"
-#include "imx6-logicpd-som.dtsi"
-#include "imx6-logicpd-baseboard.dtsi"
-
-/ {
-	model = "Logic PD i.MX6QD SOM-M3";
-	compatible = "logicpd,imx6q-logicpd", "fsl,imx6q";
-
-	backlight: backlight-lvds {
-		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 20000 0>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
-		power-supply = <&reg_lcd>;
-	};
-
-	panel-lvds0 {
-		compatible = "okaya,rs800480t-7x0gp";
-		power-supply = <&reg_lcd_reset>;
-		backlight = <&backlight>;
-
-		port {
-			panel_in_lvds0: endpoint {
-				remote-endpoint = <&lvds0_out>;
-			};
-		};
-	};
-
-	reg_lcd: regulator-lcd {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_lcd_reg>;
-		compatible = "regulator-fixed";
-		regulator-name = "lcd_panel_pwr";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio4 17 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		vin-supply = <&reg_3v3>;
-		startup-delay-us = <500000>;
-	};
-
-	reg_lcd_reset: regulator-lcd-reset {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_lcd_reset>;
-		compatible = "regulator-fixed";
-		regulator-name = "nLCD_RESET";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		vin-supply = <&reg_lcd>;
-	};
-};
-
-&clks {
-	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
-			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
-			  <&clks IMX6QDL_CLK_IPU1_DI0_PRE_SEL>,
-			  <&clks IMX6QDL_CLK_IPU2_DI0_PRE_SEL>;
-	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
-				 <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
-				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
-				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>;
-};
-
-&hdmi {
-	ddc-i2c-bus = <&i2c3>;
-	status = "okay";
-};
-
-&i2c1 {
-	touchscreen@26 {
-		compatible = "ilitek,ili2117";
-		reg = <0x26>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_touchscreen>;
-		interrupts-extended = <&gpio1 6 IRQ_TYPE_EDGE_RISING>;
-	};
-};
-
-&ldb {
-	status = "okay";
-
-	lvds-channel@0 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <24>;
-		status = "okay";
-
-		port@4 {
-			reg = <4>;
-			lvds0_out: endpoint {
-				remote-endpoint = <&panel_in_lvds0>;
-			};
-		};
-	};
-
-};
-
-&pwm3 {
-	status = "okay";
-};
-
-&reg_hdmi {
-	regulator-always-on;	/* Without this, the level shifter on HDMI doesn't turn on */
-};
-
-&iomuxc {
-	pinctrl_lcd_reg: lcdreg {
-		fsl,pins = <
-			MX6QDL_PAD_DI0_PIN15__GPIO4_IO17	0x100b0	/* R_LCD_PANEL_PWR */
-		>;
-	};
-
-	pinctrl_lcd_reset: lcdreset {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_A25__GPIO5_IO02	0x100b0	/* LCD_nRESET */
-		>;
-	};
-
-	pinctrl_touchscreen: touchscreengrp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_6__GPIO1_IO06	0x1b0b0	/* TOUCH_nPINTDAV */
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index ffcc05e8683..cc6369dbbfb 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -272,20 +272,6 @@ config TARGET_MX6CUBOXI
 	select BOARD_LATE_INIT
 	select SUPPORT_SPL
 
-config TARGET_MX6LOGICPD
-	bool "Logic PD i.MX6 SOM"
-	depends on MX6Q
-	select SUPPORT_SPL
-	select BOARD_EARLY_INIT_F
-	select BOARD_LATE_INIT
-	select DM
-	select DM_GPIO
-	select DM_I2C
-	select DM_PMIC
-	select MMC
-	select OF_CONTROL
-	imply CMD_DM
-
 config TARGET_MX6MEMCAL
 	bool "mx6memcal"
 	depends on MX6QDL
@@ -752,7 +738,6 @@ source "board/kosagi/novena/Kconfig"
 source "board/softing/vining_2000/Kconfig"
 source "board/liebherr/display5/Kconfig"
 source "board/liebherr/mccmon6/Kconfig"
-source "board/logicpd/imx6/Kconfig"
 source "board/sielaff/imx6dl-sielaff/Kconfig"
 source "board/solidrun/mx6cuboxi/Kconfig"
 source "board/somlabs/visionsom-6ull/Kconfig"
diff --git a/board/logicpd/imx6/Kconfig b/board/logicpd/imx6/Kconfig
deleted file mode 100644
index dfc196124f3..00000000000
--- a/board/logicpd/imx6/Kconfig
+++ /dev/null
@@ -1,12 +0,0 @@
-if TARGET_MX6LOGICPD
-
-config SYS_BOARD
-       default "imx6"
-
-config SYS_VENDOR
-	default "logicpd"
-
-config SYS_CONFIG_NAME
-       default "imx6_logic"
-
-endif
diff --git a/board/logicpd/imx6/MAINTAINERS b/board/logicpd/imx6/MAINTAINERS
deleted file mode 100644
index 4280315269d..00000000000
--- a/board/logicpd/imx6/MAINTAINERS
+++ /dev/null
@@ -1,10 +0,0 @@
-MX6LOGICPD BOARD
-M:     Adam Ford <aford173@gmail.com>
-S:     Maintained
-F:     board/logicpd/imx6/
-F:     include/configs/imx6_logic.h
-F:     configs/imx6q_logic_defconfig
-F:     arch/arm/dts/imx6-logicpd-baseboard.dtsi
-F:     arch/arm/dts/imx6-logicpd-som.dtsi
-F:     arch/arm/dts/imx6q-logicpd.dts
-F:     arch/arm/dts/imx6q-logicpd-u-boot.dtsi
diff --git a/board/logicpd/imx6/Makefile b/board/logicpd/imx6/Makefile
deleted file mode 100644
index dbaf18d3e0b..00000000000
--- a/board/logicpd/imx6/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-# Copyright (C) 2007, Guennadi Liakhovetski <lg@denx.de>
-#
-# (C) Copyright 2011 Freescale Semiconductor, Inc.
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y  := imx6logic.o
diff --git a/board/logicpd/imx6/README b/board/logicpd/imx6/README
deleted file mode 100644
index 9d7b9128c4d..00000000000
--- a/board/logicpd/imx6/README
+++ /dev/null
@@ -1,82 +0,0 @@
-U-Boot for LogicPD i.MX6 Development Kit
-----------------------------------------
-
-This file contains information for the port of U-Boot to the Logic PD Development kit.
-
-Logic PD has an i.MX6 System On Module (SOM) and a correspondong development
-board.  SOM has a built-in microSD socket, DDR and NAND flash.  The development kit has
-an SMSC Ethernet PHY, serial debug port and a variety of peripherals.
-
-On the intial release, the SOM came with either an i.MX6D or i.MX6Q.
-
-For more details about Logic PD i.MX6 Development kit, visit:
-https://www.logicpd.com/
-
-Building U-Boot for Logic PD Development Kit
---------------------------------------------
-To build U-Boot for the Dual and Quad variants:
-
- make imx6q_logic_defconfig
- make u-boot.imx CROSS_COMPILE=arm-linux-
-
-
-Flashing U-Boot into the SD card
---------------------------------
-U-Boot is now building with SPL enabled which means there are two files to
-load into the SD card. Make sure the card is formatted with at least two
-partitions with the first partition being FAT32. First copy u-boot-dtb.img
-to the first partition then burn SPL to the SD card with dd.
-The SPL portion is programmed into a certain location for use by the internal
-bootROM and it cannot be changed.  The following instructions assume the SD
-card is located as /dev/sdb.
-
-  cp u-boot-dtb.img /dev/media/logic/boot
-  sudo dd if=SPL of=/dev/sdb bs=1k seek=1 oflag=sync status=none && sync
-
-
-Flashing U-Boot into NAND
--------------------------
-Once in Linux with MTD support for the NAND on /dev/mtd0, program U-Boot with the following:
-with:
-
-  kobs-ng init -v -x u-boot-dtb.imx
-
-
-Using Falcon Mode
------------------
-With Falcon Mode enabled, U-Boot can be bypassed by having SPL directly load
-the kernel.  The device tree, Kernel and boot args must first be configured,
-and stored to a file on the micro SD card called 'args'
-The kernel uImage is built with LOAD_ADDR=0x12000000 and the device tree is
-assummed to be imx6q-logicpd.dtb.
-
-By default the mmcroot is set to the baseboard.
-
-  # Establish bootargs
-  run mmcargs
-
-  # Load Linux Kernel uImage
-  fatload mmc 1 $loadaddr uImage
-
-  # Load Device Tree
-  run loadfdt
-
-  # Setup the blob that will get passed to the kernel
-  spl export fdt ${loadaddr} - ${fdt_addr_r}
-
-  # Note the starting and ending address of the updated device tree.
-  # for this example:
-  # Loading Device Tree to 1ffdf000, end 1fff038b ... OK
-  # Notice that 0x1fff038b - 1ffdf000 = 0x1138b
-  # now Add 1, so the length is 0x1138c.
-
-  fatwrite mmc 1 0x1ffdf000 args 0x1138c
-
-  # Reset the board and it will bypass U-Boot and SPL will directly boot
-  # the uImage
-
-To interrupt the boot sequence and force U-Boot to load, hold the 'c' button
-while starting.
-
-Additional Support Documentation can be found at:
-https://support.logicpd.com/
diff --git a/board/logicpd/imx6/imx6logic.c b/board/logicpd/imx6/imx6logic.c
deleted file mode 100644
index 652994df616..00000000000
--- a/board/logicpd/imx6/imx6logic.c
+++ /dev/null
@@ -1,323 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017 Logic PD, Inc.
- *
- * Author: Adam Ford <aford173@gmail.com>
- *
- * Based on SabreSD by Fabio Estevam <fabio.estevam@nxp.com>
- * and updates by Jagan Teki <jagan@amarulasolutions.com>
- */
-
-#include <env.h>
-#include <init.h>
-#include <miiphy.h>
-#include <input.h>
-#include <mmc.h>
-#include <fsl_esdhc_imx.h>
-#include <serial.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/gpio.h>
-#include <linux/sizes.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/crm_regs.h>
-#include <asm/arch/iomux.h>
-#include <asm/arch/mxc_hdmi.h>
-#include <asm/arch/mx6-pins.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/iomux-v3.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-#define UART_PAD_CTRL  (PAD_CTL_PKE | PAD_CTL_PUE |            \
-	PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED |               \
-	PAD_CTL_DSE_40ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
-
-#define NAND_PAD_CTRL  (PAD_CTL_PKE | PAD_CTL_PUE |            \
-	PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED   |             \
-	PAD_CTL_DSE_40ohm   | PAD_CTL_HYS)
-
-int dram_init(void)
-{
-	gd->ram_size = imx_ddr_size();
-	return 0;
-}
-
-static iomux_v3_cfg_t const nand_pads[] = {
-	MX6_PAD_NANDF_CS0__NAND_CE0_B | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_NANDF_ALE__NAND_ALE  | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_NANDF_CLE__NAND_CLE  | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_NANDF_WP_B__NAND_WP_B  | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_NANDF_RB0__NAND_READY_B   | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_NANDF_D0__NAND_DATA00    | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_NANDF_D1__NAND_DATA01    | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_NANDF_D2__NAND_DATA02    | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_NANDF_D3__NAND_DATA03    | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_NANDF_D4__NAND_DATA04    | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_NANDF_D5__NAND_DATA05    | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_NANDF_D6__NAND_DATA06    | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_NANDF_D7__NAND_DATA07    | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_SD4_CLK__NAND_WE_B    | MUX_PAD_CTRL(NAND_PAD_CTRL),
-	MX6_PAD_SD4_CMD__NAND_RE_B    | MUX_PAD_CTRL(NAND_PAD_CTRL),
-};
-
-static void setup_nand_pins(void)
-{
-	imx_iomux_v3_setup_multiple_pads(nand_pads, ARRAY_SIZE(nand_pads));
-}
-
-static int ar8031_phy_fixup(struct phy_device *phydev)
-{
-	unsigned short val;
-
-	/* To enable AR8031 output a 125MHz clk from CLK_25M */
-	phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x7);
-	phy_write(phydev, MDIO_DEVAD_NONE, 0xe, 0x8016);
-	phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x4007);
-
-	val = phy_read(phydev, MDIO_DEVAD_NONE, 0xe);
-	val &= 0xffe3;
-	val |= 0x18;
-	phy_write(phydev, MDIO_DEVAD_NONE, 0xe, val);
-
-	/* introduce tx clock delay */
-	phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x5);
-	val = phy_read(phydev, MDIO_DEVAD_NONE, 0x1e);
-	val |= 0x0100;
-	phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, val);
-
-	return 0;
-}
-
-int board_phy_config(struct phy_device *phydev)
-{
-	ar8031_phy_fixup(phydev);
-
-	if (phydev->drv->config)
-		phydev->drv->config(phydev);
-
-	return 0;
-}
-
-/*
- * Do not overwrite the console
- * Use always serial for U-Boot console
- */
-int overwrite_console(void)
-{
-	return 1;
-}
-
-int board_early_init_f(void)
-{
-	setup_nand_pins();
-	return 0;
-}
-
-int board_init(void)
-{
-	/* address of boot parameters */
-	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
-	return 0;
-}
-
-int board_late_init(void)
-{
-	env_set("board_name", "imx6logic");
-
-	if (is_mx6dq()) {
-		env_set("board_rev", "MX6DQ");
-		if (!env_get("fdt_file"))
-			env_set("fdt_file", "imx6q-logicpd.dtb");
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_XPL_BUILD
-#include <asm/arch/mx6-ddr.h>
-#include <asm/arch/mx6q-ddr.h>
-#include <spl.h>
-#include <linux/libfdt.h>
-
-#ifdef CONFIG_SPL_OS_BOOT
-int spl_start_uboot(void)
-{
-	/* break into full u-boot on 'c' */
-	if (serial_tstc() && serial_getc() == 'c')
-		return 1;
-
-	return 0;
-}
-#endif
-
-void board_boot_order(u32 *spl_boot_list)
-{
-	struct src *psrc = (struct src *)SRC_BASE_ADDR;
-	unsigned int reg = readl(&psrc->sbmr1) >> 11;
-	u32 boot_mode = imx6_src_get_boot_mode() & IMX6_BMODE_MASK;
-	unsigned int bmode = readl(&src_base->sbmr2);
-
-	/* If bmode is serial or USB phy is active, return serial */
-	if (((bmode >> 24) & 0x03) == 0x01 || is_usbotg_phy_active()) {
-		spl_boot_list[0] = BOOT_DEVICE_BOARD;
-		return;
-	}
-
-	switch (boot_mode >> IMX6_BMODE_SHIFT) {
-	case IMX6_BMODE_NAND_MIN ... IMX6_BMODE_NAND_MAX:
-		spl_boot_list[0] = BOOT_DEVICE_NAND;
-		break;
-	case IMX6_BMODE_SD:
-	case IMX6_BMODE_ESD:
-	case IMX6_BMODE_MMC:
-	case IMX6_BMODE_EMMC:
-		/*
-		 * Upon reading BOOT_CFG register the following map is done:
-		 * Bit 11 and 12 of BOOT_CFG register can determine the current
-		 * mmc port
-		 * 0x1                  SD1-SOM
-		 * 0x2                  SD2-Baseboard
-		 */
-
-		reg &= 0x3; /* Only care about bottom 2 bits */
-		switch (reg) {
-		case 0:
-			spl_boot_list[0] = BOOT_DEVICE_MMC1;
-			break;
-		case 1:
-			spl_boot_list[0] = BOOT_DEVICE_MMC2;
-			break;
-		}
-		break;
-	default:
-		/* By default use USB downloader */
-		spl_boot_list[0] = BOOT_DEVICE_BOARD;
-		break;
-	}
-
-	/* As a last resort, use serial downloader */
-	spl_boot_list[1] = BOOT_DEVICE_BOARD;
-}
-
-static void ccgr_init(void)
-{
-	struct mxc_ccm_reg *ccm = (struct mxc_ccm_reg *)CCM_BASE_ADDR;
-
-	writel(0x00C03F3F, &ccm->CCGR0);
-	writel(0x0030FC03, &ccm->CCGR1);
-	writel(0x0FFFC000, &ccm->CCGR2);
-	writel(0x3FF00000, &ccm->CCGR3);
-	writel(0xFFFFF300, &ccm->CCGR4);
-	writel(0x0F0000F3, &ccm->CCGR5);
-	writel(0x00000FFF, &ccm->CCGR6);
-}
-
-static int mx6q_dcd_table[] = {
-	MX6_IOM_GRP_DDR_TYPE, 0x000C0000,
-	MX6_IOM_GRP_DDRPKE, 0x00000000,
-	MX6_IOM_DRAM_SDCLK_0, 0x00000030,
-	MX6_IOM_DRAM_SDCLK_1, 0x00000030,
-	MX6_IOM_DRAM_CAS, 0x00000030,
-	MX6_IOM_DRAM_RAS, 0x00000030,
-	MX6_IOM_GRP_ADDDS, 0x00000030,
-	MX6_IOM_DRAM_RESET, 0x00000030,
-	MX6_IOM_DRAM_SDBA2, 0x00000000,
-	MX6_IOM_DRAM_SDODT0, 0x00000030,
-	MX6_IOM_DRAM_SDODT1, 0x00000030,
-	MX6_IOM_GRP_CTLDS, 0x00000030,
-	MX6_IOM_DDRMODE_CTL, 0x00020000,
-	MX6_IOM_DRAM_SDQS0, 0x00000030,
-	MX6_IOM_DRAM_SDQS1, 0x00000030,
-	MX6_IOM_DRAM_SDQS2, 0x00000030,
-	MX6_IOM_DRAM_SDQS3, 0x00000030,
-	MX6_IOM_GRP_DDRMODE, 0x00020000,
-	MX6_IOM_GRP_B0DS, 0x00000030,
-	MX6_IOM_GRP_B1DS, 0x00000030,
-	MX6_IOM_GRP_B2DS, 0x00000030,
-	MX6_IOM_GRP_B3DS, 0x00000030,
-	MX6_IOM_DRAM_DQM0, 0x00000030,
-	MX6_IOM_DRAM_DQM1, 0x00000030,
-	MX6_IOM_DRAM_DQM2, 0x00000030,
-	MX6_IOM_DRAM_DQM3, 0x00000030,
-	MX6_MMDC_P0_MDSCR, 0x00008000,
-	MX6_MMDC_P0_MPZQHWCTRL, 0xA1390003,
-	MX6_MMDC_P0_MPWLDECTRL0, 0x002D003A,
-	MX6_MMDC_P0_MPWLDECTRL1, 0x0038002B,
-	MX6_MMDC_P0_MPDGCTRL0, 0x03340338,
-	MX6_MMDC_P0_MPDGCTRL1, 0x0334032C,
-	MX6_MMDC_P0_MPRDDLCTL, 0x4036383C,
-	MX6_MMDC_P0_MPWRDLCTL, 0x2E384038,
-	MX6_MMDC_P0_MPRDDQBY0DL, 0x33333333,
-	MX6_MMDC_P0_MPRDDQBY1DL, 0x33333333,
-	MX6_MMDC_P0_MPRDDQBY2DL, 0x33333333,
-	MX6_MMDC_P0_MPRDDQBY3DL, 0x33333333,
-	MX6_MMDC_P0_MPMUR0, 0x00000800,
-	MX6_MMDC_P0_MDPDC, 0x00020036,
-	MX6_MMDC_P0_MDOTC, 0x09444040,
-	MX6_MMDC_P0_MDCFG0, 0xB8BE7955,
-	MX6_MMDC_P0_MDCFG1, 0xFF328F64,
-	MX6_MMDC_P0_MDCFG2, 0x01FF00DB,
-	MX6_MMDC_P0_MDMISC, 0x00011740,
-	MX6_MMDC_P0_MDSCR, 0x00008000,
-	MX6_MMDC_P0_MDRWD, 0x000026D2,
-	MX6_MMDC_P0_MDOR, 0x00BE1023,
-	MX6_MMDC_P0_MDASP, 0x00000047,
-	MX6_MMDC_P0_MDCTL, 0x85190000,
-	MX6_MMDC_P0_MDSCR, 0x00888032,
-	MX6_MMDC_P0_MDSCR, 0x00008033,
-	MX6_MMDC_P0_MDSCR, 0x00008031,
-	MX6_MMDC_P0_MDSCR, 0x19408030,
-	MX6_MMDC_P0_MDSCR, 0x04008040,
-	MX6_MMDC_P0_MDREF, 0x00007800,
-	MX6_MMDC_P0_MPODTCTRL, 0x00000007,
-	MX6_MMDC_P0_MDPDC, 0x00025576,
-	MX6_MMDC_P0_MAPSR, 0x00011006,
-	MX6_MMDC_P0_MDSCR, 0x00000000,
-	/* enable AXI cache for VDOA/VPU/IPU */
-
-	MX6_IOMUXC_GPR4, 0xF00000CF,
-	/* set IPU AXI-id0 Qos=0xf(bypass) AXI-id1 Qos=0x7 */
-	MX6_IOMUXC_GPR6, 0x007F007F,
-	MX6_IOMUXC_GPR7, 0x007F007F,
-};
-
-static void ddr_init(int *table, int size)
-{
-	int i;
-
-	for (i = 0; i < size / 2 ; i++)
-		writel(table[2 * i + 1], table[2 * i]);
-}
-
-static void spl_dram_init(void)
-{
-	if (is_mx6dq())
-		ddr_init(mx6q_dcd_table, ARRAY_SIZE(mx6q_dcd_table));
-}
-
-void board_init_f(ulong dummy)
-{
-	/* DDR initialization */
-	spl_dram_init();
-
-	/* setup AIPS and disable watchdog */
-	arch_cpu_init();
-
-	ccgr_init();
-	gpr_init();
-
-	/* iomux and setup of uart and NAND pins */
-	board_early_init_f();
-
-	/* setup GP timer */
-	timer_init();
-
-	/* Enable device tree and early DM support*/
-	spl_early_init();
-
-	/* UART clocks enabled and gd valid - init serial console */
-	preloader_console_init();
-}
-#endif
diff --git a/configs/imx6q_logic_defconfig b/configs/imx6q_logic_defconfig
deleted file mode 100644
index 1b09d9a5d27..00000000000
--- a/configs/imx6q_logic_defconfig
+++ /dev/null
@@ -1,118 +0,0 @@
-CONFIG_ARM=y
-CONFIG_ARCH_MX6=y
-CONFIG_SYS_MALLOC_LEN=0xa00000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_ENV_SIZE=0x100000
-CONFIG_ENV_OFFSET=0x400000
-CONFIG_MX6Q=y
-CONFIG_MX6_OCRAM_256KB=y
-CONFIG_TARGET_MX6LOGICPD=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6q-logicpd"
-CONFIG_SYS_MONITOR_LEN=409600
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL=y
-CONFIG_SPL_FS_FAT=y
-CONFIG_SPL_PAYLOAD="u-boot.img"
-CONFIG_SYS_MEMTEST_START=0x10000000
-CONFIG_SYS_MEMTEST_END=0x10010000
-CONFIG_LTO=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTDELAY=3
-CONFIG_BOOTCOMMAND="run autoboot"
-CONFIG_SYS_PBSIZE=543
-CONFIG_SYS_CONSOLE_IS_IN_ENV=y
-CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
-CONFIG_SPL_RAW_IMAGE_SUPPORT=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_DMA=y
-CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
-CONFIG_SPL_I2C=y
-CONFIG_SPL_NAND_SUPPORT=y
-CONFIG_SPL_OS_BOOT=y
-CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x18000000
-CONFIG_SYS_NAND_SPL_KERNEL_OFFS=0x500000
-CONFIG_SPL_FALCON_BOOT_MMCSD=y
-CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1000
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x800
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x800
-CONFIG_SPL_WATCHDOG=y
-CONFIG_SYS_PROMPT="i.MX6 Logic # "
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_SPL=y
-CONFIG_CMD_SPL_NAND_OFS=0x1500000
-CONFIG_CMD_SPL_WRITE_SIZE=0x00100000
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_MTD=y
-CONFIG_CMD_NAND_TRIMFFS=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_USB_SDP=y
-CONFIG_CMD_USB_MASS_STORAGE=y
-CONFIG_CMD_CACHE=y
-# CONFIG_CMD_LED is not set
-CONFIG_CMD_UUID=y
-CONFIG_CMD_PMIC=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=gpmi-nand"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=gpmi-nand:2m(spl),2m(uboot),1m(env),16m(kernel),1m(dtb),-(fs)"
-CONFIG_CMD_UBI=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_FAT=y
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FEC"
-CONFIG_ARP_TIMEOUT=200
-CONFIG_SPL_DM=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_BOUNCE_BUFFER=y
-CONFIG_PCF8575_GPIO=y
-CONFIG_LED=y
-CONFIG_LED_GPIO=y
-CONFIG_MISC=y
-CONFIG_I2C_EEPROM=y
-CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
-CONFIG_DM_MTD=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_SYS_NAND_USE_FLASH_BBT=y
-CONFIG_NAND_MXS=y
-CONFIG_NAND_MXS_DT=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0x200000
-CONFIG_FEC_MXC=y
-CONFIG_MII=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PINCTRL=y
-CONFIG_SPL_PINCTRL=y
-CONFIG_PINCTRL_IMX6=y
-CONFIG_DM_PMIC_PFUZE100=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_SERIAL=y
-CONFIG_MXC_UART=y
-CONFIG_USB=y
-# CONFIG_SPL_DM_USB is not set
-CONFIG_SPL_USB_HOST=y
-CONFIG_USB_GADGET=y
-CONFIG_SPL_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="FSL"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
-CONFIG_CI_UDC=y
-CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_SPL_USB_SDP_SUPPORT=y
diff --git a/include/configs/imx6_logic.h b/include/configs/imx6_logic.h
deleted file mode 100644
index 75997469cd9..00000000000
--- a/include/configs/imx6_logic.h
+++ /dev/null
@@ -1,121 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Logic PD, Inc.
- *
- * Configuration settings for the LogicPD i.MX6 SOM.
- */
-
-#ifndef __IMX6LOGIC_CONFIG_H
-#define __IMX6LOGIC_CONFIG_H
-
-#define CFG_MXC_UART_BASE   UART1_BASE
-#define CONSOLE_DEV            "ttymxc0"
-
-#include "mx6_common.h"
-
-/* MMC Configs */
-#define CFG_SYS_FSL_ESDHC_ADDR      0
-#define CFG_SYS_FSL_USDHC_NUM       2
-
-/* Ethernet Configs */
-#define CFG_FEC_MXC_PHYADDR         0
-
-#define CFG_EXTRA_ENV_SETTINGS \
-	"script=boot.scr\0" \
-	"image=zImage\0" \
-	"bootm_size=0x10000000\0" \
-	"fdt_addr_r=0x14000000\0" \
-	"ramdisk_addr_r=0x14080000\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"ramdisk_file=rootfs.cpio.uboot\0" \
-	"boot_fdt=try\0" \
-	"ip_dyn=yes\0" \
-	"console=" CONSOLE_DEV "\0" \
-	"mmcdev=1\0" \
-	"mmcpart=1\0" \
-	"finduuid=part uuid mmc ${mmcdev}:2 uuid\0" \
-	"nandroot=ubi0:rootfs rootfstype=ubifs\0" \
-	"mmcargs=setenv bootargs console=${console},${baudrate}" \
-	" root=PARTUUID=${uuid} rootwait rw ${mtdparts} ${optargs}\0" \
-	"nandargs=setenv bootargs console=${console},${baudrate}" \
-	" ubi.mtd=fs root=${nandroot} ${mtdparts} ${optargs}\0" \
-	"ramargs=setenv bootargs console=${console},${baudrate}" \
-	" root=/dev/ram rw ${mtdparts} ${optargs}\0"                    \
-	"loadbootscript=" \
-	"fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};\0" \
-	"bootscript=echo Running bootscript from mmc ...;" \
-	" source\0" \
-	"loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image};" \
-	" setenv kernelsize ${filesize}\0" \
-	"loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdt_file}\0" \
-	"loadramdisk=fatload mmc ${mmcdev}:${mmcpart} ${ramdisk_addr_r}" \
-	" ${ramdisk_file}; setenv ramdisksize ${filesize}\0" \
-	"mmcboot=echo Booting from mmc...; run finduuid; run mmcargs;" \
-	"run loadimage; run loadfdt; bootz ${loadaddr} - ${fdt_addr_r}\0" \
-	"mmcramboot=run ramargs; run loadimage;" \
-	" run loadfdt; run loadramdisk;" \
-	" bootz ${loadaddr} ${ramdisk_addr_r} ${fdt_addr_r}\0" \
-	"nandboot=echo Booting from nand ...; " \
-	" run nandargs;" \
-	" nand read ${loadaddr} kernel ${kernelsize};" \
-	" nand read ${fdt_addr_r} dtb;" \
-	" bootz ${loadaddr} - ${fdt_addr_r}\0" \
-	"nandramboot=echo Booting RAMdisk from nand ...; " \
-	" nand read ${ramdisk_addr_r} fs ${ramdisksize};" \
-	" nand read ${loadaddr} kernel ${kernelsize};" \
-	" nand read ${fdt_addr_r} dtb;" \
-	" run ramargs;" \
-	" bootz ${loadaddr} ${ramdisk_addr_r} ${fdt_addr_r}\0" \
-	"netargs=setenv bootargs console=${console},${baudrate} " \
-	"root=/dev/nfs" \
-	" ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp\0" \
-	"netboot=echo Booting from net ...; " \
-	"run netargs; " \
-	"if test ${ip_dyn} = yes; then " \
-		"setenv get_cmd dhcp; " \
-	"else " \
-		"setenv get_cmd tftp; " \
-	"fi; " \
-	"${get_cmd} ${image}; " \
-	"if test ${boot_fdt} = yes || test ${boot_fdt} = try; then " \
-		"if ${get_cmd} ${fdt_addr_r} ${fdt_file}; then " \
-			"bootz ${loadaddr} - ${fdt_addr_r}; " \
-		"else " \
-			"if test ${boot_fdt} = try; then " \
-				"bootz; " \
-				"else " \
-				"echo WARN: Cannot load the DT; " \
-			"fi; " \
-		"fi; " \
-	"else " \
-	       "bootz; " \
-	"fi;\0" \
-	"autoboot=mmc dev ${mmcdev};" \
-	"if mmc rescan; then " \
-		"if run loadbootscript; then " \
-			"run bootscript; " \
-		"else " \
-		"if run loadimage; then " \
-			"run mmcboot; " \
-		"else run netboot; " \
-		"fi; " \
-	"fi; " \
-	"else run netboot; fi"
-
-/* Physical Memory Map */
-#define PHYS_SDRAM                     MMDC0_ARB_BASE_ADDR
-#define CFG_SYS_SDRAM_BASE          PHYS_SDRAM
-#define CFG_SYS_INIT_RAM_ADDR       IRAM_BASE_ADDR
-#define CFG_SYS_INIT_RAM_SIZE       IRAM_SIZE
-
-/* Environment organization */
-
-/* NAND stuff */
-#define CFG_SYS_NAND_BASE           0x40000000
-#define CFG_SYS_NAND_U_BOOT_START	CONFIG_TEXT_BASE
-
-/* Falcon Mode */
-
-/* Falcon Mode - MMC support: args@1MB kernel@2MB */
-
-#endif                         /* __IMX6LOGIC_CONFIG_H */
-- 
2.53.0

