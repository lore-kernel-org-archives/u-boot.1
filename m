Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686F2C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 21:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 456C7831A2;
	Mon,  3 Jun 2024 23:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="P+hr4hYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 345F2883B3; Mon,  3 Jun 2024 23:28:19 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE4C81026
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 23:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6302bdb54aso634269766b.0
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 14:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1717450096; x=1718054896; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNGROccSaNHV2d77luxoSSDnNrRRXPLIEee9PuDipVk=;
 b=P+hr4hYmf5gxDOBQCrkf1/g3QCT6uUAmSXM9wQGgg+pqdDjr5WSBJBADB1zK+e1tKu
 UucBW7qxiJMhtmk5lPL3j1wUgRdWPdA9cxrJrKbEKPJc6pbAtmiKbj2+UJoTWLWTVbme
 Ckj4Z6DjGWBVQ3UxhjEeHZAiZI473+4C4uKSYBom1pYIc8+HD/P01HJi6NxsXiyaexYK
 NBwyjd6TzHO/lP/UXzctUCjnkX5euKpAQiC3tvHhddsm7R0v1n9+1BUey3BzY248e3yi
 U1oiTEXTaHDqnbNzKGXbySfplRzGKjJ1MbR4aq+iXIN/iZoCLu466J+qdzU0ePZv+Qdi
 PYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717450096; x=1718054896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kNGROccSaNHV2d77luxoSSDnNrRRXPLIEee9PuDipVk=;
 b=wE++ELg/mc+Ux3T8CWOW5GWhQ97ZglCpGMO7OQKdN1zroQ2WxEPpIX0+ZQguEMr9nd
 5CSCiNrte7IR15i9jawcINlF693KlPMgHkhj9IbcjsxWb6H3i5KX820BSoTJQjZSRtbZ
 OG3gn+VOrr9Gjg1lSiH48m1iImkb/2ZB/tYfX/LG+n6oN8GRQgVSEP1gY5++NQ+Kl6Il
 1u7wgMxbgd+k+6GZwzyR2C8LjiUtHl3YCAIC9FWhO/C7qVXbVMqI7BxKUVSfGHONJsu6
 SrywlczZF7WGpizcJIpprC7GUI1KxVO0E9j67LdNoXwy3SlbnKYYM/qE08FV5fnzEl7D
 51wA==
X-Gm-Message-State: AOJu0YxXd2Gki+c4CJJVYoL9sP2lIN8od7zbrfTp5SlrSKwhsWPl33D3
 aG4wQ8+TvQuCCviGU3/50zas5BbpvrTXWBYnP6wyJ/T0tuBtocV2nAIZS1IQCmDeNx1RkgVw8uz
 g0zq667dyECpHO40d1rkPOuYwHeUOijXinlcpAw==
X-Google-Smtp-Source: AGHT+IFUpE1yAnr+EA4tOHqhgT5Hywj4u0yMIFLXvPcXn2TUAiT8DAUt4icmaeZdmRG0hV7pksCURqf7oWnVHxOA/00=
X-Received: by 2002:a17:906:f592:b0:a68:fa24:9e82 with SMTP id
 a640c23a62f3a-a68fa249ebamr378786066b.38.1717450096008; Mon, 03 Jun 2024
 14:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
 <e0f38bc9-bcc2-4476-a5d4-4f2efaebc0c1@arm.com>
In-Reply-To: <e0f38bc9-bcc2-4476-a5d4-4f2efaebc0c1@arm.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 3 Jun 2024 14:28:04 -0700
Message-ID: <CAJ+vNU0jiVb4caYeQ5HYKZ-dqxcdG1K5pPisJZpfL4q7Sc3zvA@mail.gmail.com>
Subject: Re: obscure microsd detection issue between U-Boot and kernel
To: Christian Loehle <christian.loehle@arm.com>
Cc: u-boot <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Linux MMC List <linux-mmc@vger.kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
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

On Mon, Jun 3, 2024 at 1:18=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 5/31/24 21:47, Tim Harvey wrote:
> > Greetings,
> >
> > I'm seeing an issue on an imx8mm board (imx8mm-venice-gw73xx) where
> > for a specific set of microsd cards if I have accessed the microsd in
> > U-Boot with UHS/1.8V the kernel will not recognize that microsd when
> > scanning.
> >
> > The issue does not occur with all microsd cards but seems to appear
> > with a large sample size of a specific card/model (Kingston SDC32 32GB
> > SDR104 card). I do not see a signal integrity issue on the scope.
> >
> > Instrumenting the kernel the issue is that the host reports a CRC
> > error as soon as the first mmc_send_if_cond call which occurs in
> > mmc_rescan_try_freq.
> >
> > I can avoid the issue by either not accessing the microsd in U-Boot or
> > by disabling UHS/1.8V mode in U-Boot therefore what I think is
> > happening is that U-Boot leaves the card in UHS/1.8V signalling mode
> > and when the kernel scans it sets the voltage back to 3.3V
> > standard/default and default timings then issues its clock cycles to
> > 'reset' the card and the card does not recognize the reset. I'm
> > wondering if this is because the reset is done via clock cycles after
> > the kernel has set the I/O voltage back to 3.3V when perhaps the card
> > is still in 1.8V mode (although I don't see how that would cause an
> > issue)?
>
> It will cause an issue for many cards and might break some cards.
>
> >
> > Is there some sort of MMC 'reset' I can/should do in U-Boot before
> > booting the kernel? Has anyone encountered anything like this before?
>
> There is no 'switching back' to 3.3V signalling from UHS 1.8V.
> The only way this can be done is therefore a full power-off.
> Is that done correctly for your system?
> AFAIR spec dictates 500ms of <0.5V on VCC. Note that  driving CLK/signal
> lines can also sustain the card somewhat, as leakage is only limited
> within operating voltage.

Hi Christian,

Are you saying the only way to properly reset from 1.8V is to have a
VDD supply on the microSD card that can be turned off before booting
to Linux? We have never had that before and never encountered
something like this.

Best Regards,

Tim
