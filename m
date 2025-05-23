Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE17C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 20:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 366C78338C;
	Fri, 23 May 2025 22:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NZojICFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DB2F833B3; Fri, 23 May 2025 22:20:37 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 893438334D
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so36130566b.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 13:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748031635; x=1748636435; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wx1NygAtK2ngHI7QhihWoLi/xdYaN3E653ZfL6CgQpc=;
 b=NZojICFyb05yLwj7EiNn2YzSn2jnyeOAgwVFYLDS49sob6tKNnqTMh0z/W5jwyQwW4
 qGiSd+FLaZGxmmIEigs8GiWpwjmPiGS+9QEcr4Wyw3I0jEfoiuCaJBnTvixOjsjyNruV
 CMJoW046r1ukW5NefMPTWUPDr6rjAERWv6wos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748031635; x=1748636435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wx1NygAtK2ngHI7QhihWoLi/xdYaN3E653ZfL6CgQpc=;
 b=iYfOa9xU9idMocpu3KimQzCl6PZoyp3CyQZY2OXAg6DEDKp1k3Etk4DY0c8B2SesT4
 XICJm/5r8lxco9D2Rmr4pBN0HDnCtpv7BeVUp+xFBRMZo8TD/8qgw0lJta8bI/eq+rRU
 Vl1SoCNPooH4p+MrkCcM6h7SgfC/MSG/cPF5IICaVRuy131cUjnp82U3JzPA56nundeO
 zuNNPZRiPai3ijk0Cz5muFo8d5cVLifjXvIcTQa/8xvnLshKrJF7orPa83NtF6Csk2jS
 rZCKR70TAj52WwnPnLwH9rH5AMQ86m6AXgUFeYkw8qRZuUs1JcmGUoO3NM4I2dNqQN7i
 46+w==
X-Gm-Message-State: AOJu0YytK14z3snhQDkva2p/5espdyU9dbKWSYtrP8dq3UzLJhZEOwIK
 wvt7EVfLL+4ir5dcWxkaW1UmQUnFX/FY1OMeQlg1ZtWXRDsSmQSFNRvHinsDsTj1AgwxC/Dvg8w
 tEQkjjX8Lb5HfwWe7YYJDMEX7fA9cUJhQMvSOay7Q
X-Gm-Gg: ASbGncuPA0fPJeK4B7ztZbW66jSjFu78+dRlwN9DBnSEtrs49kooHJNd09JLmelUDva
 ze6tLC1i6ma2TZ2xmtjJ7kiVEXtbLEVu3EZfCtXs4dRVKIH/vFp4CbnwWG9HiPx76n5jPLPgm7G
 Zwde4s0fyZsW29ZxbGnJSlUAFSUY0G1Dg=
X-Google-Smtp-Source: AGHT+IGaJq7iWGpdoFEqYBVrHSK1sINpiCyX6W8zIUQC2zB1fPxIpxsRxcQ495hmhYY2FcBBpwTNejdT9KKIkZopX6I=
X-Received: by 2002:a17:907:96a8:b0:ad5:ef0:5724 with SMTP id
 a640c23a62f3a-ad85b19f6d6mr42487666b.34.1748031634937; Fri, 23 May 2025
 13:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250516125430.1361912-1-ravi@prevas.dk>
 <CAFLszTjHnxzTxGUVOkTBo6CxoZc3DxO4q8=R8_Y847g_WHWM1w@mail.gmail.com>
 <878qms51zp.fsf@prevas.dk>
In-Reply-To: <878qms51zp.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 May 2025 21:20:22 +0100
X-Gm-Features: AX0GCFsvHaNs9C4tENR2UAt57DMHINyb-jNOEgEKfbF7yTU_WJccJNuJOG_KiVQ
Message-ID: <CAFLszTgZgXX=gogi7x3+84UReWC3PM1=QKevNPO-6koTV16QRg@mail.gmail.com>
Subject: Re: [PATCH] mkimage: do a rough estimate for the size needed for
 hashes/signatures
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On Mon, 19 May 2025 at 11:28, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Fri, May 16 2025, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Rasmus,
> >
> > On Fri, 16 May 2025 at 14:54, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >>
> >>
> >> While not perfect, we can give a reasonable estimate of an upper bound
> >> on the necessary extra size by simply counting the number of hash and
> >> signature nodes in the FIT image.
> >>
> >> As indicated in the comments, one could probably make it even more
> >> precise, and if there would ever be signatures larger than 512 bytes,
> >> probably one would have to do that. But this works well enough in
> >> practice for now, and is in fact an improvement in the normal case:
> >> Currently, starting with size_inc of 0 is guaranteed to fail, so we
> >> always enter the loop at least twice, even when not doing any signing
> >> but merely filling hash values.
> >>
> >
> > I have no particular objection here if you really want to go this way,
> > but it seems to me that it would be better to have a way to determine
> > the size of signatures using a new (or existing?) API call. Then you
> > can make this deterministic and always correct.
>
> Well, I'm not saying I won't revisit this at some point in the future
> and improve on the heuristics.
>
> However, as indicated, it's not just a matter of knowing the exact size
> of the signature data; one also has to account for the space used by the
> "hashed-nodes" property, which of course depends on the number of
> elements in the sign-images property, but also on the number of hash-*
> nodes in those "pointed-to" images. So it ends up being quite a lot of
> code to get it more exact.
>
> So yes, for now I would like to go this way, because it's a fix that
> works for my use case now and is easy to reason about, and should also
> be an improvement outside my use case in that it avoids at least one
> iteration, but possibly many.

The 'right' way to do this might involve converting the APIs to use
ofnode, then enhancing ofnode to support tracking how much extra space
is needed (instead of actually updating the fdt), so you can then set
the size and do it for real.

Anyway, you seem keen on your current approach and it is better than
what we have.

Regards,
Simon
