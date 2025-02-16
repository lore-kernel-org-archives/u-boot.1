Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEFCC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 12:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E14C80C7E;
	Sun, 16 Feb 2025 13:58:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O9hXHMwk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5779C80F12; Sun, 16 Feb 2025 13:58:31 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516C58056A
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 13:58:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38f378498c9so760193f8f.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 04:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739710709; x=1740315509; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9UhcTbbECujcMk0uWI54UPHmN72uqq9HJp9e36m/Mg=;
 b=O9hXHMwkVZqAfDp7nGHJr78lNLnjIgrrPj+gNS6nsX7dAcv7QUMotfgLDEfNwaBnK7
 KOR119q8C8Z/BnhQ1r0O1ceMR7xwe6BYc3QUggbTKD3p6tln4HYlI+v3hQFC98BD7tNQ
 9oDKb+nppK9lNWzcaFFCo0Mh4Bn/oHmViScxUDB2IYIlZo5bCbS8JY+cRfO3m6pfUi4D
 h0hvzJAv2g5G7zo/P+Act0wwtIrSyTTz54vmiCyMNm+dwU9b7VeyxJrgOi/bPw6LfECM
 CQ4UpCfHoQyGG36/Nd/qJWgAiJj+6aU4INszFbGKcDsYNoaqRphMdlcDLVoEIlbuVbOJ
 VTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739710709; x=1740315509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9UhcTbbECujcMk0uWI54UPHmN72uqq9HJp9e36m/Mg=;
 b=mL7Qx3t79bicbzXOqSIk5uhsKBaeEHTiFaHSqeQCenDbr6eOQq4ppEid/WRIyjmvvo
 Y8yI2g8WhVz5R5Z94OdUEr6yu2F94hgM0JaEoTtmLxcAfliTzqTopfgLpJVhBBAEWoVf
 4uiWc992lMF9EuGKy/yoo6MFieiQ2pcuKGKRQw6AQATIr/YhfXim/znKXLWg8X4lsTXq
 7svYEOI5xJDip7MjIIYso204TuBGoClt4Q9B5vLZWZjgoIw/bs/RgvsuoHwTCirXmzc3
 be4BpJTyivZqyjcfvOxoChCMVfB6bXQsvyYLSjNweDswvUsCeh71a73KV0CQGfkSNGBS
 rxlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2zCZM30XKQes0cchVWgXyuDK/ElG1yUzg569n538qm/kXCa/R8WSrGLinXZsRV0/d9zPsr2M=@lists.denx.de
X-Gm-Message-State: AOJu0Yz27BfG2iF5NH5IkHsv70pqU/mXlZ8xfY0PxF26wN1n4RdDDtzB
 SuKU+yPQ+TakH3Jo4aZgGYq1455MIY1UvqzD7mT60uI/EHFDG1zgAHjjxooC/913xZ7M6HTwIUA
 qmb7w/79TaS3a4d4Ov/lcCbxMdRE=
X-Gm-Gg: ASbGncvXTldQXYQv2v5xnZSBW8DShC68tWu/vd8TgSZ3xoXjl0JuJPW9Hmy0OSWXyQo
 gD6+sVv+wEu0s0c8VxYT+MJD9sgeEb4ps14mZhR98RcM0NvY6uJCPbuf0G+63SMg0GS5TAiBQJw
 ==
X-Google-Smtp-Source: AGHT+IEU9j/rPey9Hmi+Af/KIqNOGWV76CtAgottVcLX8C5v1zfLSI+DZi0V5jzmAWYRCdD+J+L8Nt4WXE72ubZ2Wts=
X-Received: by 2002:adf:ce8e:0:b0:38c:5fbf:10ca with SMTP id
 ffacd0b85a97d-38f33f511c0mr5819933f8f.39.1739710708426; Sun, 16 Feb 2025
 04:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20250215175534.203539-1-clamor95@gmail.com>
 <20250215175534.203539-2-clamor95@gmail.com>
 <CAFLszTjqDJdDUYVHchnrYn1e1_PTqCPusNCUWX_gBdncLJvMKA@mail.gmail.com>
 <CAPVz0n1O59cj_r0jDK59e+Q_YD1yTz9UASai+BtCz2AhVGr01w@mail.gmail.com>
 <CAFLszTimQBXGBqfG2BW8PYCXidQ+Rtr35Gh1jZVTXbC58Ujhcw@mail.gmail.com>
In-Reply-To: <CAFLszTimQBXGBqfG2BW8PYCXidQ+Rtr35Gh1jZVTXbC58Ujhcw@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 16 Feb 2025 14:58:17 +0200
X-Gm-Features: AWEUYZkeToYtrDf2eYgcksYbhdEUtNoj09bFy_AUeLgp0GykmDenAzzeYLENdNU
Message-ID: <CAPVz0n2tRNnUfL+Jr6j6M8j3y01Ge3DmP5XWNzcZjnwpKL7Emw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] core: ofnode: add of_graph parsing helpers
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

=D0=BD=D0=B4, 16 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:56 Simo=
n Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Sat, 15 Feb 2025 at 11:10, Svyatoslav Ryhel <clamor95@gmail.com> wrote=
:
> >
> > =D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 20:08 =
Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hi Svyatoslav,
> > >
> > > On Sat, 15 Feb 2025 at 10:55, Svyatoslav Ryhel <clamor95@gmail.com> w=
rote:
> > > >
> > > > Add a mostly complete list of ofnode analogs of of_graph
> > > > parsing helpers.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  drivers/core/Makefile       |   2 +-
> > > >  drivers/core/ofnode_graph.c | 217 ++++++++++++++++++++++++++++++++=
++++
> > > >  include/dm/ofnode_graph.h   |  90 +++++++++++++++
> > > >  3 files changed, 308 insertions(+), 1 deletion(-)
> > > >  create mode 100644 drivers/core/ofnode_graph.c
> > > >  create mode 100644 include/dm/ofnode_graph.h
> > >
> > > Can you add a test to test/dm/ofnode please?
> > >
> >
> > Sure, is there anything else besides tests?
>
> The other other thing is that you could mention in the comment for
> get_display_timing() that it is an optional method.
>

Wrong patchset, but sure, I will.

> Regards,
> SImon
