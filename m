Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43076C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 15:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A066D84B55;
	Fri, 10 Jul 2026 17:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KxJyl+Hv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2958484B70; Fri, 10 Jul 2026 17:21:41 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 204E384B2B
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-81e6f2ee60bso24873557b3.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783696898; x=1784301698; darn=lists.denx.de;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BzbZg3CSbStF+3H7rB1GiefixLZTL3+r0G7rVfIlgWc=;
 b=KxJyl+Hv5tRWs1gUe28WFOUfm+ILwkW/cwsLk5JEaHasgRo32/4zpywHNuvIce+zck
 adYHfprcMfwTDoln3VBhoafpbuGfyHcV2cJ40w/i5xwgMSgzlCC+Z4u2TTNHld7+Mrzq
 2cA+Zzunge0PK3R/9JFFijBRQjQrIsi9e/QGfAUihE+m1WHXrK9ZojgdZYvRQzsMoymh
 zqrNQbgOt23UGW2xsR8WhhIsr1lKOHodWtLqY+ppTYHRkFm2zc4T++MkXTXB2wltsTxt
 CHDP9ws6VqCvJ5CgxxHxozGKlBzEDpy/rOHJYcU978020RVetYOcH+BcXmE7HsDFRmrO
 vBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783696898; x=1784301698;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BzbZg3CSbStF+3H7rB1GiefixLZTL3+r0G7rVfIlgWc=;
 b=pHX/YvcjIDeLVjcMm8ooKRyxDOMlcYMCvz/dHI9qo81e6Q3Z8ukjjgV99K/cpFTp4n
 Gf14/4G7c75ioOZvEPXu9cKkZ0WOAVeN6fOuwU6wjOhjyK5jaCYd7x5SKMylcXgV1E/3
 S9nfAJ+m81QEZu7m6AUvh1HNSbH7KAUStJTgxd29aWNKGEehZrysm2BG0ulB4OqgG2TD
 2V0OEai6kO3uOjnfumoD3Dw0oTY1VolFO5AZuWINjYr3I6g2+YSe6UW4LpS0EOjWbFUU
 z8kplcjYwKIrkJoJexATMrYYM5a2ZCHmQ26kI0B38U/OZc09WRYy70i+UQ4R4qMaHsiI
 ZyFw==
X-Gm-Message-State: AOJu0YwMbj0POLGsjfNwXivGWhQ4i3GKFE9/MBPw5N20NVYVjVAW/P/2
 LO/PDP9a42+hY+pIZmnEfyi5TZWgvV6+abbQHiiisK39ekdjlxJjzMr1
X-Gm-Gg: AfdE7cmjj/Os5muf2XqAcyAEb9s1zD+SeCTwbfdP/XGQFtOKrlfd5qrLE+tMEek9Lhv
 FjM0N6JNo2RXYjz8KOfInXgUDlGhoVLjU1JJCiLCMNpmCID0H0XmIg6mp75PULgtc1o+3Ol0vDo
 0liVRt9tu/34I/Tnft7aJhKTdEOggksm178FzWdyMkNLzbrU6QODN97xyGNB9+6tLVWhn2Qd85L
 jmTP1dgEVbNM3jNB0u8QqqiqDWR5R7G2NJnKTHiS4NAizXURyqGdju+/fHPVGSTpteL9RlwkZQX
 aJfSPUwOBtlbpe4qspvYZQPCm3wscvS76iFEL2IvJybQ/mcC2KTo6ukcYFqzggkOk1bLb/nUT5a
 GfLolIvJddHnN2OKH89OuJH8AVLZlXh8x7TI31tTtpMo9/3b+sda2tfh1jELRwWwzeyvOuSitG7
 nLt9+k9CKJYg==
X-Received: by 2002:a05:690c:c4c1:b0:81c:2a00:aa42 with SMTP id
 00721157ae682-81e7c013db9mr30113757b3.20.1783696897873; 
 Fri, 10 Jul 2026 08:21:37 -0700 (PDT)
Received: from localhost ([49.36.187.33]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-81e6c245d12sm47617307b3.48.2026.07.10.08.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:21:37 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:51:33 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: jerome.forissier@arm.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: lwip: wget: free mbedtls x509 cert context to avoid
 memory leak
Message-ID: <pqy43tgj6qomfmqneq7e7xl6ifopleolqtmiduhwlo4yt3dufo@pwzqjjjdajdn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

_set_cacert() calls mbedtls_x509_crt_init(&crt) followed by
mbedtls_x509_crt_parse(), which allocates internal storage (parsed
cert fields, chain links, raw buffers) inside the crt object. The
function then returns on both the error and success paths without
calling mbedtls_x509_crt_free(&crt), so all of that internal state
is leaked when the stack-allocated crt goes out of scope. Every
invocation of "wget cacert ..." leaks memory.

Free the cert object on both return paths.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 cmd/lwip/wget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cmd/lwip/wget.c b/cmd/lwip/wget.c
index 4883ad61bce..531e886e986 100644
--- a/cmd/lwip/wget.c
+++ b/cmd/lwip/wget.c
@@ -67,12 +67,15 @@ static int _set_cacert(const void *addr, size_t sz)
 	if (ret) {
 		if (!wget_info->silent)
 			printf("Could not parse certificates (%d)\n", ret);
+		mbedtls_x509_crt_free(&crt);
 		free(cacert);
 		cacert = NULL;
 		cacert_size = 0;
 		return CMD_RET_FAILURE;
 	}
 
+	mbedtls_x509_crt_free(&crt);
+
 #if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
 	cacert_initialized = true;
 #endif
-- 
2.43.0

