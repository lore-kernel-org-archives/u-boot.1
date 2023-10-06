Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD904E94114
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E26286C78;
	Fri,  6 Oct 2023 22:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jUX6RJJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7055586D7E; Fri,  6 Oct 2023 22:27:37 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E39B86ACF
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57b9231e91dso1442039eaf.2
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696624053; x=1697228853; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/u47TsV5kAHbJnXomo1lS6pGCQ0BF5TQg8f8FYVrBkg=;
 b=jUX6RJJGbuq4nrqQrUFy6ie76S2yqZ8yHCHuH3ptRBHQIN2eq2RNeAhhN/2tn+rog8
 7NNf8W98IP84RSact7m6dQupXxtJ6QmPNfyVBRZPpmRxARPiM+h54OQdQB71F1/5O/tH
 +EPTLvZxzV4C1ydp/Dwo3TCNnTeE4/9UxTzjOvt1ysoOJSbnQqu0zMKT6FnwnNKkd0+1
 17wtDXCeQRnAOaohfKnUKmaqYGqfyhwnjwZOrCu2IurIYZEFUO9wIlrvhIhlWRN6ywzT
 fs4Id6DfZ0SNM8eOibu+WW3vlQ3WukNMaoHQ07strq/L/b9ePBIsMzojlvkbW90zm7U3
 v/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696624053; x=1697228853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/u47TsV5kAHbJnXomo1lS6pGCQ0BF5TQg8f8FYVrBkg=;
 b=hENZicHBJHw9KMYUSWaau42mAQiK3+1oRUvWnBZtHACzz3eyr9bCkSJ7e/7BulI7jh
 tk7vK7ZT4DdyaQ2EkA7sYRJjzL/h6dJ/NQgUm99TA8GQyR0ekq/nKuXuu+ko0tawNNPk
 mVbbRlk/NAQwH14Vaq5Zj/gLGF0O5ef7EM8FDMJX47DmBmmo7UUCn7747W95RbUCFmCR
 e0m6RIhzwmVvxaBXB+cLaxxhDoUsk6T+w21j07oSqCjTUKYAAJF7712aN50Dt3wWLhs8
 Jetzhn0JPIF3gjqqkwANrAkF1e860mPA+GgFN4tjG2ahQnI7Ghe97uQi5wXwStenza1S
 5wFw==
X-Gm-Message-State: AOJu0Yzcy4AnKsFGCmjJlrNLHSmBhjPfAJpg7F9EttpDHSORgw9nA1Dl
 FP02MgVFGumU9q8Dsz1CFN3OtBSNHMQoom14FQs=
X-Google-Smtp-Source: AGHT+IGI9YUdwqyfjSueQqVLPYYZluYmuDoFavtAFzuxftQ8OM6+ftT8rGeb6EDzyqNLtfE/szxTPYzkUY74Hu3ra4E=
X-Received: by 2002:a4a:8447:0:b0:571:28d5:2c71 with SMTP id
 m7-20020a4a8447000000b0057128d52c71mr7612610oog.2.1696624053749; Fri, 06 Oct
 2023 13:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <b5d263cf61282b158052ba87bde1fb4a227c0bb7.1696338593.git.love.kumar@amd.com>
In-Reply-To: <b5d263cf61282b158052ba87bde1fb4a227c0bb7.1696338593.git.love.kumar@amd.com>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 6 Oct 2023 23:27:22 +0300
Message-ID: <CAGi-RUKAYoCjmCJa_tBLsHHJfHn5hrJjn22A_MOhbnH8yaSuJw@mail.gmail.com>
Subject: Re: [PATCH] test/py: net: Add a test for 'pxe get' command
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

On Tue, Oct 3, 2023 at 4:12=E2=80=AFPM Love Kumar <love.kumar@amd.com> wrot=
e:
>
> Execute the 'pxe get' command to download a pxe configuration file from
> the TFTP server and validate its interpretation.
>
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>  test/py/tests/test_net.py | 66 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
> index cd4b4dc53cbc..b2241ae6a482 100644
> --- a/test/py/tests/test_net.py
> +++ b/test/py/tests/test_net.py
> @@ -6,6 +6,7 @@
>
>  import pytest
>  import u_boot_utils
> +import uuid
>
>  """
>  Note: This test relies on boardenv_* containing configuration values to =
define
> @@ -61,6 +62,16 @@ env__net_nfs_readable_file =3D {
>      'crc32': 'c2244b26',
>  }
>
> +# Details regarding a file that may be read from a TFTP server. This var=
iable
> +# may be omitted or set to None if PXE testing is not possible or desire=
d.
> +env__net_pxe_readable_file =3D {
> +    'fn': 'default',
> +    'addr': 0x2000000,
> +    'size': 74,
> +    'timeout': 50000,
> +    'pattern': 'Linux',
> +}
> +
>  # True if a router advertisement service is connected to the network, an=
d should
>  # be tested. If router advertisement testing is not possible or desired,=
 this
>  variable may be omitted or set to False.
> @@ -260,3 +271,58 @@ def test_net_nfs(u_boot_console):
>
>      output =3D u_boot_console.run_command('crc32 %x $filesize' % addr)
>      assert expected_crc in output
> +
> +@pytest.mark.buildconfigspec("cmd_net")
> +@pytest.mark.buildconfigspec("cmd_pxe")
> +def test_net_pxe_get(u_boot_console):
> +    """Test the pxe get command.
> +
> +    A pxe configuration file is downloaded from the TFTP server and inte=
rpreted
> +    to boot the images mentioned in pxe configuration file.
> +
> +    The details of the file to download are provided by the boardenv_* f=
ile;
> +    see the comment at the beginning of this file.
> +    """
> +
> +    if not net_set_up:
> +        pytest.skip("Network not initialized")
> +
> +    test_net_setup_static(u_boot_console)
> +
> +    f =3D u_boot_console.config.env.get("env__net_pxe_readable_file", No=
ne)
> +    if not f:
> +        pytest.skip("No PXE readable file to read")
> +
> +    addr =3D f.get("addr", None)
> +    timeout =3D f.get("timeout", u_boot_console.p.timeout)
> +
> +    pxeuuid =3D uuid.uuid1()
> +    u_boot_console.run_command(f"setenv pxeuuid {pxeuuid}")
> +    expected_text_uuid =3D f"Retrieving file: pxelinux.cfg/{pxeuuid}"
> +
> +    ethaddr =3D u_boot_console.run_command("echo $ethaddr")
> +    ethaddr =3D ethaddr.replace(':', '-')
> +    expected_text_ethaddr =3D f"Retrieving file: pxelinux.cfg/01-{ethadd=
r}"
> +
> +    ip =3D u_boot_console.run_command("echo $ipaddr")
> +    ip =3D ip.split('.')
> +    ipaddr_file =3D "".join(['%02x' % int(x) for x in ip]).upper()
> +    expected_text_ipaddr =3D f"Retrieving file: pxelinux.cfg/{ipaddr_fil=
e}"
> +    expected_text_default =3D f"Retrieving file: pxelinux.cfg/default"
> +
> +    with u_boot_console.temporary_timeout(timeout):
> +        output =3D u_boot_console.run_command("pxe get")
> +
> +    assert "TIMEOUT" not in output
> +    assert expected_text_uuid in output
> +    assert expected_text_ethaddr in output
> +    assert expected_text_ipaddr in output
> +
> +    i =3D 1
> +    for i in range(0, len(ipaddr_file) - 1):
> +        expected_text_ip =3D f"Retrieving file: pxelinux.cfg/{ipaddr_fil=
e[:-i]}"
> +        assert expected_text_ip in output
> +        i +=3D 1
> +
> +    assert expected_text_default in output
> +    assert "Config file 'default.boot' found" in output
> --
> 2.25.1
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
