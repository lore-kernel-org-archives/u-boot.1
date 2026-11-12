Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3EF606A334
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G2QsDA4m;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v3jQOrDW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB5B740D69;
	Thu, 12 Nov 2026 14:39:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JeB5Eq1ufrk9; Thu, 12 Nov 2026 14:39:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C390040D48
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794494386;
	b=gFKEFOWyOop+Zd2XgfpRucKxOmVEZUvMhwZOLjBe416me90GszPUmHXIsEBYqfgDWXzT
	 ix27bwpHJor2tDJaO60voyEi6xC5oIrs9mk/+AkjpMByK46YbiWkajFKsME8gxGuM8IqF
	 nSPCLFWRCpOcfkPfgkPsXCFEPJedwavK8HYvt4JS3xckSqZ+IFh3rGJpdCTMOZH4JzRS0
	 zJgCabx0O+fjVpX+zZmpUMN30rLW1l/ry0gybJqHoxxTszcatWhUx2AeLYoqCfXeRvL4V
	 BwCz7RkRUpQDORJG/0aY+VWgcYjKJBEBoEEmkMjGXVcHaMv21FmtP9QTYHiLpalJYfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794494386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ekPu6HevynJt7LjPGuw69ilW5f+MUUf3Cb9xJBd+b24=;
	b=l066Qxca7f67UchdNJtsI8EK2s4jLQr8dqjyaFT6KsfTAcBJPlWrH0NgVl8oTxGBDaxs
	 mVXY0zNIYCeYO9GppdCuZa+MoJEwVdEON0iFMuoOB+sQoHFGuW88Pj1KXrW3/3pLRd1de
	 tKqzPLzg6wgbBNghB8NKT+FkEVyjG2BJV5inniX2Itjp/j0xgxjXycC2MkL0vloFAZCxg
	 Z9dRnnyxtkHp5x/1XbKbxAkUjmzJ13FTg93+Zv4W5or7dozQyWArZ3YEaRxuXH9sE/2Hx
	 tdiqJLiqDmphY7RIodLygMX/zyJlNiicmb5Dq016fLMWJ/PFvg2aOCxZ1ZAFxZSwx5Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794494386;
	bh=ekPu6HevynJt7LjPGuw69ilW5f+MUUf3Cb9xJBd+b24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2QsDA4mgHKIVPL7FkQ+zQq0nkCmKJMld83fiNM4+kipmX/Z2B6NUEi6QekRLru6b
	 40oPE+EHZ/XrkeVDe4PpFzkEkr9t8iHh79Ll4ACnPOT7nnyd+IvZnfl6vuhle1ZTdY
	 h+w3Gf+CjftIwKUvTAOBh9Fbty0xfg7HnYhao/lntcmQTEEef5Wn3jjJFcDSOgU08A
	 Wa8aECVRNmMpWA3Vik08shOEKshhGGGdm5zsFhORszwVbpuUwngbEYUqCuAbm/XeH/
	 Az8pLOUm1QOVDT+gA/MZKa7wNeurXdiLdJsQDeITERciPa10Z2pCeXTKHd4MzXoM/W
	 O28NCthp0SLKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C390040D48;
	Thu, 12 Nov 2026 14:39:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AD38AE09
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 935A4607A2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:39:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Seu3rrYQlr-3 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 14:39:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2752D6063E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=v3jQOrDW
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2752D6063E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:39:43 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3ab3dd966e1so34134141fa.2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794494381; x=1795099181;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ekPu6HevynJt7LjPGuw69ilW5f+MUUf3Cb9xJBd+b24=;
 b=v3jQOrDWeU9S5D8+Es1Ble4EiUwP4scxRmOkDJv62Nw32OmVK20/17QYR6ayIDym4M
 tRECbhTrMpt9iaBZ6a62Yuxjq8AogX6QMif07c6QVNpAX8zp0+dnIeIlAuAsKAFVkwAY
 CQ6fnmP/gt+qOdt4KeYxUR7qVt037CJFfUNT+4rEBHHSvOmDLTz2OtRjkH7zJyelSu4z
 bit4V49vwySrsHfyBxNVA9UyPLzJK1U7T2U0Hu1gyVaSkhnHH8itlShdqU84wYk6fdgA
 GMGlEFOWjgAHpU72AKFJ7RNv25YRVeINPM13+XSM42MPXfzApYS1neRTtAvGih1ATmP6
 6riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794494381; x=1795099181;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ekPu6HevynJt7LjPGuw69ilW5f+MUUf3Cb9xJBd+b24=;
 b=uPlR9kWYsxxnCPgo15+Hko6TAfxT5+qHniMRDRlNjpZD/ebftaOqyUaopCoVtwytbV
 +o2l+6OjdZSjfv9UMssFcfUcYIuvsc7F+y/fZHXeeHTLu2pXO1FsPPK4RM/zKMnc3M9e
 +IoNY8AziCFEYpH7JEgMgrrHuMv50BY9dZIUWWvetPLeRNsqrKo6ASTtlgavoyn0Qivy
 wnDGIk3DMKCoMGIyvU2VFKfu4hHIlKUvl2SXXw6UXdKivFe5kzrIq5gbe+tCpDUDW9LS
 /a9SUmlWY08m6w1m75i06hEKFV2+tbsgbhWam+tG/HAKGI30rr12toaGO9K3ZvlmAwjd
 yr8g==
X-Forwarded-Encrypted: i=1;
 AL+hErFlZmSaxfY/VBXbYoOu0SGHgDYT3xF09E4JTAqjkarZ82NBar0TNo1P1BNBI0FW3KYN61IK+VE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9RzwgEXkKU35c5dyMzSYIRk6Xf/SqzDVjus/apXOs8Un66AALr
 qBUWLWkG/yfjaB9MsI2sJ0gzROgbIgeNb4sHvbDjzpHq1A95faBco4SKwjttBDtoysRbX2q2OqQ
 d4ouzxzBFmtvbcsKVzch/jc8Mjr+8nybrjQ==
X-Gm-Gg: AYBFou3KDinH8cgUmBzf75+HenUK5aRbmBxh/q0dlwWqf5IvyJFKjul0WBUronv0o6M
 eTO+ZsV833zr5B9VuMdH4g/HfKG3wFs3Q/2sttWSdUE1RBha260jtQvM9H4tzqBIVoSBhPIhzq7
 310WTNkSZga/EwDWQeNMo1WEZXN5IjyTi+6t/52qg1JIXObVG7HvJEyIONjd2ey3yo8QVHMul5H
 owdEMVl2JNaLoKb8Hz7wbNkEC3OgKqe9taop+nVgZFf4AGqGyg2qYdiq9p+shMNzTRhRxw3Do0D
 ZJ9i1EFJZjMyp9D+N0GL59Y20GPeamUan7BT1qXxkIDiswy75SBoy+0XLAWwcXhWgM7CQd8i2Gh
 35CKBPN7o+SbTJsUQYibxglYrRMaY+BMBKXkbb3OuYoitVB774SLoq4QuzBnxxnIljhVGiQpbL9
 pOdUZlE01wYIdtnvCQNysy7jT55NzH71k5AH6AVB1IgwUQUP240P5MutJ/C6h4PfAILt5HOtse0
 SzOrW1RXCRGnRHqUpNjT9H7Jc47G3oz0Pc=
X-Received: by 2002:a05:651c:2110:b0:3ab:4eb4:5f19 with SMTP id
 38308e7fff4ca-3ae126bb069mr13675671fa.27.1794494381016; Thu, 12 Nov 2026
 06:39:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112115842.39126-1-pbrobinson@gmail.com>
 <20261112115842.39126-2-pbrobinson@gmail.com>
 <06aa5a02-0f60-476a-abab-aa3de9ad6019@cherry.de>
 <20261112141428.GB554944@bill-the-cat>
 <45f6a190-79ca-4eae-9291-8522307780ba@cherry.de>
 <20261112143135.GC554944@bill-the-cat>
In-Reply-To: <20261112143135.GC554944@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 12 Nov 2026 14:39:23 +0000
X-Gm-Features: AclHuK_qwIVG1PHu3L9a4LpVPVeZRG9hLXjd2pTPo3qvi8Q0ZVuyykuo0AgXX_I
Message-ID: <CALeDE9Nf0msp7LunKtCdissYCP31nTwwrcupmXtqpeFJgc_8Cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Update maintainers and get_maintainer.ignore
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="00000000000021cad00660154876"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000021cad00660154876
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 14:31, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Nov 12, 2026 at 03:22:55PM +0100, Quentin Schulz wrote:
> >
> >
> > On 11/12/26 3:14 PM, Tom Rini wrote:
> > > On Thu, Nov 12, 2026 at 02:59:35PM +0100, Quentin Schulz wrote:
> > > > Hi Peter,
> > > >
> > > > On 11/12/26 12:58 PM, Peter Robinson wrote:
> > > > > With the departure of Simon update the MAINTAINERS file
> > > > > to reflect the current situation of various subsystems.
> > > > >
> > > >
> > > > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > >
> > > > I see we're updating patman MAINTAINERS entry to Orphan... weren't we
> > > > supposed to remove it recently? I see it's been moved to Simon's tree
> > > > (https://github.com/deinde-dev/patman) so I guess the "find it a
> new home"
> > > > part has been done already. Is there anything missing maybe or can
> we start
> > > > cleaning things up?
> > >
> > > It looks like the MAINTAINER entry was missed, and yes, should be
> > > dropped in a follow-up.
> > >
> >
> > I see we kept a few files because of buildman it seems? At least that's
> > what's claimed by 91b94aff149d ("patman: Remove the patch-management
> code").
> > So maybe there's still more to do.
>
> Somewhere, but not high on the list of things to sort out, would be
> seeing what git libraries for python have evolved in the last decade and
> if we should just migrate to something else instead, yeah.


There were stubs of patchman that were left behind, this was discussed on
the thread that covered it, there's still bits in the directory so I left
it as is figuring it can be reviewed in other patches.

--00000000000021cad00660154876
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 12 Nov =
2026 at 14:31, Tom Rini &lt;<a href=3D"mailto:trini@konsulko.com">trini@kon=
sulko.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Thu, Nov 12, 2026 at 03:22:55PM +0100, Quentin Schulz wrote:<=
br>
&gt; <br>
&gt; <br>
&gt; On 11/12/26 3:14 PM, Tom Rini wrote:<br>
&gt; &gt; On Thu, Nov 12, 2026 at 02:59:35PM +0100, Quentin Schulz wrote:<b=
r>
&gt; &gt; &gt; Hi Peter,<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; On 11/12/26 12:58 PM, Peter Robinson wrote:<br>
&gt; &gt; &gt; &gt; With the departure of Simon update the MAINTAINERS file=
<br>
&gt; &gt; &gt; &gt; to reflect the current situation of various subsystems.=
<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Reviewed-by: Quentin Schulz &lt;<a href=3D"mailto:quentin.sc=
hulz@cherry.de" target=3D"_blank">quentin.schulz@cherry.de</a>&gt;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I see we&#39;re updating patman MAINTAINERS entry to Orphan.=
.. weren&#39;t we<br>
&gt; &gt; &gt; supposed to remove it recently? I see it&#39;s been moved to=
 Simon&#39;s tree<br>
&gt; &gt; &gt; (<a href=3D"https://github.com/deinde-dev/patman" rel=3D"nor=
eferrer" target=3D"_blank">https://github.com/deinde-dev/patman</a>) so I g=
uess the &quot;find it a new home&quot;<br>
&gt; &gt; &gt; part has been done already. Is there anything missing maybe =
or can we start<br>
&gt; &gt; &gt; cleaning things up?<br>
&gt; &gt; <br>
&gt; &gt; It looks like the MAINTAINER entry was missed, and yes, should be=
<br>
&gt; &gt; dropped in a follow-up.<br>
&gt; &gt; <br>
&gt; <br>
&gt; I see we kept a few files because of buildman it seems? At least that&=
#39;s<br>
&gt; what&#39;s claimed by 91b94aff149d (&quot;patman: Remove the patch-man=
agement code&quot;).<br>
&gt; So maybe there&#39;s still more to do.<br>
<br>
Somewhere, but not high on the list of things to sort out, would be<br>
seeing what git libraries for python have evolved in the last decade and<br=
>
if we should just migrate to something else instead, yeah.</blockquote><div=
><br></div><div>There were stubs of patchman that were left behind, this wa=
s discussed on the thread that covered it, there&#39;s still bits in the di=
rectory so I left it as is figuring it can be reviewed in other patches.=C2=
=A0</div></div></div>

--00000000000021cad00660154876--
