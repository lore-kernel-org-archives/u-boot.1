Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA611E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 07:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A717802D5;
	Wed, 18 Dec 2024 08:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UeRraT5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D20680214; Wed, 18 Dec 2024 08:03:19 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AAFA80243
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso63773045e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 23:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734505397; x=1735110197; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5tM+ThIP7Ggd12PDma8fzMMV0s1w8rhwzRtsjrdIs0=;
 b=UeRraT5X7OZZspyF8N/QkEas9roiZhhVQFgzxmTKXLkg26Fa3TB8hbMdq+NGuiUg2r
 kC3Vt2PBrlagib07Uh56YhqNh+MFDMvLUKs87Pm35goNBNQwH3PpJq1uAJmOT9U/pzWe
 F9403/jHxxShJAZug+yaxAXoBIuGRFvFr271vwfVPxa/WXhFSkwTw4idDNMLU7DY9vek
 zOcvgRXTH64cqygeTOpUjizcAf//vSMoTCOOnuOcuxVPBqZlM5rCtNMB6u8TnqOBXy87
 jQANF9Mbi4uPPlgYzJueg1EAzjBf5jr1XVqLnlGjq9xBu01Ty8sKuOrSQ0DUdn/8rGfw
 tqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734505397; x=1735110197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5tM+ThIP7Ggd12PDma8fzMMV0s1w8rhwzRtsjrdIs0=;
 b=YcKwN7gSWAo1nf2XyA12oClqALOvtK+4Yu9sbXWOScsRyr6yglh4VyhR3RHfbYXXu3
 9ejHvWmgj82SZOeCRGWuJnfQxDiUCrov+WeUyRmHQ7Q96cFpHgJHRPjrmY7FJxMReC/I
 aorlmGoW86jodZ247U+F3U89QjR3efLIxe9ADuWXeG5lt95bRaZIaShksiWRgJUAwzUF
 6xg44rbXdIBVp4FkIsDYSAHqMd9pQ2kfCj+Mjf7lIHvHS7mYg7MLKWablmOwP8c8vxD1
 j2QTAC+QlGaTDcpYOlz1tehGfVDGc/UMf7OSmIH5Vv97gd3XXLTW+8CS+K32YKpwj9WU
 WESA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk/ZdwgmApad2DZrOfBBsyGexnBc2+j1wFkHZJBKiOwJ8XV4AOIlrrzci5FTMSOGUVEr/n8wc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4+KvJVPOpuI6pEWO3m0wtk/PW/iDqIZcesT36wzItJwr5WuH4
 tRHGjX5YSQgANC36CPtRNE1qETaNqcUSexv+y3IIXwBgpEK47shVq0MeBRInQ0M=
X-Gm-Gg: ASbGncv1Q9uiyRtlrZ8sUAclstzs9jyCJNsV2psm2eT/jc9SNnTaCY46KGMwUZog+wz
 BNlS1dGe6twIqww48JRFtazpvNNHvAr01y+UOyGqFkhtGJ5b6HoR/hERpZhtHjw4Eiet0sTFYUW
 bNW1zqSg30fFnqToVVbKc4tWTPHF3UMQySa7L+XEayUOl8ZY3YIl9qyslh8vjVdkcv9duLzW1/t
 zalxLrbEDmhiAcEicXodz2gwnaYgiO+VBg8IYDNMykXGBvC+92WTBTUmGXWm3CtE+lDl79F1+M1
 5rvfXIW5t/9HaATGPrCiQFXiIGcfWMH5/w==
X-Google-Smtp-Source: AGHT+IFbt5eMZiJn9uL30mct7dkguUPj2pbiBkyY0L0sSq3JZ7aqYZa0y0FCuM4KXXVb2z9FwL05nw==
X-Received: by 2002:a05:600c:35cb:b0:434:ff30:a159 with SMTP id
 5b1f17b1804b1-436550af78dmr13420365e9.0.1734505396887; 
 Tue, 17 Dec 2024 23:03:16 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060592sm12971612f8f.98.2024.12.17.23.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:03:16 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Walle <mwalle@kernel.org>, Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Janne Grunau <j@jannau.net>, Prasad Kummari <prasad.kummari@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 5/8] lmb: Remove lmb_add_region()
Date: Wed, 18 Dec 2024 09:02:34 +0200
Message-ID: <20241218070251.686383-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218070251.686383-1-ilias.apalodimas@linaro.org>
References: <20241218070251.686383-1-ilias.apalodimas@linaro.org>
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

Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/lmb.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index da960e422ada..659581f13f20 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -632,19 +632,13 @@ void lmb_add_memory(void)
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

