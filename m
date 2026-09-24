Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5972C98324
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:44:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FC4F811E3;
	Thu, 24 Sep 2026 19:44:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zx2x9mtI59nz; Thu, 24 Sep 2026 19:44:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E05BC811ED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279046;
	b=NqfA/7eQtbD8MdYYer85WFnnIUN4dy+c1mfP9HlaaapCEro3l4EujkL9wCQLzokC6baR
	 Z8YrX3UtFhEJsOrwkeKY4InsMtZyXTNW3N+B9+ySjM7B4pCcrod4VLqZNMUrEXx19WgyB
	 eXDpgjIcbYd+dpli9m/ZaP9e7tRDlIk7WszqGo+3KXdQN2pdGMfk0GQrIyCa6P3ofuVHG
	 5+1m3ciiaDNnC/wESgN5FdSQWRrPcNdF7+FCRGH68PKAJsxLN+GWTbDhNHVgUjexlB9WZ
	 c8vFTAa7phl1d4ZVrDGXyecSe7zyZUZDQFQLCbZh2inPac2/KBZPzGsbNhnS7lp3YWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EOAiHB21fPdpfeN0eytOvm2Nh/3gMfJ8UWm/PAhAFB8=;
	b=O2lTnhiRjNYj3twPcOq9gqKd7fe+aTgpqk6CMiGQcs/2hihzFrvq7Zxrp56uVfRm3B1U
	 Ire+ewjcmyYLiFtWG3F1Yuwju6PUfCvUM8mdEVJu0UFF+Z4na+EfAYjm4Gjlg7yIiXOMo
	 aN1EvKnzcazBzw8DRfN5dUYptqLc8dsI+oUDpR4KTjOS+MssUkw3bto5hhrpbN5J5CgMg
	 3C+WJdKxkHWWO3/RZDKsY5MoqTa8XL3XdLoJnGqYbsM5i4mgnE884zVc+mKrLdnAQE2xl
	 eKRVsJNxFGnH9oDNs9F5C6aN5dBzmEJFLG5i92eE9dW7rdaSiM+CPw3mjYJlGhLlBEg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279046;
	bh=EOAiHB21fPdpfeN0eytOvm2Nh/3gMfJ8UWm/PAhAFB8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cI/Us1diRQk24+khqaZPMcHAZ4xTZt2/fyXxYd6+s6rSwIJ1mFV3Z5iY/g9ZmYe1s
	 UG33eY6S6PLGpiCPPHpf6rW7UBen/9jv20SHx0UT2ZIkQHClaGPz7uHEsWRed9+SIU
	 qmDQYpfDN7ATSBdo2vvECSKBab5il66Sridnrs/5nlO0/ZWkK5NURT4IYvHkk/lyw+
	 71KVkdelNzKfnXSLTwX0xH1PnFegGvnE65GOZBdZ3njMug7MhUo0kZEMavECwfmkdX
	 rJLWqom+Z6jqX4f5/YBhBvmSv+71qou7bt6t3UeuwCiZB6c8u3SrlS3nY5dvtT4v8I
	 n/02ZcYyswe4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E05BC811ED;
	Thu, 24 Sep 2026 19:44:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B9451328
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB4BC4017A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifJw37SCJqaV for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:43:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C6573400B5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279038;
 b=PKx8xmilZLC4SdkSvSWe+dEk2+cD2n1skBie+rMoBHrRWNNb8MRILkZaHtEfr1/vGWoJ
 XvDmo/bkmvgFHvodcnYohBMJxYahs4MSTDlJs8xmXpvmybwpDpy0jituujHiR+LJahulm
 /8PggqpmzpmvV4qqMMeKj/XyhHyKPYnkHLNQeWwuua6V2qgWD6HMIutWUjVhe/YEsAkpD
 3fJtp+wBCA7BNquxfZaYYWGec1uKG4K2Jdet0rWgPR3yXwg8tKv3wXZ8RazqIDqw95naw
 bHMAi/KL/K8C7GY+MN/XNhE29W0pKeSVz4BRL459JLiY9ZoJBWPs+x7MFLVIxI2gAlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279038;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=EOAiHB21fPdpfeN0eytOvm2Nh/3gMfJ8UWm/PAhAFB8=;
 b=msLw8QXDJAXoQ5KnUFYq1fzy0WRTTfctcWFNG+9rZSb1yY7ZrmFvumeP/qj7IcnheyCI
 V1obVjTjC1CjJcdJ2HD4g1ApRZeGk2o1ysBFkeQjyNMZr8EZUuyw47ng75B4YEIR6iSrp
 CgA1MewPuWavsy0f13HpvkQWV7QMuF/ARbaojeYGcqLyNGlgTnxHualXYfl+cdgniANBg
 G4Hw779dzWgfPuD/K1FpX2lKgQyopCBhMeamEFniIn9LsHlSsgpofQz+FsO1d6Ub69Lj3
 kFfFnH/S4pWXXTaqTMiqoDBV3YJn91uMjfpf+8H/thob407wtPSJygbTTtrIAcRJl0A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fJoCNI5M; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::29; helo=mail-oo2-x29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fJoCNI5M
Received: from mail-oo2-x29.google.com (mail-oo2-x29.google.com
 [IPv6:2607:f8b0:4864:31::29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C6573400B5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:57 +0000 (UTC)
Received: by mail-oo2-x29.google.com with SMTP id
 46e09a7af769-805440319deso88078a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279036; x=1790883836;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EOAiHB21fPdpfeN0eytOvm2Nh/3gMfJ8UWm/PAhAFB8=;
 b=fJoCNI5McnIzi/dO3BdEp1YjwQwvcML+fyjRErrhWORrws4Pnx7X4tc6iQHAEwITYJ
 /9O5TkFqvH/f5eq01uHGVbqrc8dYLowAcufqiE2Olzy08mDzSGC4pjtuDBby8Dfb80Fo
 LcsLQQrFcXMr+Z4HxAKfmy1qAcv3QEtkT/5pOKRe4/TfmJqtknUNyRFY7fD4uoGHaadp
 EEu6jj2XgKKUb7KPR7l5v739LBHD+SIwvcgoxIu7P2Z6Jd4JGKxLbcA4/RnvQ4xAu8tK
 gDLCHyufhXyZMXlb3c90zGDqH8KOlKfubxgVuLx582UVMxnarLfeJ7xoApqs4RD9xDFE
 Hrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279036; x=1790883836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EOAiHB21fPdpfeN0eytOvm2Nh/3gMfJ8UWm/PAhAFB8=;
 b=RIIXSIJg/RcZ1YFTnRbPfWe7g6+4zhN1xOnoF2h5JOAXLcMU44iZy7qg/OR/wwjAst
 YLPSHBdNxdhnBMfTyDu1YnF6/3onF1kmrSpjfxJkuKHD3LOKTeM3aelJNRHlPckymFor
 tgfk/A5+fMbTnxMVnKi3WpCRsbEO/rwzuHJBzB7Y7jAV45byJ/RGqVuOf/WonWNKIaYr
 CLVu2KeeI3fCzPudzq9x4/oeoZCQ25N+evLBapN8ev56DRxaVc+PavkSJSrrA5VPLtp5
 M9x1FwaZLQbhTMa05QCBSyYkdPgEp+wU2W1z9a/hMe2GIBurpNJh7iDLGgmfKm+M+pYo
 jHRQ==
X-Gm-Message-State: AFuF++nNzvXy8AVtbqTzILe1whYinGseTFPwaAuk8dmI95cLdcDJd4ve
 bd+UaJT9kdI7+4ioXrrqvy4/RPPAXk1eAwK77OxfH7IrnuO/QJxhIQ3WBgkaq1Rb/SI=
X-Gm-Gg: AYBFou0B6Q0jOEccdPVGaui3wWbqXHzHu23WsoFnNNi+Br8i8iWXXAopCCdHbCMGa3W
 6yr1DIcezAwKO32tN/USKvfVbrcuP7msBHWb1RT7B9oEPQ0yLmJTqvPFOOOWPIy6/GfEztbkAU+
 jRXUjjEzOnDtmsQQImsGIwjG8kOiljNYvlwMF0u6fGQyUm2GUH26o4HPZLo6prpOAxnhHyAJkwu
 iJbnguMRgk3qvIH0YU4DxLPezCkznEsFO3H6CpTfSHeSr+NlihvoDDHi3KCCxc7NLQk7e8Tl7CW
 tDoXSkRIK0vX4GRxsbWUnRtkDYg7J7CQPHpEcAX1vgPvvdrknQLkeBlYHrxRIgwKZ2Vgmw2xTbY
 8WW+ta21btuQ3B3cob8m0L9bQhNe10QTYXQiM1wI34/urxyc6Jo5czGCZP3pzz0geZJWReJcRNe
 /3ut74jzYl1wRHmSCD5jrsGTr+57x+q95Pja7mzWRktAzIQuv0b30JhAjN86ge19OXWah+Zgb21
 6s=
X-Received: by 2002:a05:6830:dc5:b0:7f4:d1aa:2f32 with SMTP id
 46e09a7af769-81782c8976amr4010800a34.11.1790279036539; 
 Thu, 24 Sep 2026 12:43:56 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:43:56 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:47 -0500
Subject: [PATCH 09/15] clk: mediatek: mt8189: merge the remaining drivers
 into mt8189-clk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-9-1c3b5d8744ba@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2596; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=WBfkaEi81ZZ8qrHGEjf88kZCYBpDaqv7B4qTGYi+5aQ=; 
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLK21pqv+fngQpl3xa0s60ReO73A9yuPmf7neMtqxrRyu
 0mICMvbTkYvFgZGLgYTMUWWNxI35yXxNV+bcyNjBswgViaQKWIyKTmpyRl5qUUOSYmVOZlJRal6
 yfm5DFycAjCFVqEcDNP0F506fUl256RMBlUL0dyF8TorsruK+yNTSk0fmJ+1Xb54OfPMCkXnLd2
 nn1cfcf8sqC/47JlU0oMAJr7003X3nUXV1qo06ulecY/VPBXkWJ/XIptVaj5jdfxSu7ib/Iv3mo
 dVfQ9T+ptpv3VOW0dBKvOqpXPbra9KOJmeE+OcI9e8R+jId1c5f4YPC+uv3/Z5IS0dwR6tIXOoy
 biStWuOxHVfSaMzyk79ZveOOctG1oY7NR+zdite+ULIkH3ej/NzljGrFMg2PbPQZvrbdys26rTH
 5LJF7ZvCThQWz/u21y3kyuYLr3+eLhU8tD4uzu2/Qa7ksjP3v/LUfXjvJnEl03u+C8//5/z5/Ic A
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

Move the apmixedsys and vlpckgen compatibles into the mt8189-clk
of_match table and drop their separate U_BOOT_DRIVER entries.

They were only kept apart because they used different clk_ops. Now
that all MediaTek clock drivers share mtk_clk_ops, their entries are
identical to mt8189-clk apart from the of_match table.

No functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index a4880b98906..89589daae8b 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1978,19 +1978,19 @@ MTK_GATE_CLK_TREE(ufs_config_ao_clks_tree, ufs_config_ao_clks, ext_clock_rates);
 MTK_GATE_CLK_TREE(ufs_config_pdn_clks_tree, ufs_config_pdn_clks, ext_clock_rates);
 MTK_GATE_CLK_TREE(vlpcfg_ao_clks_tree, vlpcfg_ao_clks, ext_clock_rates);
 
-static const struct udevice_id mt8189_apmixed[] = {
+static const struct udevice_id mt8189_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8189-apmixedsys",
 		.data = (ulong)&mt8189_apmixedsys_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8189_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8189-topckgen",
 		.data = (ulong)&mt8189_topckgen_clk_tree,
 	},
+	{
+		.compatible = "mediatek,mt8189-vlpckgen",
+		.data = (ulong)&mt8189_vlpckgen_clk_tree,
+	},
 	{
 		.compatible = "mediatek,mt8189-peri-ao",
 		.data = (ulong)&perao_clks_tree,
@@ -2022,24 +2022,6 @@ static const struct udevice_id mt8189_clk_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8189_vlpckgen[] = {
-	{
-		.compatible = "mediatek,mt8189-vlpckgen",
-		.data = (ulong)&mt8189_vlpckgen_clk_tree,
-	},
-	{ }
-};
-
-U_BOOT_DRIVER(mt8189_clk_apmixedsys) = {
-	.name = "mt8189-apmixedsys",
-	.id = UCLASS_CLK,
-	.of_match = mt8189_apmixed,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mt8189_clk) = {
 	.name = "mt8189-clk",
 	.id = UCLASS_CLK,
@@ -2049,13 +2031,3 @@ U_BOOT_DRIVER(mt8189_clk) = {
 	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
-
-U_BOOT_DRIVER(mt8189_clk_vlpckgen) = {
-	.name = "mt8189-vlpckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8189_vlpckgen,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};

-- 
2.43.0

