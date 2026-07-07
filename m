Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071BAC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EA2D84A5B;
	Tue,  7 Jul 2026 21:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="WEma9lvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA03884A5B; Tue,  7 Jul 2026 21:12:13 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CD2484A77
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-485ecc0f2dfso2753033b6e.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451529; x=1784056329; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5QiFrIV9TX8ruRwK2PGBzEvgIBb/OjOdeDKdXSGkRW8=;
 b=WEma9lvVxBAdLujiNBvEljqS/EscOkZKNrwmgjOB3S9efMhT+ejX0KcjUCF/1D7rQp
 LqVE25SqWdvZdxkNCUQzo5srml5zo+Ad938elEbyyv39tN6TXuOzaaRlMJieJrpqyGdZ
 s2r2TnQxe0LDloMQI2krg9WA2/HXExfxzcuV0elVqq482gNtA4XkDZbA1SwfGM+sBjNI
 jT82gWI9hqdBpD/dxxotO+dQto/Sw1YbnEU+zlqtILzyWbYB9ripCS/YlcOhaId355J8
 0JJT2f/jgIFydpP27PDpMVsg+wfNp1E9kh6XnIGySZ0rj2zGrRdZWUSaNhvRC3y9eoQ0
 ssnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451529; x=1784056329;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5QiFrIV9TX8ruRwK2PGBzEvgIBb/OjOdeDKdXSGkRW8=;
 b=XhzfLKZzELZfT79woVSQNG4VmAneFMsnr0xbxUtrfe9Hj6qWT/SNFBw7l+6GY+PKfN
 ccc9l1E6HNHuIaT76zJYN/jKOfkazyWQGiZM9ocyofiQRtH5ePJfYujDpa7i5RFOwg0D
 XXK4aj/1lTv1J29Bn9oUEE7c1Z74pF39XBLtIxRl5FSQZ7kXSeiPugBKbWwoLiPw4j+U
 0CJ3dZkRcKzQxMh5pOH5LKKBAS4k+YpCzva+r7jrv0ivXYAM3FaJPodi+OEYPj2adzT4
 t9jmiukIpRtCnFB1AKCWzepCpbw1GyjUKA7PJ9onJFQSWRhgdb0IS7Ue4SWkzQqkgNSi
 uIvQ==
X-Gm-Message-State: AOJu0YxdlpnfQconBk3PgTy5E2PehnzMMwaVUQlPFG5WxQywY5qSGspF
 jVXo23EAAbZ5/jHforyp8rdBCHDb3qZjlfMHMcEphyBKQec5gZD2OGstvnvx2fCHtbk=
X-Gm-Gg: AfdE7ckY7dMSJnTT1SpC5evUK1pFT1bLCg1jkB12Gicl8Q7GmL5wizYF4kI3m/YVlaf
 iJ6Gij8UPcmGkjFYaJwZcg5BAnKIzHasW9oBCiwcGqq8ODduMRrtY3835ES4bv6WkjnAIUOHR1H
 PWuwgc3hF2bvLP30E97xJHsqy3fSBi8exhgnK4mAVKEnffvrClQHurTCUjnYgdg/VNT4oMsq0oE
 QAxyPoggk1nV0oytFdnkEWhHHrYkEHXA/hqfEx5DIovWCJQMy/hQHaaHHd8d74doLAn4TwcYp7c
 IHkP+j7BQyh/Wtc+9IXKMEGAOHwFr8Ll8+A1WY0SLVnvWLIh4cr6p2ND5AvZrLugtan28riB8TA
 FeuXvLNH7xnPvV/jzSqzJF2hZNBarPXblcK6+PtEt4e4S7MU/It33PTL5jz5RVwi0Dm9fur0Lnw
 gp6EZzGHhGscNBihaZluy2CWSrcEwk
X-Received: by 2002:a05:6808:2388:b0:496:c5a:e11d with SMTP id
 5614622812f47-49fdc762b48mr5196008b6e.15.1783451529392; 
 Tue, 07 Jul 2026 12:12:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:11 -0500
Subject: [PATCH 09/15] clk: mediatek: mt8188: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-9-283d9a55361e@baylibre.com>
References: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
In-Reply-To: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2555; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Q8cnj4GzoHWPEpXZ1mzLX7P6u4DulsKCqgg1XvXudkQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU9M83LfSEVp79uRETszxcpElo6yVlK0dbtti
 isDGbECKDCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PTBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AGF0H/2gsKOzchtA5XznaLOvQXlVVmGqV19tQ1UFN2c+
 wZbO+MDRS8dOHhXbnc12NL97kpLU8ZOk5VOrxXkmFgokgiE4uZXqApj9FYkdNee6uV1dLnK9J38
 TrWlckoFDwUmyxVDWCuyMFhZdi7AXTjCIBjqfgqU0U/oB/dq5mlVRASw16V+lw3V8XZWGjjx45l
 Kjb2O0HWtik34Vl0SsNnEPLFkSXQ3t1CcdVCi/UWD/6ZD10jlAxM3s5Bxyh0yNdCc0cx37mi2Iy
 pR0DIhdUpCgZmn73MyWqYhSv/56eKIoLstJoecHCLrk48f22aJxzZnNDsb0hwLbifmnhlUepQv0
 wlaY=
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

Change driver names for MediaTek mt8188 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index aef60b324b6..9e55a585f9a 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1792,7 +1792,7 @@ static const struct udevice_id mt8188_imp_iic_wrap_en_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt8188_clk_apmixedsys) = {
 	.name = "mt8188-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8188_apmixed_compat,
@@ -1802,7 +1802,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt8188_clk_topckgen) = {
 	.name = "mt8188-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8188_topckgen_compat,
@@ -1812,7 +1812,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_infracfg_ao) = {
+U_BOOT_DRIVER(mt8188_clk_infracfg_ao) = {
 	.name = "mt8188-infracfg-ao",
 	.id = UCLASS_CLK,
 	.of_match = mt8188_infracfg_ao_compat,
@@ -1822,7 +1822,7 @@ U_BOOT_DRIVER(mtk_clk_infracfg_ao) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_pericfg_ao) = {
+U_BOOT_DRIVER(mt8188_clk_pericfg_ao) = {
 	.name = "mt8188-pericfg-ao",
 	.id = UCLASS_CLK,
 	.of_match = mt8188_pericfg_ao_compat,
@@ -1832,7 +1832,7 @@ U_BOOT_DRIVER(mtk_clk_pericfg_ao) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_imp_iic_wrap_c) = {
+U_BOOT_DRIVER(mt8188_clk_imp_iic_wrap_c) = {
 	.name = "mt8188-imp_iic_wrap_c",
 	.id = UCLASS_CLK,
 	.of_match = mt8188_imp_iic_wrap_c_compat,
@@ -1842,7 +1842,7 @@ U_BOOT_DRIVER(mtk_clk_imp_iic_wrap_c) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_imp_iic_wrap_w) = {
+U_BOOT_DRIVER(mt8188_clk_imp_iic_wrap_w) = {
 	.name = "mt8188-imp_iic_wrap_w",
 	.id = UCLASS_CLK,
 	.of_match = mt8188_imp_iic_wrap_w_compat,
@@ -1852,7 +1852,7 @@ U_BOOT_DRIVER(mtk_clk_imp_iic_wrap_w) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_imp_iic_wrap_en) = {
+U_BOOT_DRIVER(mt8188_clk_imp_iic_wrap_en) = {
 	.name = "mt8188-imp_iic_wrap_en",
 	.id = UCLASS_CLK,
 	.of_match = mt8188_imp_iic_wrap_en_compat,

-- 
2.43.0

