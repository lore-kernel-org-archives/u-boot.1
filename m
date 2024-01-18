Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99AFC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 14:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14FFA87B5F;
	Thu, 18 Jan 2024 15:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jD6Gqty9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0081E87BA9; Thu, 18 Jan 2024 15:06:42 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B4C8796A
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 15:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-429c00bf0efso48654551cf.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 06:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705586798; x=1706191598; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fnry0+h15qteCZKQkLIu66+O1B7onTmKOwSPca2CVP4=;
 b=jD6Gqty94130GJiokEoPeSS0tzR8JvbUVueseBQCrNX57MwbcZwg0DletuM+N4IE7N
 MWS3LyogJIEufzDk3ltM4nPEbzVPtxtIaNdPcH6Wk+ZR5oqDKaoOp5Z/VoG4Css0EZ5x
 y+HnjDu9ng+QWp+9Vji3pblRseQByHoPh1deo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705586798; x=1706191598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnry0+h15qteCZKQkLIu66+O1B7onTmKOwSPca2CVP4=;
 b=oHPyvHW3qFPVqqaoTqD4h0oKvZQbnghF8wFEOQWHoITmn8pPEvLBlt6+1+2/TlM5Wn
 KvmW+DENTHz8WTeFapptR3iOAN6TS4D1mdYvRpONxr8sSRKtkTOhD/uxWRbqyUrtn5yg
 f2dOxaUlexK4/fQBfRpQ20tmcH1nNX3MO7E/bNcZG4BMEK1OqueiJDenrDrfQJ0VXTd9
 JOOHOr8A7dj114U13XaxLocLA+xFfPQAtdymozIA2cx9+bUbVdSdcaKNLpIvGt51Yzn8
 QQxMMS9UBW4cGmT93lYa8qWS4aR9RnPT7jv7EIyzoZ1cJAhgjk3Jop352JXV5fhnN29N
 ZZAw==
X-Gm-Message-State: AOJu0YzfRF4/ygsT3NwExDavkepBoG0V50jXt4QlBR+DAMalqeufrVcL
 Jf+FAyAOLjP5n826wmHtMCmL0yiHrJ1hdVSOqXZW+cWkFnTRq8p9CIMVmYecO4E=
X-Google-Smtp-Source: AGHT+IED3hogRRt30oNUlurw7aTucO+ZQo+Ws9FXg6BHdlg0T4Nz+hmfPq3pAxo+bndQpQydFDFPmg==
X-Received: by 2002:a05:622a:452:b0:429:bccc:e450 with SMTP id
 o18-20020a05622a045200b00429bccce450mr1023860qtx.78.1705586797974; 
 Thu, 18 Jan 2024 06:06:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 br15-20020a05622a1e0f00b00429bad8986csm6776229qtb.16.2024.01.18.06.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:06:37 -0800 (PST)
Date: Thu, 18 Jan 2024 09:06:35 -0500
From: Tom Rini <trini@konsulko.com>
To: neil.armstrong@linaro.org
Cc: Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com, git@xilinx.com, rfried.dev@gmail.com,
 v.v.mitrofanov@yadro.com, seanedmond@microsoft.com,
 emohandesi@linux.microsoft.com
Subject: Re: [UBOOT PATCH v4] test/py: net: Add dhcp abort test
Message-ID: <20240118140635.GA12635@bill-the-cat>
References: <dd44fc9bf39e0debc9d0bc78a5d9215bace26023.1700571693.git.love.kumar@amd.com>
 <e19b68f5-acc5-4838-8fec-b0fb4b4f1a5e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ohT+xT3BacEh6XBc"
Content-Disposition: inline
In-Reply-To: <e19b68f5-acc5-4838-8fec-b0fb4b4f1a5e@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--ohT+xT3BacEh6XBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 09:56:58AM +0100, neil.armstrong@linaro.org wrote:
> Hi,
>=20
> On 21/11/2023 14:02, Love Kumar wrote:
> > Abort the dhcp request in the middle by pressing ctrl + c on u-boot
> > prompt and validate the abort status.
> >=20
> > Signed-off-by: Love Kumar <love.kumar@amd.com>
> > ---
> > Changes in v2:
> >   - Mark CMD_MII command dependency
> >=20
> > Changes in v3:
> >   - Skip the test if PHY device not present
> >=20
> > Changes in v4:
> >   - Setup the network configuration by running dhcp test at the end of
> >   test
> >   - Add option to skip the test if it is not desired or possible
> > ---
> >   test/py/tests/test_net.py | 57 +++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 57 insertions(+)
> >=20
> > diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
> > index b2241ae6a482..e0749125fd53 100644
> > --- a/test/py/tests/test_net.py
> > +++ b/test/py/tests/test_net.py
> > @@ -7,6 +7,7 @@
> >   import pytest
> >   import u_boot_utils
> >   import uuid
> > +import re
> >   """
> >   Note: This test relies on boardenv_* containing configuration values =
to define
> > @@ -30,6 +31,11 @@ env__net_uses_pci =3D True
> >   # set to False.
> >   env__net_dhcp_server =3D True
> > +# False or omitted if a DHCP server is attached to the network, and dh=
cp abort
> > +# case should be tested.
> > +# If DHCP abort testing is not possible or desired, set this variable =
to True.
> > +env__dhcp_abort_test_skip =3D True
> > +
> >   # True if a DHCPv6 server is attached to the network, and should be t=
ested.
> >   # If DHCPv6 testing is not possible or desired, this variable may be =
omitted or
> >   # set to False.
> > @@ -115,6 +121,57 @@ def test_net_dhcp(u_boot_console):
> >       global net_set_up
> >       net_set_up =3D True
> > +@pytest.mark.buildconfigspec("cmd_dhcp")
> > +@pytest.mark.buildconfigspec("cmd_mii")
> > +def test_net_dhcp_abort(u_boot_console):
> > +    """Test the dhcp command by pressing ctrl+c in the middle of dhcp =
request
> > +
> > +    The boardenv_* file may be used to enable/disable this test; see t=
he
> > +    comment at the beginning of this file.
> > +    """
> > +
> > +    test_dhcp =3D u_boot_console.config.env.get("env__net_dhcp_server"=
, False)
> > +    if not test_dhcp:
> > +        pytest.skip("No DHCP server available")
> > +
> > +    if u_boot_console.config.env.get("env__dhcp_abort_test_skip", Fals=
e):
> > +        pytest.skip("DHCP abort test is not enabled!")
> > +
> > +    u_boot_console.run_command("setenv autoload no")
> > +
> > +    # Phy reset before running dhcp command
> > +    output =3D u_boot_console.run_command("mii device")
> > +    if not re.search(r"Current device: '(.+?)'", output):
> > +        pytest.skip("PHY device does not exist!")
> > +    eth_num =3D re.search(r"Current device: '(.+?)'", output).groups()=
[0]
> > +    u_boot_console.run_command(f"mii device {eth_num}")
> > +    output =3D u_boot_console.run_command("mii info")
> > +    eth_addr =3D hex(int(re.search(r"PHY (.+?):", output).groups()[0],=
 16))
> > +    u_boot_console.run_command(f"mii modify {eth_addr} 0 0x8000 0x8000=
")
> > +
> > +    u_boot_console.run_command("dhcp", wait_for_prompt=3DFalse)
> > +    try:
> > +        u_boot_console.wait_for("Waiting for PHY auto negotiation to c=
omplete")
> > +    except:
> > +        pytest.skip("Timeout waiting for PHY auto negotiation to compl=
ete")
> > +
> > +    u_boot_console.wait_for("done")
> > +
> > +    # Sending Ctrl-C
> > +    output =3D u_boot_console.run_command(
> > +        chr(3), wait_for_echo=3DFalse, send_nl=3DFalse
> > +    )
> > +
> > +    assert "TIMEOUT" not in output
> > +    assert "DHCP client bound to address " not in output
> > +    assert "Abort" in output
> > +
> > +    # Provide a time to recover from Abort - if it is not performed
> > +    # There is message like: ethernet@ff0e0000: No link.
> > +    u_boot_console.run_command("sleep 1")
> > +    # Run the dhcp test to setup the network configuration
> > +    test_net_dhcp(u_boot_console)
> > +
> >   @pytest.mark.buildconfigspec('cmd_dhcp6')
> >   def test_net_dhcp6(u_boot_console):
> >       """Test the dhcp6 command.
>=20
> This test fails on the BPI-M2S and BPI-M5 boards:
>=20
> Section: test_net_dhcp_abort
> TIME: NOW: 2024/01/18 08:43:48.152149
> TIME: SINCE-PREV: 0:00:00.000629
> TIME: SINCE-START: 0:02:17.928462
> Stream: console
> =3D> setenv autoload no
> =3D>
> End stream: console
> TIME: NOW: 2024/01/18 08:43:48.232597
> TIME: SINCE-PREV: 0:00:00.080448
> TIME: SINCE-START: 0:02:18.008910
> Stream: console
> =3D> mii device
> MII devices: 'mdio' 'mdio@0'
> Current device: 'mdio'
> =3D>
> End stream: console
> TIME: NOW: 2024/01/18 08:43:48.277449
> TIME: SINCE-PREV: 0:00:00.044852
> TIME: SINCE-START: 0:02:18.053762
> Stream: console
> =3D> mii device mdio
> =3D>
> End stream: console
> TIME: NOW: 2024/01/18 08:43:48.318273
> TIME: SINCE-PREV: 0:00:00.040824
> TIME: SINCE-START: 0:02:18.094586
> Stream: console
> =3D> mii info
> PHY 0x00: OUI =3D 0x0732, Model =3D 0x11, Rev =3D 0x06, 100baseT, FDX
> PHY 0x01: OUI =3D 0x0732, Model =3D 0x11, Rev =3D 0x06, 100baseT, FDX
> =3D>
> End stream: console
> TIME: NOW: 2024/01/18 08:43:48.370420
> TIME: SINCE-PREV: 0:00:00.052147
> TIME: SINCE-START: 0:02:18.146733
> Stream: console
> =3D> mii modify 0x0 0 0x8000 0x8000
> =3D>
> End stream: console
> TIME: NOW: 2024/01/18 08:43:48.451550
> TIME: SINCE-PREV: 0:00:00.081130
> TIME: SINCE-START: 0:02:18.227863
> Stream: console
> =3D> dhcp
> End stream: console
> TIME: NOW: 2024/01/18 08:43:48.493680
> TIME: SINCE-PREV: 0:00:00.042130
> TIME: SINCE-START: 0:02:18.269993
> Stream: console
> ethernet@ff3f0000 Waiting for PHY auto negotiation to complete..... done
> Speed: 100, full duplex
> BOOTP broadcast 1
> DHCP client bound to address 10.34.56.144 (3 ms)
> =3D>
> End stream: console
> TIME: NOW: 2024/01/18 08:43:51.002287
> TIME: SINCE-PREV: 0:00:02.508607
> TIME: SINCE-START: 0:02:20.778600
> Stream: console
> =3D>
> End stream: console
> FAILED:
> test/py/tests/test_net.py:171: in test_net_dhcp_abort
>     assert "DHCP client bound to address " not in output
> E   AssertionError: assert 'DHCP client... to address ' not in 'Speed: 10=
0,...6.144 (3 ms)'
> E     'DHCP client bound to address ' is contained here:
> E       dcast 1
> E
> E       DHCP client bound to address 10.34.56.144 (3 ms)
> TIME: SINCE-SECTION: 0:00:03.866916
> End section: test_net_dhcp_abort
>=20
> Full test logs:
> Job https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/595614=
6503 :
> https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest/-/jobs/595614650=
3/artifacts/test-log.html
> Job https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/595609=
7398 :
> https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest/-/jobs/595609739=
8/artifacts/test-log.html
>=20
> It seems it makes DHCP fail on subsequent board reboots.

We need to rework this test to be opt-in rather than opt-out, I'll
revert for now.

--=20
Tom

--ohT+xT3BacEh6XBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWpMGgACgkQFHw5/5Y0
tywjgAv/SrLT1FDX+WR5jWoVJyHlhT2M7IPV5Ll2ZJFbiwUFxeGi5YRwaZCxG10H
MoXQBm4zUxOBVFFZ1bGPZZPAs6pahHB2HGxD60ut5BEzsauRPeBRGvcZqzpiiRfU
nrvvX2PbmBWYkXA9+d1P0OP7R2mn4DuMEmqRnA2eFPoFf47KARQ3UpPXBi940CIj
Ly7QpeBmMUDUINb7sUZgUnFAWx8rAdTFnVHfprpQfO5KJqKUwH45MfDAM81vrKKP
ns4O0aIPGc+dgPZGIVfZ4cY1OeQw883sqvSUv7A+Xhp6guIt51XxYWvoq5vYGTQE
G5l6+GLuQ2x3Puu0mGRecGyLn3KBwPFxM+SqM55i+i5NrDMiUKOw/+E9a/fEzAML
3TXRbzWG63Zil9nG9q14fypOWpZLZx8yWcW0iZCnTGzIqvlkcq4xADQNOZckz2eJ
Us8jzT3KllWnDmF0CEc2FTkiU4HcX5ZQNkOsvJw04+4Jwol/ZgKC+mbixVnm1N4+
IXY6d3GS
=R5qd
-----END PGP SIGNATURE-----

--ohT+xT3BacEh6XBc--
