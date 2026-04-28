Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E948EFF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA5F5846B9;
	Tue, 28 Apr 2026 20:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="c0H5UT06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8679E846A2; Tue, 28 Apr 2026 20:14:53 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8088884679
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 443D33F7DC
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777400091;
 bh=F2A0P7cQ0cFNbj5Q4TdfH6Avz0l72NXGndTs+LO9wFE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=c0H5UT06S3tb+KJu8tS0eIO/0glcnrirxKWNRA5sb0wsfJvzZUbX7iKo+Zj2UaXay
 hagS7jkkJu0TQXZUV0vBEOJHevm+twFBpp8uH0caC9otLVaMFXwavgRO/ugtwJDku1
 ZRnfnrgbMp8SlHWRACHbJwhHMK1yfn0hnLtk4YB62l2un4wLDhokZTd79asLqJb8T6
 EdjSX0oaQbu+DH139NarAFhcQ3d0pbzgAhF5vf0jLITqnK5PkXWL64l4tQS2Sh97CP
 BgDg6ZbcBmrbs/xWUIWEQ3l44CzTlfujd/mRm+nWg2Tc+7dGHhRKKh4kdh7cIjDaIT
 GIPxllNRab4XMdu1LWyULmc3qdIYo7BD4R14yeOq+kLJW1rZFbmOYuWYG9JZlimGHl
 FGsNRof/sqm98w9k0hk7zANngMxKZDmg5LjnUD/UJhpeQAECmevOl655Qim3Q1zEhw
 l370UQPpJoc7AkNlSQzxUR0+Fg1wDMQWhsXk4cxSTT1+/ndf/SxW7/fVUUtRRguhko
 1+kJ8hIFYaZdeYSTZk53YUxYhZcVKpoIqGkZSfSEiIjzEp1iv9YnMJ/r3hCUfUyQYN
 Zw9yvlSvPBm+5BzhmLpqVZelUpM79YrWEC3rJwdjOEg+rQzNGfLx+pIJeQeuE1p52m
 mS7HYcfnKWhHLOZZoJheAWuE=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d7d03e1e7so9430420f8f.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400091; x=1778004891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F2A0P7cQ0cFNbj5Q4TdfH6Avz0l72NXGndTs+LO9wFE=;
 b=DMHFUD8pKdDi0VG9yUSJoFYVoNmRtzaX4hVktTsQ5FZVTpoGmKVBhCbRLGO5cVx092
 5JMeuiiFSAOo8lFjqELgpto/VMTyFH2fXxImt7+Mk0yy8uE0gfHSJNwisqKXmfBaPeib
 V2qn5ARksojySHORPSWB56ohAmUyqmzTYG0mijZ82yMDAMjxY1Snhipo/9mORefAO1MC
 5Yf5rCbER8gQsXkALtvQ/E8fJLQb+q5PAzQ6ZA+1NQzjm2Aa53jL8oiiX/kQbU6D6Jxe
 WO85sKSIyi82oB8g8SIwXghEDiq6oRNLqrCQzhfIIj8L2QpBo6TVlF5Y69LFQ9ZJ4iXZ
 9lRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/oh7yG1+qiewz49QiUbP0BW1qqZYpm1sriIqXuk+egvb86UZbaKSrydW/QBK/ns5w4+MdC2qI=@lists.denx.de
X-Gm-Message-State: AOJu0YxFROpkCNi7RAxxt2orBsEeox2SDm//Z0xr2IN/GTr5as0/qLmx
 FKfKOgulvEygELl8PaqwSvnCa0iGDIXpxieZPZZH1CGqFgl5S6J2xWGcqkxQwLvRCieKsWk//mf
 JS4zA12nKcYFKk2E04QlYFwq7pD9UGmi7MTUhJ0J3A9vmNzugxvR5tdA7e4V9+C9FNXGeZ2s=
X-Gm-Gg: AeBDiet3JpvEJHI411bSdXvCeMclkZ3z2aGbkWfolsPEe7d/ZqGDHE3qsgqyEEHFQbz
 yrThwFVRxtLUGisz6vF9tPFbL7uzoblA3gbxBEMpHvLjmVxZaGSPXaVSR+THD/zu6t3++hVAr0o
 I5AiwZ/xe0UvqRGkI5xqSnnhWF1HVm40dz2why5iJWCWgHJ5+P+2S7Q6qcmYdYYJYJcyKzMGrvh
 /ovKA8sQmVrcn/K6hlxYCtPk8zXDQ1ANnZODpIHSw54/yqAO2sOPteYtEdrODgSvZFgzKBF0s/a
 LFMsVvz8mBWRHhF0s+qFYx0mvwZNwfvZehRZ+QFncmeCqAYj0iEBWcrC8FXRI41KgFo0d+KfkPa
 Y8rmQYYH7k4q5v6e0j0rKfpaADGDf3cAY2tKTV9wUes/1Ws/bi7hzEoL59wss/JEizJCmuCmlVD
 qESP1Pbw9SYEGGAEMZAtCIqwtcHlQaL8221V2+faj5u+zSgE7sBDKwbRWUYCJv
X-Received: by 2002:a05:6000:26cb:b0:43f:de5a:eb63 with SMTP id
 ffacd0b85a97d-4478ea89a58mr804033f8f.11.1777400090786; 
 Tue, 28 Apr 2026 11:14:50 -0700 (PDT)
X-Received: by 2002:a05:6000:26cb:b0:43f:de5a:eb63 with SMTP id
 ffacd0b85a97d-4478ea89a58mr803974f8f.11.1777400090289; 
 Tue, 28 Apr 2026 11:14:50 -0700 (PDT)
Received: from workstation5 (ip-176-199-115-125.um44.pools.vodafone-ip.de.
 [176.199.115.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d02f35csm9551802f8f.11.2026.04.28.11.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 11:14:49 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] net: lwip/wget: don't print progress bar when silent
Date: Tue, 28 Apr 2026 20:14:34 +0200
Message-ID: <20260428181434.179888-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428181434.179888-1-heinrich.schuchardt@canonical.com>
References: <20260428181434.179888-1-heinrich.schuchardt@canonical.com>
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

When the EFI sub-system request to silence output, do not output a progress
bar.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 net/lwip/wget.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 983abe2ccd3..e7d302b7541 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -177,6 +177,9 @@ static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
 	ctx->daddr += len;
 	ctx->size += len;
 
+	if (wget_info->silent)
+		return 0;
+
 	pos = clamp(ctx->size, 0UL, ctx->content_len);
 
 	while (ctx->hash_count < pos * 50 / ctx->content_len) {
@@ -239,9 +242,11 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	}
 
 	/* Print hash marks for the last packet received */
-	while (ctx->hash_count < 49) {
-		putc('#');
-		ctx->hash_count++;
+	if (!wget_info->silent) {
+		while (ctx->hash_count < 49) {
+			putc('#');
+			ctx->hash_count++;
+		}
 	}
 
 	elapsed = get_timer(ctx->start_time);
-- 
2.53.0

