Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608A9C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EB96807E1;
	Tue, 11 Feb 2025 15:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gtPY2Is6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62306809D0; Tue, 11 Feb 2025 15:10:39 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09889803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fa488351ffso4573187a91.3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739283034; x=1739887834; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qkj6oEuo9PPVN68Z6Xcfu5YE6GRIad6HTPZ+T/oioNo=;
 b=gtPY2Is6BF7mUEtfptYHQSUUvooKbxma3SFnXZbv1/3frmDjD4sO+BcR4tG33V9U5v
 BjSScBm3+3QqIg0gLUzl+sgKeioroeCFa2CmFdGdauvpkC6BdqNPM4WaKSdGTw8/g/lA
 afXF9+yQSDtE+vNxeeTEJQWdTx/JiUAehPJiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739283034; x=1739887834;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qkj6oEuo9PPVN68Z6Xcfu5YE6GRIad6HTPZ+T/oioNo=;
 b=lX4MymNiOX23URD9skkS6rQe3jg/CoQDzmFJ88lhXYzXRhPd6leEY7AGE3Dvse0slf
 n+j/NdJu/69grG8qYmFmJZbZULN2HndLwkFbAO6tMrdX+ez0w0SV7OckzIDPDZiveGu9
 PtjjIzl3f/qjpVF21rYVFjlmO2pBXKnhX2wsWJl9DvlAG82aMqATKPUNHhSLLGdKnejW
 caOka+snD8Ca/NncAsBenkUfXaMc3VJvzYLCHONglLpYIu4CRc4pjywAWv0x5S0BugLx
 u/9gL7ftp7Twrx/rqD/LA3M6qO0gelgm79DrJrvkd+j5vL+6AwERKNcDLwRwjbgipl6R
 Y2Jw==
X-Gm-Message-State: AOJu0YxkRW2r+R8GMOlrv6LTks3F7mCcLRmy0v/R7bIHIClmOtyAZD6H
 KdRg4KpWFn/3i7YDu5MP0xBq7zddtFmovoazCrU2Tcy4kUeywTkd8SZVMFUAuKQ=
X-Gm-Gg: ASbGnctVBUz4jl9Get96rPQiZ7pCZ0jA4BpnSNZiaW5UUTrUAZVK+D6w+0OiYsSbS8a
 OFLanQo+1Uu7+4mbroJCyb7E98qOfUR9i/c4TBWOHiS64A5ZL/ii7/HNdp9wwpSPaJdMnZK1JI8
 X7eXh+ftvej04HlyhEt1neg+WkYSfJ1lURvpYZlXU3MfO7CO5lsgMJsYLjx+9BBGisLtWZVu3pZ
 DCXF04H5qBlKD4iVbfNtrsndVoYi16rXAbj0Szeb78m28UQRnvyFA6BZUDjxFksKNxDP80giePF
 IKosQANB7kEzUx0=
X-Google-Smtp-Source: AGHT+IF4EOg0v3IP9eDssyPX7K7qLGpDC2Lpeu3lVnLBVgOdMY+Yi8hPWCvAabw5sh7iWfy4usPEFw==
X-Received: by 2002:a17:90b:3f85:b0:2f6:d266:f467 with SMTP id
 98e67ed59e1d1-2fa243f038dmr23772598a91.34.1739283034192; 
 Tue, 11 Feb 2025 06:10:34 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2faa5cf3415sm1073823a91.1.2025.02.11.06.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 06:10:32 -0800 (PST)
Date: Tue, 11 Feb 2025 08:10:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH v4 05/15] lmb: notify of any changes to the LMB memory map
Message-ID: <20250211141030.GB1233568@bill-the-cat>
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
 <20241015153717.401371-6-sughosh.ganu@linaro.org>
 <20250117-molecular-quicksand-e80bf947313e@thorsis.com>
 <CADg8p97Q70PnsXd=GtTLncg8B8LMTN7bda4YXxb+VDnCU4HL4Q@mail.gmail.com>
 <20250120-shine-extended-134d3ccac85f@thorsis.com>
 <CADg8p96wCZppfKBrVok6nU1eyx=dHcAH9iZaiHa_jMkYd1LHUg@mail.gmail.com>
 <20250211-distract-whooping-739989988035@thorsis.com>
 <CADg8p94iMJv5ph51ng8r=HaiMSdSMj08Lj03=Amt+2JzyFySYw@mail.gmail.com>
 <20250211135407.GY1233568@bill-the-cat>
 <CADg8p96rNvxQ7ugmexKhmJ092WJEMwYjF50KpASjVbNrA7xxsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7sVsMXB8wTa4oZ/X"
Content-Disposition: inline
In-Reply-To: <CADg8p96rNvxQ7ugmexKhmJ092WJEMwYjF50KpASjVbNrA7xxsA@mail.gmail.com>
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


--7sVsMXB8wTa4oZ/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 07:30:12PM +0530, Sughosh Ganu wrote:
> On Tue, 11 Feb 2025 at 19:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 11, 2025 at 04:41:09PM +0530, Sughosh Ganu wrote:
> > > On Tue, 11 Feb 2025 at 16:34, Alexander Dahl <ada@thorsis.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > Am Tue, Feb 11, 2025 at 04:23:13PM +0530 schrieb Sughosh Ganu:
> > > > > On Mon, 20 Jan 2025 at 15:43, Alexander Dahl <ada@thorsis.com> wr=
ote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > Am Mon, Jan 20, 2025 at 02:40:38PM +0530 schrieb Sughosh Ganu:
> > > > > > > On Fri, 17 Jan 2025 at 16:40, Alexander Dahl <ada@thorsis.com=
> wrote:
> > > > > >
> > > > > > [=E2=80=A6]
> > > > > >
> > > > > > > > This changeset breaks build with CONFIG_CC_OPTIMIZE_FOR_DEB=
UG=3Dy for
> > > > > > > > me.  In a usual non-debug build, everything is fine.  Howev=
er in a
> > > > > > > > debug build now I get this error:
> > > > > > > >
> > > > > > > >       UPD     include/generated/timestamp_autogenerated.h
> > > > > > > >       GEN     Makefile
> > > > > > > >       Using /mnt/data/adahl/src/u-boot as source for U-Boot
> > > > > > > >       CC      common/version.o
> > > > > > > >       AR      common/built-in.o
> > > > > > > >       LD      u-boot
> > > > > > > >     arm-v5te-linux-gnueabi-ld.bfd: lib/lmb.o: in function `=
lmb_map_update_notify':
> > > > > > > >     /mnt/data/adahl/src/u-boot/lib/lmb.c:458: undefined ref=
erence to `efi_add_memory_map_pg'
> > > > > > >
> > > > > > > Can you share the details of the toolchain that you are using=
, where
> > > > > > > can I download it from. And the target that you build which s=
hows this
> > > > > > > up. Thanks.
> > > > > >
> > > > > > Although I'm actually building with ptxdist and
> > > > > > OSELAS.Toolchain-2023.07.1/arm-v5te-linux-gnueabi for a custom =
board,
> > > > > > you should be able to reproduce the behaviour easily with build=
man on
> > > > > > master when building for boards sam9x60ek or sam9x60_curiosity =
like
> > > > > > this:
> > > > > >
> > > > > >     buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE_FOR_D=
EBUG sam9x60
> > > > > >
> > > > > > My output when running the above is this:
> > > > >
> > > > > Sorry, I haven't spent time debugging this issue, although this i=
s on
> > > > > my todo list. Btw, since you already have a working setup, can you
> > > > > please reset your tree to the following commit and then check if =
that
> > > > > fixes your issue.
> > > > >
> > > > > 92e75ee47f1 ("board_r: Remove duplicate headers")
> > > >
> > > > Does not change anything.
> > > >
> > > > Note: my tree is not special in any way, it's a clean mainline u-bo=
ot
> > > > checkout and I'm building for a board with an in tree config.
> > > > Everyone should be able to reproduce this by using
> > > > configs/sam9x60_curiosity_mmc_defconfig, enabling
> > > > CC_OPTIMIZE_FOR_DEBUG and building with the default toolchain
> > > > downloaded by buildman, which is also mainline u-boot tooling.
> > > >
> > > > My assumption is: some efi code is pulled in unconditionally here,
> > > > but efi is not enabled on armv5 and it can not be enabled,  efi is =
not
> > > > needed on this target anyways.  Furthermore: I assume the code is
> > > > optimized out when doing a normal build without CC_OPTIMIZE_FOR_DEB=
UG,
> > > > which is basically building without optimizations and keeping debug
> > > > symbols.
> > >
> > > Okay. Please give me some time. I will try to spend some time on the
> > > issue this week. Thanks for your quick response.
> >
> > Yes, the problem is that CC_OPTIMIZE_FOR_DEBUG disables compiler
> > optimizations that we normally rely on to avoid having to #ifdef the
> > code. In this case, lmb_should_notify() causes this to normally be
> > optimized away as CONFIG_IS_ENABLED(EFI_LOADER) will be false and the
> > compiler will do the right thing. The "fix" is to instead make most of
> > the body of lmb_map_update_notify be guarded with #if
> > CONFIG_IS_ENABLED(EFI_LOADER) ... #endif
>=20
> Yes, that would be the obvious thing to do. But I suspect that because
> there are no optimisations with the said flag, it might be needed to
> even protect the function calls with the ifdefs. Which I am hoping to
> avoid.

If we guard the body of the function with #if (not if (...) { ... })
then cpp will still do the right thing :)

--=20
Tom

--7sVsMXB8wTa4oZ/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmerWlUACgkQFHw5/5Y0
tyxHPgv/eKtSy1e5v9OUTNdaO/pjvZCHZAqSPjDkpCLMfs09JES0WDlE5NGQSZu2
+iblsX1JB1J4z0MAte/bIcF/6XPbZnRpbDtFajIogUmPJlHU3Y2PH0JhM1fKHjmJ
XInxOVbZGqO1Rd3H2O0kqdeRLXrdjuLiQY49KFwan7r8n7HnnS3oUQIm4VM+S0/i
ImLfg3svFRsuadfVagQpX+veTKJwW++tMEdbYyQh3GauM83Bz2Dh/nyKI3sCWj/j
PBMJH2s3HDOJYONYS51ifPCe9MKM/0Go2uLtQLDwwlmrplxl36vFIShVPxmK4hNa
VgivX72Uj7uHaquWAZXTDTVOqjCIlmNnrwtK4LtiQK0h6CWfWQxVZ72HvmUuUPGH
WO+EoVQuP7d7UsIHzRMaGsD6xUyVrGIe/HDgqfarePVrxidithXhxou7J+gPSk+W
N6pv/YvpzD6nUdzQb/GGSDGrhgcN4zvsNSIbfrtU32gXQnGGa8CRJ+tWrxLr2CRr
byExkGn6
=HhXb
-----END PGP SIGNATURE-----

--7sVsMXB8wTa4oZ/X--
