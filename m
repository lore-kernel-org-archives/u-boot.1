Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDEBC54FD2
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 10:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2B4840720;
	Thu, 30 Jul 2026 10:57:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0-R2fia07XjK; Thu, 30 Jul 2026 10:57:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36CC1408B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785409025;
	bh=u+Wq4j1sla+6LvPde2UM1wpX06ongwLhV4urO9Dmb2c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kZiuZp2oInKbvStihOcGCp3N7FEmx4vpRI38OGjEzKieJ/1vzyGknU0P+dTqp6W7m
	 U8MIodHfcbA95wSQQNQzdRo56GDnWs+m/5LAeyvlAbZQs+zfKyOeHTiq2hAFPW3Tse
	 RDBSDVFRktCrxYdE/pjta3uo5QyeFo+Jd09j+uCM3VlKkHfAnDUBIeEscYHM5o3t0k
	 iaowIIK0ypTZLjF8koAuAk8Hrimt/cywDtvFo1Y3URBcYP6xB3TXXVyC5AWT/P8+RV
	 +D82AfmsHUXV0ke5fcczJIXTNBDGfgYl4TSfvk92KBNholrQOyoVpsqRkpuvoD/ZvP
	 b8Kuc7jddDePA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36CC1408B6;
	Thu, 30 Jul 2026 10:57:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ABCA336E
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 10:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D8DB408B6
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 10:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CMdrIqdRV1zY for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 10:57:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.104;
 helo=mail-244104.protonmail.ch; envelope-from=rv@rasmusvillemoes.dk;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 78F7040720
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78F7040720
Received: from mail-244104.protonmail.ch (mail-244104.protonmail.ch
 [109.224.244.104])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78F7040720
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 10:57:02 +0000 (UTC)
X-Pm-Submission-Id: 4h9mLs1lWRz2Sd57
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 1/2] cyclic: get rid of cyclic_get_list() helper
Date: Thu, 30 Jul 2026 12:55:14 +0200
Message-ID: <20260730105515.421677-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; 
 s=protonmail; t=1785408918; x=1785668118;
 bh=u+Wq4j1sla+6LvPde2UM1wpX06ongwLhV4urO9Dmb2c=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=UyNaTrSYw4owS7IlCQ7KmoTGLwgzWqbp08wR/OdeTqJ3/NKdFhyZ5pMrt5Z8wmqdh
 QQY9+eQLoRM0aqEDxv2X6pNYlXfv2288gPuHFOm0QqNO+ANEYKp3MMo1g1wAFoA8Sp
 nfiNXU12aX1KuhovgAq1GlZ/7mPwsJphGCKTPv5c5FopgjS4yiGiSmcRkkT8UejgqC
 uVmUuUOk3kzmGYs87+1mkyUCwMoXiuAhEVp0omgnmxZzVGyJRZ+EF/CJPLNe9S3gno
 C6ETz/qrum+F0a/S+iVL1BwL0Tri0MhrzmM+bNLGOrYs/rD2AJPT770iUlV3MSnv7x
 TzR+jHDUHmJPw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=UyNaTrSY
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

As the comment indicates, this was used to silence a warning without
having to add casts everywhere gd->cyclic_list was referenced. But
nowadays gd is not volatile qualified, so this helper is not needed
and only obfuscates the code somewhat, because the head of the list
being operated on with the hlist_ or list_ macros is usually not
obtained via a function call.

Remove the helper and refer to the list head using the idiomatic
&gd->cyclic_list.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 cmd/cyclic.c     |  5 ++++-
 common/cyclic.c  | 14 ++++----------
 include/cyclic.h |  9 ---------
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/cmd/cyclic.c b/cmd/cyclic.c
index 339dd4a7bce..880cd648aae 100644
--- a/cmd/cyclic.c
+++ b/cmd/cyclic.c
@@ -16,6 +16,9 @@
 #include <vsprintf.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 struct cyclic_demo_info {
 	struct cyclic_info cyclic;
@@ -64,7 +67,7 @@ static int do_cyclic_list(struct cmd_tbl *cmdtp, int flag, int argc,
 	struct hlist_node *tmp;
 	u64 cnt, freq;
 
-	hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
+	hlist_for_each_entry_safe(cyclic, tmp, &gd->cyclic_list, list) {
 		cnt = cyclic->run_cnt * 1000000ULL * 100ULL;
 		freq = lldiv(cnt, timer_get_us() - cyclic->start_time_us);
 		printf("function: %s, cpu-time: %lld us, frequency: %lld.%02d times/s\n",
diff --git a/common/cyclic.c b/common/cyclic.c
index 573e715587d..2bc3c773f27 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -22,17 +22,11 @@ DECLARE_GLOBAL_DATA_PTR;
 
 void hw_watchdog_reset(void);
 
-struct hlist_head *cyclic_get_list(void)
-{
-	/* Silence "discards 'volatile' qualifier" warning. */
-	return (struct hlist_head *)&gd->cyclic_list;
-}
-
 static bool cyclic_is_registered(const struct cyclic_info *cyclic)
 {
 	const struct cyclic_info *c;
 
-	hlist_for_each_entry(c, cyclic_get_list(), list) {
+	hlist_for_each_entry(c, &gd->cyclic_list, list) {
 		if (c == cyclic)
 			return true;
 	}
@@ -52,7 +46,7 @@ void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
 	cyclic->name = name;
 	cyclic->delay_us = delay_us;
 	cyclic->start_time_us = get_timer_us(0);
-	hlist_add_head(&cyclic->list, cyclic_get_list());
+	hlist_add_head(&cyclic->list, &gd->cyclic_list);
 }
 
 void cyclic_unregister(struct cyclic_info *cyclic)
@@ -75,7 +69,7 @@ static void cyclic_run(void)
 
 	gd->flags |= GD_FLG_CYCLIC_RUNNING;
 	now = get_timer_us(0);
-	hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
+	hlist_for_each_entry_safe(cyclic, tmp, &gd->cyclic_list, list) {
 		/*
 		 * Check if this cyclic function needs to get called, e.g.
 		 * do not call the cyclic func too often
@@ -129,7 +123,7 @@ int cyclic_unregister_all(void)
 	struct cyclic_info *cyclic;
 	struct hlist_node *tmp;
 
-	hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list)
+	hlist_for_each_entry_safe(cyclic, tmp, &gd->cyclic_list, list)
 		cyclic_unregister(cyclic);
 
 	return 0;
diff --git a/include/cyclic.h b/include/cyclic.h
index df8b725e3d0..ec2c53b6ecf 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -78,15 +78,6 @@ void cyclic_unregister(struct cyclic_info *cyclic);
  */
 int cyclic_unregister_all(void);
 
-/**
- * cyclic_get_list() - Get cyclic list pointer
- *
- * Return the cyclic list pointer
- *
- * @return: pointer to cyclic_list
- */
-struct hlist_head *cyclic_get_list(void);
-
 #else
 
 static inline void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
-- 
2.55.0

