Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8187AC9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C25D811D4;
	Thu, 24 Sep 2026 19:44:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1amiANFam37H; Thu, 24 Sep 2026 19:44:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7E86F811DB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279053;
	b=n9vEXYGZnQ96dsy5tIhlKbPZiTQ85Hahv0bhaob5mWzJhcq9AoffTFNJihblXWsFB0XH
	 7wQtmuCHMvc2feblnz6Z9GW8Q3Ul+VXaZ/8H140oHNF8JL+RR2KIN79dYo0BxOw3W67Vo
	 E+8eQFtNjFi/2Hmns86TqbdChIXqOBEe8bbHzb1ZccUp1lBA+Laao7/A3oPi6mQf9H8jW
	 accr+be1QfEPoBWDGaOS8S3Cf4ZJP7PiRYMyth89S0fiN4wk/RInbjDdjCeHymxwG7HW7
	 K5IeDDQDB9MPJ5+4CVF/cU83fpMDusyH+OrC8m1ldPUJg4cT4qAiJyhQ9XWcw3GpETQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279053;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8BgfGBzVPpH4v3lw8MgDQwMbxoUwG5BNNnFKSpj/mus=;
	b=gnhOZXar3XjwQSGgVYaJg4BPYCowRRfaF1g9as/8GgVhDRp9W5vP9aCdkmttTRQrxcnc
	 NH2HcKmdQvYoyDhFney1zPe61DseaX5gv3mDthsvEcDHO8b4DjPDpJ2Tm/4D7YxJbEOE2
	 VSeIYVYckfBeOeBoMm24GKDErMA7Z2YdhWGJsRMzkfejPTYE45qKXppHdYqyFgl6+aEO5
	 zw88hYDEpHVWSRQzNrwzMZV8AC5QchNFekwQ8JZjqnTEdaoLUDZ94RCKRZrLYUZTjZZR5
	 OtCXCODItPujgSmwjsGj8LUAwtJcnI7uUFZLJDektC9tGwps5kpZEUmMMFLcH0u9DrQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279053;
	bh=8BgfGBzVPpH4v3lw8MgDQwMbxoUwG5BNNnFKSpj/mus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UrkOUBnZvsUhNSINo4OzlC5S9lk5GiZlb7p7Ne/KcABcHizC4rD/HgPv9N+zc3jMn
	 aSZC3l4UDqldc7/Qn3TlKhBz5Vofw5lfeDbFteQaBtXv0NC11xNkrkfi9bnelFYMB+
	 +Zm0NP5ZdVZjJFECYx7bVrlOM0W8NbviB4rAiKFohyc11F1Tp3uGUbLjRXkCkV7yIq
	 5AI2fvqJ3gLnYlqDzst3VQC5C4dno6K7s1rAmw17EtZMWBXabeueVxQEDBXet+DE0A
	 ILfoU3vtiLu+nlF3FpByV3sE/NJmTXLtpUA3agXWKdBZRhC2PlrRfo9qS/i0g8qDK+
	 sPeCvtw9fRX4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E86F811DB;
	Thu, 24 Sep 2026 19:44:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 377F32F5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 299274017A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ORYndlyPePpC for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:44:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5A2FF400B5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279041;
 b=P6CKmxtJCPEJKx3Xmiul6DJS5yfOIdx1T4QdRxTRpTBbd+pB881oHeiAfTJ8h7PlkbPa
 jII7f5u6gnhnf+Hs//CkfZuy1HA/7RDhx1ByDbd0kGkKnd7A1cSIdZcL1adjmHRLuRFt1
 Bet6qR9QY0rrGcmJAvQPg1tvOcWGWVnQIMiYH30rxhUmHJ4DdcLp9svtW/C/iQdVKG86c
 2WrwJlaI4LAtKHu3Ptn60fz6ah9bkFrlu9LwzIBjScuCGOc/op+tW8eyCix2Zb6iR6k0W
 9+LZjJZUgyA4F9BVhfbFo7qI50+vie1Z57YPEa9C/PM5Pob+bTgouIh1gaapDgYPIXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279041;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=8BgfGBzVPpH4v3lw8MgDQwMbxoUwG5BNNnFKSpj/mus=;
 b=YTKctsj9nha2ltuUeDHSpSTSyzVMYE//1R32MZwM6sBnhddyfmmt2OyJ/+6ir46ymzoK
 iNM4SQzQwHvFpAVm0VedkRdWgynG7mJBUoZLXZf1QCqMcwcqnm/kb2yDFP7jh74pCQKFJ
 osuHjoOaAPAVy++zYUijXkYDW549940zBy7AkfV8OL8eMEgcKLZdRnKpjhnku0BZhyMX7
 B5R0DFHiEFAY6Zm/fy/TzVlviCHKkzoX2k2zql7wFWpJmyzx7a1GuqP+TqMZW1JA2DXGi
 a2X9xKhBUPVBsIR7MCI6x1esdqLatqAPqiiJ0z/yBldnFwIAeD8S400NcMcITmPAYkA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="T77DUq/5"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=T77DUq/5
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A2FF400B5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:00 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-80a18990c76so103006a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279040; x=1790883840;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8BgfGBzVPpH4v3lw8MgDQwMbxoUwG5BNNnFKSpj/mus=;
 b=T77DUq/5Xcn3HuiPa/sreedBaPOXHneYXhiRunmqjNbmjBZ39siZcj4WwXkSSj+gq6
 LKXJDzQggXGEjQP1gW/CTZHZLDrGWEwPV+atUhn4mxJr7lwq0r37fiFvNm4x3szxoRPP
 fuUQgYzbRythRCN1Sooav0iAaqHCN3VkIvc2eX5NGV6KRfzblY3sKa1vykir1X2xt2kz
 eVXp9jm5qoWdbG6EFYt+oSLTuZme/97d4fM/j5jhOsidJXxm/f1UTEQnHg+1nG8Or2ef
 Y5RKl42YuStl1UG5a0hq8jk92lIFdWWz+8AsCz7Ds7j0s4gThzvOGVcafffxT7OE2mh8
 XOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279040; x=1790883840;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8BgfGBzVPpH4v3lw8MgDQwMbxoUwG5BNNnFKSpj/mus=;
 b=k7z8qpPhJ0fy6mzztUmS/Rx8jf13bMMUYA1vUKO7uDolZocWqVqhd0yhK/AaKWTS9R
 k/v2Ffy8d2KMl27Hc3NjpPRHHVJJTPbNvPm7P+vusau0lgtltj1kVR70e9CLGqcwDGSg
 tRWnL20E/knfziI8MedM+kucQ5UuqOSF8WFV7BIwlCLCWm5DpRULFfBaxS+KyIhDHNLl
 b3tahYTrUVXzD5njXxbifIoMrn9xugOM/EsK51g6AvR0cVbuNUEHF5gqVjYHd5Li8vC4
 2f56KdHSf8ABoHFgRJXne+komYHNlaCsJG1Fsx5pz6vCfije3xDShj3FglyUglrjkR7Z
 a1YA==
X-Gm-Message-State: AFuF++k+R5OpTb7cFvPO8gQMhokXyG0IfmfDV6cD6ywE4Mn8KrEl0yp3
 qRRK1SFq1UxVJIsZ8DOlhK9jU7DgKiViw7vhV51iUv2tjRM6zfrbFzIdum04jjO+x6g=
X-Gm-Gg: AYBFou2Wo6Ck5exNPEER5/yurQSdeGbpPMj+Hu98B5IuTKPc8v8qSYkUSsWfQuXBqKk
 /LPWYlsyoDipS0Lr88GgZR5FD7ZifT7nEmLpwh0i6AqGMYUefoW0lAmOvuOcbwwnHH2W3iQrNxZ
 hq+jq2v99jlk4Biy2i3wJegmeqGlg3ZYLYz8tVQGlCiz3zzRYDUmIcEEEXBZNV+PVcHbcXL47NR
 zntolvkRUOfRfChw7mbdesgAN3j/n2zLSpxrOP5AOjQeTS6ptz1Snm79RijHidcQs7w85LtEuBR
 M4NRbz+b4+xgUKG4T2YM607ZdhiPhmcv4JFFKKnrOnXe/8STeB2RzA8UlbCEw3+UoAMDEDNPf/i
 gtIzS59EUo8W7kpP+LrJp1fxkfIg4Ii0xqde5RO3msZyYzL+adkV7nA0Inmq28BDSLeEL9k0Nev
 vaLpOgldbGTk2Ewe9E1KOQtRVCmN1LRKyICgnKI+NR39WSBxShFvgbnmA26uiLQ1FjKr/hNgg3Z
 sXu8Ld77BBWxg==
X-Received: by 2002:a05:6830:439f:b0:80c:d34f:5f62 with SMTP id
 46e09a7af769-81783b98fa3mr3718589a34.27.1790279039982; 
 Thu, 24 Sep 2026 12:43:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:43:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:50 -0500
Subject: [PATCH 12/15] clk: mediatek: mt8366: merge the apmixedsys driver
 into mt8366-clk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-12-1c3b5d8744ba@baylibre.com>
References: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
In-Reply-To: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=DxYrh8Wk0xzg/Ddu6h4IteJ/FiV/nbCFTPu+BcpKlz4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtX1LrdUQM2raRBoQjHl8Z5dRs9bg17c+CSLuS
 7jFzbPvOcqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV9SxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/APeMH/3AEIlugxGswehggd1teomUP/1e1SDT+irPvNQZ
 lq1SdMemiKPBv4yERqORQfUCNpP2Yo7iqx8QRvhSW0O7nNYiDmStCGZR1E/fK+x1A0prYD5PPOb
 s1bKapnmS8sTDxmvcqx6c9Um0sm9hgvLfLAiXKsg1INpgct34Ej6ivZtJ6IbjJEB0FJFj6mrfGu
 8IaQMWZHJQ/8/iowC2FxUqE7ZvNto+rax6sNMXm85mn6ORyC1PQXqvBt4Jg60AczOCmPFiSNrv8
 xUEjIYF/A7TYPSAQsH+KSzpxBKtGg6PQIMKL/5XfqLevHKYuM7jJPjv4aGSt+C1OZ2bSUZdUwOb
 Aeaw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Move the apmixedsys compatible into the mt8366-clk of_match table and drop
its separate U_BOOT_DRIVER entry.

It was only kept apart because it used different clk_ops. Now that all
MediaTek clock drivers share mtk_clk_ops, its entry is identical to
mt8366-clk apart from the of_match table.

No functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8366.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8366.c b/drivers/clk/mediatek/clk-mt8366.c
index 23b2920ef22..7e0306762f0 100644
--- a/drivers/clk/mediatek/clk-mt8366.c
+++ b/drivers/clk/mediatek/clk-mt8366.c
@@ -1444,15 +1444,11 @@ static const struct mtk_gate camsys_main_clks[] = {
 
 MTK_GATE_CLK_TREE(camsys_main_clks_tree, camsys_main_clks, ext_clock_rates);
 
-static const struct udevice_id mt8366_apmixed_compat[] = {
+static const struct udevice_id mt8366_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8366-apmixedsys",
 		.data = (ulong)&mt8366_apmixed_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8366_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8366-topckgen",
 		.data = (ulong)&mt8366_topckgen_tree,
@@ -1496,16 +1492,6 @@ static const struct udevice_id mt8366_clk_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mt8366_clk_apmixedsys) = {
-	.name = "mt8366-apmixedsys",
-	.id = UCLASS_CLK,
-	.of_match = mt8366_apmixed_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mt8366_clk) = {
 	.name = "mt8366-clk",
 	.id = UCLASS_CLK,

-- 
2.43.0

