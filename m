Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45ACC3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE87885C5;
	Fri, 26 Jul 2024 14:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.b="Wld51fS4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5DBD88395; Fri, 26 Jul 2024 14:03:25 +0200 (CEST)
Received: from smtp30.i.mail.ru (smtp30.i.mail.ru [95.163.41.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B9B680C58
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fido_max@inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=BFDzryoMbp0/Endz36Mmi6I0Zj3B2j/aTrdG/N0adE4=; t=1721995402; x=1722085402; 
 b=Wld51fS4ZzDvZEjK8wiWk2PBF1GPP4GY+LMxQ02WG/IaPZzRMrZM3xSrIbFoqaRXYvOC5ZbIkJ+
 beStcwXLPTtfzMP74tAoqpH0kOd+FzYpTMXD6MtzQGSa8RIu9d0L0lLleaeyA+e3MGRt9equNmYmf
 hgMfF/nKnXhENeYykCNsvy2rmcgWKRPt8DzNo6cpL3k2CHGzn10ziUx3pXHWpwxU8ID+3S9naI2fz
 QnQH1eFB1UZ9cxyL9BCiD4pSwLwIHpWIc25w4KhPSwrSF4Gp7TQjxAdUNps5cQo5Q37yvIpfkRhxT
 gIV7j8hG6grE8x0FNDnFEY546xwIb9QHRd5g==;
Received: by exim-smtp-868bf69f6c-995c8 with esmtpa (envelope-from
 <fido_max@inbox.ru>)
 id 1sXJfK-00000000KKh-32Qy; Fri, 26 Jul 2024 15:03:19 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: u-boot@lists.denx.de, lukma@denx.de, seanga2@gmail.com, trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, mkorpershoek@baylibre.com,
 eugen.hristev@collabora.com, ashok.reddy.soma@amd.com,
 jmasson@baylibre.com, forbidden405@outlook.com, bigunclemax@gmail.com,
 Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH 1/1] clk: fix clk_enable() parent enable
Date: Fri, 26 Jul 2024 15:03:09 +0300
Message-ID: <20240726120309.150180-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-868bf69f6c-995c8;
 auth=pass smtp.auth=fido_max@inbox.ru
 smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C6C95C4F1944E32E59211CC92C36EF20F3182A05F538085040A35D4E464453917A3DE06ABAFEAF670510ADF8F34EFA81C45FE6BF42C7EEC79F784ED878CF4C7D9C
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70386A6136E33FD82EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006370CE92FB8C11ED3D88638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D878CCC99EDA921842AF799F7A84AE62481E0D30A93A56459820879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0F73DE2C02C717D058941B15DA834481FA18204E546F3947C5FF72824B19451C6F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F3E38EE449E3E2AE389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC8C7ADC89C2F0B2A5E2021AF6380DFAD18AA50765F79006378A4BC95AACA28A5322CA9DD8327EE4930A3850AC1BE2E735BA6625F88748EAEFC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A558AE24AEA2E48F9F5002B1117B3ED696CDA5D1555D99465C715D9AB585B0EB04823CB91A9FED034534781492E4B8EEAD14747542773C033FC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFB34B9013CC080A6484DEBF20210198F8EF862DABA77507D675A378868D09D7C849C71475D3C809317D42B5C1564802C6E88865CF72E077AD56F875277CB6233FF9A26E73B8E28A3D42BF32D1DA1046D202C26D483E81D6BEEB84411BD425175970A7FB4ED9620804ADE12199CE9660BE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojW5AakKLSukNni1dYqr5mTw==
X-Mailru-Sender: 689FA8AB762F7393C6D0B12EA33CAA9B0919BC22544F9BB1D9570471C5D7F4F330E16FDE6B8D971190DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Fri, 26 Jul 2024 14:43:57 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Move clkp->enable_count++ after clk_enable(clkp->dev->parent).
It allows the parent clock increment its enable counters for proper
disable sequence.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 drivers/clk/clk-uclass.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index c48a62ba09..d56001c0b7 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -618,10 +618,6 @@ int clk_enable(struct clk *clk)
 		/* Take id 0 as a non-valid clk, such as dummy */
 		if (clk->id && !clk_get_by_id(clk->id, &clkp)) {
 			ops = clk_dev_ops(clkp->dev);
-			if (clkp->enable_count) {
-				clkp->enable_count++;
-				return 0;
-			}
 			if (clkp->dev->parent &&
 			    device_get_uclass_id(clkp->dev->parent) == UCLASS_CLK) {
 				ret = clk_enable(dev_get_clk_ptr(clkp->dev->parent));
@@ -631,6 +627,11 @@ int clk_enable(struct clk *clk)
 					return ret;
 				}
 			}
+
+			if (clkp->enable_count) {
+				clkp->enable_count++;
+				return 0;
+			}
 		}
 
 		if (ops->enable) {
-- 
2.45.2

