Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964C4E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 13:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AEAF89746;
	Mon,  9 Dec 2024 14:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jRPPA7PM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C181889741; Mon,  9 Dec 2024 14:29:33 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA3868973E
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 14:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9ec267b879so842189966b.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 05:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733750971; x=1734355771; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=anJCWe4K8wPUQO7Ta3kgUZijdDWjvvhHeSfNU7FIsTo=;
 b=jRPPA7PMKejN2+mSOONh/HL5IPpuA8Ic+uTgQ9IfZg4CiUpShnPeSpfDkxXp1o36/u
 b0VgJjWOh27e7bk6I4Fl4H1OMyLdF2FIfv3dgO7brWRtdtKKOvLKDJ5k0JGOiW8DFCde
 MNz9dquU4biJmQjxl0IKNhIV1hGevHzyg2hKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733750971; x=1734355771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=anJCWe4K8wPUQO7Ta3kgUZijdDWjvvhHeSfNU7FIsTo=;
 b=PPv0gL1ioblNukjdkrkGAq613WViC6XRXAklrf/pTInoFKoxc9W/D/JNVVs11PMIL/
 GdIA8iO4Q7ZUsZwFKIitEdEwvrNbNgMDsNxRVxxT3fiCHL2WPGmAdYH7jWjeUQYjThNp
 AGzxzUMXOyk75MrbWmbroH3UfOpBpUNBDwt6laDduLpsIQ2EklvH4Dh5uLj9CCNrfmeP
 TYjwNSlu10rTmyqqlt6S26iOjJWKADdcPkkPnCEyf9BcCqjpURyHEgopjx7jR9JAeK+O
 it3r/rPgChs5dEW6NqeQxicapcKgCawRb65AHpEXe7zezrqUdP0bNUGB+17J3iU3WgRe
 X7NA==
X-Gm-Message-State: AOJu0YxbVp+1GJ9H2GyAqKtwtlABNQaaL9diz4W5lnmdAn17kgjlbowN
 iLCdmdZ5G4GW4lcb2ddhGSsADJRVCRYFi++UtpQ9JnDDuAVRHKOTFmBKxX18VW06qEbIMETO3w4
 8PRpBKH+nZ12FNNLT18yOVusl8QM0ccNLHxKR
X-Gm-Gg: ASbGnctGodDVjoqX7Hv8Q0rlhbbFTaARa59mSil5bzIWuC0jIgZQIB9+nqIfU978vbX
 drh3fRAnXJwEauWPxg9XdpbZ+Qas/FaVu
X-Google-Smtp-Source: AGHT+IGCBluq2FbCURE/8CeAMaKwYgIwkuB9/y9iOrjL3z0h122b1UQcEVahkx5uPTd6wm4IPPPcaYVxuIFV67UNiCA=
X-Received: by 2002:a17:906:32d2:b0:aa6:5385:90ef with SMTP id
 a640c23a62f3a-aa69cebf912mr34339766b.61.1733750969722; Mon, 09 Dec 2024
 05:29:29 -0800 (PST)
MIME-Version: 1.0
References: <20241208190741.4192601-1-trini@konsulko.com>
 <20241208190741.4192601-2-trini@konsulko.com>
In-Reply-To: <20241208190741.4192601-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 06:29:15 -0700
Message-ID: <CAFLszTjgMSK3joQ_BS=kvyuPh-Jzq4X22caxBZ8eoTnySTu04Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] Docker/CI: Only test Xtensa on amd64 hosts
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Sun, 8 Dec 2024 at 12:08, Tom Rini <trini@konsulko.com> wrote:
>
> The xtensa architecture is interesting in that the platforms we support
> are only valid on the binary-only toolchains as the DC233C instruction
> set requires those toolchains (and not the FSF instruction set). Only
> install the binary toolchain on amd64 hosts and only run the tests on
> them as well.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .gitlab-ci.yml          | 8 +++++++-
>  tools/docker/Dockerfile | 4 +++-
>  2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
