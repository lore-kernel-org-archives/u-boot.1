Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F19CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B54ED84C59;
	Fri,  8 May 2026 10:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="f/nxqD1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7E884AF6; Fri,  8 May 2026 10:21:43 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C102984B56
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=33KD83HWfRlX/Ui2IOxTRZqGFYcFTH0gKyVvdPn4atI=; b=f/nxqD1m+acBI9hux5toveCs9L
 qVdYfZnXO0IYzOLpxq8RHTcVQYHeTfSl57zqJoOnd0gIx16+7QDphlEzh65G5Ph5ZwtCn7txp+6tD
 ZMtLGuBf1QfkvBrV50ZVDZOUVIBCW+UekPROAEuFEO79oNAwsrY8IpTabb/R5fyg6YpOB/5YsPdAM
 ux36paewDZRB+onwKZaipj6bqwt7LeHK7hX9ZCg/+6zYn98H7mRMFR5oPaa8++qG5XRj8bxvbxekh
 jPBkWkSLEY1Ah2pSSyvG64An3ggJIKzRHL+zfge8rpQEWy1aLj40Whb28jdzfXE6ruqdawepQvb2o
 /mtt4Hdw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGSr-0005nF-0v; Fri, 08 May 2026 10:21:41 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGSr-000P5H-1B; Fri, 08 May 2026 10:21:41 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com, Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/8] cmd: date: improve day of month verification
Date: Fri,  8 May 2026 10:21:25 +0200
Message-Id: <20260508082132.25476-2-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508082132.25476-1-Alexander.Feilke@ew.tq-group.com>
References: <20260508082132.25476-1-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Use rtc_month_days instead of oversimplified local logic.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
---
 cmd/date.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/date.c b/cmd/date.c
index d047872289c..158449ef0fc 100644
--- a/cmd/date.c
+++ b/cmd/date.c
@@ -167,12 +167,12 @@ int mk_date (const char *datestr, struct rtc_time *tmp)
 		/* fall thru */
 	case 12:		/* MMDDhhmmCCYY	*/
 		if (cnvrt2 (datestr+0, &val) ||
-		    val > 12) {
+		    val > 12 || val < 1) {
 			break;
 		}
 		tmp->tm_mon  = val;
 		if (cnvrt2 (datestr+2, &val) ||
-		    val > ((tmp->tm_mon==2) ? 29 : 31)) {
+		    val > rtc_month_days(tmp->tm_mon - 1, tmp->tm_year)) {
 			break;
 		}
 		tmp->tm_mday = val;
-- 
2.34.1

