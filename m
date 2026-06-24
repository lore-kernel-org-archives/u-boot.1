Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E906BCDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 15:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B4A88460E;
	Wed, 24 Jun 2026 17:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Mn8apXCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2432184671; Wed, 24 Jun 2026 17:28:31 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D00DC80398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 17:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-48b7df4b4ccso1288659b6e.0
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782314907; x=1782919707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=en4i/KtqDpWswHqrZ+f8n+OGkjhnEAe0qZhPlur3grY=;
 b=Mn8apXCzevbQhYP82ntpX9LCcx8ZQk7hbk9NdzmgqkCWPBlPwbWK2Ae9bQE4Z1leir
 3T1/GEY/ybIQRRGJdLQZR4TdUkAXeXBkjP/ZSlsfs0o5I6lRtj6rAhaeEjMqC/YFUuKi
 2Qrvrfbs29Nz4xrR/qjv87jtNh76calTZcgQtBDtkmeHCG8/ED1LiZsMNUj81gY5yNcY
 Pa3XuM0Zu0Y6kUSgn3E/M+d8cY0XXzPnHp7Mz4/DA5d3rFm2CIBy5y87dg+QjrQIDUVX
 IIAg8kf/w8ublcq3XkUbzreQAMxbAa7g2kBC6OLv6Piru/lRXKT6NuquNNPZU10Hp1/4
 yijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782314907; x=1782919707;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=en4i/KtqDpWswHqrZ+f8n+OGkjhnEAe0qZhPlur3grY=;
 b=VrzSZ3Sa38ehJYgSw9P2IYB4qe/RDISYfgNB2LeSR9LoYkpSBMcGzfupxXjlp+Zv8A
 0PZdQo3WkKrsUZpTLGFrICfG1PNor/8xu2f7beZ4ICpGiS1Xci+hGBtv4s2hQ2WBX8L/
 ChxK8Y3pvS30k1vw3gyR837cH42uSKxJzG487XZtA4Baxq90Oiptb7RtZKq4q4xIr+aq
 cGjRTcD9yc9+efYdClNcY37Sk7dPOdu7jJmf7lXz+UIJCGzHqA2FJ5DkBVa6g/TFTAWQ
 Sa8baGXZAgnNF7K7/M4iY6H6VCCMB6Zxx66rIUvuhukFGf/lsJt17n0xTIJP9QiK24sx
 LuAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CF3hVfPGxPwQ7SlyEh7GkMwSwMrbNPdwu/cFqRqQBxpPtrP+6cGI3PN1MSibFlvazpmiZgPI=@lists.denx.de
X-Gm-Message-State: AOJu0YxZ/uAovEfCpu2+Gm82/mUkEghwLbvw6UPYwaxrTFJJOh4GW2Yz
 p4B90GxAHnjxEUOoNDgd1XK0Zab271d6ua932sHWimqUKsFhrtU3PuCf5u7zDuQFhR8=
X-Gm-Gg: AfdE7cnv0cACZjC9QZkkGfthB7lRGdZ2/U0S21G3zbvJaWC6AmEXsHS8GC9ZGDa/HPE
 CZxi3ijbOt4OD7uvuYCEGmo4l4+3mdw7JuEGI3NFGAzpjV94w8NW1efyBTGBaCSoYqIm9DuE6DW
 3rRmW+eaIMoLEsjdmNjxqR2LDz111VuR3xxZ3qFdFtMcUt7WHWrG7LorVo5K3UzFm66d42lsuRA
 /lPtD39T95bD5RyB8mspF/HewdDMvto1HwYgEKFxyR4kWTMqRXyTosMvCsATOFTzcGFGi6YoNIq
 zJFuKKgyJrVRzl7SVhMgK4T9CUzZJGnCzuJAutoqP00Fjd1hDPxQKloXZ6my9Z580sdsYbmEIFn
 6bpPI60LJKCaePTyY8LQFkS2ryeRGcB/s7SCPau8bsmIJY91LTgO56740JL1GDmtJxPqEhjxOuQ
 herL4hkh9yiLeGddBCqw==
X-Received: by 2002:a05:6808:6602:b0:479:fca7:4650 with SMTP id
 5614622812f47-48ee556c405mr5084647b6e.31.1782314907519; 
 Wed, 24 Jun 2026 08:28:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:68dc:b788:b3ac:e34e])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48aee43c088sm8985730b6e.14.2026.06.24.08.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 08:28:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Rudy Andram <rmandrad@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260615-mtk-fix-ram-size-v2-0-f72cfc52ce58@baylibre.com>
References: <20260615-mtk-fix-ram-size-v2-0-f72cfc52ce58@baylibre.com>
Subject: Re: [PATCH v2 0/8] arm: mediatek: fix gd->bd->bi_dram[0].size
Message-Id: <178231489670.3619522.4421316885006430352.b4-ty@b4>
Date: Wed, 24 Jun 2026 10:28:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1668; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=to1+/LyAurQczwAyWAGF40SF5j5b6mzCd6ZJ1FxI7fk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqO/eTq+CnZ3l+Cf4uU9aygtZVfygDbhnA5xptx
 zAyk2iYaiWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajv3kxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6pUH/0bD/aOFFUC4LR1KxjVlq6weLGYf6iBUOJdzzJB
 bO+36Y1j2ooH/U481SKZhw/z24y/pmBjBPNQpfhoJ4mhWDuYUDXi13Mrz60R+dh5DF61K3NEXPL
 EQ1st5atGRi5li7m9DFNP/YIr6DGOsX5Dznrl+LLKuCYacwMR/dTGbRvxHEfaI34J8Er8seV1Wo
 TNIfell7QAjK/1pegPh7HRcR2cM9sn5Nh2ng7J2YjFfAtShwwXGHgiNJ3AgCZ8Pdo4XJoM3OYQ4
 fCpXbeFezvKfQ87m5DNTNkOSEn/AFw4Yryj/20Yhe1elcDFgrqSPxSSOqUT4csXrQrQRt09Suy7
 J2WI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Mon, 15 Jun 2026 14:23:30 -0500, David Lechner wrote:
> arm: mediatek: fix gd->bd->bi_dram[0].size
> 
> During some recent cleanups we made some changes that had an unintended
> consequence of changing the value of gd->bd->bi_dram[0].size on some
> boards.
> 
> 64-bit Mediatek ARM SoCs have some peripherals that require DMA memory
> to be allocated below the 4GB boundary. We were using
> get_effective_memsize() to work around this. However, this also sets
> gd->bd->bi_dram[0].size to the value of get_effective_memsize(). This
> variable can be used for other things, so needs to be set to the actual
> size of the DRAM.
> 
> [...]

Applied to mediatek-for-master, thanks!

[1/8] mmc: mtk-sd: select LMB_LIMIT_DMA_BELOW_RAM_TOP
      commit: ae73cc6df7246b80ebc3c602da952e13fa72f2f7
[2/8] net: mtk_eth: select LMB_LIMIT_DMA_BELOW_RAM_TOP
      commit: 2d9a9f1cad906bbc13e8c131ed6932d0da4e28ee
[3/8] arm: mediatek: mt7987: fix gd->bd->bi_dram[0].size
      commit: c074950b489957931296bc1efdb5e19f6f64e9a5
[4/8] arm: mediatek: mt7988: fix gd->bd->bi_dram[0].size
      commit: 3b7adad0b5223422d9993e08faa9c879c023742d
[5/8] arm: mediatek: mt8188: fix gd->bd->bi_dram[0].size
      commit: 6f274732f7960319ea0337e34210d440753ff11e
[6/8] arm: mediatek: mt8189: fix gd->bd->bi_dram[0].size
      commit: 58c7145d687a6442c077b0ed0a8c57012de347af
[7/8] arm: mediatek: mt8195: fix gd->bd->bi_dram[0].size
      commit: ec457f7cfde59a2122297a7a217c88f02acc63a5
[8/8] arm: mediatek: mt8512: fix gd->bd->bi_dram[0].size
      commit: b4fa246a1565aa63375de06b732c6d1eb1f82d27

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

