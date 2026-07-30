Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF30C54FDF
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 10:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6B3480F5C;
	Thu, 30 Jul 2026 10:55:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5YTMz6-mE8eU; Thu, 30 Jul 2026 10:55:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE55B80F46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785408950;
	bh=P6rTnNNW3VC2yedx/9g6HwbqWkZju1T1HfsBeBxd2UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eevn8EYuWkGKExFmV66db9tIYoYdWtz4K5UmQkgAkYo9dLQmwlwMORpkof3gqWZU9
	 LQZ5xZnEc2MjmM+Fyab8uQ7inMbHXteT0ELCIAtXqJW0C47ANViRUKWLwqSnLeyZQ1
	 GEwPvkpgX5LCi7pbmMdv4+G03elb50rTubQWXnK++oX+OQFGY4eQDx0Q5/iesEX4fW
	 I9KYlNUynJO1Jlq0kr7C2+UtpULQL+HMi2onkgzYP8Miz4Ite0lmZ+Z5AB4xT4pukR
	 RPMGM3HiKKTUK3wGpvImfDJGSZs7pOz1qFfm4WMcmoHku8ihFIK13TBlQakmjWxD3O
	 k2qalL2Ap0CQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE55B80F46;
	Thu, 30 Jul 2026 10:55:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AF75F26E
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 10:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0CC980F35
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 10:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-3N5YyqwIUI for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 10:55:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.27;
 helo=mail-4327.protonmail.ch; envelope-from=rv@rasmusvillemoes.dk;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 81F0080EC6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81F0080EC6
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81F0080EC6
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 10:55:45 +0000 (UTC)
X-Pm-Submission-Id: 4h9mLv670fz1DF4s
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 2/2] cyclic: return early from cyclic_run() if the list is
 empty
Date: Thu, 30 Jul 2026 12:55:15 +0200
Message-ID: <20260730105515.421677-2-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730105515.421677-1-rv@rasmusvillemoes.dk>
References: <20260730105515.421677-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; 
 s=protonmail; t=1785408921; x=1785668121;
 bh=P6rTnNNW3VC2yedx/9g6HwbqWkZju1T1HfsBeBxd2UY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=QpszT5VVb2cf80Z2U9YEb6US9QZgGWqrN9/vnyhLeE/eP8hrpZJ150hbOy/kzemnO
 5ukrc16D7lXNSvZJhTCxX/dt4G8ZwOkyA1BO3xvjCvKnp/oW8rIviSfqTG05XXhg/A
 eEW5Vt7lu1XE3FcRb1nnhTDbxs7QeimiAtWVIrWlJhC8LaaYTsWxsNBTvt0t7O0ydt
 gDMfnxxihmvPyFNc7thoYcDa6Q/phho6vp2RB1MthnKJ05KxD1gzqPeaTFDzchozVO
 T0u6msLz5y824qheDwYUuN+FZoY4qmehCqBHzboVHgwwcgAeJrv/aM7su8M5D9rVD0
 mpKCR/0K6Nt9A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=QpszT5VV
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

It is possible that schedule(), and hence cyclic_run(), gets called
very early, perhaps even from assembly code. With commit
9c1b13b3fd2 ("cyclic: reduce get_timer_us() calls inside
hlist_for_each_entry_safe()"), there is now an unconditional
get_timer_us(0) done outside the loop, and depending on the platform,
the timer infrastructure may not be set up yet. In at least one case,
that has caused a divide-by-0 and hence a failure to boot.

Platforms should really ensure their timers are ready ASAP, and in the
concrete case reported, that was indeed possible to fix that
way. However, it doesn't hurt to also insert an early return here, and
that could prevent other such hard-to-debug boot failures.

Reported-by: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Link: https://marc.info/?l=u-boot&m=178481834846283&w=2
Fixes: 9c1b13b3fd2 ("cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 common/cyclic.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/cyclic.c b/common/cyclic.c
index 2bc3c773f27..232143171ab 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -63,6 +63,19 @@ static void cyclic_run(void)
 	struct hlist_node *tmp;
 	u64 now, after, cpu_time;
 
+	/*
+	 * Nothing to do if the list is empty. Also, schedule() can be
+	 * called before timer infrastructure is ready, in which case
+	 * calling get_timer_us() before the (empty) loop could cause
+	 * a divide-by-0 or otherwise crash the system. No clients
+	 * should be registered before the timer infrastructure is up,
+	 * so the check for the list being empty should be
+	 * ok. Otherwise, we would need a new GD_FLG_TIMERS_READY
+	 * flag.
+	 */
+	if (hlist_empty(&gd->cyclic_list))
+		 return;
+
 	/* Prevent recursion */
 	if (gd->flags & GD_FLG_CYCLIC_RUNNING)
 		return;
-- 
2.55.0

