Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C77606A32A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NMVyA0e5;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DnyGbYhn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD64260608;
	Sun, 22 Nov 2026 10:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pNGbqB3-N1K4; Sun, 22 Nov 2026 10:56:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 104F56060B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795344972;
	b=sIVV0Aw4nyI2hybCZXeOuirFk6dhA32JtjZ7uHCd9pUhkzEnuTjthO4gx8CzVLaTaNap
	 LWO2abWb3FAFSabVkoX+Pp/zEjd/H4Pja4gHz96AcrsYltfMH9S9wTnAGI9htVvFbdS5w
	 v+VN0aIB026ZXsGg7nXvh2A7S2poSi6pDEVS7kmzmTAYv1UZDspBFtT1E7G/6X3faqz64
	 0UZ04ePSh0GRPg8QBHk/0lO4rfsr4eZ6KhvBSc7ZwHQ4efrPV4QHUaX04g9yjX5T6foFi
	 ygPKJyA08SW576IbPKpe+0H5ZHDi1iag1FqygrI/4dirPxzPj99ygk3Atu8Wf5GgbRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795344972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DyceCgyZetmF1OVwYwVz9H/Y8yBkF+VdfYFvLco/ZeQ=;
	b=gYHYoaSZhOZIFTJawuM55pUUun4v7Y/Nys5XVQGWXSHlDklw+Ywsei6QOMUH4S1fHMvu
	 9ATI/wGGTDWT8UAfCMZ92SV9decPAcjyRrnW1o3TWL483wwAXAdyl/dPmFBsCdiEXH6nm
	 LbfOpdpidisazQzGElS6qc7UGuLZXBwcaihRwHhN9IdX+noXBkmhLfUO8tuGvcQ95hVRh
	 zioBtj/UJGK7kI0eEqdV3rnnW1kOEppJ40Iefi4DjUw5AGMGBky9Kkf1cWd33hodV3HuR
	 COvLkl79psrBerWF6NOrH0Tjp3JScSj/wXLKlljTKmAJFXmbEmBZ1tHRG8uEs1PVL1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795344972;
	bh=DyceCgyZetmF1OVwYwVz9H/Y8yBkF+VdfYFvLco/ZeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NMVyA0e5w6iwaUPISPbsp0ChKxt5cAqmd5k+Jt1wFbMw3G8xtv/brKD4HCbJBvnEC
	 137GClwDkIw7PxYRDZJj6M8WI/bgwaspgvAznZQ55QBFfM2JNVqcTSVVAcHLG7cL0R
	 BsWqHKJhgAJKr50tQoVYyx+CDr1Jwc1ZSfuGCpklKMJvQ6iDcoz/EBsmGebT6iw0bi
	 v8vncMokOhtXrsizw1mBfD7eV1ucr+FN/vkyzxVLVmgihKtI5vEdmBoXjo8x3tIZWE
	 6pDgfBBKugWt9XxePkDr2QfuRkbrZUSoIf72MXwsBYIFy1oqO45PFLz1wWoRlG+MQA
	 BHlqzisZg5v6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 104F56060B;
	Sun, 22 Nov 2026 10:56:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 33A1A260
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18FD480E12
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pdeo4ATW77TK for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 10:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28A4F80DE1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::832"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=DnyGbYhn
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 28A4F80DE1
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:56:08 +0000 (UTC)
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-55ade1de0b4so29817661cf.3
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795344967; x=1795949767;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DyceCgyZetmF1OVwYwVz9H/Y8yBkF+VdfYFvLco/ZeQ=;
 b=DnyGbYhneLTXWdbVW0vVgLNLQvcGw71dR18gMZoMIUFvLd5+zgaZW6E4vs73WO4bPh
 vxepxnd93r99vDbFJV6jqU0CH51AKtrZ41XLXEDjTaI6xWMDANkU6ZF+8tNOF0QTxjnF
 KH7ah0dDeczwwfgSCT/9DE/PoOWyTmYBpHhhRMAf1FeYXl/upw0q6uw3i2fJRbozEZl6
 3bhvao3teZBoFOdzTCi6OztBqHLzbfd+o1Ky2sCEoow25FmyDdmGy39ZpX9R+zEBLC7U
 xgDK0hKDjuQSdw3dPM+QDED6zj3NmGIbamX4QGPxnobiO1vBZHxdDNy4SGm1LKvViDoN
 +niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795344967; x=1795949767;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DyceCgyZetmF1OVwYwVz9H/Y8yBkF+VdfYFvLco/ZeQ=;
 b=WNN9w6ndLJvUw8sFrMPkxN0vNTSF3RdXEDCHHsNNs4OjudTUnOPjs/98trO0X7oVgX
 8lc+4QdDV0seb7bThs5qJJs7z4YNM3j3E8t3g9pMhhu5t6N2DBzu2qZDlFZ1llA/OqzD
 d4cBZAjMfm8ch7p27N6CPX8g7ivBgj4KPvrnBi9tVllB0NxqPkYVwl9Jkbx4gEunVnAf
 xuWjDwqH++KA2xCdIzuiSKLB+7VR8Mb0pvJx4zquMQ5B637ZmWVvNCLd3KPSEXqAC69p
 vbU79QHvZ6JWVsRo3pgF+Xgy+vxif7sJK1jycHR01Qy6kstYdqzg91A/EKDARdGdP1uH
 jSSg==
X-Gm-Message-State: APuU4Z/OMDjCZ1maju1oIwDWLbejBR8UttuIBAX//DSdT69t30m1Mg1y
 FEUbg6zJVUFwY5KQX6fFhVTWqveuPjFDYjcFk25p4+N0/3+ajuolbeMYSwD6CMy1dUHfLB2iJgj
 65yCw9HLPonR2w7PWn2UrkzNBWfz3pjC5CpLgysg=
X-Gm-Gg: AZFdTZfrAkjN6tDEuhX32+7q1wGFMtccbE1UTIXXjH4VGiviyDrJtS1DLFOABHxfK7O
 98rADQ/EPyza0gbsgToanF4b14tDU7kVg8QffiEtGfB0fZ6MGHxeLSMulHcrtsZqlkZ5pC1l3SS
 q6fFPbbv3Y1Zqc/yPTFAucLnPFPyZ5poNle/ENgcM7p4vltXKxobvdT+LpYdRuJ9A6NbErw1g6x
 g8tViJSdHLTlcgMp0SK15ghlrLO36mpLRTYQs9kC7MOzIxhX8mRVd/72IOp3rwFxF7vaSd3HdaY
 SrUWfqcYk6+ehcO7RVVJNBuwwOQhXu4b1E/qb0SvQrLCn6NWvM1tCEg9UpmvZdwNGk7G51EV3rj
 D+sYtrwlnnDVsJBdwEfa4ynKOqDZbvcpv8DaS56kH6UR2hawx+vC15xEWbeChi+hrsKIApGrf7a
 orm/U8gBxXMV76qk2rk7cCkSVeCaOW8heneJsmg4Z9fFjcNCvRqTDSCITusOIKQslkLRu83BXMq
 BC56w==
X-Received: by 2002:a05:622a:17c9:b0:55d:6e81:2034 with SMTP id
 d75a77b69052e-55d76ae21f0mr149924771cf.44.1795344967183; Sun, 22 Nov 2026
 02:56:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121092137.2797011-1-pbrobinson@gmail.com>
 <20261121195816.GI3176972@bill-the-cat>
In-Reply-To: <20261121195816.GI3176972@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 22 Nov 2026 10:55:54 +0000
X-Gm-Features: Aa3M54pDyFFJbJvOQR47kihUemRxmAtCr1h2Fk33R9RqsGJfkpAP3_QE86pmpd4
Message-ID: <CALeDE9O7jbQ_2hPC4BP9P9EJzeHmjAeQqjKf6miuVTHYiL8jRg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Move PLATFORM_LIBS outside the the
 whole-archive region
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="00000000000004b27b0660db538d"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000004b27b0660db538d
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Nov 2026 at 19:58, Tom Rini <trini@konsulko.com> wrote:

> On Sat, Nov 21, 2026 at 09:21:33AM +0000, Peter Robinson wrote:
>
> > The LTO link passes $(PLATFORM_LIBS) (-lgcc) inside the --whole-archive
> > region, forcing every libgcc.a member to be linked. On AArch64 this pulls
> > in members needing libc symbols U-Boot lacks (__getauxval, abort,
> stderr),
> > so the link fails, e.g. on p3450-0000. Place $(PLATFORM_LIBS) after
> > --no-whole-archive, as the non-LTO link already does.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 840d02aa6ca..4323d5ec701 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2103,8 +2103,8 @@ quiet_cmd_u-boot__ ?= LTO     $@
> >               -Wl,--whole-archive
>      \
> >                       $(u-boot-main)
>       \
> >                       $(u-boot-keep-syms-lto)
>      \
> > -                     $(PLATFORM_LIBS)
>       \
> >               -Wl,--no-whole-archive
>       \
> > +             $(PLATFORM_LIBS)
>       \
> >               -Wl,-Map,u-boot.map;
>       \
> >               $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@,
> true)
> >  else
>
> Is this still an issue on the next branch after Josef Schlehofer's
> series? I'm wondering if the --gc-sections change there fixes this too,
> or not. Thanks.


Yes, it's still a problem on  p3450-0000_defconfig and this patch still
fixes it on next.

--00000000000004b27b0660db538d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, 21 Nov =
2026 at 19:58, Tom Rini &lt;<a href=3D"mailto:trini@konsulko.com">trini@kon=
sulko.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Sat, Nov 21, 2026 at 09:21:33AM +0000, Peter Robinson wrote:<=
br>
<br>
&gt; The LTO link passes $(PLATFORM_LIBS) (-lgcc) inside the --whole-archiv=
e<br>
&gt; region, forcing every libgcc.a member to be linked. On AArch64 this pu=
lls<br>
&gt; in members needing libc symbols U-Boot lacks (__getauxval, abort, stde=
rr),<br>
&gt; so the link fails, e.g. on p3450-0000. Place $(PLATFORM_LIBS) after<br=
>
&gt; --no-whole-archive, as the non-LTO link already does.<br>
&gt; <br>
&gt; Signed-off-by: Peter Robinson &lt;<a href=3D"mailto:pbrobinson@gmail.c=
om" target=3D"_blank">pbrobinson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 Makefile | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/Makefile b/Makefile<br>
&gt; index 840d02aa6ca..4323d5ec701 100644<br>
&gt; --- a/Makefile<br>
&gt; +++ b/Makefile<br>
&gt; @@ -2103,8 +2103,8 @@ quiet_cmd_u-boot__ ?=3D LTO=C2=A0 =C2=A0 =C2=A0$=
@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wl,--whole-arch=
ive=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0$(u-boot-main)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0$(u-boot-keep-syms-lto)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0$(PLATFORM_LIBS)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wl,--no-whole-a=
rchive=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(PLATFORM_LIBS)=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wl,-Map,u-boot.=
map;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(if $(ARCH_POST=
LINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)<br>
&gt;=C2=A0 else<br>
<br>
Is this still an issue on the next branch after Josef Schlehofer&#39;s<br>
series? I&#39;m wondering if the --gc-sections change there fixes this too,=
<br>
or not. Thanks.</blockquote><div><br></div><div>Yes, it&#39;s still a probl=
em on=C2=A0=C2=A0p3450-0000_defconfig and this patch still fixes it on next=
.</div></div></div>

--00000000000004b27b0660db538d--
