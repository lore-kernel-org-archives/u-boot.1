Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99170C3ABCD
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 13:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E6182A1C;
	Mon, 12 May 2025 15:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DgzI3Bdd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 699F58294C; Mon, 12 May 2025 15:08:34 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88E82826AA
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 15:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad238c68b35so408073366b.1
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747055312; x=1747660112; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mYVI6gst+CgqnFyY2dMifa/8EIUJ+64cepLh5aDbKiI=;
 b=DgzI3BddKM+jLt/ycLfosUqien1N0On6BG08FK7MVM1OIZ2oZk5npJQ0TjxzFUjOwb
 96229atAtyNS/qe0wUj4KHc/heAGQa1+ozyRpdag2UTqnkpNUXXymC6M5Nr+HQejYuwF
 sPajppqsn0C787o0SrSi6XSx52wrMJXvXZ+gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747055312; x=1747660112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mYVI6gst+CgqnFyY2dMifa/8EIUJ+64cepLh5aDbKiI=;
 b=XOBj3i2ci7sU9W/5YFiunIFoY6RBxiLANJzEvwFAToWZWFPp4pNNwq3f/IctywrW++
 xmSkJ49ZKsf5Is5RPF/JAWRRfVGpOJ1j3k+UPkfsYHIqp9HyHqnPOo+1Z98nFWLz+v2V
 LnG8NKAmpe3T9PHuraQ5jZOiC6FDbxrESwqy1ddd9aU4oqyWeXaKsP66JVepFLASp/NL
 tqZQxcJ+usA+2LWv3Y+CbE3Ud3gmQEOS11rzfMG0zOW0AiU+D4L+GC1/TV+qDm7ASVCf
 GrBipqSkJ7YAjEqAOa9X97/RiP0QBsp6TFaarmRET6dgNqqO6Ml/U8mKhcnXx8Oiwq17
 qq4g==
X-Gm-Message-State: AOJu0Yw/ZxiBgOAMifGo/ty2eju5O8ZpMTpXUI6nQ9TRhh9HmaoDy/1o
 z6YwMBhfvB9GBxy2lhRVNfi/zTX6Jllt7e6X73MvH7scYvkgp0ONRgr1hUgAfZtyFmBZc7xuOHD
 rdNKCJxfG+06hsTA8PhayWKWiurrzt7pn8Pkw
X-Gm-Gg: ASbGncsyy9h5Nk6RS9e91uwue7iWLmxaM72safSDsvhAbaVecF5c2X5eLE1KbgTkW8P
 J5R6ZecWeHC6h0HEb8v+pOGepkQeqBNoqN5jPnClL6Y/wQ+xg4gmpdldm5z9JZp8XuuPG5HZMtL
 RdOkmZZMF15B04XbwjbjLUbgXeP0vtJoHWKKJt4/fOOQNP
X-Google-Smtp-Source: AGHT+IEq7CIe8gdsBv/N4j7ksF9IFPgpWCo0vWDoHLKimQbqMwKMcwVPIcDVNmlzqfq8qklxBf41nQoOYQDsO9RAi5A=
X-Received: by 2002:a17:906:2317:b0:ad2:1cba:cf78 with SMTP id
 a640c23a62f3a-ad21cbad577mr930723666b.45.1747055312025; Mon, 12 May 2025
 06:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250512115028.1783305-1-m-shah@ti.com>
 <20250512115028.1783305-3-m-shah@ti.com>
In-Reply-To: <20250512115028.1783305-3-m-shah@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 May 2025 15:08:17 +0200
X-Gm-Features: AX0GCFvZLv0xNYd1oUGXDQCGszSU3LU5hKgPGopMISk-JA1QRUWZqDE1yfHZH4A
Message-ID: <CAFLszTiPSitCeYZUdf_=_w9NMmbtfKjjvztw-dMQKYXRxUqQFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools: binman: ftest.py: Add testcase for bootph-*
 propagation
To: Moteen Shah <m-shah@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, alpernebiyasak@gmail.com, 
 quentin.schulz@cherry.de, m-chawdhry@ti.com, n-francis@ti.com, 
 vigneshr@ti.com, u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 12 May 2025 at 13:50, Moteen Shah <m-shah@ti.com> wrote:
>
> Add a testcase to ensure that scan_and_prop_bootph() actually
> propagates bootph-* properties to supernodes.
>
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>  tools/binman/ftest.py                 | 22 ++++++++++++++++++++++
>  tools/binman/test/347_bootph_prop.dts | 19 +++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 tools/binman/test/347_bootph_prop.dts
>

Reviewed-by: Simon Glass <sjg@chromium.org>
