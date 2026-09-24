Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2569AC98324
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA04860C05;
	Thu, 24 Sep 2026 19:44:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tSVjLGNZuDA5; Thu, 24 Sep 2026 19:44:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2CB1360C0A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279055;
	b=XQIpVWebAELCk7ykfIozHQt1UPUL9KZsEs6PZFPu8rK/nov81N1lkDAmV9iedsqIiJxm
	 xd2hRViZ1XXD9g8xLWodGqmSUy7dU6hCQT5+oy1U0M5JzJfpKsee1m8Iz0rJyHLFO/ZN7
	 E188y6BNq+FjxiAIdGF6+Fwg5haK35SB4zq3Or/vbplWtpYvP2+/ap6SgALoC8XCq/Jje
	 7LIc5QISAr9TyLe4ExpsFJ9ck1rMvAkQh3+uYf991V9ZnrI15CDmC6ZJZJqu2EZVyqpQO
	 VeUY42bRyjxnJoOkaHXoPVzLgo4S0HQDlqcrUr4xeY2Kv5kAX3SYjOfvKAjv/cmsFIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279055;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZFBgaOc6wHzD3gDMFA5WI2QDAqFGd+/3uOTbow2s9LA=;
	b=H/5sgyRelfaVzjmCYyC9Tl7sRCllP+QTDRVqHk6H92W4IwZHZyykctgo3t/Zxv00I4KC
	 rU64okJT++WtkZaOzdRV90r2vzGbOYZ0WWm6ALwYF7nk8udJ8JstAQI1WgTUNVd6fQZys
	 5MOF5m1mfyJPyWyr8gMBr7WR3LbMNrGQoFmTXx6cMpYtiQ/q7E7In1dYWyPSoC1oJbzDp
	 kttvHyuBVPw7xzBbkYKBf+4fk0eqZ+Sox2bjFY5UFTy0nj4NtIedRZxR8sp3rtr8U4Ztj
	 MUhJ2gAK4uiYUpHR0HQob8JcuFFqBPLJZYo0EiXdgp5ElrgkD0bmHHx1p/iB+ijLzvQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279055;
	bh=ZFBgaOc6wHzD3gDMFA5WI2QDAqFGd+/3uOTbow2s9LA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sV7cd0JYHagChyGnoH7+dVX+YFgDEW25OdUm8umRkGwtmZBH07rsFN7J4lzrPVNRL
	 39nVXyIA6hD8X43wGBV02942viK+3d9u3ev5/dNCF7e9FlOXhUD/LHgCvsbpwJl1CU
	 OKokjbhuH2FCSJZMkknKPBNrDAllKxPCR5h6TulQhTLTTjARrhI1/Kw0nQBUg96YS0
	 KzP8NtB1FJEg4SEzMS8DA09YznGdI4A8GOgF9KzjdPsf2isTRwegTuQAp3OgToukZL
	 6kpgpHx+VA/cJ0z6uyy45y4l8RspaqzKXW79qA/86JGvk5L4CMQzWj2QkUlX9eaIoJ
	 fQSQ/J4/VXW2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CB1360C0A;
	Thu, 24 Sep 2026 19:44:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 47228332
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D7974017A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pwhXapg-oyvw for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:44:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5D2BE400B5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279043;
 b=mLhHlFGgMbui5ikfzpuZIa0k/ByqQZq11wDkaODNglpvKjmhWZKk0PyngwyfqO6rCGYR
 5LBiX1Qp1OLyLyFbUd3oFqHYNCyjpUD9sJWgMO401CdO4SWXLsBeDPWs84jlAt2yrqfK2
 upxfwaII9vZv4F0IXSOjUihn428SoOeTMST20b4UBlni2iOS3I3gyALdQ4vKBahr3SvRk
 JvctKbsei5wZSwMWKw82JlX1u3nElch4hD/o86tYt1nRoiFOh7GqAGjwPOBCWJ73KDRM0
 KpmChKRKuzYHre2Mgqvkhv9XxyO9r11G6et6Ejy4PNui9dUPyvzq1OKWD/GTzSFczWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279043;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ZFBgaOc6wHzD3gDMFA5WI2QDAqFGd+/3uOTbow2s9LA=;
 b=PdgzExOtQMwWgqAu068+vY5ThxtiYqpNfpMxTuozzJtAAQtNbmJE1eMVorTfYJFEwyMl
 awMMCO1YrpfChcWg5Wjnn/VyEPOxQno5N2z49xmCNPfwWNU4OsHwf25gUXGH+qaPfWd7C
 nCOOhBqaSd6p3der+Y1S0WCy5dtFgnYi9NWvil/EwY5raVAAez+Mkd9hbmd2ItrgaGQ2a
 /f6C2zU79mZ7HX3fSp5OLaGCjiR9CwdiX+mYi2LNVEKSVEJ3ZcWuhVW1thei7UifHXz9S
 RHVs5ho/aIiJjG+ByqFQ3cu6hYQ7LnS5ROn7po74hGxuQcKFIBejIRkLW7Jnc8lUJ2g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jTHSMXMF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jTHSMXMF
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D2BE400B5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:02 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 46e09a7af769-8177a7fc354so81341a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279041; x=1790883841;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZFBgaOc6wHzD3gDMFA5WI2QDAqFGd+/3uOTbow2s9LA=;
 b=jTHSMXMFuj4sPDgwMF8M4av1IRSARjFmecuWrm/XYOY2/jFr+lO83v0FXY127PGt38
 GqLPGs42Y75CSDvJUFx3/PVid2Vv1uJc45vuIMX5PBsiLbyi4LOL+RKC42kMD6mWFDkm
 dqZlCDPcKOk5xM59KdY9ujstkkIgEPFMf2sUyByuTCjFSONTqfPM36f00oGt75QvnWqT
 w/14EEWVLBWVYqGxjkS+CvHNAwBFsuYdf6Tv8esVqgZUsV2AlX0S8tjdcD8CJm9Gf46K
 Eh4StqYKEldGhscWZXCh29ZjjlnFO+95+5IP0m0gWX2NHxR9BK6SIAXWZXvAQT0omO2c
 b3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279041; x=1790883841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZFBgaOc6wHzD3gDMFA5WI2QDAqFGd+/3uOTbow2s9LA=;
 b=25fpUbHN57dygxCRhODbz1h+0RFi2ElhpdaC33wxalyg0fMvkSjrD2tb6K4SqUfgU0
 YadSlloJzFCwhm2M0gGUAUAjdumaoAQWQHb1mtXS0CSCw8tPQ51R/ISnwAGGknK46JOu
 atQHgpheYfqDNokMIvYbRJ1/mGlcSC/uDtmzw9UM+iFZ3TG5OJ4/2aKwzz46Csk7WngO
 n9dJL1z0QcPFrfsXROqkavy9Sg449PQazjxD4VSbySADuUznwtUoVOSBzOFLgkW0k1US
 WTwLXB5XjDuSNyxrAsxUpDRwtFXWwnSh3UEOpmC917K1cajNCKFsS9YTM4xToxH24bFC
 mivw==
X-Gm-Message-State: AFuF++mKlV3qbZvbSk0LIHdxd+tsdCGBHVkpSAmRQ6cCImwIlpo3kgu/
 JvfDpIu4j7ajfMiedzsAkR2DM/RIKKA22PulSfFOvaeikypH8dS1pUkA8RCEz0O+HQw=
X-Gm-Gg: AYBFou0zehfFvJTFfF2ZsS+xm0wqcA6oZae4nfhCLsNn/GeE+12IOG+p8m3Qs+c9vBW
 u7S1BfeLCh9Lh9305BX2apYliXd+3Ic4rbfOLwkDKVdWL5zg7JQQNka3LHal+rvout3K/Yc/DsE
 JFAzeJ/JNkJx+aFRkQoUELZYu32qhs7SI05dG2jVKYBegCNpp7RWjaXPHB9LYmG2o/6zoWByk0k
 yn/b8ebxJ6gZAgipTkAlGUDodPZ2IVqIQBN7fEeS6i4NM0wUmGKSOkn8uXjYClNprnPCrokjaxI
 1C78hFnz8mJo2okOV+XrT6V1uwlmcWpMhmbaxquDghuiEVuXlCXBHE8FvaKbRkCKoFFA70igQW3
 Ffz6Jy8s0xj7/cUbqxDbWvq4DQ851HJmE97XldfvGjJAZ5O2eZ7P3sBAvdTxbhs1fOBNzOt56e8
 Wm2dO5FgdpxogC86cBXd3mIiqsNZypMHMqGB3S8yyV9SPvNU31i4UoT0F+rZisG/Ki90k4VLwvo
 QvLJ7ETqcUxPA==
X-Received: by 2002:a05:6830:7193:b0:7fa:5c68:d050 with SMTP id
 46e09a7af769-817836892cfmr3736867a34.26.1790279041298; 
 Thu, 24 Sep 2026 12:44:01 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:44:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:51 -0500
Subject: [PATCH 13/15] clk: mediatek: mt8512: merge the apmixedsys driver
 into mt8512-clk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-13-1c3b5d8744ba@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=FvGmBBByWBVmfKmn48E3uuoZ5LxI1oQQuU2YoggCoGM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtX1SP2FYsYahjg1X/j63HbrKZFIJOJIlU4lr2
 Q6v3xxyeWKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV9UhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A20IH/jKhDn+z+5qQwQ3ggGpz6tmp0+d0utzGd4891+Y
 394yKbxOKZQH2e5Q9cQnaB6qqp/mNobb6x1ax7MS/162PNt1HVd0JddstQEZRaYCzG3wHFTC1pL
 i/FJZhDLsMq3ngVkHQaf8HwQX3y4Q1UN5Plon9QgsR/I0wdHmhI0KoLdTX2Kc5430IW7ohcvR5T
 Hw0K1ZMiPGK7+ZSRcWUIuDTVSzhmvuzAIjs2DE5njlGopE2rrsqoEOVJA+plZ2rnRCsv0Zqr1Ik
 kkcmZncLxWRBBfnGXG0Zqdh1hV+VWKsJV22nv8YLLIIgEUjH15MRUAf2h2Y7HyK5aNH9wzJoSfY
 AY2A=
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

Move the apmixedsys compatible into the mt8512-clk of_match table and drop
its separate U_BOOT_DRIVER entry.

It was only kept apart because it used different clk_ops. Now that all
MediaTek clock drivers share mtk_clk_ops, its entry is identical to
mt8512-clk apart from the of_match table.

No functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8512.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index 0b763876f17..41710e63cef 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -819,15 +819,11 @@ MTK_GATE_CLK_TREE(mt8512_topckgen_cg_tree, top_clks, ext_clock_rates);
 
 MTK_GATE_CLK_TREE(mt8512_infracfg_tree, infra_clks, ext_clock_rates);
 
-static const struct udevice_id mt8512_apmixed_compat[] = {
+static const struct udevice_id mt8512_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8512-apmixedsys",
 		.data = (ulong)&mt8512_apmixed_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8512_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8512-topckgen",
 		.data = (ulong)&mt8512_topckgen_clk_tree,
@@ -843,16 +839,6 @@ static const struct udevice_id mt8512_clk_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mt8512_clk_apmixedsys) = {
-	.name = "mt8512-apmixedsys",
-	.id = UCLASS_CLK,
-	.of_match = mt8512_apmixed_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mt8512_clk) = {
 	.name = "mt8512-clk",
 	.id = UCLASS_CLK,

-- 
2.43.0

