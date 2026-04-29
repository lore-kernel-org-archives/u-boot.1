Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8BFFF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 21:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B793D8491D;
	Wed, 29 Apr 2026 23:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ucZ2h/rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF2284837; Wed, 29 Apr 2026 15:59:29 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D3708485D
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488d2079582so147549445e9.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777471167; x=1778075967;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PKZajtnxuquByd82zKC7xi3sY6wzeZyzPF0oTBC4qiY=;
 b=ucZ2h/rgxms8IFQdFIS4iYMX9IrBtgK/qN1Ckv9u15LNfU4Eu/O8v26OpK2LPVeECP
 yS8d3nU2yuN3fADdsazExXOU1yJGLgaUoFXH+RD/TSaXctFU7qj1CwJ4BRypTPwW3hh9
 JUj369i53IngozUTbsYmsFTQ4Ggd0a7DPuPOC2pOtkSbneTXPvH40U3Yf5kEPUJvIn97
 zc+geUeJveTU+uPfQ3raR5fECFAr36GnRAIp9jmvjTMIliO1wpF0FQLOTkQlk5MpWJaO
 t40S2TtpIfbBKv8imwsCHgqbPlP+A0KQy9Nq2b7N/SyB6o/yUcCRR5yPs8bSi2MnY5Xx
 A0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471167; x=1778075967;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PKZajtnxuquByd82zKC7xi3sY6wzeZyzPF0oTBC4qiY=;
 b=djbh0br3nMcLhI0XhkhPJu5bDoViKVCC7D8ZMGIRCXTM8OeB4oOQv3qQtlTc/Gj1wG
 ee5axHdNtOZYOecjD9XNGYhyIyvDh31stupj63p9R3m4ynLGsguWVPzI92eLmxT2p0DP
 fKIvjvjGQY3g9u+MSSdPrrWUgkYCJPFVFgPIh3KCFgXtikU6biDLmpAlRZQ22CDnh85Z
 slumPPpADYRWP/tFH3XaAIh93zUJxCVlV0/ojr1FFuhJt6Fk8yeD72+znL7ZexgCxft7
 sZ39jMqhPEWd957SJgV0mO4ApUU6esc9KgtXeVlsftXx4N1TflecKC85b0q6N9Rdp/wR
 GcdQ==
X-Gm-Message-State: AOJu0Yz45dbcJh5CLXlRJSXHAfMp/vGzt+Yu0XClLFs3TrsI0SoQ4C8c
 KBxgPcnVIBoveHb/G2PO9OyWPMbVm4/EuYU9OrJrDuFKyJELgWWCROLAfa3I/ybFgRE=
X-Gm-Gg: AeBDietO5cBdgoBl1jO0UVJu7PhKb51khTYLYF2MgCL8c9J1kIMPpVg5qTxXGnKG7Un
 WEcDwiMzPbrgw6fRrQ/39kkIVgRQGajIMPko6jyU2C6bA9MJwN+CPqwJ0aspzDqCLk7V8cKoJPB
 NpDqdyMWWllhfks11S/Lwm7uEn3kmsoEfs1uM2yG0PcRsmd3IgWUDsnWeySj4hJb9qY5oxFxMUb
 g9Qc3B+fH68kGXD0xnK5iQdNKFGeNikkHHJL06N+op5ABRtC0Seeq7HTeMP9TbzShLevzE58hKZ
 4PQKFa5sw7G/oomLv6mqPS9US4SaWu4XwLOR/hpPlZEcjd5wIlxReFc2PPsytlmyysNC1gB1Jb2
 ugvdygi4V7PVyd4jdRYjdPZVfwnYwjFqPee8Y2PsrmndM7I38CN3bvRPikMrgbZsC/fQ6zcrSNj
 wNQUruDS7gb+4nZKluPd++uRxyxT1gqd92vcPWGMYMbnY38yH/CZF5paocWmDU6Y1WeENlqMG3e
 WzwkYh7oh0rd3/vDC2CBPdinyOuW9MbGHMgiBxhXvHXCG62hBblu9cx3HEDOH071VLVGoO9bNa+
 p+QEP62frNcZuDbpzDI=
X-Received: by 2002:a05:600d:f:b0:48a:592c:e642 with SMTP id
 5b1f17b1804b1-48a7b531539mr54847415e9.18.1777471167400; 
 Wed, 29 Apr 2026 06:59:27 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca64ffsm6289675f8f.37.2026.04.29.06.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:59:27 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 Apr 2026 15:59:02 +0200
Subject: [PATCH v4 9/9] configs: mt8189: Enable ethernet support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v4-9-be54e17239b7@baylibre.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Tommy Shih <tommy.shih@airoha.com>, 
 Kevin-KW Huang <kevin-kw.huang@airoha.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 29 Apr 2026 23:15:47 +0200
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

Enable configs needed to support ethernet on MT8189-based boards.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8189.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index ecf8c5f4b4b..f86bb50bb5c 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -23,6 +23,11 @@ CONFIG_CLK=y
 # CONFIG_MMC_QUIRKS is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_MTK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_MTK=y
+CONFIG_PHY_AIROHA=y
+CONFIG_PHY_AIROHA_AN8801=y
+CONFIG_PHY_ETHERNET_ID=y
 CONFIG_PHY=y
 CONFIG_PHY_MTK_TPHY=y
 CONFIG_PHY_MTK_XSPHY=y

-- 
2.52.0

