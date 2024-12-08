Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9920E7717D
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 00:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8455F8946E;
	Sun,  8 Dec 2024 01:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yV1n2JLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5836893E0; Sun,  8 Dec 2024 01:21:29 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F182D893D4
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 01:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71d4e043dd9so848991a34.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 16:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733617286; x=1734222086; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LP7WRT98dGj39h1CiHCmB/n2Zg81Ci8i+gupvmN8tSc=;
 b=yV1n2JLa1pckJTc0FG9GsWfOJ98rTNyQ/UDgwOvPadgbrUYiPrnY7Q7BQmeh8RyHiM
 m2CGp2+E4uF9qnULWHMo5MMkpzAmX8ZaaZmHZ7jk+rcWK6yK++fjXx/ZYLgnYutnxuCO
 Oksy3XyXVBOx1N+qZeCw95TvyDPzf4L7es24G8RK0cdSiq+oos4lvOkwnHojctyl3T6k
 sRkhZ3G0mRiPejCEyU3fCNYG0XCKN7/rBsAFAUjeaIkuHwrjlccgEurYcpzN7xgnBSKS
 gpJf52Z/a8UsuS5ky1KvTJttfFfnjsm1ORYvR/XWMgwCx70awWiuIe4O6ybxUB7ZizDD
 8oMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733617286; x=1734222086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LP7WRT98dGj39h1CiHCmB/n2Zg81Ci8i+gupvmN8tSc=;
 b=sOjV6oXUd01lEeO9uYmWnbo0pAIaXXXKJtbjDPIoFFe8ffjn9IKDMn5wSvpVR09oqH
 ntC7pYXavQwW0ZgGlHxDJQ1Zr7eJ8UNyEyYPg5oevdKq2cKu9qYHSjn6Yy02NCpE6DVH
 bGMv6R6RX4aHvdSAtJCmjwJ9ZvbyK1SUZRoTQyHmsR9gD+9iwTVPnDsdbyO8wgfG1vIs
 io25lpm5L9HawABL3grInxGrRdC/nkOkmGVoYdev5DfXBN0EK6zsK5+TmeRpW83ieWC0
 5uaNUcYbzjpaSCzX6IgQoxa9zuqzvhUu1pWQQljGzM+KocW44qY0fEKcgaf6Vk95y9Z2
 8Uow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb88Ocs1rykeWcJXpPFcMTQF6gd2G1458p1635G8MrO9R+PzwwgA/1PG3Q/34Cmmr6Rm5M1NU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0hCAl4ipnrKmUiaIyjLlGG2jMA3Np4PXbV+EtpWxDic9Le3H2
 dUiP7M2qptVhmQ1Kz43+e+v20b94jXA1Q+X91J23HaM2paqmFaMq+LHUXpK+qtw2jjB0zWZ+rf/
 7D0w=
X-Gm-Gg: ASbGnctTyeOcf0tR6MVL6Go5UIm+cY0kJMWnQqpMoNkK1i/ll3z0/xaD4lk0ZOTiE39
 hmn1K9fdDQXl8Sj11rC5hIm1M/4XJ5j75+s6/8lNcLJQGQqZGLOe/72wTGGcWggeyenxawwAOGb
 /iAPoy7Bp3g5v0jPfJcMrCvBFNu1IkG7oX9s5EwRDntpMQUQ9UfPNnP6SRq31OSRPX7wBSNLCU+
 nsKUVxuFaH/RlijXFuy2FaNCy7VhNz4ApxE7P6PkY+aKNnbxpGxYj0=
X-Google-Smtp-Source: AGHT+IFagsnLUDT/GXsWdOJkAgvUJI7fbFduSM/w3WXdjzfrv+6GQgaj0FrwWvo4EvRzzwTOqmZARw==
X-Received: by 2002:a05:6830:25c4:b0:718:1cb6:e593 with SMTP id
 46e09a7af769-71dcf5530damr3981015a34.27.1733617285725; 
 Sat, 07 Dec 2024 16:21:25 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc4951cfdsm1541454a34.28.2024.12.07.16.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 16:21:25 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH 2/6] lmb: Return -EEXIST in lmb_add_region_flags() if region
 already added
Date: Sat,  7 Dec 2024 18:21:17 -0600
Message-Id: <20241208002121.31887-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208002121.31887-1-semen.protsenko@linaro.org>
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
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

An attempt to add the already added LMB region (with exactly the same
start address, size and flags) using lmb_add_region_flags() ends up in
lmb_addrs_overlap() check, which eventually leads to either returning 0
if 'flags' is LMB_NONE, or -1 otherwise. It makes it impossible for the
user of this function to catch the case when the region is already added
and differentiate it from regular errors. That in turn may lead to
incorrect error handling in the caller code, like reporting misleading
errors or interrupting the normal code path where it could be treated as
the normal case. An example is boot_fdt_reserve_region() function, which
might be called twice (e.g. during board startup in initr_lmb(), and
then during 'booti' command booting the OS), thus trying to reserve
exactly the same memory regions described in device tree twice, which
produces an error message on second call.

Implement the detection of cases when the already added region is trying
to be added again, and return -EEXIST error code in case the region
exists and it's not LMB_NONE; for LMB_NONE return 0, to conform to unit
tests (specifically test_alloc_addr() in test/lib/lmb.c) and the
preferred behavior described in commit 1d9aa4a283da ("lmb: Fix the
allocation of overlapping memory areas with !LMB_NONE"). The change of
lmb_add_region_flags() return values is described in the table below:

    Return case                        Pre-1d9   1d9    New
    -----------------------------------------------------------
    Added successfully                    0      0      0
    Failed to add                         -1     -1     -1
    Already added, flags == LMB_NONE      0      0      0
    Already added, flags != LMB_NONE      0      -1     -EEXIST

Rework all affected functions and their documentation. Also fix the
corresponding unit test which checks reserving the same region with the
same flags to account for the changed return value.

No functional change is intended (by this patch itself).

Fixes: 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory areas with !LMB_NONE")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 lib/lmb.c      | 18 ++++++++++++++----
 test/lib/lmb.c |  2 +-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 713f072f75ee..ce0dc49345fb 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -183,8 +183,10 @@ static long lmb_resize_regions(struct alist *lmb_rgn_lst,
  * the function might resize an already existing region or coalesce two
  * adjacent regions.
  *
- *
- * Returns: 0 if the region addition successful, -1 on failure
+ * Return:
+ * * %0		- Added successfully, or it's already added (only if LMB_NONE)
+ * * %-EEXIST	- The region is already added, and flags != LMB_NONE
+ * * %-1	- Failure
  */
 static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 				 phys_size_t size, enum lmb_flags flags)
@@ -202,6 +204,14 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 		phys_size_t rgnsize = rgn[i].size;
 		enum lmb_flags rgnflags = rgn[i].flags;
 
+		/* Already have this region, so we're done */
+		if (base == rgnbase && size == rgnsize && flags == rgnflags) {
+			if (flags == LMB_NONE)
+				return 0;
+			else
+				return -EEXIST;
+		}
+
 		ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
 		if (ret > 0) {
 			if (flags != rgnflags)
@@ -667,7 +677,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
  *
  * Free up a region of memory.
  *
- * Return: 0 if successful, -1 on failure
+ * Return: 0 if successful, negative error code on failure
  */
 long lmb_free_flags(phys_addr_t base, phys_size_t size,
 		    uint flags)
@@ -818,7 +828,7 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
 				      lmb_memory[rgn].size,
 				      base + size - 1, 1)) {
 			/* ok, reserve the memory */
-			if (lmb_reserve_flags(base, size, flags) >= 0)
+			if (!lmb_reserve_flags(base, size, flags))
 				return base;
 		}
 	}
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 0bd29e2a4fe7..48c3c966f8f2 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -754,7 +754,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 
 	/* reserve again, same flag */
 	ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
-	ut_asserteq(ret, -1L);
+	ut_asserteq(ret, -EEXIST);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
-- 
2.39.5

