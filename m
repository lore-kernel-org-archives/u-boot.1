Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD338606A32A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H7omOvQR;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WzxvY+1C
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9C2860628;
	Sun, 22 Nov 2026 10:48:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jiucs8IcQtzx; Sun, 22 Nov 2026 10:48:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CBE3A60616
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795344493;
	b=PSF1aeoEUplG6GDSL5z5NmuSyhZWakPnzyZe8E6Oc0Y42IGlurd0Uqfj5O/AuPd6w5dB
	 Nfg7Z7E39LJocmuaQ7rNaJNazYrhCXW2E8eodNfaEf4bOMsyPBYUDK/PtcMJF6tgzFIOv
	 VtGl4aAWi3YCefyViOTVvnAKZHrXhdVj4Wtu3r3eBG5AvkmTWrE0BCl7wNvFo5r9qO8i8
	 foZfpBk5Z2qs4gYTBydsBHFD4NcfAH26PpJyTwe7GLXi7eUfYQwoeIQpLsX6yAnfxzHht
	 AT3kngoa2svrMkafO1XGPczge7p3FM95aNlqv5ASkjJhnczP3ZrF15FmbS3oI1HFPDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795344493;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CWzI0lRby+KcPbl4zdhEyBeoIuO9tVEL+zCYDrWqqSQ=;
	b=NAXmieINOMggiwWudfhBQxGadwG5xmxAD8VUXgUQqnKv8GsPrzSPvisrskS/3pRt69NM
	 +8WJTlzm5ZJxR/L+aVTerYm3RVjPuZMuXi+s5bO/76KI28XlY+Qkygl6Ao8V/qn++YnYL
	 MjnVDqySoPr5nn3UYeoewycFqgD/IFGhuwJZjJG6iaxZDGwx5Atb+z9Yk+GN3NXOUGLs/
	 h0gy6KYMtWrt/CFD5skjAN9J7xQNVLx3HvOyteRocpdNdAQJB6KnJkYDzpdRjdEHFHdI0
	 iFWl3VPANh10qPPbY/KoX1yKZf6531s9qhl2RD4jX2pmSQ20gGogxKDR0dlPd0FYGFg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WzxvY+1C;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795344492;
	bh=CWzI0lRby+KcPbl4zdhEyBeoIuO9tVEL+zCYDrWqqSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H7omOvQRNWC4JqeItoWk2hf1sImdzvv1O4uSbuirRZdySbr0oWvDx/6hj6qY9Kyy+
	 59yvlvRHGRtsGmiVJ9wic/c1wH4sXdMu19qAaJVc+37xVwd7nTpaFy7n573dFYvQ/7
	 iZR3BPFgcQ2upYC6SPjNJQTwPbdHEIrs/IHLolKKM83OCRP4hnXbGaiHVUs81kd6CH
	 Et2BXBAKl0irjrq7DquANRgoMgaJaPvPb1MKc6/YpmyGyeClIUtxQKDYteMcYLwDlS
	 HaR9rTRArAai1VC90NlWErMorSDxm+EqGDUcuZdsa4TQ4JjCaTkz5L/jNpf1SACroK
	 i9iZseNFpTnDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBE3A60616;
	Sun, 22 Nov 2026 10:48:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 86BB5499
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 842DA60616
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:48:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kuvOHCGXdJJ for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 10:48:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7D0B1605D5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=WzxvY+1C
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D0B1605D5
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:48:09 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-920fed989b2so24773416d6.2
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795344489; x=1795949289;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CWzI0lRby+KcPbl4zdhEyBeoIuO9tVEL+zCYDrWqqSQ=;
 b=WzxvY+1CvEo5MV9zhWOvfGroTuB43u7WR07NpU+FBOsJJ6LSgZeMI9l6Drv+LrMbJ9
 59fnwGJ0IYBDC4YcKni7Jq/lPHnsE3Xn1et+7fZtUHlHhXcyZ8FVQwYvakJPepNmcvSH
 GJG57pxcmO5hSi4aKrak7atjvNmaSZXWWBErJcPSkIHgpyrFOstZBzkjcRbENFE4qskF
 WyXy5eLgsrfoAccCdPb9NOOn8PEe31F4KNOqxiyJpL3/RyHcKBRF8KwxB06jfM4Vj+pt
 Xwdj2suJyEfVPlaxohKWrU+SjuswywR8YUHmWqBZjEqeK6Op/JouMQ+vpvDbc8UlyZhV
 do0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795344489; x=1795949289;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CWzI0lRby+KcPbl4zdhEyBeoIuO9tVEL+zCYDrWqqSQ=;
 b=Us1RHT2TxLnkrH8ijn5T9kvBq5Tb4xV+P5JOZzluplqRK58ktJiaZmVJa23jciHViO
 R8doIT7M0DjQOv72eaQHOqv+Kj4/HFMcD/jzkuMNfYtJrRq3QL3C4Hiyh0zHQC7oyZw7
 V3hUoVC+dV9pOg5GaoDlUzK8rcqiSYV/o88otFtVurRGbkfMUxnIoTkfMJ4QugT8gsRW
 3HLytgTXVCc1UnieEVnf6ICTrrUEC2wcTapD6ipZhjiVCH7W6QRL1Cc+psbcqeNTxH2G
 OibYEe92cQGSKG7bX241bXARu9fOQIKXkcPWh7019v9T2nPHkhzyYhzwT/8HKSp63B4K
 AVhQ==
X-Gm-Message-State: APuU4Z8VLTq833cuHCZcthKPFtb7hHdouADwdRSNdtMnUAjhGZ62G2Fj
 nCYqrAzXHagYeV/xlL6i4RWL5w6NM4usmy5fnuxEanuBkpbftYnjwuaTaOJGYrM6eY4fN7OzqzD
 xP1gukquPp8Y/SSz1Z7AUwKSzb1HMtKdLVN5y
X-Gm-Gg: AZFdTZf8se28POhXPSkADnqF0t/hUdjT7IgsjeVi47+vqxJbk3kTfutxQrxAYQT+Gaw
 MMm+Ut1EA2MVfXmVXjy9zjwFbuxFTM4Rfm2Tz2uwXtGW8garQb78AHfYhYiB9mGIR+45qoNL2SG
 o1V5/xb9SHS2ScoZqynaYb0S3LqHPQfzMJkjV8g8OMfZEQaqMHhGplm+voxFOrbBB90Jmlrscdz
 4MGW3lzsh96qlK63AFPYuSzIeH0IuR1HLddzCDl7ddOfc6+LWdfWtEKxHgi6cmZEDE2lfIKVuSN
 oyqAcE2rYnAnC3GBlLyi5PzzMyTpWLMQdKjRfxAnIz6f9olNIXDYgcX9poFMqpTrTQi4njxZJzF
 zglTLWG+VI+svzznu7mEQ/uItXLBbpQSSz0Oq8X4IdqiN8fHjrfUb7xNe0AATWRizJj3WHd5rQo
 /j9vbsygaZs6HgJRELByZVTUFCJ9JdIpStM2xc83jvp4HC0IzLVDYwmmXRou15dbUPiPP07aY4M
 n6ep/RjabqrW6UhKqhRN81KJukw
X-Received: by 2002:a05:6214:488d:b0:921:37a7:d1a8 with SMTP id
 6a1803df08f44-92137a7d247mr137067226d6.1.1795344488639; Sun, 22 Nov 2026
 02:48:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121092137.2797011-1-pbrobinson@gmail.com>
 <20261121195816.GI3176972@bill-the-cat>
In-Reply-To: <20261121195816.GI3176972@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 22 Nov 2026 10:47:56 +0000
X-Gm-Features: Aa3M54qmB2wM-OVSP1Vy0AETQHVRpEQ49f8seoLPZdT5__BmXuz3zdMQLCiLmas
Message-ID: <CALeDE9NCJ+fCDb=BTkDOKYUggynQEQVjD-CONG7bAXrqN448Ww@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Move PLATFORM_LIBS outside the the
 whole-archive region
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="0000000000007eb2ac0660db36c1"
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

--0000000000007eb2ac0660db36c1
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


I haven't tried next, but certainly it wa still a problem on main. I can
try that next week though.

--0000000000007eb2ac0660db36c1
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
or not. Thanks.</blockquote><div><br></div><div>I haven&#39;t tried next, b=
ut certainly it wa still a problem on main. I can try that next week though=
.=C2=A0</div></div></div>

--0000000000007eb2ac0660db36c1--
