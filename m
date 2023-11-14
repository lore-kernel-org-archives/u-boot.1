Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12497C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 01:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F218887026;
	Tue, 14 Nov 2023 02:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bi+jNGlM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5209A86F88; Tue, 14 Nov 2023 02:41:28 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5482870DD
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 02:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ca85ff26afso6931975ad.1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 17:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699926084; x=1700530884; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cfNOelmZ+2kpt0AoyYrBog7oOAIKjIaM3HO/PPcT6qk=;
 b=bi+jNGlMW/cdtE/dIGZPvaxOINI/90e8kt3WrGzWXwVBxbDSKF5JmLVgvgC0wTnjez
 J6BQkhiLDiF22VvQpJyl61djqQ1Jx1MZWcVzASczjanDiglPPlvER6IRh8oQTyDwFUs0
 o5yQgMxT3FwTA72KOKYw5iV91m0J3SjPNu/DJuhNL4lkHkuq5Rt9y+IbMdxJ84DREWIY
 7TWBi4kOpkAPQ48rAgk94sY5U9FkkxGJbTrRr8u+PrbGV4ouVP3ewuZBfxp59ZM5rQqM
 91XnEJ9i9TUnpdYSKaIoxMQX/Jr5+I+ua8wiHsPp8x2lQ/jrWa8A8dj0/JuZRi5O343k
 3PJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699926084; x=1700530884;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cfNOelmZ+2kpt0AoyYrBog7oOAIKjIaM3HO/PPcT6qk=;
 b=uUUyJUWq/cEZvLhxCl1vczusvLpbN8THeIrgyZLoiAVYeyt577RPM7YgaXKgHXTgXi
 zCcwHldgYFi/zokQxHjgfbkMXQRsoL8G0rGxYJLrm5xo7TmKHDSZggjGftMpUpVb4/Fg
 /MklEVuLSDlJoh0OsXOlYyU7fgvjXq+Hfp+ydFoQyWvhOKRWcA79/Wv1ac7LR/mjh62c
 zTcUlxscLsVqnX6bQn7ZVv+v4u2IogmGimlUj7oCFbBEkooXFakKFPNUkki8JhYOKJ1g
 D0C9S8IyskwgRF6du5NRaeRVnbjkR/vdVm8IxgaW7eEL9l4ZA5eWBDj9m6NAd90Cahyv
 9m1g==
X-Gm-Message-State: AOJu0Yx+G2iCN+eHPnrpQQff2sALpAyAKMECNP3RETuj/F/gS5u3fP6A
 E8vhk7/CWoO13GinToJU1WM41A==
X-Google-Smtp-Source: AGHT+IHwTdLY0rLB7Ew09wh/hA52w9pnWTfmX0ceYZxGx1hhPgs+ojOf1AYjUzMHIQEyXLJXsB/mMA==
X-Received: by 2002:a17:903:32c5:b0:1cc:3b88:78b with SMTP id
 i5-20020a17090332c500b001cc3b88078bmr951591plr.6.1699926083863; 
 Mon, 13 Nov 2023 17:41:23 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:66f2:cd5c:3d82:6e6f])
 by smtp.gmail.com with ESMTPSA id
 ji19-20020a170903325300b001c9c5a1b477sm4676247plb.169.2023.11.13.17.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 17:41:23 -0800 (PST)
Date: Tue, 14 Nov 2023 10:41:20 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, etienne.carriere@st.com,
 michal.simek@amd.com, u-boot@lists.denx.de,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH 5/5] test: dm: add scmi command test
Message-ID: <ZVLQQHRPUFTCQZln@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 Etienne Carriere <etienne.carriere@foss.st.com>
References: <20231025051427.509602-1-takahiro.akashi@linaro.org>
 <20231025051427.509602-6-takahiro.akashi@linaro.org>
 <20231110182137.GA3824573@bill-the-cat> <ZVF/5cYQJzj08aI9@octopus>
 <CAPnjgZ1kt2swHPTEPmA8YQvW3oNniw8M_VrDh5d9JC8949yjjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1kt2swHPTEPmA8YQvW3oNniw8M_VrDh5d9JC8949yjjA@mail.gmail.com>
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

On Mon, Nov 13, 2023 at 11:01:17AM -0700, Simon Glass wrote:
> Hi,
> 
> On Sun, 12 Nov 2023 at 18:46, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Hi Tom,
> >
> > On Fri, Nov 10, 2023 at 01:21:37PM -0500, Tom Rini wrote:
> > > On Wed, Oct 25, 2023 at 02:14:27PM +0900, AKASHI Takahiro wrote:
> > >
> > > > In this test, "scmi" command is tested against different sub-commands.
> > > > Please note that scmi command is for debug purpose and is not intended
> > > > in production system.
> > > >
> > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > >
> > > The test part of this still fails:
> > > https://source.denx.de/u-boot/u-boot/-/jobs/732077
> > >
> > > I don't know why more output wasn't captured, when I run it locally
> > > instead I get:
> > > ========================================== FAILURES ===========================================
> > > _______________________________ test_ut[ut_dm_dm_test_scmi_cmd] _______________________________
> > > test/py/u_boot_spawn.py:195: in expect
> > >     c = os.read(self.fd, 1024).decode(errors='replace')
> > > E   OSError: [Errno 5] Input/output error
> > >
> > > During handling of the above exception, another exception occurred:
> > > test/py/tests/test_ut.py:502: in test_ut
> > >     output = u_boot_console.run_command('ut ' + ut_subtest)
> > > test/py/u_boot_console_base.py:266: in run_command
> > >     m = self.p.expect([self.prompt_compiled] + self.bad_patterns)
> > > test/py/u_boot_spawn.py:204: in expect
> > >     raise ValueError('U-Boot exited with %s' % info)
> > > E   ValueError: U-Boot exited with signal 11 (SIGSEGV)
> >
> >
> > The command uses global variables which hold pointers to 'struct udevice'
> > which are to be shared between the main and the sub-commands.
> > Since pytest framework executes ut tests twice, once with a (normal?) device
> > tree and once with a flat tree,  udevices will be *voided* between
> > two executions.
> 
> Are you able to put the var in the uclass-priv data instead? The state
> should be cleared before running each DM test.

Well, I don't think we need such a trick.
As you can see, we may simply fetch/find necessary udevices
every time the command is called.
It is enough given that the command is mainly for debug purpose.

-Takahiro Akashi


> Regards,
> Simon
> 
> 
> >
> > I will fix it in v2.
> >
> > Thanks,
> > -Takahiro Akashi
> >
> >
> > > ------------------------------------ Captured stdout call -------------------------------------
> > > => ut dm dm_test_scmi_cmd
> > > Test: dm_test_scmi_cmd: scmi.c
> > > SCMI device: scmi
> > >   protocol version: 0x20000
> > >   # of agents: 2
> > >       0: platform
> > >     > 1: OSPM
> > >   # of protocols: 4
> > >       Power domain management
> > >       Clock management
> > >       Reset domain management
> > >       Voltage domain management
> > >   vendor: U-Boot
> > >   sub vendor: Sandbox
> > >   impl version: 0x1
> > > Denying access to device:0 failed (-13)
> > > Denying access to protocol:0x14 on device:0 failed (-13)
> > > Reset failed (-13)
> > > Test: dm_test_scmi_cmd: scmi.c (flat tree)
> > > SCMI device: Q
> > > =================================== short test summary info ===================================
> > > FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_scmi_cmd] - ValueError: U-Boot exited...
> > >
> > > --
> > > Tom
> >
> >
