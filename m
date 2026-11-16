Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B6606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WOIxQJVi;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=BQZ93raR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71EB181155;
	Mon, 16 Nov 2026 17:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YmX2AxKgjS_X; Mon, 16 Nov 2026 17:36:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5F34681089
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850594;
	b=WKNKutIvb2tNF/0+e81Rcy6YCo2MwmDk7Zsnt11viK8GIMpD+1NOBsanUTLBk/EK+N/V
	 +SeF/XvTxOhhIM5vdZUrnqbZ7gQR+9r7UNVMPZoh+UH1zihwwmaNqXupvjTwLm3ler7YH
	 V1nydIITxmh5KsVx+Ui7ggDS2CrXQw7Q0wArIzb9to1CbAP84rJAZ7o5QINem50t0njxi
	 yEwP48Gpv5PTnE6Nce3mJp8r/+76Jne/El7Sf/DCrsKqHe9G8BvstGT6Ai6cp/l8+xVGg
	 Yrx9Uf/cXdWFFSKYLcW4MV3XGaH/ORkQCRQp/Bob6a667StbbWluPYFS/3Xl5veIf7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cP8TUDOTn7Ur/1oh9CS99g4G85T/GInghZpMvHArKF8=;
	b=Rm04LbrrxIEn+LDtyR4gCMGEDVhbS/afF8ucSLePfTa3udVhrD2H5ccXLGioXCTUNqs7
	 HzjrVoJYem1MN75s6fH7ka6x8VIUlD2YvcPDWX0QYliLXJ15bntq6X+lA8mf+4Mif6z88
	 DJUO6ZMqcQ1DOsmBN9teNcbd3z4E2U94QS9nVYmVTUuxTl5GYTBc+OUaf1+4VCqLfkZf3
	 LsRU8HSTrBEtt1r3WQlHorpc3m/ogrc7BKPGJEB3EBTcOwG0ezTvuYtCQMkh8wimaeMCR
	 sEl1IQwvWdtD0otsu1x9daqXtsZO5WZ4fifcW+jb0wt0VPriDEtP4IfQJRNobfyLzTg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850594;
	bh=cP8TUDOTn7Ur/1oh9CS99g4G85T/GInghZpMvHArKF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WOIxQJVi1gugrBaRhbS637W3Bl6e5GDcsoqLtgG1KCF3K94kBvK157ca2WFRWNYAL
	 5A1E38Kjorggm6npTkcflcyApQ/LBf9EzmCWw2kccyr33UkshVhngYA7MSDdT9kl5a
	 x/sZcuEo1O6VZmU/qcSV6wQXOpK4F4ad4mw8y41lf6ny6knV31NzxfpnywbR041z0y
	 DjIgI160dZG7UEPFGwgM8690fEasTWKkVNWavUgTwJLErmH7JElr76CCEkpTipgl8k
	 8gbcHmtkDm2VkUffBztxEVWdZjZLoXHldOuhcT+MVh0fuP0nrYGuIQpuATGjAL/Pyd
	 UpcOxNOJFshRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F34681089;
	Mon, 16 Nov 2026 17:36:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 28F6570B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13DFF40783
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zHXizd3CS-sX for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 497D140781
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=BQZ93raR
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 497D140781
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:05 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSw4y2xVkzKr6p;
 Mon, 16 Nov 2026 18:36:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cP8TUDOTn7Ur/1oh9CS99g4G85T/GInghZpMvHArKF8=;
 b=BQZ93raRkMcjke0JA7S5ZHds3O2cFdSctQ3g/Byj+tU4XwSLnLf9X7X5z5cbk9nje922mR
 A/RcjnnB8x8WzdBDwt7w6K/Z9ErEOCWZYwTerooTKSziTtt9ESZsTmUvcz9lEm+3gM9NVM
 ZcbosGf5UwHSCSYOWQEd7/kqCzSa03ATrwFAnIImxuE5evM//OfXfoqg40IecBjXlWpjUU
 i4GS4qumRvJ0OmSaoPRxHNCod8ibXwsLoQ8lu5t1AZrgpFedZ7DJxEbhElhrizjZH4WVZB
 R8zWZtagIqAWZOihljfXPr52yxS2sK7VvoT5WjXrvCsc2b7zDStqNU1tLMJ6Pg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Liviu Dudau <liviu.dudau@foss.arm.com>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/20] clk: vexpress: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:57 +0100
Message-ID: <20261116173546.3487841-18-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 227728810161f9d4bf1
X-MBO-RS-META: b14s9hjpr4omtexcrte5t3ged7kke19z
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Liviu Dudau <liviu.dudau@foss.arm.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/clk_vexpress_osc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_vexpress_osc.c b/drivers/clk/clk_vexpress_osc.c
index 85ac92c908a..9e7fb9f61c7 100644
--- a/drivers/clk/clk_vexpress_osc.c
+++ b/drivers/clk/clk_vexpress_osc.c
@@ -62,7 +62,7 @@ static ulong vexpress_osc_clk_set_rate(struct clk *clk, ulong rate)
 }
 #endif
 
-static struct clk_ops vexpress_osc_clk_ops = {
+static const struct clk_ops vexpress_osc_clk_ops = {
 	.get_rate = vexpress_osc_clk_get_rate,
 #ifndef CONFIG_XPL_BUILD
 	.set_rate = vexpress_osc_clk_set_rate,
-- 
2.53.0

