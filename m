Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F26D26296
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 20:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F1982A9E;
	Tue, 20 Jan 2026 21:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sxucX904";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1255483A6A; Tue, 20 Jan 2026 21:13:36 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDFFA839E2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 21:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45c7a6de470so3699173b6e.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 12:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768940012; x=1769544812; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJm6KcR8DoAex7Va5LEc4K0jzzZM1VO5Vb5RsFfMsd4=;
 b=sxucX904nDk98sFcUtmzKPvdUVL7slzP/az3aPlMocTKqGxH0uj5288du8L8/FnUI3
 RXH0YYQ0FhnA73zvOvZGnvqeUz0w6/1i3vWWy3Sov50w2tMrAb8u473+cCqw0t6x6tD+
 witxwJQo0li/ekCP/zDVv4ROI9TrxHOBCuHrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768940012; x=1769544812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fJm6KcR8DoAex7Va5LEc4K0jzzZM1VO5Vb5RsFfMsd4=;
 b=sFMh3ADIHw/TwJvskqQhykKhrWRAdYm38rIXvBwgLlRdrhM0Yo4XWKa+9UWbPM7W0M
 p6VhDnXk51XgbF4LljOhMMYFlF+V9/uVbrmOm2BaGNI42fbBSt+e5AxUUnzNx2Em+D3c
 ZyuOr2djrOyZbjYoB7T11Vqp0V6rY9wyjJtGNRblCFFyvMmSg9yVZdrGKlhGYApk8dks
 oVI0oS5+FYwKHFuLGKx1o2+7LfD6Z6rxeHDyhXNslK4+zecsR+kkZpir95+f63baH6rx
 l5XN2CsiJFCZCjJbizqarDBgo3gCvYgj/BMcPcfmz1M5i65Lj79QRdYblSqCJJ1UyKXg
 +NCQ==
X-Gm-Message-State: AOJu0Yzo7FhomaQHplvWM70MwCgfhJnLZxy37wGC9lyUNcDvTyeDXaT6
 cCoip9/3vUFYjeFKJI0EAhqzlVtY2QbHNGztME9gJtNPW/Fi4fpY/gzE85i0kNDeaSmorK1zzDW
 QLsrzO1M=
X-Gm-Gg: AY/fxX5cQ+qNKneXhD6UcCSTqQjJLNkZ4zTkiFRMD8VnwuQ7m27f/tD5YbBTnjXnXlI
 OLPj6vMhTFIpVkrpnz4//3YrvXwlff2+u+/nBSe6nevsXvD8chxZnh8gAk8Z6g0boZr31wZoQnr
 FFKyHyIeGliA/4UTQnxec/RdZPXCZpHpig+H7bQwIRbYsf+iqHxrdmJJXA0t35NMj/MjRssAHGl
 j+bv1aeA07i37bw+10AGRdpIDiZM3HPQLusCHDSs4g8pWihQs1E7U5ylzDKfs83QbSPbdPwg9Th
 6cNyo5qujZSTxrW1jNywGUhnALEXi48N9Y+sWg7uYKQNfpL4Q5nTmIFA3Wr9S66yFIZmdKBYqpu
 VN0h4m58srjDUXvjtk0SU5ew2P06HPOueXO4xGteVMTLFxGidlcMr5gf1tnbiowuFZPymGY2sBK
 mcF2Z7Grp2ccDQDAdpV4nMv4wQxEe7rMExsXnqQ1ku5WEbEGHto3jhyNrNSVEi42N744T4eS7nz
 85S/ItYpuHE8GsS8IffavnPvqEtNbvLvHffM0pE4FE2oUhaU2FF
X-Received: by 2002:a05:6808:10d6:b0:450:3c49:519 with SMTP id
 5614622812f47-45e8a8f79d6mr1548920b6e.7.1768940011695; 
 Tue, 20 Jan 2026 12:13:31 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9dec6619sm7417337b6e.3.2026.01.20.12.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 12:13:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 2/3] doc: develop: process: Rework the custodian feedback
 section
Date: Tue, 20 Jan 2026 14:11:44 -0600
Message-ID: <20260120201327.451872-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120201327.451872-1-trini@konsulko.com>
References: <20260116182335.4081828-1-trini@konsulko.com>
 <20260120201327.451872-1-trini@konsulko.com>
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

Now that we have two items here, rework this slightly to be using bullet
points, and so easier to expand on.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- Add Quentin's RB, correct a minor existing thinko
Changes in v2:
- New patch.
---
 doc/develop/process.rst | 43 +++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 81e1aa7e34db..4159a945707e 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -132,27 +132,28 @@ It is their responsibility to pick up patches from the mailing list
 that fall into their responsibility, and to process these.
 
 A very important responsibility of each custodian is to provide
-feedback to the submitter of a patch about what is going on: if the
-patch was accepted, or if it was rejected (which exact list of
-reasons), if it needs to be reworked (with respective review
-comments). Even a "I have no time now, will look into it later"
-message is better than nothing. Also, if there are remarks to a
-patch, these should leave no doubt if they were just comments and the
-patch will be accepted anyway, or if the patch should be
-reworked/resubmitted, or if it was rejected. However, if a submitter
-feels it has been too long since posting their patch and not received
-any feedback, it is OK to follow-up and ask.
-
-Another form of feedback is about applying the patch itself to the
-source tree.  The custodian is expected to put in a "best effort" if a
-patch does not apply cleanly, but can be made to apply still. It is up
-to the custodian to decide how recent of a commit the patch must be
-against. It is acceptable to request patches against the last officially
-released version of U-Boot or newer. Of course a custodian can also
-accept patches against older code. It can be difficult to find the
-correct balance between putting too much work on the custodian or too
-much work on an individual submitting a patch when something does not
-apply cleanly.
+feedback to the submitter of a patch about what is going on:
+
+  * If the patch was accepted, or if it was rejected (with exact list
+    of reasons), if it needs to be reworked (with respective review
+    comments). Even a "I have no time now, will look into it later"
+    message is better than nothing. Also, if there are remarks to a
+    patch, these should leave no doubt if they were just comments and
+    the patch will be accepted anyway, or if the patch should be
+    reworked/resubmitted, or if it was rejected. However, if a submitter
+    feels it has been too long since posting their patch and not
+    received any feedback, it is OK to follow-up and ask.
+
+  * If the patch itself can still be applied to the tree. The custodian
+    is expected to put in a "best effort" if a patch does not apply
+    cleanly, but can be made to apply still. It is up to the custodian
+    to decide how recent of a commit the patch must be against. It is
+    acceptable to request patches against the last officially released
+    version of U-Boot or newer. Of course a custodian can also accept
+    patches against older code. It can be difficult to find the correct
+    balance between putting too much work on the custodian or too much
+    work on an individual submitting a patch when something does not
+    apply cleanly.
 
 Review Process, Git Tags
 ------------------------
-- 
2.43.0

