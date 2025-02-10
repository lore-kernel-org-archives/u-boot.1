Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7901AC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E9080BA8;
	Mon, 10 Feb 2025 14:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y6/LrmyQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1EAE80BA6; Mon, 10 Feb 2025 14:10:07 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76C4480BA8
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:10:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fa48404207so3576511a91.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 05:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739193004; x=1739797804; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FwF77R2ZXeXaHUmPQIqP+pmSys9qSjNMyubYMeL1RYc=;
 b=Y6/LrmyQ7Wa3jnDK8O5NP/brsG+nY2n2VUcUiYA1s9+tSkotsAokoxBcUOkkdWVTcl
 V87qCm7jAmaXYXFdCHzrOhoqmhrvXZgfzr54KPMksvDvMVQn2V0u5kBxrWK7MPtkHg2Q
 wwdimNiZxL/MCbEqiKnqIn31ExWvk4Uj7KTAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739193004; x=1739797804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FwF77R2ZXeXaHUmPQIqP+pmSys9qSjNMyubYMeL1RYc=;
 b=CsGXVQ1Q4PzCJDfzrtxmuWYPKBR6mPFSPqp39mVavg3+bR4w3d0XpRfXvCkosg6fmK
 PD3gQDF4xoqDBXU2y1OS+wa5nO9LkBlNK6Bj+WdRDxkuIzvJ9kSWJdSxhuoDPYXQ9S5l
 XKuI7UXDPFqQZCBY1cOA5Z+XT29Hm3Ez0L59ckFnrV6exeCg1n/5bBEDol/INY/8VvSO
 aIQj/NdlYs7W409Gzf65lQYGTTiomLeyp39xXoYlDHdqTkBUphJdj1iDmRh4es/0N0qt
 bOo9DT7UtCSgvs4jxxXFFWGAEOW6Wm/YgeiCKGjqeBgQtluJk73onWUOn8gjKkTAkkIs
 SWtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF0Qfn3g2u9tQhwT5HzCR/Hsoy1GA62j5LAACzKGpQWisrx0MUblg1UXpy+ujWxBR7zK9DsSU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1kEePH8DoydFjZ/awcV1OLclwzFsL4Xsd1/tc0mlMXVfESD1d
 mj7v0SqR6Sjr6csaZ4qsShQWGP3MN7ARN6B54zLFXRb44+emPoUvRUrp1Avxp12ruqhzDnhole2
 IGGApQFSIovZHXMksHeO+iv0ni+GQ/iOu58XA
X-Gm-Gg: ASbGncvUpD0HR+nd353XCezM0BB9UE54NdxBPszTJJF4Vrtju6/eFgVrTXor4AdrA+5
 evC5OfSbXJB04rPphB4/VY8cwbcWP/JymSGaSNM4bd9xWOgWjChw002CNq/EgcK8AFWaTcovnuA
 ==
X-Google-Smtp-Source: AGHT+IHRdlFL8h1ULVcguy78cFD6uURjqY+9OZwZ+C+xg0Emla8tx9YX2kHwI2fJJYHKxx7oaG1Fa8cpWIBR9iwquQw=
X-Received: by 2002:a17:90b:2fce:b0:2ea:b564:4b31 with SMTP id
 98e67ed59e1d1-2fa2417770cmr18458287a91.19.1739193004056; Mon, 10 Feb 2025
 05:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-3-a4534bc67cbb@phytec.de>
In-Reply-To: <20250129-binman_faked_optional-v1-3-a4534bc67cbb@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Feb 2025 06:09:43 -0700
X-Gm-Features: AWEUYZmhvO4KzA0oFdjr881JeHcVRxDVPCFavu5uLl-OFLcYakNK3nuG_Dup9Ig
Message-ID: <CAFLszTjg9YYzwWjYccH0V9-45xzO0n_soDscfr+ie1maLMSOTg@mail.gmail.com>
Subject: Re: [PATCH RFC 3/6] tools: binman: ftest: fix tests that require
 non-faked ext blobs
To: Yannic Moog <y.moog@phytec.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, upstream@lists.phytec.de,
 u-boot@lists.denx.de
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

Hi,

On Wed, 29 Jan 2025 at 03:30, Yannic Moog <y.moog@phytec.de> wrote:
>
> By default, external blobs are faked. Some tests care only about more
> basic functionality. In those cases no external blobs should be faked.
> That would trigger a different (binman) case which is not in scope for
> those particular tests.
> Thus, disable faked blobs for those test cases.

As before, please keep the non-fake case as the primary one.

Something else to keep in mind is that the tests should pass with each commit.

>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/ftest.py | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Regards,
Simon
