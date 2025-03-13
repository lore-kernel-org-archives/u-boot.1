Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3017C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 09:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DCAF80756;
	Thu, 13 Mar 2025 10:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sKThwRS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76D5880540; Thu, 13 Mar 2025 10:36:23 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1C808168B
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 10:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so637817276.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 02:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741858579; x=1742463379; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IJRnVbAmL7DQwb8nRi/iEopPW7saFjrIVTBQnZQUChA=;
 b=sKThwRS0v/NW6VRMisiedbWGBhJLPi7rer9V9bGLF63DuFMclow4I9b3x+IhdRWQ59
 YHyZ/IhzGyHZ6C/TqylWj9BbLsN6knnKlPxex7zJceVrdX4R3vmrqVRtd1jfX24w0VJa
 WvKzrfHjI0kXa3oUx9jPZWoq4sMwK0o8nxsN9TjFNJx0/TlNCj9uVs/CdOJlaBftHHpV
 3Y5+eSPE08VcNqmAxCcoga0dFRTbmyeMRx/DpzynFG9LNfkhf2fJIuKFlaO3FR51os8V
 mmZBWmyRKsgBv32LLv8Dl6S6vIdlK+xDOiU3yUXdom8IkZy892aSWKRvsk1KTYXcLC33
 IF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741858579; x=1742463379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IJRnVbAmL7DQwb8nRi/iEopPW7saFjrIVTBQnZQUChA=;
 b=QjagJoZswmMg78rMgOC/aojViIXn+WF2VwXz36eCporCpat6D6/4TFvcv4R3CCMg4I
 OdYLJHutjhGCefot0Jh088EfllAP/VjuK3akqnDkcAlaZ2+f24RpJynPqCnx8WaUkxrB
 dXWXiKnrkFAn10S745ZyqZMmWa7WdrkBY0rkBqBeyyf+9n6vBRPYBBN973TvzPU353uf
 /orhs5O6JpOcJPxS3AOEKnEmxzcg0uQjvC84N25ZAiNtYoeZ5yokQKtow7H3ob759CRy
 18GxU+AT32wX4UoGxS5sSj2FANzszyB6jb0hEokr+R8d/YjLoeGRWpraN0ieidiiGNoO
 mAiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK+u0obI55tZU7Wo6RWYHYAg4uu9bgV7L3zbOyW7H6J4BU19rrfdJNVUMJLdNADlPnZJhX684=@lists.denx.de
X-Gm-Message-State: AOJu0YyaLUiXR5lcLNU9TUxPASc4XPODDQPC+gFuiBOUw2Tvc0pKbimB
 shJ1PQA6zyc+j+1chv4+5D1jSMz81HiXMqiha8VYnfIP4zQh1WW5H7wkJgkuP8wJNs4/vLuXg50
 uZm6OYs/PPwFDpa8rwYmLlsFaAjqCnMkfh+/xNQ==
X-Gm-Gg: ASbGncsIMUYr3N3gdRDRErfrqp/k2RLV4h6q1+L8gsb9cwx2IiQmStH+iKywn+ZDtRW
 kF8K/HUCpIOFxvEcXh+G/bA7VTKXeD/gGUlL4t4oCx106UrfyggoZjiFtNALVPoeqTo8/d7qwrD
 FdiH3ow0WUm1soIoxfVqTcRYTOfmY=
X-Google-Smtp-Source: AGHT+IE4fF3kq/n/ITYyaF0i3fDRJGQxzMRGJbGUqrkhX9ZcIeiN4S+Ve+3mr9YqWHcQdqp4WRPqkLn5st6tVRtRizI=
X-Received: by 2002:a05:6902:1206:b0:e63:ddc4:f5a9 with SMTP id
 3f1490d57ef6-e63ddc4f8cemr2900455276.20.1741858579714; Thu, 13 Mar 2025
 02:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <CdUirikQxEto6yzkO-G-y6mmWa-ek5NZPN9K7EYvyeUAmnxuge6UmHxfp0tb580qFmfHacX5aWFLqrXjXAFs87nP14AZ72vkClzp3U3WBw4=@bens.haus>
 <CADg8p971xqUzCHhV_yZDXbn8OMn_V2DfHoVschZOTfx1dFvV1A@mail.gmail.com>
 <09712f67-51aa-4db5-bb7b-e1305c08d5f1@gmx.de>
 <i0EZ5kRllpIYtHd8QhvzuyTJDkJ2ZrHvCYibVvyxWKY6H-Z1m94rb8AmxFnzDCkq3qRgpj0B1k9S2ozXIb0wW5opuRORg-jS6tAskSfAihE=@bens.haus>
 <CAC_iWjJKO4Dkbd_x9==Cq=Kb4Cy9S4PQqz7d714U9ErWsdW81A@mail.gmail.com>
In-Reply-To: <CAC_iWjJKO4Dkbd_x9==Cq=Kb4Cy9S4PQqz7d714U9ErWsdW81A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 13 Mar 2025 11:35:43 +0200
X-Gm-Features: AQ5f1JrB6CdahGENQ4kQdnGtzwoks7o6uslECoAKuOgSWA6-0DAG85QfM5BnoIY
Message-ID: <CAC_iWj+R9VA9vNGM=R-UwJCDJ=t9Wa1A28Om4tAX48MmpnKcxA@mail.gmail.com>
Subject: Re: boottime->efi_allocate_pages() returning EFI_NOT_FOUND
To: Ben Schneider <ben@bens.haus>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Ard Biesheuvel <ardb@kernel.org>
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

Hi Ben,

On Tue, 11 Mar 2025 at 09:34, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> +CC Ard
>
> On Sat, 8 Mar 2025 at 19:36, Ben Schneider <ben@bens.haus> wrote:
> >
> > On Wednesday, March 5th, 2025 at 12:20 AM, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 3/5/25 09:13, Sughosh Ganu wrote:
> > > >
> > > > Can you check what is the address being asked for in the
> > > > lmb_alloc_addr() function.
> > >
> > > maybe also add a call to lmb_dump_all_force()
> >
> > Thank you both! This was exactly what I needed. This appears to be
> > a kernel bug in randomalloc.c which always breaks out of a loop
> > after only one iteration[1] which is unlikely to be the intention.
> >
> > Ben
> >
> > [1] https://github.com/torvalds/linux/blob/master/drivers/firmware/efi/libstub/randomalloc.c#L133
>
> FWIW we discussed this in the kernel mailing list as well [0]. Ben can
> you apply [1] and see if it fixes your problem?
> [0] https://lore.kernel.org/linux-efi/CAC_iWj+9DNswD7qCc7V8UxsAOaBTzx7QTYA7Yo8py5pEuHdWDw@mail.gmail.com/T/#t
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=446790

Can you apply https://source.denx.de/u-boot/custodians/u-boot-tpm/-/commit/b04e708c615c15423ffc80d73430bf2d36fb7c21
and see if it fixes your problem?

Thanks
/Ilias
>
> Cheers
> /Ilias
