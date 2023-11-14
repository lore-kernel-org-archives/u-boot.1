Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494F1C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 23:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D185281F54;
	Wed, 15 Nov 2023 00:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T35FHJ5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2583987230; Wed, 15 Nov 2023 00:31:14 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B8E8871FC
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 00:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9e623356e59so701673766b.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 15:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700004601; x=1700609401; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P5mlKAXwaTuPIjNk7MLzzOGq8eqHx5U52oT1ZuBYnbI=;
 b=T35FHJ5dXnJhmnrHaVMvFo8ddozaFO1BjXK8pzTOQugGeKnRioXSl75ZaFFKfkIrDY
 CozRJljcORv/bydA4187Ru6XNYFbWhZIwutx4iD1N3ocJG/iDpz0V/sv/9KyVKSh3t2G
 mlSHC/ZZZm4LyhmMkC6QrBy9n5jB9BcePgkZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700004601; x=1700609401;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P5mlKAXwaTuPIjNk7MLzzOGq8eqHx5U52oT1ZuBYnbI=;
 b=TY2xlQ+Uxs4tb/yWbxQslpUHSCI/nQRJS1IR8iHMooVON1JJ7pMPv1DOdiXdtjCi7O
 YYUnGm/FRdd8Pb4L7m4qb3JCmGP9G8SD3NHnWhESQJEA+lV4r2MCovY4tYrGyVYbXiAC
 eGSTkjzL/ahraaguRJF90Votf7ttEyUQArJAbb43Dvyk1zZzjrzD7Jww9Rv/2fcOg0lO
 1ZGl+9452H7LwahYjT2tRxbFR1r+e/qfYNbmOtm7yxYCfecphO2oW3SDd+k1iDSLdX2v
 QpGQKj9sUiIvH5QT3qDLeLhI6ALaovju7Wc/cyXTcExbQ+uXCNuHQZhW7Vr1SQr22MiS
 oGyg==
X-Gm-Message-State: AOJu0YxfksKMpAxN+dnwDWcAcTEAfpcdVG1jP0CV8ZYGApYWlteR2P+c
 IxBlgYgSS7gk/3ilrr+vb/MrHvK59wBNVajvK3f9bA==
X-Google-Smtp-Source: AGHT+IEr9AR5PKZU2A8kwmWviyaYsxSMd0HrK298dCDLa5TliOLzc1Vjbf9ClvkkeeHS92CQtCmORoknUCVh+6+OPHA=
X-Received: by 2002:a17:907:7207:b0:9e7:cb49:9f58 with SMTP id
 dr7-20020a170907720700b009e7cb499f58mr10231871ejc.2.1700004601435; Tue, 14
 Nov 2023 15:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20231025051427.509602-1-takahiro.akashi@linaro.org>
 <20231025051427.509602-6-takahiro.akashi@linaro.org>
 <20231110182137.GA3824573@bill-the-cat> <ZVF/5cYQJzj08aI9@octopus>
 <CAPnjgZ1kt2swHPTEPmA8YQvW3oNniw8M_VrDh5d9JC8949yjjA@mail.gmail.com>
 <ZVLQQHRPUFTCQZln@octopus>
In-Reply-To: <ZVLQQHRPUFTCQZln@octopus>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Nov 2023 16:29:47 -0700
Message-ID: <CAPnjgZ2xUGB8U=_e+RKs54+4mV9wOH7pseFfEoM9Uqr8nPi59Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] test: dm: add scmi command test
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, etienne.carriere@st.com, michal.simek@amd.com, 
 u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@foss.st.com>
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

On Mon, 13 Nov 2023 at 18:41, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> On Mon, Nov 13, 2023 at 11:01:17AM -0700, Simon Glass wrote:
> > Hi,
> >
> > On Sun, 12 Nov 2023 at 18:46, AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Fri, Nov 10, 2023 at 01:21:37PM -0500, Tom Rini wrote:
> > > > On Wed, Oct 25, 2023 at 02:14:27PM +0900, AKASHI Takahiro wrote:
> > > >
> > > > > In this test, "scmi" command is tested against different sub-commands.
> > > > > Please note that scmi command is for debug purpose and is not intended
> > > > > in production system.
> > > > >
> > > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > > >
> > > > The test part of this still fails:
> > > > https://source.denx.de/u-boot/u-boot/-/jobs/732077
> > > >
> > > > I don't know why more output wasn't captured, when I run it locally
> > > > instead I get:
> > > > ========================================== FAILURES ===========================================
> > > > _______________________________ test_ut[ut_dm_dm_test_scmi_cmd] _______________________________
> > > > test/py/u_boot_spawn.py:195: in expect
> > > >     c = os.read(self.fd, 1024).decode(errors='replace')
> > > > E   OSError: [Errno 5] Input/output error
> > > >
> > > > During handling of the above exception, another exception occurred:
> > > > test/py/tests/test_ut.py:502: in test_ut
> > > >     output = u_boot_console.run_command('ut ' + ut_subtest)
> > > > test/py/u_boot_console_base.py:266: in run_command
> > > >     m = self.p.expect([self.prompt_compiled] + self.bad_patterns)
> > > > test/py/u_boot_spawn.py:204: in expect
> > > >     raise ValueError('U-Boot exited with %s' % info)
> > > > E   ValueError: U-Boot exited with signal 11 (SIGSEGV)
> > >
> > >
> > > The command uses global variables which hold pointers to 'struct udevice'
> > > which are to be shared between the main and the sub-commands.
> > > Since pytest framework executes ut tests twice, once with a (normal?) device
> > > tree and once with a flat tree,  udevices will be *voided* between
> > > two executions.
> >
> > Are you able to put the var in the uclass-priv data instead? The state
> > should be cleared before running each DM test.
>
> Well, I don't think we need such a trick.
> As you can see, we may simply fetch/find necessary udevices
> every time the command is called.
> It is enough given that the command is mainly for debug purpose.

OK. Let's see how it goes. When you mention global vars I get a bit
nervous, but we do have these in some places.

Regards,
Simon


>
> -Takahiro Akashi
>
>
> > Regards,
> > Simon
> >
> >
> > >
> > > I will fix it in v2.
> > >
> > > Thanks,
> > > -Takahiro Akashi
> > >
> > >
> > > > ------------------------------------ Captured stdout call -------------------------------------
> > > > => ut dm dm_test_scmi_cmd
> > > > Test: dm_test_scmi_cmd: scmi.c
> > > > SCMI device: scmi
> > > >   protocol version: 0x20000
> > > >   # of agents: 2
> > > >       0: platform
> > > >     > 1: OSPM
> > > >   # of protocols: 4
> > > >       Power domain management
> > > >       Clock management
> > > >       Reset domain management
> > > >       Voltage domain management
> > > >   vendor: U-Boot
> > > >   sub vendor: Sandbox
> > > >   impl version: 0x1
> > > > Denying access to device:0 failed (-13)
> > > > Denying access to protocol:0x14 on device:0 failed (-13)
> > > > Reset failed (-13)
> > > > Test: dm_test_scmi_cmd: scmi.c (flat tree)
> > > > SCMI device: Q
> > > > =================================== short test summary info ===================================
> > > > FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_scmi_cmd] - ValueError: U-Boot exited...
> > > >
> > > > --
> > > > Tom
> > >
> > >
