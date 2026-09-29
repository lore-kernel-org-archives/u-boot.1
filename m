Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A84CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58BF080E56;
	Tue, 29 Sep 2026 12:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b2o_XgJ5jU1S; Tue, 29 Sep 2026 12:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 892D580E3B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685397;
	b=aVs/dsaH67SLuLH9OpV9IhBZGnxfOqUMBDqszsvlxo9skdxSgcSVlnV7b9zp+mcDPRyx
	 IQpc68CtlAEGvJZ+KrhRP4YwFFI2Imt82cqSPEpbBBtAXU8VFZDcnQZN7ubtEFa6WjIlS
	 iqbPSNsnE671R2985HXG2Bh1K6bfnu9XKtI2obBjZtTtiACnTu5ENHDSqntUlssvbndYo
	 jkuvMHa7wDEmiZmoiv4OLqauuhDSXpEO3NtVPcJ4nxj2vl9ZgDttb6ubLFG9ejgGIHu00
	 BanmZhabvdE7HezGvOxtl0GRkZqtUWufZmxbRtS4r1JXw+Irh+2cU7Ml7cElmdf74aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3ZRzRUxAMEqu9jrugVGCy2Y9TdFEtkpI5CCPKNk8qxw=;
	b=e4/YEp4BT5AXndJuX5t3LWZ22085sk0AsyTXuzhalB6o550XXl15hO8DV9sYAzLtzgC7
	 6z8ZmK30o9ZVFh9ToXSqLbbQdnFBp/etAvFS8+vp5hqRAC6pW46rzrGcsJfLZ0U0zWhNV
	 eVhrT42Zp2GamklOFXV7NVaoa62VvzYIK2orjHA1NjkLyVqs+r7m/jrZRqksFI3iLPJtu
	 GaEATKVEnzSPHNkxezmTKpgFribxkkqQYO2kBKuLRe443k9iogIFwerEIx4cLeWUsXgvA
	 W1XdAVQM2PaWL2ppIIIGVbxt31iV58tPRA/pPm4cRupUZu5rLV488n+BT+1Pm0TbX3Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685397;
	bh=3ZRzRUxAMEqu9jrugVGCy2Y9TdFEtkpI5CCPKNk8qxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EuPJigh434+1WQ7RsSGE2+WtojX4PVWAw8bbjfjo5YotQ8mtUy2KMQ+Qkl9Oyn7U9
	 2XLI4aPgKxQsu8l8VYdQGWMp/rnNssCYIhg4/WSQzpHVSo0wQKvAkvmwUovEB/M8zg
	 CGr2yResfdZf22Tu/sx52GXJ5mVY97RLj2gSwM3VRfw2ZHgaTUuvug8cuOyXmKMZqa
	 V0aYS6vwh+WawrawMPiff8eMaQuQi20qY3Yqe7nMvSqdd217OUTdj3amOL68wHoRok
	 CnmIK2wKeM0uFnAh1LoVlFHBT+yly/T8Xkt+OQrBHe9LzANrM+5aqNxjzS2//cpwxE
	 XiCM+4fDTFoTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 892D580E3B;
	Tue, 29 Sep 2026 12:36:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CCA6335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3FCA406E4
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k7Qs5HFEzmsk for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:36:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E7C5A406F2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685392;
 b=PNW5HqNhmo2bH331i7yFrgU9/Yo2svD09MzqbB0SHHMl+4jRUDNc8zD8UHnucy8TRdxv
 B7LGQ+znXwUpBz7CNMvYMO0Z4wqC8yh1lQC6iT+OfV0b0NhKuCjUdf5JB9UKUj7PFNloo
 LZMBVx+hQ712OWVN4oQy/tNurVhBSW/kBcCcY4dpoR+XbqJ7F6U8keXPgdZydumnmbFt+
 UiZHElpnQ1e4wrBW6uXR90l3HPho0t20PsBQXVbbudsq/BOt8q091c2QFfALl2qzdwTJ6
 ZaAkAEYLyz8zPhpaYBEq3aYizmNt1kGSqcFcoh0aAbFfFEy+WvJlE5KMaYYp2/yPIRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685392;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=3ZRzRUxAMEqu9jrugVGCy2Y9TdFEtkpI5CCPKNk8qxw=;
 b=atCakCCyXtmFKlq7sItMfp6l+wluWha5DSqMM3sr49W1zARKc12cT+B6UIjlZAQ+ctQK
 OysyNDduepcZYm0rDH5hq8pXA2CPuJ7fBZdFNbkPqA024uLH/82OGSMdyhvIvak8r46WN
 +t12WiSKklG6+AvwdkgE5rOqLCIZu814tsIoD8aXmfWgEVsyyGW4dveZ8BKmMbY9SLtNZ
 H0XLUSvCbpkRcQ+B28KW9yxPP2T7SXCEkabeyOP+z5RdiOFFks2pwrDj8eaZ78EsrSVfP
 yi5L3YDjaARE2YKJR4V2yvdSQTH4LKKlczwj0nMSNwlAA7fQHzGfq4YSnBnxzbx5vNw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gxby2AiK; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gxby2AiK
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7C5A406F2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:31 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffe281cb1so18525295e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685389; x=1791290189;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3ZRzRUxAMEqu9jrugVGCy2Y9TdFEtkpI5CCPKNk8qxw=;
 b=gxby2AiKoG1T3HvWlzVVhQk+qBzBEPTUnVZduJy/scKC1g8zTmG1reFwDAh9Du/hVZ
 eJnqMrQWzHnqgsoA6nG1WgzeTR6i+9eXUj6Fq1vhRc5GDUwi1lZw4omph/j6umspcnhA
 yF1HUDeekRn6KCcFCnL3TGvjhdV91zbJQjPMXIVOHIL4Tw2xq0f9kZXeW4fw1CMuKRvo
 i1G0Jk3sd8r7yk/kDIgOism0Z4ZNTUpd0oJitrdsXdFekww3QozFH+Lxk5Ic09DjmMBs
 u++14ITcjwKdiOqRjwBCo0nbF17frAlwuRBPt3l8UrTuw3WgchXnHN3je7YSGGee7ytW
 j5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685389; x=1791290189;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ZRzRUxAMEqu9jrugVGCy2Y9TdFEtkpI5CCPKNk8qxw=;
 b=Va7HRaCM1zevl07+iv4CQ89JUj4JJ/iEpkkZ2mw0X/X9f4E97gjPmka/dVN/Ty6CSR
 /QqRWbhseR7kMwrNmeNaizbHYlJQoM50amNKZLieHSc2FJCRblp9AzxIei7sWJzuICqq
 mWnIDLmhBh1S6jRJjHWKAeTtEgApA1NgwIyXoEYJ3GVyi7kgJ7IbWC+ldy/cbb1H09MM
 YaZX6xUFpmtKP6y3niyXo0ncb9Qk9NtaNHDe5AtOq4yBlQOR1EjJbQhDD7Z0RXjInBy5
 mPxbda2GSGBMZ/7IHRuqCpeW4QgsAHhJAbSWN1/V4BGYs8GbFmYLWPE1p6S/2n5EvgQt
 bbrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5Oul5tO1HyW8QnYPt2WBOA/4yVkPNmDqfvw0NhTWxYsf+dh1J7lobma0TAwE1MxYcCeSGg/E=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nWAH8c1SSurQX8C4Iy9pECgAXknATXuaFeohUS68FSxpDQpGbT
 AXAhvLr5KogTXV7+dU5qKAnvZGxJ/bF8ZVU9Hllif50MNdQErQropsRxA1hDcktWphE=
X-Gm-Gg: AYBFou0nigtfmnMOtZ2OP9yubw9qK0sqAzztx23dO3YtWlmdoJFtHN28yeU0i5mIand
 quyAgNedEzWO16ZEDjTSWktZ9gWYi+VlXSI8raXLGYLrIQLrbwARShceMOB25IXUb0jsb68WkIJ
 rWMUNxPXO0X8o91DA+Xmv8rrfe5nZQnL/hsk0d11aTUk+d4JvykpPWy9eDGIYMmgfrLeZ9S6DLS
 4UPFR3sk3g0c+tlsVxp61d+SwNrsS7Rcpg8k7EenKCCRC6p8r9CKK3Y2QgSd4sCNdT3uzGuYY/S
 nyRFu3Kbk1V5ADNN4Tt36xtB0a92hmwKciYw8mFu6dtFaelTYwh2F9n+z8+Jj1CDNOWZbqUxb4f
 3dPu4NGIb7zV1lqffe8BBe2fX7EBjINOjcdQ6aoxZ9p0+MrszOu0dw70hispIU1xsuvuJmIc8/d
 wWGXg33wu6v0BiaKM5SpBWKo0s5r+yT4jlwT0rp4v5VmxN8oiPaHmH4JE/Pr5S1q4djglYuA2es
 EEoYml2HRXuzz3rGMKZ3QRiixVX9cOeDf5wKyTkSn9mUwGJSN1URkKPhHRBxvZE1aLs5cgPaEPl
 JBPm+3j6cZF22l3MQrvMsieOHv2V8e1E5c4FXI5AdM7E4KyZPty+7I0=
X-Received: by 2002:a05:600c:698c:b0:49f:df99:ff1a with SMTP id
 5b1f17b1804b1-49ff06e503cmr222376395e9.17.1790685389300; 
 Tue, 29 Sep 2026 05:36:29 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cfc788sm450305e9.2.2026.09.29.05.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:36:29 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 14:38:40 +0200
Subject: [PATCH v2 02/11] clk: mediatek: add a helper to declare gate-only
 clock trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-clk-mediatek-cleanups-v2-2-b296bf3a4a93@baylibre.com>
References: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
In-Reply-To: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
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

Subsystem clock blocks only provide gates, and every one of them
declares the very same struct mtk_clk_tree boilerplate. clk-mt8189.c
already hides it behind a local GATE_CLK_TREE() macro.

Move that macro to clk-mtk.h as MTK_GATE_CLK_TREE() so that the other
MediaTek clock drivers can use it too. The array of external clock rates
and the tree name are now passed explicitly, so that they can be grepped
more easily now that the macro is defined in another file. While at it,
move the clk-mt8189.c declarations above the of_match tables, next to
the other clock trees, in preparation for merging the clock drivers into
a single one.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 25 ++++++++-----------------
 drivers/clk/mediatek/clk-mtk.h    | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 3724dffcc3a..05e5593c714 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1970,6 +1970,14 @@ static const struct mtk_clk_tree mt8189_vlpckgen_clk_tree = {
 	.type = MTK_CLK_TREE_VLP_CK,
 };
 
+MTK_GATE_CLK_TREE(ext_clock_rates, perao_clks_tree, perao_clks);
+MTK_GATE_CLK_TREE(ext_clock_rates, imp_clks_tree, imp_clks);
+MTK_GATE_CLK_TREE(ext_clock_rates, mm_clks_tree, mm_clks);
+MTK_GATE_CLK_TREE(ext_clock_rates, mminfra_config_clks_tree, mminfra_config_clks);
+MTK_GATE_CLK_TREE(ext_clock_rates, ufs_config_ao_clks_tree, ufs_config_ao_clks);
+MTK_GATE_CLK_TREE(ext_clock_rates, ufs_config_pdn_clks_tree, ufs_config_pdn_clks);
+MTK_GATE_CLK_TREE(ext_clock_rates, vlpcfg_ao_clks_tree, vlpcfg_ao_clks);
+
 static const struct udevice_id mt8189_apmixed[] = {
 	{
 		.compatible = "mediatek,mt8189-apmixedsys",
@@ -1994,23 +2002,6 @@ static const struct udevice_id mt8189_vlpckgen[] = {
 	{ }
 };
 
-#define GATE_CLK_TREE(_name) \
-static const struct mtk_clk_tree _name##_tree = { \
-	.ext_clk_rates = ext_clock_rates, \
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates), \
-	.gates = _name, \
-	.num_gates = ARRAY_SIZE(_name), \
-	.gates_offs = _name[0].id, \
-}
-
-GATE_CLK_TREE(perao_clks);
-GATE_CLK_TREE(imp_clks);
-GATE_CLK_TREE(mm_clks);
-GATE_CLK_TREE(mminfra_config_clks);
-GATE_CLK_TREE(ufs_config_ao_clks);
-GATE_CLK_TREE(ufs_config_pdn_clks);
-GATE_CLK_TREE(vlpcfg_ao_clks);
-
 static const struct udevice_id of_match_mt8189_clk_gate[] = {
 	{ .compatible = "mediatek,mt8189-peri-ao", .data = (ulong)&perao_clks_tree },
 	{ .compatible = "mediatek,mt8189-iic-wrap", .data = (ulong)&imp_clks_tree },
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 9244542a2a5..fc7b7955228 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -8,6 +8,7 @@
 #define __DRV_CLK_MTK_H
 
 #include <linux/bitops.h>
+#include <linux/kernel.h>
 
 #define MHZ				(1000 * 1000)
 
@@ -274,6 +275,27 @@ struct mtk_clk_tree {
 	enum mtk_clk_tree_type type;
 };
 
+/**
+ * MTK_GATE_CLK_TREE() - declare a clock tree made of gates only
+ * @_ext_rates: array holding the rates of the external clocks
+ * @_tree: name of the struct mtk_clk_tree to declare
+ * @_gates: struct mtk_gate array backing the tree
+ *
+ * Most subsystem clock blocks only provide gates, whose IDs are
+ * contiguous and start at the ID of the first entry of @_gates.
+ *
+ * @_tree is declared static, so this must be used from the file
+ * defining @_gates.
+ */
+#define MTK_GATE_CLK_TREE(_ext_rates, _tree, _gates)		\
+	static const struct mtk_clk_tree _tree = {		\
+		.ext_clk_rates = _ext_rates,			\
+		.num_ext_clks = ARRAY_SIZE(_ext_rates),		\
+		.gates = _gates,				\
+		.num_gates = ARRAY_SIZE(_gates),		\
+		.gates_offs = _gates[0].id,			\
+	}
+
 struct mtk_clk_priv {
 	void __iomem *base;
 	const struct mtk_clk_tree *tree;

-- 
2.55.0

