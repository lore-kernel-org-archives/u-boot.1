Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F1CCF884E
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 12:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0963084105;
	Thu, 20 Nov 2025 13:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gjBC9iog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50E5384106; Thu, 20 Nov 2025 13:18:38 +0100 (CET)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21FBA840CF
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 13:18:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-640f2c9cc72so649603d50.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 04:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763641115; x=1764245915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xRYau9OKy+AbsVX5w3yBSMFZFe1UvEpbRQzKCfs0084=;
 b=gjBC9iogXpDrEyxw3GjfdQpxJOD4JL6IgbVzLWJlgWtE/PgWM/Gc1WUfRyWMoe2l2x
 yX9EL6Cb0ekKA2798ZT2e4Dd2bhbzv3B43vn0CGVdf9q4gQe5mXjKZo+yE7SMhOkcZFK
 LwKW2h1dIomtxn8Qy233BsbNbpQ6WdJXufITt6CvO1r9uu1hyUvkSe7szWhtuETzxptZ
 nIulRTPx3xS2z58lBTORrsXp/Gcdn2qnCZG2XVM6t2hatOjgKKGcAaKtihXsPf6RthWA
 xqvK99X0kHCMPDDz85Zh/itcqwh/780cKkaxvk8Eh8tkJwjSWD474rrme+vi28lWCdWM
 QsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763641115; x=1764245915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRYau9OKy+AbsVX5w3yBSMFZFe1UvEpbRQzKCfs0084=;
 b=Qc9KTyVHaoYIY6a3n42a987cVxPTt8HPEsGdjcEtliC5QO1Gb9OFLbY+prDt3zHV7a
 j+ZWxHFJw/6ALiD0dKsw4SFhdWPX7MfC/O11UABVpkPacnyoOh30bIvGzC6NxcHLAIwd
 KD7k0N1YeY0GXTofs2rWAAHbOmxem5y7qTxDn9S9YGGhZpSaNn7rDvw34XA2Ot1vLCy1
 G2pW598d6AagePP6Xe42Uj6FQ/7qEjk5tI4Cf63tVOzfOaQ4kHgOOQjrqvnDzq7GSv5l
 OjkTh4vAD/ycpaVcPlg5ZTxT7m3qh53+jTMbugb6GtxmP6CAwAU5/dXJQHqFFmF6W4/4
 SG1g==
X-Gm-Message-State: AOJu0YxKCBfJFFpXji6VqtLcm8N1tS5s6kARhhuNRN4at8oYGjYjjGJM
 zpnZ2Qg4bVn+ZmECwTe+TGw2LEwLK1fqT2/jvJfav4zKATkQhK18SWbVjkYQSPTP/pMyTDFcvwq
 tOhSFpEI5kxopR2I1U3RdEQw44ocw5CATRXBhdQ5J5Q==
X-Gm-Gg: ASbGncsY4LS9ZFb+MzS6pChBSjJcNqnPX+GYLJky7PxkSN+52K+W/UIuU2HdsBnAvfJ
 ZkbznirnFLsUZ6eIU/YSW6a3u0C6m8sfoDwC+AX9WS0fvCVapdN7L/Z6nnHgo8Wp2ECY3qkEAAI
 mGsksSBVSu5sZ3ANy01AFCGS7l9APMBU46X6rfZ8LG96a8i6JXuke4GTcx0yDjLycu6ouPEb9LQ
 BdD9b9079P/KKlDe29F8tTRCx/5i1UEMiKM1/n8Bgegn6BjYs8QymRTcY9IytguBHiRZAJ2f8aF
 tm4KE5lGFmERNT7gt1E8F4CQ0kNnrBeFR3YRbUMo45MhhcgCfkg=
X-Google-Smtp-Source: AGHT+IGeyi0aq8RCbyQdv7/J2rsQTi2mjjhwDfY/ZLvpsPWa9A4jIsI86TRbJd0wTemFmKhY/TPUCc6hkXF5VOj+mM4=
X-Received: by 2002:a05:690c:c8b:b0:789:2be7:ae80 with SMTP id
 00721157ae682-78a7963d5d4mr45285677b3.54.1763641114921; Thu, 20 Nov 2025
 04:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20251113115558.947903-1-marek.vasut+renesas@mailbox.org>
 <CAC_iWjJE1meO7UonS2-hUSkkcnxQWCerqdN4mb_wcR7rpVXy+g@mail.gmail.com>
 <20a873e8-d17c-43af-88af-ca14219859c3@mailbox.org>
 <CAC_iWjKWr-J3pxmwT5mCDXaAiRxYFiX=hfHGdp2x81-0WzbEpQ@mail.gmail.com>
 <7a84357d-c4c6-45f1-a0bf-d21ee7a19a19@mailbox.org>
 <CAC_iWj+tKuw-cByFDQMceb6w97KZ=0CzK3CWyA4ceC=eQ3L_CA@mail.gmail.com>
 <2e4d6bfc-c26d-40ae-a565-bf1ab2c341d7@mailbox.org>
In-Reply-To: <2e4d6bfc-c26d-40ae-a565-bf1ab2c341d7@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Nov 2025 14:17:59 +0200
X-Gm-Features: AWmQ_blsJ5q183UxF02UoeUFBadZlqX7wOdVJwI1nqSCe_aaSauX9xyPw2LfqOE
Message-ID: <CAC_iWjLRRkXYak_cgf_Oi-ReeypECv687YEoyV26zPcm_K0y3Q@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Assure fitImage from capsule is used from
 8-byte aligned address
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>
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

On Thu, 20 Nov 2025 at 13:57, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/20/25 7:10 AM, Ilias Apalodimas wrote:
>
> Hello Ilias,
>
> >>>>> Initialize img to NULL and make the check a bit simpler to read (or
> >>>>> get rid of it overall)
> >>>> This part ^ I do not understand. The img variable is used by
> >>>> fit_update(img) , where should it be initialized to NULL ?
> >>>
> >>> The patch might be misleading since it doesn't show the entire
> >>> function. But from what I saw 'img' is only initialized when
> >>> 'if ((uintptr_t)image & 7)' is true. you can initialize img to NULL on
> >>> the declaration and just check for that.
> >>
> >> The 'img' is always initialized, see this:
> >>
> >> "
> >> +       if ((uintptr_t)image & 7) {
> >> +               img = memalign(8, image_size);
> >>                   ^^^ ----------------------- Here it is initialized
> >> +               if (!img)
> >> +                       return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
> >> +               memcpy(img, image, image_size);
> >> +       } else {
> >> +               img = (void *)image;
> >>                   ^^^ ----------------------- Here it is initialized too
> >> +       }
> >> "
> >
> > Which I somehow missed reading the patch...
> Therefore I assume, we can wrap this part of your feedback up ?
>
> Thank you for your help !

yw, yes we can wrap it the patch is fine.
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
