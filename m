Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD497C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 19:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1056688BD1;
	Wed,  7 Aug 2024 21:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kz0E8m0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 422D488BC6; Wed,  7 Aug 2024 21:08:21 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A06188D17
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 21:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5d5eec95a74so120806eaf.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723057697; x=1723662497; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=md6P15qIOGd4UWhEgwZr3A443HX9G3o2OmsU+vXAC/k=;
 b=kz0E8m0kPIY4hmkvc7XPKCHDz+wzp1/iK6Dq5sW/xf8HZ0/AaPDw5WaFB0kZjRbgm+
 B84EuqVo5zbV8nK+k5Lj88sgC7wYZMJlAy42yk/DAnyJsmXyThOsN0ZswO0cAPhLPMMC
 ayQHqC5Me4QSzFz2HFlHOTlxF9S1Q+DJ29+30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723057697; x=1723662497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=md6P15qIOGd4UWhEgwZr3A443HX9G3o2OmsU+vXAC/k=;
 b=lH/Gv27yZxFwDQ9YpYbB1WSsuruxPUlL93dl5u3qnJUbKyZUv8XHA6OiPBTwN7mTi/
 ohQ6na4xKkIyWPsy0olJlo97SBADeZYOBuQm4aDnhHpySpFGuVTW/aM1CPOI1HlXLfx2
 WF6zjUz2tSzsCGJdoRS9T3kL2Wm2w3DQO3OVRXFaGtBBvb+Cfg9OoKGZxpfxgQM7+B8C
 +u3tXsrTDrSkeCEI3qNfh2pH1n1Z1CmzmUhYpgNSP6cWlFefOF+6zS7UVVx6Sg80xe8/
 OUNmU/wraXqwwCJmg+qLYYqM4sqFXMi1yFVAXbutm3WDW0YI380Px7yXf7y4r8bdU1jA
 xmkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWWh9FTNSrrXaicRyZdVW2g3ZgIclICgor9aWUcGX0YLC59JWhRGAQ6TGl7LbhKdqaou+5Fpk=@lists.denx.de
X-Gm-Message-State: AOJu0YzQPW7ZqXh0AEs/Ce+p2IXv6zRNTFzfQqNLjfQfGVj1qf25aVcb
 bkMUQvyzHTjN6RF1XnjG3WAPNBC0rJJWZx3dzzOvnwKvMSiiElV3jY4c9LEacPw=
X-Google-Smtp-Source: AGHT+IFtDxgr/gsw3dFGAHYf4q7ldB1GFk31H3r5duMijeYeVbIdWsxYas9bmgz+rVl/3AFGplnAqg==
X-Received: by 2002:a05:6820:2228:b0:5c4:7b18:b8eb with SMTP id
 006d021491bc7-5d6553365f8mr23312988eaf.2.1723057697123; 
 Wed, 07 Aug 2024 12:08:17 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d7625e9b97sm3349566eaf.34.2024.08.07.12.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 12:08:16 -0700 (PDT)
Date: Wed, 7 Aug 2024 13:08:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
Message-ID: <20240807190813.GI1626301@bill-the-cat>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <CAOf5uwkiTwsAPducOJxEBUHKYiT0+q_dH_ZCOdCd7e4b45DS0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7xtk92msdstn6wNO"
Content-Disposition: inline
In-Reply-To: <CAOf5uwkiTwsAPducOJxEBUHKYiT0+q_dH_ZCOdCd7e4b45DS0A@mail.gmail.com>
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


--7xtk92msdstn6wNO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 08:54:08PM +0200, Michael Nazzareno Trimarchi wrote:
> Hi Jerome
>=20
> On Thu, Jul 25, 2024 at 2:58=E2=80=AFPM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> > library for the network stack" [1]. The goal is to introduce the lwIP T=
CP/IP
> > stack [2] [3] as an alternative to the current implementation in net/,
> > selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> > reasons for doing so are:
> > - Make the support of HTTPS in the wget command easier. Javier T. and
> > Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> > so. With that it becomes possible to fetch and launch a distro installer
> > such as Debian etc. using a secure, authenticated connection directly
> > from the U-Boot shell. Several use cases:
> >   * Authentication: prevent MITM attack (third party replacing the
> > binary with a different one)
> >   * Confidentiality: prevent third parties from grabbing a copy of the
> > image as it is being downloaded
> >   * Allow connection to servers that do not support plain HTTP anymore
> > (this is becoming more and more common on the Internet these days)
> > - Possibly benefit from additional features implemented in lwIP
> > - Less code to maintain in U-Boot
> >
> > Prior to applying this series, the lwIP stack needs to be added as a
> > Git subtree with the following command:
> >
> >  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savanna=
h.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> >
> > Notes:
> >
> > 1. A number of features are currently incompatible with NET_LWIP: SANDB=
OX,
> > DFU_TFTP, FASTBOOT, SPL_NET. All make assumptions on how the network
> > stack is implemented and/or pull sybols that are not trivially exported
> > from lwIP. Some interface rework may be needed.
> >
> > 2. Due to the above and in order to provide some level of testing, a ne=
w QEMU
> > configuration is introduced (qemu_arm64_lwip_defconfig) which is the sa=
me
> > as qemu_arm64_defconfig but with NET_LWIP and CMD_*_LWIP enabled.
> > Tests are added to test/py/tests/test_net.py for that configuration.
> >
> > 3. The default QEMU networking doesn't work with NET_LWIP. wget
> > pauses and resets the connection. Wireshark shows [TCP Window Full] and
> > [TCP ZeroWindow]. Wen using an emulated e1000 however all is fine
> > (that is "-nic tap,model=3De1000" on the QEMU command line, with a brid=
ge
> > configured on the host).
> >
> > Changes in v5:
> >
> > - Rebased on next
> > - Refactor Kconfig options to avoid duplicates
> > - Library functions use a more consistent naming (dhcp_loop(),
> > ping_loop() etc.) and take a struct udevice * parameter (Heinrich S.)
> > - Do not use net_process_receive_packet() for input anymore. Instead of
> > calling eth_rx() which would invoke net_process_receive_packet(), we
> > call a new net_lwip_rx(udev) function which invokes the device recv()
> > and pushes the packets up the lwIP stack. Thus everything is tied to
> > a udevice now. (Heinrich S.)
> > - Add "configs: replace '# CONFIG_NET is not set' with CONFIG_NO_NET=3D=
y"
> > (Tom R.)
>=20
> Here I have some questions. You can have CONFIG_NET with two alternatives=
 and
> the alternatives are exclusive. Why do we need a CONFIG_NO_NET definition?

For the platforms that today don't enable networking at all (of which
there are a small but reasonable number). Since it's a "choice"
statement we need a "none of the above" option.

--=20
Tom

--7xtk92msdstn6wNO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmazxhoACgkQFHw5/5Y0
tywjPwv+Nx8RkL5BdV7B0qczJjNnhy8Z3XnXsDsUOyzr+jbI2aUsbNys1ncy9P2f
nkROeSDYOVMDOxZIPiG3MPhykFroiIiS9PaoJfVkR0iPm5Mk70FMQsY/kvI/GMwT
1TIEp6vZzn/M2U1tcFlEOU6R314CQmpAo3bxk15k6p7ObyWv3P/SmNaWwXOS2NBb
037Yt2Hc5DvZRBPw427imXCVP+qkOS/31s/3Tl5zKtDnA31ifo9UBTFke4XKO6/6
RqKOm0MhkcbXWsNLtCjclR3kMrUC9qh8QLZ/FEfi7n+3+Tb9E9+9DQYyUkn/h3Rt
r7WXrtg7vkotFrQzvYkPJvfWR2dqwYcCHx+XobWi5uOn0hyk0bM7JENBGO0VWJ5t
3xfFuJXYJDGoeBWaP5gHra3TDaJeqlCM7a+YfHs5klwD2Jq64qlARbZEQq0LKV/8
337Qj0sPDzKK0jMfpLOhjgrhuCgqEjhvRZrz598ztnn/Swb5Xmft5oKVCiTn9HUx
caDyRQEt
=lOPW
-----END PGP SIGNATURE-----

--7xtk92msdstn6wNO--
