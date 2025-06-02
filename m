Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3B4C5B555
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 20:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69CA7810EB;
	Mon,  2 Jun 2025 22:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V36Qpaf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9ECA81E72; Mon,  2 Jun 2025 22:52:03 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ECF28006D
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 22:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2e8f7ca7ca3so2786018fac.2
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 13:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748897519; x=1749502319; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k8krxjdHGxYB/DruoeQ7XgaPzECuNvKmtUDyggKe318=;
 b=V36Qpaf3gH8QLbQS69oeXKATkdzz5WuogBUCH5nzOMFH48FzJgCZh9u2N9b2ARmNBT
 sNLSP4sn7paxd5nUIYk05hoEM3WKyr9mY+L/yKR7QnbPZ5Fiq22Q0/S3k8De+15wcfk9
 DEtpEM3cBFoilgxaaKRViVbH7It1xRNnjei/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748897519; x=1749502319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8krxjdHGxYB/DruoeQ7XgaPzECuNvKmtUDyggKe318=;
 b=qgV/m6vOYWzZnXJG8usYc4L8hYGaIpFMY0xgrU0pINTcuPTq51QQe6jYAjKODZsqxs
 mQCX8kcVmkMihJCQMq90u51kz5RRuzhN0O8L6WP5yDh2fJ9FoHqipZ2BEf8a5bWLWQXm
 5SuuONQkz7BHv3HUvurWrT1/zYQwPgJNkUalzJXWuFvIW+V4OzgV9rSMBhmI+2hT97hN
 QgBxw+NWYsPTuS8qT/kz8EqqrRPw4SA+AbncbSEC2UVM+ago7gLuGCurjVlYROnXITxz
 7aeeyjIT1DAcZVOUwgw99jQ9GSAsjb3OIvnz539EBiXbYJg0odBnUP2sJzK4DNDM/UXR
 J34w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAjhOhBOMgZ7gKJLHf0mcWDvxcqL4jlRIpAuWkObOlryunqa5X0AoS6pP27W/Qb3blt+cDZKY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5mSHQ8r1pveeeC6acJKPHlIq+lo078zGAwoxNB0dZ9nYWwOtm
 SOW+iBtt5iNNjsmE8DXU7D4ejpQFlOH+sWodWa9OlQH1zJYYjxucdewyeanvF5gAUYQ=
X-Gm-Gg: ASbGncsDL1w5inn4/VvuesoJv1O03/GuoZ9h/4JyR3jaJw4l90c5NCucfB4bC9tOsco
 XTpRnxGvlAXvWCb7jqxhYccbvP0ZU+UftoxGk/upjn08ZVOEjFidyXIkqALqLMl2zm5BFSUpXjd
 cA0TkO2aG4e746o1pOSUMQum9x3CLtvSxVBKHdbQjK/BO5UWMKjxuqqrtN6KzUQn+1GGgD5q4pH
 VhL9Z/ZUbia0oxLugf0CJTszdNKoW6AO51JVNvCO2DkKoMxZKk58m8j1GOtKaKyIh0pK9iBLvlB
 p3qBNKuU47+z956hDX7XOh1Dchooob9oR+BQ5qYyyde5RdSmrHNvDslHkF+Fx0LikgH86FFDEM8
 K/NzUq0LyxQSv
X-Google-Smtp-Source: AGHT+IH0LIHAn2hN2OJrLO02QDvEE+tfDSuWUiTWEGdwU/MRMVICh/PUmBapdptjmTaW+/hUNa2b4A==
X-Received: by 2002:a05:6870:8a07:b0:2c1:a810:d697 with SMTP id
 586e51a60fabf-2e9488ace3fmr5290853fac.15.1748897519615; 
 Mon, 02 Jun 2025 13:51:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e906b810b3sm1982102fac.34.2025.06.02.13.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 13:51:58 -0700 (PDT)
Date: Mon, 2 Jun 2025 14:51:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: E Shattow <e@freeshell.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>,
 U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH 0/3] sntp for NET_LWIP
Message-ID: <20250602205155.GB100073@bill-the-cat>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
 <CAJ+vNU08-=eWAceEedRg7RabqB-BKO_1F+8EkDHB8zHg79VK3g@mail.gmail.com>
 <af397cfc-e222-4ed6-b8d7-802d9080dbfa@linaro.org>
 <a3ee52c2-0ee9-48b0-9cfc-a0efcb02907a@freeshell.de>
 <91F2F809-9971-45FD-8B45-30AE56E166A1@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rv+1OzatnQ8Gr6PZ"
Content-Disposition: inline
In-Reply-To: <91F2F809-9971-45FD-8B45-30AE56E166A1@gmx.de>
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


--rv+1OzatnQ8Gr6PZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2025 at 08:35:31PM +0200, Heinrich Schuchardt wrote:
> Am 2. Juni 2025 20:06:08 MESZ schrieb E Shattow <e@freeshell.de>:
> >
> >
> >On 6/2/25 01:11, Jerome Forissier wrote:
> >> Hi Tim,
> >>=20
> >> On 5/30/25 17:46, Tim Harvey wrote:
> >>> On Wed, May 21, 2025 at 8:15=E2=80=AFAM Jerome Forissier
> >>> <jerome.forissier@linaro.org> wrote:
> >>>>
> >>>> Implement the sntp command with lwIP (CONFIG_NET_LWIP=3Dy). SNTP is
> >>>> supported as an app in lib/lwip/lwip/src/apps/sntp/sntp.c so this is
> >>>> mainly about adding that file to the build and writing do_sntp() to =
use
> >>>> the sntp_*() API and run the receive & timer loop. There is a patch =
to
> >>>> extract a small bit of common code from net/sntp.c to avoid duplicat=
ion.
> >>>> The QEMU arm64 lwIP defconfig is updated to provide the sntp command=
 by
> >>>> default for convenience.
> >>>> I could not test the case when the NTP server IP is provided by DHCP=
=2E If
> >>>> someone has access right away to such a configuration and in case it
> >>>> does not work, please let me know.
> >>>>
> >>>>
> >>>> Jerome Forissier (3):
> >>>>   net: extract function net_sntp_set_rtc() from sntp_handler()
> >>>>   net: lwip: add sntp command
> >>>>   configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP
> >>>>
> >>>>  cmd/Kconfig                       |  13 +--
> >>>>  cmd/net-lwip.c                    |   5 ++
> >>>>  configs/qemu_arm64_lwip_defconfig |   1 +
> >>>>  include/net-common.h              |  13 +++
> >>>>  lib/lwip/Makefile                 |   1 +
> >>>>  lib/lwip/u-boot/arch/cc.h         |   4 +
> >>>>  lib/lwip/u-boot/lwipopts.h        |   4 +
> >>>>  net/lwip/Makefile                 |   1 +
> >>>>  net/lwip/sntp.c                   | 128 +++++++++++++++++++++++++++=
+++
> >>>>  net/net-common.c                  |  28 +++++++
> >>>>  net/sntp.c                        |  23 +-----
> >>>>  11 files changed, 195 insertions(+), 26 deletions(-)
> >>>>  create mode 100644 net/lwip/sntp.c
> >>>>
> >>>
> >>> Hi Jerome,
> >>>
> >>> Thanks for the continued work on lwIP!
> >>=20
> >> Sure. Thank you for testing and fixing bugs :)
> >> =20
> >>> For the series:
> >>> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> >>>
> >>> Note that if this is merged before my series we'll want to have a
> >>> followup that removes the sys_check_timeouts() after net_lwip_rx(udev,
> >>> netif), or if it is merged before my series I can send a v3 that does
> >>> it.
> >>=20
> >> Both series are in my patchwork queue, so I'll take care of that. Than=
ks
> >> for the heads up.
> >>=20
> >>> Do you have a list of lwIP features you're still working on? I'm going
> >>> to be moving the Gateworks venice boards to it as things look pretty
> >>> good. The only thing I saw that was missing was TFTPPUT which I don't
> >>> really care about.
> >>=20
> >> I don't have any thing left in my to-do list for lwIP at the moment. T=
here
> >> are several U-Boot features that are still not supported with NET_LWIP=
=2E As
> >> you said TFTP PUT but also IPv6, the bootp command, as well as ncsi, e=
thsw,
> >> and wol (those are found in cmd/Kconfig). Maybe other things, I don't =
know.
> >>=20
> >> BR,
> >
> >Getting data off from the U-Boot device under test is missing some
> >similar function today. It would be enough to re-implement tftpput but I
> >rather like the convenience of "wget" to do everything from host and
> >from U-Boot device.
> >
> >Before LwIP and missing tftpput I did use tftpput:
> >
> >1. Send data from memory address range read from some flash peripheral
> >
> >2. Send data from files on attached storage filesystem (repeat
> >intermediate step to read each file to memory address).
> >
> >The tftpput command is useful for (1) and is a problem for (2).
> >
> >Suggestion is an HTTP server command to respond with data from a memory
> >address range or device filesystem i.e.:
> >
> >httpd <[<address> <size>]|[<interface> [<dev[:part]>]> [filename]
> >
> >The command responds to HTTP GET requests until a simple timeout in
> >seconds (default 0 no timeout), probably as an environment variable.
> >There might also be an environment variable to limit the maximum number
> >of requests handled (default 0 for unlimited) so that you could use this
> >in a script as a kind of network operated trigger or automation.
> >
> >When first parameter is a valid memory address (default $loadaddr) then
> >second parameter (default $filesize) is the size. A size of 0 is valid
> >and does not read from the memory address also returns no data. Optional
> >third parameter unspecified or default responds to any GET request. If
> >third parameter is specified then only respond to GET request for that
> >filename with any leading pathname stripped from the parameter.
> >
> >This would allow to simply command `httpd` after some other memory read
> >operation which has set env variables for us, and optionally `httpd - -
> >"filename"` if we want to be selective about the GET request that will
> >read our data. For an HTTP request viewer specify `httpd - 0` or in a
> >script for example if you want to hold up script execution until a
> >certain number of valid network requests for "secret" resource but don't
> >care about the return data, something like `httpd - 0 "secret"` and the
> >appropriate environment variable to limit successful responses before ex=
it.
> >
> >If first parameter not a valid memory address, then we assume a similar
> >invocation as `ls`. When responding to a request if filename parameter
> >is then a valid directory respond with a directory listing, else serve
> >that file. File not found is 404 response but does not exit.
> >
> >This overloading of both memory address and device filesystem works if
> >there are not any devices that are named with address values. If that is
> >too much then split to `httpd` and `httpdmem` i.e. two commands.
> >
> >Overall with LwIP adding HTTP `wget` command we are able to simply start
> >a host HTTP server to get files from, and this is easy on most host
> >systems that have Python lang:
> >
> >$ python3 -m http.server 8080
> >
> >I hope this description is useful?
> >
> >- E Shattow
>=20
> Implementing a robust and safe HTTP server is not trivial.
>=20
> If you want to use http to transport a file out of U-Boot, you should imp=
lement a HTTP POST command.
>=20
> https://pypi.org/project/uploadserver/ allows you to easily spin up an HT=
TP server.
>=20
> I would favor focussing on reaching feature parity to eliminate the old n=
etwork stack before implementing new features.

I would second looking down the path of adding HTTP POST support first,
and then documenting spinning up a trivial http server to accept the
upload, rather than adding http server support.

--=20
Tom

--rv+1OzatnQ8Gr6PZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg+DucACgkQFHw5/5Y0
tyyqOQv4tVJqdjaBeGPZGb5qWlFJKGFL4bRa2Ljpw40IybJP29QYvu/w2w5Pj0/o
bvS/etBe8ai07j6ItJA3mhND8hmkrV5RQ4PWEqm9lDyWZHiphw0HJq807gw8JBeK
pevXUrXKJJVeskRmFU2lTN1UTStnJyKbwJUPif4do3akwCz1LTHDY1U8vlfI9pi8
0xUPN4AwY2N6+IRr8BNlGhKk8kgK9QofAbkXxiA8mSA1LIFbdmon55OPCVCzFynJ
maZ8N9VLkgAZUqGNWspxHfC2OmKw+13KsjrD5T5r5fkTVVjtQcxspfkX/jOhlCct
9j3OAbEAymOWkplKYazuFGnWIybdg1Oy4FOyeN8q7hK+H7Ipn/WxhsKSzrh5OnE3
/Xw8Hjt3QODCiz/sIgWwnSNLciyIBUfCKMaxkFMZ1kLJ75SHabLj2iL202SkZPNl
GReRMse9Gykqiso0S4u8KjElI9cnsbcIrZ4W0aBC21ZoB15aZAF1rbCVtBvYom6Y
J9Zc3/8=
=AdHi
-----END PGP SIGNATURE-----

--rv+1OzatnQ8Gr6PZ--
