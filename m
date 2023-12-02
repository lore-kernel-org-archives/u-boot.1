Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321EFC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40C7B877D3;
	Sat,  2 Dec 2023 19:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RFs3NNs9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A84F0877CA; Sat,  2 Dec 2023 19:33:30 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1A12877D3
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a1b54b58769so7384366b.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701542008; x=1702146808; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A6c/k3qSXHF4IGb7BRMP7v4hQF/m4hj6YPhbH76EByE=;
 b=RFs3NNs9SEeDVguCzFI2XDUuhp5LOZyeXiCUh7meglHBXZnZGMQA8tvvVAFez6nFBD
 kndcJfaz6LIMuCtXpyJdvMMd0qTFAydiZplT1HCcrwJEJ4kcwYdwU2OHYZ5GbQA4JguH
 RUW9mEHUyBcB4JPuuvBKeCq7S7arghdAcLmgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701542008; x=1702146808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A6c/k3qSXHF4IGb7BRMP7v4hQF/m4hj6YPhbH76EByE=;
 b=qW+u/MmZcp2XWz51/OK2MMgCPvINSYbXrjh5xSM0qdl13MacEsAyRYdkyjwwMVrN3U
 aEIbvo+ZodEoEuCjaAN3pcGOO2zNQaXXeCMso0CJZ1sATye4Htl+sO4p44DZ6aWG97SB
 kQDSvk3Gjo44qnOwc2nAhkDakvHsI24kS90EMN3LgWVtOSr8RsUwZ26ya2cZOJ2zdW24
 x+IOxm1chv5wiroOks4/FRUW//8dDoL6T4Vr4CONEApw0F6Ya/PPhzXyYg0thGm3cYkM
 jjTi6CcTbq4aljNyHuDImncCw7G4XG2H7PDO5+lcrUqH6yVbfNFWUSuki4H+xmEs/347
 5RUA==
X-Gm-Message-State: AOJu0Ywcv6qEbIBYunECUhEwwUk8Ku8JizmK/dgv9Wv1LJj9dnENg5/y
 fO5x0yut58LnLxj9kjNFGBY6VUgOQUMtJ3OcxVJmmg==
X-Google-Smtp-Source: AGHT+IE6z+gc3ltEhuDIiRBhjlFbnunWgbfz5zt/yvHTmx8QSl4jk1rrErzx5Y7lXQ3GalmLK6uSa0R/edrPPBRP4U0=
X-Received: by 2002:a17:906:29c:b0:a19:a19b:78b6 with SMTP id
 28-20020a170906029c00b00a19a19b78b6mr996759ejf.121.1701542007937; Sat, 02 Dec
 2023 10:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-18-maxim.uvarov@linaro.org>
 <20231127181955.GO2513409@bill-the-cat>
In-Reply-To: <20231127181955.GO2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:33:14 -0700
Message-ID: <CAPnjgZ157AQPoLse4OyFq2CrBZOf2AQX=aqvyw_q+tQeDQCUcw@mail.gmail.com>
Subject: Re: [PATHv11 17/43] net: sandbox: fix NULL pointer derefences
To: Tom Rini <trini@konsulko.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, goldsimon@gmx.de
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

Hi Maxim,

On Mon, 27 Nov 2023 at 11:20, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 27, 2023 at 06:57:00PM +0600, Maxim Uvarov wrote:
> > Add additional checks for NULL pointers.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > ---
> >  drivers/net/sandbox.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
> > index 13022addb6..75d32db3a9 100644
> > --- a/drivers/net/sandbox.c
> > +++ b/drivers/net/sandbox.c
> > @@ -65,6 +65,9 @@ int sandbox_eth_arp_req_to_reply(struct udevice *dev, void *packet,
> >       struct ethernet_hdr *eth_recv;
> >       struct arp_hdr *arp_recv;
> >
> > +     if (!priv)
> > +             return -EAGAIN;
> > +
> >       if (ntohs(eth->et_protlen) != PROT_ARP)
> >               return -EAGAIN;
>
> This part seems fine.
>
> > @@ -82,6 +85,8 @@ int sandbox_eth_arp_req_to_reply(struct udevice *dev, void *packet,
> >
> >       /* Formulate a fake response */
> >       eth_recv = (void *)priv->recv_packet_buffer[priv->recv_packets];
> > +     if (!eth_recv)
> > +             return -EAGAIN;
> >       memcpy(eth_recv->et_dest, eth->et_src, ARP_HLEN);
> >       memcpy(eth_recv->et_src, priv->fake_host_hwaddr, ARP_HLEN);
> >       eth_recv->et_protlen = htons(PROT_ARP);
>
> How do we get to this dereference, and is that not a bug in the caller?

I wonder if somehow the device has not been probed yet?

Regards,
Simon
