Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7137E6748D
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 01:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68438838A5;
	Sun, 21 Dec 2025 02:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rpmLF1hQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F275C80325; Sun, 21 Dec 2025 02:59:10 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 020E483642
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 02:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-001-171.46.114.pool.telefonica.de
 [46.114.1.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D9DC5409C3; 
 Sun, 21 Dec 2025 01:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766282348;
 bh=0xgWhgFl6B9sN0/TFUWkNKVhpb75OJ/T7bPJNBCwmso=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rpmLF1hQGA5Vh061KInV4QcDU6j3bl2vofF/lzxewLhvLO91T9lHFdJgGS31FEvRT
 cJB2o0/EPe93wbMPx5lAF88RvfmnN6xOvjoFs84vcfoOWxp87X4uxvgjhc4JIrU1iz
 CpiRRIcz0S76lmc60tckL5DTa/DVy6CrTBaOuiGrPE2QBcl+pDcUSaHKrSP6gm6ZS9
 XKFzgSETzdpd+MmZJLe0CjVMKPTcO49OftfNrZj9LIcAoIbjaHJcdFJ0r6NT3lkkee
 fM8hE3S9TKVBNybssTAef5k4JXnhm5uMtv/K6afliyj2GGt2gZ1UFQ82rAukH73/K2
 j3oQDzqZzZe0VVbsvVRhFvEUJexfiUD7BbWQRJQJCPiTktQsze00PDpPLCONfuO/2v
 gUofzcy0PVABMRSu+m8jfuZlIJegKGw2beLOMIuVo8O+MAhy8xOdrOSdeUJUg5duV1
 KdxwuMSJXn57g63QKvCBzDby9OjcUE071noA4jo5N1Cgys/PRLPYrkxNvtTOyk9oyN
 vYTlIwZxqx2MfQ/w+lcvzRt4vCGKllIdYZMNCWUS5lXO8CURP/TvfL+FbsJsACPt4k
 ZfwA/UqBlMsS2+rUOgTwBliZ4vfM4nDnOAEi9lp0EfutA4Mb5BKayG3eXASGZMpRLj
 jN8XjRlRvigf/haZEWiBFLF0=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 1/8] trace: correct handling of recursive call
Date: Sun, 21 Dec 2025 02:58:52 +0100
Message-ID: <20251221015859.738112-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
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

__cyg_profile_func_enter() adds timer information to function traces.

Commit 852d4dbd70ba ("trace: Detect an infinite loop") introduced a logic
letting any recursive call to __cyg_profile_func_enter() deactivate
tracing.

This implies that a lot of the DM core and timer drivers functions need to
be marked as `notrace`. This in not desirable as those functions are part
of what we want to trace when not invoked by __cyg_profile_func_enter().

A better approach than switching of tracing is to immediately leave
__cyg_profile_func_enter() when reentered.

Reported-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/trace.c | 59 ++++++++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/lib/trace.c b/lib/trace.c
index 3d54dfaddc0..2dea8fc85f2 100644
--- a/lib/trace.c
+++ b/lib/trace.c
@@ -131,32 +131,26 @@ static void notrace add_ftrace(void *func_ptr, void *caller, ulong flags)
  */
 void notrace __cyg_profile_func_enter(void *func_ptr, void *caller)
 {
-	if (trace_enabled) {
-		int func;
-
-		if (hdr->trace_locked) {
-			trace_enabled = 0;
-			puts("trace: recursion detected, disabling\n");
-			hdr->trace_locked = false;
-			return;
-		}
+	int func;
 
-		hdr->trace_locked = true;
-		trace_swap_gd();
-		add_ftrace(func_ptr, caller, FUNCF_ENTRY);
-		func = func_ptr_to_num(func_ptr);
-		if (func < hdr->func_count) {
-			hdr->call_accum[func]++;
-			hdr->call_count++;
-		} else {
-			hdr->untracked_count++;
-		}
-		hdr->depth++;
-		if (hdr->depth > hdr->max_depth)
-			hdr->max_depth = hdr->depth;
-		trace_swap_gd();
-		hdr->trace_locked = false;
+	if (!trace_enabled || hdr->trace_locked)
+		return;
+
+	hdr->trace_locked = true;
+	trace_swap_gd();
+	add_ftrace(func_ptr, caller, FUNCF_ENTRY);
+	func = func_ptr_to_num(func_ptr);
+	if (func < hdr->func_count) {
+		hdr->call_accum[func]++;
+		hdr->call_count++;
+	} else {
+		hdr->untracked_count++;
 	}
+	hdr->depth++;
+	if (hdr->depth > hdr->max_depth)
+		hdr->max_depth = hdr->depth;
+	trace_swap_gd();
+	hdr->trace_locked = false;
 }
 
 /**
@@ -167,14 +161,15 @@ void notrace __cyg_profile_func_enter(void *func_ptr, void *caller)
  */
 void notrace __cyg_profile_func_exit(void *func_ptr, void *caller)
 {
-	if (trace_enabled) {
-		trace_swap_gd();
-		hdr->depth--;
-		add_ftrace(func_ptr, caller, FUNCF_EXIT);
-		if (hdr->depth < hdr->min_depth)
-			hdr->min_depth = hdr->depth;
-		trace_swap_gd();
-	}
+	if (!trace_enabled || hdr->trace_locked)
+		return;
+
+	trace_swap_gd();
+	hdr->depth--;
+	add_ftrace(func_ptr, caller, FUNCF_EXIT);
+	if (hdr->depth < hdr->min_depth)
+		hdr->min_depth = hdr->depth;
+	trace_swap_gd();
 }
 
 /**
-- 
2.51.0

