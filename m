Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36635C49EA1
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 12:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9C088C75;
	Sat,  3 Aug 2024 14:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="W/mwk8OU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E684688C45; Sat,  3 Aug 2024 14:42:11 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C3788C45
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 14:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c82d=PD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722688923; bh=Xa0KPkiVKU7XnvF56zL2tBOqweC6dQjLSUdJv+MVaYk=;
 b=W/mwk8OUzrTujN/z8jaEzInELIllckd9VsP6fgiTV4VBABBWUhI72iwoTOmFJD0ngYWiu+JSk
 4gQitq/uXOzGvQ0mhzVBrMPJifp18+nY2Pa1v6NJCiIVeJBvC6unUGnvd8cDxeJ/D+XBRUqkduC
 7UBKBDfXY8WFmHiKl0lYkn7COs6A0D6uZ3SfCr5YFma0djfmo8NMfSH2YoMevn3xFK/AjN6RlBG
 LpHUq9jZ2tVlB8yOnVWJH294jNBcQrEzN3lcXGgdvlWBCVTLPlBAVUlVQqyPqnt7oL+zEpn423/
 dq7O+8m2zKUrRnPpcGSmrEigYHuU3q6MFDyxpppdlY6w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] bootstage: Do not sort records
Date: Sat,  3 Aug 2024 12:41:45 +0000
Message-ID: <20240803124149.2916030-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803124149.2916030-1-jonas@kwiboo.se>
References: <20240803124149.2916030-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ae2597c2f14e5c6aed0279
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

The timer counter on Rockchip SoCs may be reset in TF-A, this may cause
the bootstage records to be printed out of order and with an incorrect
elapsed time.

Fix this by not sorting the bootstage records.

Before on a Radxa ZERO 3W (RK3566) board:

  => bootstage report
  Timer summary in microseconds (12 records):
         Mark    Elapsed  Stage
            0          0  reset
        7,436      7,436  board_init_f
      164,826    157,390  SPL
      375,392    210,566  end phase
      423,909     48,517  board_init_r
      472,973     49,064  eth_common_init
      476,848      3,875  main_loop
      477,003        155  cli_loop

  Accumulated time:
                   7,181  of_live
                  14,739  dm_spl
                  15,029  dm_r
                 315,150  dm_f

With this the records can be printed in chronological order when the
counter is reset and SPL and board_init_r records show correct elapsed
time.

  => bootstage report
  Timer summary in microseconds (12 records):
         Mark    Elapsed  Stage
            0          0  reset
      164,437    164,437  SPL
      375,023    210,586  end phase
        7,437      7,437  board_init_f
      424,390    416,953  board_init_r
      473,515     49,125  eth_common_init
      477,402      3,887  main_loop
      477,571        169  cli_loop

  Accumulated time:
                  14,734  dm_spl
                 315,646  dm_f
                   7,339  of_live
                  14,977  dm_r

For the tested board external TPL and BROM take ~164 ms to initialize
DRAM and load SPL, SPL take ~210ms to load images from FIT and U-Boot
proper take ~477ms to reach cli prompt.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 common/bootstage.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/common/bootstage.c b/common/bootstage.c
index 49acc9078a6d..80168e965b12 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -249,6 +249,8 @@ static uint32_t print_time_record(struct bootstage_record *rec, uint32_t prev)
 		printf("%11s", "");
 		print_grouped_ull(rec->time_us, BOOTSTAGE_DIGITS);
 	} else {
+		if (prev > rec->time_us)
+			prev = 0;
 		print_grouped_ull(rec->time_us, BOOTSTAGE_DIGITS);
 		print_grouped_ull(rec->time_us - prev, BOOTSTAGE_DIGITS);
 	}
@@ -257,13 +259,6 @@ static uint32_t print_time_record(struct bootstage_record *rec, uint32_t prev)
 	return rec->time_us;
 }
 
-static int h_compare_record(const void *r1, const void *r2)
-{
-	const struct bootstage_record *rec1 = r1, *rec2 = r2;
-
-	return rec1->time_us > rec2->time_us ? 1 : -1;
-}
-
 #ifdef CONFIG_OF_LIBFDT
 /**
  * Add all bootstage timings to a device tree.
@@ -342,9 +337,6 @@ void bootstage_report(void)
 
 	prev = print_time_record(rec, 0);
 
-	/* Sort records by increasing time */
-	qsort(data->record, data->rec_count, sizeof(*rec), h_compare_record);
-
 	for (i = 1, rec++; i < data->rec_count; i++, rec++) {
 		if (rec->id && !rec->start_us)
 			prev = print_time_record(rec, prev);
-- 
2.45.2

