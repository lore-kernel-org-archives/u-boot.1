Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E23D63935
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 12:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C01CE896B0;
	Wed, 20 Nov 2024 13:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PIFPsvyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F29C9895F0; Wed, 20 Nov 2024 11:56:15 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B8D89533
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6ee724cb04eso2927577b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732100172; x=1732704972; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHDtVboIp/4t2hGeex6iqLgMyK/vtGaNLnMONzHgwww=;
 b=PIFPsvyiVeIU3wM04GFkO2eNLwQg+MI/0/RXeiljv5xEMnhm7iEXVxBRz1OXvRQPkf
 DqgHRwClVCfxLQgkodmQNNieYyomkwR0KNZz8MsvfQPYGgOlNPjsu8j+eFlfLePMoP+v
 eBXDJDMsgfMrJDPFu5lCNAZBhfDpXBgstw7JxNKpnfO8RKV/A0eEh5yJX7UsLULzf/7x
 Iz+k0dD2LfJOStcieLn+bBi33Mje2h46Am/o6GKjhjLvPJjdnQ6u+qndPqsW4ADbQ6vM
 LLL6e1q0Sj6uz2tQPqvsKPrpKETTH/DoAX6EwQCTwazlPks9JcMUN68IufQKshhxszSO
 Tn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732100172; x=1732704972;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHDtVboIp/4t2hGeex6iqLgMyK/vtGaNLnMONzHgwww=;
 b=Hb8SVO8RVCp0k0Ylj8AQxoix3jnOOe9DKGGmjT8WOThCMuYP2HFKKVdDbSOr61cMOS
 zKHTv8l88U+YIVyYrjufQUQw4V/byIBIC23T5YmiDLEQb9YHrv3fRrXRi4FruEZ0YI3/
 Ld/jrdDDkFrpPs03vn3GrbGUgnNG6b/yl9nFPzzWD+f0aKfotXeHWRpGdEr4XAkFK36y
 zOv1CoLkLHg/zat4NfSQahe7zsxc4IS6UhPH6Mt0vT46TULtMx2atwNFnJBrMrUAefSh
 ED9QUxm6Nxu7HhM+D4+HW3zdz5qGoW9njeg5BBdQ1yCi9bERld0vo+miyr9DEZ59Vzeu
 W/2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ5Bwo/k4OynF0BxjNuIn0xUpwjvDMRhi2c5/bRHNXhdXBFwu6NONPVhJ2cTMc10G8Znvb6Do=@lists.denx.de
X-Gm-Message-State: AOJu0YwDT3k31OBUXzqxCAL/x0nvxDk80wSX1c+U80xIGNdOw+QROaK9
 WbkHthj9xQ5DT71aCK19/2eu+iXIYIgC0LmnQos3LFCcosxbQBZdNut1fCk4SUOk+slFBalPEET
 TSiBtvWED/NONwz2U4c3mffY1Zd8=
X-Gm-Gg: ASbGncva4tFwyFK11iHURseWbK4/hcjNFj9/J5mqEFZgx0Fw0ejPPt2RN3WS6wQWiPQ
 2BfdSUczMrYeNhDDPALR8nSpwB9t5gVk=
X-Google-Smtp-Source: AGHT+IHOxPoryXwrA/Na6094H8n9ecSOzVsz0ZZ7EvQoIosHaAhIrbU3NbwjjK2BN6WYS6x+wi1qzwRHphP4VB/5MIY=
X-Received: by 2002:a05:690c:6303:b0:6ea:9fd0:346d with SMTP id
 00721157ae682-6eebd0f51efmr8046897b3.3.1732100172258; Wed, 20 Nov 2024
 02:56:12 -0800 (PST)
MIME-Version: 1.0
References: <20241119222837.27550-1-l.rubusch@gmail.com>
 <20241119222837.27550-2-l.rubusch@gmail.com>
 <316ED154-4011-41B4-8565-CD37C95D72B8@gmx.de>
In-Reply-To: <316ED154-4011-41B4-8565-CD37C95D72B8@gmx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 20 Nov 2024 11:55:35 +0100
Message-ID: <CAFXKEHa9dHgB=esEzEiVAEeb7H62bgEu_-m--ZQzA2ufL0SHCg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] doc: develop: Fix typos and wording in
 binman/binman.rst
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com, 
 ada@thorsis.com, mkorpershoek@baylibre.com, 
 dario.binacchi@amarulasolutions.com, pbrobinson@gmail.com, n-francis@ti.com, 
 afd@ti.com, al.kochet@gmail.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 20 Nov 2024 13:56:12 +0100
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

Hi, thank you all! This is outstanding, such a fast feedback! As I
also just ran a tool over the texts, adjusted formatting and
reverted/accepted some changes manually to my knowledge (I'm not a
native speaker). Please, could you clarify the following?

On Wed, Nov 20, 2024 at 12:10=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> Am 19. November 2024 23:28:35 MEZ schrieb Lothar Rubusch <l.rubusch@gmail=
.com>:
> >Fix some typos and duplicate words in binman.rst.
> >
> >Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> >---
> > tools/binman/binman.rst | 238 ++++++++++++++++++++--------------------
> > 1 file changed, 119 insertions(+), 119 deletions(-)
> >
> >diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> >index 381e55686f..620b5fa048 100644
> >--- a/tools/binman/binman.rst
> >+++ b/tools/binman/binman.rst
> >@@ -5,7 +5,7 @@ Introduction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Firmware often consists of several components which must be packaged to=
gether.
> >-For example, we may have SPL, U-Boot, a device tree and an environment =
area
> >+For example, we may have SPL, U-Boot, a device-tree and an environment =
area
>
> Both devicetree and device tree are common spelling variants. See for ins=
tance https://www.devicetree.org/.
>
> > grouped together and placed in MMC flash. When the system starts, it mu=
st be
> > able to find these pieces.
> >
> >@@ -19,7 +19,7 @@ together.
> > What it does
> > ------------
> >
> >-Binman reads your board's device tree and finds a node which describes =
the
> >+Binman reads your board's device-tree and finds a node which describes =
the
> > required image layout. It uses this to work out what to place where.
> >
> > Binman provides a mechanism for building images, from simple SPL + U-Bo=
ot
> >@@ -31,13 +31,13 @@ needed.
> > Features
> > --------
> >
> >-Apart from basic padding, alignment and positioning features, Binman su=
pports
> >+Apart from basic padding, alignment, and positioning features, Binman s=
upports
> > hierarchical images, compression, hashing and dealing with the binary b=
lobs
> >-which are a sad trend in open-source firmware at present.
> >+which is a sad trend in open-source firmware at present.
>
> It is not Binmans support (singular) that is a sad trend. It is binary bl=
obs (plural) that are a sad trend.
>

Sure. But isn't it possible also to read it like this (below)? May I
split it as follows:
"...hierarchical images, compression, hashing and dealing with the
binary blobs. Dealing with binary blobs is a sad trend in open-source
firmware at present."

I mean I catch the point here, as anyone else probably does. This not
a problem, just let me know. Or, if not, I revert to the original.
