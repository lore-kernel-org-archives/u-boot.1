Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C56CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 08:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B781760737;
	Tue, 29 Sep 2026 08:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zQJeZLY6gZ1P; Tue, 29 Sep 2026 08:50:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EEB516073E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790671839;
	b=OWMkGax4BYLHDjKkElFrOEB379vou8eoJC/DCMJ54DdvE7e528itSCgOXmoP8omt3W0E
	 SPBuF/8zsszzWrkxHhKnsIBKR2KWgDc30/5srBlrXVBXNt3HjASi1YtoPzUIXmbN1quOT
	 3B82hAbKDXRIFbr46YAAmUd+lZRuLlyPgo1lDXlG4Ei3sVhF+mVW3TeL6WVQ2mGBCuzB3
	 FOW/4D3f6WZRg9SdMl4yKbZyB2Pr7U7VSjcV4rvfqsxUEYu/0EaYARt4yOZHobJAUtMMk
	 +rRLNtrtDrZVLHwiH/uhxneZHut6DuVAUA6hGtvXM6h1bd99rnpKpRqxUUhsWyEOr2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790671839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CIE7fW/jQ74wTpF14E7UixpKM7NJfasGE06nTq3BiOk=;
	b=XmsGxJEHjdHpO3otBO12FFQ8tNHGmn6bPSTthCVEk5KZE3XkiR3YBdpe3Lg/WSMpCiaw
	 umDItdApDbmtFzxWuI2akH6MBw+nXKLzzK8z4BCAMmZakC3071RfR2iSLEUGPRT9qa0lp
	 3xTc7EFDG0VqyT5cUF9VWfym8g/XMmCQCLr9eqmpWySu8e1cX5bp92ZCWzR28EuyjuqHI
	 oCew4kB1vV0yS2PIqrD6PZyWbOWrxVnXKoVGBQQYZhJXbdxAfAh19KiSvfyXGin47RtSt
	 a2qrbhLCU6UdGMvzpFm9Sl9qfQ5hi1Y6yfzCJwvLLgVpkFKs4pwpZJmXeLdfTAdknhQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790671839;
	bh=CIE7fW/jQ74wTpF14E7UixpKM7NJfasGE06nTq3BiOk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eJNy9KAHMQTsE8gDhVy5IRGcTcWRWeDE4qWeDMujgtXX4rXdg2yEJ8n50C09LRGfp
	 mPXZlofIDs8Q9eZLnTvSBP91WD4//bC2lXsgG8+tbOB87S4PKKERH0uDsmuFglCFIe
	 W0PrFg1JfW/AaPaPYMsw7ff5VQ7xAdNDV1PHGETaujOD5AXOKAsIq/sTxp1i6yfbQV
	 LGaQP6BOS+8WnP17LXrUIWhC1/iA5GKBtb+R6YeHTzV/Z4nZKwMJgmSK58y2HhLtli
	 JeTTmbKGDeHWW0GX8c/IgtgG94pKl4WClgTjtrLKyKw77B7T79dD/TBp8Jio+NCrep
	 1zOeJ8s7JdY4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEB516073E;
	Tue, 29 Sep 2026 08:50:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DDDC32A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F6D14027A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0qVblDMWSGk8 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 08:50:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 00C4B40270
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790671836;
 b=KGnO793L8EiG7cvUFendDWUv91PEdPnHD60c/kIpd/nYuAOncMBPPnOuMwo57gIgQSoR
 0W0SFOvP9zdTXnXdyrGAieeY7Z8PvZqAAkt4jX3/rZo4PS20CGBgqCGF7VOtZ8k81lUlc
 q3Te9Pss61fgjG4SnsFMMWI6/f6BMo0jPBwZDoqKg0mZ8diQnpyK6TmBrHjKF2+bl/M9r
 GEo8MuJh7BKHpHm7ghoG6LkcXLCY0hzSiIgJpH/RIjKf3oAJULR5dsrxL7ZeN2bJ/QVk/
 OGaoUfPkpHrjUOudpxjDbGWEoTqJ+mSwMskk2andoronVRwfDshy3FBrj4cExdgdngw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790671836;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=CIE7fW/jQ74wTpF14E7UixpKM7NJfasGE06nTq3BiOk=;
 b=cZgrRHweYbAhYrH/6irzKAx+lG+SW3P96Fq++hxhmf42dKyIfczOJc9lRdhH3cJEyEIp
 JVn51547Z9xh1WYL6WxBhobbDdedTOyGH9V/mEmFvdjF42YBbgEAhy+g9JrRqpOLyoWLW
 F7ftXoc7xfBvRi7VXR/oMi04quKXqmWYuG9oFx4Wv11P8dhyfRUxFNtsOIhZ5GexLwGPO
 988Sh/ejdzonpWkNEy4h9eZgG+E95CdWf5UNUXvOP79xxW6G9RZ4ORXU4exs3FmJ7JZQu
 yjkMQOYrEtMa4qhiyngfCZse/oafjzj4U8BCe/Jn00N4cAYYguqJnQ/aAPqSAEmeo9w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CI9LYn3A; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CI9LYn3A
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00C4B40270
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:50:34 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so29149575e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790671833; x=1791276633;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CIE7fW/jQ74wTpF14E7UixpKM7NJfasGE06nTq3BiOk=;
 b=CI9LYn3Ait7QIt45VAOMrP+tMXNdZqBbr1DnbugjnoxW89sziMTv27N+YWMTH6OiOu
 8w3YXN9I/xo5I7LHrtgikByMomBLOE4R9owLna6JCSobqt3Ntff8HsSNok4q/7t4FvwE
 lI620IxcppJN78FiGdIlWbatr/5xcAA1FPgux+4jNLpCy8jO3CUeHAKa3m7jgpeBiljp
 +NPhaVEvmnO+7sEh32P64bAZbB+bZgcy7rYlQqo6JF2gzMVlNN7n0uZBfL1cwrM+FjCq
 ouhFk64qhUfM7l5GBU9i/4nVMfDu65suV1locBnZNUtwAGLqCiFRCMWRw2BvINjoZ3hf
 ZjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671833; x=1791276633;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CIE7fW/jQ74wTpF14E7UixpKM7NJfasGE06nTq3BiOk=;
 b=IAEU5l55cxyiwzPlk2TPVT7qtsP88LG5EIqGcyd4UasQj3ts633eoVbVYk3KLaL9F9
 xgKkyddYI2a02UdSJh23z7MgqZvfXt0Q+jycbnUsYNWtPoCfbqrv03fcCMAspkGPerDP
 VW0kv7bsBghVxoSuTGr4p+LRom7l18TGVV6V2Qxk1V+VaE0W0xtoJGw4/Mf9CqU8SUgT
 /e2I/mDoZgJyaqj3aVa+BwXjZtt40N/BdPSAAJIkZydfLsmNB6KOOI/xrr9pwoTFLlvv
 sRWQSNNeZZvvCG2UUMS48bkbnqVZuD+2/OpXvwh3EdKuEi1XTLzqwUyshW02sSri/Ewp
 +zCw==
X-Gm-Message-State: AFuF++lgACKo7OiwZUN+bqdc1rpj7milMwPIWQtJGDT1nSycFUr+EABj
 Wd3W1UI/xV/hDnzCSWEpnP1u1q96byGprCAyoU13TplfB9UqtpJvnBqZL7XlwQiIeTc=
X-Gm-Gg: AYBFou0ELHYNaUaH3RWe9/BbRs6xfio8zLr7B362A4puFWZwfxJqpif+BML4DuDLuyi
 MfqIDpQj+JC+V3JJsNsgbiPUSh6e6hpiP6C4x1AD9MwxePVz9p6hS37jNIJHCyNI865lzPccy0q
 w0ozajd7NcppNp5AnbIw1kAtqY+FUqqjggtviROa/MFYRPxC7O2/zlSpG1XaMeICvcw7qIIZaJi
 ToBUJsZejjBFeCmvgnorGnqb40ifie8a7Lw3OglfmY6RFZtdF+plbc/kwf85I9wI5lbAy+5qfe9
 y7TAFUgC7Y1fm26/6cLOFHJGdOBmuz2tXheu0fJ9s3w5GVQUZN99/S5i+qGOwKp+oyBJc2zXkND
 Fnkf2j2zP0ELHqRLTxwlrX2LdLz1Ag4e4lx+0wJMphnkyKztZ4WOagNJ7pogsVgA2E5+zYd49ha
 1GkZhLeagpFFb6DrromqqiVMWumTWVjI7PWIzRobPviNboeQdwkB22hVRyrs/WMXsdmH28ak0B/
 Fgi/TCkE6Xnup+9F75JinHepyX4JOzi5XLhKN4xGYBKXars4LWhypX+n7UKeCOs4dGX0PcTFJfW
 8k48wH930CBP/93EdEaC8nMnQYQ3BD4iWpgjh0vZIxUTg3/TfLuab94=
X-Received: by 2002:a05:600c:a47:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-49fe66abc9cmr267371435e9.6.1790671832577; 
 Tue, 29 Sep 2026 01:50:32 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfe16a2sm60967475e9.4.2026.09.29.01.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:50:32 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 10:52:41 +0200
Subject: [PATCH v2 1/3] phy: sort vendor subdirectory lists alphabetically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-mt8365-add-phy-mtk-mipi-dsi-driver-v2-1-7a1bd29d0e6d@baylibre.com>
References: <20260929-mt8365-add-phy-mtk-mipi-dsi-driver-v2-0-7a1bd29d0e6d@baylibre.com>
In-Reply-To: <20260929-mt8365-add-phy-mtk-mipi-dsi-driver-v2-0-7a1bd29d0e6d@baylibre.com>
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

drivers/phy/Makefile has two separate blocks of "obj-y += <vendor>/"
lines, neither of them sorted, and the list of "source" statements in
drivers/phy/Kconfig is not sorted either. New vendor directories end up
appended wherever there is room, which makes the lists harder to read
and to extend.

Merge the two Makefile blocks into a single alphabetically sorted list
and sort the Kconfig source statements the same way, so subsequent
additions have an obvious place to go.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/phy/Kconfig  |  4 ++--
 drivers/phy/Makefile | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 6262380a60a..97133304cb6 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -363,12 +363,12 @@ config PHY_XILINX_ZYNQMP
 	  Enable this to support ZynqMP High Speed Gigabit Transceiver
 	  that is part of ZynqMP SoC.
 
-source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/cadence/Kconfig"
-source "drivers/phy/ti/Kconfig"
 source "drivers/phy/qcom/Kconfig"
 source "drivers/phy/renesas/Kconfig"
+source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/starfive/Kconfig"
+source "drivers/phy/ti/Kconfig"
 
 config PHY_COMMON_PROPS
 	bool "Common PHY properties support"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 19cf95759e5..02f8b495ea0 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -4,9 +4,14 @@
 # Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
 
 obj-y += allwinner/
+obj-y += cadence/
 obj-y += marvell/
+obj-y += qcom/
+obj-y += renesas/
 obj-y += rockchip/
 obj-y += socionext/
+obj-y += starfive/
+obj-y += ti/
 
 obj-$(CONFIG_$(PHASE_)PHY) += phy-uclass.o
 obj-$(CONFIG_$(PHASE_)NOP_PHY) += nop-phy.o
@@ -46,8 +51,3 @@ obj-$(CONFIG_$(PHASE_)PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
 obj-$(CONFIG_PHY_IMX8M_PCIE) += phy-imx8m-pcie.o
 obj-$(CONFIG_PHY_XILINX_ZYNQMP) += phy-zynqmp.o
 obj-$(CONFIG_PHY_COMMON_PROPS) += phy-common-props.o
-obj-y += cadence/
-obj-y += ti/
-obj-y += qcom/
-obj-y += renesas/
-obj-y += starfive/

-- 
2.55.0

