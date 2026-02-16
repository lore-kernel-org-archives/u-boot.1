Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ECCE7BDA1
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 11:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796CF80FA1;
	Mon, 16 Feb 2026 12:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nV9EvDmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA9083AB7; Mon, 16 Feb 2026 12:54:15 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B358063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 12:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-38706f96202so18146651fa.3
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 03:54:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771242852; cv=none;
 d=google.com; s=arc-20240605;
 b=fvvjBD4mvhZ5n1qPGDBwtnrU1bIki7R4tZuRHZMVPFXWdw1sYdUrHI7RI7Yrj67GwR
 sqAHm0xLQwFxj86baH65uFv3lU6YTPcG6Rd+t9N8oZEhcmQLd1ZvraCrLSh2vuVO7DMY
 Wi9eiyFLFYoJU/bYkk6qv1N2deMBnYVvy+eqC05a4HJojoHE7N133BfRxIoXIH6LXJyU
 poYsqzieVEqDAIBnqLqvz6aIOCcHLiYtYFhM64YjEyqLCoBgKdUdwv4uEZ+QzZ2mGJIO
 izTJ4X+y3nWRUXsrKkVlbD+esvLLuSHyvwnmROVxLEfW3e1GoaZTYaKOkTukJ1iR6Nbl
 aCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tHHKGzr/mj5rzzDXRQTPfn1jX+R7c8qr3T2kx9lLq4o=;
 fh=dnxC08T5YtX7Sz3Ven3edkzZQyNDOTCG6TzyTHNA9t8=;
 b=JIfRezBq4KskjGKuWBBy0fT0nHBCGGfCgdw6yhH5AcpSmZnyUoINsT4A5mHJGnur1o
 CwaXDNXpiSCrgbCSExgDq7NzJf/L0NXPtqvfH78+OgvzBGRlt5nQwxVZBjpzSFrzw3dg
 i73WBNCcOq4LmAZsAa6t7h3wyu0qU+ib8h/qAr4WQgmOgLBR1OG9eTmpaRmu66zpU0IR
 g8CjBZyrSovqvrQA6HGT6tBjJb/2lzCE8gidFhOnfdrx26Lk82SXXzr/BS+GjtA+x92v
 sgxScGs3LCbYuUQ1dfiHPJKAb56TGE2my5SJktv7LqZjIs60vTbQWHl38QsthEHf12Gm
 0+Hw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771242852; x=1771847652; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHHKGzr/mj5rzzDXRQTPfn1jX+R7c8qr3T2kx9lLq4o=;
 b=nV9EvDmdko0/dfYCJBDPJYRwlfvk1RiVahtzrGEY0U9WuCCJKlk6VRYvzcl/LZPMNO
 nvBWuEkesmah5h/BmJPnbwUqgbBvah09l94uqdHsjw4m9hDzIGT2XgeuZSNO7k4yR5cF
 tPEovWreUGat9J6xEqS8HJJMfA/mAGg5Sa16tcxpruUSjNSsvR3rExI5l57V4nIq2GOh
 zM+jseo6+f/UgEpoRe0CXqsy06NAjKTG10SxBelJmf1HxJHhZJjN7qu+kUhjzSfFnHET
 ea3th0RwFIE9Rhae5JZ2RQ4FXdHIZ8ELMNXw2w8mAyDruy0XHNvsBAqW6RscPf+gajmr
 Z3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771242852; x=1771847652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tHHKGzr/mj5rzzDXRQTPfn1jX+R7c8qr3T2kx9lLq4o=;
 b=VLSuLWrOTkFA5GgAtSUoUb3rp0nPBRFlnI8YxxBKuYVNccSUbbalALnK2eDZKhpIAL
 hj5Ba2XYtzJ2t2PpJorMjkDMw3kenRFN72JkDJ7cIIAmO7hHxIiapKIDw5DLiBb0r705
 GB7dgmffLBCdrNA+l3BxvA9BGXqoAcpkXzaavOAj9hwEQHxPAIWwcTbCgBWqi71tRHvD
 kE3Mf0GjCozOT+YJNfrIS2TdUPj9fobyzSlPvxB2ELgCKjF4DY80ZcNoJ+5uubYMKikt
 tTer7xiichxx6QbwAqyLL5kplVclhNeNJlpmf/s3SlcUY7TL+Q2dQMmELMIL84utoo5o
 1Yng==
X-Gm-Message-State: AOJu0YxsBp+zkMsjRHUts37ChHsIxLDJoEuH6gPghGnNUOBGOvNK+HOL
 McWoWhe2/AZBkhgDumNuvnC8ZsU4QtCrpv9tqqvzbjdxv3zjkucmxBUczjms6IGbmbR6IkTA0IK
 9FtFVMFNDK2l8RsJX9ybUrVR3VFJ+dNA=
X-Gm-Gg: AZuq6aJcNo7BDHfUCuY3KQCpmWtdje+ne+fD6KqWbDZ2V8lOQQbuJ6xN6ctw85YA6zY
 lsf9+pw0hkH+iAS2S0Er+gB7y/Wz3niSKbrhGYE46Eryf09SqprK/xsyIjiznRHKoT93kGt8uSF
 dX/hfYMqShvZf7waehJPExKZxGnsCyOYCyfeiVCLsHGuWHD2bmTWyY8apCT+mI+l34SOXOe4n8+
 rheC+qK83K71i4XWvW79WMsXAuLljvxlFXemgi4elYw/CmBImyRJwDP17UH2JlprCuVYqa/HGoC
 3h5MLniqNG2GTF1rysgm82S/S62LNJjXhbIWnO6ECq3optRuK8uNBmgKlv9AiIohqDjt4w==
X-Received: by 2002:a05:651c:b10:b0:37a:34e2:88e7 with SMTP id
 38308e7fff4ca-38810570813mr33275521fa.22.1771242851576; Mon, 16 Feb 2026
 03:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20260214045703.28051-1-hs@nabladev.com>
 <20260214045703.28051-6-hs@nabladev.com>
In-Reply-To: <20260214045703.28051-6-hs@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 16 Feb 2026 08:54:00 -0300
X-Gm-Features: AaiRm50eMREeKWMVI3LabrF4yfLwKa-FSSJQBJFrMcrFTXzYtRwo-cl4_qdps5k
Message-ID: <CAOMZO5CeuGSdHMaFy5dvSHF=5xt0hM+Xb2GshafXJ0QuwCj-Ug@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] imx8qxp_capricorn config: add wget command
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@oss.nxp.com>,
 Walter Schweizer <walter.schweizer@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

HI Heiko,

On Sat, Feb 14, 2026 at 1:57=E2=80=AFAM Heiko Schocher <hs@nabladev.com> wr=
ote:
>
> From: Walter Schweizer <walter.schweizer@siemens.com>
>
> Faster than tftp.
>
> Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>

In addition to the other comments, please do not add a blank line
before your Signed-off-by line.

This also applies to the other patches in this series.

Thanks
