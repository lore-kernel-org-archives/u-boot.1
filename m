Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8073A109C045
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A83B83DA7;
	Wed, 25 Mar 2026 17:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F6W1aLaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2029C840AB; Wed, 25 Mar 2026 17:56:03 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB7683AAB
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-467161c4b7aso4068b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457758; x=1775062558; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybRUXoSCfavvLPDZeI/u+AYGnmOH+GFLNDwv1DHxeYk=;
 b=F6W1aLaMRwgQ0u3gUXEQ06pMqSguO4c+3hfTQGSPcSETwPeKAZyhozysjYHor5oan1
 5O0XdrzBu7JSkZyfOG18Yh/CQQkmjUzj2lOFM2OrQK0Z0FAk9FPnBIAi+f5WGp+cspPK
 tqe2jz/CZFqVpNDQGDDTKH6dhLBu+81rXeIUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457758; x=1775062558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ybRUXoSCfavvLPDZeI/u+AYGnmOH+GFLNDwv1DHxeYk=;
 b=aGq+W8lrK2k5bEegzOq07kUxCFDXuUhrb8LUSeOwPcHtT1xNTkANfpi/ropsnVEFjq
 zZlnGKAUFuW1MaseH0Af8wMGKrEsg/o7/y4iUJnRJK2Qe9LQFwl7jj4Gj06d4AY1U6b8
 4g06emqZV/NftbIQJ40PYWkLmQYnuhkNVsUVaq+y4rC4w0F7j2AlcvYgNeYQ6s8bMecY
 +ocIkTi+VUzw1S2YobP1Ih1Vh779enjJwtFq6xLiMqgieETBx91c+S9UiDQNf3XRir+L
 BbZb+jXmxsgyP5Jcjkdg9c5In/0sO5cZoYzsQggBUcadzUVzsZKY+MIM6ZXDVX5G5nTO
 lrjA==
X-Gm-Message-State: AOJu0YxKqrK8HU5gyzi0xpBugQ8IzcqmjpN9I9Cna60QExOuCnQNjxI2
 kE84FavYS8yz+FAbAI3dbwi/xvSzd/FBzYZm91Ctr4bB/MdoALk0oVvUD1IDd436d8GsqGk+TIa
 GE2kcBg==
X-Gm-Gg: ATEYQzxlNm54h306P6cHToY2SRZ3Xt7pJLyE7+FP9ePXRjicVT8awfcapBZXJeZjIvd
 tLgXGrRDGbv5aOo+IjO3zZ6ReAgsgCGIbghJzHduXV9j4omRFuvcqLXulRikoPlZM5vD2xemJD1
 Yj7mYaTVSPpjfWOxvB5Oqg84LNjRQhubop7M8IEuegH/xYLudcdyYUd7/lEdoVg0c38MCCB6iA3
 K+p6AyobIxpcPQH2AuyZKImMGF9IuiERbqOuFnDAMrfM6t0xq+Auau89FOvMaOnpncKrsBtRQSc
 GEBWmSU7zeTeZG06n75+EgX2m/2BRVBpcZO5Wfyi6XC6Gf7Aa6jAuW/o2g1/dfHDDt7l3laDuq5
 QU8SfPpALugMyfwcee9RzvTZpLekgbycu8VS0h58jSYBLRYVCTSGoB7TSzwOmf3CUyuXOqJX68l
 d3KBZL4qFp6Yq6KDcfEw==
X-Received: by 2002:a05:6808:1911:b0:467:1462:a9b3 with SMTP id
 5614622812f47-46a5c6b4cb3mr2037018b6e.38.1774457758565; 
 Wed, 25 Mar 2026 09:55:58 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/13] boot: Tidy local variables in fit_image_load()
Date: Wed, 25 Mar 2026 10:54:22 -0600
Message-ID: <20260325165431.1027591-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325165431.1027591-1-sjg@chromium.org>
References: <20260325165431.1027591-1-sjg@chromium.org>
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

Arrange these so that they look a little nicer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 34876b66fa0..fe53b3a278b 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2472,15 +2472,14 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		   enum fit_load_op load_op, ulong *datap, ulong *lenp)
 {
 	int image_type = image_ph_type(ph_type);
-	int noffset;
-	const char *fit_uname;
-	const char *fit_uname_config;
 	const char *fit_base_uname_config;
+	const char *fit_uname_config;
+	const char *fit_uname;
+	const char *prop_name;
+	int noffset, ret;
 	const void *fit;
-	void *buf;
 	ulong load, len;
-	const char *prop_name;
-	int ret;
+	void *buf;
 
 	fit = map_sysmem(addr, 0);
 	prop_name = fit_get_image_type_property(ph_type);
-- 
2.43.0

