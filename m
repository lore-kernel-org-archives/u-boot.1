Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967D5C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 19:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 260DB801F5;
	Mon, 20 Jan 2025 20:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bpMyeVJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7F6B8032B; Mon, 20 Jan 2025 20:21:18 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD376801CF
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 20:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaf6b1a5f2bso1142290866b.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 11:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737400876; x=1738005676; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bB3Ys3X0PUeGkdCEqxxWdxI2rJIWZtYXctD6zyp0upc=;
 b=bpMyeVJ9pLHya1wgk7ASD28oG7xTHAA82mWCEpV4tn0PsN+XMOpgYNXvBFv8KSaI0z
 E9oGqR06THQ2ZonPZVxMrv0ZOSk6D7uIuFnCMP29JTbUoumFxMlJwBhmXB0PZQEGObSc
 tzwlVPYV9C4WoWYnDsGzy9B56QxbmTOid9sOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737400876; x=1738005676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bB3Ys3X0PUeGkdCEqxxWdxI2rJIWZtYXctD6zyp0upc=;
 b=vG9zH7qDp71DCnBkySNqmvBePY+m8RvFhLTGI53u7jyqbpHRQzHXSG43Of3PhbahzR
 BGZGl1uDwqoLqSwp4TEms4VCsPdSourx6EN/G52YlNvLBbEWjmi8jKyEAOv0hn/IvnUQ
 UuUnJgKc0VtfrW3mWoMXS3khNHI/zJp32NwDmesPug7sUfsn+p1PNv1z2MpUDXB2Zv6X
 LH9zzaHvvfsFlvmdkoHSRHH1R178xX0exR/DF8g7eE/wnZWuUJQ7fyEeKnYGGoUHWDYr
 /wSsQHQCU+J47/a71P0ekA1vcbBBnxpMSrGPyPpVhMjLmT4nCSDyHbB2Q04T14MPLjxq
 hJfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBycgyyRQvOOaVr3zY3iou/nExxg2dir6v4bauwqh++vffjsCeGLdWkk3FjckyePdp9hDWkxY=@lists.denx.de
X-Gm-Message-State: AOJu0YyLXd4da65BxvoRysWOsZuDTl7oNm2D2yO5i+FZ50XBBxGSL6nS
 x0elUAkuC3sRG7OLt+ieXGyUNJ3j5AH0G/e6q0a2+qE6OiKaTzLxYgU3sRVr9xA3K5VZBGle3A1
 7EynanpZwBDgrRHRtIHONEJUjXRaWoOUU2Cn5
X-Gm-Gg: ASbGncutcCfPyLHVv+b/ixy8u7tmVtchc3Jx6t3i0vBDkZvp1QtWMvSkBgt1FEbiJqW
 B+/Q2P/nrYDlgd7TCz4nUYtnP+mYqB0ho8P93LGSGekNjFlpjrJ4x
X-Google-Smtp-Source: AGHT+IG/rwAmCsmIMWLFaLs3mBRC2wgcG9AG6I8JTXDqkWX7auKoV49MRxU2rejX+6mBnhHiTxLFKIFWI/3Wa1DEe08=
X-Received: by 2002:a17:907:3f90:b0:ab3:a4f6:7551 with SMTP id
 a640c23a62f3a-ab3a4f6a751mr873232066b.13.1737400876148; Mon, 20 Jan 2025
 11:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-5-d2c0acea6feb@bootlin.com>
 <CAFLszTinomkmj=gaKbX5WBPMsbr_3nxt45sQjXqKJ5q1rxcKwQ@mail.gmail.com>
 <87a5blu630.fsf@bootlin.com>
In-Reply-To: <87a5blu630.fsf@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Jan 2025 12:21:04 -0700
X-Gm-Features: AbW1kvb2XFmnH4ljee_h9v1JRMfCBMK5LbDVk776gcby0FV3FmpoF5KbvuVVyQo
Message-ID: <CAFLszThX2ULHHA1DOA-essfVJ_Fw=BgsR391iDT=bO+6j=UGwg@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] power-domain: Add refcounting
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Mario Six <mario.six@gdsys.cc>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Miquel,

On Mon, 20 Jan 2025 at 03:34, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hello Simon,
>
> >>  int power_domain_on(struct power_domain *power_domain)
> >>  {
>
> ...
>
> >> +       if (priv->on_count++ > 0)
> >> +               return 0;
> >
> > -EALREADY
>
> ...
>
> >>  int power_domain_off(struct power_domain *power_domain)
> >>  {
>
> ...
>
> >> +       if (priv->on_count-- > 1)
> >> +               return 0;
> >
> > -EBUSY
> >
> > See how the regulator uclass does it.
>
> I really does not understand why we would like to do that.
>
> It is perfectly normal operation to call power_domain_on/off() on the
> same power domain several times in a row and there is no reason to
> return an error code. It is quite the opposite, the main reason for
> power domains is to act like shared regulators. Se while a regulator has
> one user and doing the same action on it several times does not make
> much sense and can be reported, that is not how power domains have been
> thought about in the first place.

I am not aware of any difference between these two subsystems. If we
want a power domain to actually turn off, how many times do we need to
call power_domain_off()? The function silently does nothing in many
cases, so it is not deterministic. In the case where we *actually*
want to turn the power domain off, we are at a loss as to what code to
write.

>
> Hence, I do not agree with returning error codes in these situations,
> they are misleading and they would have to be ignored anyway.
>

How about creating a power_domain_off_if_allowed() or
power_domain_soft_off/on() or power_domain_req_off (for request)?

Regards,
SImon
