Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3969E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 10:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19557801EA;
	Wed, 11 Dec 2024 11:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yhng+d9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B629C801EA; Wed, 11 Dec 2024 11:55:30 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC3A3801BF
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 11:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a68480164so962417966b.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 02:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733914528; x=1734519328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LrJKDtfKA9ty6RP+PUQwpGRC7a/wDd2aZf4oOuSj3g=;
 b=Yhng+d9XtoUlt5lnJwrHWhwboV53v1J6ULmuv/2EKOCnEC1drbfQDB3y89bsDbKkpZ
 cEDn4fJ603jGqC05Hp5/V2M3/LqfgwolPUkU5JKoypxlI6wXBavZ+kBmmElPYBnN7Cxn
 8iMnV/7SV6EV79EVe2sO7FJyOoBqq3lRpTmIW6/+8kQdksGq4ot5t238QWwdqd5JvLic
 vFrL0jjm8ik7CH+DLFb2Ld/l/H8adhDpF/PCcdNMyQF3FLkb+zi//tIHHdNrWlWufLp1
 21QHb4xitpOpkkt05QxqOaclmTmzglKBIPPZBl8/3GTGAQgwLcB04txGvea3xzcDKtae
 BsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733914528; x=1734519328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0LrJKDtfKA9ty6RP+PUQwpGRC7a/wDd2aZf4oOuSj3g=;
 b=pTGAJ82KLSMKQRaK2/efLpmM4465yUu4dnbxU1JkHMIux0Fopn3nm6/BGR0urTg3Dr
 wRsElSqIBRSTXloNn4VJLL0DZ6g469wjeojEptHflWqkiGaka0Am+Zvo1tF5LXBu+ywX
 /XoobDfDxWQteKi/YTkRcKwJc1hZruX7SPKcuMOJMd43EO8mAvT0yhi+vVRyiVczltaF
 WNdtO9xZbIRzvfvaF5e9Zhrq0iDiz+V73BRahN0EM1wO6RxTCigwYUJkrK9rikHm+q0l
 tUVwAuz+cgjwh/9imzB8qUYe8hmY7f/MC2766W5uhxzveN5Q/OLlDoGH3jbzrpkBSoPP
 1qnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHysDyoOtdJHCgxohj7ioSWHZ3tBeEp4KQw10FXYfucPab9L5SfzMVagq6icY6XQNzQyMQXJg=@lists.denx.de
X-Gm-Message-State: AOJu0YxSx+EDJhiyUZ63gCn/0zA2LYX/ryCb22FowWGJ7W5RvTGC6u39
 NH3KG6TXAAdbhJORJHKws5jbnUVuhHF5au/y8eJQ52Zu3jZ/aGvCHYbl+WxhzuY=
X-Gm-Gg: ASbGnct2LaxKUa/DWpJ4Zi6IrBe4of29vz+nIFAVCQxTzZsqQ21ARFpOyc9P8sgZEf0
 R7kT/tSx2+EcoAKrUFUYDiovpStIKBFx2WzyelWzZvJeP5TuvEOlYfSYe9VokNJbogonYllil/e
 oIxjeTX6guA5TzfOM/fdVFvza+7gEUwiSOUPo/9ARbFi+Zne7r0qlWZHJfMLk/xg3yNNW+IlXoi
 e+oOC3nLpD5cuS0EO7J1tOUzVOXVYQmd4B4eFRftJmrSNOroFTxWD49u1fMG6zVl4Kc4ZaowGpl
 RzYzIdSzSKN8nTZ/bRH7mIPSL2lTsb8=
X-Google-Smtp-Source: AGHT+IHenNo3GIh48RP9z58LOSNY8fPQcVnylfsIogIUciX8ao4VCXlvd+y0ovD1FLZSeoYALq6eqg==
X-Received: by 2002:a17:906:1ba9:b0:aa6:995d:9ef1 with SMTP id
 a640c23a62f3a-aa6b115b17emr204184266b.12.1733914528150; 
 Wed, 11 Dec 2024 02:55:28 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67e652b1dsm508006566b.172.2024.12.11.02.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 02:55:27 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Nam Cao <namcao@linutronix.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v1 5/8] lmb: Remove lmb_add_region()
Date: Wed, 11 Dec 2024 12:54:46 +0200
Message-ID: <20241211105504.453234-6-ilias.apalodimas@linaro.org>
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

There's no point defining a function that's called only once just to
avoid passing the flags. Remove the wrapper and just call
lmb_add_region_flags().

Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
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

