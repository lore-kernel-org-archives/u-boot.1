Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B16E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 10:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03300801FE;
	Wed, 11 Dec 2024 11:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ruovsQOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C881080241; Wed, 11 Dec 2024 11:55:41 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBBEE801BF
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 11:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa67af4dc60so576662366b.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 02:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733914539; x=1734519339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Pa4i6SSo0ziuImDLfRHe3DBSlYndj2von0Q32AANuI=;
 b=ruovsQOQiNJpumVdcdvmcW3SxlLGAbPQyKOLrtLuIij2RLco0+xV4iFUtAdQiGNCM6
 4tvGPe6J3ymEmNAMAp2Tgj9BNtSbOKTEHNai22C7QWDl7NGcE4kObBJWXjKE9cH9YC1s
 X6ZuzBPeX9QFm+mRB4zya7aPMPbpBJ8o/F8HjC/DFxNF5iWM25EMUGSWlF2Q3ntYnY8D
 41kZO0RQLRRE7wQVL5IehO/TUclBsQnqC7utTAwBjlVKDgq+Wfux/CIhfVZEpcxQO9kd
 ln2FuHhUB8xYcQpAJFjtKFFXUQt3y8Cx4s1OZdHrY8WNAVJG6q2KvKaSsSgb0bK0Ks75
 9tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733914539; x=1734519339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Pa4i6SSo0ziuImDLfRHe3DBSlYndj2von0Q32AANuI=;
 b=OyByVo8zxR8tNnkuaZJdR0kMN7IO/G4Wn9utdnEtHoxKVCdWLX9+k9mUE6F1HMPHOW
 eYGq20zK3gD1DR6wfrMYAMEi/ELNM50YnzqFuM8wOq+dx+ty/iZoXbDF3MngxFuw6No9
 sQpJ4np5bvmHfwge12NmWStwLjkv1KtVBbk/kML6ECuQNm3Ibz4KajbHNmpAyOQ9Nhmw
 4ZBh130BBi8vtTb9UotmcsW2kb1cI5urOfpBdNFG1lgpeQ+cCaO4JterrsgQx1/p2ltM
 iDXIyyRmgl0SJ7IW40/wHl+KjlgBTtayq0YL18vBTy/+lCNnSEnn9DFXdWYm+izwl67b
 lPPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBUHvudLT4kjFMYKLmNtsj5roWDQgwzpUZWJqrCfzCvQCY7x2bG27rkIPL7gNOxbcMpWxD4EE=@lists.denx.de
X-Gm-Message-State: AOJu0YwnVXajgOy3zbkVLvLPmrZH3hSKoKFI9/EpzI0NcNJgWE4CDKan
 9OOxpe0+MyN59t7VAUca6rd4WJq5oJZurAzHI39F1Ayf/HsLX9ZM5GurWymOoeE=
X-Gm-Gg: ASbGncu4C+fANeW+BnToZGyJe2PHvCfBoUkqV9SNrwCTCFZnSWK2T1DX9H4oxR5PY3n
 0bVI1If3+m8lK5y6ffnccCNvM08BYForE6hrEPrrqs/rQS5kvnKNJi64HeVPwm+a4/SThRhRDaQ
 StnGQjBKxUS56LtxDerktGFs3+JyVb3O9DC0o5frIJ80ahpNbRaKf79N0fKJdRPrxOAYHbx4kYr
 ShkHjl95lvxu3N6reNgpYFpObAUyW05L7PIKiwqnXw1o5X1X8rV5rVY3+IaJHPjdJ4Xrq3/a7u1
 ZoJ7VTGnE1M/zG3Wl/YYfH5KbGVZLH0=
X-Google-Smtp-Source: AGHT+IE3/Zv+lKjDiKfZYF0rO1HoGlqlfgeka/9mctJSusFEkD3h2AS4DOLMF0IRpElCumETE622Pw==
X-Received: by 2002:a17:907:84c2:b0:aa6:824c:4ae5 with SMTP id
 a640c23a62f3a-aa6b1505cc2mr176234066b.56.1733914539129; 
 Wed, 11 Dec 2024 02:55:39 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67e652b1dsm508006566b.172.2024.12.11.02.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 02:55:38 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v1 8/8] lmb: Rename _lmb_alloc_addr() to lmb_alloc_addr_flags()
Date: Wed, 11 Dec 2024 12:54:49 +0200
Message-ID: <20241211105504.453234-9-ilias.apalodimas@linaro.org>
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

lmb_alloc_addr_flags() is a wrapper for _lmb_alloc_addr() and it's the
only function using it. Rename _lmb_alloc_addr() to lmb_alloc_addr_flags()
and remove the wrapper.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/lmb.h | 2 +-
 lib/lmb.c     | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index d481972a6686..76fb82b197a9 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -123,7 +123,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
  *
  * Return: Base address on success, 0 on error.
  */
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, uint flags);
+phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags);
 
 /**
  * lmb_is_reserved_flags() - Test if address is in reserved region with flag
diff --git a/lib/lmb.c b/lib/lmb.c
index bdaaa634abd1..7ca44591e1d7 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -748,7 +748,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
 	return alloc;
 }
 
-static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
+phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
 {
 	long rgn;
 	struct lmb_region *lmb_memory = lmb.available_mem.data;
@@ -772,11 +772,6 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags
 	return 0;
 }
 
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, uint flags)
-{
-	return _lmb_alloc_addr(base, size, flags);
-}
-
 /* Return number of bytes from a given address that are free */
 phys_size_t lmb_get_free_size(phys_addr_t addr)
 {
-- 
2.45.2

