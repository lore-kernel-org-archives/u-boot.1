Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DC4C4167B
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 18:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85AA18715E;
	Mon, 13 Nov 2023 19:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WnP3oHqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B888719F; Mon, 13 Nov 2023 19:02:03 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64C8E8716C
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 19:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d865854ef96so4827707276.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699898519; x=1700503319; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/MnCWSngpCW748tRiNv+K+OlwVVbQyPKYzvXw9lHlHY=;
 b=WnP3oHqGh2RcEpXm1vmcAQEGQfZ24vpRMdhy24F+cu74lmujI2sIgWekyg9VgfgQhr
 x5iISrWHAcp/HJ0LYUD2jh+4EGfPmj6tUdFqLKKaCRgAX2o1zsvo7H3e0SoRkRBWFmlQ
 DEuEbBVU6ebJr+Vm6CnEJgwneaVulADyJJFfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699898519; x=1700503319;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/MnCWSngpCW748tRiNv+K+OlwVVbQyPKYzvXw9lHlHY=;
 b=EzBSn2ZRNAA99wYqU5AVV/+90dqa6yJmtmbb+CDQsYF3ymjO31ObQG2s2eUc9+5Pzr
 6uYfhgcs+u5gsbrYx7mBEyo/cP9Rs0kc2oKyRe5jO9tNP6wV5BDSyn/gIQqIK2vLbH9q
 ysWxmXD2aqandrve35C2F3cioAWzmdDZdprFtnyT1rG0CbIMIXnXG074FhOh7cgC8F1K
 mERMey0eN8Ep00fHiBgLU0tXpsJ9KZO8Qv5nC3h5ZYGTXseXaiCvr4iqbrNGz8dy9/RC
 66pT6ZUAUy7ezoRZEGfvQF7QMtUNnddotNyqs0JX/HY9kVV67xkhhTApE6MsHM7T8rza
 wSmQ==
X-Gm-Message-State: AOJu0YwJT6lHbcC0dam/0oV1D2a8IKVTYrplIsMFvVpO9HR3t9TX2M5S
 wzKZQjxAtwJOBO+mgUtEFpcYtjZC4KesTs0gU9CiuA==
X-Google-Smtp-Source: AGHT+IFdz54P+lv8BpNiC9KU6vVP9/T28f6JziBurfOaf9SidA91c02TG8/5gNcpC1blK4fTuoB0qaq6ukhPtnJOmUo=
X-Received: by 2002:a25:d817:0:b0:da0:84b2:5e3e with SMTP id
 p23-20020a25d817000000b00da084b25e3emr7186117ybg.21.1699898518789; Mon, 13
 Nov 2023 10:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20231025051427.509602-1-takahiro.akashi@linaro.org>
 <20231025051427.509602-6-takahiro.akashi@linaro.org>
 <20231110182137.GA3824573@bill-the-cat> <ZVF/5cYQJzj08aI9@octopus>
In-Reply-To: <ZVF/5cYQJzj08aI9@octopus>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Nov 2023 11:01:17 -0700
Message-ID: <CAPnjgZ1kt2swHPTEPmA8YQvW3oNniw8M_VrDh5d9JC8949yjjA@mail.gmail.com>
Subject: Re: [PATCH 5/5] test: dm: add scmi command test
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Tom Rini <trini@konsulko.com>,
 sjg@chromium.org, 
 etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de, 
 Etienne Carriere <etienne.carriere@foss.st.com>
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

Hi,

On Sun, 12 Nov 2023 at 18:46, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Hi Tom,
>
> On Fri, Nov 10, 2023 at 01:21:37PM -0500, Tom Rini wrote:
> > On Wed, Oct 25, 2023 at 02:14:27PM +0900, AKASHI Takahiro wrote:
> >
> > > In this test, "scmi" command is tested against different sub-commands.
> > > Please note that scmi command is for debug purpose and is not intended
> > > in production system.
> > >
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> >
> > The test part of this still fails:
> > https://source.denx.de/u-boot/u-boot/-/jobs/732077
> >
> > I don't know why more output wasn't captured, when I run it locally
> > instead I get:
> > ========================================== FAILURES ===========================================
> > _______________________________ test_ut[ut_dm_dm_test_scmi_cmd] _______________________________
> > test/py/u_boot_spawn.py:195: in expect
> >     c = os.read(self.fd, 1024).decode(errors='replace')
> > E   OSError: [Errno 5] Input/output error
> >
> > During handling of the above exception, another exception occurred:
> > test/py/tests/test_ut.py:502: in test_ut
> >     output = u_boot_console.run_command('ut ' + ut_subtest)
> > test/py/u_boot_console_base.py:266: in run_command
> >     m = self.p.expect([self.prompt_compiled] + self.bad_patterns)
> > test/py/u_boot_spawn.py:204: in expect
> >     raise ValueError('U-Boot exited with %s' % info)
> > E   ValueError: U-Boot exited with signal 11 (SIGSEGV)
>
>
> The command uses global variables which hold pointers to 'struct udevice'
> which are to be shared between the main and the sub-commands.
> Since pytest framework executes ut tests twice, once with a (normal?) device
> tree and once with a flat tree,  udevices will be *voided* between
> two executions.

Are you able to put the var in the uclass-priv data instead? The state
should be cleared before running each DM test.

Regards,
Simon


>
> I will fix it in v2.
>
> Thanks,
> -Takahiro Akashi
>
>
> > ------------------------------------ Captured stdout call -------------------------------------
> > => ut dm dm_test_scmi_cmd
> > Test: dm_test_scmi_cmd: scmi.c
> > SCMI device: scmi
> >   protocol version: 0x20000
> >   # of agents: 2
> >       0: platform
> >     > 1: OSPM
> >   # of protocols: 4
> >       Power domain management
> >       Clock management
> >       Reset domain management
> >       Voltage domain management
> >   vendor: U-Boot
> >   sub vendor: Sandbox
> >   impl version: 0x1
> > Denying access to device:0 failed (-13)
> > Denying access to protocol:0x14 on device:0 failed (-13)
> > Reset failed (-13)
> > Test: dm_test_scmi_cmd: scmi.c (flat tree)
> > SCMI device: Q
> > =================================== short test summary info ===================================
> > FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_scmi_cmd] - ValueError: U-Boot exited...
> >
> > --
> > Tom
>
>
