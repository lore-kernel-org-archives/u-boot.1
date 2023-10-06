Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5B5E94114
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 924FC86D30;
	Fri,  6 Oct 2023 22:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PQxugixu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A59DA86ACF; Fri,  6 Oct 2023 22:26:55 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D0386D3C
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-57b706f604aso1461736eaf.0
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696624012; x=1697228812; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZ57fGBGZTdbCsnLiO6tZiq6k8fGZUno3kPzj9bMXB4=;
 b=PQxugixuMh/WrK1jlTwjbMmfVQBY6GI4RMgdgw158lm2mrWOPcx/w9YzUhbCyD5ZGO
 vKOdlQFyMF7fGm1Cuerp4VDsyQmNfRVehY6QcHG5b+Je8aes21/s9RaSLF7cOBFg4l1N
 HX2W0dwyPHxXBFSSLMhCuP8miTzbsjKF59srj4mjWVQ3RNdXd1tzTgiM9wOE2+yIyLhQ
 aId02P8t97YXnXGhYvcm4B9FL6T1ltcJvHeEXYaBx8H6hL7Asa1pi0uGTAbKuVUZimRT
 DVn6eDKOGy4B3SwXalAyfrPFokvwyUV3/iTQdLmHXsCD8qmCQzGvGHxvUtn7yMvqvoge
 AlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696624012; x=1697228812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZ57fGBGZTdbCsnLiO6tZiq6k8fGZUno3kPzj9bMXB4=;
 b=tE30oRL4cxPu9w73MhGKJ0VUJ9HxMyCjWaqGsbRKjUnOdVVqkboyHBZu4weL6g3KMp
 9xYu60cFvzqgYeu2qI76c1YsmhgkA/eCzrNdJDdfl0cFQdHBWS411STH3IQHxbBy6Yux
 I6JhH+nRpEHl6r6hueliJrd4N+o5kpRYdM84gdnNMXbhTOUEQjXppajTRNkbKVVdkHNK
 Udckg1Vk+QOApPxI/fjGtPXD8bkn1TA+zmF1GWiaFsKaP9NVZILDpjn4G3cyhnp3pBcR
 QlSu/shln3jaAbxohT/VgezSnDs92KX3BUp2tD6cN1emQBqDPAzHrz+hgZOKqJNidFJS
 Ujqw==
X-Gm-Message-State: AOJu0Yx3hhi94r8cOZaoeFx/Ln92DTBYvLxAF4Su98T+ZuRx96HU2rrq
 zd7gYMPgwan6PoGttZFpfs6AQk8kji1YLnVn9Ko=
X-Google-Smtp-Source: AGHT+IG6KC3BrinFVhrJnCBF6p0qfTReMMT+AcDXvVwnSlt7P6v/VpNABtnathf33ed9axB5ofnV2wH6WwC+v1/0fQs=
X-Received: by 2002:a4a:3009:0:b0:57b:92f2:1f64 with SMTP id
 q9-20020a4a3009000000b0057b92f21f64mr10016744oof.8.1696624012091; Fri, 06 Oct
 2023 13:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <12a4371d0abfe7de83a42847573b8db8c1bba8da.1696337031.git.love.kumar@amd.com>
In-Reply-To: <12a4371d0abfe7de83a42847573b8db8c1bba8da.1696337031.git.love.kumar@amd.com>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 6 Oct 2023 23:26:41 +0300
Message-ID: <CAGi-RUKT_AHD9z+c=4+tKdT=Let88UYVGa5e5CZDfFDZ6HV8CQ@mail.gmail.com>
Subject: Re: [PATCH] test/py: net: Add dhcp abort test
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

On Tue, Oct 3, 2023 at 3:46=E2=80=AFPM Love Kumar <love.kumar@amd.com> wrot=
e:
>
> Abort the dhcp request in the middle by pressing ctrl + c on u-boot
> prompt and validate the abort status.
>
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>  test/py/tests/test_net.py | 44 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
> index cd4b4dc53cbc..1e8eb0357eef 100644
> --- a/test/py/tests/test_net.py
> +++ b/test/py/tests/test_net.py
> @@ -6,6 +6,7 @@
>
>  import pytest
>  import u_boot_utils
> +import re
>
>  """
>  Note: This test relies on boardenv_* containing configuration values to =
define
> @@ -104,6 +105,49 @@ def test_net_dhcp(u_boot_console):
>      global net_set_up
>      net_set_up =3D True
>
> +@pytest.mark.buildconfigspec("cmd_dhcp")
> +def test_net_dhcp_abort(u_boot_console):
> +    """Test the dhcp command by pressing ctrl+c in the middle of dhcp re=
quest
> +
> +    The boardenv_* file may be used to enable/disable this test; see the
> +    comment at the beginning of this file.
> +    """
> +
> +    test_dhcp =3D u_boot_console.config.env.get("env__net_dhcp_server", =
False)
> +    if not test_dhcp:
> +        pytest.skip("No DHCP server available")
> +
> +    u_boot_console.run_command("setenv autoload no")
> +
> +    # Phy reset before running dhcp command
> +    output =3D u_boot_console.run_command("mii device")
> +    eth_num =3D re.search(r"Current device: '(.+?)'", output).groups()[0=
]
> +    u_boot_console.run_command(f"mii device {eth_num}")
> +    output =3D u_boot_console.run_command("mii info")
> +    eth_addr =3D hex(int(re.search(r"PHY (.+?):", output).groups()[0], 1=
6))
> +    u_boot_console.run_command(f"mii modify {eth_addr} 0 0x8000 0x8000")
> +
> +    u_boot_console.run_command("dhcp", wait_for_prompt=3DFalse)
> +    try:
> +        u_boot_console.wait_for("Waiting for PHY auto negotiation to com=
plete")
> +    except:
> +        pytest.skip("Timeout waiting for PHY auto negotiation to complet=
e")
> +
> +    u_boot_console.wait_for("done")
> +
> +    # Sending Ctrl-C
> +    output =3D u_boot_console.run_command(
> +        chr(3), wait_for_echo=3DFalse, send_nl=3DFalse
> +    )
> +
> +    assert "TIMEOUT" not in output
> +    assert "DHCP client bound to address " not in output
> +    assert "Abort" in output
> +
> +    # Provide a time to recover from Abort - if it is not performed
> +    # There is message like: ethernet@ff0e0000: No link.
> +    u_boot_console.run_command("sleep 1")
> +
>  @pytest.mark.buildconfigspec('cmd_dhcp6')
>  def test_net_dhcp6(u_boot_console):
>      """Test the dhcp6 command.
> --
> 2.25.1
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
