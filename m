Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DBFC5AC7A
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D062640648;
	Thu,  6 Aug 2026 13:05:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nryTwhvvxuWK; Thu,  6 Aug 2026 13:05:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3DE9440657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021504;
	bh=IsUGFmSnbeF78uxiR9aEaDNwoxt/q2ttr1C8Dl9kS5A=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=AZ07gIWTztqHi17LPnuTw9zXX6WmcaIMOlxaVkeOJpfKFcss1my9KbAaMSewxyAi1
	 wSX5S8Ts0IwJ41Gi9Qhu+PelebqUk1g3KPQD2hZCEKI3TR6F+IW/Q5BtKgg70d/3QX
	 v+5KtKB6+Jh+MZqANkMfz9bZ8rU5OnTpx0MlFL4NoramdLk8Vha42LgTowsTNhAklR
	 q4e8P8MZ+5KIp2EMQXwnB2YHOqR6WdIHAYJEo20Dy5Y/CWROJ0Uf0ckvmTTKLEVmW7
	 yXOjmNJFZenNA6+dQHr2POp+uKCQxeu2JIcdeoTGtoUbLFWVc5oZLWBkHmQx3Bm1Si
	 qqddwbTQN2qzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DE9440657;
	Thu,  6 Aug 2026 13:05:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D46F9218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5ADF80DCE
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:15:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6n4_HxDUIGnN for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:15:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BC22780DB5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC22780DB5
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC22780DB5
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786018430; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=C0DN4M4S/GXKwednHiaZoSvT/Q7A2h6gmdIaGPhxcIeZ6TXTCepTfD2DiFGvu2HncC02mc7kvMiUgOojDMkRWgJX2vl/EQHV4KPH2dKHcbcAoDBEUKSe82CHz4mkj3nZ7totKPJOpFLsJPLUHQQcYFK3Uz83N9a7LzIV51KLMRA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786018430;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IsUGFmSnbeF78uxiR9aEaDNwoxt/q2ttr1C8Dl9kS5A=; 
 b=IjFZLC2Alt6YcRWVl2Uz7Kl+31br9OjD71dEDpxXuWWYiZA1p1FSWQhWQoWj1EEIT+YyX5TxVV/J0tgoW/jhmX2MkCS50OiJcISzxmJdnU61MtZZ4CempTupI5mt6/e3EV1YAtgzAOskrNSvpcpPlMty/9B24dcECImaFLA9cCQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 178601842520115.751473938330491;
 Thu, 6 Aug 2026 05:13:45 -0700 (PDT)
Date: Thu, 06 Aug 2026 20:13:21 +0800
Subject: [PATCH v3 1/7] clk: sophgo: cv1800b: Add SoC-specific compatible
 strings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-milkv-duo-upstream-dts-v3-1-917cf70a2337@zohomail.com>
References: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
In-Reply-To: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Guodong Xu <guodong@riscstar.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
Feedback-ID: zu0801122760aef652722c9ca7d7f19ead0000431358eb24d5318b354b0db866bc79fa1285aa76cdbf2b22fc:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 06 Aug 2026 13:05:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1786018430; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=IsUGFmSnbeF78uxiR9aEaDNwoxt/q2ttr1C8Dl9kS5A=;
 b=FvSQuT0j/au2tA8+HiJJwggHI5JOGTqvt/zOZCgL/PQ9KKYDEQTIIzJQAL1Cu9U4
 a6FYMq+nMyn9NftaUbRa+KsusAZO5gJMdce1Z2kWlMnaPDrYZ6+YTEMHWBMZktDjgRt
 zHCVqOljpmnDwQ1IrUh2dcVOFDX/rQ1ekrdHEhyo=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=FvSQuT0j
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
From: Zhuxu Ran via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The upstream CV1800B and SG2002 devicetrees use
"sophgo,cv1800b-clk" and "sophgo,sg2002-clk" respectively.

Add both compatible strings to the existing CV1800B clock driver.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/clk/sophgo/clk-cv1800b.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
index 248a69321fc..57051c1ec0a 100644
--- a/drivers/clk/sophgo/clk-cv1800b.c
+++ b/drivers/clk/sophgo/clk-cv1800b.c
@@ -744,6 +744,8 @@ const struct clk_ops cv1800b_clk_ops = {
 
 static const struct udevice_id cv1800b_clk_of_match[] = {
 	{ .compatible = "sophgo,cv1800-clk" },
+	{ .compatible = "sophgo,cv1800b-clk" },
+	{ .compatible = "sophgo,sg2002-clk" },
 	{ },
 };
 

-- 
2.55.0

