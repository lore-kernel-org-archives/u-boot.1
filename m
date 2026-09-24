Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E84BC98324
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F09178124F;
	Thu, 24 Sep 2026 19:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tF_8wMI1zDSn; Thu, 24 Sep 2026 19:44:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 34DB18122C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279059;
	b=rIPQzt6KFIYQ5FYy0OVeq1ecEx+zKMmx3W0CLxwtgIQhwqoUZC7WJnDOeCiFIrRw5KaV
	 sxKlH31Xp5s9fNuvKjT5edWZ7pZS8GOsJx2GoB/VejKCwTKX7I/SNhlEdqxOYlyZwH+6z
	 oHwTL6Lrwe5733bLwJehssvI1LSt8zcphPQgpwace+Rn2vmidhdGU+D3eeGdbkFEfzpM0
	 rgdUdsJUeUJUkamExUD7CO0TWpMo79cuFbjJjRFnvi1y/ImCzVOIcXN+4Lpph5xlgNI8V
	 PHjvPKlRN+9JpxbBPd5ABqiEupgI4o0vim7M+LlDvS8YGSDs4Cmcde9e4XEjeEk9Kfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279059;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GjfLobyLub3CengW+WV7kmJnuIADfw4KY/LMYnyDVlw=;
	b=PfdMZctBCmReKrsodxajZKLTBxxnSdR2/JQ9libBqCJQCgQGzs2F5ndGhfPJ9YaVbovb
	 tKl130l7DY299x0r5GJ0JGKMhcUeHj4Aj5X2FXRPEalLyk+X6V/5QNcevYrwR+SqM2Ziz
	 adjQNKlaGxvhs6cHVmGwzTZtfMh9zaGvgWYfs7qBjAYOduN47hTLpxvh/KylNthNXryGu
	 y/GuLp9fNOSM0mV1v/XHMExaR885maItTTlqHMo7wI5qXthLOi7cRBhWFhLziCQL3Niip
	 TzBqCpXetQUDJJM8E9wjAUaEzB1dHelnDY5A5I2kg/7duhkiNj7fRE7VE0552BEjuzg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279059;
	bh=GjfLobyLub3CengW+WV7kmJnuIADfw4KY/LMYnyDVlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o5rxANysLHT4vYyHumRhoEsHF8n+Jkz2TNKnzwcWk7RWO0wRn/3SDaybMAk5ilTGN
	 pTs+RTk1QqVYIXyFCUZdXrwiT5wi9rQz4r0qdmaUaI6tRpXULWMeujuez2+vD33MnB
	 aA61/Kp7qAxHrdsLq2C5NQ8cOJkE/V89YOQ3VNMujPBcPCbvS6AE6AJbc0KPEF+JZh
	 ugrGrL+nptS9qBjk/QH0OUxsyvhHaEGyYPYHlUzeIp1fTdwIH5AsxhO522KkA1Bxli
	 kJC6BfkbChnaJhjcVfpQJlrRJ0jyy1NHcdLuNRSVytzGDtT2a25rZKFMJ8P6e5HW84
	 tLjKFQ0poTnVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34DB18122C;
	Thu, 24 Sep 2026 19:44:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D7C8E355
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8C4960BCA
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJcsvgCjdVXo for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:44:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BC92860C0E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279049;
 b=CRqX8Ji6qEk66MrkbLMbj5MJxwdNoZxeLOiMKPtt2kmGBfJemJlp8dzUhwLRKqVlAfyO
 idreWgY9OB8tIyNMLjyFKhgE7vu4J+Kt+3yKcLw9w2phfDyoJvbaHkwB1kSCxOck9W1AK
 SO20l/BqEPrRkUlQ2U1m96ARdIo/OaLkXJ2V2QgCpoaHg4b2q8+j+Y245vuOQkW+F0IWh
 1MNwzHhl1xZMDhOXOZYGnvakdkBuLvCi3KyzKu+pxe0XARsjRdxJu4sSomOfNXKAQkB0N
 9uWx0fNkfzblEtq+AfCfqwHJ2FtwHZF7VKGFh3s3oqEb3Fe0pjgcV/0xur2uG/yS3OA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279049;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=GjfLobyLub3CengW+WV7kmJnuIADfw4KY/LMYnyDVlw=;
 b=QLGAtQoZTd9DwMnYn9tsgUsb1aR2GLa5vKcESHJtBz6kD3C8QvJdsgjAcgBbf39eY3C/
 JxwiT5tWL6/z4FX/rGZQXpXv8SVcAxI+oaiEr1OvFV+/2IDJK8otP6DepkifVitz+iB/H
 ulwxoBrvxatYGPjZUBn710dxrofHIVq83UQigGI8odonSjuSBgcI7Wr2j6+ytZX/jfCVX
 6RJGHh+Vr4w5wS287T8DuwdcPqCZhj5VS5nCxmDwJGiKaDo0YOxsKoq7rDNndb+e7FN/E
 VzsVHOtIXO5M/ABlIqp0TTtLcx38l2rvERTluT651R8nk2eSAFrTXuoN2M7dFzrarIg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FapPPza2; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::c;
 helo=mail-oo2-x0c.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FapPPza2
Received: from mail-oo2-x0c.google.com (mail-oo2-x0c.google.com
 [IPv6:2607:f8b0:4864:31::c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC92860C0E
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:08 +0000 (UTC)
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6c24d19ebcfso133992eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279047; x=1790883847;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GjfLobyLub3CengW+WV7kmJnuIADfw4KY/LMYnyDVlw=;
 b=FapPPza2QrypepZVX22z4Nq7WaatGHDM3GhkIcLM9Zrw2RLrCbx2C7PcuO3c5D2Jwm
 qMWAFQ9SGX0uaYJUNfLt8kTqIvdMXxlG6gxHh8Pz5aJqTiXaqCDpbFs9q+FVADJt7sPT
 qZPsbWNsnO52tG+OkqpDUmOidZpjdMQK5GfvUkT5hzYD6+57ZbyBrfqoye5pXuK7S125
 oiPluqWphEKQGWtTGWubgXSN/wv14F9jKQaAse5qGTIZtyDS3EDGltZcJ1ubUpGcCYSg
 W1frlxMhx0SrToEjbzzxz3rnViyLXU+CNlBGNoP5dGtpgZEYzGOZe9Q0ztj95ATUfI4e
 sd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279047; x=1790883847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GjfLobyLub3CengW+WV7kmJnuIADfw4KY/LMYnyDVlw=;
 b=0C7/1UnqyBEYZz8k+fevQheorP2dH9G6iFWAo8xdoaKPzorN8FsCboDeHI2VO1ssro
 /IiivSsbZ2KZR7X2L3eMq5jC67+6uhxeFowTALBiVtmIaFv2Rj1IxmgbrNaI6Ud4paIr
 RiPTRa8pfFplwNcltdYtZfqXKCTVvKduanHtYmfML/4YzXkqB/PG6X8qvya7++at412u
 HOC6Y3L+L+fISA8WKCf2ckTaA+0pWuX4JEm/Bt5xA/nhfwuSviqv/4xL3QcVe/HIrjhp
 9s5XVNVQ7sJHhU1us0aHwg/dcP6islCxZMHpeZSZ1ZAYDaAQjXaFyO/fHXNVUwMTWgzG
 zcGQ==
X-Gm-Message-State: AFuF++nedk0PwEYY8OHXgFuwpWZso9QeXG/MYHVpZYOnvktuDOjmveZm
 rqZW91vnntqVedG0kmCoT5vunLv5cTWiW2Pvfms9D3Gno0kzghrvDJEu4crpKbJt21s=
X-Gm-Gg: AYBFou3MgowZj54iGc/5td7QNCoqkvJ0q0fbGEgAA854JL9abYWm2L8isYmJ5cPuC2p
 PlkuXxrkFNiZ+ucozq8qbSpwteTDRIIdJ7QXh+C1INOpQ4AvwHKdR9YoCP0AQw5UIPeeywUvdxw
 uRDJLAdeVK0uybm94WldgIFXwU9CBcqHkwPjTv3p0Ip9XS18SgMke1hgkBl+x0x4gdEz8nK8oye
 9OIP+xOqyZurj1j+zCtfimoSQoVYsTA0MQcR3j9bYRdhEU6EXKP2RurfWlsOWVPOSM1bBrceRlm
 MyG6GyCj1vm9EaaD9iG0302ra/RhNQmsbkehSDsMWkvzISGjbKSCnGAgojKyX1e5x2W8nXUIZR5
 aLQjW52La/OEvouTnEsGJsnpEqED80L8lX6GCu5jelE+6876q6gH2T4+4ZnIXW2IzeITcl49EVf
 WiyaB6gk3npFFmGHzbJcr2JJil4BwrQxodpFJPIRUZ7hJeiKA8kXaxUCKNzXuhfBS//3oy8ImAv
 W8=
X-Received: by 2002:a05:6820:88f:b0:6cd:3fdc:6002 with SMTP id
 006d021491bc7-6d441c79693mr3108880eaf.83.1790279047121; 
 Thu, 24 Sep 2026 12:44:07 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:44:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:53 -0500
Subject: [PATCH 15/15] clk: mediatek: mt8518: merge the apmixedsys driver
 into mt8518-clk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-15-1c3b5d8744ba@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=n5WNYonz8q5y7B2mzJr5x4B2qxpFQGRHMZgc/R8iNLQ=; 
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLK21sZvs3bwm1bb5TFFOkA1MvNr+G3uPYyGwefeLDie8
 qnga6x0J6MXCwMjF4OJmCLLG4mb85L4mq/NuZExA2YQKxPIFDGZlJzU5Iy81CKHpMTKnMykolS9
 5PxcBi5OAZjC+6bsfyWvrpn/p7jzhtqO123fOV5Fup5xqVCZ7JSxxsbMyFx4C79fxrt338wyzq6
 ucBFKjV9keFp7h0u72GpvR2XjY6v2lsby+jztCrkh8awvm/eqyPGgfeffitky8V3I27Vu3uP6hI
 WLPV1CK44ZLtA2dojY3Ro+e9W0u857461OdOrKdd7xStDNMprK3Xzsb6O7tcZ1Sz2O1n6HLUkFV
 mn/8kIyk25nijtOnf2/a7HGZhX7Wu/55V1rJ7GdWMR+pXKiXd1n4eWbf+9ZHuqz0qG3+XmJTyn7
 kaAox75mBrt7U6f99dc6ki+YY/OT6Z3PGoWuGZYmNY73K/cEPix2E5rc/qWhM8bd7pfL9TLee38 B
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

Move the apmixedsys compatible into the mt8518-clk of_match table and drop
its separate U_BOOT_DRIVER entry.

It was only kept apart because it used different clk_ops. Now that all
MediaTek clock drivers share mtk_clk_ops, its entry is identical to
mt8518-clk apart from the of_match table.

No functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8518.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index b6b61248f5c..392225389b5 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1525,15 +1525,11 @@ static const struct mtk_clk_tree mt8518_topckgen_clk_tree = {
 
 MTK_GATE_CLK_TREE(mt8518_clk_tree, top_clks, ext_clock_rates);
 
-static const struct udevice_id mt8518_apmixed_compat[] = {
+static const struct udevice_id mt8518_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8518-apmixedsys",
 		.data = (ulong)&mt8518_apmixed_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8518_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8518-topckgen",
 		.data = (ulong)&mt8518_topckgen_clk_tree,
@@ -1545,16 +1541,6 @@ static const struct udevice_id mt8518_clk_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mt8518_clk_apmixedsys) = {
-	.name = "mt8518-apmixedsys",
-	.id = UCLASS_CLK,
-	.of_match = mt8518_apmixed_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mt8518_clk) = {
 	.name = "mt8518-clk",
 	.id = UCLASS_CLK,

-- 
2.43.0

