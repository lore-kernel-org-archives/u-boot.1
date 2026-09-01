Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBB1C624D3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 18:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CF9560790;
	Tue,  1 Sep 2026 18:15:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cr5udmUdnZdr; Tue,  1 Sep 2026 18:14:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788286499;
	bh=r5dfPySm+lbdTvWBMTVvTofhKPfdQWIcWIy0W3vc/7g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gboo9TzsKR3FJGtDZXXk9u4KBsVTlwRhZqrOosD6wtmoLFUlpFn76Q2oxyu8230tq
	 1XTVsNghkRKNChz1TI6Af/t6/zkjv6x6lc3lSyAJNCBEcovpkKyfGzqym3sXy8jB4P
	 ZXdppGyJzhTVP4PCeosppOOtCu1jQy6WvnPUHo9i34yXcTBVHsFwH0LNcsXiaLMTSx
	 eSUemSqimDQo1JqAVYVmVj8qLWXkh34eUjQKPi5iCpYzyh/TAOSS1lMJ8g0AEqfs9s
	 roBUE19DgZEgHZ8nNFUQI6d7GAKIN1kAJFx3CJFsD1R4VUuYo7aobbb6v5LEowqGEX
	 dkiDtBvMwWGuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FFBC607B8;
	Tue,  1 Sep 2026 18:14:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2564E1D9
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:47:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1682360749
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:47:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pvSFYYxy4aML for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 17:47:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::936; helo=mail-ua1-x936.google.com;
 envelope-from=yuxiaozhang@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=rVrUXl22
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B973D606F6
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:47:52 +0000 (UTC)
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-97c441e66f0so39126241.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 10:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788284871; cv=none;
 d=google.com; s=arc-20260327;
 b=Rw+qyezg72dYMXcDmXNy2Q2ZxOgssP6MfwPYWlRn9C/OKkYDKEhI7Kv2hDLwuOnWP1
 HBATnzPn2SLarZli8wKjdBxV+RYGmgrHcDzyK8hvCSqdoS2fFOCu8w/0eTLnX54E6y+i
 LNYWFH7Jl20M1YZSVFbSzvQdehPrKyyc9ap5SJ0/rzkhZNEACchD4wUU5TqKO8L0pkpK
 AKR6dg047AYh3i8tVUOa49CXGBH/5xTycJhIQwWKIov1SqFFLUwqNhcYM0DtcYXOnIXN
 pDf6ieYCc1LtQXhoJNq/ebf+RnXL1iHgoV69xlZZYj6DWPl+9ZbqrmVzvpRaJVeuTCxw
 TNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r5dfPySm+lbdTvWBMTVvTofhKPfdQWIcWIy0W3vc/7g=;
 fh=MkVoi0MryA72ed/47Z4PgqiI0BkTdH0TG2Bf89HJVgQ=;
 b=hq/1bGrOUP+SLNJv9HXYQz+MBfNqvKnLZ7UvSeOrsGugZDB8tEAHc/Syl9bt7tvvnP
 A5Qs8yI3Bjyh6eryOC8kOyemBHFlw88uAazbyvUrT00kbhMDl1r/AmU2wl7RDvrKSjqd
 N32sFXP8elCgDJWNMMZWXfG14XPOmxuhPnDJCJ4VehgMUx9jP4mxGHBTH3D2tnbD5ZZu
 FsY+s/RmT6xqoVBhj1VwjllIGAmge7nlPnCi3nizsPN24sD+M3fUTURlngrzqntl1M6D
 z3mSMXJhJmNZilz3TFjGsuCXYvGIxmjFU5EzSxtM9A7Z+LxVv3TrN+WdCZQDFouuUnJZ
 0zVQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788284871; x=1788889671;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r5dfPySm+lbdTvWBMTVvTofhKPfdQWIcWIy0W3vc/7g=;
 b=rVrUXl22/oiV1n34M0J1VMCpn9urRcEHbe4qeDBrbs+d5sjORhhYYsS+S7vIrJWHtZ
 WAzJXHTWuA9VZrwNB76zHJm46rqmDs3DS/HIM7b1JubHFDHIoaU7XU8eF7L3p7bOP8TY
 ugI/XAyc2fzWlE52sOXJVz0dAbaMrKRZ60VZgtwpHuPIwsTnuQ5wPZ+i8WJn34MvoZHZ
 N2SJofBXMfCp0Jk6NnqSz5sXfOyf+BKF+oDOfv3raaycNSYZRKVhbUCzFzm42/Dhpkm5
 3JgtXbDnPdgfpdaG2e9geB50+JEQWhL1uZXC2/+65IMPBCTuGjrMnlIOgP0Ho5UxVDZ5
 /sSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284871; x=1788889671;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r5dfPySm+lbdTvWBMTVvTofhKPfdQWIcWIy0W3vc/7g=;
 b=Vw3iuw1XuCcxMInzu+YOwCQpHq0w2A25F9lVu6Dym+iBjnQTT/Le2A934eJjT0cqH4
 JiBaHiAM7jSHRIoU7CaZUEciTUp1T0qQ04unhSuq+61w1cAzb7a6IMLkOI6ZOQmGc3Ch
 yUuszpDk4e13u3gup8Ipeo8veLhFHtJzWyDrOZjzWx00WHlEL/8twPW1zvu0kP1PzRyg
 wR0iV9+ghU7tMQbXMbPRfg5NRtaGzXXCDIHv/PIjSWMSd4RtuIQrFzbxV4+zXKkde3pC
 qI4FmcqZGJe9EECj1s76X68dkNIsJXM0cYvwiwOwSpTE57cxLF/pfQbXOSujRNM+8Nj0
 Z9bQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEWbmvQIm74N2agMGJvezyNZll8fm54Z0GMWHbGe1uDwRdQ661H79jelQYdmPKHyl72Xg0zVg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mEf3LJjMMr5kLdc/Ahrw3wDtPzqw/gZSEfOBD9F396hU+cbnIN
 FN9J3tkI2vJ77i6Kn+CriFZI3YsE5Bn6+rrbCl03NLKzr6cDXvYoOxh25A844WbknTsntwZi/7H
 mJvawFETxsUysOzyV91UNuOcvHH6Zq3PwhyevG3Kz
X-Gm-Gg: AYBFou2tK70QXlbufRqkuASXAen5PnpgH8sz2v41S5VsmOQ/joR/vzuoc1Uej4ky+fH
 ENnBQ7I4ol8AFpbobhM6xBBfTtMCl8S6h1k6W5P8UA2jrbB0vuAqpW6CpeB75w1bPF9+bAsIoK3
 lyl6HLnZBiIZmRQ2yaE1zs3An0FZDO9G4anfHmcE9VC0o36myETGdpSKX1xOdtIES46u7lps2jD
 yn9WyJljP5AB4XMWcmKAtenfNry9OrHS2DgQwUWlnXO+LGSzWUQXEquw9YcTWKT70lf5B9oUZjw
 LKTGhkqIuZhfyvo+1uJdI5EIVAAfmx4Gmoj5D1Ay56wqwk9xML7MgcGnYJiJ2EfBavoWdj3AniA
 s9w==
X-Received: by 2002:a05:6102:3747:b0:785:1a50:3f56 with SMTP id
 ada2fe7eead31-78598c4186emr12112522137.12.1788284865488; Tue, 01 Sep 2026
 10:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260826181428.1856166-1-yuxiaozhang@google.com>
 <20260826200207.GB3959812@bill-the-cat>
 <CAOOoKeQPDO0FTN0ya+W5-HR0DsadcbXFgfyG=SwG9DaM8S-GWA@mail.gmail.com>
 <20260826204240.GC3959812@bill-the-cat>
 <CAOOoKeQXLLWa-aUJviAt0Qrj_Z922UkeM-0iVs0FK1swBwiOFg@mail.gmail.com>
 <20260831230114.GC1145425@bill-the-cat>
In-Reply-To: <20260831230114.GC1145425@bill-the-cat>
From: Yuxiao Zhang <yuxiaozhang@google.com>
Date: Tue, 1 Sep 2026 10:47:32 -0700
X-Gm-Features: AcwNN1XS_38Qzu5ujUcpFelyBoj_6S898Q58p9nAO5lKT8CE9LbjtQdM_ShKnO4
Message-ID: <CAOOoKeR5oAcouuG1EO2fQNubKsfVB=O5qf0aj-FhSSGJeOH-LQ@mail.gmail.com>
Subject: Re: [PATCH] u-boot: fix error check in eth init
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="0000000000002d1581065a6f84ac"
X-Mailman-Approved-At: Tue, 01 Sep 2026 18:14:57 +0000
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

--0000000000002d1581065a6f84ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 4:01=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> On Mon, Aug 31, 2026 at 02:00:22PM -0700, Yuxiao Zhang wrote:
> > On Wed, Aug 26, 2026 at 1:42=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> >
> > > On Wed, Aug 26, 2026 at 01:12:55PM -0700, Yuxiao Zhang wrote:
> > >
> > > > IMHO at least the activation check is a valid case. It just check t=
he
> > > > status flag and returns EINVAL without setting errno:
> > > >
> > > > 292         if (!device_active(dev))
> > > > 293                 return -EINVAL;
> > >
> > > Please don't top-post, it makes following context harder. And, this
> > > isn't quite what I was asking about. If we look at commit:
> > > commit 7ad5e878cd850102e13ee2a5f8a5fb69742f70b0
> > > Author: Jerome Forissier <jerome.forissier@arm.com>
> > > Date:   Wed Oct 16 12:04:01 2024 +0200
> > >
> > >     net: eth-uclass: add function eth_start_udev()
> > >
> > >     Add a function to start a given network device, and update
> eth_init()
> > >     to use it.
> > >
> > >     Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > >     Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >
> > > Which introduces this function, and examine the code before/after, we
> > > aren't quite doing the same things as before.
> > >
> > > So yes, we aren't handling the error case you describe correctly, but
> my
> > > first thought is that the caller here should be doing eth_errno =3D
> > > eth_start_udev(); and then setting ret =3D eth_errno if we get a prob=
lem.
> > > But that might not be quite right either, I've only spent a few minut=
es
> > > on this,
> > >
> > > >
> > > > Thanks,
> > > > -Yuxiao
> > > >
> > > >
> > > >
> > > > On Wed, Aug 26, 2026 at 1:02=E2=80=AFPM Tom Rini <trini@konsulko.co=
m> wrote:
> > > >
> > > > > On Wed, Aug 26, 2026 at 11:14:19AM -0700, Yuxiao Zhang wrote:
> > > > >
> > > > > > eth_start_udev can fail but errno could still be zero which
> causes
> > > the
> > > > > > function ignores the error silently. This fix catches the error
> > > > > > properly.
> > > > > >
> > > > > > Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
> > > > > > ---
> > > > > >
> > > > > >  net/eth-uclass.c | 11 ++++++-----
> > > > > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> > > > > > index 5c437143a30..5518268bd68 100644
> > > > > > --- a/net/eth-uclass.c
> > > > > > +++ b/net/eth-uclass.c
> > > > > > @@ -347,12 +347,13 @@ int eth_init(void)
> > > > > >                       debug("Trying %s\n", current->name);
> > > > > >
> > > > > >                       ret =3D eth_start_udev(current);
> > > > > > -                     if (ret < 0)
> > > > > > -                             ret =3D eth_errno;
> > > > > > -                     else
> > > > > > +                     if (ret < 0) {
> > > > > > +                             if (eth_errno < 0)
> > > > > > +                                     ret =3D eth_errno;
> > > > > > +                             debug("%s start failed (ret=3D%d)=
\n",
> > > > > current->name, ret);
> > > > > > +                     } else {
> > > > > >                               break;
> > > > > > -
> > > > > > -                     debug("FAIL\n");
> > > > > > +                     }
> > > > > >               } else {
> > > > > >                       debug("PROBE FAIL\n");
> > > > > >               }
> > > > >
> > > > > Is it a valid case for eth_start_udev to have failed and not set
> > > eth_errno?
> > > > >
> > > > > --
> > > > > Tom
> > > > >
> > >
> > > --
> > > Tom
> > >
> >
> > Sorry for the late reply. I checked the commit
> > 7ad5e878cd850102e13ee2a5f8a5fb69742f70b0 and looks like the issue still
> > exists before that commit. If the check "device_active(current)" failed
> > then the errno is also not set and we still return 0. I am not sure if
> > "eth_errno
> > =3D eth_start_udev();" since that just ignores the real errno. The fix =
I
> > proposed is just to capture the corner case that errno is 0 but
> eth_start_udev
> > still failed for whatever reason. Otherwise the logic keeps the same as
> > before.
>
> Yes, before if device_active(current) is false (it's just a flag check),
> we would only end up with something in eth_errno if eth_get_dev() had
> failed.
>
> So at this point, it should be clear that, as I had asked originally,
> this isn't some special case but rather a problem in handling errors
> from eth_start_udev to solve. Perhaps it should be setting eth_errno
> instead of directly returning? Or perhaps as I suggested at first we
> should be doing 'eth_errno =3D eth_start_udev();' and going from there?
>
> --
> Tom
>

Ok makes sense, I will send out a new version which also set the eth_errno
if the flag check failed.

Thanks,
-Yuxiao

--0000000000002d1581065a6f84ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt">On Mon, Aug 31, 2026 at 4:01=E2=80=AFPM Tom Rini &lt;<a href=3D"mailto:=
trini@konsulko.com">trini@konsulko.com</a>&gt; wrote:</span></div><div clas=
s=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Mon, Aug 31, 2026 at 02:00:22PM -0700, Yuxiao Zhang wrote=
:<br>
&gt; On Wed, Aug 26, 2026 at 1:42=E2=80=AFPM Tom Rini &lt;<a href=3D"mailto=
:trini@konsulko.com" target=3D"_blank">trini@konsulko.com</a>&gt; wrote:<br=
>
&gt; <br>
&gt; &gt; On Wed, Aug 26, 2026 at 01:12:55PM -0700, Yuxiao Zhang wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; IMHO at least the activation check is a valid case. It just =
check the<br>
&gt; &gt; &gt; status flag and returns EINVAL without setting errno:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; 292=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!device_active(dev)=
)<br>
&gt; &gt; &gt; 293=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return -EINVAL;<br>
&gt; &gt;<br>
&gt; &gt; Please don&#39;t top-post, it makes following context harder. And=
, this<br>
&gt; &gt; isn&#39;t quite what I was asking about. If we look at commit:<br=
>
&gt; &gt; commit 7ad5e878cd850102e13ee2a5f8a5fb69742f70b0<br>
&gt; &gt; Author: Jerome Forissier &lt;<a href=3D"mailto:jerome.forissier@a=
rm.com" target=3D"_blank">jerome.forissier@arm.com</a>&gt;<br>
&gt; &gt; Date:=C2=A0 =C2=A0Wed Oct 16 12:04:01 2024 +0200<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0net: eth-uclass: add function eth_start_udev()=
<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Add a function to start a given network device=
, and update eth_init()<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0to use it.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Jerome Forissier &lt;<a href=3D=
"mailto:jerome.forissier@linaro.org" target=3D"_blank">jerome.forissier@lin=
aro.org</a>&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Reviewed-by: Ilias Apalodimas &lt;<a href=3D"m=
ailto:ilias.apalodimas@linaro.org" target=3D"_blank">ilias.apalodimas@linar=
o.org</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Which introduces this function, and examine the code before/after=
, we<br>
&gt; &gt; aren&#39;t quite doing the same things as before.<br>
&gt; &gt;<br>
&gt; &gt; So yes, we aren&#39;t handling the error case you describe correc=
tly, but my<br>
&gt; &gt; first thought is that the caller here should be doing eth_errno =
=3D<br>
&gt; &gt; eth_start_udev(); and then setting ret =3D eth_errno if we get a =
problem.<br>
&gt; &gt; But that might not be quite right either, I&#39;ve only spent a f=
ew minutes<br>
&gt; &gt; on this,<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks,<br>
&gt; &gt; &gt; -Yuxiao<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, Aug 26, 2026 at 1:02=E2=80=AFPM Tom Rini &lt;<a href=
=3D"mailto:trini@konsulko.com" target=3D"_blank">trini@konsulko.com</a>&gt;=
 wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Wed, Aug 26, 2026 at 11:14:19AM -0700, Yuxiao Zhang =
wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; eth_start_udev can fail but errno could still be z=
ero which causes<br>
&gt; &gt; the<br>
&gt; &gt; &gt; &gt; &gt; function ignores the error silently. This fix catc=
hes the error<br>
&gt; &gt; &gt; &gt; &gt; properly.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Signed-off-by: Yuxiao Zhang &lt;<a href=3D"mailto:=
yuxiaozhang@google.com" target=3D"_blank">yuxiaozhang@google.com</a>&gt;<br=
>
&gt; &gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 net/eth-uclass.c | 11 ++++++-----<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 1 file changed, 6 insertions(+), 5 deletions=
(-)<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; diff --git a/net/eth-uclass.c b/net/eth-uclass.c<b=
r>
&gt; &gt; &gt; &gt; &gt; index 5c437143a30..5518268bd68 100644<br>
&gt; &gt; &gt; &gt; &gt; --- a/net/eth-uclass.c<br>
&gt; &gt; &gt; &gt; &gt; +++ b/net/eth-uclass.c<br>
&gt; &gt; &gt; &gt; &gt; @@ -347,12 +347,13 @@ int eth_init(void)<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;Trying %s\n&quot;, current-&g=
t;name);<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D eth_start_udev(current);<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D eth_errno;<b=
r>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (eth_errno &lt; 0=
)<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D eth_errno;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;%s start=
 failed (ret=3D%d)\n&quot;,<br>
&gt; &gt; &gt; &gt; current-&gt;name, ret);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; &gt; &gt; -<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;FAIL\n&quot;);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0} else {<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;PROBE FAIL\n&quot;);<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Is it a valid case for eth_start_udev to have failed an=
d not set<br>
&gt; &gt; eth_errno?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; Tom<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; Tom<br>
&gt; &gt;<br>
&gt; <br>
&gt; Sorry for the late reply. I checked the commit<br>
&gt; 7ad5e878cd850102e13ee2a5f8a5fb69742f70b0 and looks like the issue stil=
l<br>
&gt; exists before that commit. If the check &quot;device_active(current)&q=
uot; failed<br>
&gt; then the errno is also not set and we still return 0. I am not sure if=
<br>
&gt; &quot;eth_errno<br>
&gt; =3D eth_start_udev();&quot; since that just ignores the real errno. Th=
e fix I<br>
&gt; proposed is just to capture the corner case that errno is 0 but eth_st=
art_udev<br>
&gt; still failed for whatever reason. Otherwise the logic keeps the same a=
s<br>
&gt; before.<br>
<br>
Yes, before if device_active(current) is false (it&#39;s just a flag check)=
,<br>
we would only end up with something in eth_errno if eth_get_dev() had<br>
failed.<br>
<br>
So at this point, it should be clear that, as I had asked originally,<br>
this isn&#39;t some special case but rather a problem in handling errors<br=
>
from eth_start_udev to solve. Perhaps it should be setting eth_errno<br>
instead of directly returning? Or perhaps as I suggested at first we<br>
should be doing &#39;eth_errno =3D eth_start_udev();&#39; and going from th=
ere?<br>
<br>
-- <br>
Tom<br></blockquote><div><br></div><div>Ok makes sense, I will send out a n=
ew version which also set the eth_errno if the flag check failed.</div><div=
><br></div><div>Thanks,</div><div>-Yuxiao</div></div></div>

--0000000000002d1581065a6f84ac--
