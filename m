Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65EFC83F26
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 00:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BB5F83700;
	Fri, 25 Jul 2025 02:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R5x0x+GB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC5C583927; Thu, 24 Jul 2025 23:30:35 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C158391A
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2ffa81b41d7so784556fac.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753392632; x=1753997432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPxVMYbbKVbjD1LnqDvMp6mdQbbSwvqoiCWolQ08/gE=;
 b=R5x0x+GBjwvH0Yjdnh6IM4ivGoEfrzDChTdYCjn42+XZxxu2XBrwL3NCRkZrFit1cq
 5YD2c/lCsib/85G3E1TDpc5g9sHv7u8mIWDSnbG+6g65BUHmWMbBTC0s8XCTF+CncUEL
 8Nxf9deGd1auEJiwIiVk4jZArT0/VikiiD+6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753392632; x=1753997432;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZPxVMYbbKVbjD1LnqDvMp6mdQbbSwvqoiCWolQ08/gE=;
 b=dqsdv1UJUdhvJBxktj8XPdQ+Vm21Kgih72ejOzZ6jysYt3yfaHaNFcHF/f7ooO6ZUd
 DCOL6TryOopEfB0hw4+6aEn4FuIYaE8GFolb06pxu22MOl5wrHtSV3oTqXHN0yAUI3Fn
 BbdBPZX2ca5r97/tHosxkuwqjWs4QRN+TNaZWS5LgJVB8aaBtV+FUvUx3Q/+rn4zHqvK
 TLvsVEFhusdCugPtQAXoQZ27Xxi+DU50jFj4E022ESo9DfrqvHCmHL33zIK1ybHF7e04
 mc4bU8Q6FLbdbWkJc/JXhgJziE01sGL+kRAMk927hhzhfhvtyMUquCmTBws8/26llkAH
 xDhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhBev2S8D4WeL7kfDH82Nh4ierm4ShN0RBeeyRmFcAPYt9ItL2wj7GUD58Us14m+KV2zn9erY=@lists.denx.de
X-Gm-Message-State: AOJu0YygVRUv+kSSMYNAbYkFWzLaIMJQNUsRivJXI9kS3L40uaDO6VlU
 K3t9xtOYVChfEdSKckOY85Fj4c4DuiaHDSRhm2L0LLKtClbJL3eOen9ldW9xq8tSCis=
X-Gm-Gg: ASbGncta4GIJwtsNKD5gZA9Ps0LvWZYzIa3qUbgkqNKF0M6eygCDC1HN/f2BvY8ML7m
 5Fpz+9BARiNrnzVTHgzluUg2iCKneSDzJFnv9/hEZK5xsdxjbr21e4HJRcdOoTuH9EtCC4ii2kZ
 j7687cSCcfcZIgaC7Y3j3c7gBuaadZx28hC6oqtQbsPEkrIrlAHax2GkH97M7TvJz3xDguAUx59
 IlBRMUNqJrESHg4kJiilTPaxoDgAl4KkamIr3AMgL49XmyGpWCXEYE3cELm200kUSZQno08/ymT
 edhYDiLZ5aZDtNmQxOPTO2t5jVlWRKy9Ps6bm2eqW+q0gWzT5VTM9ibopUFtes8H+BGRivdKoV7
 f2tcnsBY9S/LaklSJ0PO5bj07LxmB6kVLyy/lIQmqqkIpr9z5+S5spcE=
X-Google-Smtp-Source: AGHT+IG0FY2EDvYGbb64jrHdiWUQWKS88Y8wn2wbX8Iy1WYMr5QZ7j5xiKwzKDoUxQj8GpweL8iRng==
X-Received: by 2002:a05:6870:6f0c:b0:303:5cb:4296 with SMTP id
 586e51a60fabf-306c728975emr6224526fac.30.1753392632210; 
 Thu, 24 Jul 2025 14:30:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-306e1f8a7adsm660520fac.42.2025.07.24.14.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 14:30:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Aaron Williams <awilliams@marvell.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Ben Horgan <ben.horgan@arm.com>, Adam Ford <aford173@gmail.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Sergey Temerkhanov <s.temerkhanov@gmail.com>, Marek Vasut <marex@denx.de>, 
 Gilles Talis <gilles.talis@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Eric Nelson <eric@nelint.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Michael Walle <michael@walle.cc>, Sam Shih <sam.shih@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Fabien Parent <fparent@baylibre.com>, 
 Stanley Chu <yschu@nuvoton.com>, Jim Liu <JJLIU0@nuvoton.com>, 
 Tianrui Wei <tianrui-wei@outlook.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Wadim Egorov <w.egorov@phytec.de>, 
 liuhao <liuhao@phytium.com.cn>, shuyiqi <shuyiqi@phytium.com.cn>, 
 lixinde <lixinde@phytium.com.cn>, 
 weichangzheng <weichangzheng@phytium.com.cn>, 
 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>, 
 Paul Barker <paul@pbarker.dev>, Simon Glass <sjg@chromium.org>, 
 Mario Six <mario.six@gdsys.cc>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Sean Anderson <seanga2@gmail.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Kamil Lulko <kamil.lulko@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dillon Min <dillon.minfei@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Apurva Nandan <a-nandan@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20250717024426.26953-1-semen.protsenko@linaro.org>
References: <20250717024426.26953-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH] treewide: Remove empty board_init() function from all
 boards
Message-Id: <175339262777.1899261.14751318047956466864.b4-ty@konsulko.com>
Date: Thu, 24 Jul 2025 15:30:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Fri, 25 Jul 2025 02:27:04 +0200
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

On Wed, 16 Jul 2025 21:44:26 -0500, Sam Protsenko wrote:

> Commit 86acdce2ba88 ("common: add config for board_init() call")
> introduced CONFIG_BOARD_INIT option. This option can be disabled for the
> boards where board_init() function is not needed. Remove empty
> board_init() calls for all boards where it's possible, and disable
> CONFIG_BOARD_INIT in all related defconfigs.
> 
> This cleanup was made semi-automatically using these scripts: [1].
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] treewide: Remove empty board_init() function from all boards
      commit: 70a4d1fa1ddb2f5f8f9a27442563f182549abbb5
-- 
Tom


