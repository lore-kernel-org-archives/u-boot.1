Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6377ECD5BB3
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 15:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9419984875;
	Fri, 22 May 2026 17:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Cag2dB6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F41878486D; Fri, 22 May 2026 17:39:46 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 162FD847EF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 17:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=BNveE9MuGmAQmBJ80FMor1Z/uhDwAKNNFg6lIsWqsDw=; b=Cag2dB6Cb4ZKeYvoKwZpy4bKE8
 8G2ZabjOn/RwtiH1VKv1tquBdmVZ3PT7me5W9LDdy4DFKl41T1papyGJBRDL7qesovofWiPRrEFlR
 r/vvTVkhFyCsk8IJlWlSd0R1wqoxTMTmWwkMbT0u6H8ZtFGfY5TjnOlbgr0P5ivWg9JeZUJc8yvpV
 YhmFlYTTvuy5GCAms8rsJ7INOo4Eb055pkb0qZSUnP8RVYgOj07dMRHAidQHnCAQmNb4qbBCDpjNA
 t2Fi+wA1PH4DyqWzhv5SiaykhRljggG8F09P+163KbYXDEdmUahhg/dVIjOFgeHTmEFO4MrfpOh5a
 eQBEg/2Q==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyS-000OLh-22; Fri, 22 May 2026 17:39:44 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyR-0002ma-1X; Fri, 22 May 2026 17:39:44 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/9] cmd_date: make mk_date() static
Date: Fri, 22 May 2026 17:39:21 +0200
Message-Id: <20260522153929.2472552-2-Alexander.Feilke@ew.tq-group.com>
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Use static as this function is not used externally.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 cmd/date.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/date.c b/cmd/date.c
index d047872289c..f7ecdac7dd3 100644
--- a/cmd/date.c
+++ b/cmd/date.c
@@ -16,7 +16,7 @@ static const char * const weekdays[] = {
 	"Sun", "Mon", "Tues", "Wednes", "Thurs", "Fri", "Satur",
 };
 
-int mk_date (const char *, struct rtc_time *);
+static int mk_date(const char *, struct rtc_time *);
 
 static struct rtc_time default_tm = { 0, 0, 0, 1, 1, 2000, 6, 0, 0 };
 
@@ -117,7 +117,7 @@ static int cnvrt2 (const char *str, int *valp)
  * Some basic checking for valid values is done, but this will not catch
  * all possible error conditions.
  */
-int mk_date (const char *datestr, struct rtc_time *tmp)
+static int mk_date(const char *datestr, struct rtc_time *tmp)
 {
 	int len, val;
 	char *ptr;
-- 
2.34.1

