Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE2DC98302
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 16:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F27F80E8B;
	Tue, 22 Sep 2026 16:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZpukCZ9aA7i1; Tue, 22 Sep 2026 16:50:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6721880EC1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790095813;
	b=I1vgsDosdgO7E53CkDVeEmsHoLvsgQEH+RbprhdC/w1Cv3OLPTDySXCPR0yF9ZgBN9V/
	 NmVQX27y/pGIt/ypPhYipdCFcRwya3S9JlicWon05eRn57batSSb6EFrfnF+sX++878o8
	 pGIHN1jQF7ULP27zjBDs0at5yHH39lYeTu040HpoDJiu5b7JclqjRCmft2cXHLukxNWzG
	 zKVxmyvDNu5sNTE5Rg5GmSH+sT3nHhk351uTKGJyHtlP7vSAWZ4Uuuy+dywKIxBfoz0Gv
	 sP1gJL9CJOf4T+G59AV4pM9N3F/V1gVYm+C4ZH9CrglwWSuqBuHTAZ8hYWzDk/h45UQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790095813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WoMYcr/cWLhLj4yK79gEPCTS0V/fcpQbbLl5NU05CCo=;
	b=CREPvj2skzgxm6xEP8lHSxIiwPy0iWg++2fLRsXtMQPBDM/1CMCY7mWih8XQjkkzQLEV
	 bfMfAO69GS7V9LF8dg+HW+cjJuRhgVUiq6hMqu94g3J2YNYGrLNwuAQgvTePCmXKDADj7
	 s8sQ0FK7jlfmOlUPzZCyOp+ITJjSfl1O8wxe0uK0T3armtnk7Lh89prYUjD4015LFtp/e
	 O8nrr3kxHur803lEfOV7Z+uiLtylwxdpxhGCsT+c9XpZmbJPGNuHxxBY4mTx9d2XAxIvz
	 pRGBqEN4RuH5S1sG+yXRyiSZqieQeD9zSJQ9LiIqQrOBQvryqr64t2M50zDTe/zOTrg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790095813;
	bh=WoMYcr/cWLhLj4yK79gEPCTS0V/fcpQbbLl5NU05CCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S0lltJbj0CBUYmicvfJJ6CeWhtUYYocYTH73Toyfwc6d0WtgvvVgGzbS6UuxfIC3e
	 kCRchVn6vcHfyWe/d1G38tEnGmEiEuAuXHXoAPGVyn7Qh0a03wBSAhLkbZVQm8sAri
	 KeEVOS+AMvrca3iq/6Qj8bsZXnYUiZl8SB8wb4ZWMIP/BXfxdfv5EX5ai5naTr8u8s
	 zRQ8IF9feLnNCm61ftQYWm8+BGvEtSlAwl1LyUDo/LDlHvFeRCQkvx/jTUHcTEwXBL
	 +7H5BEeJsisRyNWiLjFtW/wuc0ov26ufZUkR9d3Vrt65/wAifGcsOnzSznoFFBKka8
	 jcPA4w3Noyv9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6721880EC1;
	Tue, 22 Sep 2026 16:50:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F16B3472
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D745A40545
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:22:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ToLdNG95lzcZ for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 16:22:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 485B840511
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790094143;
 b=XWRugx29F27GnNKH8Q8vJ358Pzk1abyl9F/3fpFNbunU2B3fN72iMc+fbR+ls6G7Pewv
 Tti/Ypx5OifSEYil30Bh83r+Dkk/eUBEqVZsu/tc5ebtg509fSEwTChhfTjRJp2WkKNe0
 YcvRQNvnn8gjnIAYVjerB4tAFLBjFb43r5bHHtiVg93BEDoFXCBoPqaMiNymIDmsxUJRm
 98oNfSiMHXaB0gvrMcRIHBzMdnKJ9wMzUhtiIh6pXSyz/K+4km7I7J2jT0MBIfXGLypHC
 Zt3QtR+cM//mjy4PcxzUx1d3mJqcn5qaLQQK7GpKBfassvVSzzuy7CBhUcDZog9CCDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790094143;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=WoMYcr/cWLhLj4yK79gEPCTS0V/fcpQbbLl5NU05CCo=;
 b=M5HOSc6ZbfNNWrmOoHUBDF3gQZdoXxv/AchuICsmchvTtB0YIeoQhJMgUluedj90RSfa
 iWWjYCUHpGhLAC//C+xZrDdXAfIK1ybew34DQ3gtEfITQY02yi0nTmmUlEQJCGsQPaKnD
 kNVvHS8sifF4q4d4bGuSzPyE76QJv173TATVvAncrXFPpXIAepNr0JbUNB0tPE0FXfoE7
 wJX9FVCd1ON5OOz4JDnSJnK01aflWFR9ARRTBP2dndLPUBn4NMKiwgb0qaZjDxuG+tLHp
 KUW6V8fhsN8DebruO9LfL7ClAl3q+qfO/qOnMGn2i8jEqH2QE0bdwOOHiUo+FODFQkA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b="e80L/Slz"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=e80L/Slz
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 485B840511
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790094093; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lT6KS5q5atKCnrMUBZoBOKA3MZf9BbPNuj4jVTSO6+EJQ/G6hQ0iB4SWMMekKWpSI/u/eQnAUitsnh/RQE0I8CsHvVXqYbSLsZWI8GJW7uL6bUKcLRD34RJPs1YfC8odWTTrXoeKKUTvO9J+x5oJQxrElgSqrGN6+33b4a9j3u4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790094093;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WoMYcr/cWLhLj4yK79gEPCTS0V/fcpQbbLl5NU05CCo=; 
 b=INjgW3q8GPNXwCYDPVpMv4ljDNsDu29y1NnWECxbjLfM9wjqOi/hOKa4DY8C8TQ5zmoiAOpVXbthJjJO60NSgVIvG2tpda0qubxJHcmAzv/2Duc0/S4vAJVSU1GKJQIzjGhJIazD+HL0mib/D6324++PHpuoFz9SrGKfNFLQo08=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790094093; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=WoMYcr/cWLhLj4yK79gEPCTS0V/fcpQbbLl5NU05CCo=;
 b=e80L/Slz0PU3t8lFTLBsyme0Sa3CBiGOV84M+abF/ubP6ZmjsFPaSNUB9hhCv+Bp
 g7yDkhC1wXd0ys9ZqBWjTDe+IgMLOjb78vF+XKhNocBsjJF1HIHB71atWzF12L8yu67
 ajzn8oH82nQH5EGEhm0OCJBlCQEwTEqEjHxFQ5CU=
Received: by smtp.zohomail.com with SMTPS id 17900940919204.05439948831156;
 Tue, 22 Sep 2026 09:21:31 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 22 Sep 2026 23:46:26 +0800
Subject: [PATCH v4 11/11] clk: sophgo: cv1800b: Drop legacy compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-milkv-duo-upstream-dts-v4-11-d45b74dfad36@zohomail.com>
References: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
In-Reply-To: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Zhuxu Ran <zhuxu_ran@zohomail.com>, Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
Feedback-ID: zu08011227cc7c5d3e1afb73eee1ea9fe6000006ac6f6268849537817df814c8c60e063f000f3db736a88805:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 22 Sep 2026 16:50:01 +0000
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

Milk-V Duo, Milk-V Duo 256M and LicheeRV Nano now use upstream
devicetrees with the SoC-specific "sophgo,cv1800b-clk" and
"sophgo,sg2002-clk" compatible strings.

Remove the now-unused legacy "sophgo,cv1800-clk" compatible string.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/clk/sophgo/clk-cv1800b.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
index 57051c1ec0a..2270a076ce2 100644
--- a/drivers/clk/sophgo/clk-cv1800b.c
+++ b/drivers/clk/sophgo/clk-cv1800b.c
@@ -743,7 +743,6 @@ const struct clk_ops cv1800b_clk_ops = {
 };
 
 static const struct udevice_id cv1800b_clk_of_match[] = {
-	{ .compatible = "sophgo,cv1800-clk" },
 	{ .compatible = "sophgo,cv1800b-clk" },
 	{ .compatible = "sophgo,sg2002-clk" },
 	{ },

-- 
2.55.0
