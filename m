Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C759C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 13:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB97B882BE;
	Mon, 24 Jun 2024 15:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EVzzBNBU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B10B883DA; Mon, 24 Jun 2024 15:40:40 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2E1387DEA
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 15:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c2cb6750fcso794324a91.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 06:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719236436; x=1719841236; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QPqbc+wt3Z0bDFV312ryD+d4FGGMI2BL2HEr4RXobI=;
 b=EVzzBNBUO2v742ecjCg+EE3Oz0i3v8tPEq1a2H0gCx2yR8C70o6419MZ4g8wtsCg0N
 M3rw/oNpKHxCtg75gEZYVT6sBR6KOqCWdsUOZXR/DOAHa0rE0IY5mfxfHjqrettmRCav
 hSOxM0NCyjzOeTZ0s7qe0+qwPjjzQTWUodDjDhuoDCjihYEfVePKKP0JlB5seB9C9FMM
 vsefK0Upg5GBtTMqvwwfYb8tbZZ7dIVkRPDBqHlK1ZeqYMm8U/yiA7zBoypAV64OPVTn
 ReQrv73VC9sKWxftmvWROfyTC+gasqoJlFwuFMnFdixdhXRYQaNrrW6YKU5RGxbMyFgA
 Yijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719236436; x=1719841236;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3QPqbc+wt3Z0bDFV312ryD+d4FGGMI2BL2HEr4RXobI=;
 b=UOJgi07WYZ6E41byCnI2/0+v2EldUhqHMDUp4Orc0QBaJEhuEFDYNno2S9NDMdONoz
 h1tW9oyBXAXzI/WlTYk2QZtpaNeg7uecSPFf4e92t8fkiGly9n07FoxBLnQq0CDwJVTY
 /eBAL51k5C0Bz/t3YZ0JljmjPycV4K58XfB7A0+321wyBqawj0yfL1WHABc8XeU4SZ9g
 D0jIaIS+g8DYFq1sOUlCErmj/vvoyoMDmJPGmVmBvkS+iCAN4ALgqJCR7KeRhAZ5uUnd
 OofK3GfmJKUR66mJuBiS0Q0aEeFgaZF5xSRnHj00lB3gIk9TIbtJ8y+qPsHimrsDuWPr
 oYig==
X-Gm-Message-State: AOJu0YxocoNMgOyaelPeCHONdi6OvtCKwB4qWZOfDuYSmKnSpZWdtgtk
 /eVVIDxjjKUxSC9uC9aRsN28rJAhlz2ijEf22fXPBQC83Ozp4502FIymG6b1lH6ZPRryRMrbE7b
 HeIAO9jFlTYGFga7zMtWo8ej4MOil5w==
X-Google-Smtp-Source: AGHT+IERXE1yqpcflXmrxOAlnBJBVmHgLcr35ipFdM1tee+SHmYl1KDeks8IXOCmg81tNGEeeiDYXH38XqoU9PVhkTs=
X-Received: by 2002:a17:90a:db94:b0:2c2:d11b:14dd with SMTP id
 98e67ed59e1d1-2c8452e0fdbmr5183508a91.0.1719236436225; Mon, 24 Jun 2024
 06:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240620013018.2283965-1-tharvey@gateworks.com>
 <CAOMZO5DESaposvEEH8suJm6cGA-qqUQ=_5bvZY=L03bT09zk+A@mail.gmail.com>
 <CAJ+vNU2mmxivSRK_Q-d2Lbjk=41BZjdNm_=jd098oBkpqCUVhw@mail.gmail.com>
In-Reply-To: <CAJ+vNU2mmxivSRK_Q-d2Lbjk=41BZjdNm_=jd098oBkpqCUVhw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 24 Jun 2024 10:40:25 -0300
Message-ID: <CAOMZO5DYdfLYBcYxdejufUjy_JOexbw9b-9KYDZjpPfhwFEeYQ@mail.gmail.com>
Subject: Re: [PATCH] imx8mp-venice-gw702x: Drop EQos clock workaround
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
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

Hi Tim,

On Fri, Jun 21, 2024 at 12:42=E2=80=AFPM Tim Harvey <tharvey@gateworks.com>=
 wrote:

> Hi Fabio,
>
> It doesn't make much difference to me. This is a fix for a board model
> that was renamed from gw7905 to gw7500 anyway which is a change in
> dts/upstream I'm going to have to wait for anyway so you can leave it
> for next if you want. I actually have about 8 patches in my repo to
> dts/upstream from linux 6.9 and upcoming linux 6.10 as dts/upstream
> was last merged from v6.8.
>
> The set of 5 or so patches I sent in the last few days are all fixes
> of sorts and they are all isolated to board/gateworks/venice so don't
> affect anyone else.

Applied this one and your other patches to u-boot-imx/next, thanks.
