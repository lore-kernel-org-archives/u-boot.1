Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF0CFED9EB
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 16:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7255784383;
	Tue, 17 Mar 2026 17:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZZkMhnfY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA9C84399; Tue, 17 Mar 2026 17:08:36 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D1C5841F2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 17:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-661be3380adso10788612a12.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 09:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773763714; cv=none;
 d=google.com; s=arc-20240605;
 b=HprPQq6Cc5+BmlQrypGB5Gwn/3o8UybA7BKwn0NN9ofG94L7aKapJu8aFeT0rWKbLd
 ilhMgD/xtkbFbNJoOTCEd12L22EwLJ+3jnaT/uJaVkpDhG9m/xqG/gIAZU8qC3Duz/2F
 xPW4ZItgKXO5yQUeBoi1r9xhMi9+WyxCLliQ7efI4uRNjcMbZeYydjrte2nlhe7nnkFO
 DQ9fCA4XjS9/yGFnG9K9Knpe85+dccQSqNVpZfwbwLwr46qN2TNKH4aSXbKekCh1Ontv
 86Z8Z2b3RTTH+mhH8wpZdPxH5H7b/U2UFn3jjBkdibg4k/rGJSSJV8t8aJBJUHlKXpfR
 4gWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1Ktv5AyMtmUiXwmnLpC+rs+i6YZLsUsJ/hQ5G5HF7Bw=;
 fh=zN4vWXJ6FaAWWZrs2FhdOzeUvaDqwQTt2jKQ+KjfPL8=;
 b=Z3vfURIt0/P7w6IKLrUbN+UFXVbmf69ZBGNxJQRTofN3zjXTRIHwUxEYzqK+Oa2Xa7
 ZFgy/iPYAN+rUayv3IoUjOcqbklT+aEBiWHsDErPAC341FpHvVurFFGjAHByj8BnjHRS
 h1YOjNEOdNT4k2dRKfMvyEkQ4fctLJS7ybupPXteAjdLZrIE+W9gxrwHIA7Y6H8U1ZTv
 TmA/xeg1csdB8cx2qe9s2EkCQpcsrx9SBrjYTq991gGA40Rt+GlkRv01AEhZs8+/4uvA
 Dt+iCpu+Yw/c3NqQyIY93Kzky0YwpsYuf1eGviHyHurctoSRP/6JT3tc5qhh06kYOwXC
 /cDg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773763714; x=1774368514; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ktv5AyMtmUiXwmnLpC+rs+i6YZLsUsJ/hQ5G5HF7Bw=;
 b=ZZkMhnfY5hWEYOZzPfbWLzj+TO66tHP76OiB6SXxhKe70HbWAi+5BZtwDKHcb8AREb
 cgeMWZdzULtVqHEiL1UmezeqYko4vV45UFetNpHAWvuUO+CqcO+F0JY/WBPNUsZLKft9
 F89a+PzKWQ+ULdwkzqOgvaUh3JH3NfN+XhFddhYxMVpOdR6n4ZYawMHf25Xjz/OkfY9+
 4Fh6QClIBw9GrWrmvqgnWEwWTmMcZ93qu8Bg5I0Ps9R9/xEbtrkCjKpTIpSLjX/3QS9M
 ZC171zX2kupnr4JXZSl+U5Hjukf8cP7mzuopkqznLinGcDWbaeT/e1zTXax3e75Pey2Y
 JsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773763714; x=1774368514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Ktv5AyMtmUiXwmnLpC+rs+i6YZLsUsJ/hQ5G5HF7Bw=;
 b=Y+UXlOgL+TAvYRsmB6AGo/XfOXMz4RspF4SfoE69Rx8NuQ+OPMh6kGQCwgD408rrcB
 2t3Ma/wfunRefgrWATiHuZ47Jpt7WsejeRY2e7DF6GLcpibiUjksicOXLvWqzG+5M4IU
 d5ReyXBdtSbyx+0FhDGP7UtC3WX12xoim/wsk8yh8ABY8laCy0TdLzq4Kx8cWkVBYN5H
 3kfrAYe58uHT0X2ESJVTKOp7ckIQAXQOkCCGC4GMkNps/WzfqP8yBJFhLGm/wvIedTvr
 l1v0+ibRkgH37a7tLnMuIBSuDXH0TSrWZgSOJy/Gkw4sM03OjZxg9f5ovKCHqZAyWVQ0
 wAUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTmTzZ/vZltDp3hGdaoGcCU9U2bMRHIJbvlKwdO7mw5P9ojcrPj884RkMaCmF+d87TpfIbEbM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7ECoKvn05Pk8ii9tADbbQoSed1L6f78P0uTlFsRB7/QuyYTLq
 uFrfeJZLQRlBNhsq2t+pVVdmCCJWlxXggyxJnonjIAS4mgo6WDJfg7N/JdMErdxLOeEJ/LaUuJ3
 jt2uOb5Ehq+oNJWqS359d9T/w0eqDha4=
X-Gm-Gg: ATEYQzwLsZaTaqcD0M3rC9KyXYM6OXFHmy1FQqvM1F9+6i8j1dmX7R0FTyXAadu8DPb
 dgnNcoz0Q0AsWY+0ay2MeKZ0MsmLCqbr6Z0fxe/xJZKF/VLP4WfzJWhI1MYRxauTex6YxKAyh/R
 sIMVa0OwGF55RE4jyW8UOXKcTz/b1Xc7R/U2hm0gRKCD6rVmOTuQhk5/Yfah46rFRZKDXdwBtJ6
 pYFnt4Vz5+rnM7Rf8nN+tGPIdP9dIlSE09LpffFTgvE83Hf5V9WDLGxPCbhJfs+JLw8qkDZVBlQ
 zZDm2Jou0f4L/iHwjZ+ZOKp0+zm73aLVdtaYPxJEM3zR+9WKMrCgneqHvh7B8f1AoGHlex3YeQQ
 7PkFy021Zj95vLfuhc/rE8pruJl04oft2VslkIJD6M2iCZfvqUuM=
X-Received: by 2002:a05:6402:1476:b0:663:b689:ca74 with SMTP id
 4fb4d7f45d1cf-667b2c1e685mr114896a12.19.1773763713716; Tue, 17 Mar 2026
 09:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260317012449.4162666-1-trini@konsulko.com>
 <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
 <9F36DE37-16FF-4519-9F66-A4A79F618794@gmx.de>
 <20260317134427.GU502704@bill-the-cat>
In-Reply-To: <20260317134427.GU502704@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 17 Mar 2026 16:08:22 +0000
X-Gm-Features: AaiRm50RTDp-uQt-DZTmRWnrtcqBwY5n4DS98A_nl0ojDS71RNxudQqUT5Efxf8
Message-ID: <CALeDE9MVgs--ABnZZ4RJDOnTLM-+imKxG6iJBGmQFHHXivLMxw@mail.gmail.com>
Subject: Re: [PATCH] EFI Loader: Correct dependencies for EFI_HTTP_BOOT
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Tue, 17 Mar 2026 at 13:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Mar 17, 2026 at 08:42:39AM +0100, Heinrich Schuchardt wrote:
> > Am 17. M=C3=A4rz 2026 08:03:47 MEZ schrieb Ilias Apalodimas <ilias.apal=
odimas@linaro.org>:
> > >Hi Tom,
> > >
> > >On Tue, 17 Mar 2026 at 03:24, Tom Rini <trini@konsulko.com> wrote:
> > >>
> > >> As exposed by "make randconfig", we have an issue with the dependenc=
ies
> > >> for EFI_HTTP_BOOT. As this is implemeneted by running commands (as s=
een
> > >> by what it selects) it must depend on CMDLINE as well.
> > >>
> > >> Signed-off-by: Tom Rini <trini@konsulko.com>
> > >
> > >In theory, you can configure UEFI with a set of prebuilt boot options.
> > >If one of them is http(s) the device will boot even if CMDLINE is not
> > >selected. I am not against this patch, but we will remove the
> > >possibility to build a firmware without cmdline that just boots to
> > >whatever is was preconfigured
> > >
> > >Cheers
> > >/Ilias
> > >> ---
> > >> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >> ---
> > >>  lib/efi_loader/Kconfig | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > >> index b5f81e0ff530..a9b2f813e1d5 100644
> > >> --- a/lib/efi_loader/Kconfig
> > >> +++ b/lib/efi_loader/Kconfig
> > >> @@ -600,6 +600,7 @@ config EFI_BOOTMGR
> > >>  config EFI_HTTP_BOOT
> > >>         bool "EFI HTTP Boot support"
> > >>         depends on NET || NET_LWIP
> > >> +       depends on CMDLINE
> > >>         select CMD_NET
> > >>         select CMD_DHCP
> > >>         select CMD_DNS
> >
> > Having to select commands here to get network is what needs to change. =
The network commands and EFI_HTTP_BOOT both should depend on configuration =
symbols for the protocol implementations.
>
> Yes. And this is about fixing missing dependencies, today.
>
> > @Tom: Do we have a target release when to finish the move to the LWIP s=
tack?
>
> We do not. I'm not yet sure if all the various use cases of the legacy
> stack are fully supported now (I don't recall off-hand the NFS series
> state right now for example).

I did see NFS patches go through the list.

I think there's also likely some legacy usecases where non parity is
likely fine too.

Peter
