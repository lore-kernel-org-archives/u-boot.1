Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67529C982E1
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3194E40F31;
	Sun, 20 Sep 2026 15:49:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k09zBF2IV3mo; Sun, 20 Sep 2026 15:49:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 79D1E40E32
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919381;
	b=Lg6Wc4fM74KmPXhqxIrfOzmAYOQ4RTmSdlrLVyQBT16pdbJ01zL0sAXeYg0TnJI0KOV2
	 hmT/3FS1YcwSDTVS87b6TqawDwehue6SfFrspSHNxNrVTKnao0/7UMgeqed/FWYxZWVuI
	 ZJsVgsFa+NV/OESRmLUj23twPEd23CBN9jdjy7+Gz2mp5gJw4ks8SzcHkefVuOev23yoc
	 nA5iuFw1yYd9sxykgbJthP5fVgzhjC7IDCLLvHxE50pS0e6ZItXYvA8qAL1WOhFfk7m0X
	 o/fPLhhIYKL7fHWNWKS7a3rOJzpXeDj+HwPJYhZ0mW0FokaEKBd2YjfA1g6HRgEbs1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eESfEEo10K0CkSwReixGksK4IR5FNjort52w/c+1wVE=;
	b=rAXur3dciEWShEcgQXWKAR0SMcO/z9z6oFe//lqANvxjNA8aqKPmCoZocWEi9XRAnSB5
	 UV6krNx6kKrXrnDzv347Rc95jan5iUgffLWAkJBKDPk3Na+RSwk4Dtai7uLh7abeRcrGC
	 2mXv4/MlyfpxysoIb91aWpo6fMiT90DgflCvUdiV7K4L58aL+Q68Vkj1RkJUuK2ppswRh
	 L2Vq/yNsvb03MXH6dDkphas2+Kh9hbw5/a8lYQdh+ABlD+6U2HGESLtuHLai2uhf/dsyW
	 uRsdAmkKaGLBm8NGby+hX6dAYyEgTHk/3ZAE5USUkiqzTHWGK3Oa+yseYMtisXJL2JA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919381;
	bh=eESfEEo10K0CkSwReixGksK4IR5FNjort52w/c+1wVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HldNT7PrCIV0G3444rHj3kWbSrD3kg6ijBa5gfBn0HG9+quY5U91iYtqIEcxFN6Yo
	 28/lXwqb+iJ1/3jK4GfupFlwsIo+JRDRaMkhBcPeJBXUYUueEw/qiUELpe68g9lilS
	 2JUOK+6SM24kB3irzMnRKpPs1MhEWUQ7RRncniVipSpEF1XdMbLH7UxID0UHXMxZ7T
	 zKIlb4rEOq6UVXGTZjHMBXyJtRSXpGTU5eSJafH/OV+AsW2LF/PpXrgf3eZmzzu21n
	 BITAe9S61QLxWAz5GVDS7XPO5ii2ao1ZxSxaCrXdecD4y6NLbMplZAvZaBgYN0t+XO
	 GDvEKvNMxTsZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79D1E40E32;
	Sun, 20 Sep 2026 15:49:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A28F324D
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88C17400D1
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WsrvS2Uc5_CL for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 14:16:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A4FF440022
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789913799;
 b=qSmpvvtXCbXYIIkVZgg3OFInnubfcuI47GurgUWmlvAZb5agfcfBC+4ZKI/FIPn7UCGm
 wzBOzMyBjzmFmSCE7UCbQRq8gH6Of6pdFGbsrWGVqYzuF3oBLO4Y6h2yOmWE852vgk+te
 5exHslFKw4crDZUtlTwOpD1mVJpZE1BzbVH86a0TQlBUEbOlrtLkm9SnHcMk+eskSW4yt
 mkoVKXJMFfYWOw1MXzqvRHzn4UP64ubczEpcSRNWo4AqF2zSNx0gHGIMdFlH9ZlmLQLOB
 QWNJ7PoF3rGZQu01iDKPvvrATGVSFxZF2c/07Dpxf2Wpq9b8XjntJkbMr+zBY6bPLFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789913799;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=eESfEEo10K0CkSwReixGksK4IR5FNjort52w/c+1wVE=;
 b=Z0+nsuBvpWmO8leHRSHXkxwQWf3TSjPsMJEDCguLGi19n0Mfe8KL+LLkk1uHOvMV5xly
 f0+0uyq4c9DX85dToc+XqaZZYqa1lr+xXKhcHN8IuJ8Nl36iCxgTf02oh1rhI+OTrO1+L
 9yx+uWJ8d3Mxx+n4yWmcidwvOrwGarAh2fVM9N3Tt5+AXOtK95BBMGDyay4elO6oVHZgD
 Z7RMCkGqKEPZJZn7HlCnoRp1gHmLVmYOBKISweRxoH4se70TpRwW5akCrQof/SSZ6Nm7L
 cpIlwEtefxt6z4DP67TlZOvb1V645Xjs6xAh/7z3FlttVlBSPjhkgjT/8gIaL8gpo9Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fpy9DygF; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fpy9DygF
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4FF440022
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:37 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e83a388f8so13264055e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789913796; x=1790518596;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eESfEEo10K0CkSwReixGksK4IR5FNjort52w/c+1wVE=;
 b=fpy9DygFhw3YOx6Xhyc2+Z7ta2CrzHrRVcy1qSUjMEtSoqQ1stLE8KiO0ApmtATNWg
 jJe/kWikZgXEcW36YNFhRAB06uRBE+Nx0aPWPiqBAPydD9Nm8oz3S1rrerykBqxHCLbp
 G2oZY0pIWhVWAGYgANHgHGB79LxQKHRVX0xr4ilc/3vbIxk5FWFmNQeJ3zqXsO+OnaJH
 xjNl4SEbHhqhW6DHCUHwqJ7ZP+qy5w5GdD2AL53zflov3UOg90xcjOVbGKxNuX7P117o
 xOMjUcmaTiiglmvd8kdZL87VloV5FHxEz/BJIoazCANKIQoG3btNcxMh844BQdVj/UTO
 dM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789913796; x=1790518596;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eESfEEo10K0CkSwReixGksK4IR5FNjort52w/c+1wVE=;
 b=LFyIF6NmArUxlXvJ2Y6wAbY8wpB8jlQ6A/GrJKBvAMPelS8BezZlbYIrT2j6tJsg+E
 oU6rKcmADS1DYWiSdmfLqhvjYEog2NG9jXpXO+lhIajVgv6MwATTJtMW+YfUq24/tiZ1
 ngY1ugB4jQymDRq9N8T3O8uxmbHNG3tRhmS3kL+CMhAs4as8U/z6hfP1P8mEMoGECowa
 a+MWaN2VRdREcs2ZqmPc5mWdR2pa+KJr06ZscxOaT5Te7+M2651fZtWhmeafKtS5o6BF
 dXdyOY1HvvAiefFvUzBAlAd5oZ+nj50wHDXE0cfKjMb2UDeYwVu3DXvbHXj4V9DM1c9u
 bppg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfv9azvlLLBKdZqo++y3LPwj6dM6SgaLRU/ki3S+4LKZ7i5KTm0anzcMjdAiJ6GOaG75dG888=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kxM5Gkum8KMiNSvOvYMMbachEYeISxOrmFWCsmh87T6LmPtJy5
 QExhosQtjYO2QEARlKCfRa38jDyCTDTVnZxQUhCAq5YNfWM8KCL3lNOw
X-Gm-Gg: AYBFou2K4xddjKsbpgUfKnhVSz7L/QkaUW141kf5buFDux+Y5l2tt9YxtUenTrWQhfS
 U0s/av5y00mI0JYCjdFLkqbsSKa9pm9WOJOh013iZuWQvEGvfHH9Wh+iXWTfRg5CRKefwfs5t3q
 cIWxRN86BvRK0ahiWUldVp0xzxxBi0zKWBpZ+riRw8YHorsleyt+IXPjLp88jh9LtfDWNKVAiur
 Dx/VJ7YB8iu8J5nd+owAf3Y6h83bjlt8PLnbdUCnJARMyk1o7CBRjfpraDfoHpeBVCN54eeii9F
 8unRs59SAfQhJ6Ob1f0FJSbMMSVhI2Eoi9Tn1o/Vrbu/sM2CM92QPPLJFCDJ1khoXhpl8yUEYe7
 icuAf1vWprtJ3DppxvYslsz8X7HGSMOyg9mLUSI3bc2qSQcfOl/QQq5mvDiGyzrpzMdIDxDZ1d7
 UmgxIfb+ltR/Fen74nw0p7ZcBirK+TSoCW6GqudGcpRFCDeJ+eXnJQBqWRsFQS88OC/DTa/pQNk
 JvbYtEQ
X-Received: by 2002:a05:600c:354e:b0:49f:bd3c:bc1d with SMTP id
 5b1f17b1804b1-49fc573a7famr106755945e9.24.1789913795335; 
 Sun, 20 Sep 2026 07:16:35 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.151.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm184107005e9.3.2026.09.20.07.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 07:16:34 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 20 Sep 2026 16:15:53 +0200
Subject: [PATCH RFC 09/11] arm: rockchip: do not print SoC info with
 DISPLAY_BOARDINFO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-reset-v1-9-42820216369f@gmail.com>
References: <20260920-reset-v1-0-42820216369f@gmail.com>
In-Reply-To: <20260920-reset-v1-0-42820216369f@gmail.com>
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Levin Du <djw@t-chip.com.cn>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Alexey Charkov <alchark@flipper.net>, Fabio Estevam <festevam@nabladev.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Chris Morgan <macromorgan@hotmail.com>, 
 Coia Prant <coiaprant@gmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>, Andy Yan <andyshrk@163.com>, 
 Liangbin Lian <jjm2473@gmail.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Tianling Shen <cnsztl@gmail.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jiehui He <jiehui.he@foxmail.com>, 
 John Clark <inindev@gmail.com>, Sebastian Kropatsch <seb-dev@mail.de>, 
 Jagan Teki <jagan@edgeble.ai>, Ilya Katsnelson <me@0upti.me>, 
 Niu Zhihong <zhihong@nzhnb.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Akash Gajjar <gajjar04akash@gmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Eugen Hristev <ehristev@kernel.org>, 
 Jianfeng Liu <liujianfeng1994@gmail.com>, 
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, 
 Martin Herren <sputnik@on-the-web.ch>, Torsten Duwe <duwe@lst.de>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:49:13 +0000
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

Discard checkboard() implementation in Rockchip mach: DISPLAY_CPUINFO
prints SoC info; therefore, having DISPLAY_BOARDINFO(_LATE) to print it
too, as an alternative, seems redundant and misleading. Moreover, it
seems preferable not to implement checkboard() at mach level, leaving
the overriding available for board level implementation if needed. BTW
this is the approach taken by most of the other mach.

Side effect: Rockchip board configurations related to PX30 RK3308 or
any RK35xx having DISPLAY_BOARDINFO(_LATE) option selected but not
DISPLAY_CPUINFO one, must select the latter too to keep printing
SoC info.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-rockchip/cpu-info.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 79ea3e17185..616cd45c6bf 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -15,15 +15,6 @@ __weak int rockchip_print_soc(void)
 	return -ENOTSUPP;
 }
 
-int checkboard(void)
-{
-	/* Print SOC only if not already printed by CPUINFO */
-	if (!IS_ENABLED(CONFIG_DISPLAY_CPUINFO))
-		rockchip_print_soc();
-
-	return 0;
-}
-
 __weak enum rockchip_rst_cause rockchip_get_reset_cause(void)
 {
 	return RST_CAUSE_UNAVAILABLE;

-- 
2.34.1

