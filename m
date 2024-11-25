Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFC6D58D4B
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 14:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD2A89A21;
	Mon, 25 Nov 2024 15:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PENdtRKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A456389A2F; Mon, 25 Nov 2024 15:06:30 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA7D89A1E
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 15:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ea499f264fso3217994a91.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 06:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732543586; x=1733148386; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Uky3HI7f5akOdCue+TAbvQ/OHuKjWwAsHMkNKOxlaE=;
 b=PENdtRKwtAiGH8FYf23LoPY9Mbh64JBZ6htkB7Ta+ywAD8yqMSaqrYsYjnpY7mykD/
 L1hJ3kxU05NYCB3HoIVMv2Nf6R8FP3KVD/vZT5Rvdif1Saq4aMEmhOmtfHx12dBhWtcJ
 F7/OmHEtc6BE1hjZZKQe5nsfdfMQnZPdnbo2nBovlxE7ukNquX0NWDrHgHt+4r4PkBhi
 D9GGyTY5+TUVRoiPTfZYqLR3asnUL5OEaomL9VK2BvloPnRHA8yNZYr391FWPnAl7CGa
 TFR6/mBJz/DM7J8J8ZMbJkyqMRC/Ga4+naTgjFPBqUNk0qWnVeoyptJq295dsf688L+A
 3reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732543586; x=1733148386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Uky3HI7f5akOdCue+TAbvQ/OHuKjWwAsHMkNKOxlaE=;
 b=UMkvMcfxZoUHZotyCHIK+BPzi0VOR6Oz+rxLBeN7pZ0/IjyTE0pmmMKZxIaa/KzpA/
 YpFEP2w+LdfcpYzIzCl3ldj0cazUD0OISsWwj1Idv7juIUYES/gAe3w5qpZkl/bURLrE
 KGIERoac6qKBiUiuD5gtqdIqzAEM+2pg3RaTL4ZkM+SjX87K/KV9Eu/KhuPX5lEGQkkT
 WHu4AUYF8Ge8e6K0a52ATaip1tmwkDT9fB/kmDwtj7Kl4TnQx61tr5NSvuTmaQef0zlS
 2gOg1Hy00bQ4wER/2PfebCIQNnVNhGG2T+5gsWAO4bFLcSPx3lBbiXOPS3SUY9hlkmpK
 ITJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhBDs1kRxCNwFkfQIpUZg7bv8L6hIWLNcxXVStkg7u0na0MgrA6Lmdtr5fHgvcvMOZKb17wZI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+5DMZy0yI9z1t+cdu+25c1ejGxoVw3ykj4E0QKgrMaTw4Cejl
 b6i4Y7048/vdteO3k22OqJ8CMvB7P6qkTlf6QfVvyR8fcgm3FsQVPN5s5sn2OyhVszRMDHd4YfJ
 4ZfLtbPC0rx3VgwDZyVk73M179RzqiM3jlHI=
X-Gm-Gg: ASbGncs+oS2yY2eWfpwRPsMJ9g3w38oRyGClDEOGORQmTaiIStmHNF+zQtX6TCIHf/I
 aTGucrrtG6ZGKSwZo608reFWNRJolSDI=
X-Google-Smtp-Source: AGHT+IEAppW2O1LyZy4iFFSoVR0QSdLYV//SJ6aHFIQlLsL9+7FJYUYZGcMEyTLf0MxjMUcrrC1XMeO1jvxacoYw888=
X-Received: by 2002:a17:90b:4b0c:b0:2ea:a9ac:eeec with SMTP id
 98e67ed59e1d1-2eb0cbc715cmr19190384a91.18.1732543585669; Mon, 25 Nov 2024
 06:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20241125005814.236669-1-adrianox@gmail.com>
 <20241125005814.236669-4-adrianox@gmail.com>
 <d65bf941-7fa2-4ec4-82b6-b3ff70af653b@gmx.de>
In-Reply-To: <d65bf941-7fa2-4ec4-82b6-b3ff70af653b@gmx.de>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Mon, 25 Nov 2024 11:06:14 -0300
Message-ID: <CAMGU2hXFp5a8RwY8t1ATzMRQ-GRGbKd-XU8VvevoshAEQMw4Ag@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] efi_loader: device_path: add efi_dp_from_ipv4
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org, 
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

El lun, 25 nov 2024 a las 5:42, Heinrich Schuchardt (<xypron.glpk@gmx.de>)
escribi=C3=B3:

> On 11/25/24 01:58, Adriano Cordova wrote:
> > Add efi_dp_from_ipv4 to form a device path from an ipv4 address.
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> >
> > Changes in v5:
> > - Add function description to efi_dp_from_ipv4
> > - Allocate ipv4dp in the stack
> > - Make efi_dp_from_ipv4 static
> > - Remove u-boot log messages inside efi routine
> > - Change (void *)(unitptr_t) to char *
>
> Nits:
>
> uintptr_t
>
> >
> > Changes in v4:
> > - Fix memcpy mistake
> >
> > Changes in v3:
> > - Remove some unnecessary void* casts.
> > - Change sizeof(struct efi_device_path_ipv4) to sizeof(*ipv4dp)
> >    in efi_dp_from_ipv4.
> >
> >   lib/efi_loader/efi_device_path.c | 43 +++++++++++++++++++++++++++++++=
+
> >   1 file changed, 43 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_device_path.c
> b/lib/efi_loader/efi_device_path.c
> > index ee387e1dfd..96e72f72fc 100644
> > --- a/lib/efi_loader/efi_device_path.c
> > +++ b/lib/efi_loader/efi_device_path.c
> > @@ -974,6 +974,49 @@ struct efi_device_path __maybe_unused
> *efi_dp_from_eth(void)
> >       return start;
> >   }
> >
> > +/**
> > + * efi_dp_from_ipv4() - set device path from IPv4 address
> > + *
> > + * Set the device path to an ethernet device path as provided by
> > + * efi_dp_from_eth() concatenated with a device path of subtype
> > + * DEVICE_PATH_SUB_TYPE_MSG_IPV4, and an END node.
> > + *
> > + * @ip:              IPv4 local address
> > + * @mask:    network mask
> > + * @srv:     IPv4 remote/server address
>
> The return value is not described, e.g.
>
> Return: device-path or NULL in case of an error
>
> > + */
> > +static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_addres=
s
> *ip,
> > +                                      struct efi_ipv4_address *mask,
> > +                                      struct efi_ipv4_address *srv)
>
> Nits:
> scripts/checkpatch.pl complains here.
> Alignment should match open parenthesis.
>
> If I align it the line gets too long and I get another checkpatch.pl
complain. Similar things happen
in a couple of other patches in this series. I could move it a bit to the
right if you want.

> +{
> > +     struct efi_device_path *dp1, *dp2, *pos;
> > +     struct {
> > +             struct efi_device_path_ipv4 ipv4dp;
> > +             struct efi_device_path end;
> > +     } dp;
> > +
> > +     memset(&dp.ipv4dp, 0, sizeof(dp.ipv4dp));
> > +     dp.ipv4dp.dp.type =3D DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> > +     dp.ipv4dp.dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MSG_IPV4;
> > +     dp.ipv4dp.dp.length =3D sizeof(dp.ipv4dp);
> > +     dp.ipv4dp.protocol =3D 6;
> > +     if (ip)
> > +             memcpy(&dp.ipv4dp.local_ip_address, ip, sizeof(*ip));
> > +     if (mask)
> > +             memcpy(&dp.ipv4dp.subnet_mask, mask, sizeof(*mask));
> > +     if (srv)
> > +             memcpy(&dp.ipv4dp.remote_ip_address, srv, sizeof(*srv));
> > +     pos =3D &dp.end;
> > +     memcpy(pos, &END, sizeof(END));
> > +
> > +     dp1 =3D efi_dp_from_eth();
>
> If dp1 =3D=3D NULL due to out of memory, shouldn't we return NULL to the
> caller?
>
> Best regards
>
> Heinrich


Sure, makes sense

Best,
Adriano

>
>
> +     dp2 =3D efi_dp_concat(dp1, (const struct efi_device_path *)&dp, 0);
> > +
> > +     efi_free_pool(dp1);
> > +
> > +     return dp2;
> > +}
> > +
> >   /* Construct a device-path for memory-mapped image */
> >   struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
> >                                       uint64_t start_address,
>
>
