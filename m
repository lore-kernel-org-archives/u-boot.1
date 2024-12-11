Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B716FE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 10:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB4BF801FD;
	Wed, 11 Dec 2024 11:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qxul41gv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FAD8801BF; Wed, 11 Dec 2024 11:55:15 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979DD801FD
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 11:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa6332dde13so938675266b.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 02:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733914513; x=1734519313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6KbavC+z5tRgNXbT1IqE6TtPJsFqKJYWnG08OKayQ4=;
 b=qxul41gv/9Zoh98m0w0cCc7dG37ZQtv2cEc6ZB23MDf++U93Ip18mrKT53QRNwlkFo
 Y25mKe+GvwKS9/5eajvlIrW4AeM9sKutPHTeuunxUcPMMfDDDq5dmV/rca3YnO9FlJsU
 /bnQLjTntF1A+o2K0pEK0TV71dBSPSnbWfMQPKGKeun9W6Jgi6tt2PRiqNioghsksobt
 5PdbG04gcFKAJB2coQHTFuA806W+95GHUF1knTEk+xUYaw+9N5VVvRxdMorHLNRYtrYY
 xkeIbiUtYDdDAmZn47GYOgPSBii8X3yfdbqiV3ddoljw+XRXAxFXRyjKzLBH37a0r90H
 eyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733914513; x=1734519313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6KbavC+z5tRgNXbT1IqE6TtPJsFqKJYWnG08OKayQ4=;
 b=Ly0DqGIVSCdo8TN5ljcjkE/e9YvyCGKlxqVS0B42dTJV5bX8Ho0CFRsgKVl3809722
 FqR+fTg6zx47Q0t0BZivlRLBpFKZBkwei8P6S9lzESJqDemOAy2z5F3FDuyPLqSqNtdV
 YAlnLIXEB0Z1MEHg2q1mfwnGeZBtmyU1onyPqUBTX4vnCTdz2TvWabt0vvXE7TBTlR5R
 9wxHOTUq/KEcTMHewsEfXOof3YSc67aZkT5KXvHBzFpxBzHFxEcuNXFqTYxICVuu+uMM
 CUs7W81NZkNuSbGu7bkClpIJGMNqlYk/x51W0cykid3jcfo24LKHaWJBBJsbgayfiTTl
 mamQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoAbqGQJHjPnXNtOY+yRDzOs5q2yxyCTdeFT7m1r7gN0WsxBtNbDQ/TQ7UaHhfCVK4BeF99Go=@lists.denx.de
X-Gm-Message-State: AOJu0YxKX39mqQVQ5quuzKDCAUMvuJUQYj+1S6XtTdoj7Ra2Pids+czf
 aqbzX8Dy0ReunkMWmi5UmWguMfJAtv3WDLTyAtq//TxpJDtH51+khgT5ZD9r2uw=
X-Gm-Gg: ASbGncvpC9gBW9xygYnWFV2aVi5ai4K1WD7LxzWn3+SH6Pu2bYAUmEGXtINQAc6KHru
 DzUVFIZsEwpn7GJa+aWyiQALgyrt1kmfOSHQcbnl+oTmqxgV6ojQeI4fsvG0iMajw3t0NDJjLC0
 2nW0oQCcDu/JEoLjoJDBqMplx9KBTZQXHfrGT9OU/74gNG7o6NRsQCjhD8FdIHgBzYdrRltjHJl
 YpgxT6wmeRWjcQC1XOxDs9ja8xDPSlwplinUFqQLboC1nx9ihBRZwJ2ZzL/jU8Y3422c6+QDlhS
 MBSHrgSD4O18KQ9jX4IRxeo4YJqcjgw=
X-Google-Smtp-Source: AGHT+IH/JDTpOGQNjpi23H6NxtzZ6O7hcbmVvmY6vaZtYNUaeS7B6/LdqgvjZj81m6HJ0vMHoBtvOg==
X-Received: by 2002:a17:906:314e:b0:aa6:9eac:4b7f with SMTP id
 a640c23a62f3a-aa6b11418aemr229775066b.7.1733914513071; 
 Wed, 11 Dec 2024 02:55:13 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67e652b1dsm508006566b.172.2024.12.11.02.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 02:55:12 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v1 1/8] lmb: Remove lmb_align_down()
Date: Wed, 11 Dec 2024 12:54:42 +0200
Message-ID: <20241211105504.453234-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
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

We already have a macro for this. Use it instead of adding yet another
variant for alignment.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/lmb.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index f9880a8dc62b..b9c26cb02e10 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -342,11 +342,6 @@ static long lmb_overlaps_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 	return (i < lmb_rgn_lst->count) ? i : -1;
 }
 
-static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
-{
-	return addr & ~(size - 1);
-}
-
 /*
  * IOVA LMB memory maps using lmb pointers instead of the global LMB memory map.
  */
@@ -400,7 +395,7 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align)
 
 		if (lmbsize < size)
 			continue;
-		base = lmb_align_down(lmbbase + lmbsize - size, align);
+		base = ALIGN_DOWN(lmbbase + lmbsize - size, align);
 
 		while (base && lmbbase <= base) {
 			rgn = lmb_overlaps_region(&io_lmb->used_mem, base, size);
@@ -416,7 +411,7 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align)
 			res_base = lmb_used[rgn].base;
 			if (res_base < size)
 				break;
-			base = lmb_align_down(res_base - size, align);
+			base = ALIGN_DOWN(res_base - size, align);
 		}
 	}
 	return 0;
@@ -709,13 +704,13 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 			continue;
 
 		if (max_addr == LMB_ALLOC_ANYWHERE) {
-			base = lmb_align_down(lmbbase + lmbsize - size, align);
+			base = ALIGN_DOWN(lmbbase + lmbsize - size, align);
 		} else if (lmbbase < max_addr) {
 			base = lmbbase + lmbsize;
 			if (base < lmbbase)
 				base = -1;
 			base = min(base, max_addr);
-			base = lmb_align_down(base - size, align);
+			base = ALIGN_DOWN(base - size, align);
 		} else {
 			continue;
 		}
@@ -740,7 +735,7 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 			res_base = lmb_used[rgn].base;
 			if (res_base < size)
 				break;
-			base = lmb_align_down(res_base - size, align);
+			base = ALIGN_DOWN(res_base - size, align);
 		}
 	}
 	return 0;
-- 
2.45.2

