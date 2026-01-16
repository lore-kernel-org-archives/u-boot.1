Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E26C98302
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 22:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF1EE83966;
	Fri, 16 Jan 2026 23:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GSRbcVSS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5521B8309A; Fri, 16 Jan 2026 23:12:25 +0100 (CET)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15C3D8397D
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 23:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-64d00702990so415070a12.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 14:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768601542; x=1769206342; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R3kGISHdJS1cL36L4ZKDtU5qFE+feWqGQU+6IfReT/0=;
 b=GSRbcVSSVhQ8jvFNqFQU3IvljKbExClRyoZI5CcIKwhuLqCP5foMyFrUbGQtW6pF/N
 M4VJRS0G7UnBW7pEtpgBvJVa1F38tmporHHHRUkOZt0K8+vSqNaJpI/irevELDwaD/Ie
 iYbs3SWS9TfU3Um/cCsHNZi49W2qxCToIwxypY1pc3hjj5k5msP1VqPZ7+Ay0YdTInqF
 csEdgc3FRWAEFtxEhRQEXD8dHN6Taka15CjIUCnJIhIYPEx1m3z4tfrLfUnUOesRyUUL
 peN/hgU64YdpxKY4Tma6mX7ngqsHnRpAAmbSr3QrAjHR6ma+E//XqpsEmPGXfg4n4+6+
 8ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768601542; x=1769206342;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R3kGISHdJS1cL36L4ZKDtU5qFE+feWqGQU+6IfReT/0=;
 b=EQY2C2/NXUT0brxzyxm5CxzDYgKpaa+QV5zxPlnr7kqINDR+FCHtb5QaABePnlLMnr
 R4HYWW9zz0j6dpjd0kYKCrNW8B/KMt/c+DKpFBbuP17a1wd/jxtoY8FRrr7E1GKvZfP4
 lH/sVKsxThf0LwiFFeV2Kns5bTbrxuKDD5eD870kq6hEEyL7S8JQfY8zmO8QC0Ahq2Gb
 PabpLsplj9OnugdZ6gXtvdoU3sHreVn3Lnx0P+dr3rWDfgd3u7mTYiE4d4oKaTiMmBJp
 5LxpK/MNKBX0tJkzGewDFV04EmUpFURbnDi0FAvYAbDI/TdLhZA/mXbCr35V9LwD5cyO
 D3Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA+4PtbGLOd0SxHDb6sD1c0nECUN9Ny8a+esQj1QQm0yjBlMtu1YaWP/smRJKVoSCCE67Ce4Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yzd1OpBK2CdT4WGpPRiEHz13KmSSCfyn1dkKjwUFYS965mkD75Z
 VQf6ch81tE+3+UjGnnOY6xPOKG64HVC+88K/jv/VqzBn+4mYxRrNlmHWHIPHHmgk
X-Gm-Gg: AY/fxX48qWdxDQaTakPntqQ7Rrb50leSpvvl2vMSxhsnZ21wgBU9KMT0rfbwf8Ey+6C
 P37RzTn0QQIbLU8WMpChvlIaswx9ACmZnFOfv9XrPOFjo+MH18MzYKAhKTGn6AZZxClusC0hRPh
 SSLomBOWDVWZTzVTqBH2hb2AOX0YsYXtiNclA4U6GTDnki9btAIimzZfsJGpAWFjdr7k/0/gcnX
 vScXDyXpegocc3R3umq0oLD3LwtV9Q9aCmKyw8su+yjOI2+0x3oNk07EPmfbAZErXSN/+VrbATY
 Xjj4htTED8Mcj3aEzrhhKtALqH9OZghxK/2Cnq4jjdPku8gWEtrwwVSyy2plWj1Xu1oKk6mWtM5
 1vUIJ5F8969RqEbPq8KT4dr7VJOL2jEZbYjCrL8b2nbEkV8VRvwdPUVWtJQuq3QmVzVkrizHm8n
 Mwmvk4VrSAU7xRxG3PR29+XQG6gTjsRX1sc2XaSwot5Ft+/3rTRQ==
X-Received: by 2002:a05:6402:350d:b0:64b:aac8:4b9b with SMTP id
 4fb4d7f45d1cf-654529d21f9mr1977883a12.4.1768601542454; 
 Fri, 16 Jan 2026 14:12:22 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc543sm3361813a12.20.2026.01.16.14.12.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 14:12:21 -0800 (PST)
Message-ID: <31a98155-90cd-4896-9dad-002e6a53b4fa@gmail.com>
Date: Fri, 16 Jan 2026 23:12:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 3/6] ARM: dts: rockchip: move edp assigned-clocks to edp
 node on rk3288
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

The rk3288 power-controller node contains an assigned-clocks property
that conflicts with the bindings. From the git history it shows that they
wanted to assign the rk3288 EDP_24M clock input centrally before an edp
node was available. Move the edp assigned-clocks property to the edp node
to reduce dtbs_check output.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://patch.msgid.link/7d6fa223-ab90-4c44-9180-54df78467ea5@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 10712ce694a67304a99dbba20f8cb146ca5f4fd6 ]

(cherry picked from commit e1b4137b6bbc9998b13cde2eba0655cfdd358c69)
---
 dts/upstream/src/arm/rockchip/rk3288.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/dts/upstream/src/arm/rockchip/rk3288.dtsi b/dts/upstream/src/arm/rockchip/rk3288.dtsi
index 7e284b4fecdc..7477fc5da3ec 100644
--- a/dts/upstream/src/arm/rockchip/rk3288.dtsi
+++ b/dts/upstream/src/arm/rockchip/rk3288.dtsi
@@ -741,9 +741,6 @@
 			#address-cells = <1>;
 			#size-cells = <0>;

-			assigned-clocks = <&cru SCLK_EDP_24M>;
-			assigned-clock-parents = <&xin24m>;
-
 			/*
 			 * Note: Although SCLK_* are the working clocks
 			 * of device without including on the NOC, needed for
@@ -1193,6 +1190,8 @@
 		compatible = "rockchip,rk3288-dp";
 		reg = <0x0 0xff970000 0x0 0x4000>;
 		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+		assigned-clocks = <&cru SCLK_EDP_24M>;
+		assigned-clock-parents = <&xin24m>;
 		clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
 		clock-names = "dp", "pclk";
 		phys = <&edp_phy>;
--
2.39.5

