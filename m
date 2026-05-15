Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E31CD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF225846AE;
	Fri, 15 May 2026 16:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qp5I5TD0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5981B846B5; Fri, 15 May 2026 16:14:02 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42A5B84676
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-95ce7b777ccso558607241.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854439; cv=none;
 d=google.com; s=arc-20240605;
 b=GydXYGRf6ItaconNMLC6C91ew6EZ5OorJJX+XFCSkuq8IPZlvgiRnjXMQ6GpqYLR6z
 WoZIIOtbJAOV8MukgDouJWjaz0lyY1MsiNnqZGJG227qrWHF/Zxz5UkALPjkOS1xRdFr
 Dc7c/zC0bvke1/nailQf9KE7t3g69vWPo/1tX9dDHsxfodU3Tu3uRLwwQBBfwIFfWUkr
 mbaRXKLpPBaw3u2Z6Rl0CH+9wqUn9aiJRAnTQHMUf0CmtKOKfyCsNO0RV9psryo3sTie
 18GIxQKa+FojHs3eBG/zguPWplUc+RYhIpEkwOY1174Qs/S+9EYL1XdqSvg1h3/8rtvH
 lsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZKm4ASztNpQbyBN9RWPFOM1I+n2FlvIv0QAQsldOn6U=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=hykbrrR48VBOkfWgcZb1igYb0mHBsnamIz3KwNjO8FjfTGue2quC0GwwPxOz6UcKET
 e7geBjH8+Ha0OUnPo4O5SG1Gmazi6WuEN+THdtNk59pRtqekTBdFpG8HAU7+B+m+I448
 a/WnIQ/IOxMOTDnpuQvTLnz8XksQsvrthFU9XozKvrua2hAtkqSfkftkJY81RAKdI61A
 gQ2yrAATvRLG+0Cug6Oca9HP2vRaqo8gbJfMzAe5AgsJCY44FvtpX4JLTqhrof/11Pbl
 JZ/kn5WIZjs6T0BD0lmKgcmvpcXtTHX1bfzHply4G3eE88xsBYn2vK8QG65DTGVRpNhu
 O59g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778854439; x=1779459239; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKm4ASztNpQbyBN9RWPFOM1I+n2FlvIv0QAQsldOn6U=;
 b=qp5I5TD0B1sl8ghyqH1jhFXr0oljAFRkP55L9UOJUtBwbxlM/3UTcUdEifY3QkT27n
 10h7fLhonoYp2QFuLP7Cugse77EAa1+om45R0Qfv84/m0H6mm3v3mDP6M4QWuKsUrL95
 4SexKQB+PYjgRbIZQqkn9mdyTFq7s+ycql9hU0NBveo1z0BiptDTN2VrOV73xWdXWdPf
 apCqUtgnIpQ5oBEwFxk7x1g+yqEEmgHM7WHq8U+yrYac6U5XdqQmdANobovsH3NBePAU
 2MiCXf+WfV53vpUc4i6itJExG9GA8VjrmVBSAdzLrTU8qfaNo0MIMc5q1Q07PAWIW0wX
 d+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854439; x=1779459239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZKm4ASztNpQbyBN9RWPFOM1I+n2FlvIv0QAQsldOn6U=;
 b=jIU8MzZbHBYeJyFrP7xylNqOn9uJd7q3Eloakw5PJkNNQxgpJIgzdffFBUPYnSy9eR
 4F3TBTCySLX5RI+4KkdTtHIjw76UxDZTdlyznfEmjYsBWc5LsTfXTRYTbNHUtkpeNd7j
 U5ZqGVGZqiMWi0ZRp14mGgimnvSD9RCLv9y3GAPoyJdHhE9YvvpHGxrA5RLIO1KQ4jyU
 iQvqK44wBe4mtCS2boeuIFCYpys5w9uM9GrVzv+lK4RrDajhfaIrMUnJHy1Xt+6Ynw9i
 lj4XJwDtu7jT+cPOFIkt3FmSUAD5q7A5NvrRf9b4gZ/1t0z5RWSi6/sT5ZSONew7zGgL
 yxLg==
X-Gm-Message-State: AOJu0YxMPfjIfu8jwCY035BuPOb8N+ERbevG6Vvvc/eNXY50G6Pg8JrF
 29285054oBdVjNDsGVGonhvrdO0Tfo+V5Q9ahBSYKapktbyjdG6hEDpdBIjjjjygmv/JfpoYOml
 FPkO0BofaEipewpTKjrjFyL5ojzxSkRUtW+Ch
X-Gm-Gg: Acq92OGWD4lzv39n3xvxwn7FxXlCaLeuyaulgEir55okNCDXTCUxmTPLUF7QdJd2hdw
 o4llEwCB2WbM9bsHaxgePzoCmpuWdOzRsJIb7zhTHmOdnmvMlI1Fe53JQc/w7B6oKHhzLPWP2OH
 hrdfYx9hG0kX2Yl2GH1W4wbnMtiHJIi/ZZ7BRqtu6TpsN7tw52ppSwyDvHsMO6t/cYc4r/v5v9k
 KOI8LTiBkOosA3XK5xZ9atVHqBtI3v1WtjxOzu76ovXyGKOgtIYnBn4mkQXVXWVQmFQTfLq8U5Q
 asYZa2ae
X-Received: by 2002:a05:6102:3053:b0:632:5db8:f672 with SMTP id
 ada2fe7eead31-63a228c1c14mr1724276137.6.1778854439036; Fri, 15 May 2026
 07:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260514175457.4047707-2-trini@konsulko.com>
 <CAMDkj5xKePrX+Q7qhUq1KQpuGr6poyDFcdXxKnwhzQL8K9AJOQ@mail.gmail.com>
 <20260515141210.GZ1858239@bill-the-cat>
In-Reply-To: <20260515141210.GZ1858239@bill-the-cat>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 15 May 2026 10:13:47 -0400
X-Gm-Features: AVHnY4JnkdutudkPUhDGxg6ZChywEvmlEaf6jAvi2Ca74jFLoosEwKv_hwResbA
Message-ID: <CAMDkj5yZaBcNSo_Qfq7kaEP+4eiAwLCKsy0DJDXvpvk6RT9PhA@mail.gmail.com>
Subject: Re: [PATCH 1/3] bloblist / handoff: Make this depend on BLOBLIST_FIXED
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Fri, May 15, 2026 at 10:12=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, May 15, 2026 at 10:08:39AM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Thu, May 14, 2026 at 2:02=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > Currently, the only way we support passing a bloblist from one stage =
to
> > > the next is via the BLOBLIST_FIXED mechanism. Update the Kconfig logi=
c
> > > to express this constraint.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > >  common/spl/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > > index 5fa94098e498..cc819344cad2 100644
> > > --- a/common/spl/Kconfig
> > > +++ b/common/spl/Kconfig
> > > @@ -220,7 +220,7 @@ source "common/spl/Kconfig.nxp"
> > >
> > >  config HANDOFF
> > >         bool "Pass hand-off information from SPL to U-Boot proper"
> > > -       depends on BLOBLIST
> > > +       depends on BLOBLIST_FIXED
> >
> > I am wondering if SPL can use the same way as we did for Arm Firmware
> > Handoff - the address is not defined by Kconfig but via register
> > conventions?
>
> As part of future work, yes, it would be good to move in that direction.
>

Thanks. That is reasonable. At the moment this patch is fine to me.
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Raymond

> --
> Tom
