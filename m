Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BF8C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 18:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B6E82E35;
	Mon, 26 May 2025 20:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F6KbzEYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9929C82F14; Mon, 26 May 2025 20:37:26 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1047282E34
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 20:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-601a8b6c133so1443357eaf.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748284643; x=1748889443; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u4dgSZPMQoEAK0RID/JNiIN7wdDulgoawSFWtmFsRnM=;
 b=F6KbzEYDKkZLhLo4Q3lMmgjCaeyaYCZhneNheisynpXLFBIS5HwQMerCCl202SExYu
 CPkR5Bg7wYCRS5r0DZE516XmgCbxCq7qeF9KN3KdJCjFr+56bCf3UWDUvDQf8V6wAZKT
 c3wBSuDQwelXvEjEvjvHe44u1O8FuaickCmH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748284643; x=1748889443;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4dgSZPMQoEAK0RID/JNiIN7wdDulgoawSFWtmFsRnM=;
 b=p2YnMtXQ5/6W8p1am/dsTNcIrsx9x88++VSe619uC+1zsia891OfS79/T2CRs6/A9V
 ENSsRZxqxpL98xn1rR0WJtIkJTJ8k0H4Ajypql+RVaIRIwFWPS+/LBdgb3aMNWb4san2
 Hka22BOub1LNd4NlhvddXAd2X13fIMJwNrF/gXwxwqzqwQ33Rk5hGyXH3I0BTQBJIDSk
 h8sWJ2b8EvvL7zg/YD0gvSgtMRjnV9LK42edGz6m4nxgU92aAFrUQRLaByl8ooStNzzD
 1x4hHA4CScOapN2ivmlrdKn/zBS2+s2DIbHL8C8Jag+4KaImzn5zB7hlZZvxFqG7xDfx
 Tlqw==
X-Gm-Message-State: AOJu0Yyrd1a+DLnKDM32qggSduxSBfCLfCWziT2KMV4TcV/xx/JHT1Ao
 DvobU7CWO3xQBMJxQ9metVkAeloh49YgRp2tAluoMkssz8/C2Eg1xd2Bv2xOUj4xV3s=
X-Gm-Gg: ASbGncvVc2EJBsiYGEBgd+hLs+/lQq5NNTJBM/MRM1/DdRJC799hZeZSSwwSpNgDfg5
 6lL2JqQQFJh7DgU4feATPhP2zGiM+7bO7WfvoKbehZ6S+ZJOlvF5jvDkfK+JZq/xvHRTbCp6+rf
 /fgfke+hCHGIrsftAzHilFQP0oq6TK33aKawBOIARB4jN638scswBHazlm51Qdjpj/S+DjIm5l5
 XrzPtjtBc+BAu4iGQxlQO2W3vbxZ/xuZqQOmkegfb7M0uoqTL8Id4gF+npswCdy3t4RE6V/fsh2
 RoJPa+Pn3J/pGsGlw3MRsTr3sBMpWUf7gHd3VhgfADmxgLGmTX5bIQYw8z5QviPHyH/2/ZOtlkh
 G1w9zPMbO4DkC
X-Google-Smtp-Source: AGHT+IGY2BW9o+1uLYhFR3iinZKWV1lFtxy2iQeg/m1imvyR4IDvR55KqTp6YxH7Qw3yunTnxddzgg==
X-Received: by 2002:a05:6871:d68c:b0:2d6:8eb:8918 with SMTP id
 586e51a60fabf-2e83e2a76admr7948832fac.7.1748284642668; 
 Mon, 26 May 2025 11:37:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c06b0b3csm4923468fac.14.2025.05.26.11.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 11:37:21 -0700 (PDT)
Date: Mon, 26 May 2025 12:37:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
Message-ID: <20250526183719.GC100073@bill-the-cat>
References: <20250523130651.1329593-1-sjg@chromium.org>
 <3b23fc9d-345f-4945-b89d-153a18f5828d@gmx.de>
 <CAFLszTjofbRtjXxfR6MmnHP0hYcpg+pgLKLYDXN2KxLZ2rNPHQ@mail.gmail.com>
 <20250523164909.GV100073@bill-the-cat>
 <CAFLszTiVv9Qe5y2Mt7LFZ0i=3G=4u+0ZAVjs3hc6G219BCzBsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QuUWN/jLPUZxSGa8"
Content-Disposition: inline
In-Reply-To: <CAFLszTiVv9Qe5y2Mt7LFZ0i=3G=4u+0ZAVjs3hc6G219BCzBsg@mail.gmail.com>
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


--QuUWN/jLPUZxSGa8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 09:36:03AM +0100, Simon Glass wrote:
> -trimming cc
>=20
> Hi Tom,
>=20
> On Fri, 23 May 2025 at 17:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 23, 2025 at 05:36:52PM +0100, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Fri, May 23, 2025, 15:19 Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
> > > >
> > > > On 23.05.25 15:06, Simon Glass wrote:
> > > > > Some functions provided in lib/efi_loader are actually useful for=
 the
> > > > > app as well. This series refactors the Kconfig and directories a =
little
> > > > > so that code is easier to share.
> > > > >
> > > > > As a starting point, it moves some filename and device-path funct=
ions to
> > > > > the new directory.
> > > > >
> > > > > The next step would be to move device-path code over, but this wi=
ll need
> > > > > some discussion.
> > > >
> > > > Hello Simon,
> > > >
> > > > Overall the ideas in this series look fine to me. But this series d=
oes
> > > > not apply to origin/next.
> > > >
> > > > Applying: efi_loader: Separate device path into its own header
> > > > Patch failed at 0001 efi_loader: Separate device path into its own =
header
> > > > error: patch failed: cmd/efidebug.c:8
> > > > error: cmd/efidebug.c: patch does not apply
> > > > error: patch failed: include/efi_loader.h:967
> > > > error: include/efi_loader.h: patch does not apply
> > > > error: patch failed: lib/efi_loader/efi_bootmgr.c:12
> > > > error: lib/efi_loader/efi_bootmgr.c: patch does not apply
> > > > error: patch failed: lib/efi_loader/efi_device_path.c:10
> > > > error: lib/efi_loader/efi_device_path.c: patch does not apply
> > > > error: patch failed: lib/efi_loader/efi_helper.c:6
> > > > error: lib/efi_loader/efi_helper.c: patch does not apply
> > > >
> > > > Please, resend the series based on origin/next.
> > > >
> > > > Patches that are not based on upstream U-Boot cannot be reviewed via
> > > > this mailing list.
> > >
> > > The app is quite behind in Tom's tree due to rejected series.
> >
> > It was not "Rejected", it was "Changes Requested", please stop
> > mis-representing things.
>=20
> That seems like a distinction without a difference. For example, [1]
> is marked as 'changes requested' but the abuf comment on patch 1 looks
> like a rejection to me.

In [1] the requested change is to stop adding abuf everywhere and use
the normal malloc/free pattern that is most familiar to everyone. The
concept is fine. For the EFI app series, again, I don't know if you're
acting in good faith or not, it feels like you aren't.

> > > In fact
> > > the app is pretty limited on x86 and there is no Arm app at all.
> > >
> > > My current plan is to move forward and eventually Tom might take it
> > > via a pull request.
> > >
> > > Do you have any other ideas?
> > >
> > > Perhaps this is something we could put on the agenda for a future cal=
l.
> >
> > There's nothing to discuss in a future call as step one is "post patches
> > against mainline".
>=20
> Well, you keep bringing it up, so it seems that you are unhappy with
> it. An alternative to talking about it, if you prefer, is to accept
> the status quo. But either way, it doesn't seem helpful to mention the
> same issue on so many threads.

I keep bringing up that you keep misbehaving. Maybe you should leave the
project if you can't follow the rules everyone else does and people have
asked you to stop doing.

And this is why I don't want to have more calls with you. We had a call
where my understanding was that you would only put stuff in your tree
that had been rejected but you felt was unfairly rejected. And that you
wouldn't build on top of that because it would be a nightmare. And
instead what we have is you've built a heavily divergent downstream tree
and want to act like it should get the same community feedback and time
that mainline has. Multiple people now have told you they do not want to
spend time on your tree. If you want to just do what you want, just fork
and rename your project to something else. Hand the domain over to DENX
(as they oversee the rest of our resources). But if you want to stay in
the community you have to accept that some concepts will be rejected and
others need to be reworked a lot. Because at the end of the day, the
project needs to work well on the ~1400 different boards it supports,
and it needs to be stable while we make changes, slowly.

[snip]
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D454989

--=20
Tom

--QuUWN/jLPUZxSGa8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg0tN8ACgkQFHw5/5Y0
tyygkQwAiCNkDGL7DDLYv50rGD7DQReEyC/GfOK7zKFmdWg7os3L/9h/UT+a18cI
oUdb+taht5GHzCegbn+Vj27MxTMVM5TW82cYSVH142O6p2jReWBhoKby3gnC8lCC
QJeWkDhMhdF4NKCReYURu/+ofCh9k6x4WRe5Kwh4f8c1KtOIajvlmSZy/eHO4dJS
Rfo7qoX7cR6m92hrTvGDPqXLDb3J2gtMRWpz9yXb6WgGgunIYBLcRELtw7oDGb7X
K2jbOcF0viO9LvmGlnEHdQ5AL3zddDFrxgVV18t3JmYnxuLU5db02umAuhN8axzr
yE7y8pXC+6DTzwzZx9n47PnB3o3ikNrz+UkGneG6SiO3dJ66EPcJzMhfnQiS8WaF
Od1gd1pgaj9+jmvdp1p6mlFpJ6c4lfJtATkYg/sgf9On7V9NnPd9qzLLvyWOtlMt
4cSxATCjkgfPkUWmdieTLhJkxNaxA1Nd54LU8/fgeXrplU+hXZ8mi0ZjgJZvRYzw
AcG1uqLt
=jzxi
-----END PGP SIGNATURE-----

--QuUWN/jLPUZxSGa8--
