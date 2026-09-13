Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33B7C88E5C
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 23:21:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8C3680D2D;
	Sun, 13 Sep 2026 23:21:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VNQvRmQ21qL5; Sun, 13 Sep 2026 23:21:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CC3DF80D4B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789341623;
	b=KfbvwK5/ZKRIvXWVF1lHORrVmJs9TWwqRpJlfcVzmX2iZcWZoG1tN/A7TQzK7h2ErIjS
	 OlKKdU7XtnmmY913zNRiY1CTJPv9XeDkb6IVBkLqch7RXa/fHnjoaLa9SF2bDSMktBC/X
	 /DKSHRbx3JlCyfY3KaNpti7cewMXdou6gW8Hd0eF/LXGvtxpZQp8oxnXMPAzOdIpO+Utv
	 VcJrMnR87wxYx7qijKI7ZKF28tjeB2oHvF/rMdAOJYxBTkmgoirZUILdzVvOy+IpnD/lw
	 L9z/b2Hy4mJNlQ7Js0RpOWI1cGkVWxWlyJz8sYyQgsdI3+yuC7HvcBnndVjuEYW5YOQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789341623;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ja4gy9bM3MSnu3e3kwLdSiJg3jbn7lEXKz0erDP5BvA=;
	b=BJBsau9J+RVrfxzquPZCZW2PJXzfQNgH5pLiFJZx8Y/ALgCI8yS5T4+dP0pg8wNFSbRa
	 RgjbxGW87Alxi9TKQKPnV5+QcEzLu/dgI4d6Q9dn9ybWaMQDYy+p4F1p5F3YueKFfdEft
	 au+O4F6VoPMJMg6Q4DYEAKCme6TYOXpKjQQc0pZuum0jvZR6A0EGH/M5b9yfKRqndprla
	 3cj/r3nnHRMWmwqr2Eju/CjKUJFqkmRsAgiMwErL48kKj0ZfH3SveLyryHk/gaIVMx1AF
	 73VghLxUUMp2SUEHJ1FgSvHdgg0Ezoemm6gK6BwMqc3Q8rKfSKgPJGKvwj78YmthnVA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789341622;
	bh=ja4gy9bM3MSnu3e3kwLdSiJg3jbn7lEXKz0erDP5BvA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vqySY15CWkn2SnJJJP94tPcQWWmBHuobuH1mzKsFlGmS2mfd06DPxhjs8Cz8hWkwv
	 hRjuHdARMYNZpvFfS9mK5419WDiogrkOxLGfSIZJ3lWHru3QfL+l5i7FGeNAb0vJ7s
	 LHqDW/uDpSfOm9fT4schyjipn8HTNFh04KIJjhV9TNRd+rHca091Du67KTJvBUujmZ
	 vZJTltzxEdXrzYN6d4/kJu//V7aAde+IRM5QnYr3FmyWqdKvxTTc9LSeMeVxkZ3Ybu
	 x+Hr/dd5xo8yv+tc+RZaFJHNsatJilIRPZD1if5mVGIDJJGVYp4JOTrR80Rkvi+RXd
	 uDdOZ5gKQTsuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC3DF80D4B;
	Sun, 13 Sep 2026 23:20:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EF3D53AF
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 16:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D5B9640076
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 16:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V8vdT_MM0skr for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 16:24:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1F44C40022
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789316684;
 b=VtEitzfU1HRVq0yNqniEu6IhA0j2NYekmY1cxdZLBndJj2Sj7AUfuhoCqF7SgIbiGS0W
 y4TulBeb3FdepsRXI8xN9GVy9F1FEc1YMkUAIQViXoJkgn7NTm/8XWkSrQ9/JKA75VGEB
 ai63YaVwC5l2sVpG2wrpPFzxrPZZTar5NTG3MgF2qDntMLqPaT7Zu3lu9taOVRg7hjYQx
 7lRhrQvOBujM+lyVCYEYRUno7nyDt+S5Y6qdx03O52xBg1DUDqiTj4+JW+n2QKIZQGzoS
 ERjXJEHw9EVUw3A2Vf3lZHUoSv825xykC4fRCrpR5IKzLND86vcDbhdwT/BzQoYgAMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789316684;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=ja4gy9bM3MSnu3e3kwLdSiJg3jbn7lEXKz0erDP5BvA=;
 b=D2OMQkn2ZsKSzq3NoKlbgWFLi6vU74QZLi/PLwN8fTcys8m3M07ApzuKLfy7dI8Z/ue0
 NOAF2iGFDQphNl6n+Y33EorOIb9/RG8TMA/lF+qiXVx3PJXl5sHC6kA1usTVsCMQYBT6Q
 QZGS47kYGoDmmHwlnWvh0i+LpATYMf56gdhM8VyGDFHBstYY18Aok7uclRzaV0b0mYnIu
 Qi7rkNtd0tZSUhQSTCc3f+OOHJPmDQBrD7p7mjsDf21wZ0crHMFxONxrghwLzN3KavJWV
 weJurAM8+rCM6Z0ct0mT1YVP3EKA5SfuKn26Mchd/6uHtMTfk2ibIkqmhuRJBkpJsnw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ECCr7+lE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=aford173@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ECCr7+lE
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F44C40022
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 16:24:43 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a30eb3bso945155b6e.1
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 09:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789316682; cv=none;
 d=google.com; s=arc-20260327;
 b=E6UJMUDWNz8A7tQVLDe5K1qzczFZur0V91h7pzSxpjvWQiRKPPp59DpacBj8YvZutF
 PbniMbSw8W6lIXGTk3aVXvauKq09FJ8nLAOe/E4TMVZWxSTuaRMjdY/fbiwHAUghIYfP
 42thr9sO0gHH7LYyJdVEEnB/SpnkHF1x5ogP0Af6A2UVPoSBQNWLQ3JHwm1YHhFIKm20
 rJCKG9+AUe877oE5m0PCoccubEAQZWKT4htx94x6UaOYCDxRGifIF8xWrSUqYdwuv3kr
 iBavjQWWtznIiY/inaT8NRw0SmOUrAyIIsRkxc/QAOQcsu3Lq7DJlZ44Fu6aDIFpOw82
 VgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ja4gy9bM3MSnu3e3kwLdSiJg3jbn7lEXKz0erDP5BvA=;
 fh=MhcknzA2QyC76p/3rcOfZBYuve8eRX/xyGV8pGCNG3s=;
 b=FZvpCoHRsCUIFrnq4wVDx7yZaGnBg7/X1gyq9GXluiOpDMjAb4xUbQfl/6oN+p8zeK
 qb3EVkMBXHUKJzk6/4qS9oSVI+FU9yCM39uHAs+izpneijVGH04XOhpriLzFBhRYGiiU
 +zh4hOUk3pWwX62PCLn9Q+qgzSkZmDzI8wRNAyf7magOfilmd+umLINtqiks2YM6J1pp
 C050NT4Uf46YluhcmM9RMKe8lToLOv8fEWXmstuDAwifbkayA0c/QrjkY0pqj7vMd5pJ
 EZwWEf/pvN30O6Dg6UxAj9RoXAwTFbsfP0Ob/0487WSCis7IjKwB8RVIUrNGQS3ZOuk+
 IBsA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789316682; x=1789921482;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ja4gy9bM3MSnu3e3kwLdSiJg3jbn7lEXKz0erDP5BvA=;
 b=ECCr7+lEPSMxHNJ6tGQj6zw+NVdJnCyBC6JeEeYqtGk/StD0nMd3anvg3YlwBVDNmz
 tGsOSRz0efJQmT6cBv47CVlUDhoIrdXK5n57n+CnkYOYpWSE3SH4353ZV2msZAXnFG4M
 wvjpXUeQKivN0l6aeN3No6ZlzvTtiZ0+CDmr3wxBzbNG0YrrLejYqU0HQkVuyOXgGwal
 CVaUgge2bPn7E2uvIjLKJ4Df8Xv4gQsBvTwX8lBgC5rCts96Ps8oa4UU8t8geegkJ5bO
 GctlTrbjEbt6dum/7tBV8OsngZ16OiArdCfRv7J5YnamcN0NNlWcJGQHxdbHnas7Clkj
 /MkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789316682; x=1789921482;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ja4gy9bM3MSnu3e3kwLdSiJg3jbn7lEXKz0erDP5BvA=;
 b=pkEORJgYtqir1qEQ6hFmzAJ4fjqegzBbpLCCy0z6fg7oVq1mYgYj2v/0yTaWCe2don
 usvfi1cJneXqQ2Xv12lNmVswgy6ImfpERwrmt+ar/GZ49J+FrfhmM3amXYjS0qD/fJ6/
 hSNpefeNRizPLFXV1NJcZRyOeHm20bk79Lih0Yo2PA7fwWWwEKfApt7KaMkPRMynJo/W
 TKUpZEDEXVKJOYL/c5qWaVAzPyfj/U/Z9HRhfj0oM5n3ujTWjsOrUBI+Qrzdu7yEUI+H
 fCCeao24IxoljvQVt36G1IMofcblJe3n9dlm0pJRh/9xQPKpRJzDfPCtXMF78XGTQ2hq
 6Uhg==
X-Gm-Message-State: AFuF++mKrrUCeT/KK6S1hgvuV5oOMr8uLyYcwykfi7JOeezennV9q6YF
 6XGKwwILcRVWpCYAbPm2ekhGmQw8VunUHNpL0CoclrB5fpUbyjfo+1GO4Xd0XesQeka+zOuLwnn
 9CDSe7Q5d7ovqaZd4Et7AolDzjGxm+/8=
X-Gm-Gg: AYBFou2orbc0AVya8VqHZ2YH3IlmUHwrLkDywlHPqqT0RME1rIMFHqUuzFG6S1mCsZ1
 KxDaWxwZZ4AgjLB8mXUjZcXYuAl7sR+/X37O4RP3QQWQ+A4pRtPxMYs0so8RwWjEB7vuSutFMZG
 uBkxAsShH9R20P/LI2BLuFtqpg3a6epGrDpaeWkdDjo/67eRYs/T1ztyV/PAxgfiPlxCM0yFrfF
 dKGRB3H7kv11YXGfFsDBSyIUutegljxgWozWCEDD54jHVd/rY6I9ICXtirbbF0QTO9cuL9upgKK
 srkV3iYDRS5FQyUWxsoJmJE6ihklrwbavayB4QTcwdlpqylqwFFLR6E=
X-Received: by 2002:a05:6820:83d2:10b0:6b9:7d9e:5708 with SMTP id
 006d021491bc7-6c0b9e5081cmr11465365eaf.3.1789316682606; Sun, 13 Sep 2026
 09:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260913155303.84201-1-aford173@gmail.com>
 <20260913155303.84201-2-aford173@gmail.com>
 <CAOMZO5DV80JfDUyadp3-nbAYCLUT8tYroCGtdqkw+=b9LRxa9w@mail.gmail.com>
In-Reply-To: <CAOMZO5DV80JfDUyadp3-nbAYCLUT8tYroCGtdqkw+=b9LRxa9w@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 13 Sep 2026 11:24:31 -0500
X-Gm-Features: AcwNN1UtKXeCW1WlIsPklMKVfLrYgQ_5w4mSz0rv-FK8KJ7TrjZj3oc_jzEMKDs
Message-ID: <CAHCN7xJKwZXdJW_UnVB8rTaAzBfAT+wyua=52Q-iDzz689dZ-A@mail.gmail.com>
Subject: Re: [PATCH 1/3] board: beacon: Remove i.MX8MM Beacon EmbeddedWorks
 Devkit support
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000041ec9c065b5fc17d"
X-Mailman-Approved-At: Sun, 13 Sep 2026 23:20:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

--00000000000041ec9c065b5fc17d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:15=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:

> Hi Adam,
>
> On Sun, Sep 13, 2026 at 12:53=E2=80=AFPM Adam Ford <aford173@gmail.com> w=
rote:
> >
> > Remove the i.MX8MM Beacon EmbeddedWorks Devkit board support along
> > with its defconfigs, config header, U-Boot device tree overlay,
> > documentation and Kconfig target.
>
> Please explain the rationale for removing these boards.
>

I haven't worked at Beacon aka LogicPD in almost a year.  I have asked that
someone take over maintenance, but nobody has stepped forward.  I didn't
want to put that into the official commit message, because I didn't want to
sound harsh or snarky.

adam

>
> Thanks
>

--00000000000041ec9c065b5fc17d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 13,=
 2026 at 11:15=E2=80=AFAM Fabio Estevam &lt;<a href=3D"mailto:festevam@gmai=
l.com">festevam@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Hi Adam,<br>
<br>
On Sun, Sep 13, 2026 at 12:53=E2=80=AFPM Adam Ford &lt;<a href=3D"mailto:af=
ord173@gmail.com" target=3D"_blank">aford173@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Remove the i.MX8MM Beacon EmbeddedWorks Devkit board support along<br>
&gt; with its defconfigs, config header, U-Boot device tree overlay,<br>
&gt; documentation and Kconfig target.<br>
<br>
Please explain the rationale for removing these boards.<br></blockquote><di=
v><br></div><div>I haven&#39;t worked at Beacon aka LogicPD in almost a yea=
r.=C2=A0 I have asked that someone take over maintenance, but nobody has st=
epped forward.=C2=A0 I didn&#39;t want to put that into the official commit=
 message, because I didn&#39;t want to sound harsh or snarky.</div><div><br=
></div><div>adam=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
Thanks<br>
</blockquote></div></div>

--00000000000041ec9c065b5fc17d--
