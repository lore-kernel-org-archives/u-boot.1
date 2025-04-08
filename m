Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84755C369A2
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 13:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D7B4822D7;
	Tue,  8 Apr 2025 15:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K/flyB2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DF8282A96; Tue,  8 Apr 2025 15:54:27 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA5C482169
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 15:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c1818c394so3389435a34.2
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 06:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744120463; x=1744725263; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ubDjyg4IRHwNJ1xq2eXmwnjBuT4Tp8Adq48KKZigS6U=;
 b=K/flyB2shjgN3hURiZyN6yY7BA2jeFy3DeVdbtv2e2aKzAtm2iLdbBfWwjiAoUTLAE
 1ugqJO3L/8Ph3V9CX8KNhTwcjdZ2pU0VXNYP2qzUg7IHrhzWybz7sonxa/Z/UMX8WY3r
 DzbNfb2qthji9P9AQoLAkeJTVGSoVQGULAKE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744120463; x=1744725263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ubDjyg4IRHwNJ1xq2eXmwnjBuT4Tp8Adq48KKZigS6U=;
 b=AoY7i+dQhYOf0/DDkdNE7AFMcQu7rW3Y2p+eFf7QMZD/Y+sEmHxUL+4GWJchgWvkwo
 AgrZJ4MGqmWg+A46BqLZ/qyY5ROUwt/4Il4Pn9sVHM/COz+CnSsf/p+hsL1ssp1heS9Z
 GPIJvyuXD5mNzW0W6doBUciJoZoHq6bJPp8YFjWhjxzl15huMX0TQNPJNga4QbShtmEy
 g5iKGmYzaEYn/IM0ZQEy40Aq1U4jcB5NbpVWGKaPWnPOiDnRxA1sd9ZI8i/pHBVWZHzo
 ObVdHfSX6uUS5nP8lo9oEt1iG/BR9JK2Y2V2XmOYVywuQMKZFcNKOSjK4DWC8MsnXYLH
 Jz1g==
X-Gm-Message-State: AOJu0YyFQuJuZcn85lLjv1LqQkqM0RQIIpDvzLpaxr2pWoZ9dgnVr9Gu
 J52LctfBMNBs4cvOgMlcfaZUMfv2kumVFxePC5NSq7fPceZ10ckI1D2RYiuD+zHdU9/DFgriJPr
 r
X-Gm-Gg: ASbGncvY8ZxcHypx/8Fx1ZoYmAeI348vSPW6mydcB6lBRY7O+WrXaMVpR9/AnEVssB1
 l0T0iZdEjmJ8hTXOeCBjGFmZARGKRo9viKE7+RCg86w2WNUX07ZEu+unqYsUi9CDPck6RLJTGQm
 UpSK8Dl9TzrKs9qoOrzOJP1iPz0HF9nmGRICV+dweMdiqFPRS8lcx4GPnHutNvQ9aUjgpFQWPtp
 pvFm2L3cjI8zuYka32fEx96Vh58Sx/wPcK09E7QykBSFRA0J8+zIy4g+CVulRGqdm1nWTLmpBPt
 nlSwBZ0JUVCBkeddHyFlNYqOtoccpIQLpQx70xB0MdEBkYj+g/Lwbn4DbqSDfKK6befGqt4Z5Fi
 I+tUQ/mmY
X-Google-Smtp-Source: AGHT+IHAGjQsao7tOjOb1EszEo7+6PL4JucwsKQGOpXluDiBoJ0SOLb9bMG//9PgOlXjqBAB55Z2jw==
X-Received: by 2002:a05:6830:d04:b0:72b:a175:2f1d with SMTP id
 46e09a7af769-72e40ecacafmr8023961a34.23.1744120463406; 
 Tue, 08 Apr 2025 06:54:23 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e651a2974sm461745a34.33.2025.04.08.06.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 06:54:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH] doc: release_cycle: Use variable substitution for next version
Date: Tue,  8 Apr 2025 07:54:21 -0600
Message-ID: <20250408135421.1393991-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

To avoid the problem fixed in commit 57a95d522ca8 ("doc: release_cycle:
fix next release version") moving forward, make use of the variable
substitution feature of rST. This adds a next_ver variable and
references it in all of the places where I had been listing the version
being worked on.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/release_cycle.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/doc/develop/release_cycle.rst b/doc/develop/release_cycle.rst
index cbbc2bad0ebd..50948c009272 100644
--- a/doc/develop/release_cycle.rst
+++ b/doc/develop/release_cycle.rst
@@ -1,3 +1,5 @@
+.. |next_ver| replace:: v2025.07
+
 Release Cycle
 =============
 
@@ -53,13 +55,13 @@ Current Status
 
 * U-Boot v2025.04 was released on Monday, 07 April 2025.
 
-* The Merge Window for the next release (v2025.07) is **open** until the -rc1
+* The Merge Window for the next release (|next_ver|) is **open** until the -rc1
   release on Monday, 28 April 2025.
 
 * The next branch is now **closed** until the -rc2 release on Monday, 12 May
   2025.
 
-* Release "v2025.07" is scheduled for Monday, 07 July 2025.
+* Release "|next_ver|" is scheduled for Monday, 07 July 2025.
 
 Future Releases
 ---------------
@@ -69,15 +71,15 @@ Future Releases
 
 .. For the next scheduled release, release candidates were made on::
 
-.. * U-Boot v2025.07-rc1 was released on Mon 21 April 2025.
+.. * U-Boot |next_ver|-rc1 was released on Mon 21 April 2025.
 
-.. * U-Boot v2025.07-rc2 was released on Mon 12 May 2025.
+.. * U-Boot |next_ver|-rc2 was released on Mon 12 May 2025.
 
-.. * U-Boot v2025.07-rc3 was released on Mon 26 May 2025.
+.. * U-Boot |next_ver|-rc3 was released on Mon 26 May 2025.
 
-.. * U-Boot v2025.07-rc4 was released on Mon 09 June 2025.
+.. * U-Boot |next_ver|-rc4 was released on Mon 09 June 2025.
 
-.. * U-Boot v2025.07-rc5 was released on Mon 23 June 2025.
+.. * U-Boot |next_ver|-rc5 was released on Mon 23 June 2025.
 
 Please note that the following dates are planned only and may be deviated from
 as needed.
-- 
2.43.0

