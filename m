Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E64E94114
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF88C86BE7;
	Fri,  6 Oct 2023 22:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lgnyGtX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A9986C78; Fri,  6 Oct 2023 22:26:19 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB5B086ACF
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57b6c7d0cabso1493139eaf.1
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696623975; x=1697228775; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EN3VbJKpueOyfFSkLYfny1GWxIQAVl7frgDK2P/7ItY=;
 b=lgnyGtX/H9AvceTu5dyIvpOJFYwLH8idd4JY7UVoHXDu44DgAHzQKr9NP9ONR90z+1
 gax1+0+wmG0oULcjh8Qb/755Lo98nLiYELayIdWVz+YMda7qUIyWLjGeriZk/nAEyEfk
 2vJwn9uwav9RzkxNk7FYdTeU2vAEee/ZL8ImrvzOQT9k2I6JqyZ30VS9pYnmh62Z/Isw
 qjlMNUfSI9/bQGiadhZND4GOroF7TIJB3xeH7RCYt/IW+6B7ZmlAocrX4G2ifdVEfntg
 ZzS+HOOCShMttuJHfiTYYvInuKpRF2Qvn8Oh3RKOjey6x+GXJ9cVF9u38t/5v9jF8r/E
 MH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696623975; x=1697228775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EN3VbJKpueOyfFSkLYfny1GWxIQAVl7frgDK2P/7ItY=;
 b=nXQPqqRV7TrWrDav4oEuJRI3Zr9mPe5JoGC0zfZaFYzsymxOyesggZRQYcQysvS60t
 KySitPCqBHNsJpaoNuwvpJdzIGzQkgah1kM315W1M5JO/+sremlrLCWwbAzeSfPzVpOS
 Vxacq+zU//VE3iLZz4P/jglxIcsdwdHf9zymN0Y6wa/dcPNTUBqworkJpqiTftYf0D+e
 n3ReE/qZ86GkzjCTx59IKosPRfSh3xVALdCCWUrJHT2Sb0C0/zJaWCrSskZ0OmJhnI4w
 LVznP9DaXBaraWW7bI3rRYT7TyUmdguO0OZ8O09eApzu4rw/CRYeurNdzu8DROU0TPUm
 zOOg==
X-Gm-Message-State: AOJu0Yz8drycnIJwKhH6feWSC8nbivNHh5Q39AEFv55fuPSBS6FcEVAO
 msgOLPXZKR3C335xs1Hl+rn83QKl57pC3YnKrgo=
X-Google-Smtp-Source: AGHT+IHKbEiNq7NWrTKzU7gqv0u9/JGYk389hQAwiEJk2jF2IwLp6V2wM4tv5YzDy4pCtGFEXtHNlJkpB1L4gpWqXkw=
X-Received: by 2002:a4a:6c57:0:b0:57b:82d2:8254 with SMTP id
 u23-20020a4a6c57000000b0057b82d28254mr8861129oof.3.1696623975202; Fri, 06 Oct
 2023 13:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <f67478ee2642e6c598da4364f84c3bec900f89c3.1696323438.git.love.kumar@amd.com>
In-Reply-To: <f67478ee2642e6c598da4364f84c3bec900f89c3.1696323438.git.love.kumar@amd.com>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 6 Oct 2023 23:26:04 +0300
Message-ID: <CAGi-RU+vrfYjHU3OpvuvQyZ07O+iDMCmPbR1Js7t4y2KitFaLg@mail.gmail.com>
Subject: Re: [PATCH] test/py: net: Add a TFTP put test
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com, 
 v.v.mitrofanov@yadro.com, seanedmond@microsoft.com, 
 emohandesi@linux.microsoft.com
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

On Tue, Oct 3, 2023 at 12:02=E2=80=AFPM Love Kumar <love.kumar@amd.com> wro=
te:
>
> Execute tftpput command for uploading files to a server and validate its
> size & CRC32.
>
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>  test/py/tests/test_net.py | 69 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
> index cd4b4dc53cbc..f69e3ea2dbba 100644
> --- a/test/py/tests/test_net.py
> +++ b/test/py/tests/test_net.py
> @@ -6,6 +6,7 @@
>
>  import pytest
>  import u_boot_utils
> +import datetime
>
>  """
>  Note: This test relies on boardenv_* containing configuration values to =
define
> @@ -50,6 +51,7 @@ env__net_tftp_readable_file =3D {
>      'addr': 0x10000000,
>      'size': 5058624,
>      'crc32': 'c2244b26',
> +    'timeout': 50000,
>  }
>
>  # Details regarding a file that may be read from a NFS server. This vari=
able
> @@ -260,3 +262,70 @@ def test_net_nfs(u_boot_console):
>
>      output =3D u_boot_console.run_command('crc32 %x $filesize' % addr)
>      assert expected_crc in output
> +
> +@pytest.mark.buildconfigspec("cmd_crc32")
> +@pytest.mark.buildconfigspec("cmd_net")
> +def test_net_tftpput(u_boot_console):
> +    """Test the tftpput command.
> +    A file is downloaded from the TFTP server and then uploaded to the T=
FTP
> +    server, its size and its CRC32 are validated.
> +    The details of the file to download are provided by the boardenv_* f=
ile;
> +    see the comment at the beginning of this file.
> +    """
> +
> +    if not net_set_up:
> +        pytest.skip("Network not initialized")
> +
> +    f =3D u_boot_console.config.env.get("env__net_tftp_readable_file", N=
one)
> +    if not f:
> +        pytest.skip("No TFTP readable file to read")
> +
> +    addr =3D f.get("addr", None)
> +    if not addr:
> +        addr =3D u_boot_utils.find_ram_base(u_boot_console)
> +
> +    sz =3D f.get("size", None)
> +    timeout =3D f.get("timeout", u_boot_console.p.timeout)
> +    fn =3D f["fn"]
> +    fnu =3D "_".join([datetime.datetime.now().strftime("%y%m%d%H%M%S"), =
fn])
> +    expected_text =3D "Bytes transferred =3D "
> +    if sz:
> +        expected_text +=3D "%d" % sz
> +
> +    with u_boot_console.temporary_timeout(timeout):
> +        output =3D u_boot_console.run_command("tftpboot %x %s" % (addr, =
fn))
> +
> +    assert "TIMEOUT" not in output
> +    assert expected_text in output
> +
> +    expected_tftpb_crc =3D f.get("crc32", None)
> +
> +    output =3D u_boot_console.run_command("crc32 $fileaddr $filesize")
> +    assert expected_tftpb_crc in output
> +
> +    with u_boot_console.temporary_timeout(timeout):
> +        output =3D u_boot_console.run_command(
> +            "tftpput $fileaddr $filesize $serverip:%s" % (fnu)
> +        )
> +
> +    expected_text =3D "Bytes transferred =3D "
> +    if sz:
> +        expected_text +=3D "%d" % sz
> +        addr =3D addr + sz
> +    assert "TIMEOUT" not in output
> +    assert "Access violation" not in output
> +    assert expected_text in output
> +
> +    with u_boot_console.temporary_timeout(timeout):
> +        output =3D u_boot_console.run_command("tftpboot %x %s" % (addr, =
fnu))
> +
> +    expected_text =3D "Bytes transferred =3D "
> +    if sz:
> +        expected_text +=3D "%d" % sz
> +    assert "TIMEOUT" not in output
> +    assert expected_text in output
> +
> +    expected_tftpp_crc =3D expected_tftpb_crc
> +
> +    output =3D u_boot_console.run_command("crc32 $fileaddr $filesize")
> +    assert expected_tftpp_crc in output
> --
> 2.25.1
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
