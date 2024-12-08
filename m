Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79839E7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 10:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 337D8895C2;
	Sun,  8 Dec 2024 11:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fUU7oL0s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05BDF895A1; Sun,  8 Dec 2024 11:52:55 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0806B89589
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 11:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f804233so4160927a12.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 02:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733655172; x=1734259972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAmvCUSXW6aB30F7BDwm6ua6DD8so9h99thLaEi5j+U=;
 b=fUU7oL0sz9UBeYYfL/ebLK4avQvYKGBH/WVzDTfS+Sb9Incp7mN9cfVWnECLSny/Fn
 yAlZZwo96LwWwcR707QYVQjlRmazrBPosYActwUyk4p/BKdY7lMi21jRpb4lvK2yCu+e
 BCE5uZKlChflM5rcCfByZsDu/Vgofwcra/s1iEKBM/AbkNHadhnd0Bg/qfVWp7JJnrMq
 sTcl2kNZ4yHaUOOwJ9z941yyFGZg1+qTXrw0YzNL4zarkxHDICCcC522JrCmVEdfjqtL
 JiYyctp88pX/mNzFD61D31yixGfoM2oBq/jcg1jwDlIaprPQZ+JoiqavD8kPBoPtL4co
 3Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733655172; x=1734259972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pAmvCUSXW6aB30F7BDwm6ua6DD8so9h99thLaEi5j+U=;
 b=MhfU9JVzu/xpuHEYU2xvzkhy8Bw6g9UCcCw/LGHNa6Qzm8wG/WovFZ2CA4cW44NQR3
 8abGSZH5Xoxw6LqwSqV+uMQWSEsmL4Nck7GZUDCEkKokK/jVi1FXFe13M6Qn1PF7NVil
 8hz3EN1xnetkmDmV9CVKbYQFvLwYUSCfD8XrHTRaejnUf+qkVzBM5UPdDBIOab05gbUZ
 TVp5rPlet0GAV6idr00A8o6VhmiyjUbyA5CuuRv+SZwF/dErgfksT2d8HUeUQD6+PbJQ
 Y8vPlXH0Q86w7KzT0oXLXryF8NgLv/CDc/+eZ42mpZw9jLpVIPA/JQMZRo9u4yan0qLJ
 aKoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpMIABAb1ClciX2jLzc12SnDlfrMan7GXa9bkvAlKd562nABthyeG9gI4tvpm8YJsKmmIodak=@lists.denx.de
X-Gm-Message-State: AOJu0Yza2PcArNDhhy/nkR5L/x3JoS5ZvVHXU+PN3x3yh7FJQQokuugl
 6q/TVYyZc8BLNEW09s0sYOVoDU4DikEBNFYCQ5FF+S703PsCKpe5FFkpuSvLQa4=
X-Gm-Gg: ASbGncsqmxynAlz/1c0RYypM37vtreilSH6quTRr7W20xiCHRJPI1Dt1xtHO8Y1igFg
 HPpPNx8pLddk7C9zekVlMcmgpFwIG1nUZ+BH4NS/y4Lht6O3Bj7QHWoUSKaJDq+j10WmxRkmuqh
 DQcQMFY5ZcdSyacwI47E1tFaHiHGiLg/ePy1Qvj8CG5r7tvsjsbeTpoEA1UUFgkwod6KWLkNKO5
 +NOB2jvLtHaavDOcFiIdsaunhZ3d5kqIMDT/yxZviXQhCWOjrm0f0N/1KY+xUHgZOcfwa2t7oEg
 UUyR3aGfvxDT6QXwdbtfJfXVxQg=
X-Google-Smtp-Source: AGHT+IHzq9ZZIWxsfzhvVtTML00W6kAEswYKMXqXEikVcLtXk6j5xc27ZLTm/QiHYGHbJb7wDb20jw==
X-Received: by 2002:a17:906:3d21:b0:aa5:44a8:9ae7 with SMTP id
 a640c23a62f3a-aa63a20ecb6mr886366466b.47.1733655172489; 
 Sun, 08 Dec 2024 02:52:52 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e92fe3sm517768566b.51.2024.12.08.02.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 02:52:52 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [RFC PATCH 4/7] lmb: Remove lmb_add_region()
Date: Sun,  8 Dec 2024 12:52:07 +0200
Message-ID: <20241208105223.2821049-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
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

There's no point defining a function that's called only once just to
avoid passing the flags. Remove the wrapper and just call
lmb_add_region_flags().

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/lmb.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index ffdd23d87b9b..56e005308dde 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -640,19 +640,13 @@ void lmb_add_memory(void)
 	}
 }
 
-static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
-			   phys_size_t size)
-{
-	return lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
-}
-
 /* This routine may be called with relocation disabled. */
 long lmb_add(phys_addr_t base, phys_size_t size)
 {
 	long ret;
 	struct alist *lmb_rgn_lst = &lmb.available_mem;
 
-	ret = lmb_add_region(lmb_rgn_lst, base, size);
+	ret = lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
 	if (ret)
 		return ret;
 
-- 
2.45.2

