Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D06C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA40F87940;
	Tue, 26 Dec 2023 10:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L9STfqtZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 824BB8787E; Tue, 26 Dec 2023 10:48:25 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8D5887922
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-593f7a1afd7so2539011eaf.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584100; x=1704188900; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2F7y2ZAsDOsnL3tR0un72mklLb2AW3kbO9YY4CuA/Dg=;
 b=L9STfqtZ1KROK401TNZ49ZDBhmek0LCAhFgtKkcVwDRseGFSiELRdZgWhI55XGmpk1
 rmdRbi8mottKI1YXZrHdrxOrRQ6IS3FZ/c8TcUH01o1ZzJtxly+QImHomD46r3gESgUM
 rSBuTkBqLuihVGNi81uttH7+3hy9lF0n75nH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584100; x=1704188900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2F7y2ZAsDOsnL3tR0un72mklLb2AW3kbO9YY4CuA/Dg=;
 b=jnb0QEOkVRRvsB6rC0YsY5XnIQLvROQCusmXupDeomtNAIbNFQPZM8bB8IwFd3Z3Fq
 GNcXmVnXrEvbzJNPOJrgULXHDK9VrkBaRuZd83/FidvpJH88lBQzzmn5iy8EB++aiso8
 ehuxs1tBEx/ZDZSwJ/Kf0VJu8Vu9Cw1EQ5OdTV4eXHMlO7MFrd7UOqXkUz74a5qI/zER
 ETM2uDWwm7uWP/hfFGn3LM93e6ueyCNATckX/hPsVueZM+fXtUmsZsgxrEx3Sd8cuYoE
 o1fOKGIbv6xHxtllXEOsNkYcl2c8OYU8f7esB/y/44A9N928UZevGijyLweH8axcbSzQ
 my9g==
X-Gm-Message-State: AOJu0Yw8pQEF+XxAK75usvvf4bQe5ztnN9bbkYABfRT9hfC2T+WO6r1J
 R3iT2lviB3Fj8eUZCQeoQ+EntTGPtgGxogOOqxmricmIY/6A
X-Google-Smtp-Source: AGHT+IEWafE2AMVS8lk4XK1K+/kC5FLA0kLm19r8J72y5BfEB5AzR9OX6PSPAI8Xf4auNff5FCqjEUdFIX9yfx5Eo1k=
X-Received: by 2002:a05:6358:2905:b0:170:c3c6:bda5 with SMTP id
 y5-20020a056358290500b00170c3c6bda5mr5269384rwb.15.1703584100410; Tue, 26 Dec
 2023 01:48:20 -0800 (PST)
MIME-Version: 1.0
References: <92d06d89e2d2d6b1738c62453789872dcb6bfa92.1701777713.git.love.kumar@amd.com>
In-Reply-To: <92d06d89e2d2d6b1738c62453789872dcb6bfa92.1701777713.git.love.kumar@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:49 +0000
Message-ID: <CAFLszTgKZWyCWRXFJvYpwLTTV0OQ+rjKXPssW0Zc9thqLDf9nw@mail.gmail.com>
Subject: Re: [PATCH v2] test/py: mii: Add tests for mii command
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
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

Hi Love,

On Tue, Dec 5, 2023 at 12:03=E2=80=AFPM Love Kumar <love.kumar@amd.com> wro=
te:
>
> Add below test cases for mii commands:
> mii_info -To display MII PHY info
> mii_list - To list MII devices
> mii_set_device - To set MII device
> mii_read - To reads register from MII PHY address
> mii_dump - To display data from MII PHY address
>
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
> Changes in v2:
>   - Get MII device list from env instead of auto-detecting it
>   - Set the MII device to its current device after testing so that it
>   won't impact next cases
> ---
>  test/py/tests/test_mii.py | 92 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 test/py/tests/test_mii.py

I'll just note that we can write tests in C now, even if they need
Python setup. See [1].

Some nits below, with which:

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/test/py/tests/test_mii.py b/test/py/tests/test_mii.py
> new file mode 100644
> index 000000000000..e9bdbadffc8e
> --- /dev/null
> +++ b/test/py/tests/test_mii.py
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# (C) Copyright 2023, Advanced Micro Devices, Inc.
> +
> +import pytest
> +import re
> +
> +"""
> +Note: This test doesn't rely on boardenv_* configuration value but they =
can
> +change test behavior.
> +
> +For example:
> +
> +# Setup env__mii_deive_test_skip to True if tests with ethernet PHY devi=
ces
> +# should be skipped. For example: Missing PHY device
> +env__mii_device_test_skip =3D True
> +
> +# Setup env__mii_device_test to set the MII device names. Test will be s=
kipped
> +# if env_mii_device_test is not set
> +env__mii_device_test =3D {
> +    "device_list": ["eth0", "eth1"],

Please be sure to use single quotes throughout, for consistency.

> +}
> +"""
> +
> +@pytest.mark.buildconfigspec("cmd_mii")
> +def test_mii_info(u_boot_console):
> +    if u_boot_console.config.env.get("env__mii_device_test_skip", False)=
:
> +        pytest.skip("MII device test is not enabled!")
> +    expected_output =3D "PHY"
> +    output =3D u_boot_console.run_command("mii info")
> +    if not re.search(r"PHY (.+?):", output):
> +        pytest.skip("PHY device does not exist!")
> +    assert expected_output in output
> +
> +@pytest.mark.buildconfigspec("cmd_mii")
> +def test_mii_list(u_boot_console):
> +    if u_boot_console.config.env.get("env__mii_device_test_skip", False)=
:
> +        pytest.skip("MII device test is not enabled!")
> +
> +    f =3D u_boot_console.config.env.get("env__mii_device_test", None)
> +    if not f:
> +        pytest.skip("No MII device to test!")
> +
> +    dev_list =3D f.get("device_list")
> +    if len(dev_list) =3D=3D 0:

if not dev_list:

> +        pytest.fail("No MII device list provided via env__mii_device_tes=
t!")
> +
> +    expected_output =3D "Current device"
> +    output =3D u_boot_console.run_command("mii device")
> +    mii_devices =3D (
> +        re.search(r"MII devices: '(.+)'", output).groups()[0].replace("'=
", "").split()
> +    )
> +
> +    assert len([x for x in dev_list if x in mii_devices]) =3D=3D len(dev=
_list)
> +    assert expected_output in output
> +
> +@pytest.mark.buildconfigspec("cmd_mii")
> +def test_mii_set_device(u_boot_console):
> +    test_mii_list(u_boot_console)
> +    f =3D u_boot_console.config.env.get("env__mii_device_test", None)
> +    dev_list =3D f.get("device_list")
> +    output =3D u_boot_console.run_command("mii device")
> +    current_dev =3D re.search(r"Current device: '(.+?)'", output).groups=
()[0]
> +
> +    for dev in dev_list:
> +        u_boot_console.run_command(f"mii device {dev}")
> +        output =3D u_boot_console.run_command("echo $?")
> +        assert output.endswith("0")
> +
> +    u_boot_console.run_command(f"mii device {current_dev}")
> +    output =3D u_boot_console.run_command("mii device")
> +    dev =3D re.search(r"Current device: '(.+?)'", output).groups()[0]
> +    assert current_dev =3D=3D dev
> +
> +@pytest.mark.buildconfigspec("cmd_mii")
> +def test_mii_read(u_boot_console):
> +    test_mii_list(u_boot_console)
> +    output =3D u_boot_console.run_command("mii info")
> +    eth_addr =3D hex(int(re.search(r"PHY (.+?):", output).groups()[0], 1=
6))
> +    u_boot_console.run_command(f"mii read {eth_addr} 0")
> +    output =3D u_boot_console.run_command("echo $?")
> +    assert output.endswith("0")
> +
> +@pytest.mark.buildconfigspec("cmd_mii")
> +def test_mii_dump(u_boot_console):
> +    test_mii_list(u_boot_console)
> +    expected_response =3D "PHY control register"
> +    output =3D u_boot_console.run_command("mii info")
> +    eth_addr =3D hex(int(re.search(r"PHY (.+?):", output).groups()[0], 1=
6))
> +    response =3D u_boot_console.run_command(f"mii dump {eth_addr} 0")
> +    assert expected_response in response
> +    output =3D u_boot_console.run_command("echo $?")
> +    assert output.endswith("0")
> --
> 2.25.1
>

Regards,
Simon


[1] https://docs.u-boot.org/en/latest/develop/tests_writing.html#mixing-pyt=
hon-and-c
