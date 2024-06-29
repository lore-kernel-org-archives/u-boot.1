Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA6CC2BD09
	for <u-boot@archiver.kernel.org>; Sat, 29 Jun 2024 02:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E166885BC;
	Sat, 29 Jun 2024 04:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RXyXGoHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77DDB885BF; Sat, 29 Jun 2024 04:33:27 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 026E0885A2
 for <u-boot@lists.denx.de>; Sat, 29 Jun 2024 04:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-79c10f03a94so100990185a.1
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719628404; x=1720233204; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jpcVPMHU01NUyo8aKtQlnGcmkJD6H4fhOgoaGz/rwAo=;
 b=RXyXGoHzYWmDyQh1Gnrpb2lWdUqTEfG9FkP63g5++Rap3potlFBgBEkQo0S9NMxdjc
 Nayt+nzUDgIe+iDbHdiy2Co4VxpHC/wdoEZeA4xejycMKgEP4L0SnnpelnEQTFuugzlM
 q2MjjIHTURd0iEzh6weE70b+Nwaor+MP7/0mxv04CXsAQStpTJXhrN9/G1/N4PY6PGu7
 2dr4NUmiwXfaNQ36jpRyL0/KhdzpuL6szWAxvfrnisOUP/YK4Lxt7N4bPg02fgBfqD9s
 +sf629zCaKdxL6dkf/7qGCfmmdi6H/CD+P4x7omUvTswDynN2vDlPq0z4xnSMO+EFDA3
 5vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719628404; x=1720233204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jpcVPMHU01NUyo8aKtQlnGcmkJD6H4fhOgoaGz/rwAo=;
 b=Aq3yBkD40jHTzg0Nk7XFrQZTzyJE3bNt1OGLucRgWRH6NDmoQN4+MBvCTfxNMLDcI3
 SB1arO9XrIesIhFvf0wuhabilLTX5oLHo8qeGCcf6icEPI6wjIyeObweRtF7HjEot3qH
 Hm1cGE2fkWDaa1/WpcbqNkXxpKr92TK0lmiszc8Yezi1uE8ikik3nXoHCIcBldPkZmPI
 9cfkocKsjNsTtVB6z4VTiR2ZJu6VWUbt3X1AnuSCNWKcE2Jpwz9IbFzTuX4/9T8wyUBT
 +X5XP49m89OBEaR/BdjypO7EYARQffvenJ2p+teEinLXKUGiJBziP6hYj/Ea0wFnLeHz
 faxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNkJPmvbty+py2D2Kogy9AaMiiM5bS+K4s6HJjXGlLto7lBAZ+V/dtEgXACPmfI4TX64qoV+D1jB7KdgCd63wRuHTYsA==
X-Gm-Message-State: AOJu0YydCCwW5faAel9GcMYpT31j7Y5N8yVLyRrgVAoAF2n9pjpEQIXw
 icmFqWTOR0dfcqER3IRYvgJnPIEW9EQS/CpqTgOKGo2lx8kPbR29m0Yy1a5SYvZVyrijEp/I54N
 MnAUewnM0dA+8+gD6RRTFWsdMMeZO9w==
X-Google-Smtp-Source: AGHT+IGtA8S+L3Vy+aHLcMnNtAxwL5SlGnwXXZiU6jGPdwfFTT6MF99pl+GepkFG0DkFGOqv+D2bT9dapolTDX341sg=
X-Received: by 2002:a05:620a:40ca:b0:795:462b:6e70 with SMTP id
 af79cd13be357-79d7b72104dmr7494685a.2.1719628403823; Fri, 28 Jun 2024
 19:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240618044946.270299-1-d-gole@ti.com>
 <20240628131222.4ev5rhmqepmc7qnk@reward>
In-Reply-To: <20240628131222.4ev5rhmqepmc7qnk@reward>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 28 Jun 2024 21:32:56 -0500
Message-ID: <CAOCHtYjWva2T+ALZL+Q7t7QA9wCojRqeAtbfJwns41XDJaG5BA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] k3-am625-beagleplay: Add symlinks for tiboot3 and
 tispl
To: Nishanth Menon <nm@ti.com>
Cc: Dhruva Gole <d-gole@ti.com>, Jason Kridner <jkridner@beagleboard.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Neha Malcom Francis <n-francis@ti.com>, c-shilwant@ti.com, m-chawdhry@ti.com,
 vigneshr@ti.com
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

On Fri, Jun 28, 2024 at 8:12=E2=80=AFAM Nishanth Menon <nm@ti.com> wrote:
>
> On 10:19-20240618, Dhruva Gole wrote:
> > Add symlinks for both tiboot3.bin and tispl.bin because a user has to
> > anyway rename these files to get the platform to boot up.
> > Also update the documentation to reflect above change.
> >
> > Changes in v4:
> > * Add the docs patch.
> >
> > Cc: Nishant Menon <nm@ti.com>
> > Cc: Robert Nelson <robertcnelson@gmail.com>
> >
> > Dhruva Gole (2):
> >   arm: dts: k3-am625-beagleplay: Add symlinks for tiboot3 and tispl
> >   doc: beagle: am62x_beagleplay: Rename the boot bins
> >
> >  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 1 +
> >  arch/arm/dts/k3-am625-r5-beagleplay.dts      | 1 +
> >  doc/board/beagle/am62x_beagleplay.rst        | 7 +++----
> >  3 files changed, 5 insertions(+), 4 deletions(-)
>
>
> Robert/Jason:
>
> Can you folks confirm that we will ONLY have GP version of BeaglePlay
> for even a new update of the board? If that is confirmed, then this
> series is good.
>
> Any thoughts?

Yeap pretty sure the BeaglePlay will ONLY ever use the GP version.

I know there is a list of wants for BeaglePlay2, cc33xx WiFi, the
newer ITE HDMI encoder (oh wait, BeagleY-AI)...

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
