Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE73C982C1
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 15:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40BD780857;
	Tue, 15 Sep 2026 15:00:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K9tJV2ca7dYA; Tue, 15 Sep 2026 15:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8729280859
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789484408;
	b=pVerfGUGRojZ9KSYD0dsS2MjaZgoSKJPLBDT7L2TakcvoU6DnkzRKbDvhTFjizq3b006
	 dbb2LbaXjNpmJkgAiLC2vT+nnQU5AKwGh/Al4yyDDdgaXt4wCNQfQq+GA5xdLPXjqScwv
	 d6EIP+P2KHxbTrMIJ/i7TAvWJxcOulRKdIwhk4i+Yj1CwOhgsEB3MIGroysbfOsuLjT4u
	 x7mcTfxkZxk1tcytIqRxAuPq1RmDmLVSppURlWl2bFya13QA5zZt9+Nxd6hAYKCQu6tGA
	 2H5+BJVJEB7eGeRSF2nTIcZs/AdZUHjgUVvBo+pY6T1x3xQIyeKzwFVh8XpnNcFl3/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789484408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Hm7/fig6UQnYof63Atsztn0VgasbH5ptKerfi88ZT3k=;
	b=VNNnU1+RCAzliVuwSJmtPe2llstSsRLWM+vJyK7rj+YduutdVQ1dCKsmftDNVvXRt42h
	 2BCU8CoZq9O/L+ffpvtYLkp5DgEdVjkEzDcJr79J33OEptU8J0Sw61jwlhSQ5uDi8ZfDd
	 fCxUTRSN21XUxrS0zYkKBlVmCOsbqDVFvzOtzti5Tbzc5vuWLD7y0umEVyB/q/do29oFp
	 1rkS/3I4hkSOQ1fa+bb9RokQH2rYMIQDnyMM+gAxDAiufllrQNlsMRjMgLnZa/IVFR1Pl
	 q5BYFIZzy34h6lpZSb35sazuTKpq8r2pZO/m0ZitSAT4mNV5I4T5BhhNLwLAV8OXvdw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789484408;
	bh=Hm7/fig6UQnYof63Atsztn0VgasbH5ptKerfi88ZT3k=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=v6hO+nTiJa/h2AjSBIwExzm26M5TPMmrWvxfsPMvJjPG5xWXvkQcfkwaduIJYsik5
	 K3sMejD+psSauyJiihm9wumSKNuIW0Q0fgjIRrMJUXJ+nKbrIW6O1jxWQNkwvQEEqW
	 XHtKviuUce9o+LhEyUjVzIQVPGNbXCTFcT7t7wLZIXI8cCeI/mNvCbsQjT8LORyqLb
	 Wq27h9p5jyNJLHnJNXnVsPTODmIaWoeDotW5TGvv/SiISoDjut/U41nvwPKtBad00I
	 meN9tEYg9CFc69ap1KUPQ659IcE5IwH6aTWxI6qvqwfuGRK+E4b/8OznM7UrUBoEPK
	 y7H+mFfBcsuOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8729280859;
	Tue, 15 Sep 2026 15:00:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E86A024D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEB7C400D8
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xX7VPPkuZNZm for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 15:00:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B2B95400C2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789484406;
 b=a8pHNl7UFMsu59NWpl4ECn04xDiCHU4cgK0wygIzF/iTlYHzvWlpWqd/eZk6RTsATohp
 amvDUwMLkMud0O84KWeApfdkCA0I1PyYhnNM7qye7/Gk1fPhy/BceTB2BWj4Jh/4SY8F7
 8+dvuL+5nU0B1SciU6WXom3g9BIpgfYQBDju3hrn9kiksHatAoiR2HiTtyyMLOPflQCyN
 tpPtRvoQ7JmXOSjr/jGP1p30+Qh/sB06nts7VI086QkOFQp/10ADpCdLe3UTaIBYswMJi
 s4q8CAzBWruS/TTu/uFcdL/wnrVYNi5H0XZUa8lCGC97We+bdQ7pxv3G/TkeNbWClUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789484406;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=Hm7/fig6UQnYof63Atsztn0VgasbH5ptKerfi88ZT3k=;
 b=WD21sfHlUL98+ev16swJfGEwim8TkJLYo/RkrANq4itiIMq3gl15NQQS07jD2M+kkq7M
 k1TyP8bjqNdqt2pWcNb/h7knEnW3ybvxxOPqpexU6dzkYWLGrGZsfyIwWjBpedX1F7JzB
 QRkNuD1W7iSp5H3vY9enyzXQIAd1ZOV0mIs7koAX5oqPAMjUko1k574OKYmHmXe5hSXP3
 xY24jH2pldzdvHWzDoAcRlUFeI8S6wUN21KYzbktu88IGZXEmtAmL+X2Efe0pRTxZo8/T
 KsNUzrHYz50hO2OJ8qV1M3d0JHNOL2hMv6dUYCTf1E+ZsiMh+WZhsCvaoI2qwKFVfDQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=RePegQqH; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=RePegQqH
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2B95400C2
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:00:03 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso22431475e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789484401; x=1790089201;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hm7/fig6UQnYof63Atsztn0VgasbH5ptKerfi88ZT3k=;
 b=RePegQqHV4Z60nevH17WxvCjDjaKO3wwN8TYkg0e4ulNosWn7eKyjT68wsPqH7u7m3
 Mqj5grTK+KV2OeMgIbINF+6Ab/y0nTZUJTs0q1Gn9qyiOuggmuQpXK2Dr8hgJ6tMUSco
 hfp3ZEsEI6pbkCjPImC/9S/6U9iNIzmPH9H8daK4uRagjhsUldryKstnJAnAFU4w0cYL
 23bEanFsD+KB6oZbv09ziVSzcSpMA0m4unQ5ZGUm9zW1o59KXqVTx7WyT2eP1Nhm/inr
 ETZ27vA9pJ8krGPngrRwvKJzB9HDFZEMd2n/4wnYmn8GomZmv+OodSyOLITSkpgM5Uhi
 TxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789484401; x=1790089201;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Hm7/fig6UQnYof63Atsztn0VgasbH5ptKerfi88ZT3k=;
 b=JPuotubyW9W2yASCrR1x3Fj8Te7Eolahieb1rVtxLiKQ4gSuvYt0VdGHGvrC+eO5fg
 xr66SR2kUa4NeiWXClFStjAPizOszq9L5aIN5Frv4+E+4BZus85TTThWtPoDxbu75Mkz
 RJ32RXRGUgTvkyShqpMeHLRJaJHXqmXeqAUatPnoE8AC7YPdcSO+fzZRYndtPuB+yLo4
 +Xv0u89CJLA7HL1yJ5VmoH5NJcqzm85uoAG9KvETvKv1Z9JC1fGos0g2x/rcZ4R3xUvJ
 bReecvF3JK1m57cu41e5+3aM7MSKR4l8j0WT2oOs5gD+SHn4RhJz+EXsvfZSuFLK2tWQ
 riVQ==
X-Gm-Message-State: AFuF++m/AhBi4rSAH2b42TjlzpYnwcjaNiKjc+VCaenEIj86sn5TLi89
 GEoK1ljOIguKjg/fWZPKUUUV3iz2UBpqc8qYqdKGTjSnby51SeGfez8hQO32DI1ItpQ=
X-Gm-Gg: AYBFou0C9oXsJ38Jd2ciLShoUINV1m3ZwBP2ujR7kDlfitozjejlB7an+ero+94d5CS
 DNUlooY03OrMoibyKwyg0f2tq7D3FlXbWSqhM8SoxPHLoUJWgkOBTGWJn8OAdXshnkr2GSHXPc+
 z2xObe+4ORdhKCXnZthOWIrcqNA8pL+Zh/fasGjOzg+VAxH1tdxV4KgY5NgadzloLBHbmnmY6JB
 DvAqBew+0q0Eug5Phoo48dbNil2uYCIXVlrQOdjdjqGv3IbQ2/zvlSnIz81siOzl+xVb2n29Li1
 AWTyREnX6Cm2+POKx+sst/Z5b/B3GcOSBlHOrwRMgqGQYa/B3z7VKmFzodSE7jSGXdi9bgTEKfm
 zEZc/Cy6aV+9dZRzt5llWwBimudyyUp6/lLuMfC09QVtCVnmMXmiJRI82G+xHzSt8zXJtMqoeNt
 DBvlwLR2ONyDpZ4mmC8U0Rwk3mesOxsEz1fx2hJymjHoEtvMiXjYa6xoTYVfgKOfvB7KGRfiSyE
 29uOEKhBEjVcyD4oLlJ7+BAVIS5iOhYhg6OH6KGox6EbXSzl/VHtvEw6CCrIj5tZ44dhsOiNFWI
 Q8X4YCsh1G1FbsWx789Y7ArI7A4/D0X4Jv5yvk6gLOa085eS91mSf7Q=
X-Received: by 2002:a05:600c:4f12:b0:49c:eb04:1c49 with SMTP id
 5b1f17b1804b1-49e7a64a7b5mr105075895e9.13.1789484401282; 
 Tue, 15 Sep 2026 08:00:01 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83aeb654sm1538675e9.8.2026.09.15.07.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:00:00 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/3] phy: mediatek: add MIPI DSI PHY driver
Date: Tue, 15 Sep 2026 17:00:29 +0200
Message-Id: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CQAyF4auQrm0yMzgEvIphgbRINeCkRaIh3
 N1RF2/xbf63gbEKG5yKDZRXMXnMGf5QQD9285VRKBuCC5VrfMRpqcsqYkeEaXxn3nGSJEiWp7K
 yYgjk6+PgSm4i5FBSHuT1Ozm3f9vzcuN++ZZh3z9aABdwhgAAAA==
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
 Julien Stephan <jstephan@baylibre.com>
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
  "calibration-data" nvmem cell. MT8365 doe snot have that cell in DT yet,
  so rt_code[] stays zeroed and the SoC layer falls back to the same
  0x210 mid-scale default the kernel uses when the cell is absent. This
  can be wired up later.

Tested on Genio 350 (MT8365). The DSI host side that consumes this PHY
is sent separately to ease review

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
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
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c          | 144 +++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h          |  45 ++++++
 drivers/phy/{ => mediatek}/phy-mtk-tphy.c        |   0
 drivers/phy/{ => mediatek}/phy-mtk-ufs.c         |   0
 drivers/phy/{ => mediatek}/phy-mtk-xsphy.c       |   0
 15 files changed, 437 insertions(+), 56 deletions(-)
---
base-commit: 5437f0d7943e352ebe126f66275edf4f8206b545
change-id: 20260915-mt8365-add-phy-mtk-mipi-dsi-driver-22d184f03e95

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

