Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2F0CCF9E3
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 00:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BD73839D6;
	Wed,  5 Nov 2025 01:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="loVAGGAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 543B4839D9; Wed,  5 Nov 2025 01:46:29 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 484DF83981
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 01:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-784966ad073so72873647b3.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 16:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762303586; x=1762908386; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbI4V5Bqw4eX6fGHZDXD0tODieeH4U3HrsM/GZRRw/o=;
 b=loVAGGAb7960WILLymU3x6Vkhow4LUhlF1kacWUwGDcfltI9rmmHNnMee/wDOcfDWc
 JgfNZgThFAAXVxn/TX10A/gCsFMEULyd6gtxx5W7iCu2lczbqQG8xCKx/vXm0rZAKp9x
 d83MGK82+3xeUEHSGyvo8wMu8AkCkW0RuToNYGUbDh0w55NAkn8urOjmnGJL1AGMazR3
 n+sgRYyUiVrWcmaasSwdBaDN02wPWjq2Z7/cEjesNaszy2bLQEmGMlXo9/OmdnbK1Phh
 9oQQ4nyMPMXsVyzgU01HDsuJMuRly0QPIK5paoD05VNdpXqa7bHshBNBmVxPTzUZt2ZJ
 BDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762303586; x=1762908386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IbI4V5Bqw4eX6fGHZDXD0tODieeH4U3HrsM/GZRRw/o=;
 b=oMOskAqdfTKIDiFDSt+nwJ0VURrMXNSggfvAezW4ekqLR1GbZZnMDYMmKi41/67Tfn
 JoSDhcSRhqdwGGdPDuqkfQ5PvziLAfj+Fm4gpXFspFv/ifXR+6TakjcZWoBf7RgLdm50
 lKBkn3i0TpWPHKdOhHgwA532YvJ20KmCh3GHyt+Et/5pyOrzKHPGHdncc28vqt+08Ypt
 pG3tE+j49O9X/kWj6zdJSnpFECwQ9g1qtIbhcOpufZ4FuXLhbTld5h0tIO5qMlKhdC3f
 oexJ63QRxlIsXwH0mZn2shGATq3+bT/4V8ksgJhH7HNvpK2IBPfc2VwG0gOirrobm1dd
 EgRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUGq2nCYsd+6kpP4Fsy3AOv0Qc6hVCdsHvD4UjV4pJa7uaPvu00wtdJaw2KIreXDvvy/Ls6QM=@lists.denx.de
X-Gm-Message-State: AOJu0YwOdhUu7I6CUJ3FW4I0xmY0B0xoH/HiDyLreImSBNPshb1i7/Ku
 EpoLWmOZjX50Tf1lt1FbjfCyrk3cARmw/sci1q13U15uK2gvEG99Aw1uPOCasV81f4iJavEXjhZ
 ysDTMKfHa/dM7/Cc62MHzeQ2Ibjzynu0=
X-Gm-Gg: ASbGncveivWRVh0WUZG3RP8QiYEbnhZXV1tOE9ZC0kmj1tyw2Tjumyy5Mwj3Th2opc2
 cvpXf2GVi12658glJeGoQPa9GO+nUDndcfxfzApyVpEakhIlFR7a0Y0VLuRIQiE2N4HXOwCdxOX
 Vpj/QY1TnGQpp2PSZm++w9x54SEdOob5DZQiPYrqYCwzCJsG9HXoTTtlt8xnQObipcNo6fYKlXi
 fw8G/pQJqsLI2SKtLDXPcuu1C0I9hJn8B4VlszVUKH4fsHTd1D1lxIUBVPn
X-Google-Smtp-Source: AGHT+IFw6dKHGHC/39Ft+ACX8qicfY4v3ZnWq3e6AvsnrTXXGfL+kLnVLXD9i2muggGvHkncFc54r1UrKEde6eI7z7Y=
X-Received: by 2002:a05:690e:1559:10b0:63f:b9d1:b152 with SMTP id
 956f58d0204a3-63fd34c52f1mr1272202d50.21.1762303586138; Tue, 04 Nov 2025
 16:46:26 -0800 (PST)
MIME-Version: 1.0
References: <20251104225404.49618-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104225404.49618-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 5 Nov 2025 08:46:14 +0800
X-Gm-Features: AWmQ_bnVgya9JDJhJF6UxUnYR4t0sQZVxPFDe5siod_6KmvMpBlFNUD8Q6Qgjwc
Message-ID: <CAEUhbmVNfx0FS7j3jVxcttermTVJ6owUkF=1F4s65H_ZREGQMA@mail.gmail.com>
Subject: Re: [PATCH 1/1] block: type 'to be write'
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Wed, Nov 5, 2025 at 7:03=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/to be write/to be written/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/block/efi_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

The commit message has a typo too :)

%s/type/typo/

Regards,
Bin
