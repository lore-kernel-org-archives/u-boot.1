Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BBBEE49A0
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 22:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B6C871DC;
	Tue, 22 Aug 2023 00:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UHiVqn7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A30871FB; Tue, 22 Aug 2023 00:11:12 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73953871E3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-525bd0b2b48so4791241a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692655869; x=1693260669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZesBRQQCm6O3jvTiWA3MjibSeGahjr8RFPFNvPVscT4=;
 b=UHiVqn7SrmtVoOvDuTdJqppgljYgoqqPDvGNfKJTGOZNCIjWu8P/qB8vjGI44jrHrQ
 9BBJCJ3H++CsxNDBBZHbvfkTTekSQ4Z/FMNYPocGkm7DPEpPcQMA527iPgEiSZgch12u
 cuCKv7+fECenVXJrs+pz6VKXEeicm9a3Z98BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692655869; x=1693260669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZesBRQQCm6O3jvTiWA3MjibSeGahjr8RFPFNvPVscT4=;
 b=jKthmLhzRrSojbWuCYn+S7cqnd572RyWzwDTT2GSMn7NNrdK2UhtbqkxwdYcpb4gSZ
 Z42Ha4MGe1fSJYrg1JABEbYNVNTsfYGH3rlQbKDJJHwN0n3eEngwLoeBQ4zGDvfdG2Bd
 G9UhV9RdAto2zzGNLjFZP9Eb+SzhHQQfOpPn5Q9HYFmvV3t25CdkxUg6EpJaed8IcwfL
 BIIXbwIWup4pjrPA312fAHTkpZhyR7OlyRjxbgssCHY7dhewh1L636ftGEdxorIlf5Cr
 JbXWoMjuUNedbLZaj+NKfQl5ejjpOxEJ5JCamlajJK8SJhWdo99HbQwDMsPLr45zfAFV
 HxyQ==
X-Gm-Message-State: AOJu0Yz2PoCd9rbHBOUWPydz1/dYeMX0tmK7qEHOcU0a/rnLNoWf+v/C
 RMF/+3ZTlmbGXipsPbaGRqNhqtqNYFkakKrA9dz3aDQFPfdNmpUOH6U=
X-Google-Smtp-Source: AGHT+IGDOJh4FZjXjKq0Dl9RlLigWYjIrNzOvhecU6hFLVVRrKhaSOm9pFU34ys8n1YqOxfoesFzsIilqlwq8s73dhs=
X-Received: by 2002:a50:ec84:0:b0:522:2b76:1985 with SMTP id
 e4-20020a50ec84000000b005222b761985mr5816287edr.2.1692655869018; Mon, 21 Aug
 2023 15:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230821181339.4135800-1-alpernebiyasak@gmail.com>
 <20230821181339.4135800-6-alpernebiyasak@gmail.com>
In-Reply-To: <20230821181339.4135800-6-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 16:10:56 -0600
Message-ID: <CAPnjgZ3cAsRBa2-r+uNG_Pn65x8L50or779-=iLzVWS2qB1Grg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] sandbox: video: Use partial updates for SDL
 display
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>
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

On Mon, 21 Aug 2023 at 12:13, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> Now that we have video damage tracking, try to reduce the SDL display
> work by copying only the updated regions onto the SDL texture instead of
> the entire framebuffer. We still have to do RenderClear and RenderCopy
> the whole texture onto the renderer, but that allegedly happens in the
> GPU.
>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
> The second half of copy_to_texture is untested.
>
>  arch/sandbox/cpu/sdl.c         | 25 +++++++++++++++++--------
>  arch/sandbox/include/asm/sdl.h |  9 +++++++--
>  drivers/video/sandbox_sdl.c    | 16 +++++++++++++++-
>  3 files changed, 39 insertions(+), 11 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
