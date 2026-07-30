Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E483C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34AB940B30;
	Thu, 30 Jul 2026 14:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yb5cG0xoGlwW; Thu, 30 Jul 2026 14:13:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6533140B2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420808;
	bh=KMFUDfi2Z5RW27lTiNj8KuPAevO3Vq2GPSfOUKoKizc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DZaJ5cABVqDMF+SGXkdPMg6v+9/UGUcn6ceWrZ7Q3wub5XpUR9sOmF1iFkxmfUUh8
	 RiCoyIEwh8ZJMS9L//rngA2/Wxre1MFuoNXYF5Wvys6ilDf6SvfaKar/ibR4oqfwV9
	 52+7i+VXmwpBF4N2dS2cIWvvh+3FtIz92Z40rTAoDCDkz24sEMDUD+ibytfGfreZ/g
	 piotlfSlJX8HRBnqv5Lr65yiRtVhEaNp7v7AExPYaLCjYPDuWo2QrLWEyjlDEWltvK
	 gHmXgudffrVKguAv+7Tp6KeSe+ZLc6+BU7r9NBrjt1/3kkxNbzgVdcD5YqysjO21IH
	 4vz2ccCqDzb8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6533140B2B;
	Thu, 30 Jul 2026 14:13:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DBBD69
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 338C580FDD
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l4VDah2eNZTZ for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8B1FF80D47
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B1FF80D47
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B1FF80D47
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:22 +0000 (UTC)
X-Forward-Email-ID: 6a6b5bfda254ae338c09167c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.12.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 01/15] clk: rockchip: pll: Fix double use of postdiv1
Date: Thu, 30 Jul 2026 14:12:50 +0000
Message-ID: <20260730141308.1218014-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420801; bh=KMFUDfi2Z5RW27lTiNj8KuPAevO3Vq2GPSfOUKoKizc=;
 b=LwhqoqT/n+DcJ9yqYGytBHHSj2LBLxlUrT7j4TqTkGSDcO/TgoxjrKMENkaMSDIm0tLheOMFm
 obE8ol2l00mkDdaSgktySTzvAArFvtl9RRUSFPWFdhPieb747OlzG6btpRSdqpGz1EntDHMqAKV
 HL7jDiNJnHfKncuirrdcCHbCOpNzOdlS/bsvwBNtX5k2jcyKP2C9wgCiBzrM32e3jP+2VEYKDeJ
 +Fh66jgBiWQMoS2oInH24y/uCOXtWhzFYnG9tu/ioqtgqieLUPegqeKIPezZkXgsl7ppf/Y2zdQ
 NoG8Zan9VX2k/qEtNGxUTrW6jE/lpNiDbp5ZvbrU7Ylw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=LwhqoqT/
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The possible frac_rate part of rk3036_pll plls is divided two times by
postdiv1 instead of both postdiv1 and postdiv2 as the integer part. Fix
this by using postdiv2 in the second do_div() call.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 9dec40b1fe83..4fe67c889376 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -405,7 +405,7 @@ static ulong rk3036_pll_get_rate(struct rockchip_pll_clock *pll,
 			do_div(frac_rate, refdiv);
 			frac_rate >>= 24;
 			do_div(frac_rate, postdiv1);
-			do_div(frac_rate, postdiv1);
+			do_div(frac_rate, postdiv2);
 			rate += frac_rate;
 		}
 		return rate;
-- 
2.54.0

