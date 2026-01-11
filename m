Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CC1D2502D
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 16:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E644183C5E;
	Sun, 11 Jan 2026 17:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LrgGJa18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B474583C51; Sun, 11 Jan 2026 17:30:42 +0100 (CET)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7214083C8C
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 17:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-b8718e54398so5537766b.0
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 08:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768149040; x=1768753840; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R3kGISHdJS1cL36L4ZKDtU5qFE+feWqGQU+6IfReT/0=;
 b=LrgGJa18tclTNETxNj9hOz3GwhX0m2RbouzBMATXJtuhrccBrD9xQhlV2bSL/j0QUM
 F5f+rsTh5h2EG6Zxz11MKI+bd+SbqCn3OvF4pQ7TaIAVxoLenU5a2rEU++ko6lGuxLj1
 DB7xh/vQvYs/SIiwqjRV3wVJB54IgVt9m2BEY0F6Zwa2oSOmUSlBAninN3Cs2CS6Sy6R
 jpEtKhQV2Og1V3M9pXLdD5VSppjM081tcDWLozEQANuUiSoOYycbpHa5vi/NG3X0Jc2r
 WXuu1KZOYKUpXoumVdgo1TjsnJVSv+970WI37sMKQUSRlpBhcwRlqexz3lRwyjH/Xmhd
 kfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768149040; x=1768753840;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R3kGISHdJS1cL36L4ZKDtU5qFE+feWqGQU+6IfReT/0=;
 b=iCB/aqeQLsTzI9DX9c9yc9Z7hZSGHxh5EGZCf2LMD8lUC6/wYE/15MiEUWe1FlUsWE
 QbJ45FC8OGIAgwAolZvwrJQ0fYkF9Mk+UvENHv5B7Xx6KAjg7eSSNvB642XOxzB3gWB8
 n2h9inEgdMegUibmWvTLUfBktjevwWl0/off1ykgL+YkLqFYm33nFzcNhfpkkGitSNC6
 hMgT+QsgtDk38PAo6gycYBK+soppYPiOIADaC8sYjkln1CdgeaX2QIbvsq6/zNsV5Mot
 TA+ylHj48kcjIblXsrdFGe3f5jA8TnWNi2E0JEq80JAUEQPN2modqIjbICZHXD0PY94R
 fC9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFcFz2NBYBGnOJcnB8Ih0sEja+w1QsjTTIPAr8OcTQA2LuJeBV7Ii2jg6ZbZrxuJL/czzTzBg=@lists.denx.de
X-Gm-Message-State: AOJu0YyA8CtivrKDLrltIHayIVqrxLOMBUXccVEE1AF9VXuy+QKrM6M2
 qwsGymQMhAOUWUf5VDN36aOlF/wznqEmC0wOdvrj2TkQvsUGIPBz3POk
X-Gm-Gg: AY/fxX7okAMJpY+6AlygI05vpHo6faG8xziqCOmXlkMElOFleN2bFUuzC/kvq3O31GW
 sX4o8B3pNXlw2NS4I6VGIF1aAfmNLf6U6wotCbIiJ+uFScPYAmGMdW8ilR+KPm8JQxkpeOR6637
 XOcHaEndceDm2kf+6n/Bjty9bYw0iGt339THsarbvru7dT/ZHq+05omjBZ8bvgbVHeCRNO1HiRG
 gDgzftNJb82zC9k2MjYD5XDz4AkjU26appDSKsIofsPQo6dmMmBTg+DdSTOhagpdzjhcYAaV5wT
 yNFpMrbXQrSjgBT+eoBpMEOaIUQqVH0w4E2PsESA20ClyBm0NnGpO5D3ixnlu6MftlwwwFD+Hhm
 A+DEEO3RMgKnFHxxHriO7ZmOmebhWS9F90QMKi+a1n48y+o8d/+YTgHd/Rhthnar6PkwQOs4B+S
 PY0Fnj5c1dohgjy8FYwz9TRCrfvnVE9hX736oA9pVKNEWOYbmjyA==
X-Google-Smtp-Source: AGHT+IEj2zTMtZetZFLLr2DJm4Fl5+Qj5ip4kl9W7o/jtiVZXkF7gBxY6b+txRArumHHi2FcceNpHA==
X-Received: by 2002:a17:906:ef0d:b0:b71:a627:3d9a with SMTP id
 a640c23a62f3a-b8444c99d74mr823949266b.0.1768149039688; 
 Sun, 11 Jan 2026 08:30:39 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b870bcd342bsm223160866b.56.2026.01.11.08.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 08:30:39 -0800 (PST)
Message-ID: <c3f50794-bd46-41c6-a224-96127007ecac@gmail.com>
Date: Sun, 11 Jan 2026 17:30:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 3/6] ARM: dts: rockchip: move edp assigned-clocks to edp
 node on rk3288
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <deeedc19-e992-44d4-ad77-2b9b2d891675@gmail.com>
Content-Language: en-US
In-Reply-To: <deeedc19-e992-44d4-ad77-2b9b2d891675@gmail.com>
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

