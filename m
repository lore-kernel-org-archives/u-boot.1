Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF84CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 08:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3870E40602;
	Tue, 29 Sep 2026 08:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WvSjrVaetk_A; Tue, 29 Sep 2026 08:50:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 903F640619
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790671842;
	b=M/5eQRioe5cKiKWrpGQFJY7NM/dI5B+oYVyrPpsLBiEs4WD55cY+0kSGpfXdJKSWQmxO
	 ehzbMYFoMro6lC1Q6OXMYxjWSKoJG9jsOYRcli9eDF/onL+tb6EmKYcicxQYKNt01g4eB
	 LhRBmdqf+09g1kpWqy1LzUJfkqBtXaLgfpcqQ7nSbS5lVx6XXKZita/7hCltkfbFbPHjz
	 8IvgY1hk9vX/wHS2zNbAfz9xgXzohqQj+l6v9SO5UZC+AfOmBvuayW9c0qSrvOUq979+J
	 ATa5LCP2eOX3h9wItdWGL8nJnqcR1G9FZJcS4CRVUnUfm87j247nuwkfGk/KPntxxxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790671842;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EF3pmwzlyKaNwW4h/2asa3O/GOx+YNQokbL4EH9dXJA=;
	b=Bt8ob6WYx1BIPXP6f946Qr7Q1VJf6yKKqBG05Q4mvDniM7Hn4rBcx+nMtZuB8/aqrH/y
	 JzMm5zuZFw6zRUkuWRiZ1T0zXQUP0T7ZM1526ytRDW8hgt5lmHfs6H8mB+FMLbwlVYyr2
	 YAqNe1wohTgy9kJA7c0WjuH+MF61V0walzIByMWI4FxQQfo++Z+VZ/V9psBozoHCKCf+6
	 oju38fFCCu4RB7LxrUsJVQ3e1dJsnj40k33/VhhabAHA8caP9YbUMviBsEbOYHMJyiN5X
	 dWFmBiGRw9oMvoTKecLq9wM8F8s4lznvmSOHUPqvg/VhXk0yFedP3F4DIBEpRMACgBg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790671842;
	bh=EF3pmwzlyKaNwW4h/2asa3O/GOx+YNQokbL4EH9dXJA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=V8v2yWgW2WTL2KrP0vnoRv9oo48VZBJDQ6zTpRBPiyIub2+KNqg+aSYSG9P0MIGB+
	 ZYhoUZm8U8c6OMBwLBa5JKglXBCeaQtQBGgj7yNKC3FePxpKDk+yF+SHX1tbyQ4zil
	 YZVMVKhzkv3vStdU6jEifKyrFQHVnQPnEa2XSFAhDYgTpFrqK+s7ruJ3re7/fC3wVP
	 c5V42Yct4CbICO0vL/+6gaj0UDBaU0wiufrkdNrv0Gt9WJyJWhpV9HB1uCnyRfyN+Q
	 Ko1VREd/4iQjgX9zxrejSTbt65uGJ3N3off5P7sKr4i4LRAAOcMthc/ROTRhqLuCg+
	 mLJcGWgpbYH2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 903F640619;
	Tue, 29 Sep 2026 08:50:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 73CE44CD
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5988060737
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h-UGadDz0BSf for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 08:50:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C91AC6073E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790671836;
 b=I2ihRFTc3BJkGamOjJKYACGgei+iLOw/XRy4S+1iN0bXhW57gApAbByfpE35v7n3BF0r
 GR5hgIEqusOZpY5HMri6hvA94yi4LaaMNEvjMfhk1nWuuVq4N8Fmt2EdiKPgiTeYK4lkr
 8M8Y5V+hmw6Mf6UVF/JS8QFuHOUJQpcA3kM02tr7S/RsWfcrptiii/84RyLxWcu8ygtQp
 1ZGDr0zOHlfYhTJrYBa/Hv79hTJ5ekxILvJbJYyMq2rzuH8xj/pEuV4HT/PifIY85McKX
 RLAdZtpfM9lNHocZls68LqpKEtXoHCbayfAU4GBseoEnCxtEo6US8dCKIeGPfbzNlgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790671836;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=EF3pmwzlyKaNwW4h/2asa3O/GOx+YNQokbL4EH9dXJA=;
 b=JFf9Uf3YgPppg37cjES8F0LusWSPBi5GD7CkzDOwsdUbBOEvz+LvOGuPqokKum7dOMm0
 bxoHByOjVpK0ivXXcP1VEhkM/xXHcUS+lDiqHFS9/qYrOzI8lLaCBS+XMt7awwve718Ua
 z9YS8GtvsRRbNesqOLXw9hLf3Tbqkp9wzkIbgvyKfz2MdXvRYot4kftRcjtB7mpZsCdaq
 H81y+JY4mTi8eg+x2heZEh2B+9uQj4Ae2shKuN91v5Ko3X0K1oYLXlKCoOE+Bwba0chad
 A9rSr/qw7rX0/tKclvMOyirZ8scx2Lh7SOXzea41XtH0HEsdzBjz6Uck0f83y25G92A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Hrn89jZ8; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Hrn89jZ8
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C91AC6073E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:50:33 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e66390995so21898995e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790671832; x=1791276632;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EF3pmwzlyKaNwW4h/2asa3O/GOx+YNQokbL4EH9dXJA=;
 b=Hrn89jZ8oNcFBR42dGPpj6g58wF7WKEYcsAMscbiJBcDLuksefMGxwXiu4gSjjDyUc
 jsNNGPswkXTFOY+t8MkgQWK9DDTJVd/5JKR3toohheeccIfYOduX9QBjzwhgpja5mplz
 54Mt/psbacjzAWhkbPZTzsviUe69lOj9yzFm31bXlaTjxLlQzv0Qbnz0IMU/0KtvD0FX
 va1BGqMDMRPFtzYWVtq8o+scCX3qzcbg8f69vr2x3ARFwF10UjNG8PUC+dzwlJUzH7tc
 ES73kU1Vo6kvWYM/PYe7FkZUjGUGZSzD664KJz4ZERlgq8ZLMqbaV1dC/zoeaCX1SXe+
 8Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671832; x=1791276632;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EF3pmwzlyKaNwW4h/2asa3O/GOx+YNQokbL4EH9dXJA=;
 b=dD6lFvrH9HlakxiOrOdA035rrie4IJjEzJynaDW8wP6T4J8jqDCCcV/2PhB5S8hN+k
 2lFvntjAkrxBCfDNMMZeQ1fSGEA2im0Rhx7Y5CUHXYxRhY3icaErJy/f21A7P/zxwUs4
 5xMWf3704QHspaTo/hHea2iD3feX9SVwJEEaKH5XtgiTj1dgMf8mJcwUTZo/Fo/eiKLA
 e+LgiYYD0lHdyMmgp0iWDUIpB4cECL04cq0FFSLLT2YcNv9M8VbXpQM7le7P14XMxVqA
 ddAED09XGW+ti4xrO84imNZZC/1jSTGuhlmRAMWm+iBDUfWigJjq+URhsRO2kIrlzMDu
 0CzA==
X-Gm-Message-State: AFuF++lMm7My7O5OPlJPDq5HneMDOyUvUIWzXAiqcmWY9VpHagadO1iI
 4xSLuF4FETepX+LG523XKXZBiCK8kgyBctlyNiy4YhlidO013Vb54Ur3VBrwnVG+2mk=
X-Gm-Gg: AYBFou2dY6NxnnI3xS8S7WHDvVwU4E56ShqD0aTBohB61JAmKS1m0Q3PMeKPkQ9+N+K
 P+SgR6cujNrouTPsVUpED0vrloyWUzmFdp7Y1ZS3JrjPjPr5XmyXy0QHkoVPjQ8SSbVDRbYMd/e
 0AIWAp2HCi1l2+g/F9qkG3y46xBv41azMIsO++ZwvI8tFbTXWXCuKd91g654Yqbk0He3VZaQOq1
 4LsEemv1YI0OPpk//LOEXbN6XysPH07fNduWDEcrqzVOlLBU+H9hwVlt2rHXf8E8zGtV5olOU9d
 Nnr/0909C385pmiNv9dhcVmC6QMnEziwms1h9V7dapO0mim/NlAi9jL0x3j21M7PIHCoiT4xZgk
 GWKe5WLQLXBxDOIF8/6JlapphPrmoqdDvDHqs+uxbOiPdr/XG1rV1QH4ynKi/oxPTIMvZTt0Fzf
 bAqnzlyULuK10rbfclGdoPyhGZShkr4QOTVLEQo7MGx04bNpVD33EKjnveIeWPYLMQ4wjvfMK71
 g67DhJLFW9xXv1q/PvNeqdKgVb9XAjP8/4uTaxJDdrJEmaBWrrehUQJwj/LWCGpCbVKP8XfPVWa
 vFRc6OrWXyRzfUl5v1tNOZJcWG9V8Dzi8vNQsFvzdY/306OFiS4FpaE=
X-Received: by 2002:a05:600c:3550:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-49ffd408357mr135010885e9.34.1790671831847; 
 Tue, 29 Sep 2026 01:50:31 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfe16a2sm60967475e9.4.2026.09.29.01.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:50:31 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/3] phy: mediatek: add MIPI DSI PHY driver
Date: Tue, 29 Sep 2026 10:52:40 +0200
Message-Id: <20260929-mt8365-add-phy-mtk-mipi-dsi-driver-v2-0-7a1bd29d0e6d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOTQ6CMBSEr0K69pm2UH5ceQ/DotCHPLVAWmwkh
 Ltb8AQuZvElk29mZR4doWeXZGUOA3kahwjylLC218MdgUxkJrnMeSUU2LlMcwXaGJj6JeITLE0
 Exsc4CuhASiPKrOMpVopF0eSwo88xcqt/7N/NA9t5N++Nnvw8uuV4EcTe+2swCOBQpgUv0CiZS
 X1t9PKixuG5HS2rt237Aqym2X3pAAAA
X-Change-ID: 20260915-mt8365-add-phy-mtk-mipi-dsi-driver-22d184f03e95
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Stephan <jstephan@baylibre.com>, Siu Ming Tong <smtong@axiado.com>
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

This series adds a mipi-dsi PHY driver MR8183 compatible SoC such as the
Genio-350 EVK.  The driver is ported from the kernel driver.

Patches 1 and 2 are preparatory patches: drivers/phy/ already carries 4
MediaTek PHY drivers and this series adds another one, so collect them
under drivers/phy/mediatek/ like the other vendors do. Kconfig symbol
names are unchanged, so no defconfig is affected. Also sort entries in
Makefiles and Kconfig.

Patch 3 adds the MIPI DSI PHY driver itself, supporting MT8183-compatible
SoCs, based on kernel commit 2ec9c210c1f9 ("phy: mediatek: Add support
for MT8196 MIPI DSI PHY").

Two deliberate deviations from the kernel driver:

- The kernel registers the MIPI TX PLL as a clock provider and hands it
  to the DSI host as its "hs" clock. U-Boot has no consumer for that
  clock, so the PLL clk_ops are folded into the PHY ops:
  determine_rate + set_rate become .configure(), and prepare_enable
  becomes .power_on().

- The kernel reads per-lane impedance trim codes from the
  "calibration-data" nvmem cell. MT8365 does not have that cell in DT yet,
  so rt_code[] stays zeroed and the SoC layer falls back to the same
  0x210 mid-scale default the kernel uses when the cell is absent. This
  can be wired up later.

Tested on Genio 350 (MT8365). The DSI host side that consumes this PHY
is sent separately to ease review

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- fix various typos and improve comment about nvmem cells
- (mipi_tx->data_rate * txdiv) << 24 : add () to improve readability
- Link to v1: https://patch.msgid.link/20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com

To: u-boot@lists.u-boot-project.org
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Siu Ming Tong <smtong@axiado.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>

---
Julien Stephan (3):
      phy: sort vendor subdirectory lists alphabetically
      phy: mediatek: move MediaTek PHY drivers to their own subdirectory
      phy: phy-mtk-mipi-dsi: add new driver

 drivers/phy/Kconfig                              |  50 +------
 drivers/phy/Makefile                             |  15 +-
 drivers/phy/mediatek/Kconfig                     |  57 ++++++++
 drivers/phy/mediatek/Makefile                    |   7 +
 drivers/phy/{ => mediatek}/phy-mtk-hdmi-mt8195.c |   0
 drivers/phy/{ => mediatek}/phy-mtk-hdmi-mt8195.h |   0
 drivers/phy/{ => mediatek}/phy-mtk-hdmi.c        |   0
 drivers/phy/{ => mediatek}/phy-mtk-hdmi.h        |   0
 drivers/phy/{ => mediatek}/phy-mtk-io.h          |   0
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c   | 175 +++++++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c          | 143 ++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h          |  45 ++++++
 drivers/phy/{ => mediatek}/phy-mtk-tphy.c        |   0
 drivers/phy/{ => mediatek}/phy-mtk-ufs.c         |   0
 drivers/phy/{ => mediatek}/phy-mtk-xsphy.c       |   0
 15 files changed, 436 insertions(+), 56 deletions(-)
---
base-commit: 1dfb2fd2e589c7514d8180a49c90fe13c85bf2b5
change-id: 20260915-mt8365-add-phy-mtk-mipi-dsi-driver-22d184f03e95

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

