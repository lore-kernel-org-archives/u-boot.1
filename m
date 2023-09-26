Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16386E7E65A
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 19:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5377B86BE2;
	Tue, 26 Sep 2023 21:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="mWOp/Zhp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DE3486BF5; Tue, 26 Sep 2023 21:06:43 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A30286B93
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 21:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogan.dawes@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bf298ef1f5so5889511a34.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1695755199; x=1696359999;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QbRfR2JYhZrcc21ikfKgvOJDYp/gMxup0NLv5tkGVvc=;
 b=mWOp/ZhpZftW8Rh/0rY6/yF6V4vonaXGnT6xXrQkg9lkb+0pkwNxvyJXPsi0m7/Iq+
 2HHO5S2/hk/YVq0REkOFwuT7ks1psnjaS10oMEEu5lMKEa3oFIqqT+y2z3fWzDrtwYgK
 TjwIIzE2gJCBB1FPWlM1EhelDC/IPwnFou/42rNxRy9IBBW8SWyHn5ma9tX4vfZ19Mkl
 +/5WxMHwu9or1y7ouSFq6HjyjWyS9G8hh2zhOCRovai8xgWBvBH8GS2kgx5AzCiBatI6
 95MSVFi2VUOWJl8NtzA93dGpYe74CUBWVh6kBiFukELA6Iak2c3RudYctQrZh1+/LG9V
 YU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695755199; x=1696359999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbRfR2JYhZrcc21ikfKgvOJDYp/gMxup0NLv5tkGVvc=;
 b=jsuLJsvkB50pGppiOepQwCtFbDPWcf6w74Uq8TOojqk9NmnTyxRFW+AKW3wp/qrY/M
 8+L2LSSqiA5CUbDYGQC+dA5gn4vhz5x99xMopnGh1S0mAzKbpt+/iolP3R294OJlrlfe
 v4VRIvMpSrvOVqIx748vhbulbDp7VymJjpKDFcpDp9qcVNHEYJGIvd4WUa5vIc87Xmek
 nYoWvQGpF7e1xQWuu/tt3ajQmUsxBuJjZqFnrn0ZQTqDlsTUk90CJzRD3UKa3CuxM+cH
 FGMvoDEu2NuVcaemeZTx2mh0WEk95smIoYN2EHv+nSwLgRDdQCqjGX9DOurao0B0qTjB
 oaxQ==
X-Gm-Message-State: AOJu0Yx3erbmHCYJobgncgdK5YWrzCO7pzRLeXxRGXCMHfhVhSy2WaqI
 Xp1zrgsnmY/XzD7M+wBI3zg6opdsMGj+3xAY6gw=
X-Google-Smtp-Source: AGHT+IGJHcVx0w2/9C1WWtGSNSx+6FLmcCgiS6Km7CQ5+ncjIZmxo7ZCOEQO18mDim4bJ66V9TizY3m/QnEgiB08wfQ=
X-Received: by 2002:a9d:6e0e:0:b0:6b9:b1a7:1f92 with SMTP id
 e14-20020a9d6e0e000000b006b9b1a71f92mr11993647otr.8.1695755199659; Tue, 26
 Sep 2023 12:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
 <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
 <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
 <CAOYdKdjPrRT7F_LFf8YeafX1MWep_p91CFdwc-SH8+diCu+2sw@mail.gmail.com>
 <CAOMZO5BzrfvLDrtqBk1dmLqb9-GxzZs8nRVY7GxqCRY34pKg4w@mail.gmail.com>
 <CAOYdKdgyXi5g9zPNOCBtsrA8KV0L1O0Oyh4Ne-Q79Z=EgGs=zw@mail.gmail.com>
 <CAOYdKdhvKEaeyv5zhXiswuF-Kd6ee8FmdN8MoMS9=5VTWVgMXA@mail.gmail.com>
 <CAOMZO5DS2VHPKvVioSW=7fWfnrP63A6wdga6pFmFuSK2QF8gSA@mail.gmail.com>
 <CAOYdKdjALruh9v6HBO-MSjzZM0whYhbA5YLJxbKk7yQk7cznGw@mail.gmail.com>
 <CAOMZO5AVuBxGFF_itcxvdG=W9JoRtyzzeeC+wji__uUOQirwZg@mail.gmail.com>
 <CAOYdKdingLtAvEnth8mSnazQ2fZ_kCsM_2P_dX7tbL2xe9wyVw@mail.gmail.com>
 <CAOMZO5ALK_O-648FaHFrjJc9EiU3J=nvv1rYDiLOGqhjt3mmkA@mail.gmail.com>
 <CAOYdKdjEOsLmkoJdxk1CmLk6_AJFZhuS_7fWxWOm14Av1n7gHA@mail.gmail.com>
 <CAOMZO5BEqwT+t7hw=neAfww_edg61cC6eggr9NNL3OS3jXOY8g@mail.gmail.com>
 <CAOYdKdjn39rV-z3wRf8tORvxP4riZaY0=POhaVjeGh2i3C-yUg@mail.gmail.com>
 <CAOMZO5CQrr8QzU2QArS7fTf3beNDxgLRNHNRJSL81gMUJ6NvBg@mail.gmail.com>
In-Reply-To: <CAOMZO5CQrr8QzU2QArS7fTf3beNDxgLRNHNRJSL81gMUJ6NvBg@mail.gmail.com>
From: Rogan Dawes <rogan@dawes.za.net>
Date: Tue, 26 Sep 2023 21:06:28 +0200
Message-ID: <CAOYdKdg0v6vshLY90MC2=m=HLm86e8ed8jgcWGja_w2bJMKmZQ@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
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

WARNING: unmet direct dependencies detected for PL01X_SERIAL
  Depends on [n]: SERIAL [=3Dy] && DM_SERIAL [=3Dn]
  Selected by [y]:
  - TARGET_IMX28WINKHUB [=3Dy] && <choice>

WARNING: unmet direct dependencies detected for PL01X_SERIAL
  Depends on [n]: SERIAL [=3Dy] && DM_SERIAL [=3Dn]
  Selected by [y]:
  - TARGET_IMX28WINKHUB [=3Dy] && <choice>

I also tried building and booting your latest version, but just got "LLC".

I'll try putting a logic analyser on the UART pins to see if anything else
shows up, but I didn't see anything else on the USB-UART at 115200.

Where are the LLC characters coming from? It's a little tricky to grep the
source for a single character :-(

Rogan



On Tue, 26 Sept 2023 at 18:47, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Rogan,
>
> On Tue, Sep 26, 2023 at 1:01=E2=80=AFAM Rogan Dawes <rogan@dawes.za.net> =
wrote:
> >
> > Hi Fabio,
> >
> > That prints "LLC", but does not print "Pref".
>
> What happens if you unselect DM_SERIAL like this:
>
> --- a/configs/imx28-wink-hub_defconfig
> +++ b/configs/imx28-wink-hub_defconfig
> @@ -58,4 +58,3 @@ CONFIG_DM_REGULATOR=3Dy
>  CONFIG_DM_REGULATOR_FIXED=3Dy
>  CONFIG_DM_REGULATOR_GPIO=3Dy
>  CONFIG_RTC_MXS=3Dy
> -CONFIG_DM_SERIAL=3Dy
