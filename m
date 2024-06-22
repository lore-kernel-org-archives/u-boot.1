Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A280EC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 13:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 854DF87B4D;
	Sat, 22 Jun 2024 15:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cgceovXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF37787FC2; Sat, 22 Jun 2024 10:09:04 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADCE287D10
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 10:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=muvarov@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6f1c4800easo304646866b.3
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 01:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719043742; x=1719648542; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFSsRmdQeAgYrNJXqoV8//gJaxRK6uYF+MxzCjEXOio=;
 b=cgceovXimFmRA5xxbffl7TWKposeQcWE9t6vjqZhNtajcqTLwmZyhJW+eZhnQwytCl
 oNqQjjfbyru3pr3+XWK8fzRKIL4rTJzROQ5mQA2GmRdnKG4Aq7BYMSscXn6XCKzRza78
 lxG08UF2D1P6KiJd2Coyzo7ZYCqsj5gdeVzPZFtem+iYck2/jkPtFFh9Szi4BcXfXLew
 +wPtIRIN+l0tbNYDgtve87DMXN4YgAGOXBDdr9Eo0iMCsOiwRcLHDFHiqDmoF5yHlqZF
 XA7C+DxaeE2FhRi/pYsdbyMKSivMtQngneeWAK5FRsmKkh7mxnb5LdxmRglc8mpON3ax
 bkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719043742; x=1719648542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFSsRmdQeAgYrNJXqoV8//gJaxRK6uYF+MxzCjEXOio=;
 b=NUMtEIhr1FnglyJslRoJUAhRo+0/lj1w18HJSGUtXNX80v3LIg7hMDn/HOZ/NiPAEu
 DKqSahkgZbBkP0nLif+fOYi+rBMtm0kIVahvMt08m6uerkg4x+yJKCHOB/ICFC16WeB/
 RELhvUvDQ/WkQNqdjeHrYsHjEkbwehzX5AzxT0lq3/xOs77j0GKSidsUkBl5xh7umVmy
 94Vna7/Yuxp0tTUTuaimVMek3h2QkzV6kw1uxge/vT1T2A3n17l0VSxwWPzE+90AEjD4
 0I4+CAhYhIMl9X0fXF+PZWvOxYpArcnP7j4o4VCqaUC7Ev0dbBW6nDpr3D9Vc1hkvSB/
 EOJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOMv6q1KG7ON40+6e3S2s5VdN/81FLufQysH6Neydm6ACHO0tUxxy/rmDwsCPpcChh3B6dLQlix/xmazEcTJ6SglB6+w==
X-Gm-Message-State: AOJu0YxGj9lJpcqFPBUBh6sLyA9Av2rmj0pn25a1EK34AowlzgqCIaZI
 8LYJTSe+5SoQTyalG1BE91SYAPQwhgH/3AqRfVLtWxQVIS4RktfJu5zzVGvWp6LxpJSNimX0bPr
 z4ZBIswRGi8UnCTfiPwMUbP9UsjE=
X-Google-Smtp-Source: AGHT+IER6wNtWmzh4319XYRyT2s6tWSzc5zX9SMnKItV/aYakAGVgba03v8Hci9k6eBiRh1iZsiaqtywysw/3LHrJJk=
X-Received: by 2002:a17:907:874e:b0:a6f:4d6b:c779 with SMTP id
 a640c23a62f3a-a6fab7796fbmr615490466b.52.1719043741724; Sat, 22 Jun 2024
 01:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <CAJ+vNU0yGH6FKZsx+UZXvnQnsT13U9iKUb68=Fqc_z7J0XL14w@mail.gmail.com>
 <0db93742-f8d3-45b6-9d1e-e4f687c2d81a@linaro.org>
 <CAJ+vNU3ECDoquHLyA3ULac0HkUGbzggG-bDQ8v0F2vStyr47gQ@mail.gmail.com>
 <CAOMZO5A4MS9eZe24WBSu4omfhjmwtjM72ftdQBwDWGd1wFiLmw@mail.gmail.com>
In-Reply-To: <CAOMZO5A4MS9eZe24WBSu4omfhjmwtjM72ftdQBwDWGd1wFiLmw@mail.gmail.com>
From: Maxim Uvarov <muvarov@gmail.com>
Date: Sat, 22 Jun 2024 11:08:49 +0300
Message-ID: <CAJGZr0LCGaKN_G54HMOmQx8y7cuER_OLGP6Axf2ksUQLhoSF8Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
To: Fabio Estevam <festevam@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 22 Jun 2024 15:11:38 +0200
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

=D0=BF=D1=82, 21 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 21:42, Fab=
io Estevam <festevam@gmail.com>:
>
> Hi Tim and Jerome,
>
> On Fri, Jun 21, 2024 at 1:08=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
>
> > I tried your to-upstream/v5-wip branch
> > (042bea36eb9731079a3d7afffe3774d79e06ac5d) and it behaves the same. Do
> > you have something else to try/test?
>
> Yes, when I tested older versions from Maxim I could never get lwIP to
> work with i.MX.
>
> Jerome,
>
> Please try to run the lwIP series on any i.MX board, if possible.
>
> Thanks

Packet not for us means that incoming packet DST MAC does not match to
the MAC address inside lwip. I.e. to MAC address set into lwip when
lwip_init was done. Original U-Boot network stack does not compare
MACs but lwip does. There is something specific on this board, in
general lwip with debug should print out
MAC used during initialization. This MAC should match to the MAC from
the incoming packet.

--=20
Best regards,
Maxim Uvarov
