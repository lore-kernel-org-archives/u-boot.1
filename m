Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02381CF8552
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 08:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094BA84082;
	Thu, 20 Nov 2025 09:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gvf008vf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F194083D3C; Thu, 20 Nov 2025 09:13:09 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1D9B8405C
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 09:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42b38de7940so252577f8f.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 00:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763626386; x=1764231186; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lpjdtNLUSa5Nf+Kcn+8HYzrzuL7NL/okw9MxRgAme94=;
 b=Gvf008vfQWZk8lHhiFYtK0rrhC2i/t/K8vafDs5g6e6up2GHOirgqrl3jCx1+IVPfg
 pKjs3zg0izcIrCWdSESSfTN5tAWblU/rpOOhI6u8M2Zkmi7IhgK5KFfrU8ri+KLzKf8J
 FpCZMcmmPDK2y3oLBpgIxZK4CCDNCUC4j4XHf3ang0GsiJG2qpw+dE3+Wkr6xAVpIzCP
 U6suZwodwxFhFQJV6G4OO3ftNtGq225e3dFvcD/Ymdlv43hAA0TkYs1624jDE/i1i4Sy
 WG1NhQbFt0iEtKrHkI9QoEC3/zDymHk1XdYA1pBpdjw/kSr5E+cm+3A4ChSlh8dGaedI
 10lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763626386; x=1764231186;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lpjdtNLUSa5Nf+Kcn+8HYzrzuL7NL/okw9MxRgAme94=;
 b=fflAAbWIFvFjqh2uoRoOxw1islYo2+9qlyp1gixASzwaWa82fh8xUQLwIbpD3aQ2hi
 1aa07EqY07f340bbSB+MWF2Fy5IiAJxH3kX5ltiPXaMgMV+uiviV5/TIuSxvuBwP1FGg
 p7u019CId4bzvs8LufA7dHdHgtXRxlX8bExuXI3IHPRTt7PED1ym8Pp9cEpITftLwsAE
 CaU/RcjDWggksJ7qhwdDIrzo7cqtc9YUu7KVW9XyGXV13CdugrBN+r5xUUXixZoM4H4J
 o37/sryQulH7+QJt0IUrlHSGDkkOYhlCExvb1jJ7V2d8egaPBzVzobdQA+VKixnfEy27
 HGfA==
X-Gm-Message-State: AOJu0YxYdatd2XFktTrqpYGWGXnkKTfopEvubZ/v8q80SQGnbVzGgUAk
 yhCzmv9oMqTMTmFU+2Gs+lrZOI/SOY9BYlVxjv4qeTZqwoOWmjBbS8HhcN6ZjKv/UsA=
X-Gm-Gg: ASbGncsmCZUbpIeQVRT/iypHYpLT2ibcCXq4auDG4GERe2xTYT9R4QEnVEpayHU08rk
 /wDDL3DKuE4U6CGJ2oDmwOm1E7gkMpyhue16cszFY6hmNKOA56kYeB7/xLvlRUuYzP06PpUa+qx
 AY+KtNhBBARsp4qfBGPEtThcpZu4lbIocJSP7VGGsIroGPcv/bV5CLxDMklGMAbaNUvoHQIuHvr
 s0Vdd/X2gYps9MIWj8w5YrJyUwbbaOeuNtNeBorGHWcflJkiU46rfw0N9DpKIpBm45A23P3gCvj
 gNli0c0WktPMPDVxQvK76zURKcLMAAZct8KOgIi9B20kEe3Xba6mVdOSwU7NQp/ikTAHJCFQuoy
 L9QSl22GE7SW5wiOGkDpV3RZHa0LgSQNodZU/O9S0aPCiAWikYHsZRSLUkzLaUjwJlq+LJ1rD3e
 YoBKJS+4BLgYiYRCWUdzo0yM4jXoj+Rnk=
X-Google-Smtp-Source: AGHT+IFlX4T/dO9kB+MMZHcTVylMQUj8iVO8InmNDNEHFF0q9yYMQ1LY54xU7Pmnj+hE3V6K7ZesVQ==
X-Received: by 2002:a05:6000:22c9:b0:42b:39fb:e88f with SMTP id
 ffacd0b85a97d-42cb9a24b81mr1603309f8f.23.1763626385817; 
 Thu, 20 Nov 2025 00:13:05 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363c0sm3844398f8f.18.2025.11.20.00.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 00:13:05 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Nov 2025 09:12:54 +0100
Subject: [PATCH v5 3/7] MAINTAINERS: add myself as Maintainer of the
 Generic System Interconnect Subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-interconnect-next-v5-3-e8a82720da5d@linaro.org>
References: <20251120-topic-interconnect-next-v5-0-e8a82720da5d@linaro.org>
In-Reply-To: <20251120-topic-interconnect-next-v5-0-e8a82720da5d@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Anurag Dutta <a-dutta@ti.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Alexander Graf <agraf@csgraf.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, Sam Day <me@samcday.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Sajna <sajattack@postmarketos.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=779;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1RdedE6XE26avL82nV+Uo3NgmI80qP79UxBANUrPB6U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpHs2Ihogbmdxb6lXLZe/vFTXTzCovsaF9BU+76r1+
 c9LNiwCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaR7NiAAKCRB33NvayMhJ0ZQ1EA
 ChbKeq68AXiimKRdtcnwYgdYQfz7HcHlNcUXTwQzOw7DppcsyTXOY+JrM4kUpk1xEbb5CW1/oyKXU+
 ipathKnJ8urJydsf9tKh1PPGorSL4mMScOvlU5Me0tJ8fZKv8vHZGOUsr6XIYrYNB/fg1wVnp5WGMO
 NWQQRZCBArJZsr2K7el9NCkRqvsPtdkQ4mac85LcQyNFRgskgqw416q7AWMbkjhgwh37DTfQzWXr6G
 6LgclxmE/br8ABQ64d/1sdmMvsuz7+6MA+a8grejjxXgElwwL9sKBxbMRvPmbZNEus+dEtgZyI5e1L
 dhnX3KurxRvQucVqI2o4q6web6LeTJgjh16TqcoZNBalY1SFQjzp4zZKuXS9BGfDAzXWnKbyXU83GN
 tP29/41O9rlMiKe4AU3M7QnE4ogvmvjpCHPEYL1Dr0oo4/7H5CbJTxvJUsbh+sIDe5ymJ2Nkgyq4B4
 K54TkA4mCTWkjB0OjL+Gn8TFbu8GOaAUsCS59IlxKpHfus7gc4XBdI1kNS8jnLUXqRt9Urr312PQqc
 H71aCWUadyjAGxdWZTPOBt0bEGnEFd/HCiay3hy9n/kImIfCo4sALv8hlD37i1qoHIavX3BoYiC85Z
 ZvYqF31Yy4XmfOPNH9mwzgXV9aYNQ8R7qL1v8o87mpdn8bb2fvoYqqxSZklA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Approved-At: Thu, 20 Nov 2025 09:14:18 +0100
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

I'll maintain the Interconnect subsystem.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60772a494a3..c0c5717f45d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1259,6 +1259,17 @@ S:	Maintained
 F:	drivers/misc/gsc.c
 F:	include/gsc.h
 
+INTERCONNECT:
+M:	Neil Armstrong <neil.armstrong@linaro.org>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/u-boot.git
+F:	arch/sandbox/include/asm/interconnect.h
+F:	doc/api/interconnect.rst
+F:	drivers/interconnect/
+F:	include/interconnect-uclass.h
+F:	include/interconnect.h
+F:	test/dm/interconnect.c
+
 I2C
 M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained

-- 
2.34.1

