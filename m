Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73B4CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 08:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB28B866AA;
	Fri,  1 Sep 2023 10:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lHYnOdiw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05B4286759; Fri,  1 Sep 2023 10:32:07 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0593846C0
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 10:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5007c8308c3so3190633e87.0
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 01:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693557123; x=1694161923; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ifJvuO6wKyCxqsuqfJ5pHJorfQEsD370Z46BxflIB+k=;
 b=lHYnOdiwNJnPcTMYHfzCKqGeZX5xWIxxo+qbrYMq7m2R7x1XV5KWF1lgq83z91JS9H
 H+kM7NBDku6bRkMn1Gs4rgBCmAUFX+7CRnD686AcFIosDCU7vv2yI0S/PxWC/yolEj+S
 STg+bma3KbTIcNH400lvPy7iKhiI8QWN9N918cVyX0L4BQ9WD2cdT8WR/EsVQLTYgnH+
 8CkwFkziXWTG0yy0w4xVlcEEN7KYLmi+nUVrDTQ72plw/BYZU096h6I1eJA6cn7u+bAW
 vBRDAPzY2jVZznZu8bWR2lSX3GNc+CREbXUdgPG5IRzBp79tkycdnZ0mWk0YeM1t67T8
 fA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693557123; x=1694161923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ifJvuO6wKyCxqsuqfJ5pHJorfQEsD370Z46BxflIB+k=;
 b=BUO9M5JnD2LkBMD1oU9zKNDUJxkdTus47IGTS6vpFqdC3Veb+WPgzlk1fPMgEPuYcU
 viAoZd3XY74/k0hXlUwYIj7CSg+WW0ym41GeTDZMw9zbN6FljebLUYjYbmxVchu/SgeO
 HwUhl8eouJvFJBbpmvIGU/2Citf7gfxcHt7PYlGhNNqeLy6FFGMyF0neE+LUC2MEiqnx
 uSboE/kvvw3WRetDeZAppz0yNI2mRtAbiMK8IofjGaQKw5mZ20yrhk+bsel5Nhn5EMU1
 m9f6f98HZN9bSg3VBaAn5kPivA+WSuJE+SlDfQU+vQw036o8WaL1D76OTpdIWxdfQbrP
 3CKw==
X-Gm-Message-State: AOJu0Yz10/YzMleupmbCAw5hPWS7Wu57vCJuApa7JUFJmKSVTPjtkUKc
 Ck65lmzPr1C8WDLlvdopvSr/n/ZIjm3ak8YTmY8Bhg==
X-Google-Smtp-Source: AGHT+IH6p0cb8DZdhW6TkWqU/D5daMkAJWXHUmyBWsIHEt82EHRxCX2iBbTTt7TRAV/gym9sMIkYIzGXdIsCeCBvkfc=
X-Received: by 2002:a05:6512:6ca:b0:500:ac0b:8d51 with SMTP id
 u10-20020a05651206ca00b00500ac0b8d51mr1316519lff.37.1693557123018; Fri, 01
 Sep 2023 01:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <41f932e52bdd206b1b68d5ff313fc29b794a70e7.1693413381.git.michal.simek@amd.com>
 <b48a067e-4143-8cab-3387-e276e900e8f0@amd.com>
 <CAC_iWj+GZCHZkDf8C0v7oeJLwLZZep0jhKYv2at7BJ0gmqCFDw@mail.gmail.com>
 <77d57e59-42f2-2da0-6cdd-139c049ea401@amd.com>
In-Reply-To: <77d57e59-42f2-2da0-6cdd-139c049ea401@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Sep 2023 11:31:24 +0300
Message-ID: <CAC_iWj+6_HVOUomRGa09gyB6SqhBpVfx3nqf6EWNEUXrS=0Ygg@mail.gmail.com>
Subject: Re: [PATCH] test/py: tpm2: skip tpm2_startup when
 env__tpm_device_test_skip=True
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 1 Sept 2023 at 11:14, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 9/1/23 09:59, Ilias Apalodimas wrote:
> > On Fri, 1 Sept 2023 at 10:09, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 8/30/23 18:36, Michal Simek wrote:
> >>> All tpm2 tests should be possible to skip when
> >>> env__tpm_device_test_skip=True but test_tpm2_startup is missing it.
> >>>
> >>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>> ---
> >>>
> >>>    test/py/tests/test_tpm2.py | 3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> >>> index fce689cd992d..c2579fa02c58 100644
> >>> --- a/test/py/tests/test_tpm2.py
> >>> +++ b/test/py/tests/test_tpm2.py
> >>> @@ -71,6 +71,9 @@ def test_tpm2_startup(u_boot_console):
> >>>
> >>>        Initiate the TPM internal state machine.
> >>>        """
> >>> +    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
> >>> +    if skip_test:
> >>> +        pytest.skip('skip TPM device test')
> >>>        u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
> >>>        output = u_boot_console.run_command('echo $?')
> >>>        assert output.endswith('0')
> >>
> >> Applied.
> >
> > Uhm? Applied where? I had a few minor fixes I was planning to send to Tom
>
> To my microblaze tree.
> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/commits/20230901
>
> I want to send pull request to Tom soon and need this patch to be able to pass
> CI for enabling TPM for Versal.

Ah ok, feel free to pick it up then

Cheers
/Ilias
>
> Thanks,
> Michal
