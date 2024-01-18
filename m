Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CCAC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 12:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05F3887AB9;
	Thu, 18 Jan 2024 13:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j3E3Vv/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E3D87AB9; Thu, 18 Jan 2024 13:35:47 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D4838798D
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 13:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e880121efso20453565e9.3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 04:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705581345; x=1706186145; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B+gItZz1BRxWq9JoKdb1ce+htvh1migDtV9aQ+3YuJU=;
 b=j3E3Vv/aJuBEDKKxNNi3388HuEplxJ4mYMHv2a68s1OB6mY9zvIcRRgaiVDwNBklum
 i2iWNTBO0dctDgadclMB6ChfaGLUqjl0BwyqGJyFC0nreL2yWKZH4T1PKu4JzvdcH+5l
 E9owN+IGb9ZkL+4MDGF8KIGdZZJmUP6hmhVeouUVdGT86smFfGeMQoF0katbk3dBcY6r
 XDIgU6IkgZfWQXi9u8Zal1ok2C13zhDGaYwwPulgkoTA31f0vwVKDwfVb9dsgwxVVUmH
 E5q6YFOppdA3fkjcS/MoB8DjS1Gwd4Ywc57gXtSGEErlO7w6uIjKHh3VVYSYsHOtUf0f
 oo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705581345; x=1706186145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+gItZz1BRxWq9JoKdb1ce+htvh1migDtV9aQ+3YuJU=;
 b=Q21Kq53VaFdnQnGeCnkuJyi4oudhC9UTMHylENWjoWM+JVOydEJv8XnMntR4mIwbeH
 XDUDXUSMk9nkOd+MkK41P7HKqMPC7H5vGWoO59Vem6SPWnma/S7WyWemMqXBrBapSU9i
 zi9tlrY3ME7wpO49FuD749EtFsUkTRVgNVGAG957a2O7kXQoX5FnCRLFY11qg4WqM2cX
 XDTS1DUQC9e4FDSKyOvRyCUklEXJGT8TDXB4FhV1Hb73Z2BH7nIrUWE/sY1gkowFo6lN
 kVVqNrh5eV6DmAVAvYx2o3bNlvdKHcJmcMeQRsn50IJpg2SKUbIHakKpQXKz2rXtRXur
 J87g==
X-Gm-Message-State: AOJu0YynjsOUKO7arUIL9ymeqfqWbc9hO1JybaannykOJ20l7EoqYSVX
 3ojYMOFMCXC1wFUCDvMk8kR1TuAqmsBHjuq8CkO4r0wKLR2uTUQjrC62KDgNIdE=
X-Google-Smtp-Source: AGHT+IFMZQUOkJwP39kXnHDvEDbSc62g/fNhsUNRzdVu8PIjmFyOAyHcTkcycBGZUP62SoraibPKGA==
X-Received: by 2002:a05:600c:294c:b0:40e:87e7:ecbe with SMTP id
 n12-20020a05600c294c00b0040e87e7ecbemr459265wmd.153.1705581344721; 
 Thu, 18 Jan 2024 04:35:44 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a05600c154600b0040e880ac6ecsm5826201wmg.35.2024.01.18.04.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:35:44 -0800 (PST)
Date: Thu, 18 Jan 2024 14:35:42 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/4] test: unit test for smbios command
Message-ID: <ZakbHqumybx-cVrq@hera>
References: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
 <20240117153347.85074-4-heinrich.schuchardt@canonical.com>
 <CAC_iWjJv9Ff-sTq63b2L8vrarcpedNsDFg3iokwAgpzFAbZuHw@mail.gmail.com>
 <d58a1c24-9af3-4a49-b4bd-afafc0c684f2@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d58a1c24-9af3-4a49-b4bd-afafc0c684f2@canonical.com>
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

On Thu, Jan 18, 2024 at 01:33:15PM +0100, Heinrich Schuchardt wrote:
> On 1/18/24 12:51, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >
> > On Wed, 17 Jan 2024 at 17:34, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >
> > > Provide a unit test for the smbios command.
> > >
> > > Provide different test functions for QEMU, sandbox, and other systems.
> > >
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > > v2:
> > >          for generic boards we only can assume that a type 127 table exists
> > >          email address updated
> > > ---
> > >   test/py/tests/test_smbios.py | 41 ++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 41 insertions(+)
> > >   create mode 100644 test/py/tests/test_smbios.py
> > >
> > > diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
> > > new file mode 100644
> > > index 00000000000..82b0b689830
> > > --- /dev/null
> > > +++ b/test/py/tests/test_smbios.py
> > > @@ -0,0 +1,41 @@
> > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > +
> > > +"""Test smbios command"""
> > > +
> > > +import pytest
> > > +
> > > +@pytest.mark.buildconfigspec('cmd_smbios')
> > > +@pytest.mark.notbuildconfigspec('qfw_smbios')
> > > +@pytest.mark.notbuildconfigspec('sandbox')
> > > +def test_cmd_smbios(u_boot_console):
> > > +    """Run the smbios command"""
> > > +    output = u_boot_console.run_command('smbios')
> > > +    assert 'DMI type 127,' in output
> > > +
> > > +@pytest.mark.buildconfigspec('cmd_smbios')
> > > +@pytest.mark.buildconfigspec('qfw_smbios')
> > > +@pytest.mark.notbuildconfigspec('sandbox')
> > > +# TODO:
> > > +# QEMU v8.2.0 lacks SMBIOS support for RISC-V
> > > +# Once support is available in our Docker image we can remove the constraint.
> > > +@pytest.mark.notbuildconfigspec('riscv')
> > > +def test_cmd_smbios_qemu(u_boot_console):
> > > +    """Run the smbios command on QEMU"""
> > > +    output = u_boot_console.run_command('smbios')
> > > +    assert 'DMI type 1,' in output
> > > +    assert 'Manufacturer: QEMU' in output
> > > +    assert 'DMI type 127,' in output
> >
> > Is there an easy way to run this test with and without the SMBIOS
> > tables provided by QEMU? We could test the u-boot generated ones that
> > way
>
> We already test the sandbox without QFW. I would not want to duplicated QEMU
> defconfigs.
>
Ah fair enough, I can add the generic tests in that one

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Best regards
>
> Heinrich
>
> >
> > Thanks
> > /Ilias
> > > +
> > > +@pytest.mark.buildconfigspec('cmd_smbios')
> > > +@pytest.mark.buildconfigspec('sandbox')
> > > +def test_cmd_smbios_sandbox(u_boot_console):
> > > +    """Run the smbios command on the sandbox"""
> > > +    output = u_boot_console.run_command('smbios')
> > > +    assert 'DMI type 0,' in output
> > > +    assert 'String 1: U-Boot' in output
> > > +    assert 'DMI type 1,' in output
> > > +    assert 'Manufacturer: sandbox' in output
> > > +    assert 'DMI type 2,' in output
> > > +    assert 'DMI type 3,' in output
> > > +    assert 'DMI type 4,' in output
> > > +    assert 'DMI type 127,' in output
> > > --
> > > 2.43.0
> > >
>
