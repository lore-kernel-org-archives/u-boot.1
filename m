Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52747C71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 22:46:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1DAC82BCD;
	Wed, 18 Jun 2025 00:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hdc4lqLR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C382782C2F; Wed, 18 Jun 2025 00:45:58 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C39382B20
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 00:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-40aa391ce1aso73761b6e.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750200355; x=1750805155; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SKEdMsMZ+mWimu4Ooyczq1ujTMrtC6oQP0jfUMWrPns=;
 b=hdc4lqLRMk4ocOkbEixA+51mUOQmA7l4lT3szi43P4hLPojIPUhA8H4tLkor/7Wk6B
 WS6Q1AUJdU/WuqHBVRGviL0DbSsTqyqXHhAmNeWW4tvbGjMyeh6Y09qfujk5gk27SjhS
 X+fZ8U4DxCYeK4B/ahsIkaua4ZfawPHhbAmcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750200355; x=1750805155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKEdMsMZ+mWimu4Ooyczq1ujTMrtC6oQP0jfUMWrPns=;
 b=hTeaJ9y1O9SIw0lGDc0sdaTrxcvrVEMwYiv8JPOXnnVt0jImwxuiyUyuN7MlJS7zZZ
 c75SqZHetOhLWfFShVWULbUnvxb74IM0v0nbJn+ECSv5/9dD97LRcSYQ/OJ/hTU1O0Q3
 +WEV3OKp83NIIPUiXqdPGjoGttxtSnvuG4/D62eCCGHeP4g8NinoG68sA052Dl4myS/I
 eZNmUvLJ/fgRZX7h53NCBWOqCIlnsm3YccEhVbie8qKUqRvuYTTYCoJdL3bjisKkYEBb
 ILAnNOKteGVyMblgLb5wSAMKXI8hLUEuBdI3z2m3RF80LKF5mgTCMTDBC7L1aeTGuLIM
 CFwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4Jx9EBzy0cBX3cDfZhizJM82edHOog8l0+o394owtHOe7u4zjjpwwI00Om8FXTlPKf/yu9mQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxfD8ZGoTya/DsOWeuU2MReJDoMBI+MYFBR7KJLzgCYgvJMNEUJ
 n+aESHeYiHQfgWWnJa6dxylskSupCB8vNdwxvPfYZGTS2msyKCnps884EaZcI0ew9c4=
X-Gm-Gg: ASbGnct0+BgjwSdsPu7CRwbCYRXxSza6IwPmaqTZtmKUaVNzNbnsDhk/8iZ0Lfhdrth
 /1ZS3kGIWdae62w6VqOR4FEL8+o3uWAzfvIV4d8QcfVmfsQ2K39Px/2RBaXOQ4wa4KH7e1uR8b7
 T8HRheP2fA2Ngw7Xdwfr9g64i7aP7xzY2oYDDqC9j1YGJN6HISB7GUqJKBMSTot3DrWB3gaWFB+
 7Gx+JwaiQXv5AkYCCzCZHxkV3aGw3R3+rdfLMxGgxgyeRd0T6qt+PFAzaorXNfeQuM+lq7O7Mzm
 PHDdxkNv0Z/IXNnxtneROv5Cw98gBKZciPOZBxlFFvO/R5A+wdoK35EURMgqJKBcV/M9q9j717X
 vqadJMfAQ1VWjQd+6D/kTwnk=
X-Google-Smtp-Source: AGHT+IEJwOPdKeI7g3P8FLkN+tEs3vcaIHpX12qvmj/vY3vqMJ8f1WwKJ70oZEFQtjBWWFYpmltG9g==
X-Received: by 2002:a05:6808:1b1f:b0:408:e711:9aa with SMTP id
 5614622812f47-40a7c282804mr10877109b6e.37.1750200354824; 
 Tue, 17 Jun 2025 15:45:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a7418a394sm2120837b6e.36.2025.06.17.15.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 15:45:53 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:45:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tim Harvey <tharvey@gateworks.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 1/5] net: lwip: call sys_check_timeouts and schedule
 on rx
Message-ID: <20250617224551.GA1687135@bill-the-cat>
References: <20250530153826.1057407-1-tharvey@gateworks.com>
 <f19b630b-4a01-4e6f-b419-d2995b45198c@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RTauFANx8F3B56+h"
Content-Disposition: inline
In-Reply-To: <f19b630b-4a01-4e6f-b419-d2995b45198c@canonical.com>
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


--RTauFANx8F3B56+h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 01, 2025 at 11:07:16PM +0200, Heinrich Schuchardt wrote:
> On 5/30/25 17:38, Tim Harvey wrote:
> > Call schedule() in net_lwip_rx() to service U-Boot tasks and
> > actions during packet rx.
> >=20
> > As a cleanup also move sys_check_timeouts() here and remove it from the
> > functions that call net_lwip_rx().
> >=20
> > This resolves the issue of an active watchdog resetting the board on
> > long network activities.
> >=20
> > Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> > v2:
> >   - remove duplication of sys_check_timeouts() from functions that call
> >     net_lwip_rx()
> > ---
> >   net/lwip/dhcp.c     | 1 -
> >   net/lwip/dns.c      | 1 -
> >   net/lwip/net-lwip.c | 7 +++++++
> >   net/lwip/ping.c     | 1 -
> >   net/lwip/tftp.c     | 1 -
> >   net/lwip/wget.c     | 1 -
> >   6 files changed, 7 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> > index 92bd7067a7fb..b79b746db390 100644
> > --- a/net/lwip/dhcp.c
> > +++ b/net/lwip/dhcp.c
> > @@ -57,7 +57,6 @@ static int dhcp_loop(struct udevice *udev)
> >   	/* Wait for DHCP to complete */
> >   	do {
> >   		net_lwip_rx(udev, netif);
> > -		sys_check_timeouts();
> >   		bound =3D dhcp_supplied_address(netif);
> >   		if (bound)
> >   			break;
> > diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> > index 19172ac959ac..738f8bf3196b 100644
> > --- a/net/lwip/dns.c
> > +++ b/net/lwip/dns.c
> > @@ -91,7 +91,6 @@ static int dns_loop(struct udevice *udev, const char =
*name, const char *var)
> >   			net_lwip_rx(udev, netif);
> >   			if (dns_cb_arg.done)
> >   				break;
> > -			sys_check_timeouts();
> >   			if (ctrlc()) {
> >   				printf("\nAbort\n");
> >   				break;
> > diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> > index f05c4cd3f64f..e8d4cc542ed8 100644
> > --- a/net/lwip/net-lwip.c
> > +++ b/net/lwip/net-lwip.c
> > @@ -13,8 +13,10 @@
> >   #include <lwip/etharp.h>
> >   #include <lwip/init.h>
> >   #include <lwip/prot/etharp.h>
> > +#include <lwip/timeouts.h>
> >   #include <net.h>
> >   #include <timer.h>
> > +#include <u-boot/schedule.h>
> >   /* xx:xx:xx:xx:xx:xx\0 */
> >   #define MAC_ADDR_STRLEN 18
> > @@ -284,6 +286,11 @@ int net_lwip_rx(struct udevice *udev, struct netif=
 *netif)
> >   	int len;
> >   	int i;
> > +	/* lwIP timers */
> > +	sys_check_timeouts();
> > +	/* Other tasks and actions */
> > +	schedule(
>=20
> Some scheduled tasks have a long duration, specifically video_sync_all()
> called via video_idle(). This change will lead to lost packages.
>=20
>=20
> @Tom, Simon
>=20
> The EFI code was impacted by 29caf9305b6f ("cyclic: Use schedule() instead
> of WATCHDOG_RESET()"). This added schedule() calls to EFI networking.
> Package losses can expected if schedule() takes more than 1 =B5s. This is=
 much
> shorter than the time needed for synchronizing a 1 MiB frame buffer. The
> cyclic framework was explicitly meant for short duration function calls, =
not
> for long duration tasks like syncing the video frame buffer.
>=20
>=20
> I think we should remove video_idle() from the cyclic framework.
> video_sync_all() should only be triggered if there is video output.

So for testing purposes, if CYCLIC is disabled but LWIP is enabled,
things are fine here? And so we need to at least partially revert commit
5c8dddadf1c9 ("video: Use cyclic to handle video sync") if not fully
revert it?

--=20
Tom

--RTauFANx8F3B56+h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhR8B8ACgkQFHw5/5Y0
tyzbJQv/UUEiFnDsKhu+Xh2PBigWldzhAstts6yOfUdsCk9YTBIuK87DSEtF0ay9
9qnmpYggggvt4EqQiF3kbqpFLLizNY6Crz1wQDL2OBMaQsu0Jpb51a/2NaJHSLng
G1PDM70bYrYTSsFF1qyulY9tDtY+8bKaKSiWSaZJj3qxCSrf9uIkvTr3kxPdPD2R
0s849b0gugiSV78ClxoVG3SkcWdWYVQZSKRhfa+baZdElV4468Cyh5aSSfzSjCZY
o+OsD006uAM6PwgMij91ANMschh3XwnGtB/BNajaDwsxvc52ZacQJQUUJxc3hWaW
ex3U9fxxYUfdmm2fRqih0a9y2yIp1z+FvHH4FJEtPoO0UPKJFXx95XpxB8dpufTf
GjWKd6Xl5JcLzvcZH0ro0Y1RSFe8YVexnQhgocXptZs7E7+I8dIIbHvvx8SuTkri
ZQcmfCerweUISsEso+tanchY7lOO0jceUZF6OQGjW46ulU3Tfx2XeWWs+vqpmCT3
dIJmON0U
=gtvp
-----END PGP SIGNATURE-----

--RTauFANx8F3B56+h--
