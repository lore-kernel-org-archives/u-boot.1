Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E76CA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B263A607E3;
	Tue, 29 Sep 2026 12:36:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vTCJ1AvlkL_T; Tue, 29 Sep 2026 12:36:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D0777607CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685407;
	b=kuqxyvdo4oHmyy/sNU8zf4h+omYX2pYs5H5mtTdFm4foK5dPsl7LbgEot22nWfLLGp2A
	 ++R0a4VUc/BNpsJH3hAQZx2CQU+l4B6satsZu0UGwujJy/CUjXTQoYJurojblTnPjLWaU
	 q/bYWCr3TDfpM1YuKzbq3uvL6E7IiBeeSYO6tggmC1SUObA1iboPL6RKxEVsrBJo/P5Eg
	 BlQUgNu/mNzH05oHEOU8CkE+jF/h4iYCwBD+kT3/pLGqjbXF/dP9+Ls/2U8Cju1sR2AkB
	 g2vepX/anSAIy5NuW1FVb/Uzg8JaqG607kEYiZxgL8XewXNVu0Y0iFPO4GxrOWAtEgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Nnt2zBacIwIbsE95EO4S68EUjo62fSZmfxW+VbBOka8=;
	b=bBJF5X11Y2+XZ/lNVKhjwzIa8+YaW7M6YXFCcn2zOkh2S0Dg3f+mwv+F68p2ORvK+NsH
	 4Dm0ftgPcGqfqObHHxRC3crI7QYrA6awqWl69a9sIVh7yJPirq/g1gmYxYt4mUGhWBsRD
	 uLO9vGyBFeFDs9p1w94IcqFLklS4LZ7ufWjpUrfUhdzs5BGEF+tR9bwh2oi63oS43bxTj
	 kqKhbt069a+fzAZPNXcJ/K8cOZzkzVPp//BUNzWRFTDmD7eP/tRbzWf0dvtaHF410mt66
	 z1VNl5fUBy/SV0Ut3qFkodCP25kjlopl3tzqB0h8d4giCjNyiymA+Kw+/OPHVJTaU/w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685407;
	bh=Nnt2zBacIwIbsE95EO4S68EUjo62fSZmfxW+VbBOka8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OYrkDpBHdkIZgGEyypgt6lmZe1LoWvUkyQS5+KUlcNdEWCRQzWzqF0Kaa8e0qBE8W
	 reMW9xr0t6c6Dv7z7Gw87O6tjCqD3uR91cxkr5gxhu7v5s5VgcnwnoN21iFTT2gOUO
	 4Qg9thl+tQ7KwjLLRhtuwWc2n/2uDVpFw1tK97ljlwIbfxnZYNcjrvPZQPnCPe3ILp
	 mtckeTij4nSI1vHCm9Tpf6rfL78SGEpyxL5tna0k6i6XWSru791BGWyb9BfhkKjHVW
	 RS0nyi8k8p3o68XrKeMcdaNnc94S2Z+cK25GOyWQtgeennPnds+Y4nR3z3zwq045CB
	 EA/qlo88RbB9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0777607CF;
	Tue, 29 Sep 2026 12:36:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E8C6B32F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9EC680E32
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H57Ko00T9gNE for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:36:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DD68780E3B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685396;
 b=Bbk9XSEBQiuLBlceT3SszETEx9owK5JUw72FZs2/nc5688kneXvmI/19gdaPo4rzrh6B
 joa2pO1G0mowrBPl0jZQ9t2RERfUixjerMbXL8823xyLvPDAj/bwEHi1BdvZW7PLXs6aj
 wRfl5sDFqeRYMOZHmbd+qJzig1wOr7dpxEsVKgB1GWwCMZqLoWqmaooqBjod2wnMusgNz
 Y9L4bctpenpXTfWW4iF3ByrsjjLIuOZxe7so57AfU4K047PwIqOszGP8yd9On2lqMC21w
 omFu4NgpMTldGrdraWr//l+MbBdHK0iGw9PlcRBymaN5oexzCFAUhxLrPSTZWb/N/TQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685396;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=Nnt2zBacIwIbsE95EO4S68EUjo62fSZmfxW+VbBOka8=;
 b=mpFX13R7rQe6KnyjqQHn7R9yyQiA4hxXFFIakwzdn1yHKIqcMyTKgpqgs4TLgEw1hssO
 ILs+LmxL67QvhAvPNb8Wr13XsLGLv5KwpvwVwyxBlHC3SmGVIvE6vh6yCyPLA9jAvgxU9
 RUgsD3RqM5+V+9EJbPFG2NUEqd7Gf0nXIjCvStI8vIKIlxhVRwloG+647h44GYXL4p/rB
 UQKgGGDyghrl0jXYQEHU9h7C8vM8w8hetjimu7E4Xcrg1NrUKwHJd+iY4rlTGyP8K0RGy
 glzo1RZ/fG5//5JOPHkJTL6iCnyTDnA966S9fjnLKDCqyaUchOovYqU+10cXbYVLDPw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=PSh3anoh; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PSh3anoh
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD68780E3B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:34 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so30974345e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685393; x=1791290193;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nnt2zBacIwIbsE95EO4S68EUjo62fSZmfxW+VbBOka8=;
 b=PSh3anohhbA3DZkdYgDFSioVbS+dkkklVAi/87RrOpvMyiuzVt0RyEGzyNqUbsH+l/
 ZcB+zzrLzWIHdXX6y92nB0wGhE7N1KG4yCAvi10jhDGxGauVbS0FjyqzD+0+2KLB7mtO
 0OiqIyZV9lX4K/chc46aLUmPzS0Uq6mHOK2of+QCKC3Ydwnj5c7o1GsEPNgUq6SMqHqr
 T6/pWFhnWqGjWQgzTmO1v8gzhT1vMv2usjEaHCPsZr0GzPy7d4KI0sRB9EI1AcXlbT6h
 h5Hy8h+RAF/edw29dRSyiC9e9R1MPLLCNPIKu+jBSvVC050Aot5JDzzx0ATNjIFhpmU2
 ZwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685393; x=1791290193;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nnt2zBacIwIbsE95EO4S68EUjo62fSZmfxW+VbBOka8=;
 b=Yr6sH46P/ljm3m6wW6YUMBPR2/MYdsvg8W7/eZqReYMPsltTAA5tEA1J5GtPCKkNVY
 up7DbxBPftBwucgsI9S8dKpBevElZWjNHkIueOeS9sCRfrfVgI2/TZ36tPxLkwGly9Kj
 rPmZjVHRoBaziBGRGqajvFYcC3AMuRpdUgJMVvRn8hg8eoIkhzK5WkvEkP55lV712Az3
 zIQxg9fj0PBFyvRk5PvyQIu7bzIvGfCXoM9QklLUaF9AKDvCX3O8twZqj4WdZdeTlf3c
 +ecoK24dU6UQZEBD9DY5Vh4X3bx/bfKZUyWDx+HZFdEfTRAoq+rijjUWDpAPYZIGKNWf
 QYAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjbGNlX2fn2hYFTAKygZGWrFMIstZ7qDY8pzOaU7ecna51F8C2DGogErGgiVesPPKrvIpjz8c=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k7jqOG5qt9URYJpU9akJxthzVXgLgY8Zyt4qIMby8TD0o+DCiD
 egUjVC/attXFrEmicMIIzKoZLTwEz6QEHHYcvXi4qAYqcy9d3e18DqwrJ4azxGdYpG4=
X-Gm-Gg: AYBFou3Gigt61Q9neXBJdN8hv5R9S8tv/7/9BmC4ZuUp8rrB2k/n8S3wEsRqqapO7rA
 v7H/H+GBhaabh/wqZN58Pz2BdaN1wNDC2OpLHUq3WsPkR80ctial6oi8TkL+tSG7AIKOJPa8I7D
 70zl+e2yEWRvA+GIwEawhoZlE+9sf9ml01sEdNcj/t8Td2odgloExLD2mid1crU1RRsCrQKIki5
 c/Y1p1U0Xc5TDGT3yXk/vgeKPZOGVY+iuNRXShNsuYvIaAnSw2jpLMf+lRmt5T/gyYu+Kmf2/M7
 QPriu5VBlmEs61T3sIluwH5tYSnQ39bTxiSvYWbOxJOuPk8NCzlxZCfM125Q5C9/YBQko+Lbpc5
 n90kFDWlE63GzrvDgv2bAwLznlvXCXnJH/+1ejB+YSjT4Idm2vgCeSV0AaqBFrHuntHHKEU2LK7
 dsCar+ycm9TwvAf1BGNaUi1aqmmnlC68oBIyoHwrkuh49CVBNJubbCocn5iy2sUc083VLMqxDC6
 IF2Pz9C4CPRbHGtvjQ5/ewupD9jHHzNMcohfozTGWDOX4YlhfvuVh7j7rNRRsXNduuV7In6+oCH
 B8xdnDqqiPNaOydQoOEl4gdh3VQVoKgMtLdWiUKE+3xXMW1omvfyD0Y=
X-Received: by 2002:a05:600c:628c:b0:4a0:f4:1c76 with SMTP id
 5b1f17b1804b1-4a000f41d51mr119939855e9.4.1790685392683; 
 Tue, 29 Sep 2026 05:36:32 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cfc788sm450305e9.2.2026.09.29.05.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:36:32 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 14:38:44 +0200
Subject: [PATCH v2 06/11] clk: mediatek: mt8189: merge the clock drivers
 into a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-clk-mediatek-cleanups-v2-6-b296bf3a4a93@baylibre.com>
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

The topckgen and gate clock U_BOOT_DRIVER entries only differ by
their of_match table: they share the same probe, ops, private data
and flags. Merge them into a single mt8189-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

The gate entries, which used to be written on a single line, are
split over two lines, for consistency with the topckgen entry and to
keep the lines short.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 57 ++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 05e5593c714..6a69c78f857 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1986,11 +1986,39 @@ static const struct udevice_id mt8189_apmixed[] = {
 	{ }
 };
 
-static const struct udevice_id mt8189_topckgen_compat[] = {
+static const struct udevice_id mt8189_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8189-topckgen",
 		.data = (ulong)&mt8189_topckgen_clk_tree,
 	},
+	{
+		.compatible = "mediatek,mt8189-peri-ao",
+		.data = (ulong)&perao_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-iic-wrap",
+		.data = (ulong)&imp_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-dispsys",
+		.data = (ulong)&mm_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-mm-infra",
+		.data = (ulong)&mminfra_config_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-ufscfg-ao",
+		.data = (ulong)&ufs_config_ao_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-ufscfg-pdn",
+		.data = (ulong)&ufs_config_pdn_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-vlpcfg-ao",
+		.data = (ulong)&vlpcfg_ao_clks_tree,
+	},
 	{ }
 };
 
@@ -2002,17 +2030,6 @@ static const struct udevice_id mt8189_vlpckgen[] = {
 	{ }
 };
 
-static const struct udevice_id of_match_mt8189_clk_gate[] = {
-	{ .compatible = "mediatek,mt8189-peri-ao", .data = (ulong)&perao_clks_tree },
-	{ .compatible = "mediatek,mt8189-iic-wrap", .data = (ulong)&imp_clks_tree },
-	{ .compatible = "mediatek,mt8189-dispsys", .data = (ulong)&mm_clks_tree },
-	{ .compatible = "mediatek,mt8189-mm-infra", .data = (ulong)&mminfra_config_clks_tree },
-	{ .compatible = "mediatek,mt8189-ufscfg-ao", .data = (ulong)&ufs_config_ao_clks_tree },
-	{ .compatible = "mediatek,mt8189-ufscfg-pdn", .data = (ulong)&ufs_config_pdn_clks_tree },
-	{ .compatible = "mediatek,mt8189-vlpcfg-ao", .data = (ulong)&vlpcfg_ao_clks_tree },
-	{ }
-};
-
 U_BOOT_DRIVER(mt8189_clk_apmixedsys) = {
 	.name = "mt8189-apmixedsys",
 	.id = UCLASS_CLK,
@@ -2023,10 +2040,10 @@ U_BOOT_DRIVER(mt8189_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8189_clk_topckgen) = {
-	.name = "mt8189-topckgen",
+U_BOOT_DRIVER(mt8189_clk) = {
+	.name = "mt8189-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt8189_topckgen_compat,
+	.of_match = mt8189_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -2042,13 +2059,3 @@ U_BOOT_DRIVER(mt8189_clk_vlpckgen) = {
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
-
-U_BOOT_DRIVER(mt8189_clk_gate) = {
-	.name = "mt8189-gate-clk",
-	.id = UCLASS_CLK,
-	.of_match = of_match_mt8189_clk_gate,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};

-- 
2.55.0

