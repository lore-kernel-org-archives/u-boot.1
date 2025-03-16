Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B93C35FF1
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 22:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3BF680F4C;
	Sun, 16 Mar 2025 23:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NJZfCzPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8D7810E8; Sun, 16 Mar 2025 23:18:11 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08B5980ECC
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 23:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2243803b776so18651955ad.0
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742163487; x=1742768287; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLtuBoxyiEKDapIh+rFWhH2O9mmjR7TA653sMrPivm0=;
 b=NJZfCzPsxaUHw3T7Ns9byVy7N4fTYUHXwFBoZ9qsZPlGuWU5H+hGRXmwP2enFwbEZD
 uxUxZSKDL83qxBm4DMqLWlbM5BreigfvLaRoJ0FRabwt5dEXDe3C3nmreXRQ+DujoGI6
 uosXdopZlaW9s/GO4bgLUVGTYfnakzkudVrvaPGiIlBuhxNc+ync8/ESKL7PF0XMEBOa
 TRhi0MUfBeyT2vkUDeFJam846JbHS/0rIQ7NRX7kXs6Ps6JIFw5UuVNS6w3MlQnw1zuX
 GedTYVk6oKGD9jmKF7RWy4lzOfhT1+pqoUDk+IAULDuEDzfMPcMmr4DxUQ/Y9WWybFiA
 kg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742163487; x=1742768287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLtuBoxyiEKDapIh+rFWhH2O9mmjR7TA653sMrPivm0=;
 b=GxUd7BxGeQ8OuOUkB/K0CpVsMYgdQ3GL1cHKPuz0G1rksCQ9LK+8vkehINAbhZn/sD
 XslRvIDOQsy9To2agbi6RcQwdlStOK3GdafgiyD+GhPZMtMabkevwBMX8WRRBTmKk6Ea
 A9RTMLftVea4Trp6CTkEgAFIjqw5nOpApjY7RpXuiu8InxnrMlAqHZfOYhfgZOYFGJcy
 mugb1TX5/+Q0rshvsWiAu3cQlRMQrO13iPZcYjxge10RJ4CMUHn6EJRRHja0DmlqqwO0
 zAP557YVrHyTXLDO89/Mrn6fr02x6fZlBRg4I2lfjOwZRSoi8QYKnoXL2V+jsIRIJc6b
 Lsdw==
X-Gm-Message-State: AOJu0YxPnVZi/nWNgYgMZJqS7XfLZ/2zCBTVwFNLBHA8libKQyzpVMYX
 N6+x5gJradOLwoRzytqbOPMecBd7QN7ZEYdEi5FlvsDAuFn6U6p3UoZaLydygZW28YwmOMsuSLB
 VJ8CDUS/cF7O7I/uUWQ6E+/N6cew=
X-Gm-Gg: ASbGnctI+eEi1LYQRGzM9/CPqXBq8NiCGaD7J4ByuJiXa0NM9gsB9ey1fW0bObwdmP6
 xrF/OtJqRyX2mQ5a+al8Kgl829q95eAmv3F2kx350oeSZo76nYSdXKgLQF9sM126VBniEst0pCH
 y5l7lLurfQw24CU5aDUtRT6fHk8t5jj6po8QJB
X-Google-Smtp-Source: AGHT+IEpCbTnlWGoOJYyeP2ojuz/OkI9vt9CABW3VbpU+a09tFQCCGRfUHGBVRi4g7yEDEoxNLzuTIKUF8N/lGv4giw=
X-Received: by 2002:a17:90b:4a42:b0:2ff:53ad:a0ec with SMTP id
 98e67ed59e1d1-30151cd1a0amr10903922a91.21.1742163487418; Sun, 16 Mar 2025
 15:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250312003041.110023-1-aford173@gmail.com>
 <CAOMZO5DRn08Q58PeHqi=1V8ZRv6B1+L_CB0NA=arQ2u6XUyi8Q@mail.gmail.com>
 <CAHCN7x+grtVs1JDvfth+7VdT1Xm=_GSBsr0PD1XQSPxpRBZcfw@mail.gmail.com>
 <CAOMZO5B0MgkAoBww0pPVnv4TAyqRmGJSn6hBwivgc2ZtpF+fyQ@mail.gmail.com>
In-Reply-To: <CAOMZO5B0MgkAoBww0pPVnv4TAyqRmGJSn6hBwivgc2ZtpF+fyQ@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 16 Mar 2025 17:17:56 -0500
X-Gm-Features: AQ5f1JpGIXIrJKIiT8rxIaDjCO-Fc8Qs18eVxfKZKMeBymj9LJEGhFJmk8hghWY
Message-ID: <CAHCN7xLi+MHsQaG=vyOcyM5d5ontn=+W1kL0op1HedmkbDt=oQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] clk: imx: Use Clock frameworkt to register UART
 clocks
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peter Robinson <pbrobinson@gmail.com>
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

On Sat, Mar 15, 2025 at 11:17=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Hi Adam,
>
> On Sat, Mar 15, 2025 at 12:37=E2=80=AFPM Adam Ford <aford173@gmail.com> w=
rote:
>
> > I ran the config that failed on my V3, and it passes that build test,
> > but I don't want to waste your time if it fails on others I don't know
> > about.  Can you point me to documentation on how to test this across
> > multiple boards/platforms before I resubmit it?
>
> Please check doc/develop/ci_testing.rst
>
> "The second way is to use GitHub.  This requires a GitHub account
> and to fork the repository at https://github.com/u-boot/u-boot and to the=
n
> submit a pull request as this will trigger an Azure pipeline run.  Clicki=
ng on
> your pull request on the list at https://github.com/u-boot/u-boot/pulls a=
nd
> then the "Checks" tab will show the results."

The doc you referred me to states:  Currently, we support running
GitLab CI pipelines only for custodians, due to the resources the
project has available

I tried pushing my branch to Github, but I don't have permission.  I
tried pushing it to my own github account, but it doesn't appear the
CI/CD stuff work.  I looked at the log provided from the pipeline, and
I have been able to successfully build for that machine along with a
couple others that I have manually tested.  Are you OK if I submit, or
is there something you want me to try before I do it?  I have a second
series I would like to submit soon which reduce my SPL size when
enabling CLK and CCF from:

   text    data     bss     dec     hex filename
  95988   22668      80 118736   1cfd0 spl/u-boot-spl
to
  91898   22668      80 114646   1bfd6 spl/u-boot-spl

It requires this series in order to accomplish some of these goals.

adam
