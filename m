Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B23C982D1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CB6A80FF2;
	Thu, 17 Sep 2026 12:50:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L9wb32ooQv66; Thu, 17 Sep 2026 12:50:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 39E8280FD8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789649457;
	b=RPGbTF/wZKkai0PzJAqYWAursauPcfbkVXLh9tGt7Lg25fTgN87kWzsx9DMhagp/7XHb
	 EYb9V51ea75yqrrrBYmxnR7CCNfi8h338bC/5w6NzVJBRP6fvZVBgAQF9wQZkOfjGsLtN
	 A1xzvPwi4FlWWbArlQc0RQpoTbIxAM5fITQRx/BU0VWmMTpmQR9aFd6NBCY+oKb8XeGQZ
	 mFOtX9V03PYkdic9Yn11msnAKY7XQJFMHz+WvfohNFex5sC01xSRTCT+On2Saq2Dc2Qna
	 4oFlncs+stesCmXEF3QzBlWcoLgjv1yj0/58wW3ONYQwKze0e5h5Zd/bewo8dC4y7ig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789649457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LXfeFj5t/ftR5GMMUwYLH+yxhO+otxMsS3syMxj8NlU=;
	b=jUoQqTJD2ZY7gTVhgtRNyZ3+fOuqyMgFzts9ANNaE3wy/AGoTshJpO5C+ZO+Ai+kDZzo
	 gddOg3aWiJgjyu1ZNaWJfbMSFpFxAtkVEV1Wt+aNjy5+J/7Xg2wMfnFrs9SoN/HpgTqYv
	 ME56524xAicLQu7Yxoh5S0bOaGIUofqHeIoyGpTsgAhOODprvUpbiLQj2O+55hrhRhxri
	 2kK8CaHthBCp+u9x6byUhDH+VI1mWoryjOL5RGpVpBOCfNWt+9CIRemjK85lJ8AFjY/zx
	 1sTF2jeKhaS+KPDpkLCHU3DomyC0vr0a3NzZ/SSSZkSc5s8ooEdDDfifQ4Ga3RrgIZg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789649457;
	bh=LXfeFj5t/ftR5GMMUwYLH+yxhO+otxMsS3syMxj8NlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yI7DlDH7cPvVje6yyCXZd+Jn43WPoDFjOAFtrCVB3CJRVNL8enPs3TR4/9rKs4C3z
	 pkh5DnXIjhteiSdMbycQ649prOY0rhwIFEh95GGNWrVtAa/MKSIokvK7M61B4ytpBE
	 KqVv/ocSqX+EC19YMPQFODq0MNmoYC3MeFCczkDebNiepAVOdhpDToyX7ItvnvHcfW
	 t4IiqSbVK8NiaL7Qg3jlbklRtN9/vewdXPbvmJ5stMnM5l0pevsJQ6TySvGkpox49j
	 c6ZfKzksfpQuMt0UBhVtk4M3HqTMCNhqDkW3s0R95Yie8uKa2aX1G5inBbBO4T+5V7
	 qohisl0ZhKpAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39E8280FD8;
	Thu, 17 Sep 2026 12:50:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 04513465
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA867407CC
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XykfwMAQ7Skq for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:50:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 73321407C6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789649452;
 b=HmkZZ4DBu1JBrcL12pk4gzL1/bIokGD0DNgCrNWfrc5q6JxYwODjHKu+hG8P8GNnQHg9
 7TEUEvd/Q+pWeUcCo3u1p76tBhQh3+R2PxrFl8G2INAxVtpAv7/bk9eHWJeahGsD6khEf
 ebgdt43pk1C80tuseAET+pLSJMAifc67m0hxoZVGohp2mI30jld1dT9/2DkFtEf14N+uw
 BgMatoc9g63STGa5x1MzfUaW5oBs+BfZnqpS8fqAE5uafmxu6oJdn+Wd0b9UkatvpNuAg
 cblc00Fgknpw3q4tHyxNFOUIWId9USoPPlcJRymLjztRsStyZcEKVtEUCZpcUYdMFHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789649452;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=LXfeFj5t/ftR5GMMUwYLH+yxhO+otxMsS3syMxj8NlU=;
 b=bo6ugeipckm6tYxHFZLV/2DzrRFudFeabtySUb+/ngmvqblVp2m4V90EDEzHpNDflSm7
 yADp6lSdh6GLTdMaSQaGKcP3CMSlLOH7cxYpgqNqd7l4V4RgSM+7dfR0dZK9LrUJAaHCV
 0M+08yDU03IKHrWk15H/Wilt3nxOkyJa2x6clM/aasaYrTq49YKdRh2LZWS2XVJsWXWHS
 ulvl4S5DRF0kPMLXsAreL8lCtbcz7QVHOGJiov29W9n3fYNFFOQZeXYVkEVkqaqZCeu35
 WiNSwUsTSoT4vqzKW4BkyRXf4MjY/Q7atyMWiWPAEjqfUhPNUWuZ2blJJ4WtlK1m/PA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=KhNnGtUv; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KhNnGtUv
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73321407C6
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:51 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so6092265e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789649450; x=1790254250;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LXfeFj5t/ftR5GMMUwYLH+yxhO+otxMsS3syMxj8NlU=;
 b=KhNnGtUv2v9uKOmGZc6NMQMSW1mxGLw/7yWcv3rvH5/aWqC2vPYwVsDaiT00zZtkmZ
 1FaUwTBUcsQGZxs3oCo52q1Ko+/5tEInxbbQthq/qjVW5mt7qjgAU6x2F0vhHjPYnkP6
 4iJkkmUHoXqQgvLGm9f2+LE3SMkTtlklF+1PTuDbVKFxNzLwb9VtRJCnFzKJ6PbHQmgg
 hNu80Io053PfuqfqE+fUU9GSqsVLFqTwXkS6FEQyKhUnOhJC3tA6t7zTmUKq0tPYrjx+
 WE4XWwUZYhkz6fAAQz4/LKDkvAAQ5TTuXiNPP6nyywTZOaNsj8dbXlMXi1o22IvR6N6v
 468A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649450; x=1790254250;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LXfeFj5t/ftR5GMMUwYLH+yxhO+otxMsS3syMxj8NlU=;
 b=UVV7CMsn+ryPsSAA4dAxzJzoghZyp4wbnGWTMipL/S+kAh6oHqWXKtHWtlp4amH/kS
 eB3KYqg4OJr5jtC4FFcnYAx7tpsKAXWyf78KydWlfyxxqKVTmyYXHous60bNX4mhwvJG
 M4X9CedJI5LEgRbV730mHULPiOVI5No+l+XcnivyyOgG89toUODqvXu6Sxp2tiybJSfK
 u8khd6kuRbXFkZhMaFpJr1okgiFDNaYYrZzWFf8qX4Y/Uaa9FlB2mFrNyIjwb4UGuXF1
 Rmp4b9fv7BH3ZwF097uXk3o72Xq9APzY9naM0ZPji+L+SHl1TCtHy+o1zQvypC0LyLea
 rkyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/9+O5TtwwmaSgyDEf58YupkuuBewMXJ6tG2N7R5NNayJL8iWpZHdGIiZbmdpp8HTii2l5zTA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nPiSN8ec7P85GqTKzSU6nAqJpJ5UPnr1mZz9ibBllWWfc9utlV
 JMQIjtNRQ0RlgMsY4OrdiMz+SaRR6/KXv6b1APLoxNQwCKHOl3YDPyF0UlYoDk+EKxI=
X-Gm-Gg: AYBFou0XvRIW29C68djzrPXMUb2ti4s0bmNhA/HQj1meCtWZP0ZYUiwfqAULmgEZawj
 8ONdxzKp7U6UDQLwlPltGH3RBNc81wmpn7UClnpzOz2AzrCNBFI205Vbhd3e6yHo5/cc/ec85Z3
 Luj4scbX8FPJK/bt8TNsD4BNuJGay7L2cZkYAEODoSBMXk9/3SFFsrMapUI8gLJc39ub6RATPWu
 EWyx96ZK7684hGTesy/dEhD8wDAVOo/mmI5eD08S8ZEJAQWJBO94mexb9vgEhY4V/TJ+TVE0DWl
 3x7QuqEwhrbQC3mtmgpO6hzw0yn6vlbk2DkyJeY1J2U5PILErUR+WsdmI+KgGIBIfB/sNnhmzqF
 i9bCkS2BKvEbPZUVQsjtU7XGVWJZz7QX3Q77WXFtxQV7yHugl9sWCnpU3b0+V1vI+xG8JE88a/q
 YZeKWKML5rQ6745mIW5mmeJJsXf9v7/XVMNSdmLsgoVfw8+iKUv3kT05T44CYA6gtgYTUBY1IXV
 arC6g4o9/fKA3Vq9uWMVMI0TKsJoSRjveub8edT3SGI9XFTA3rQ8I2NCaFyATrdtJk8yFzEQ8A0
 NKMalMMKpor+IvcDy8KB7W3zZtXAkwh8XacnZj9aCFRuC3j04f6K5MI=
X-Received: by 2002:a05:600c:c1d7:20b0:499:8704:242c with SMTP id
 5b1f17b1804b1-49f1d51694amr59734225e9.0.1789649449881; 
 Thu, 17 Sep 2026 05:50:49 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f4e6sm88614255e9.8.2026.09.17.05.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:50:48 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 17 Sep 2026 14:51:58 +0200
Subject: [PATCH 03/11] clk: mediatek: use MTK_GATE_CLK_TREE() for the
 gate-only clock trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-clk-mediatek-cleanups-v1-3-4dccf8ed98fc@baylibre.com>
References: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
In-Reply-To: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
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

Replace the open-coded struct mtk_clk_tree definitions of the blocks
that only provide gates with the MTK_GATE_CLK_TREE() helper.

The helper also sets .gates_offs to the ID of the first gate of the
block. All the converted blocks start at ID 0, so this is a no-op.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8183.c |  7 +----
 drivers/clk/mediatek/clk-mt8188.c | 63 ++++++--------------------------------
 drivers/clk/mediatek/clk-mt8195.c |  7 +----
 drivers/clk/mediatek/clk-mt8365.c |  7 +----
 drivers/clk/mediatek/clk-mt8366.c | 64 ++++++---------------------------------
 drivers/clk/mediatek/clk-mt8512.c | 14 ++-------
 drivers/clk/mediatek/clk-mt8516.c |  7 +----
 drivers/clk/mediatek/clk-mt8518.c |  7 +----
 8 files changed, 26 insertions(+), 150 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 5a4863049c5..13fee7a75a0 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -787,12 +787,7 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA3(CLK_INFRA_FBIST2FPC, CLK_TOP_MUX_MSDC50_0, 24),
 };
 
-static const struct mtk_clk_tree mt8183_infracfg_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = infra_clks,
-	.num_gates = ARRAY_SIZE(infra_clks),
-};
+MTK_GATE_CLK_TREE(mt8183_infracfg_tree, infra_clks, ext_clock_rates);
 
 static const struct udevice_id mt8183_apmixed_compat[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 90effc29ab2..3ede5e792d6 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1619,12 +1619,7 @@ static const struct mtk_gate infracfg_ao_clks[] = {
 	GATE_INFRA_AO4(CLK_INFRA_AO_RG_AES_MSDCFDE_CK_0P, CLK_TOP_AES_MSDCFDE, 18),
 };
 
-static const struct mtk_clk_tree mt8188_infracfg_ao_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = infracfg_ao_clks,
-	.num_gates = ARRAY_SIZE(infracfg_ao_clks),
-};
+MTK_GATE_CLK_TREE(mt8188_infracfg_ao_clk_tree, infracfg_ao_clks, ext_clock_rates);
 
 static const struct mtk_gate_regs peri_ao_cg_regs = {
 	.set_ofs = 0x10,
@@ -1664,12 +1659,7 @@ static const struct mtk_gate pericfg_ao_clks[] = {
 	GATE_PERI_AO(CLK_PERI_AO_PCIE_P0_FMEM, CLK_TOP_466M_FMEM, 24),
 };
 
-static const struct mtk_clk_tree mt8188_pericfg_ao_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = pericfg_ao_clks,
-	.num_gates = ARRAY_SIZE(pericfg_ao_clks),
-};
+MTK_GATE_CLK_TREE(mt8188_pericfg_ao_clk_tree, pericfg_ao_clks, ext_clock_rates);
 
 static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
 	.set_ofs = 0xe08,
@@ -1701,26 +1691,11 @@ static const struct mtk_gate imp_iic_wrap_en_clks[] = {
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_EN_AP_CLOCK_I2C6, CLK_TOP_I2C, 1),
 };
 
-static const struct mtk_clk_tree mt8188_imp_iic_wrap_c_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = imp_iic_wrap_c_clks,
-	.num_gates = ARRAY_SIZE(imp_iic_wrap_c_clks),
-};
+MTK_GATE_CLK_TREE(mt8188_imp_iic_wrap_c_clk_tree, imp_iic_wrap_c_clks, ext_clock_rates);
 
-static const struct mtk_clk_tree mt8188_imp_iic_wrap_w_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = imp_iic_wrap_w_clks,
-	.num_gates = ARRAY_SIZE(imp_iic_wrap_w_clks),
-};
+MTK_GATE_CLK_TREE(mt8188_imp_iic_wrap_w_clk_tree, imp_iic_wrap_w_clks, ext_clock_rates);
 
-static const struct mtk_clk_tree mt8188_imp_iic_wrap_en_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = imp_iic_wrap_en_clks,
-	.num_gates = ARRAY_SIZE(imp_iic_wrap_en_clks),
-};
+MTK_GATE_CLK_TREE(mt8188_imp_iic_wrap_en_clk_tree, imp_iic_wrap_en_clks, ext_clock_rates);
 
 static const struct mtk_gate_regs vdo0_0_cg_regs = {
 	.set_ofs = 0x104,
@@ -2080,33 +2055,13 @@ static const struct mtk_gate vdo1_clks[] = {
 	GATE_VDO1_5(CLK_VDO1_DPI1_HDMI, CLK_TOP_VPP, 0),
 };
 
-static const struct mtk_clk_tree mt8188_vpp0_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = vpp0_clks,
-	.num_gates = ARRAY_SIZE(vpp0_clks),
-};
+MTK_GATE_CLK_TREE(mt8188_vpp0_clk_tree, vpp0_clks, ext_clock_rates);
 
-static const struct mtk_clk_tree mt8188_vpp1_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = vpp1_clks,
-	.num_gates = ARRAY_SIZE(vpp1_clks),
-};
+MTK_GATE_CLK_TREE(mt8188_vpp1_clk_tree, vpp1_clks, ext_clock_rates);
 
-static const struct mtk_clk_tree mt8188_vdo0_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = vdo0_clks,
-	.num_gates = ARRAY_SIZE(vdo0_clks),
-};
+MTK_GATE_CLK_TREE(mt8188_vdo0_clk_tree, vdo0_clks, ext_clock_rates);
 
-static const struct mtk_clk_tree mt8188_vdo1_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = vdo1_clks,
-	.num_gates = ARRAY_SIZE(vdo1_clks),
-};
+MTK_GATE_CLK_TREE(mt8188_vdo1_clk_tree, vdo1_clks, ext_clock_rates);
 
 static const struct udevice_id mt8188_apmixed_compat[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index de40821100e..fa1480e19bf 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -1596,12 +1596,7 @@ static const struct mtk_gate infra_ao_clks[] = {
 	GATE_INFRA_AO4(CLK_INFRA_AO_PERI_UFS_MEM_SUB, CLK_TOP_MEM_466M, 31),
 };
 
-static const struct mtk_clk_tree mt8195_infracfg_ao_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = infra_ao_clks,
-	.num_gates = ARRAY_SIZE(infra_ao_clks),
-};
+MTK_GATE_CLK_TREE(mt8195_infracfg_ao_clk_tree, infra_ao_clks, ext_clock_rates);
 
 static const struct udevice_id mt8195_apmixed[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 3fa030d7218..872de82d6f3 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -754,12 +754,7 @@ static const struct mtk_gate ifr_clks[] = {
 	GATE_IFR6(CLK_IFR_SSUSB_XHCI, CLK_TOP_SSUSB_XHCI_SEL, 11),
 };
 
-static const struct mtk_clk_tree mt8365_infracfg_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = ifr_clks,
-	.num_gates = ARRAY_SIZE(ifr_clks),
-};
+MTK_GATE_CLK_TREE(mt8365_infracfg_tree, ifr_clks, ext_clock_rates);
 
 static const struct udevice_id mt8365_apmixed_compat[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8366.c b/drivers/clk/mediatek/clk-mt8366.c
index 533b769324c..cc490641b3d 100644
--- a/drivers/clk/mediatek/clk-mt8366.c
+++ b/drivers/clk/mediatek/clk-mt8366.c
@@ -1191,12 +1191,7 @@ static const struct mtk_gate infracfg_ao_reg_clks[] = {
 	GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_NFIECC_B, CLK_TOP_NFI_BCLK_SEL, 24),
 };
 
-static const struct mtk_clk_tree infracfg_ao_reg_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = infracfg_ao_reg_clks,
-	.num_gates = ARRAY_SIZE(infracfg_ao_reg_clks),
-};
+MTK_GATE_CLK_TREE(infracfg_ao_reg_clks_tree, infracfg_ao_reg_clks, ext_clock_rates);
 
 static const struct mtk_gate_regs impc_cg_regs = {
 	.set_ofs = 0xe08,
@@ -1219,12 +1214,7 @@ static const struct mtk_gate impc_clks[] = {
 	GATE_IMPC(CLK_IMPC_I2C9, CLK_TOP_I2CP_SEL, 7),
 };
 
-static const struct mtk_clk_tree impc_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = impc_clks,
-	.num_gates = ARRAY_SIZE(impc_clks),
-};
+MTK_GATE_CLK_TREE(impc_clks_tree, impc_clks, ext_clock_rates);
 
 static const struct mtk_gate_regs impe_cg_regs = {
 	.set_ofs = 0xe08,
@@ -1241,12 +1231,7 @@ static const struct mtk_gate impe_clks[] = {
 	GATE_IMPE(CLK_IMPE_I2C4, CLK_TOP_I2C_SEL, 1),
 };
 
-static const struct mtk_clk_tree impe_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = impe_clks,
-	.num_gates = ARRAY_SIZE(impe_clks),
-};
+MTK_GATE_CLK_TREE(impe_clks_tree, impe_clks, ext_clock_rates);
 
 static const struct mtk_gate_regs mm0_cg_regs = {
 	.set_ofs = 0x100,
@@ -1321,12 +1306,7 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM1E(CLK_MM_32K, CLK_PAD_CLK32K, 19),
 };
 
-static const struct mtk_clk_tree mm_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = mm_clks,
-	.num_gates = ARRAY_SIZE(mm_clks),
-};
+MTK_GATE_CLK_TREE(mm_clks_tree, mm_clks, ext_clock_rates);
 
 static const struct mtk_gate_regs dptx_phyd_sifslv_dig_glb_cg_regs = {
 	.set_ofs = 0x8,
@@ -1343,12 +1323,8 @@ static const struct mtk_gate dptx_phyd_sifslv_dig_glb_clks[] = {
 				      CLK_PAD_CLK26M, 0),
 };
 
-static const struct mtk_clk_tree dptx_phyd_sifslv_dig_glb_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = dptx_phyd_sifslv_dig_glb_clks,
-	.num_gates = ARRAY_SIZE(dptx_phyd_sifslv_dig_glb_clks),
-};
+MTK_GATE_CLK_TREE(dptx_phyd_sifslv_dig_glb_clks_tree,
+		  dptx_phyd_sifslv_dig_glb_clks, ext_clock_rates);
 
 static const struct mtk_gate_regs epdsys_config0_cg_regs = {
 	.set_ofs = 0x100,
@@ -1396,12 +1372,7 @@ static const struct mtk_gate epdsys_config_clks[] = {
 	GATE_EPDSYS_CONFIG1(CLK_EPDSYS_DPI0_MM, CLK_TOP_EPD_SEL, 1),
 };
 
-static const struct mtk_clk_tree epdsys_config_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = epdsys_config_clks,
-	.num_gates = ARRAY_SIZE(epdsys_config_clks),
-};
+MTK_GATE_CLK_TREE(epdsys_config_clks_tree, epdsys_config_clks, ext_clock_rates);
 
 static const struct mtk_gate_regs vde23_cg_regs = {
 	.set_ofs = 0x8,
@@ -1417,12 +1388,7 @@ static const struct mtk_gate vdec_gcon_clks[] = {
 	GATE_VDE23(CLK_VDE2_LARB1_CKEN, CLK_TOP_VDEC_SEL, 0),
 };
 
-static const struct mtk_clk_tree vdec_gcon_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = vdec_gcon_clks,
-	.num_gates = ARRAY_SIZE(vdec_gcon_clks),
-};
+MTK_GATE_CLK_TREE(vdec_gcon_clks_tree, vdec_gcon_clks, ext_clock_rates);
 
 static const struct mtk_gate_regs ipe_cg_regs = {
 	.set_ofs = 0x4,
@@ -1444,12 +1410,7 @@ static const struct mtk_gate ipesys_clks[] = {
 	GATE_IPE(CLK_IPE_GALS, CLK_TOP_IPE_SEL, 8),
 };
 
-static const struct mtk_clk_tree ipesys_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = ipesys_clks,
-	.num_gates = ARRAY_SIZE(ipesys_clks),
-};
+MTK_GATE_CLK_TREE(ipesys_clks_tree, ipesys_clks, ext_clock_rates);
 
 static const struct mtk_gate_regs cam_m_cg_regs = {
 	.set_ofs = 0x4,
@@ -1481,12 +1442,7 @@ static const struct mtk_gate camsys_main_clks[] = {
 	GATE_CAM_M(CLK_CAM_M_PDA, CLK_TOP_CAM_SEL, 21),
 };
 
-static const struct mtk_clk_tree camsys_main_clks_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = camsys_main_clks,
-	.num_gates = ARRAY_SIZE(camsys_main_clks),
-};
+MTK_GATE_CLK_TREE(camsys_main_clks_tree, camsys_main_clks, ext_clock_rates);
 
 static const struct udevice_id mt8366_apmixed_compat[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index a0beae8fa5f..a6fbd6376b7 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -815,19 +815,9 @@ static const struct mtk_clk_tree mt8512_topckgen_clk_tree = {
 	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
-static const struct mtk_clk_tree mt8512_topckgen_cg_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = top_clks,
-	.num_gates = ARRAY_SIZE(top_clks),
-};
+MTK_GATE_CLK_TREE(mt8512_topckgen_cg_tree, top_clks, ext_clock_rates);
 
-static const struct mtk_clk_tree mt8512_infracfg_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = infra_clks,
-	.num_gates = ARRAY_SIZE(infra_clks),
-};
+MTK_GATE_CLK_TREE(mt8512_infracfg_tree, infra_clks, ext_clock_rates);
 
 static const struct udevice_id mt8512_apmixed_compat[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index ea00b8dbca1..458aad3c5df 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -767,12 +767,7 @@ static const struct mtk_clk_tree mt8516_topckgen_clk_tree = {
 	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
-static const struct mtk_clk_tree mt8516_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = top_clks,
-	.num_gates = ARRAY_SIZE(top_clks),
-};
+MTK_GATE_CLK_TREE(mt8516_clk_tree, top_clks, ext_clock_rates);
 
 static const struct udevice_id mt8516_apmixed_compat[] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 4fef36f458a..f2472d039b0 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1523,12 +1523,7 @@ static const struct mtk_clk_tree mt8518_topckgen_clk_tree = {
 	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
-static const struct mtk_clk_tree mt8518_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.gates = top_clks,
-	.num_gates = ARRAY_SIZE(top_clks),
-};
+MTK_GATE_CLK_TREE(mt8518_clk_tree, top_clks, ext_clock_rates);
 
 static const struct udevice_id mt8518_apmixed_compat[] = {
 	{

-- 
2.55.0

