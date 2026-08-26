Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E69CC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 20:26:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA3D940800;
	Wed, 26 Aug 2026 20:26:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3s6I0o_q4I5; Wed, 26 Aug 2026 20:26:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787776009;
	bh=E2Bgdj+wdMr/R9r9Vy+Re09+EsHhDvoEv6fbktFQYg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wQBml7inz4g1FKav6eetH7Yg4GVh4Lf/87BUnegpUxAYUPFND1bK296Jg+KalXFVs
	 I1T7pgpyKM/CjHqGGbi2pJdB2mrEpGRDnEZ0oIO61urR1eH92/v1qFzvIUGoKDAWgs
	 pDj93hA7LMUcFxuEH5nAtrxuPJ9ElGG3akpJIRrV0p1xpht2bDv3zkUTlok10jTKpg
	 0XZw7/ZjHYoeS7G1VXPp9Of4syyXgLnv1mEvfadDtJ3cfje78vLzesUY6Dta6GoMp4
	 xG4oQWf9hP3EYpGu2sz7autBW1PY6wquDwULQthwINdaMIdbB/VPfBnp1znTtIFC6t
	 +DVGtKTl0Usxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FC66406AC;
	Wed, 26 Aug 2026 20:26:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 959E2334
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 20:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D819080E24
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 20:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ez7UDQzkhrPM for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 20:13:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=yuxiaozhang@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=rRNZUQ0X
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D7C980BF0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 20:13:08 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cc1c8d4a959so807223a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787775188; cv=none;
 d=google.com; s=arc-20260327;
 b=XIT6HTw+9dGOaUCnaUkkuV/vC+kIB0aIWqtnwUopSAlxbLYEFoczTlDAbf+rTcQttU
 B0wNHbrwd06YNl/dAMa2NV3lzn11xUiRGFX+g0Afg4RJ6d8Afw6NYLD7FNTbcHc2+dfy
 ioEfg2FqUJ7ejgFM/1b69ePbIB8MJ8ZBVrOypthwH6r7xnUFdaviJYlayFCvAe2gcH89
 ZRG6F895ErE8U+g5tHBuJ4B24p2OZqzREBppkxylbR/PT7zdGbnxuc+HPEDRDl9utwA/
 GMRz12PWqQ7hIEHChivcifYXBvPHKKYooZahp7SOkgArtSTRFSym76Qkm2Q7vKwHCKsE
 DB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E2Bgdj+wdMr/R9r9Vy+Re09+EsHhDvoEv6fbktFQYg4=;
 fh=9Lh2CAcu2HmcuDgW/9+EU0KyXEZm56DRJ7g4N2GqeMo=;
 b=jhBunZgU0HUdRKyZJcZWMJ63Yiumid5RyGKuntL6LUJyiEkzWpxaT9CwWvKNsLrVZz
 NerW1fTg1L86F0599rid8ek0OH6fJlII/OZ3SloOi0CavtyUHafhb2MKQ1I38DIekF+C
 Q+JtcJVgtXBH3gGwbah0kbjhrSHUG7C4WN72nqZ/ZazQmUGil1XfbvfUN5Fj9A3iRNb3
 hi5r2fEwf9gSamWJsiSpdyuGJEoPBYC/ol3PuVBaWVjhm30O5afdx4j94m7nPV2u/yri
 lDnGpyz+GJ9nxvWsDa4ABzjeOOYK8+/3BySJMNnYScEdNtE6FUs7/KY7CPQBMNXYL2fx
 LY6A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787775188; x=1788379988;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E2Bgdj+wdMr/R9r9Vy+Re09+EsHhDvoEv6fbktFQYg4=;
 b=rRNZUQ0XHUyOYBXWrM3CKrxZoDiXI9Ex1be8f8uHrd1yodCpCV6wT3h0dweVySvD9H
 jnWxPApJzRRKznWqIqcKOYv2GB4+suSQ2wdSdiBhuzfPU3ZucDV7ZNhhq/xfOFPPOf8k
 bSjRh3g/1MoO1byO6k5/VxTgvMYYPJ7mZDue1kFtaZlYfQ0MnaC70a5xnS/4DgPHSDi6
 vJQGd0NS17LEkGRCLy2UsmFGo/7GFRzJ6YgHvhBexc0x0+qlv8iYgPsg2psFtgQhTWkL
 Y/Sty7mh5AOrNZCvD1blvxDBzmdZrJuDOx+zcgXe3lH0eXJGn4b7gwvTej9GN9ViQl8h
 G34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787775188; x=1788379988;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E2Bgdj+wdMr/R9r9Vy+Re09+EsHhDvoEv6fbktFQYg4=;
 b=HG5yOK4s1DahpuW6h5X9Ash2Y7QqezRqoErMil9h09KeAhrZ93B03ZHlNYkT1km3mJ
 6YKnuzCXWI/8BqsQMuIWX7vczvLlHCJOrc0/yZ61xZIChgmahko7afu96lZ2YBP6wVhm
 JW4XTRJqvSlTaQo8Yc6cJ/RkJA53d3yr9nY1sXWZ7dAAgAL8rK1+oLmSpWCC7CNBrMmo
 8e/48utoMsIAbugf9fhI/SP+TI5huRR/8coHlkTVJGD7PH0/3ZQI6ZrttfTO7NSIJmHI
 GGTQsFyGcWu+Dnx7mEg0nBNrS6Qpd14U3jmDO8rOTLWi8gvzAk4Qf9cAbMfO/ksm9lPh
 n2iQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrus8RvIVoIeG3zOsHiCwgv98rSf3fDSVvL4teiAQNKwtfaljyR/EcYAbVzgrRNBXGIYhsFres=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nNI6TpqKqbpW9DaZkq1u02FG6832Bami88lMVxER2dvrjWBhcP
 UssS6YvOSZ76Tgo2/h+i08IVsHApsPb9lNIg2rTXgEtky4IHk9TToDy5vxJaqHgB6vIbe4DmmkZ
 /ir0+fuoDtTY8SIdo0/DjxL46ki0TciwvPzAsW0fJrLUmR0wUJD0fmeq5vBY=
X-Gm-Gg: AR+sD12K0poq+3kx7dGQNbo+2EjJVJnbsedyaDSDAKNOEKDw2Xd1BAUGHaUitiRLlZx
 7DiuOgrd+t/kFwac8F0dGU+avS02dSZ1jSx+u1+KjL9MoyBAHIAuFTfP/JVX+Gzjb8+cNy+BpqT
 ntfzkND2xcBpwwo8fmqPgxOtWC7Oz+MwAsYVHurrz/m/48UZJ4Yjd+vjiSwRqEpxezV75EpPZFP
 od8P0yCzO0NZY4liTmRk8mVtHEj4DOhEdbTEBhRFVuc98IlrOKDlwUs+nK5NheUjurKpsC10B4f
 lysAfxJPW8kpe2guzM/n3Ts8fsWRZPWAMrxL4f0TkSzhdJYVd+5CxUaK/Xj9GZJAHw103Byvh/M
 =
X-Received: by 2002:a17:90b:3f46:b0:38e:7168:281 with SMTP id
 98e67ed59e1d1-3966d3d8a07mr20109706a91.10.1787775187408; Wed, 26 Aug 2026
 13:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260826181428.1856166-1-yuxiaozhang@google.com>
 <20260826200207.GB3959812@bill-the-cat>
In-Reply-To: <20260826200207.GB3959812@bill-the-cat>
From: Yuxiao Zhang <yuxiaozhang@google.com>
Date: Wed, 26 Aug 2026 13:12:55 -0700
X-Gm-Features: AcwNN1U87FxKFuxRKpyALKhL3iPRUFLVHv1ZznRaUmZLvzzWRTyGAOj1DaO2kpk
Message-ID: <CAOOoKeQPDO0FTN0ya+W5-HR0DsadcbXFgfyG=SwG9DaM8S-GWA@mail.gmail.com>
Subject: Re: [PATCH] u-boot: fix error check in eth init
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="000000000000fd57000659f8d813"
X-Mailman-Approved-At: Wed, 26 Aug 2026 20:26:47 +0000
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

--000000000000fd57000659f8d813
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

IMHO at least the activation check is a valid case. It just check the
status flag and returns EINVAL without setting errno:

292         if (!device_active(dev))
293                 return -EINVAL;

Thanks,
-Yuxiao



On Wed, Aug 26, 2026 at 1:02=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> On Wed, Aug 26, 2026 at 11:14:19AM -0700, Yuxiao Zhang wrote:
>
> > eth_start_udev can fail but errno could still be zero which causes the
> > function ignores the error silently. This fix catches the error
> > properly.
> >
> > Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
> > ---
> >
> >  net/eth-uclass.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> > index 5c437143a30..5518268bd68 100644
> > --- a/net/eth-uclass.c
> > +++ b/net/eth-uclass.c
> > @@ -347,12 +347,13 @@ int eth_init(void)
> >                       debug("Trying %s\n", current->name);
> >
> >                       ret =3D eth_start_udev(current);
> > -                     if (ret < 0)
> > -                             ret =3D eth_errno;
> > -                     else
> > +                     if (ret < 0) {
> > +                             if (eth_errno < 0)
> > +                                     ret =3D eth_errno;
> > +                             debug("%s start failed (ret=3D%d)\n",
> current->name, ret);
> > +                     } else {
> >                               break;
> > -
> > -                     debug("FAIL\n");
> > +                     }
> >               } else {
> >                       debug("PROBE FAIL\n");
> >               }
>
> Is it a valid case for eth_start_udev to have failed and not set eth_errn=
o?
>
> --
> Tom
>

--000000000000fd57000659f8d813
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">IMHO at least the activation check is a valid case. It jus=
t check the status flag and returns=C2=A0EINVAL without setting errno:<div>=
<br></div><div>292 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!device_active(dev))<br>=
293 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;=
</div><div><br></div><div>Thanks,</div><div>-Yuxiao<br><div><br><br></div><=
/div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2026 at 1:02=E2=80=AFPM Tom Rini=
 &lt;<a href=3D"mailto:trini@konsulko.com">trini@konsulko.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Aug 26=
, 2026 at 11:14:19AM -0700, Yuxiao Zhang wrote:<br>
<br>
&gt; eth_start_udev can fail but errno could still be zero which causes the=
<br>
&gt; function ignores the error silently. This fix catches the error<br>
&gt; properly.<br>
&gt; <br>
&gt; Signed-off-by: Yuxiao Zhang &lt;<a href=3D"mailto:yuxiaozhang@google.c=
om" target=3D"_blank">yuxiaozhang@google.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt;=C2=A0 net/eth-uclass.c | 11 ++++++-----<br>
&gt;=C2=A0 1 file changed, 6 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/net/eth-uclass.c b/net/eth-uclass.c<br>
&gt; index 5c437143a30..5518268bd68 100644<br>
&gt; --- a/net/eth-uclass.c<br>
&gt; +++ b/net/eth-uclass.c<br>
&gt; @@ -347,12 +347,13 @@ int eth_init(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0debug(&quot;Trying %s\n&quot;, current-&gt;name);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ret =3D eth_start_udev(current);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (ret &lt; 0)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D eth_errno;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (eth_errno &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D eth_=
errno;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;%s start failed (ret=3D%d)\n=
&quot;, current-&gt;name, ret);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0debug(&quot;FAIL\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0debug(&quot;PROBE FAIL\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
Is it a valid case for eth_start_udev to have failed and not set eth_errno?=
<br>
<br>
-- <br>
Tom<br>
</blockquote></div>

--000000000000fd57000659f8d813--
