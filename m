Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D394C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AAB488571;
	Tue, 28 May 2024 18:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bRCL4S7+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE318844E; Tue, 28 May 2024 11:53:38 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64E0888418
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 11:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=muvarov@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a63359aaacaso72472766b.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716890016; x=1717494816; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lk4xMxRJsg3oo04+pKIUq27nY4m6j6dwWGnXKxG0bBA=;
 b=bRCL4S7+btiEmTjjiXNgki+ECXweH/ygdKhr0zA/GXnP9SY8xi1EaY1c9nu5JBAFr6
 25rJ1YcpGGfGy/4V6MADsolTZ5tKh69btpRM5JnHhZ2zFK1E1ppfhgoT3E3JWQcKQvWg
 RLqGZ3xT8dngauNAtmgEoKcbzDsBC9YD5S+g/0JCtx82icjKDioo+pPDpM7DcPOBpDib
 q1w19D0/DYvffJ0k+8yw7ir5ScH8nveE3ivL8SZ8STU39gHkcyEl7mT8Xoa0BKLuIie6
 hqBFI156WQhNtweOekhZy49y2+XcM0U617GHFKV1ouPNjwhr9G2lgCM4s1Jnqy8dlJsD
 jHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716890016; x=1717494816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lk4xMxRJsg3oo04+pKIUq27nY4m6j6dwWGnXKxG0bBA=;
 b=tcviKAxQ4Umhvx4ZiqZJiq5+pKgL68efNxjeUidPjuOW+apuyBNye9JSrR3kAE0VGj
 x+N24eZ3NxO04I1tUa2r+Qu4aN7qRIJLd0mztG0dZqPSaPcLWCkloPf3iaDMP2eJw3vh
 HfCo4A6KfzGXHecgk1v7ZhzNoo6BHYnOwds6E7zFB24URKAiffagcdqTWuBKIVDJ4ED0
 T8DrIuhWN5Q9XFleSJ0JmY2dzyMaKVkTT2IWIIAIgvY1jIzKSZvasueFND3pR+NmmKQa
 C638DfLaPEG7TNVwlQsbkZu1u6LX4rMQHKTwIOQ+0SBBATWwEkLZQaNR33Ot6F72sl/j
 s7cQ==
X-Gm-Message-State: AOJu0YzaAyZheTj3Yq7ihkj8xqGG8ujAH66hp9mEVvmgHPpmyoze7fVE
 cencDMLu1ctdN6wMGY104qjYCKMmCP4LBonkQlToJR5mAi2xiH9/lNTdNYwvjYZrfaT4kNjkmf1
 xRgYNJ4vvpmvWqNrhBL4QQGWLu+SfLg==
X-Google-Smtp-Source: AGHT+IG7vo+ZvQBFuEnwoZjyVggVW3CBgWVx94rMv4uKc6fPYnGk+2yuK68Ja3d99FPzs7u07ukABU4207NXz6z8QLE=
X-Received: by 2002:a17:906:b7d6:b0:a63:2fba:ddeb with SMTP id
 a640c23a62f3a-a632fbade6dmr134413966b.37.1716890015543; Tue, 28 May 2024
 02:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <9acc7630e5768ab9af673981a78ffb84b47aa62e.1716566960.git.jerome.forissier@linaro.org>
In-Reply-To: <9acc7630e5768ab9af673981a78ffb84b47aa62e.1716566960.git.jerome.forissier@linaro.org>
From: Maxim Uvarov <muvarov@gmail.com>
Date: Tue, 28 May 2024 12:53:22 +0300
Message-ID: <CAJGZr0JN3SLGfjRunLpvstBEfpOr6tHgt4h0K5_1Cayn+5WKOw@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] test/py: net: add _lwip variants of dhcp, ping
 and tftpboot tests
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Love Kumar <love.kumar@amd.com>, Maxim Uvarov <maxim.uvarov@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 28 May 2024 18:47:36 +0200
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

=D0=BF=D1=82, 24 =D0=BC=D0=B0=D1=8F 2024=E2=80=AF=D0=B3. =D0=B2 19:22, Jero=
me Forissier <jerome.forissier@linaro.org>:
>
> WHen NET_LWIP is enabled, the dhcp/ping/tftpboot commands are enabled
> via CMD_DHCP_LWIP, CMD_PING_LWIP and CMD_TFTPBOOT_LWIP, respectively;
> therefore the config annotations in the Python test scripts need to be
> cmd_dhcp_lwip, cmd_ping_lwip and cmd_tftpboot_lwip.
>
> The console output of the tftpboot command with lwIP is slightly
> different from the non-lwIP implementation. This is taken care of in
> test_net_tftpboot().
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/py/tests/test_net.py | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
> index 038a473b239..ba30780903f 100644
> --- a/test/py/tests/test_net.py
> +++ b/test/py/tests/test_net.py
> @@ -127,6 +127,10 @@ def test_net_dhcp(u_boot_console):
>      global net_set_up
>      net_set_up =3D True
>
> +@pytest.mark.buildconfigspec('cmd_dhcp_lwip')
> +def test_net_dhcp_lwip(u_boot_console):
> +    test_net_dhcp(u_boot_console)
> +
>  @pytest.mark.buildconfigspec('cmd_dhcp')
>  @pytest.mark.buildconfigspec('cmd_mii')
>  def test_net_dhcp_abort(u_boot_console):
> @@ -230,6 +234,10 @@ def test_net_ping(u_boot_console):
>      output =3D u_boot_console.run_command('ping $serverip')
>      assert 'is alive' in output
>
> +@pytest.mark.buildconfigspec('cmd_ping_lwip')
> +def test_net_ping_lwip(u_boot_console):
> +    test_net_ping(u_boot_console)
> +
>  @pytest.mark.buildconfigspec('IPV6_ROUTER_DISCOVERY')
>  def test_net_network_discovery(u_boot_console):
>      """Test the network discovery feature of IPv6.
> @@ -255,7 +263,7 @@ def test_net_network_discovery(u_boot_console):
>      assert '0000:0000:0000:0000:0000:0000:0000:0000' not in output
>
>  @pytest.mark.buildconfigspec('cmd_net')
> -def test_net_tftpboot(u_boot_console):
> +def test_net_tftpboot(u_boot_console, lwip =3D False):
>      """Test the tftpboot command.
>
>      A file is downloaded from the TFTP server, its size and optionally i=
ts
> @@ -279,10 +287,11 @@ def test_net_tftpboot(u_boot_console):
>          output =3D u_boot_console.run_command('tftpboot %s' % (fn))
>      else:
>          output =3D u_boot_console.run_command('tftpboot %x %s' % (addr, =
fn))
> -    expected_text =3D 'Bytes transferred =3D '
>      sz =3D f.get('size', None)
> -    if sz:
> -        expected_text +=3D '%d' % sz
> +    if lwip:
> +        expected_text =3D f'{sz} bytes transferred'

Why not change patch 5 to print with capital character to match this patter=
n?

BR,
Maxim.

> +    else:
> +        expected_text =3D f'Bytes transferred =3D {sz}'
>      assert expected_text in output
>
>      expected_crc =3D f.get('crc32', None)
> @@ -295,6 +304,10 @@ def test_net_tftpboot(u_boot_console):
>      output =3D u_boot_console.run_command('crc32 $fileaddr $filesize')
>      assert expected_crc in output
>
> +@pytest.mark.buildconfigspec("cmd_net_lwip")
> +def test_net_tftpboot_lwip(u_boot_console):
> +    test_net_tftpboot(u_boot_console, True)
> +
>  @pytest.mark.buildconfigspec('cmd_nfs')
>  def test_net_nfs(u_boot_console):
>      """Test the nfs command.
> --
> 2.40.1
>


--=20
Best regards,
Maxim Uvarov
