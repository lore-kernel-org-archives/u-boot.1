Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09F7C61DFD
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 00:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45F22605E8;
	Tue,  1 Sep 2026 00:46:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2TMxve37WqA0; Tue,  1 Sep 2026 00:46:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788223568;
	bh=C60woTT/yo0h8BsXNB2I7b8pkVhxj69qw9QCllvZWx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QnhDwUGlKy9aiBNNMm/6ZiCrDDrzTr9/tAicE3gWlgFhVS7foH2j3yuRiDQLwUMp7
	 SCF9OuuI/qWjviwjzTXLSZmwyDWiWDdXlrgOMgiaN4xFztOL5Njap81uJa1LgXhAfj
	 FiyaTKzYRxr32bVzppmk/PqPkHvXQTYmZ5ZO2pm4zLugpKguuePlt5/OhIliBdHVA5
	 4moCm2+3igaLgYlIwNDrYY4tdg6abkE5FJYHgsImrav6bN4bb7IE0M+bE3fk9iVP/4
	 ENK9ek1XT2WGkAt2dWoyhbszn7qzeL4Mie8uoVbsrbMVufAzIFXC7I3/LAZ0L6CG8S
	 08JXPt8WiLj8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73DA36066A;
	Tue,  1 Sep 2026 00:46:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F7A12FC
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 21:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D7C14015A
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 21:00:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cIlyklNUm8Fw for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 21:00:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=yuxiaozhang@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=nhfPXyTZ
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32964400F2
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 21:00:35 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so409116a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788210035; cv=none;
 d=google.com; s=arc-20260327;
 b=W0UhWssi0NLIT2iYBbZnPcCW3k92a0F+a3Ce87HOKtQaxBvU/j3eCjEP2qrXYTGvlV
 jNoI6Zutx7OW7khPDC7Sbdf3c/uMK2jEVDnXYVo8Rqi4vA2lpNcwA0W9B37N+xe0Zxj9
 cHxIyc1bvRlZxRXEtdbUPI/M6dNCIDRmHbyIH5C1s9tVvx4/WyMxcVN5TM8kJgbxxB4M
 QkKSQA74sI4A59c1jxMAQbcObt82G6nkT94wSdG0kPCGSRytJay4kAhafDFSrx3JeYMI
 wa2f5PCARK/4YatNHcxn5UIaIYyJ17c/zBjXtLIkMmmVUimFYWs0huwuWAtRaV09ZJ24
 WiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=C60woTT/yo0h8BsXNB2I7b8pkVhxj69qw9QCllvZWx8=;
 fh=nK8JEdLT3NtBE8Vx9nGco40LfRfm7Ds44abeN3gFNoc=;
 b=GcUf/Hm9+weNnRvApeHLAQefXGk2NBpG8yhiUegnfIsMYMMQ36xSFGrVoQLdl0sx94
 izl0h2xHKKcwQdcw/Spld8dfM0OFCn0lXVj/bRhGm3GIU/OPjGoPmL24wMjixVFnhNtW
 SipszZLXZ+kT2yQ1nOvZA5zAiFEirFc/c2RpTQH9M0pT//iUABcogMu1OjI87LTzx5Mw
 a/bJE+0zdFyexENje8hz4Y0mNhBx6fybt7lLTlBlFcgYPUyy3Zru377s8PJPtUx8/NLF
 oZlKG/LS96IBP4ZL7W81gC8RvvJv1a/7zeIh2qDRCvWGRt2taO61J16R1ndvFjpKcvIF
 YC5A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788210035; x=1788814835;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C60woTT/yo0h8BsXNB2I7b8pkVhxj69qw9QCllvZWx8=;
 b=nhfPXyTZ9F1uLSYO/IP8xlAzRx5OSTvd//phGXPLD7ru69DARb710+BOG06gQiT0l8
 grM1x4ZqoulqoDSH9P4unu8vw2e4t1RNCgZyqS5F91PBuSTByEO5vH+rnkQdVCdakaQr
 4MnJ7CLGbMknn2R152mDGsRsFvOIKEHvBpa7TsyUOi+6qSzTNmAakGzIdRE42lernUW0
 4q9bzkJ6MQhR6m+PsvG26xsCahSdlPN+AiZ/EZvg6no+7r+ja6JPFVc77z+1O9QwwZ/l
 xw5m6lo2X3k/N1uuW5HAR3iHkpBJTVhpuCfmyf00QlKQLAkx01hHgS3oFe6hA7H8aRmv
 MEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788210035; x=1788814835;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C60woTT/yo0h8BsXNB2I7b8pkVhxj69qw9QCllvZWx8=;
 b=jXbWCBu8U0VduQ09dcireBI+bbGaUaK0rr3R6Y5kdLMFTqugoF9AwmGraQTTAo6Daq
 6Tj9PQyVYqYAXp87lwVmUoM18oC+grtVb++fdIyt67grjqciML7qz3OH+p+j1jnjR2yu
 JXV4FfwghZpQ4Qnh/T+q3VeIeiILsJTVcfqBm+pXKhCnAccYP8zs7X9k8B1oeDJoYfMC
 PPl5tke0TSUDmELMgUgE2Fp7ZNnqDJEYXVsN4zX5NneiiBHhf8hsCNF/ej3CDL/Px6fx
 4lsnrgAQDeIuHubBlNV4JthSFqZv2IFroB46keAyutcgjceQaSblnZ0M8WHrL2AAGmJt
 tOnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtYOUyfIZIyg9ynlp/AnDtmKo432IFBrCyTAflcuBsLWs7zGM6iFeF+uulEpibIUG0xOkPUk8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kqaLdiI3U05gVEMhwpNdGNBhANdjsa10FV/yo/4mJmYfM1QtVK
 QyXAn7e9w6kK06h37IOqwLeCSYBy6pX+TPlGhWRjT3uwWEVBINhrWfwH/Ui2+La/lerNw4js2RX
 I/ct2AFwpl2mXhXRl3Tek5Q/xVnCRmoGHt0jGAbUILj6FA5TGgk5htUOk
X-Gm-Gg: AYBFou3kuPvUnSD+S7CmYk/CQs+R7bfapkaAvN80xZ71gOiHzjf813gCML7FcE88N9y
 ClDftLc+Ro8312N7VQU2GbuwWQU1wy/OR6ohkm1effMHO2OPdSGScgjbx9kllsdJQnBdsrvoo2P
 +/0dZSHM6QwXGu2KnDak1IOTNEgLHSH1k2XxUiKuqIzXLoKL3C4POLbL9LzMXKswFu74sUy7+Tu
 9A+8Bs8c0CCDwRzyCS9piEQeaNEgSv3wTlKwzYWTUdUARBUkv0YCbfLcodcXl0A67Ijiq81PMiW
 ddLo4e/sY4/I5yFakX2ewVaHSxEo/2wrzb1E1/413F+6LiLAnexfLRjPe24lzdGdR377I2q6wy0
 =
X-Received: by 2002:a17:90b:4a4d:b0:38f:cfe2:fd3a with SMTP id
 98e67ed59e1d1-3990f890ed6mr730661a91.15.1788210034184; Mon, 31 Aug 2026
 14:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260826181428.1856166-1-yuxiaozhang@google.com>
 <20260826200207.GB3959812@bill-the-cat>
 <CAOOoKeQPDO0FTN0ya+W5-HR0DsadcbXFgfyG=SwG9DaM8S-GWA@mail.gmail.com>
 <20260826204240.GC3959812@bill-the-cat>
In-Reply-To: <20260826204240.GC3959812@bill-the-cat>
From: Yuxiao Zhang <yuxiaozhang@google.com>
Date: Mon, 31 Aug 2026 14:00:22 -0700
X-Gm-Features: AcwNN1UDROoWETMRharcNfNSmRow8uTAKQwN3yJpGBKz63f19S_OcWOnapSQjIk
Message-ID: <CAOOoKeQXLLWa-aUJviAt0Qrj_Z922UkeM-0iVs0FK1swBwiOFg@mail.gmail.com>
Subject: Re: [PATCH] u-boot: fix error check in eth init
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="000000000000e0bda9065a5e17de"
X-Mailman-Approved-At: Tue, 01 Sep 2026 00:46:08 +0000
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

--000000000000e0bda9065a5e17de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 1:42=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> On Wed, Aug 26, 2026 at 01:12:55PM -0700, Yuxiao Zhang wrote:
>
> > IMHO at least the activation check is a valid case. It just check the
> > status flag and returns EINVAL without setting errno:
> >
> > 292         if (!device_active(dev))
> > 293                 return -EINVAL;
>
> Please don't top-post, it makes following context harder. And, this
> isn't quite what I was asking about. If we look at commit:
> commit 7ad5e878cd850102e13ee2a5f8a5fb69742f70b0
> Author: Jerome Forissier <jerome.forissier@arm.com>
> Date:   Wed Oct 16 12:04:01 2024 +0200
>
>     net: eth-uclass: add function eth_start_udev()
>
>     Add a function to start a given network device, and update eth_init()
>     to use it.
>
>     Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>     Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Which introduces this function, and examine the code before/after, we
> aren't quite doing the same things as before.
>
> So yes, we aren't handling the error case you describe correctly, but my
> first thought is that the caller here should be doing eth_errno =3D
> eth_start_udev(); and then setting ret =3D eth_errno if we get a problem.
> But that might not be quite right either, I've only spent a few minutes
> on this,
>
> >
> > Thanks,
> > -Yuxiao
> >
> >
> >
> > On Wed, Aug 26, 2026 at 1:02=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> >
> > > On Wed, Aug 26, 2026 at 11:14:19AM -0700, Yuxiao Zhang wrote:
> > >
> > > > eth_start_udev can fail but errno could still be zero which causes
> the
> > > > function ignores the error silently. This fix catches the error
> > > > properly.
> > > >
> > > > Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
> > > > ---
> > > >
> > > >  net/eth-uclass.c | 11 ++++++-----
> > > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> > > > index 5c437143a30..5518268bd68 100644
> > > > --- a/net/eth-uclass.c
> > > > +++ b/net/eth-uclass.c
> > > > @@ -347,12 +347,13 @@ int eth_init(void)
> > > >                       debug("Trying %s\n", current->name);
> > > >
> > > >                       ret =3D eth_start_udev(current);
> > > > -                     if (ret < 0)
> > > > -                             ret =3D eth_errno;
> > > > -                     else
> > > > +                     if (ret < 0) {
> > > > +                             if (eth_errno < 0)
> > > > +                                     ret =3D eth_errno;
> > > > +                             debug("%s start failed (ret=3D%d)\n",
> > > current->name, ret);
> > > > +                     } else {
> > > >                               break;
> > > > -
> > > > -                     debug("FAIL\n");
> > > > +                     }
> > > >               } else {
> > > >                       debug("PROBE FAIL\n");
> > > >               }
> > >
> > > Is it a valid case for eth_start_udev to have failed and not set
> eth_errno?
> > >
> > > --
> > > Tom
> > >
>
> --
> Tom
>

Sorry for the late reply. I checked the commit
7ad5e878cd850102e13ee2a5f8a5fb69742f70b0 and looks like the issue still
exists before that commit. If the check "device_active(current)" failed
then the errno is also not set and we still return 0. I am not sure if
"eth_errno
=3D eth_start_udev();" since that just ignores the real errno. The fix I
proposed is just to capture the corner case that errno is 0 but eth_start_u=
dev
still failed for whatever reason. Otherwise the logic keeps the same as
before.

Thanks,
-Yuxiao

--000000000000e0bda9065a5e17de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt">On Wed, Aug 26, 2026 at 1:42=E2=80=AFPM Tom Rini &lt;<a href=3D"mailto:=
trini@konsulko.com">trini@konsulko.com</a>&gt; wrote:</span></div><div clas=
s=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Wed, Aug 26, 2026 at 01:12:55PM -0700, Yuxiao Zhang wrote=
:<br>
<br>
&gt; IMHO at least the activation check is a valid case. It just check the<=
br>
&gt; status flag and returns EINVAL without setting errno:<br>
&gt; <br>
&gt; 292=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!device_active(dev))<br>
&gt; 293=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -EINVAL;<br>
<br>
Please don&#39;t top-post, it makes following context harder. And, this<br>
isn&#39;t quite what I was asking about. If we look at commit:<br>
commit 7ad5e878cd850102e13ee2a5f8a5fb69742f70b0<br>
Author: Jerome Forissier &lt;<a href=3D"mailto:jerome.forissier@arm.com" ta=
rget=3D"_blank">jerome.forissier@arm.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Wed Oct 16 12:04:01 2024 +0200<br>
<br>
=C2=A0 =C2=A0 net: eth-uclass: add function eth_start_udev()<br>
<br>
=C2=A0 =C2=A0 Add a function to start a given network device, and update et=
h_init()<br>
=C2=A0 =C2=A0 to use it.<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Jerome Forissier &lt;<a href=3D"mailto:jerome.=
forissier@linaro.org" target=3D"_blank">jerome.forissier@linaro.org</a>&gt;=
<br>
=C2=A0 =C2=A0 Reviewed-by: Ilias Apalodimas &lt;<a href=3D"mailto:ilias.apa=
lodimas@linaro.org" target=3D"_blank">ilias.apalodimas@linaro.org</a>&gt;<b=
r>
<br>
Which introduces this function, and examine the code before/after, we<br>
aren&#39;t quite doing the same things as before.<br>
<br>
So yes, we aren&#39;t handling the error case you describe correctly, but m=
y<br>
first thought is that the caller here should be doing eth_errno =3D<br>
eth_start_udev(); and then setting ret =3D eth_errno if we get a problem.<b=
r>
But that might not be quite right either, I&#39;ve only spent a few minutes=
<br>
on this,<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; -Yuxiao<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On Wed, Aug 26, 2026 at 1:02=E2=80=AFPM Tom Rini &lt;<a href=3D"mailto=
:trini@konsulko.com" target=3D"_blank">trini@konsulko.com</a>&gt; wrote:<br=
>
&gt; <br>
&gt; &gt; On Wed, Aug 26, 2026 at 11:14:19AM -0700, Yuxiao Zhang wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; eth_start_udev can fail but errno could still be zero which =
causes the<br>
&gt; &gt; &gt; function ignores the error silently. This fix catches the er=
ror<br>
&gt; &gt; &gt; properly.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Yuxiao Zhang &lt;<a href=3D"mailto:yuxiaozhan=
g@google.com" target=3D"_blank">yuxiaozhang@google.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 net/eth-uclass.c | 11 ++++++-----<br>
&gt; &gt; &gt;=C2=A0 1 file changed, 6 insertions(+), 5 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/net/eth-uclass.c b/net/eth-uclass.c<br>
&gt; &gt; &gt; index 5c437143a30..5518268bd68 100644<br>
&gt; &gt; &gt; --- a/net/eth-uclass.c<br>
&gt; &gt; &gt; +++ b/net/eth-uclass.c<br>
&gt; &gt; &gt; @@ -347,12 +347,13 @@ int eth_init(void)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;Trying %s\n&quot;, current-&gt;name);<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ret =3D eth_start_udev(current);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D eth_errno;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0else<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (eth_errno &lt; 0)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
t =3D eth_errno;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;%s start failed (r=
et=3D%d)\n&quot;,<br>
&gt; &gt; current-&gt;name, ret);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0debug(&quot;FAIL\n&quot;);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else=
 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;PROBE FAIL\n&quot;);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; Is it a valid case for eth_start_udev to have failed and not set =
eth_errno?<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; Tom<br>
&gt; &gt;<br>
<br>
-- <br>
Tom<br></blockquote><div><br></div><div>Sorry for the late reply. I checked=
 the commit=C2=A0<span style=3D"background-color:transparent">7ad5e878cd850=
102e13ee2a5f8a5fb</span><span style=3D"background-color:transparent">69742f=
70b0 and looks like the issue still exists before that commit. If the check=
 &quot;</span><span style=3D"background-color:transparent">device_active(cu=
rrent)&quot; failed then the errno is also not set and we still return 0. I=
 am not sure if &quot;</span><span style=3D"background-color:transparent">e=
th_errno =3D=C2=A0</span><span style=3D"background-color:transparent">eth_s=
tart_udev();&quot; since that just ignores the real errno. The fix I propos=
ed is just to capture the corner case that errno is 0 but=C2=A0</span><span=
 style=3D"background-color:transparent">eth_start_udev still failed=C2=A0</=
span><span style=3D"background-color:transparent">for whatever reason. Othe=
rwise the logic keeps the same as before.<br><br>Thanks,</span></div><div><=
span style=3D"background-color:transparent">-Yuxiao</span></div></div></div=
>

--000000000000e0bda9065a5e17de--
