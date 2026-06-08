Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04AACD6E79
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 17:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC80E84869;
	Mon,  8 Jun 2026 19:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tZOQj3+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D09F184825; Mon,  8 Jun 2026 19:14:25 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70E584701
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 19:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bebc80100efso494236566b.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 10:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780938863; x=1781543663; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gIfGrIbAqkgABY984kv9woqByKrMboyswIJ+XT4hFFo=;
 b=tZOQj3+zZh31maTntAkbnK7gvqjJqVTlFqyDpj/QmjeLFxaGvXP91uQSEz14v0rZfH
 J2UL57DBNTUNgCrakrFIVPWlL/Gpwa5rjE8XnkmSf9ZOi8ifFLJjURDyTkTk382boJ0i
 FxxRwPgvryVJF7xJ57qkbUEtqSM3wKk6AnQKlBs+y4orjgTMnGY0DnEihN5vYVbFi0aD
 SNfGfmDNllzq2mlOoX9RcnEOEv5VDZQDVe5dN4snvSba+SWHH14NBTguG532u82sf9nu
 p2JxgpZkPwVgbii69FHS0pKC+mR4urJNCXvvz8ZWTPm4gb+dyYx5vFtaC08dOp9TkdjK
 Nh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938863; x=1781543663;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gIfGrIbAqkgABY984kv9woqByKrMboyswIJ+XT4hFFo=;
 b=N9KMwaUN4wpKBRiKTFfaYCqaOWxawdbrX9DzTdpCfVwNtMF2zZmh0wvyyTl0gorZ0T
 WhoXrILIdhJbdJm/f8ErQYPSfUr5JAVOW80PQqOpFKeJa0Lf1FZqyNpRakFN9m9YeH3i
 hytG7SFzl80uSGCq1XdmvW1ayUmrzGVrbkqqanKVI4yLqLV1ycwDQyOsPYqiOaWo2jN2
 DKk1RGEnpWxHREbgN3+DDWwiFAmZWvdPqcGc9hNd5Zh07O8Ss7LwZ4H6ca6xL/Q7cMzv
 AmqGjIQhr/LXLYgv6JyHeqdku4gGHeKav4pDdRPQsrSjfQZ97zlmuN411K13h43yEDKH
 GW/g==
X-Gm-Message-State: AOJu0YzZsaKfMqTu0jf5t+jmIRfp1/NwmBsPCQBa+urK4OqD05TaVfRW
 ha4hzpFoX58nUURF6G/jDq8gmxHiP1RKOhLQPkTlUFVTB4Gv1djJSC+ryTqR/pi2aCQ=
X-Gm-Gg: Acq92OEFWQ4FNpzyPYBY5LQ/PKNc6Hrn1ILGHpKFlxJS3SsE8CbZBYgOibobCgwgjP4
 SWxRxhn1mmCxvRs8SC2FLqFlDnQOjXJlHX+Jc6TCnYPe6r21LUOVMOgLm54RNyBKOvEV3WsUckT
 IN2i8blkECeQrUjiGZGS5T+4xRPM4crVDBbQ0FKphHxGDngB0kzzfFdg9yorbfaf9c9oyekco8Q
 ef42NeGv1+xXTvD1OJdIZy7X6JiFvT2RRglUuoEBk5cKJ2FIV454LUr3wRXoV6Psb8JoWzjPwC4
 FsThZPEwyM3rJs6UfRQRmivIfdr8IdG8Zn/HyrR6AJd+/+gUKbvTlZwD6BV5C6+xTh5b40fww0z
 T3eBerZneklcaAjytsF7mdUH7eCElsXY6V4xfSk93e9sGDwTZYcJaQ5/Bc3geiMnGrRNwjLDrmB
 XKZr5H61wv10JyMnHbJ8sfhCm+YU5PGjOKe9ovQBrWvRQlCm5q0ukCkYN3xg3WHnzaeH68uu3Mt
 jri
X-Received: by 2002:a17:907:2673:b0:bee:1e36:8772 with SMTP id
 a640c23a62f3a-bf370e5be57mr568963166b.20.1780938863219; 
 Mon, 08 Jun 2026 10:14:23 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559f4144sm893898766b.58.2026.06.08.10.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 10:14:22 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 08 Jun 2026 19:13:49 +0200
Subject: [PATCH v6 2/4] armv8: mmu: teach the pagetable dumper to show
 explicit FAULT maps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-b4-mmu-unmap-fixes-v6-2-ac0764cccf40@linaro.org>
References: <20260608-b4-mmu-unmap-fixes-v6-0-ac0764cccf40@linaro.org>
In-Reply-To: <20260608-b4-mmu-unmap-fixes-v6-0-ac0764cccf40@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=aQNBsjfh5AtNMjqeCKHVuDAH6/y4NcVJAjurfYmvEKg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhiy1H9kiRhr/2JzD65+/2JHyZcXknje60UJsjCuL5A7M5
 uHMP6LUUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACYywYThn1VJ1t+dbDb3+8of
 zp/xTU11TizjxDlPJ9+4f0LPVCqpL5SRYXFHeH4F+xvnxUeX8Ham7Duq/ejW47lWy/62TZ/xLOu
 wwnsA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

When a region is explicitly unmapped (like with
mmu_change_region_attr(.... PTE_TYPE_FAULT)) the address translation
still remains but won't be used since the region is marked invalid.
Print these regions when we dump the pagetable to help with debugging.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index f07204ed2fad..91c55591a1d9 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -533,9 +533,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
 
 		if (exit)
 			return;
 
-		if (pte_type(&pte) == PTE_TYPE_FAULT)
+		if (!pte)
 			continue;
 
 		attrs = pte & ALL_ATTRS;
 		/* If we're currently inside a block or set of pages */
@@ -572,9 +572,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
 
 			/* Go down a level */
 			__pagetable_walk(_addr, tcr, level + 1, cb, priv);
 			state[level] = WALKER_STATE_START;
-		} else if (pte_type(&pte) == PTE_TYPE_BLOCK || pte_type(&pte) == PTE_TYPE_PAGE) {
+		} else {
 			/* We foud a block or page, start walking */
 			entry_start = pte;
 			state[level] = WALKER_STATE_REGION;
 		}

-- 
2.53.0

