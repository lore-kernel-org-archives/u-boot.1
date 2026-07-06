Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886CCC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 12:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7D08488D;
	Mon,  6 Jul 2026 14:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E3sECGqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D9F8494B; Mon,  6 Jul 2026 14:31:26 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B8A6846FD
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 14:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-39b1f588471so26240031fa.0
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 05:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783341084; cv=none;
 d=google.com; s=arc-20260327;
 b=KIORkgCoN+To5RFw+bd2AUnj5o7UmvFkylNh/y4AZzK+CXsDFdDk+zHPmIOf6w81MB
 zLKG2iHAjdruW5eKfQ/IV8+QUgo1AaqwTitz8AFaf31S6RbaxJSHBI98DVLmyzdy7sF+
 6eig1mAIJIiZeEIvqEfNe6gn+YPaQASNcsFVEZhHc4glFjC8PShOuYB6gopRzGwhE6DM
 xXCDwjAq+pf96jKC1UgRn3XHZap78v/7ODaQ0VArDxWbaZ8CbDkQDdPZkkaL2uRsmSsU
 Z/3dHeNWGDyrv+4FRvEmLQka4I52nIdY2rVFTifJ+If8Y4He5VW+Pt+JXXaSetGRLDyz
 4lNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yWpnVLkfpcCUbs1B0CRZc3c5RgeLEbRhh9YNi79vKag=;
 fh=EXHy3Y9gzmSvK3vukrW2cXL2aNbi+7j4/fkXx9x+rv8=;
 b=Q7kjZUC9cvyIBFe9DPLdxNLqcoFAUVb7N6A6Z0Hrf8UKegtgC76Z37Cz0Zb+OqoXdw
 yPKgEOhu54l8HbRZszj6JQo581bBW+4UNSCjd53IGkfUlFecQTCjekyJ6Ea1lbrc/hqt
 UXAe/RdvWBkiCN2gcDwXla96J5C1hkA/IX2o9EhBNn+aEPXlIqZgTTyQ57D5GhMPKW9p
 DBsaCQBVYe+xaMnaukg8PEJlC9z/iZlYMUUqSN1bxujoBRSz1PfOQ4c/UQvMOqQTq+c5
 NYGr2Skl3EGbw6YKnR3fVcFwnCObhPqpNZVj8bvWUJLS8owI/gtM2sFpStHATZb8vT58
 DR3w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783341084; x=1783945884; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yWpnVLkfpcCUbs1B0CRZc3c5RgeLEbRhh9YNi79vKag=;
 b=E3sECGqOLShVIQdAoWVaXnDH2wswpGLUsOd/jYHpo/mBXPKCV9NPQhNNGcbfnz1fJM
 GpBWFuyTqnyVfL4cShc3plJAxBr8a7EKXmWPZiAunWBGTRZZ11CkSjJl/NrfJxVC3VTy
 n5y3bEjnDpSiFE1yju2wvqVYBbf7xIjJBtlvToLKxlzpuciIC3WFvEQkyogmSy2KK5jA
 sdiicDKGR7bBvINnVR5zBv0zgO66TNytmO+FN89/TK5cwkNhIiSJx+I0pEKtinsV1VF6
 BlyROtSQKWDN/1B2nR3AmkqpBhk8J4IURslJtGY2C7fmEzcAT1pPdFmSwgGmlW1zdTdO
 wuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341084; x=1783945884;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yWpnVLkfpcCUbs1B0CRZc3c5RgeLEbRhh9YNi79vKag=;
 b=qqEVBcR/Q6Js9my93qN0PceEOQVwXrd2hJTdmMZ49wXg80xdurrfOkk+sb4WyC1EiT
 AZvC+0JVFEwMVpK5UcpVMf5OICueGiZ96PzyiTmRtsJfZdsb4ohXNvixJWjXDYKc1WX/
 Ft6mOS14uS8pwZzJsGfMtGgOdAI9f+o+fTNMWZvHLOqO6b8povJDmSvZJUQJUdDh8Weo
 mVctEfI21+ea8xJ8CzaCW/Xz2jbnaTPfU0aDlLk0u7dWaBatt2bvA0wjA+Qvi6OTgk09
 ybIWH8BTQltx8jnDRQwraPh/3xEKslxyJ8akolir2UIDRDC5ULbkmyS7EaviETExxr2v
 vnEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUxqhIdZD5SxIWX4a2SNMBxXQ0ivc4EGCT+X9tMdPBkeI/U4wCakhuw0sdM8B8zMP0LiG6Tj0=@lists.denx.de
X-Gm-Message-State: AOJu0Ywu/Pxcaas9Gt1F9c1F6ty3WDxCB/wxgcrudsC1sOC9fqCfFKdo
 X2QK4Mw1iOn7WNg0YGYSqM7oaUzX888DEMMui/dEi39u6rTTm0fqUjXkqkKXd+BQpSwr8KSc98O
 2ywKqPtrCSmqkHBHFaJMGRmrHXCkfEm0=
X-Gm-Gg: AfdE7ckLSU9qrSIe15ThKHGANG9emHhLRQyvKH8xDlyrYrFvGML0tLsZbxFFHCaliEI
 byBdvqdPhUVedzev0gV/wKsi9ToKLTW7UsSSxUsydMlezpqvYdH20zPRWhpxKDdijN6CkwtG5/2
 qK1dsqY9cBloXjZvJ+LhINtKFJGs5qKHEFDE/545Nc9OVxQOgxLYc8wYHHH064L07/4nB1CHTGB
 3xX0U8NJNJTAVOq2woEL52Ku6tor3wtoO0tDgGBXeeaVe64wK7CC7hPbZlgqJ70tYFxeEQhFOwv
 zaYftpCx2Gp0+KyD9s+lbSHqsEL4oh8GIZOr2hqDXK4mCNJOa4QUD6b6AMvj4A==
X-Received: by 2002:a05:651c:198b:b0:39a:cfea:f17 with SMTP id
 38308e7fff4ca-39c5ffe1ed6mr1304101fa.30.1783341083297; Mon, 06 Jul 2026
 05:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260208212624.3413494-1-festevam@gmail.com>
 <CAFLszTgP0wCfQOZ=DJhbdPWC4k8e66XmNtF9cO8z97oqPetdRw@mail.gmail.com>
In-Reply-To: <CAFLszTgP0wCfQOZ=DJhbdPWC4k8e66XmNtF9cO8z97oqPetdRw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 6 Jul 2026 09:31:11 -0300
X-Gm-Features: AVVi8CcidOeJYjDyPn-gDReixhEUFr5u1fZil-APa9LFzAt1N1lbXT1cvHZNCHg
Message-ID: <CAOMZO5D9NuWVkJ3PH1-wmTmvzq76=zrEKEekYozoPRY8ZjcrpQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] ARM: Add RV1103B Omega4 board support
To: Simon Glass <sjg@chromium.org>
Cc: kever.yang@rock-chips.com, trini@konsulko.com, jonas@kwiboo.se, 
 u-boot@lists.denx.de, Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

On Mon, Jul 6, 2026 at 9:27=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:

> I recently got one of these boards and have it running in my lab at a
> basic level (boot to prompt, SPI-NAND and MMC).
>
> Are you still planning to send a v3? If not I could handle Jonas's
> feedback and send out a v3?

Please go ahead and submit a v3.

Thanks,

Fabio Estevam
