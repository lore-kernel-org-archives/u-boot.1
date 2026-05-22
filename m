Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DEBCD5BB3
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 15:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA7E8487F;
	Fri, 22 May 2026 17:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AHZhiCsF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 973DB847EF; Fri, 22 May 2026 17:39:50 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2988584859
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 17:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=MHpyzTWoERtiglTl3/36v96euYpQb8RRDGKC2hKkl1s=; b=AHZhiCsFzHCzUqETgvP0iYni6k
 bqkRfr3cAezbTbPJaR8J9CmLvgRSpyZo1l4MdP9TAQ4laeggNsuS8ggXC6lO2GgtCMa8bxF1oa1Hc
 fNcyH4knwQi8Cve7RQ2ON8nbNRsAaL2aDZ7ycYhuVzgfnIUnK6A5irOief7y3ejc5YeVOQBsiKnVv
 H0yAJt7+WtNVLq0J6hMN1RTXSMt8jPcc5Aan/MjwGzzdNlnkinZkt1AcGRj74IKOFootWBCRygK2U
 97UuXY0P+fUmjAKWqdWyoLXwgPNoIoSS+E/EAuE0/zCtG1DPD0Bp9GH3KTq4ff7QjInzuQuFnWSz5
 BfOFbx8w==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyS-000OLo-31; Fri, 22 May 2026 17:39:44 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyR-0002ma-2S; Fri, 22 May 2026 17:39:44 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH v3 2/9] cmd: date: validate date using rtc_month_days()
Date: Fri, 22 May 2026 17:39:22 +0200
Message-Id: <20260522153929.2472552-3-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522153929.2472552-1-Alexander.Feilke@ew.tq-group.com>
References: <20260522153929.2472552-1-Alexander.Feilke@ew.tq-group.com>
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

The old check accepted day 0 as well as Feb 29th in non-leap years.
With this change, both day and month 0 are rejected, and the local day
limit logic is now handled by rtc_month_days(), which correctly accounts
for month length and leap years.

In the 'MMDDhhmm' format case, tm_year is not initialized by mk_date().
The leap-year calculation in rtc_month_days() therefore depends on the
value provided by the caller, which do_date() does, via dm_rtc_get().
This is pre-existing behaviour, but is now made more explicit.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 cmd/date.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/cmd/date.c b/cmd/date.c
index f7ecdac7dd3..67cfaed0d48 100644
--- a/cmd/date.c
+++ b/cmd/date.c
@@ -167,12 +167,13 @@ static int mk_date(const char *datestr, struct rtc_time *tmp)
 		/* fall thru */
 	case 12:		/* MMDDhhmmCCYY	*/
 		if (cnvrt2 (datestr+0, &val) ||
-		    val > 12) {
+		    val > 12 || val < 1) {
 			break;
 		}
 		tmp->tm_mon  = val;
-		if (cnvrt2 (datestr+2, &val) ||
-		    val > ((tmp->tm_mon==2) ? 29 : 31)) {
+		if (cnvrt2(datestr + 2, &val) ||
+		    val < 1 ||
+		    val > rtc_month_days(tmp->tm_mon - 1, tmp->tm_year)) {
 			break;
 		}
 		tmp->tm_mday = val;
-- 
2.34.1

