Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A26C54744
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 00:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3844488A74;
	Wed, 28 Aug 2024 02:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OkwQxgvS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AB4388A75; Wed, 28 Aug 2024 02:21:11 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29311887B9
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 02:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53346132348so7291227e87.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 17:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724804468; x=1725409268; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBznrfm8+T5nbzI943LCuM99GhGMKtbo4taxXLC9ZTA=;
 b=OkwQxgvSStdHyeHONDph20JKnvOzI3YqGFYlw4q5qIRp3IAfzs9+LeWDisBj0zBc0q
 l59iwGKgALvslZwEvUPo+8NMGX0Gu3ubJ0ZM7poF3DcmvV4GmnVO/UzJ/pSVX9xrxL+l
 J/AVLqAVybhEv8yHeG3+7obmczu2Zi/Aj0MjYHIsZF1gfSLmcrheFATfem4PsE5bfTPI
 NrA4/r2b0tDRRB2i16QUGymO/jVh21US4mH6U9MeZBR+1nBShqoHpu2kmAuGx0osw6sm
 NOVRwcNQk7pakrtaQ4jd5hRpqbp5wm5cNlFzAH4ciQFqLavhKPGXM1/V5AlIHNs75XGV
 Qtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724804468; x=1725409268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mBznrfm8+T5nbzI943LCuM99GhGMKtbo4taxXLC9ZTA=;
 b=gQs4q+fU0uo1PIoxfG8qu2KPEQ1+UpDERV39DkKb6RIHF2mrg1KAvaaxvIfRokCSBK
 YKJtOxGuVA3UhXWF5nXCKo9BZ4ApppdfqWccCPnEibtz36yXWbxWaCK6MCMZKMSbQZn6
 /04oGzv/lQJ+KRye+PBPFDZoz9R4JgdqTDsdnc7WVg5EKFbH5REymwBTQllQD6UcI7Tf
 hVMcFBdEd7Z1O6oQVPqObFe26rNioTSeiYq9qbYkzOcCS9OOkhRhyK4jcXFHWRi0PjGa
 142yEPZg8VPowFtWs3k9VPbBVVXOwsWMjXUEj4tfHEeNwbKb3CjbSVOgAXr/s4F3Resh
 Bt/g==
X-Gm-Message-State: AOJu0Yz9+XsU6mC+QLp6QcPAY0F/iXCYol1W/E7NqLkpm8meQRnhehyv
 uhQbwTO3q5cb19clz2BFnGtNlA7wBrjnOTPqMMhv5C9xaSOr+tDGIB56lPymRWgwAGOxZJGiZ36
 p7iNBEOKL/QP2l21EV+tfqCr85pc=
X-Google-Smtp-Source: AGHT+IFPxrXEW23jv4eE9c2ATS9iCvUqerGuqKJ1ZPAL/TE4K1BmfNJ++RImwokRhsHg+VG+EM7bdy/1y08Sl5RMLBs=
X-Received: by 2002:a05:6512:3191:b0:52e:f907:1023 with SMTP id
 2adb3069b0e04-534387c49d7mr10154146e87.49.1724804467958; Tue, 27 Aug 2024
 17:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <GI.Za6b.48b6UC5Rsur.1cpWwh@seznam.cz>
 <CAOMZO5Aj9zSEWF9Gm5-tF9hTaczf6FXv0zo_z+Jws+BGPYPwrg@mail.gmail.com>
 <K9.Za7d.77W3I8GjZaJ.1cpYlf@seznam.cz>
 <CAOMZO5BshEknpJEeEiqip3e_YkN21kAKtKva0ik=8SKGJxmngw@mail.gmail.com>
In-Reply-To: <CAOMZO5BshEknpJEeEiqip3e_YkN21kAKtKva0ik=8SKGJxmngw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Aug 2024 21:20:56 -0300
Message-ID: <CAOMZO5A1r4F403efkpAPbv9zJD7bjv=aHB8SgOK3pPXtVvzE2g@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc_gpio: fix reading state of GPIO pins in output
 mode
To: Tomas Paukrt <tomaspaukrt@email.cz>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Tomas,

On Tue, Aug 27, 2024 at 4:53=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Tomas,
>
> On Tue, Aug 27, 2024 at 4:41=E2=80=AFPM Tomas Paukrt <tomaspaukrt@email.c=
z> wrote:
>
> > Hi Fabio,
> >
> > you are correct that the existing code will work if the SION bit is set=
, but this is not always possible or desirable. For example, if you use the=
 command "gpio set" to set the state of a pin that is not configured in DTS=
 then you will get the error message "Warning: value of pin is still 0". Al=
so the command "gpio status -a" shows wrong states of some output pins with=
out this patch.
>
> This happens due to an incorrect devicetree description, i.e, the lack
> of setting the SION bit.
>
> > Please see the chapters "GPIO data register (GPIOx_DR)" and "GPIO pad s=
tatus register (GPIOx_PSR)" in the document IMX6ULLRM.pdf which show that i=
t is possible to use the DR register instead of the PSR register in this ca=
se.
> >
> > I also found the exactly same modification in NXP version of U-Boot (ht=
tps://github.com/nxp-imx/uboot-imx/commit/4afc3f90943c6b117f79b66d2cd04e64f=
437b0c2) made by an NXP employee.
>
> Adding Ye Li on Cc.
>
> There were many attempts to fix this in both U-Boot and the kernel,
> but the recommendation has always been: "Set the SION bit if you need
> to read the output state".

For more information, please read this thread posted on
linux-arm-kernel ten years ago:

https://patchwork.kernel.org/project/linux-arm-kernel/patch/CAJ+vNU3w9Oi+dE=
rmy9x8g6ps=3DeLHLNLO-w7=3Dgn_8JtY4Kab6JQ@mail.gmail.com/

I hope this helps to clarify.
