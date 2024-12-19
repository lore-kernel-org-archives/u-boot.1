Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A734DE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 17:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B860380196;
	Thu, 19 Dec 2024 18:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HfZpiClA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 486948021A; Thu, 19 Dec 2024 18:21:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC4638007D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 18:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetb@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734628867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FJpcGweYRMYizJfEg8lUXGsVGoOy6sYsUs9urD/OBw=;
 b=HfZpiClAJNF1GamxLlr/n6GVMKdkRHuBqsQM91eZ6Rkoix2Sy/4oazsQSQfupLjfSkmiF/
 OZECILNVKMV8QF3o7HOQLQHKb26xV7FD1doJUN/7Ftn7LhcnRBC1Ni86A6jUtBwDXgKsGl
 Dt9uiUPgVlvGOCvtF+lGs9j3U9UAF8s=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-8q0V7eeUNN-V0sEzG0BXFg-1; Thu, 19 Dec 2024 12:21:06 -0500
X-MC-Unique: 8q0V7eeUNN-V0sEzG0BXFg-1
X-Mimecast-MFC-AGG-ID: 8q0V7eeUNN-V0sEzG0BXFg
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5f31e3b6dacso64228eaf.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 09:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734628866; x=1735233666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6FJpcGweYRMYizJfEg8lUXGsVGoOy6sYsUs9urD/OBw=;
 b=RIqTVLlKnsiBIfPzoUPbIu3B6eoS2EuG84Yk+YbaclSTZ6twPVY8sqScEUdIzersRE
 nmBzfP4ln9JBUwFbTeS6rkK6+hrTlzuBEB3Hd3dLcMjwwwIj2bL+ztWq6YSnghKq/PEv
 AwFaPotb5gY5fFjAP6Q0SnwuvLUEcAiNN6q4+W9g0YFdVFVpZ/74u9zDsLcHqKhJud9n
 VyIY2D07JmuQubIxdRlPLRPN80xSWXTFf353L9dTqFzp/z5CxkWL4ZUygYasQ5ZEwKj6
 o1lDzxrCfKey4cyqaxOn3oN/zg1OzpPA2UtW9kQDOkyMjfwkeTQI6LejhG21uZrAVVlz
 rsMQ==
X-Gm-Message-State: AOJu0Ywpdmqdl5DUX9UBr/k1/+tYp6rfCmqKblrW3v+NH1IwXdqw3gwa
 cX44pSaNL/ysDGX1H7dMefp7D9xnboDRyVcpsWFjie3GkgQv/ZuxS5tk07xAvU9pM79fNXyAaLo
 hvQLNyz+WUfT1n801E+FmC+B87ZssT/P53QO7FriSOch3OTbRxnn75ON9UrPVbnEUHfCV2keLI2
 /QMZvjK0zx38IEeVoJMGGtaBIeQA==
X-Gm-Gg: ASbGnctF0B1BGgZd6C/foLe0u5RdlgtDyf8Tr1mBKpPW8W0IYxQWTSYuOYMF8M3fI1s
 mN2ZB8fOgP2VTwc1Tjo1HGSsx3mB1D6dJOzMA
X-Received: by 2002:a05:6871:33a5:b0:296:9146:f455 with SMTP id
 586e51a60fabf-2a7b31361abmr1324761fac.7.1734628865766; 
 Thu, 19 Dec 2024 09:21:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKCI7JIWNDR8Kl9n54YWxI6xthEoTjMYCNZeoRWMcHPCD0uYx6nn/BlkaIP8ktxvRJb+t5w8GtSPYm2R2+Mtc=
X-Received: by 2002:a05:6871:33a5:b0:296:9146:f455 with SMTP id
 586e51a60fabf-2a7b31361abmr1324754fac.7.1734628865427; Thu, 19 Dec 2024
 09:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20241219105303.6938-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241219105303.6938-1-marek.vasut+renesas@mailbox.org>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 19 Dec 2024 18:20:54 +0100
Message-ID: <CALE0LRumNO8vOUA+bjpn6NA-S6vnQVWmqsp-ppD4U+Z_KrgSRw@mail.gmail.com>
Subject: Re: [PATCH] net: rswitch: Add missing cache invalidate of TX
 descriptor
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cs66sy8Pr1GY7ZuRM5kAEa4zJTpyKTNQqE7kLwhzYW4_1734628866
X-Mimecast-Originator: redhat.com
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

Hi,

Thanks Marek for fixing this.

On Thu, Dec 19, 2024 at 12:02=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> TFTP transfers of large files, for example 128 MiB, can sporadically
> get stuck and the transfer slows down considerably.
>
> This happens because the TX DMA descriptor in DRAM becomes out of sync
> with the view of the TX DMA descriptor content from the CPU side, which
> is viewed through the CPU caches. In order to guarantee these two views
> are consistent, the cache over TX DMA descriptor that has possibly been
> written by the rswitch hardware must first be invalidated, only then can
> the descriptor be cleared and updated by the CPU, and finally the cache
> over that area must be flushed back into DRAM to make sure the rswitch
> hardware has consistent view of the updated descriptor content.
>
> The very first invalidation operation was missing, which led to sporadic
> corruption of the TX DMA descriptor. Fix it, add the missing invalidation
> operation.
>
> Reported-by: Enric Balletbo i Serra <eballetb@redhat.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

I did a stress test with one S4 Spider board tftp'ing a big image for
more than 1 hour without getting stuck, before this patch this test
didn't succeed, so

Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>

> ---
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/net/rswitch.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
> index 91e2c7b7845..259d584ac98 100644
> --- a/drivers/net/rswitch.c
> +++ b/drivers/net/rswitch.c
> @@ -836,6 +836,7 @@ static int rswitch_send(struct udevice *dev, void *pa=
cket, int len)
>
>         /* Update TX descriptor */
>         rswitch_flush_dcache((uintptr_t)packet, len);
> +       rswitch_invalidate_dcache((uintptr_t)desc, sizeof(*desc));
>         memset(desc, 0x0, sizeof(*desc));
>         desc->die_dt =3D DT_FSINGLE;
>         desc->info_ds =3D len;
> --
> 2.45.2
>

