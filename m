Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A660C98321
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F8A860D4B;
	Thu, 24 Sep 2026 19:44:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYjgnujCn2XK; Thu, 24 Sep 2026 19:44:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1AD1760C34
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279051;
	b=Eh43HKFaRPiaOTKZGb2WJYDjSpA9nPNGSACRw+ppUytGbWNKWthmo/JJ8sO62AE357Ep
	 P5I/ZZToJ6ZNNUpuiafZKUtW6Ca+G2Tqpi2zGzrTlF4ig42P45/6MJbmXe4tAo/UQJB3b
	 4PoiJ3TEg2NcIOiszGMOp16CedFnZqe4qgxCCwvJJP6eR9VcRsrvOg49+7AXFQBBNAdTm
	 a7tkxW6tlADf3Pp2YNIOAtWdvKjIevPqU6RemSrqDsDq1fWOBujdrVReMM8tBq0ZRFVyk
	 MbQ9apHwmCG4Or/HJ2aYQlOXeZ576DMXieHZUHAoqRGfIE2ffkzoNrW9UhRTIx2ZM5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279051;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zfUjnzIgBBAmrY+nWPaBq3tZ/HP3dlhYMi3QMpxuDtE=;
	b=EorFiuVQeMC/Yl6CDP29mzN/xYr4nFuVJABb9XxHlhEKG60MiPQ4u9JyHqnlD2JJTPgs
	 3lQXFzBHrdF0N1/e5Op8szXyMbfTmiw+xmkj36r4k/u29teF97MHwPazuL3l5oLktPbN3
	 SK/6qQr3ijj2qUWQwHW9mCJQbXjrHvtovU9/k0+wD5+YJcvglfyzFgzVEFFcwWsVaW7Z3
	 eMaQY0YiGqSusGtNt5426SzfSO2g9E2jQFZ1KlkQbNXm/dMNGnnUOEttpvN1JZXUY4/N3
	 xGw7FqhbC37Va2Y/Rl4jUJNuqJ7hn7knn3xhl2JArkjSWz7YipvQ3nqYje6lfJhKpxQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279051;
	bh=zfUjnzIgBBAmrY+nWPaBq3tZ/HP3dlhYMi3QMpxuDtE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g3aTe2TDWjJ1ZQuikugRfjXoPRIbVivaMk/FBd7o1sQhRtyS4nxjOFjfh792X4IGe
	 jqH219sS7VO0MrbvfXQ3rraqz6ny1nWdVMQNp7TqD2TLDKHFCfFYKiIS7GyvX1pntD
	 VhBzbUjFPnUIX1qGofvjHkWc6XHhhmK3uMjZCeszL2a+Up29rHzv4Q5iT0NzhWpUNd
	 pwHSsCusIl/PN7uyOtb6SGTvdbmudb47uOtHiJhjEbolqw/RWNmBYykcYdJns3pAK1
	 FIPeklEcbjkM6KWocax7rNyecwPq3fhIGZC6npN4gJpmBCPS2Tvnhs6m0TczQLkkHK
	 TjHIBd9PNy2pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AD1760C34;
	Thu, 24 Sep 2026 19:44:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73A6B392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 654A640E3B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tGv4Y6OWoWo3 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:44:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8CD7240BD3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279040;
 b=hV8MqUNkR+joUXAs/XooiruWgD0wMbybSoVw+EhhsGP/ljfk8tsEwdF0q+83EgMwv666
 Fmr73ZRT53G3hPSza0gnRjjlZztsBPMWPloNkL8uyxZr/+X8Zvn96lKESOcaOiDwqSbVd
 n7rfGyvWg/R//kSpdYrs1HRkZK6gsjS5HXoGZ8Hn/VhkGAY7el+Sct6FfjaU5pM9G77zW
 l45tepeNaKO4Jl/0qpUZ0XlQSz3BFVyEli98eVmJjgfhcEHKhEn2zUUmOM88okGmgOUGp
 rTWXu0y73ztXE15yMvgyhkWl07A19srSo8QL53YROBRUSrmcxvsKDjoiQlwZvf75b7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279040;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=zfUjnzIgBBAmrY+nWPaBq3tZ/HP3dlhYMi3QMpxuDtE=;
 b=VAk7HowIk794FY6SfJCl8QMk2+EMDKzKHlMcqxau1dQ039XE19HqSs8laBNud/5H10EF
 KewVpo3QX6nu2jl3fvgkD7lQwPRMt4XL4i3s2sb9DikxHDJEXcEphc2oNthLaOpN3p2GK
 zR9aa27rdQCjJNGs6wRamDYX0AB+GYN56okixKsFuZ3t06i9G3uyQX4UXzgYI7Kwa51jv
 DpuZyvItnR0XVkcMRq95uYSsMgPgO9a2xzVzRDBQqRhyuC16DgMukwobp8CUSMfOSok9O
 RZuJ13CkJ4h+o8diu6SYbtalmppRGeLtKoCyBSOxsZmaOoosTizR3CNHwSFW0FW0h3A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=lmtSpEDh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lmtSpEDh
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8CD7240BD3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:59 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-801a8bf8112so67324a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279039; x=1790883839;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zfUjnzIgBBAmrY+nWPaBq3tZ/HP3dlhYMi3QMpxuDtE=;
 b=lmtSpEDhQcmdkaGUPofPsyxgYQchW9d608E9VKmiZVJiMqNnT65l01EOkCbdcI3fAX
 xiy0xbI0ogZp64mV8dh5O+x4g6z1frCAm3tNb+eQ6IIii+yzMycRqQxLUIzW282ZIN77
 UYAOYBlHE8AJvSEi9N6Ue37Awvh21UfoHkL96TWBtkDr3OXaevpiOHmrwThFCeDvC+hE
 JF8bone6IkgEzrp62szvya8bSaAsEe8lHBw22aubcNuEZ6rwtAGURSGbjKZ20fiRKU21
 PLxhUzElt75kkspCQJHKez+mFpLOfUAZAIGsrUT3YFbkPeTNkDWcZtrZg0e6P1PcCKuK
 tadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279039; x=1790883839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zfUjnzIgBBAmrY+nWPaBq3tZ/HP3dlhYMi3QMpxuDtE=;
 b=za0gREO4zKGikZFQE7J99mpLnZdS914vlgvQVyiulfEW52gUoKAABwqun7W3W7v6C8
 8HSrIbnMBy3KI5Xe8zdo8mt9J4MAZQMIkM1wJO8RkTHwnMs53afjTBZhSrfRoI0tcHP1
 8X6MRNFfAqoM8cRfNtq2I5h7ioz5gzFlAasUHrY6iZemoDZKRoeAl4NHRl5Z8SITFnRf
 F4ybqZopRsRgKJ2Jgkf9SkDu0Y3/+gCmrM4wyOaLbu9nKxkckEXWYK313cparlNAm3kj
 +UoSpKFws881MAIXtf5rvsMq/pS+mUo7zgvkdAfztcrZHxggjoMLicEkcI6GzHqGSPSp
 vwZg==
X-Gm-Message-State: AFuF++nMmLq4da60Ww3UEShutd10bnTOCjbahyVRoSv8XDR66KhtE3Kc
 QMKReytI1gsa3dxlZM1LWUwHXS0/p6b2K8asCA/Nukaa/OqTYIxlcsWjTiN/rn4sOnk=
X-Gm-Gg: AYBFou25rij2wLKDfknMI/3wEkpaz701EDz+MC/JTeRaoqcZGNNFHv180UnyyrJcIPI
 yseDbNwD+41vdC61AO+WbXKrAAPYtDGdqtgL0PvRG0NNzuvkoOlsD0pMIEOW2XLiUARLrm0OIBM
 lYU1eo6UGOK++PZ46vc2aMlLVjMaAZEV7/PRJLPUKTmK1BHHfF/nuG3C0dY4mydHSdVajKsvi4c
 66rbkrZugFykzl0/xLe1QOJyzykM3pzdThEUm+ucoapJzQ51bgkkX4stvqI3BJJqtZ5uLUuFEod
 2luEFECkEZu10D0yXn1w6PmJVh+06Vvwa2+Ykl9CivwYgwO09jVfgQO4EitDJQpoSDtPw2XJlP/
 AFqmr7emZ+KQYm47AJ5qEFtSx6/k1bOfVTlGWlWRDR55rzgCG1TuvR+VQL0QSIXnRVZbIlUMt/7
 XEK9blFBPRlDC6jhq3/GPOaBMJSNCNBG/oytZpZ5yIZ1xgfizzULolyS9IBeXSP9giROTRaAngs
 u4=
X-Received: by 2002:a05:6830:82c6:b0:7fa:ab72:9df9 with SMTP id
 46e09a7af769-81784e8d71fmr3513795a34.17.1790279038969; 
 Thu, 24 Sep 2026 12:43:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:43:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:49 -0500
Subject: [PATCH 11/15] clk: mediatek: mt8365: merge the apmixedsys driver
 into mt8365-clk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-11-1c3b5d8744ba@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1678; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=m01nPTz0szC4CCWdYgc5vM7e/YLp9gC8CJnE5C3VtcA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtX1E1qw1cftgURDI+DAnoHaDp5KPzHw5wIDNu
 Eb7/LsbjnOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV9RBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aha8H/iX5p5R+Jyh9+9gKYBA8ObiZL6wGjKqDzXSSD0z
 TMhfzLX3GeMvRB/nmKq0ustoXknMHfAnNyCXZVd3S2L6P7cbp1XGCIzhC1euVFUnHYJXYgAXZIe
 6j3z6694YgHEL4UPKG2RRgEkaganfNjPj6Vw0YsvFvieDOjWE1nWrSj+1VzT7tneoB5zDGI0SZc
 NszktDaG+dn0lDqB6cIbdC4atGuEk6t/dS/Jua1SdSIriRbQ7kyVuYLhW2hDJSP5Rl2V2erQC0W
 hHOj7cHf31vVz2iQy1zIO6qe1GN4p5HtLcLEwRAz7pBwl95g6LOmbq4DgmIdEJgIL4XzfVVFu35
 37BM=
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

Move the apmixedsys compatible into the mt8365-clk of_match table and drop
its separate U_BOOT_DRIVER entry.

It was only kept apart because it used different clk_ops. Now that all
MediaTek clock drivers share mtk_clk_ops, its entry is identical to
mt8365-clk apart from the of_match table.

No functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 25f09a30db5..13bdf5a2514 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -756,15 +756,11 @@ static const struct mtk_gate ifr_clks[] = {
 
 MTK_GATE_CLK_TREE(mt8365_infracfg_tree, ifr_clks, ext_clock_rates);
 
-static const struct udevice_id mt8365_apmixed_compat[] = {
+static const struct udevice_id mt8365_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8365-apmixedsys",
 		.data = (ulong)&mt8365_apmixed_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8365_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8365-topckgen",
 		.data = (ulong)&mt8365_topckgen_tree,
@@ -776,16 +772,6 @@ static const struct udevice_id mt8365_clk_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mt8365_clk_apmixedsys) = {
-	.name = "mt8365-apmixedsys",
-	.id = UCLASS_CLK,
-	.of_match = mt8365_apmixed_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mt8365_clk) = {
 	.name = "mt8365-clk",
 	.id = UCLASS_CLK,

-- 
2.43.0

