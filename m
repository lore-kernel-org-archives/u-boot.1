Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B3CD3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2BB089096;
	Fri, 18 Oct 2024 01:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n92PViwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B3E189099; Fri, 18 Oct 2024 01:35:06 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 563FD8908F
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-46040dadedfso12888921cf.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729208103; x=1729812903; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AoF1JGw5WWnazpsybpR/e4njbMyo7Qr+f613cvdBx10=;
 b=n92PViwMWSzS//5QhTbRXCsdS/1/h8l6PyPCgu8fmMtPmyMrI+BBFdRIOTHSagXjgQ
 8KgJ2sgO1WRMDr6Vx7iWRRooKRDVdHz/tdTe/ck3uPXLlk/rzHhoaosst76IhPToDwnM
 EmdnZNzxNzSIsByTCWpmeavQgEwAauD88YzcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729208103; x=1729812903;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AoF1JGw5WWnazpsybpR/e4njbMyo7Qr+f613cvdBx10=;
 b=BCutYTxv0nCj+6qBjFUJx+t3Xs9/bfm7k/+kavLLmZjTw6VhMyUwpDNQYFiBo6SPrs
 w1CfjSZuSQNvhMlxP1urXpuggr3hfrKuK2ygMCcOpxJrAxxCBUdCqPeayHGrfn/vfxIf
 SoGwgqZnwVXBK9IW99wFSfwB5BdBpxbz83Nz14AWV/VheTUILnjIzFKJFCVmHWAG1JGZ
 K8Qg6gwHIBybnTK3MO8DQNhEvwQDIVW/V9DsYYQhSxkb306X/pH2cd+qDtXxDc2JwZl3
 E5xqqjna+3/naDaR3GePIITyJHyY6TwdDPEx0u0BaM/yziQEcRob54EsIg1SoSJ5dusc
 hz4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Bhqy6Jwig9i3l1In5kTxlxlEcLXdBD59d2q6B4UeWqfitonPe5hMqyJ0QeOUABp58ZeU6Is=@lists.denx.de
X-Gm-Message-State: AOJu0Yycby2GmTUTVgwS0XqqABsTdP+5trPloz9afP00L50mFrFWR1o4
 7Ba7wyd4jep2yEz2QuaJPqiXdXd+EFo6gvpjGK36rRBeoOPbTma4jldX+0el7YU=
X-Google-Smtp-Source: AGHT+IF0/rUrQaQ69AZSMc51ccotlo46HY86Jyc4xQ5HxS8XWPGJcXCAw4NQE4IfxHKkLKCdF2cmJQ==
X-Received: by 2002:a05:622a:1455:b0:460:a82a:39a8 with SMTP id
 d75a77b69052e-460aecfb579mr9077161cf.13.1729208103075; 
 Thu, 17 Oct 2024 16:35:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460ae96e6dcsm1595081cf.36.2024.10.17.16.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:35:02 -0700 (PDT)
Date: Thu, 17 Oct 2024 17:34:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Artur Rojek <artur@conclusive.pl>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v4 0/5] Adjust initial EFI memory-allocation to be in the
 U-Boot region
Message-ID: <20241017233458.GQ4959@bill-the-cat>
References: <20241011212126.747741-1-sjg@chromium.org>
 <CAC_iWjKD=05pf=gcfCPUA0mGNbAX+jjyx5D03y0MWJRgxYDPOA@mail.gmail.com>
 <CAFLszTgJW2KPbD1dogSVKbxgyYtvKGgSAcB_j5kXtWdkTGvtNA@mail.gmail.com>
 <CAC_iWjJdoFLAyaa+NBoY1Hm0Q140ExU0rq-RKEqDV_yki9jojA@mail.gmail.com>
 <CAFLszThSFuAPnsOTw_4w6raWJzOojp16ULT88s9JgwoWcpMwJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VyFyVh/mD8mjN0bd"
Content-Disposition: inline
In-Reply-To: <CAFLszThSFuAPnsOTw_4w6raWJzOojp16ULT88s9JgwoWcpMwJQ@mail.gmail.com>
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


--VyFyVh/mD8mjN0bd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 05:22:52PM -0600, Simon Glass wrote:
> Hi Ilias,
>=20
> On Tue, 15 Oct 2024 at 07:32, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Tue, 15 Oct 2024 at 16:26, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Mon, 14 Oct 2024 at 22:28, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Sat, 12 Oct 2024 at 00:23, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > U-Boot relocates itself to the top of memory and is supposed to a=
void
> > > > > using any memory below that region. This allows the maximum amoun=
t of
> > > > > memory to be available for loading images.
> > > > >
> > > > > The lmb subsystem automatically protects U-Boot's code and data f=
rom
> > > > > being overwritten. It relies on this region being a contiguous ar=
ea of
> > > > > memory. This setup has worked well for at least 15 years and has =
been
> > > > > documented in the README for as long.
> > > > >
> > > > > The EFI_LOADER subsystem currently uses memory outside the U-Boot=
 region
> > > > > when starting up.
> > > > >
> > > > > Some of the downstream problems this causes are:
> > > > >
> > > > > 1. It can overwrite images that have been loaded
> > > >
> > > > So can the load command
> > >
> > > Can you point to where? If lmb is enabled, it should be using that, so
> > > not overwrite anything.
> > >
> >
> > If you load the initrd in memory X and make the kernel ovelap you will
> > overwrite parts of the initrd.
>=20
> But lmb stops that. It is actually what it is for.
>=20
> > Let's try once again, the ''''problem''' that was discussed in IRC, is
> > that the initramfs overwrites memory that was allocated by the EFI
> > subsystem *because* we haven't merged the LMB followup patches yet.
>=20
> OK, my problem was booting Ubuntu where the bootflow was unbound by
> exit-boot-services, resulting in freeing memory (and re-using it)
> which was still in use. I don't actually remember what was in that
> memory, though. This was over a year ago, when I sent my first version
> of the test[1]

This was on x86 as well, yes? I believe that's what you said on the call
and part of where people get confused I believe.

--=20
Tom

--VyFyVh/mD8mjN0bd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcRnx4ACgkQFHw5/5Y0
tyyuHQv/Wy915r3g0NH7HCRJzZrelb31NcVn+8q3Yrl1pMnmlXQ5VECSvaGYVS1x
XiYoqAkWks5iG12rlo07APehtCjnOVF2PEO2dWcwTeBqBkniGpn2tD0F/A7L+qNT
oE3y2K+ErVo/p/73kAnwXHAgtfnj8Hf2U7UXSsEfy5mJEVvD4Cmq7P/ekZt6kumH
xo20HzQvmZyY7pBHB6cRF1hUq52vcVXC8lpvC5xyElvoxY7xeScf45dWJ/BmHWnH
7TkQnAc9aEkpEQzgWLKUqoPJ1iIiQeusn96AvdaeXKseEqx30yKNiylKuvboKrU4
mFg/86IdC6xRxIRodKhDCIrLxnafacGLmpKrZEoMIk+j1zlzSUHbneegQRrAsdO2
oglfaoXu0pbiZHXYT92Q6V7CynaHXYaxQfOf1fHgHyKzcl84JzzN47cXmfSjxhPp
wTPdBQK/MNWYKMBGHuo6ALRfS8xGlEvkvBDFfBYpocLTxGcObuUWXglbIPPBW5IE
kqRdvC0B
=mqA/
-----END PGP SIGNATURE-----

--VyFyVh/mD8mjN0bd--
