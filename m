Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AE110F995A
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7BD283D8A;
	Wed,  8 Apr 2026 18:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NrOPoWNZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F17A38407E; Wed,  8 Apr 2026 16:04:31 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 004198407E
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 16:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8D5613F665
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1775657069;
 bh=xvEdXS101iGPdq8D/tueyGV9esPvRRU3a73RwdsCb5Y=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=NrOPoWNZ+yAZmBCNzN+H+A0/g7wGUsCrn6H4PSGtfE5PpwMl7JaAslPm978kzWQlD
 GMc43aaWEC0o4/rwG0znsSNdL/Mdzod419TIGbFkwDSWRKqvQiRuGMSCxkO4lEQXgx
 osef+X68AXUsbrpKM9/oO8cBPL/x/p2ULHsLEK+j7vvHfeR9aKAVeYnrrsbjVb62in
 riiCAJ6BId4/xqOckvJJl1ecynWG6K7oJcEabix+kO3QeUeREIURl8rcs2KftLWkiU
 gtt7hTLBfi1LuhGQkcG6KCBWAw9nzWkYZpGEnzb1Q5CHMjrBbjQFSIqeaUIvgIgJvx
 qpuVKw+7Rc6/jWL82Vonve0r4BzmMOpCpggo6pdbN/5jA5k5R/ZlBBb+osRtNEY0iI
 RMWMta348gtQcyXyxsc0rliaEmdt0cuM+qckgDKfLVFMiA0H2hBTppqqwSjrZ1A9v/
 dPtUX0xrh3jYcx+UKULygyc9NzEBkllNDbNiW7mTf2iKz+HgziCK8+LgZamYTNdqSN
 piHjjkAcjBnvjdNYS4kzOWyDPz5uTj01Js/UkGY9yUWs/SltnZBIPPxybpchk6sbwm
 1X//nUCedDxHt34jiOT0AwfP/G70FmjmO/cxIg+lND92j16m5tw03RSdCuIBmYs3La
 ku6uHv61Q3WNplTk1go3nZxM=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b0c30b51bfso131743505ad.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 07:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775657067; x=1776261867;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvEdXS101iGPdq8D/tueyGV9esPvRRU3a73RwdsCb5Y=;
 b=UuZO7sUt90DAYLCYGVBv9bLlyNG/ewgkm1Y3g3L8tL21s+Fu+cJ4VWccUhhfgWgGff
 SqZukA9fwqTpBfK16fLYwp+FkWm0bY5QjPo3X2YIux4RvNBJCxOKakSYFtVc0RW6VWjF
 uXhUui2BfAhn0d0yUqhpq5BeqnGC1XzHRQOOCFWbWa+hcQ84K7J20ZsKkSeYjp0dcClH
 PzzvfOVQxSAN6wpGw5DXWxr6cEpT6QEffoYjprvWUm/SCFG6nWTMcaM8WpiWRdqnbEn9
 U8qu6hb1ckShe5o7qzpejKyWsEy8JmPLqjir5eWYhJz0RT5rVFVib4MAU5guLRezb/L7
 C1Ig==
X-Gm-Message-State: AOJu0Yx2e0UPlCULP/losBVSO/tc8sOXw/xEHQ+MtblpTUM9zg81sryz
 9ioH0+AFcskR7GcRopMJn/f0g3am2WBsL/tf9TUzQim3Y8dtLPrWddECrYX7rVPZw/ygFiB1DM9
 Z5iJ/tdcb6ijsrjKOi+XXmLeMrRSl86Tg+6WU327xK4payKoUjLaObg0otRYa9CUFwnap105GJd
 WALglqIg==
X-Gm-Gg: AeBDieu6CNYUSWFT85DTYG67ZQJ6WV+oePu5ErjyY4pkGiJx83Rh7PaW9Xm3PZF3TrW
 Hyi94OAa4ZoOc0Lk5oY3ELqP0m+xfp6X61sHPi2axr+k6YtxWY1gIWYlK81aH/lmMe6IFazMprJ
 6+cIcNZtBCUv7GgD0oTlfDnGojFf+hfkWhxXS4JchwAL+s+X4dNlkQUIUSmJKnRvCrd5SsTl6cP
 C33ji/0WjPoGBTNwh/OaEJXQ+OPOS/so4ll/E4RmbQWDMCKnH8PLUKbpHOIHw8Tm67s4EI5p86Q
 oNVuGbYzFJ3+s4ibM1+d+7XPqddeDn/dGgKIVNlDY7ffwc+wfLs+vd9a1n/lZf4Z2RxHlypnlNh
 wM7AMqn4zBtNimrF/AK+zeb+6FoqACBGWT/9LyJFTu0fIF/FI9o2qnFQ8gTGMgMveLSpG3B/C
X-Received: by 2002:a17:903:17cb:b0:2b2:4029:d781 with SMTP id
 d9443c01a7336-2b28175e05amr236727795ad.20.1775657067419; 
 Wed, 08 Apr 2026 07:04:27 -0700 (PDT)
X-Received: by 2002:a17:903:17cb:b0:2b2:4029:d781 with SMTP id
 d9443c01a7336-2b28175e05amr236727415ad.20.1775657067067; 
 Wed, 08 Apr 2026 07:04:27 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749a3af9sm194312545ad.63.2026.04.08.07.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 07:04:26 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/2] lib: hashtable: fix integer overflow in himport_r
Date: Wed,  8 Apr 2026 14:03:35 +0000
Message-ID: <20260408140339.798015-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Apr 2026 18:59:06 +0200
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

When size == SIZE_MAX, the expression malloc(size + 1) wraps to
malloc(0) due to unsigned integer overflow. malloc(0) may return a
non-NULL pointer, causing the subsequent memcpy(data, env, size) to
write SIZE_MAX bytes into a zero-byte allocation.

This is reachable from the U-Boot console via "env import", where size
is taken directly from a user-supplied hex argument.

Add an explicit check for SIZE_MAX before the malloc call and return
EINVAL.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 lib/hashtable.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/hashtable.c b/lib/hashtable.c
index 75c263b5053..902fa6f3e98 100644
--- a/lib/hashtable.c
+++ b/lib/hashtable.c
@@ -820,6 +820,13 @@ int himport_r(struct hsearch_data *htab,
 		return 0;
 	}
 
+	/* Check for potential integer overflow */
+	if (size == SIZE_MAX) {
+		debug("%s: size too large, would overflow\n", __func__);
+		__set_errno(EINVAL);
+		return 0;
+	}
+
 	/* we allocate new space to make sure we can write to the array */
 	if ((data = malloc(size + 1)) == NULL) {
 		debug("himport_r: can't malloc %lu bytes\n", (ulong)size + 1);
-- 
2.43.0

