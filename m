Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AD1C27C52
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 08:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 373CA8843A;
	Tue,  4 Jun 2024 10:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="jJ6YHGHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 260A388458; Tue,  4 Jun 2024 10:14:58 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB53588433
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 10:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [213.135.10.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id C61E0113B;
 Tue,  4 Jun 2024 10:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1717488894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=8W67pPGuc+oO1wWjgLCTieOepAZSYII53gp6MQPXDQM=;
 b=jJ6YHGHxIoklBFIKb8WdhLrcxLiXJ7W2a2VqAuwBf4/MRmlmu4fT/HaGOPPw9ZFcSOYHwD
 f8idlHX4FFgTRD5jnb1XrdQn6SmylqLkJX0mHKc58gb5GhMYXtiv+1hmJ3xjZG3raHrLPI
 b/GRGPCwdDdkaTAeiHmA8l5ZrzY4jOJPx3B1VFdK242ZpFPoi2tlNx0nuDV3ZBiXVpj4sB
 3uXgReUBwdLSLexDEwgv402OFvHQgAziItkMuMQQJXjV4odzLcl6BLJjShlktUszmsahKZ
 taqtEZPdOzTkBGSHNuFBD6cx/gsPTNJtjG2BFTWQ0e47V8PIPkrL5jWRSgqfgQ==
Content-Type: multipart/signed;
 boundary=b0fc8532539659fed34754b74f65f6b7589310b80cb3b6b7ccc2d7f374f4;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 04 Jun 2024 10:14:42 +0200
Message-Id: <D1R2ZW5Q12QQ.OU52AZIYS68O@walle.cc>
Subject: Re: obscure microsd detection issue between U-Boot and kernel
Cc: "u-boot" <u-boot@lists.denx.de>, "Peng Fan" <peng.fan@nxp.com>, "Jaehoon
 Chung" <jh80.chung@samsung.com>, "Linux MMC List"
 <linux-mmc@vger.kernel.org>, "Ulf Hansson" <ulf.hansson@linaro.org>
From: "Michael Walle" <michael@walle.cc>
To: "Christian Loehle" <christian.loehle@arm.com>, "Tim Harvey"
 <tharvey@gateworks.com>
X-Mailer: aerc 0.16.0
References: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
 <e0f38bc9-bcc2-4476-a5d4-4f2efaebc0c1@arm.com>
 <CAJ+vNU0jiVb4caYeQ5HYKZ-dqxcdG1K5pPisJZpfL4q7Sc3zvA@mail.gmail.com>
 <50bfdbf9-2ab0-4111-bf2e-abe4c9ed86fb@arm.com>
In-Reply-To: <50bfdbf9-2ab0-4111-bf2e-abe4c9ed86fb@arm.com>
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

--b0fc8532539659fed34754b74f65f6b7589310b80cb3b6b7ccc2d7f374f4
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jun 4, 2024 at 9:47 AM CEST, Christian Loehle wrote:
> On 6/3/24 22:28, Tim Harvey wrote:
> > On Mon, Jun 3, 2024 at 1:18=E2=80=AFAM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 5/31/24 21:47, Tim Harvey wrote:
> >>> Greetings,
> >>>
> >>> I'm seeing an issue on an imx8mm board (imx8mm-venice-gw73xx) where
> >>> for a specific set of microsd cards if I have accessed the microsd in
> >>> U-Boot with UHS/1.8V the kernel will not recognize that microsd when
> >>> scanning.
> >>>
> >>> The issue does not occur with all microsd cards but seems to appear
> >>> with a large sample size of a specific card/model (Kingston SDC32 32G=
B
> >>> SDR104 card). I do not see a signal integrity issue on the scope.
> >>>
> >>> Instrumenting the kernel the issue is that the host reports a CRC
> >>> error as soon as the first mmc_send_if_cond call which occurs in
> >>> mmc_rescan_try_freq.
> >>>
> >>> I can avoid the issue by either not accessing the microsd in U-Boot o=
r
> >>> by disabling UHS/1.8V mode in U-Boot therefore what I think is
> >>> happening is that U-Boot leaves the card in UHS/1.8V signalling mode
> >>> and when the kernel scans it sets the voltage back to 3.3V
> >>> standard/default and default timings then issues its clock cycles to
> >>> 'reset' the card and the card does not recognize the reset. I'm
> >>> wondering if this is because the reset is done via clock cycles after
> >>> the kernel has set the I/O voltage back to 3.3V when perhaps the card
> >>> is still in 1.8V mode (although I don't see how that would cause an
> >>> issue)?
> >>
> >> It will cause an issue for many cards and might break some cards.
> >>
> >>>
> >>> Is there some sort of MMC 'reset' I can/should do in U-Boot before
> >>> booting the kernel? Has anyone encountered anything like this before?
> >>
> >> There is no 'switching back' to 3.3V signalling from UHS 1.8V.
> >> The only way this can be done is therefore a full power-off.
> >> Is that done correctly for your system?
> >> AFAIR spec dictates 500ms of <0.5V on VCC. Note that  driving CLK/sign=
al
> >> lines can also sustain the card somewhat, as leakage is only limited
> >> within operating voltage.
> >=20
> > Hi Christian,
> >=20
> > Are you saying the only way to properly reset from 1.8V is to have a
> > VDD supply on the microSD card that can be turned off before booting
> > to Linux? We have never had that before and never encountered
> > something like this.
>
> Yes, the only safe way to use UHS-I really anyway.

I can second that. And also keep in mind that the actual supply
voltage must be below that threshold. Thus, the power-off time also
depends on the capacitance on that supply line after the power load
switch. There are switches with dedicated output discharge circuits
built-in.

That being said, from my experience there are cards which will work
when switching back from 1V8 to 3V3 signalling and some don't. I
haven't digged deeper into that topic, though.

-michael

> You could disable UHS for u-boot but that still leaves (potentially)
> problematic warm-reboots of the board.
> Having a (software-controlled) switchable regulator on SD VCC is pretty
> common for this reason and you should be able to find it in most dts
> for host controllers with sd-uhs-* property.
> I'm afraid that the relevant spec section isn't available in the
> simplified version.
>
> Kind Regards,
> Christian


--b0fc8532539659fed34754b74f65f6b7589310b80cb3b6b7ccc2d7f374f4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZl7M8hEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+E2kAX9643rEFafhN3Byt2vnBYKK5gv+nLAwAup7
Lozt0Z/QxjG0X00s3/+k39VIkpN5Ys4BgOhn6O11fwB/7BZ7pLOLyDOvR6eZkX/E
np9FslAwncUReepBwreSl7NuzYlMdOAhwQ==
=zHMu
-----END PGP SIGNATURE-----

--b0fc8532539659fed34754b74f65f6b7589310b80cb3b6b7ccc2d7f374f4--
