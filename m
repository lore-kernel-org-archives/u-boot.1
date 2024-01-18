Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D406EC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 11:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F6C187A77;
	Thu, 18 Jan 2024 12:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="llFB1Eej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED1086FB2; Thu, 18 Jan 2024 12:52:13 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7648187B51
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 12:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50e4e3323a6so717753e87.0
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 03:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705578729; x=1706183529; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XNhu7Z/GXL0hqbh+aWUYdFU9lLPXKQi6JJLny92UOb4=;
 b=llFB1EejDYz6D/3t++Jkq6c9V8Tnpd88sPFvPlXCHAb0ETQ4NZRyIB5Ix1aaGTFHWp
 JxDJIuu/c7F/DlkTlullhlqFJZ4uPc6yuHRrOmxJgyw1qNlnPVLCBdXd5/11IHEj4Xye
 HypSf1+q5Z85Yx/n6P9nW+mxw1WFNDBbetSKYxPY4bxOaKUs9H0w96lmAy8h9BeqSYI4
 nVv4+YD0wxfbnnqdylK9+JuQk3em3w537SrO03mwvz7QVMPzLOzCJXAPwSyzv4PbnCNv
 3czeaGv2B4jbF9lckHOLWtatfyWAW2QneiYClhNZBPG7lXRPqoUDX7yq67/3SbcFpniU
 uLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705578729; x=1706183529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XNhu7Z/GXL0hqbh+aWUYdFU9lLPXKQi6JJLny92UOb4=;
 b=QtG0UPhSj8X8Lxqff3hVSvlNb2rHLez5wzpqrinZ1/6OFf7VLxmK+rg2Q4v/ELzx8I
 fqY6z6PgQUcVdkn1UvbhgvuXAxlAAPjuKT4/fa9lPsfO3yYLfWE7T9AAgJfkuWEYcSSR
 Rmxj8g5s/yxooa77F7X/GL5MIoBZ0hc2t1cwXK1nwPrVDR4yxa3FWRg8fFxv1DOc6i+k
 G54tfXUHD0IQzL4b4Ot8yJoFoUA1cOtHKP/GiiX9ZKRJDwPsbzWlmt/vyBjULUeIA2CT
 JmJZWwcBvVY8pyKoFMQqFXPkCFZofH2pYii+sHPZAXeGjV0DVeZj3ET1JG7Jrzw8I/w9
 k7+w==
X-Gm-Message-State: AOJu0Yx7vEKgaaNHWjIfl0FQsPIPuRuV05/8MV61jOB/OHttNx+3I+X0
 FIK227f6FEal5F+qeylwAo3GLV1kZkfAkGpOSc+GmkHlGv0YCMHXYty01cv0OEjOqK1cHQajD2A
 QjAZSc0DGJbMuv4UxskBbul7NjY28Y7ov6O/b8v9AwBMrVmDR
X-Google-Smtp-Source: AGHT+IFRa+G1tOkJ0fUSqlEXZsqKvlxrdLChf+eiwx8fqmxmezTFJo1bNdCC/sHm6DxR+lLnheyIClys+/FxfYeexi4=
X-Received: by 2002:ac2:4da2:0:b0:50e:9354:c36f with SMTP id
 h2-20020ac24da2000000b0050e9354c36fmr1583136lfe.19.1705578728719; Thu, 18 Jan
 2024 03:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
 <20240117153347.85074-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240117153347.85074-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 18 Jan 2024 13:51:32 +0200
Message-ID: <CAC_iWjJv9Ff-sTq63b2L8vrarcpedNsDFg3iokwAgpzFAbZuHw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] test: unit test for smbios command
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 17 Jan 2024 at 17:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide a unit test for the smbios command.
>
> Provide different test functions for QEMU, sandbox, and other systems.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         for generic boards we only can assume that a type 127 table exists
>         email address updated
> ---
>  test/py/tests/test_smbios.py | 41 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 test/py/tests/test_smbios.py
>
> diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
> new file mode 100644
> index 00000000000..82b0b689830
> --- /dev/null
> +++ b/test/py/tests/test_smbios.py
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +"""Test smbios command"""
> +
> +import pytest
> +
> +@pytest.mark.buildconfigspec('cmd_smbios')
> +@pytest.mark.notbuildconfigspec('qfw_smbios')
> +@pytest.mark.notbuildconfigspec('sandbox')
> +def test_cmd_smbios(u_boot_console):
> +    """Run the smbios command"""
> +    output = u_boot_console.run_command('smbios')
> +    assert 'DMI type 127,' in output
> +
> +@pytest.mark.buildconfigspec('cmd_smbios')
> +@pytest.mark.buildconfigspec('qfw_smbios')
> +@pytest.mark.notbuildconfigspec('sandbox')
> +# TODO:
> +# QEMU v8.2.0 lacks SMBIOS support for RISC-V
> +# Once support is available in our Docker image we can remove the constraint.
> +@pytest.mark.notbuildconfigspec('riscv')
> +def test_cmd_smbios_qemu(u_boot_console):
> +    """Run the smbios command on QEMU"""
> +    output = u_boot_console.run_command('smbios')
> +    assert 'DMI type 1,' in output
> +    assert 'Manufacturer: QEMU' in output
> +    assert 'DMI type 127,' in output

Is there an easy way to run this test with and without the SMBIOS
tables provided by QEMU? We could test the u-boot generated ones that
way

Thanks
/Ilias
> +
> +@pytest.mark.buildconfigspec('cmd_smbios')
> +@pytest.mark.buildconfigspec('sandbox')
> +def test_cmd_smbios_sandbox(u_boot_console):
> +    """Run the smbios command on the sandbox"""
> +    output = u_boot_console.run_command('smbios')
> +    assert 'DMI type 0,' in output
> +    assert 'String 1: U-Boot' in output
> +    assert 'DMI type 1,' in output
> +    assert 'Manufacturer: sandbox' in output
> +    assert 'DMI type 2,' in output
> +    assert 'DMI type 3,' in output
> +    assert 'DMI type 4,' in output
> +    assert 'DMI type 127,' in output
> --
> 2.43.0
>
