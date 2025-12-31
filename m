Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C77EE57CE
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 01:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D662483FBC;
	Wed, 31 Dec 2025 02:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tojBVctj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA9983FD3; Wed, 31 Dec 2025 02:54:57 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A5E83F69
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 02:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7cdf7529bb2so2071406a34.2
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 17:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767146093; x=1767750893; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=THjYJYOUS0M8fu9ZJqSbbit6+zM4B848MBgZEdEXzzI=;
 b=tojBVctjBZ1f5tpQW3DZMj9OZgAylTbwzqZKQwFV4RbiTeamIQt7UK1Z4UdZsriQhV
 F6UysqTWw1e35hzhxTY7EXaA/ioCOWdt1mfAsdCbFLPsqEjsTD6UZ5/N4rAzlBVI+aFI
 lG395YXQIlEVO7JZO+F8gVKwS164lUHsVOkGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767146093; x=1767750893;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THjYJYOUS0M8fu9ZJqSbbit6+zM4B848MBgZEdEXzzI=;
 b=C+iHs8vs+OoP2A0u7bLJtxDbb5NBsYrSrDHcDQYmgT1355ukFv37NjaDPq4JN6XpWY
 4dPGFZPoMfGDtQtXYErf8UA7gn5U/TiM0cycDnyXFiw1H9iCPVmDebgpHozjnigMqM3c
 j93iT/wFMbYUxKts3nK6gLhldvauk3E+Ii95Scdce28BWXlJScqHbvo6gsRY81R828ta
 LJ/xMuV122HkShdQrgYG2j/C2v1UUdt9iOh7GS2KOCc8KdS7j+VxIwGiGuWZX1mlUIkR
 T1aolodbr7ctrZB4QgMgn9VFT2F9FZV1L/ZFAtATkmiZTVyjnHVy1L5rgT6SUM3KdTDT
 Cobg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzdVtP7PJc4fxNZza//dMkyind1bYhaHtHQVZX2ooX3EZrKRpg2ysva9RJcgFUs7HzMUFXGt0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy65DLeTNs7BssQTSWaK9Gsjcl6g07zZDsn3K/jcJRv8xvMIQ3t
 l6cS+Ld5XfHjAIXJRCEPVugQ8CPsjJxuBv08Y/H57uqUBIGEC48x8P/AsfQYtKP3Gwo=
X-Gm-Gg: AY/fxX4f+gCaM+IW6W8tf0AP8k74f+6OsAa1nVWCE/aEryMbvgSsSK6a0OiNEBTycY8
 ImP4mavd8AiN4ayex9Fp/NeeZXpTUIRxjALPAVlNz2lPYV1DtqnA/HMJz/MsthG9w9NHplLBjUT
 ocm4IMAEkPkIHQbkoNpLy9Zw6eRIJW7Wy84pI/9IlyIzxA00QVe5Y1EIkpZWMW70FEV3ZVlce3c
 Kv4iAYAxJWs2sEfYRO15RQD7u9AXOs9mKcWkic7xFfDt5ZMP2C4phJv8u/ml595bzq5eNMqyf0j
 f731q6FRtiht7i06P40/x8biygjJkCyZxXk/HjWJnQeEk0OMPDeW04gSMNYFLyTGOP3aWvcxkTw
 CzBqXsCoj0lPh6AXcYyBQH0YjaEoqS74aDbO1ABkERS3YNJurQ9aLpQsF8emex6zKEDXNhcvXa+
 jsWTuU5Uu5KhZC7E7lXpbUG/h/hB4PrVUwD0rw9MykXEX0b4XDmt+ISrOh9ZuRpH+zUPee3E7cN
 MEQF1KTFtUShvmhs19MliB7uc1kTsIquKK4FP0=
X-Google-Smtp-Source: AGHT+IGNgo7g6Lv3j2gtG3+qQbeSKxXpCGrn7WdqBrIE4G5P0XTZCIp/EOlAJo0DiaADDtgMk3RB/w==
X-Received: by 2002:a05:6830:4103:b0:758:1417:7ee7 with SMTP id
 46e09a7af769-7cc66a0b453mr19385014a34.5.1767146093452; 
 Tue, 30 Dec 2025 17:54:53 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667f9468sm23200482a34.28.2025.12.30.17.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 17:54:52 -0800 (PST)
Date: Tue, 30 Dec 2025 19:54:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/4] fix integer overflows in filesystem code
Message-ID: <20251231015450.GW710860@bill-the-cat>
References: <20251228164500.313817-1-t.preissl@proton.me>
 <20251229144813.GP710860@bill-the-cat>
 <CAFLszTjFP4N1v-=Uob+DRpG_Fc3szkt+yziG+cbLQ7nxaM5mvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3x1QFd+lsUNBvo9h"
Content-Disposition: inline
In-Reply-To: <CAFLszTjFP4N1v-=Uob+DRpG_Fc3szkt+yziG+cbLQ7nxaM5mvQ@mail.gmail.com>
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


--3x1QFd+lsUNBvo9h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 06:48:38PM -0700, Simon Glass wrote:
> Hi Timo,
>=20
> On Mon, 29 Dec 2025 at 07:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Dec 28, 2025 at 04:45:08PM +0000, Timo tp Prei=DFl wrote:
> >
> > > Timo tp Prei=DFl (4):
> > >
> > > This patch series fixes potential integer overflows in U-Boot
> > > filesystem code. It includes the following patches:
> > >   fs: prevent integer overflow in fs.c do_mv()
> > >   fs: zfs: prevent integer overflow in zfs_nvlist_lookup_nvlist()
> > >   fs: squashfs: prevent integer overflow in sqfs_concat_tokens()
> > >   fs: ext4: preventing integer overflow in ext4fs_get_bgdtable()
> > >
> > >  fs/ext4/ext4_write.c |  7 ++++++-
> > >  fs/fs.c              | 18 ++++++++++++++----
> > >  fs/squashfs/sqfs.c   |  9 +++++++--
> > >  fs/zfs/zfs.c         |  9 ++++++---
> > >  4 files changed, 33 insertions(+), 10 deletions(-)
> > >
> > > All patches have been tested with:
> > > - sandbox_defconfig
> >
> > First, thank you for looking in to this. Second, please run
> > "scripts/checkpatch.pl" against each as there's inconsistent spacing
> > used here and that makes review harder (and needs to be fixed before
> > applying). Finally, for each commit please elaborate on the problem
> > being fixed (for example "if ... is corrupted then ... could
> > oveverflow"). Thanks!
>=20
> In case it helps, there was an earlier series here:
>=20
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D456262&state=3D*

Please don't further confuse things Simon, thanks.

--=20
Tom

--3x1QFd+lsUNBvo9h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVSCZgAKCRAr4qD1Cr/k
CpbTAP4zNnPrgRjNKH+Oo0nNjWoX0fQolrauw16TCgAKyDf40AD/WSgycx9sLGbp
TDsdbkCch7Obp9/w2UEep4FK9A54CwQ=
=ctHS
-----END PGP SIGNATURE-----

--3x1QFd+lsUNBvo9h--
