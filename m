Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F44C98302
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 22:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E9CD8367F;
	Fri, 16 Jan 2026 23:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QwFUnCYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 573AF8389A; Fri, 16 Jan 2026 23:11:58 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A2158309A
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 23:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64d00702990so415016a12.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 14:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768601515; x=1769206315; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LaRvfPD2Dsc8g8OPspV6udqL1/D0a3W3iQw2c7lVpvQ=;
 b=QwFUnCYrwy4XDdgkTTF/hv9A6+jpKUrDdmvOmAUxKrK58B1qNwkbChc9fnsbEIcELA
 fvZtib4caf7hHKMrLoFW8/1MrGuN90YM+e11zoDj8Y6VMLNLRt1f8C3Cd81XZmocY333
 tafE22YlURdhHa6wusRlwTHeH2QZKAeTNkgXmgOpObPRCdmhXYyzmH2X2GrxU/PDPPv8
 XKkaotSOo55a7oYDHFFaVCvYIwkh3jaBegsCG8OLJgT94VHZLexwuw65FnlGinlNuyWY
 sFX3/YqyvkK6cDvs3amKYoKg3qvLhKNDzSPM2D82LlEKHnIz5A1zxg5ZNpsbAcI8hIgo
 qGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768601515; x=1769206315;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LaRvfPD2Dsc8g8OPspV6udqL1/D0a3W3iQw2c7lVpvQ=;
 b=wnsjSWO46IDwWUhYDwP6oiKoVn0OH4q2xlD7IbHlLvmLGjUFsDDgTc5TNxm9cSZLc4
 CioRciLl9BNt/uuQQpmESQDm6Ip2Nzi1S8v9Jr1Nit611HrUsEqZ/dsB3D9B/3cMWQQt
 ae1MoiFVL5FA4BWZRsdpZt4TMXbKRmHeIpMkmVIyfQjNwuwi0gdPqTe5hoPowSw/HlXB
 JTdqrgKKoHfX1ziSpdhtTAdVTuGPi+1vKTYIHRbk16PqzTgmq5r4gszzSWG/VL1kTGKW
 ABKm5SEGLEZ10TOv/o/Ib5A1r/d0mbmlRNIOsi4JwI54TtQBCZ3dA4LKm+PLFz0VUyxj
 Vnkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeM8jIzAtvYg6qNyB/K5UZTNS3yVxAzCQ7eK9ocp4wBrvPNeASiHsfTAFMfbmu2TzIUyFdNj0=@lists.denx.de
X-Gm-Message-State: AOJu0YwMrIcp/BWopROlvnxM68VLm9pYsv9rdbVDOoBfpGgxo9QnHHYe
 uI9D3LnW81xbVj9rdrmipcEqZvwpzmlMSSWFfs4xOh3NDw7iuD8Qpiq+
X-Gm-Gg: AY/fxX6XhOmxJEeDLMxk1imlCU7ktRBs+IkqPeGjrFFsRV+WIbtcLxV2EOwFuBksmE6
 BBu0RHVJq8KZE0IJqprTLoV91e+Jgx43otUSIP7hM7nSuF3mE7SXB8uIB9f2Qm3TAueVpb6tkJe
 Vwi611V3Gc5SIqEdS4gxa/fvKHpQKeJcVmu5hbqUYGfJI5eKt3hPWgNixpuIubGOPCD1n01Hhpi
 EJEJWIvAPdYExyiQTp7O8/Q8pytlJRp3GYamFPCIizOvm1hmD6IeWusyi5SYatjTr3kZWXccL3K
 5ppbqpUaF7bvlhvdxYX4rKyvCJfjLVJ4qt83mHvRocHFUzX9HwBeg6XpheK1QbtZJjQZlVL1tO2
 HXH5tTcagqSVZKGNCFCrOgNKGqJkMj+BrbwuuSjmomIFhSAGWKN5pFT4YyNgyf9jcyVzHRfSIhf
 zfvX/AVcIuxhv4ZORKXk05O4KPvZmeoKy3b4juK199UN1C5d1wJidQEsyN5DAY
X-Received: by 2002:a05:6402:2551:b0:649:9fef:5b14 with SMTP id
 4fb4d7f45d1cf-654516f66bemr1874153a12.0.1768601515378; 
 Fri, 16 Jan 2026 14:11:55 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5d6sm3457367a12.22.2026.01.16.14.11.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 14:11:54 -0800 (PST)
Message-ID: <b1f8dbad-fcb2-467d-882f-25c8023ed9cb@gmail.com>
Date: Fri, 16 Jan 2026 23:11:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 1/6] ARM: dts: rockchip: Remove mshc aliases from RK3288
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <a6eba53c-a2db-44fc-9785-d817dbb4ef11@gmail.com>
Content-Language: en-US
In-Reply-To: <a6eba53c-a2db-44fc-9785-d817dbb4ef11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The use of mshc aliases is deprecated for some while,
so remove them from the rk3288.dtsi file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://patch.msgid.link/3e461bce-e8e6-48f1-a296-34040447ff25@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: cafaf99e4a790f8492a034a3470f878779c8c535 ]

(cherry picked from commit faefae4ca217961a0d96a54c9618e56aa8fd37b3)
---
 dts/upstream/src/arm/rockchip/rk3288.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/dts/upstream/src/arm/rockchip/rk3288.dtsi b/dts/upstream/src/arm/rockchip/rk3288.dtsi
index 42d705b544ec..7e284b4fecdc 100644
--- a/dts/upstream/src/arm/rockchip/rk3288.dtsi
+++ b/dts/upstream/src/arm/rockchip/rk3288.dtsi
@@ -34,10 +34,6 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
-		mshc0 = &emmc;
-		mshc1 = &sdmmc;
-		mshc2 = &sdio0;
-		mshc3 = &sdio1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
--
2.39.5

