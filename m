Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8483D711A5
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 14:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B15B8934C;
	Wed, 20 Nov 2024 15:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RwA7NtQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B0E889229; Wed, 20 Nov 2024 15:55:48 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 681D68932F
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 15:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ea379ef02fso1760736a91.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 06:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732114544; x=1732719344; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cQNSa52r9x4pAoZboxXxUnhUYKeQxWlZrqe/k5eT5Ho=;
 b=RwA7NtQBxmZQT3T8+j/URwe6idHVIR3HzTqqK7XHfVCo0A6yHfdJ7QmgPjdq/hC7QJ
 MVsiKB00jYJAj03J5+tB4MOow643a2eUyjOTyPH/yjRek6kX/NhNeV6RTPZo8Gx4lD0H
 PePXMo3QXgpwy0H4aclcSvUQ1dRnuFQnQB4AHQpK8hU2hbrU+Ii5pGNvzqTN+m5AiDZ8
 zUkXVY3cy5htyXKjQMWW9Ww9VOZEfGTRLmFjkCYmrurL8gWEDDcW1g4xTaJI16U5zNCP
 MBtMVpv9LK9KYCsOFsvBSXHufeMFd/VIit0kb4z93iUGaQ5kmoG8MGuR77cJpL5VJYjR
 0TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732114544; x=1732719344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cQNSa52r9x4pAoZboxXxUnhUYKeQxWlZrqe/k5eT5Ho=;
 b=tXXbp9H+z6JfErg1Ju3u3s+BMWBoBtRRanYtp4nHKhjOTMgqnF7+Hv4+l38L9MFDPC
 W9aJQJrSwen7b7nd8hy6VO7hMjndjsiVOvAjcly7qALXQnDxVfRPM6DqXSxqjN1GCwIN
 B9pNDEDWh/PmA3JhdXVCIyjFDd4TebC8SMn0RqkjKbIkVezuDLHFoU2hdVO1q1+l4kNV
 bgNg0UgGYFSpbP3f92WLX8xJJt2VE2OsHXrolu5lrAUCO+f56YX/fSEmvcho62QIzojj
 WU8eUJ8JAkxwujhUF3QfBXRdSO6sGeBykwU8vpNWLgRpEsUvfVl6rCAH1N+hDepDeiUG
 dxwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUYDNTj5zn1LtHclAoPApQ0Gf4deEwyjg8eT8+MSpkBb6I2PfU7N6bhmazGJoylDj85ptw4Z0=@lists.denx.de
X-Gm-Message-State: AOJu0YxwoOSrpk76774cMFT6HqGMOpx+2QC1N2eN3m1XMTw7iz5VPtTM
 Opc8ygVLGoYoHj/e/Pi5QwZRpzimA4wQVQSjLKJlFGkDHhUv5Y5Ug9zLA/U3fapITPCHV7oDoDx
 sZCzuvZLUjXNdD2/NvxUOjPUVRyw=
X-Google-Smtp-Source: AGHT+IHOo3srLgLsD5ozdNa9zZ/+sWdZtfV2S2Xq43WKcqEuAw9lYPPr36hYsFdASSp7CzkgfTuoHud0fPxBX/jvDjU=
X-Received: by 2002:a17:90b:5348:b0:2ea:4578:46d5 with SMTP id
 98e67ed59e1d1-2eaca74e9c7mr3154008a91.21.1732114543862; Wed, 20 Nov 2024
 06:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-4-adrianox@gmail.com>
 <eed3b936-a54d-4881-8f2e-534bcef34535@canonical.com>
In-Reply-To: <eed3b936-a54d-4881-8f2e-534bcef34535@canonical.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Wed, 20 Nov 2024 11:55:32 -0300
Message-ID: <CAMGU2hX1WtZ4xzMUiMCcGGDm2Kjzx-OPOJs=bmqngHkBZci1cA@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] efi_loader: device_path: add efi_dp_from_ipv4
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

El mar, 19 nov 2024 a las 6:50, Heinrich Schuchardt (<
heinrich.schuchardt@canonical.com>) escribi=C3=B3:

> On 18.11.24 22:08, Adriano Cordova wrote:
> > Add efi_dp_from_ipv4 to form a device path from an ipv4 address.
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> >
> > Changes in v4:
> > - Fixed memcpy mistake
> >
> > Changes in v3:
> > - Removed some unnecessary void* casts.
> > - Changed sizeof(struct efi_device_path_ipv4) to sizeof(*ipv4dp)
> >    in efi_dp_from_ipv4.
> >
> >   lib/efi_loader/efi_device_path.c | 38 +++++++++++++++++++++++++++++++=
+
> >   1 file changed, 38 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_device_path.c
> b/lib/efi_loader/efi_device_path.c
> > index ee387e1dfd..cdeea4791f 100644
> > --- a/lib/efi_loader/efi_device_path.c
> > +++ b/lib/efi_loader/efi_device_path.c
> > @@ -974,6 +974,44 @@ struct efi_device_path __maybe_unused
> *efi_dp_from_eth(void)
> >       return start;
> >   }
> >
>
> A function description is missing.
>
> > +struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
> > +                                      struct efi_ipv4_address *mask,
> > +                                      struct efi_ipv4_address *srv)
> > +{
> > +     struct efi_device_path *dp1, *dp2;
> > +     efi_uintn_t ipv4dp_len;
> > +     struct efi_device_path_ipv4 *ipv4dp;
> > +     char *pos;
> > +
> > +     ipv4dp_len =3D sizeof(*ipv4dp);
> > +     ipv4dp =3D efi_alloc(ipv4dp_len + sizeof(END));
>
> ipv4dp is a small structure and is freed below.
> Allocating it on the stack would reduce the code size.


But as it is a device path it has to be allocated contiguously to the END
node, see the next lines. It is then passed to efi_dp_concat where this is
important.

>




> > +     if (!ipv4dp) {
> > +             log_err("Out of memory\n");
>
> Writing messages inside a protocol implementation should be avoided.
>
> > +             return NULL;
> > +     }
> > +
> > +     ipv4dp->dp.type =3D DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> > +     ipv4dp->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MSG_IPV4;
> > +     ipv4dp->dp.length =3D ipv4dp_len;
> > +     ipv4dp->protocol =3D 6;
> > +     if (ip)
> > +             memcpy(&ipv4dp->local_ip_address, ip, sizeof(*ip));
> > +     if (mask)
> > +             memcpy(&ipv4dp->subnet_mask, mask, sizeof(*mask));
> > +     if (srv)
> > +             memcpy(&ipv4dp->remote_ip_address, srv, sizeof(*srv));
> > +     pos =3D (void *)(uintptr_t)ipv4dp + ipv4dp_len;
>
> Here you
>
> 1 - convert ipv4dp to uintptr_t
> 2 - convert the uintptr_t value to void *
> 3 - add an offset to the void * value
>
> In the C standard adding an offset to a void * value results in
> undefined behavior. Unfortunately U-Boot code uses it a lot.
>
> pos =3D (char *)ipv4dp + ipv4dp_len;
>
> is all it takes to have a defined behavior here.
>
> Best regards
>
> Heinrich
>

It was originally a char *, I will change it back

> > +     memcpy(pos, &END, sizeof(END));
> > +
> > +     dp1 =3D efi_dp_from_eth();
> > +     dp2 =3D efi_dp_concat(dp1, (const struct efi_device_path *)ipv4dp=
,
> 0);
> > +
> > +     efi_free_pool(ipv4dp);
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
Best,
Adriano
