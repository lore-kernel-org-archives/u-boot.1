Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DF2C25B7E
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 18:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9407B88735;
	Thu, 30 May 2024 20:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MoPUm1v1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 962C98870D; Thu, 30 May 2024 16:22:39 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D53288708
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 16:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=muvarov@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57a034697fbso1210390a12.0
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717078957; x=1717683757; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iqcHsO7IfRjkDS9XO6JfNZj3SBQFYCJ4aRkRWOrYk0=;
 b=MoPUm1v1xuFX/JlToAsTn/QY1w4loG/3dnB5zyWfh3HDqtIeMaLx2lvHA9SzwTQJq+
 oE20tiBox2VAYzfqYbsVKCHEIi1sUd0thTAk7ygv+2NVGwWeLZUDP+mhEz7PJBkyzbfV
 qvIMrQ1WL9AsinLbA2xpO3a0hAUTmPcTShcYdyAmVcAnJf4qRNsb8JL6UHIZmPtSTyz+
 iNTP5NQTzGHYhtV06seCLuxT6fgnyv6VgtXmntxKJ6ZUkuzAs0kfI5RU6WZaLRJiCs6D
 UA0Wp+eFC1FOPQAhfj2HbAJLq2YYYy9xAgAt45gTwU1QM1rnHEOeQUKczL6v+McL/98k
 b1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717078957; x=1717683757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2iqcHsO7IfRjkDS9XO6JfNZj3SBQFYCJ4aRkRWOrYk0=;
 b=BPfaOcK6+XTmPua299y+r8pFitDDeYC4Amo607qBVD9Bpq2QEPncEXEq34nCs/4a1g
 IvG+icPeMw2gYXfUqqVpWNcgZ2i/5t9oWs4JXbqehBAI27+o/KbzsAxi544fR66lTTaN
 NiMueOh4qrwOA5SRRBVPvHLMQ7zuigN94xIppxAXrlJeHMHwQnJo3Gx6xVDkGLgXypW9
 p9TQR8LdM3EGJARXJxKpbvR7IfSdh+bIj/HukrO/kUhkA5d/8QkJ6+yEXGuFDzq9obQH
 uFY6PcoEzPtUN4vUfgrSeK8W+weD8U8aR3XLxRJ7Q7t/+vyd3jLerZdA+yLkABLk9/Nc
 Cx1Q==
X-Gm-Message-State: AOJu0Yw9fN+PUnEILS/7JDt9NSvrspxqfgXYCUI9lb/EFyPIWOGtB4O+
 25jlWbBGX/KOIUk50uGsUSyGRIRk+ylaF7OKpIENit1S3ign/In8qJyGYyFlmj8IxMiXaRz+f2c
 MDAwPwWC334LF+eYc9NcRO5UGDTE=
X-Google-Smtp-Source: AGHT+IHo17unJVtKvkDqy0kDOM0VnwuzX0fktCt63/YX7ab4RzC6kNMostyCMSa4XHyRNjGPyQRgyhRi9Kg0o01t64k=
X-Received: by 2002:a17:906:8a79:b0:a65:cea9:dd56 with SMTP id
 a640c23a62f3a-a65e8e74832mr127639166b.33.1717078956573; Thu, 30 May 2024
 07:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <9acc7630e5768ab9af673981a78ffb84b47aa62e.1716566960.git.jerome.forissier@linaro.org>
 <CAJGZr0JN3SLGfjRunLpvstBEfpOr6tHgt4h0K5_1Cayn+5WKOw@mail.gmail.com>
 <1b104b1a-f6cd-4d16-b1e9-9f87ef483443@linaro.org>
In-Reply-To: <1b104b1a-f6cd-4d16-b1e9-9f87ef483443@linaro.org>
From: Maxim Uvarov <muvarov@gmail.com>
Date: Thu, 30 May 2024 17:22:24 +0300
Message-ID: <CAJGZr0LmonXv-RDE3tawT49tj8WNHe=fh2zhhg2wfh_6gvx6+Q@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] test/py: net: add _lwip variants of dhcp, ping
 and tftpboot tests
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Love Kumar <love.kumar@amd.com>, Maxim Uvarov <maxim.uvarov@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 30 May 2024 20:01:25 +0200
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

=D1=87=D1=82, 30 =D0=BC=D0=B0=D1=8F 2024=E2=80=AF=D0=B3. =D0=B2 17:11, Jero=
me Forissier <jerome.forissier@linaro.org>:
>
>
>
> On 5/28/24 11:53, Maxim Uvarov wrote:
> > =D0=BF=D1=82, 24 =D0=BC=D0=B0=D1=8F 2024=E2=80=AF=D0=B3. =D0=B2 19:22, =
Jerome Forissier <jerome.forissier@linaro.org>:
> >>
> >> WHen NET_LWIP is enabled, the dhcp/ping/tftpboot commands are enabled
> >> via CMD_DHCP_LWIP, CMD_PING_LWIP and CMD_TFTPBOOT_LWIP, respectively;
> >> therefore the config annotations in the Python test scripts need to be
> >> cmd_dhcp_lwip, cmd_ping_lwip and cmd_tftpboot_lwip.
> >>
> >> The console output of the tftpboot command with lwIP is slightly
> >> different from the non-lwIP implementation. This is taken care of in
> >> test_net_tftpboot().
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >>  test/py/tests/test_net.py | 21 +++++++++++++++++----
> >>  1 file changed, 17 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
> >> index 038a473b239..ba30780903f 100644
> >> --- a/test/py/tests/test_net.py
> >> +++ b/test/py/tests/test_net.py
> >> @@ -127,6 +127,10 @@ def test_net_dhcp(u_boot_console):
> >>      global net_set_up
> >>      net_set_up =3D True
> >>
> >> +@pytest.mark.buildconfigspec('cmd_dhcp_lwip')
> >> +def test_net_dhcp_lwip(u_boot_console):
> >> +    test_net_dhcp(u_boot_console)
> >> +
> >>  @pytest.mark.buildconfigspec('cmd_dhcp')
> >>  @pytest.mark.buildconfigspec('cmd_mii')
> >>  def test_net_dhcp_abort(u_boot_console):
> >> @@ -230,6 +234,10 @@ def test_net_ping(u_boot_console):
> >>      output =3D u_boot_console.run_command('ping $serverip')
> >>      assert 'is alive' in output
> >>
> >> +@pytest.mark.buildconfigspec('cmd_ping_lwip')
> >> +def test_net_ping_lwip(u_boot_console):
> >> +    test_net_ping(u_boot_console)
> >> +
> >>  @pytest.mark.buildconfigspec('IPV6_ROUTER_DISCOVERY')
> >>  def test_net_network_discovery(u_boot_console):
> >>      """Test the network discovery feature of IPv6.
> >> @@ -255,7 +263,7 @@ def test_net_network_discovery(u_boot_console):
> >>      assert '0000:0000:0000:0000:0000:0000:0000:0000' not in output
> >>
> >>  @pytest.mark.buildconfigspec('cmd_net')
> >> -def test_net_tftpboot(u_boot_console):
> >> +def test_net_tftpboot(u_boot_console, lwip =3D False):
> >>      """Test the tftpboot command.
> >>
> >>      A file is downloaded from the TFTP server, its size and optionall=
y its
> >> @@ -279,10 +287,11 @@ def test_net_tftpboot(u_boot_console):
> >>          output =3D u_boot_console.run_command('tftpboot %s' % (fn))
> >>      else:
> >>          output =3D u_boot_console.run_command('tftpboot %x %s' % (add=
r, fn))
> >> -    expected_text =3D 'Bytes transferred =3D '
> >>      sz =3D f.get('size', None)
> >> -    if sz:
> >> -        expected_text +=3D '%d' % sz
> >> +    if lwip:
> >> +        expected_text =3D f'{sz} bytes transferred'
> >
> > Why not change patch 5 to print with capital character to match this pa=
ttern?
>
> I thought unifying the messages of wget and tftp would be a good idea. Wi=
th
> this series, both commands print hash signs followed by:
> "xxx bytes transferred (yy MB/s)".
>
> Would a patch updating the tftp message when the legacy stack is used be
> acceptable?
>
> --
> Jerome
>

I think yes.

BR,
Maxim.

> > BR,
> > Maxim.
> >
> >> +    else:
> >> +        expected_text =3D f'Bytes transferred =3D {sz}'
> >>      assert expected_text in output
> >>
> >>      expected_crc =3D f.get('crc32', None)
> >> @@ -295,6 +304,10 @@ def test_net_tftpboot(u_boot_console):
> >>      output =3D u_boot_console.run_command('crc32 $fileaddr $filesize'=
)
> >>      assert expected_crc in output
> >>
> >> +@pytest.mark.buildconfigspec("cmd_net_lwip")
> >> +def test_net_tftpboot_lwip(u_boot_console):
> >> +    test_net_tftpboot(u_boot_console, True)
> >> +
> >>  @pytest.mark.buildconfigspec('cmd_nfs')
> >>  def test_net_nfs(u_boot_console):
> >>      """Test the nfs command.
> >> --
> >> 2.40.1
> >>
> >
> >



--=20
Best regards,
Maxim Uvarov
