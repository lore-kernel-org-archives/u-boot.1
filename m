Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D0BC982FC
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 01:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85AA0407C6;
	Tue, 22 Sep 2026 01:28:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eUpX-unpU7dO; Tue, 22 Sep 2026 01:28:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0279B4073C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790040495;
	b=eHqtnh0/8+qflpKVK9zh7s9bfTm7QLonUnSF1TObfljiGmrr1/LYQWkjsEVdcEM8SAjm
	 Z2d701sMcsQECbEXskC2Wu/jBZwzr1l8fhI99vDzRKaRk7fx3mu/Rwv9YzS0peXNfz4yW
	 OHNV1PYzTG0jeVqE0qqHdjIp0QPfHIgpytDgbocGOgLvNEecKEhjJBKQg2b06fyAanEta
	 BEy8wLPB1ukxgzwY5q44GelLnqzbEjpc9Wv8Qbrp3tKbEbEV0FResA0G+N5goq2ZvxL65
	 sRtgu6CAj2tPzN2c9WZ5dyRE5yDjrMaLypY1O6M8+O+9YBcqNR3jOB1+PwyEft1EECw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790040495;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-DKIM-Results:X-DNSRBL:
	 X-SPAM-SOURCE-CHECK:X-MAIL:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=enCnLN6COmRxLoo4durm2fBHfJmSGCvOTTxbd7qZEuE=;
	b=aa11BUZgh9oauOHi5Zz52qnQpdBuAfwQsDOFeT9cc92leGJPEzuwLLhkOnUwlbMS8iyP
	 0+2Km0eXLLcQpRhiX8gJReXlDjPkKwf06dW+5A0dnNIQTBtfGAVPys9u0WT5ODGVQvjq1
	 1qa1OWNISd7wZiP5PfzhLl3q9ySSKPnXvsOHelTF5VJ+E8lpOcbK3mu+fOEPNaAEAarpC
	 zA9AgnSqoDqUT6bcyecAyZU6oFzyngy9IqA3WjGPkxKFM6bNBDzBqDJOKutSzO9k0juBM
	 R25t0WV1drfGseEc5t/xgMtBI1EzbuShfC765IVzjLuK7LoFr3gBsbuuT6Sg+x2/psg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790040495;
	bh=enCnLN6COmRxLoo4durm2fBHfJmSGCvOTTxbd7qZEuE=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aCd6mxf9x2w4Fk6S+sOnDvA1Qv3h2Vm/HnBIDofeMKfhv6Lg2ZT2FdC4Ug4P2ra5A
	 ylhbNWUti1ay95mJ6nfmz2Qd+3v56MC9Xksd0DmiPEdIW0nBaUFosU+hkiphOuYD3s
	 ldgIrsjj3d2aysex1W6czb2pPV3UDPjRJ+aKASBEaKDn0dcnnRYobPahwSKQuvDmYL
	 GKjbTzb2Eo69AjOuvWVvph5y2kXIjYjOO2XZr0xaNiE1ZYIg+DgytY1PdAAG8JCgT/
	 /bEvhaQiafRmA07yUTiFPE/F3cL6JI8P4n7CggIvWdaaOwGgkt/YKEsHLmXsHtu8Ut
	 mjtWtvj07gRxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0279B4073C;
	Tue, 22 Sep 2026 01:28:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AFE3194
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 01:28:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20E0360668
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 01:28:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3r265Otr7XQu for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 01:28:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 02E1460656
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=43.240.192.165
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790040491;
 b=r09RvvAJ0LAJ+YJGI4em1FYDMv0P6FoxIIVejzqaH6oYqD5D/t+tDt5o6DZ459cJntq6
 LVOlXBTGiUgU7JybnfIIDdQ/P/HR6oMHCEOTNWf+hvGBYlVGQQyVlm3pH5ESr/YC8pyDU
 ZXbaHT9I/prmumtq/y/FFA9yeZ6a+ICYarGdo1RAxLFR/VuL2BD0X/Neu3oNU4oR22HFf
 Tvpr+NoNtdAaq4tYfHcKpRMOJix9A4Ibv3pLUMVe9ABtu5yKCstToO5pyOcqk8Jj3ZLoc
 eAE78j9WGqyQFrDZH0XG/sTQu+sPcRU1pQ41Cxki6a4SVzKCYWBiNiAnR2bYtEA6FyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790040491;
 h=Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:X-DKIM-Results:
 X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL;
 bh=enCnLN6COmRxLoo4durm2fBHfJmSGCvOTTxbd7qZEuE=;
 b=EqCdm7/Dj3aIg6xZozN/VposU8vd/6g07715VKTA20qBVUAYUkbyNgW8tZ1r05ngQLiY
 tL7bwMVOBEBi3RDHZP8vUglEbUHQXg8DVKRw0MtfzsxttvGM7aNyDFRh/ebNlRHrRc8Gl
 uc0K7t6Wq1LQpBWSugVaO5kyPNmaTs5iwqtoOyV30v5heDoKujvYCipsEC/kQeNm+0N/f
 LH/RQxA2UqpxovgZ7BWPmW9KTXQgQK0mD9OwIXVpShiJ0HF8vx1pOMdFuqrQaBIh1NUKD
 DLAjh8GJJSot+FQPgc/gNObOPb5LIq9wxS0KZl0hxV1JDJqY0SXLzfwZjQ87I+ulirg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=siengine.com; 
 arc=none smtp.remote-ip=43.240.192.165
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=43.240.192.165;
 helo=mail03.siengine.com; envelope-from=lucas.liu@siengine.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=siengine.com
Received: from mail03.siengine.com (mail03.siengine.com [43.240.192.165])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 02E1460656
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 01:28:05 +0000 (UTC)
Received: from dsgsiengine01.siengine.com ([10.8.1.61])
 by mail03.siengine.com with ESMTPS id 68M1RYMP078591
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Tue, 22 Sep 2026 09:27:34 +0800 (+08)
 (envelope-from lucas.liu@siengine.com)
Received: from SEEXMB05-2019.siengine.com (SEEXMB05-2019.siengine.com
 [10.8.1.153])
 by dsgsiengine01.siengine.com (SkyGuard) with ESMTPS id 4hpj9v1wldz58pt;
 Tue, 22 Sep 2026 09:26:43 +0800 (CST)
Received: from SEEXMB03-2019.siengine.com (10.8.1.33) by
 SEEXMB05-2019.siengine.com (10.8.1.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.2562.49; Tue, 22 Sep 2026 09:27:34 +0800
Received: from localhost (10.12.6.21) by SEEXMB03-2019.siengine.com
 (10.8.1.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 09:27:34 +0800
From: "baozhu.liu" <lucas.liu@siengine.com>
To: <u-boot@lists.u-boot-project.org>
CC: <peng.fan@nxp.com>, <jh80.chung@samsung.com>, <trini@konsulko.com>,
 <tanmay.kathpalia@altera.com>, <eric.chung@riscstar.com>
Subject: [PATCH v2] mmc: Add missing MMC_HS400_ES_SUPPORT to mmc_set_card_speed
Date: Tue, 22 Sep 2026 09:38:14 +0800
Message-ID: <20260922013814.59491-1-lucas.liu@siengine.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-DKIM-Results: [10.8.1.61]; dkim=none;
X-DNSRBL: 
X-MAIL: mail03.siengine.com 68M1RYMP078591
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

mmc_select_mode_and_width() already passes true for the hsdowngrade
parameter when the bus mode is HS400-ES. However, mmc_set_card_speed()
only checks MMC_HS400_SUPPORT in that branch, and if (hsdowngrade)
never checks the mode itself. Add MMC_HS400_ES_SUPPORT so the
downgrade path also applies to HS400-ES.

Signed-off-by: baozhu.liu <lucas.liu@siengine.com>
---
Changes for v2:
- drop the dw_mmc: prefix; the change is in generic mmc.c
- mention mmc_select_mode_and_width(), which already passes true for
  HS400-ES
- clarify that if (hsdowngrade) does not check the mode

 drivers/mmc/mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 670e92ee12b..2bc36c1405c 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -1007,7 +1007,8 @@ static int mmc_set_card_speed(struct mmc *mmc, enum bus_mode mode,
 		return err;
 
 #if CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
-    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
+	CONFIG_IS_ENABLED(MMC_HS400_SUPPORT) || \
+	CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
 	/*
 	 * In case the eMMC is in HS200/HS400 mode and we are downgrading
 	 * to HS mode, the card clock are still running much faster than
-- 
2.34.1

