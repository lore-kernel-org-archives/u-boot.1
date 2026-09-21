Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745BFC982EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 12:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F14E6075D;
	Mon, 21 Sep 2026 12:54:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uiLcl9qMLTyM; Mon, 21 Sep 2026 12:54:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6A77560759
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789995274;
	b=pb1JIINjqdWh+zV46OzvJRyt7t/p/YFQBnv4t3cn2Yd2BAt//WFZ2scFnmSLCn/mS0Xh
	 YGdif8PRH2AnemIbQjS0w9QqmPXDs/QPvdVKxpzjdATN/Wpe95LfjiOZRZ7DHoIBRbl9l
	 Jdrsfi19VrKujKRsrJss7DQyZV4vcLVI1LJVn7tfj4lIlnQ09xhG8XhbSysvJtjhNLL/V
	 IgcnYs7/1UbUVxho9ICEhaMAtIDpFa633Ut//R4OUvW5uYe3QhkSI46pdS1GDMHT3QRvs
	 qc5x2E4FfSgubJ3vcVkV42QZOEUWL7gemcVJtnrcXxZD0yDgKUK275KzLjYCRYQTXlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789995274;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-DKIM-Results:X-DNSRBL:
	 X-SPAM-SOURCE-CHECK:X-MAIL:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Fw1zlKhf2LGYX7zvhFf/fOgw9DeL6Qq18B6SO7Y5Tww=;
	b=F666NEMMnrDYYIHresrLmrag95p16Up6+0VTTqik7/LE6oCARL+YrvPRZ5ZlPu80BATt
	 0+UaBdC0b56CmcLdo0WoZvAAyojFnY7vD0m8QQuLNH+f1b4vTIldGt/9xt20VzF8giQRs
	 pWbtMywLK6d/YKSPdqTaiLgdoDVJQ13/JrhmumYsAP0A+sujw/5UHRgrECjyVJafDImKW
	 cy7TkiOyoUKWZNOMepQpF6BN8QD1xKT3Xjf07DRBsv7k/KWL+vEQzv6EJlGGxOoLcFhde
	 SUaG4aLyxhyZe57CbPG0cmdmuQvdilCiwv4lAiBMZCtQG5Hi1PCwhG7Tx02UqYO//AA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789995274;
	bh=Fw1zlKhf2LGYX7zvhFf/fOgw9DeL6Qq18B6SO7Y5Tww=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YZDtZQcv9ss+dLHvOpUUlQtDHGY3+HTI3uKBu3OtFR0Lq+yqchI0H4m+War1rOZ1T
	 2QIViHHEfYTPQD8Un4DreAsnAyA03xdPOAYSh8+urz3iromTllphlVa78bTb1aTiYS
	 y/E3JIAz5/baDMNMa16mDOB5m70ZwzzoAZfreMd4De0iVQ0pjyJnPsZXRGv/to7R/c
	 HTfnM7098EkZBYKHnXVKec4bDLG6BI0vLJDlqmwjzfss09RyG6C9lzuyb9sOySZaM3
	 GOlejJaiQqmyRmYkositE/wtDYuWKeDoCzmYC4+BT9VcwbjB543ZNydihTnPcijQFN
	 Sw21gvzfobYnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A77560759;
	Mon, 21 Sep 2026 12:54:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C26323AF
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 08:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B44EC40B60
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 08:38:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LioKhGMcJGdY for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 08:38:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F22BF40AB2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=43.240.192.165
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789979885;
 b=SqenGdGz0+2ejV+GGTjywkV4bZa6BVYkg84QeLFI0WQH+iwS7ooN2/Kw1mEjeukKXAB4
 mPTJRULfSDzEJgQWW9S+PWDNk50CawlFV37VjXeBv6UUKUkmWCThXnxeBaOccB4n0TVl+
 oKZhfAgDjKzM1fIvCM9GnBUV9qJUzvbY3fD31GVVt17lWS0EasVlBeDvOaR97WJw3gAcB
 kk8PgNkGbV/bFCbOizvscOJchSlIzW5PLeMRdWLUUjMo4rcdzGDVMFzAzriQHLX6IOVeB
 LlKBlQ+tM5YDjac7fv5iqN9us6D1t5QvKTah700gySKmRypJZdYAe6AC5EG3KAdXBrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789979885;
 h=Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:X-DKIM-Results:
 X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL;
 bh=Fw1zlKhf2LGYX7zvhFf/fOgw9DeL6Qq18B6SO7Y5Tww=;
 b=WcAB+N+ZsXwSosNBUmCDBfIbPZd02vZSEG913hjO78wXvE2Wf8uT2Gzl9dRgaajtNA8V
 Dt5fW5DRdqle7Ey+FgQKkY1JcfrbNPj+FthJMhtASb3xHWt8DQPfG90SKcTlY1S3zx4dF
 Z/wE+Ukz8sRcURC9vxcb3af57/JUKn6687cjbqnI4bnP4PF6xrzhCvfKy1afIM8hqIeDd
 jJRgQTRbzuZU50hZhg4XJu04GCGvDIN6TODfDRKITIHO9atySRb9dy4K28L1K61D7d658
 z4G9qWNiBqkFyDxhwTRx/dNvnc0agQN9hPG9Y62cr0GIvFf+IjJjS1EWNdi0MYpKkQQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=siengine.com; 
 arc=none smtp.remote-ip=43.240.192.165
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=43.240.192.165;
 helo=mail03.siengine.com; envelope-from=lucas.liu@siengine.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=siengine.com
Received: from mail03.siengine.com (mail03.siengine.com [43.240.192.165])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F22BF40AB2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 08:38:00 +0000 (UTC)
Received: from dsgsiengine01.siengine.com ([10.8.1.61])
 by mail03.siengine.com with ESMTPS id 68L8bgR1039988
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Mon, 21 Sep 2026 16:37:42 +0800 (+08)
 (envelope-from lucas.liu@siengine.com)
Received: from SEEXMB05-2019.siengine.com (SEEXMB05-2019.siengine.com
 [10.8.1.153])
 by dsgsiengine01.siengine.com (SkyGuard) with ESMTPS id 4hpGmg5FGsz58pt;
 Mon, 21 Sep 2026 16:36:51 +0800 (CST)
Received: from SEEXMB03-2019.siengine.com (10.8.1.33) by
 SEEXMB05-2019.siengine.com (10.8.1.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 16:37:42 +0800
Received: from localhost (10.12.6.21) by SEEXMB03-2019.siengine.com
 (10.8.1.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 16:37:41 +0800
From: "baozhu.liu" <lucas.liu@siengine.com>
To: <u-boot@lists.u-boot-project.org>
CC: <peng.fan@nxp.com>, <jh80.chung@samsung.com>, <trini@konsulko.com>,
 <tanmay.kathpalia@altera.com>, <eric.chung@riscstar.com>
Subject: [PATCH] mmc: dw_mmc: Add the missing MMC_HS400_ES_SUPPORT to
 mmc_set_card_speed
Date: Mon, 21 Sep 2026 16:48:22 +0800
Message-ID: <20260921084822.58297-1-lucas.liu@siengine.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-DKIM-Results: [10.8.1.61]; dkim=none;
X-DNSRBL: 
X-MAIL: mail03.siengine.com 68L8bgR1039988
X-Mailman-Approved-At: Mon, 21 Sep 2026 12:54:14 +0000
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

In the mmc_select_hs400es function, mmc_set_card_speed(mmc, MMC_HS,
true) is executed.
The third parameter is set to true, but the judgment branch for the
hsdowngrade parameter does not include MMC_HS400_ES_SUPPORT.

Signed-off-by: baozhu.liu <lucas.liu@siengine.com>
---
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

