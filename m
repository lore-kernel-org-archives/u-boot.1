Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7189C982F0
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F75838A5;
	Fri, 16 Jan 2026 19:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mVBrPx0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0AF68397D; Fri, 16 Jan 2026 19:23:44 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A2508394E
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7cfd6e0173cso1204316a34.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768587821; x=1769192621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VwrrCcD8CGyOU2jbup2kD7o0JYi0mnkCisvpE1T/2w=;
 b=mVBrPx0/kU4DZKVvdVJJzi9xxy1441s4Khz8e2WUv/yhbmY7c7J3BJl44hHq1iAYwi
 BhEiH0kHtIRvpwRB+S6kn83eAaz6Imh71tpHNs0YlUybkOJk1StRCYdOycpYINZhYVeE
 cxNKIREAWPYiejbYbuCRZWuexR/p6nYMh8bi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768587821; x=1769192621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/VwrrCcD8CGyOU2jbup2kD7o0JYi0mnkCisvpE1T/2w=;
 b=JG0hhiDRm95/QdIoqV0P/PZ1OfAZ4r/EX1oMxajwyYiqfj4uCboGuasybFV6e696tc
 ABChS6KLo+XMAQ/2Uan4a4qwlJwQZHjLnqKO1VMXddH+Cs0hfrXhNQqMow51c7bxmU/l
 vGarPzeou88TRsKScYA7epq5kvj4XUQqmaXVZGbtoXEN43l7FXBkCrasy96FBbuknjKE
 gtFZ6UhFIBhS2Hu/IF8odRpL+I4fKyczUvgHm3STpOqMaN0a381L76Jj8uslprZPIQ3+
 CJcO0k6u6IN/2w+chZ/9P2D4a8x08a1KIi7C8N0n0RtXi8ua6WgG76AhRCznfEA77z/e
 ZCCQ==
X-Gm-Message-State: AOJu0Yy3WofzsIg1+3neUA6hUUEfxIn0bjlUmuM5TzNaKxTmV4uRX+6E
 0LMDKrGv18C7fub6MERZyqmb5xClbOnm2DSAaTxl+YH2Y5VyyDHqaPsyqvtlBGskf9mIB5nhtv8
 24Gqnb/0=
X-Gm-Gg: AY/fxX6o+gOMv2DwzLQXHTJP/ubbnxEiSdSHVKHYGjzmwlU4IrzbnzAcubaL4arMjk0
 At8MWlSYqOI8/T1fDCy/faGCr+bCLas7CkeiClUSsB/D5T79iUhM9ymvegNzdg6Ol0XegNi6a/6
 qFDWYsmuy6EgNBzq/FzRu4Wj/DOypdccBIOnLTONbz2nYyX6NbxGs1kz9NtYYj+ELt7oTMNrsRT
 9LX0V9D5eKGC4Y2TSYKgcviYgOY8QX5PZBvRHTXE+wz8WLYOEJKW21LvTS4lmvVguRg+A7QJnMn
 GqOdTpawsZ8u2hAcTnZYxrcKLE6wXRdP4HkRodBpM+lUHFNzgZYzdNlEXaIeKX/p//j7iyjylOf
 XK/Q2YvQIdNO08RPhktPaDVXJ31JrYoAebB5VfaX1hq0hmEUZoQsuiNLr9CDZQ0iZ79pJp4iesi
 8Y5SN1F+aCD6bKUzgMOu4mjt2pPxLpJaBId4G9QSTg7ZJ+R43VCOddwM7uJPXeCkqsZS62/ClAF
 G0KC+Fl4BEnMkSirvd8R/5YvZ/y3McLhopYMOUvbDhsm2rlmww9
X-Received: by 2002:a05:6830:3113:b0:7c5:3c7d:7e67 with SMTP id
 46e09a7af769-7cfdee8f7bbmr1641344a34.29.1768587820856; 
 Fri, 16 Jan 2026 10:23:40 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf28ef44sm2152994a34.18.2026.01.16.10.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:23:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 2/3] doc: develop: process: Rework the custodian feedback
 section
Date: Fri, 16 Jan 2026 12:16:49 -0600
Message-ID: <20260116182335.4081828-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116182335.4081828-1-trini@konsulko.com>
References: <20260116182335.4081828-1-trini@konsulko.com>
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
---
Changes in v2:
- New patch.
---
 doc/develop/process.rst | 43 +++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 81e1aa7e34db..6f5bdd3db957 100644
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
+  * If the patch was accepted, or if it was rejected (which exact list
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

