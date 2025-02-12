Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2365EC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 13:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BE7480BAD;
	Wed, 12 Feb 2025 14:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CZZGDUJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA7A80C5A; Wed, 12 Feb 2025 14:44:14 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 492C88043C
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6e4565be0e0so44545676d6.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 05:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739367851; x=1739972651; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JrYd6reC6V3wX8LSemyNjbWUXAMzv2K5m64TfJQ6emg=;
 b=CZZGDUJZ8gYFZbQrw0/J42bLcImfKKN452KDr+e+txqGrLNOnHiyFYriwm+NQLI0TB
 6PmPSepNN/SHWS1wWUzicH7YckcOGr7wYJO4+uaXTMWO4QD2U2NGWcFlEmdF517h/7m8
 nA91fiqtsKkA9+KCVqe66mXEigPQC/nfCq00A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739367851; x=1739972651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrYd6reC6V3wX8LSemyNjbWUXAMzv2K5m64TfJQ6emg=;
 b=Law/iAoROrr9YPqTSygwPSXgmFMaNhi+Mrxw1UCPZTkqGL9ou4dS1/Fxa8HimkfZ2w
 OuXwzYAi7VYrqzgEjtLFdiVNEmmahtz8OfvMS1dTLKQkM7803grjozZAelS2hagJJ4H2
 ing3nHw6j1CjZnF+T+m7Oqx95FdWMfQp7fyphZDbRq5jToDoywFeyiZ+UWPSiaDWzXLW
 0UmPgGexV9nRo+mlt1Q4zhZTFH+AUFPxqZ9S5EL8AO1hI48yeFf58GLsKCc1MFlWETcr
 8n8wl0+ubE68zdq+cIVN2Nwztcj0aF04jJVvHRHzKjrWsx6afkiiKHOPdkAfnq3CdRM8
 wt0w==
X-Gm-Message-State: AOJu0Yw20PJojMoQ6uBQMU5NLeLox9N9O7UomGxXePIY0C3SZhYWKpeX
 fm2gO8AUST9ZpxhIR8CDXjz3u9nlO3v3/8pTQ31Pr18XMCRsM2CLJ6D3JUMj6o8=
X-Gm-Gg: ASbGnctxfEr/96dLGe8KKOcJ0i5W96tDJ49EOBvUs9O+BSCkp0iS96d/Z4tQMepVdM/
 B3GxTsr3hj4tmsY78p3xm/K5WTzSeNKE54aXztaPugb+uEhy4EuqGpvRQaI7h/35855WWduBBVV
 mDUt81FVQ4zGRdNOFiZZso3d/Eb+dUjfoKAcqsEkDuJ9jLu7TLHICw83GUwidaxF414OAHynPW5
 qamyJF+cJ32tmaWJoQBSRStCoWxxYFo9716F9Lf64wsD0lBo0KVaVjcEA/MunRWtWyijb/RGk5i
 4U8D9jtuPRge+fw=
X-Google-Smtp-Source: AGHT+IEmJ77o5oNNSAIH/VTqx+EU9i13Ul2H9lgzCTHwV/9Bhk6q7GVPouI438bULSMVtTLt47sJEQ==
X-Received: by 2002:a05:6214:212b:b0:6e4:4484:f35c with SMTP id
 6a1803df08f44-6e46edc27d9mr45191436d6.30.1739367851083; 
 Wed, 12 Feb 2025 05:44:11 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e4532f9ce9sm56826126d6.65.2025.02.12.05.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 05:44:10 -0800 (PST)
Date: Wed, 12 Feb 2025 07:44:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH v4 05/15] lmb: notify of any changes to the LMB memory map
Message-ID: <20250212134406.GL1233568@bill-the-cat>
References: <CADg8p97Q70PnsXd=GtTLncg8B8LMTN7bda4YXxb+VDnCU4HL4Q@mail.gmail.com>
 <20250120-shine-extended-134d3ccac85f@thorsis.com>
 <CADg8p96wCZppfKBrVok6nU1eyx=dHcAH9iZaiHa_jMkYd1LHUg@mail.gmail.com>
 <20250211-distract-whooping-739989988035@thorsis.com>
 <CADg8p94iMJv5ph51ng8r=HaiMSdSMj08Lj03=Amt+2JzyFySYw@mail.gmail.com>
 <20250211135407.GY1233568@bill-the-cat>
 <CADg8p96rNvxQ7ugmexKhmJ092WJEMwYjF50KpASjVbNrA7xxsA@mail.gmail.com>
 <CADg8p95xSTpDE_6zKnKHCkJmv0_rqicFXRAXA54D0hzKG_pDaA@mail.gmail.com>
 <20250211145459.GC1233568@bill-the-cat>
 <CADg8p94uShNqQuWg2BuWToDiwNfWcbd7JTNAmDs+b6WLy=u9Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NfIAes9kcz8bWzuH"
Content-Disposition: inline
In-Reply-To: <CADg8p94uShNqQuWg2BuWToDiwNfWcbd7JTNAmDs+b6WLy=u9Qg@mail.gmail.com>
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


--NfIAes9kcz8bWzuH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 03:11:16PM +0530, Sughosh Ganu wrote:
> On Tue, 11 Feb 2025 at 20:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 11, 2025 at 07:40:40PM +0530, Sughosh Ganu wrote:
> > > On Tue, 11 Feb 2025 at 19:30, Sughosh Ganu <sughosh.ganu@linaro.org> =
wrote:
> > > >
> > > > On Tue, 11 Feb 2025 at 19:24, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Feb 11, 2025 at 04:41:09PM +0530, Sughosh Ganu wrote:
> > > > > > On Tue, 11 Feb 2025 at 16:34, Alexander Dahl <ada@thorsis.com> =
wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > Am Tue, Feb 11, 2025 at 04:23:13PM +0530 schrieb Sughosh Ganu:
> > > > > > > > On Mon, 20 Jan 2025 at 15:43, Alexander Dahl <ada@thorsis.c=
om> wrote:
> > > > > > > > >
> > > > > > > > > Hello,
> > > > > > > > >
> > > > > > > > > Am Mon, Jan 20, 2025 at 02:40:38PM +0530 schrieb Sughosh =
Ganu:
> > > > > > > > > > On Fri, 17 Jan 2025 at 16:40, Alexander Dahl <ada@thors=
is.com> wrote:
> > > > > > > > >
> > > > > > > > > [=E2=80=A6]
> > > > > > > > >
> > > > > > > > > > > This changeset breaks build with CONFIG_CC_OPTIMIZE_F=
OR_DEBUG=3Dy for
> > > > > > > > > > > me.  In a usual non-debug build, everything is fine. =
 However in a
> > > > > > > > > > > debug build now I get this error:
> > > > > > > > > > >
> > > > > > > > > > >       UPD     include/generated/timestamp_autogenerat=
ed.h
> > > > > > > > > > >       GEN     Makefile
> > > > > > > > > > >       Using /mnt/data/adahl/src/u-boot as source for =
U-Boot
> > > > > > > > > > >       CC      common/version.o
> > > > > > > > > > >       AR      common/built-in.o
> > > > > > > > > > >       LD      u-boot
> > > > > > > > > > >     arm-v5te-linux-gnueabi-ld.bfd: lib/lmb.o: in func=
tion `lmb_map_update_notify':
> > > > > > > > > > >     /mnt/data/adahl/src/u-boot/lib/lmb.c:458: undefin=
ed reference to `efi_add_memory_map_pg'
> > > > > > > > > >
> > > > > > > > > > Can you share the details of the toolchain that you are=
 using, where
> > > > > > > > > > can I download it from. And the target that you build w=
hich shows this
> > > > > > > > > > up. Thanks.
> > > > > > > > >
> > > > > > > > > Although I'm actually building with ptxdist and
> > > > > > > > > OSELAS.Toolchain-2023.07.1/arm-v5te-linux-gnueabi for a c=
ustom board,
> > > > > > > > > you should be able to reproduce the behaviour easily with=
 buildman on
> > > > > > > > > master when building for boards sam9x60ek or sam9x60_curi=
osity like
> > > > > > > > > this:
> > > > > > > > >
> > > > > > > > >     buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE=
_FOR_DEBUG sam9x60
> > > > > > > > >
> > > > > > > > > My output when running the above is this:
> > > > > > > >
> > > > > > > > Sorry, I haven't spent time debugging this issue, although =
this is on
> > > > > > > > my todo list. Btw, since you already have a working setup, =
can you
> > > > > > > > please reset your tree to the following commit and then che=
ck if that
> > > > > > > > fixes your issue.
> > > > > > > >
> > > > > > > > 92e75ee47f1 ("board_r: Remove duplicate headers")
> > > > > > >
> > > > > > > Does not change anything.
> > > > > > >
> > > > > > > Note: my tree is not special in any way, it's a clean mainlin=
e u-boot
> > > > > > > checkout and I'm building for a board with an in tree config.
> > > > > > > Everyone should be able to reproduce this by using
> > > > > > > configs/sam9x60_curiosity_mmc_defconfig, enabling
> > > > > > > CC_OPTIMIZE_FOR_DEBUG and building with the default toolchain
> > > > > > > downloaded by buildman, which is also mainline u-boot tooling.
> > > > > > >
> > > > > > > My assumption is: some efi code is pulled in unconditionally =
here,
> > > > > > > but efi is not enabled on armv5 and it can not be enabled,  e=
fi is not
> > > > > > > needed on this target anyways.  Furthermore: I assume the cod=
e is
> > > > > > > optimized out when doing a normal build without CC_OPTIMIZE_F=
OR_DEBUG,
> > > > > > > which is basically building without optimizations and keeping=
 debug
> > > > > > > symbols.
> > > > > >
> > > > > > Okay. Please give me some time. I will try to spend some time o=
n the
> > > > > > issue this week. Thanks for your quick response.
> > > > >
> > > > > Yes, the problem is that CC_OPTIMIZE_FOR_DEBUG disables compiler
> > > > > optimizations that we normally rely on to avoid having to #ifdef =
the
> > > > > code. In this case, lmb_should_notify() causes this to normally be
> > > > > optimized away as CONFIG_IS_ENABLED(EFI_LOADER) will be false and=
 the
> > > > > compiler will do the right thing. The "fix" is to instead make mo=
st of
> > > > > the body of lmb_map_update_notify be guarded with #if
> > > > > CONFIG_IS_ENABLED(EFI_LOADER) ... #endif
> > > >
> > > > Yes, that would be the obvious thing to do. But I suspect that beca=
use
> > > > there are no optimisations with the said flag, it might be needed to
> > > > even protect the function calls with the ifdefs. Which I am hoping =
to
> > > > avoid.
> > >
> > > If we cannot do without using ifdefs at the function call sites, what
> > > is your opinion on disabling lmb with the CC_OPTIMIZE_FOR_DEBUG flag
> > > enabled? Maybe this can be converted into a config flag. There are
> > > existing configurations like xilinix mini which too are disabling lmb.
> > > Thoughts?
> >
> > It should just be a single set of #ifdef ... #endif, and possibly adding
> > a __maybe_unused.
>=20
> Like I suspected, just a single set of #ifdef ... #endif does not
> help. Get link errors like such

For sam9x60ek_mmc_config with CC_OPTIMIZE_FOR_DEBUG this is all I
needed:

diff --git a/lib/lmb.c b/lib/lmb.c
index 7ca44591e1d7..1e9e9f9a3321 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -430,7 +430,7 @@ long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, =
phys_size_t size)
=20
 static struct lmb lmb;
=20
-static bool lmb_should_notify(u32 flags)
+static __maybe_unused bool lmb_should_notify(u32 flags)
 {
 	return !lmb.test && !(flags & LMB_NONOTIFY) &&
 		CONFIG_IS_ENABLED(EFI_LOADER);
@@ -439,6 +439,7 @@ static bool lmb_should_notify(u32 flags)
 static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 				 u32 flags)
 {
+#if CONFIG_IS_ENABLED(EFI_LOADER)
 	u64 efi_addr;
 	u64 pages;
 	efi_status_t status;
@@ -466,6 +467,7 @@ static int lmb_map_update_notify(phys_addr_t addr, phys=
_size_t size, u8 op,
 		return -1;
 	}
 	unmap_sysmem((void *)(uintptr_t)efi_addr);
+#endif
=20
 	return 0;
 }

--=20
Tom

--NfIAes9kcz8bWzuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmespaMACgkQFHw5/5Y0
tyxEZgwAp/KmgDefBIV6OC6WyYWnVFMPGWGBqaaDi0l3Br+LfhuWPJVLo3CzfMNy
l6nHkZ2706T08sPxGzgPQIqmlbRclJLHoS1BcWfvcT5x9HCARTpdKS8igCoybAZt
0qFAY3+dw5nnebq2L5XesPaFI+OtAQtXu84W4gneHvu/pJbhzAKD+6gFbNgDUPqj
GK1KXv2n6guTJbmE/WzisAHxKhdPzfCar7ELD3SnPopweBtXVBok9IG0J/d8UHKt
bEGkSJXiJmuSWxp6jxtFd7Psvecrbgu7aTEGzKkJ6ihjZPC7F0LTKSwTGYsWElb9
K2h/F24DwgSegMiLKBYvAi+d2Fk8DCIwjFhYF8SgcIRGgvJEmutuwIV8oOLWuqwQ
55DN6N3XntA42bkWFb1/sg51GsuLLbkK0VPHxLgNPcWmA9l+QSgblSOqo8SNPR5O
r777Ad2V1aDE750slUUyJ5P2hXCGMeeHPLzmRVViL2FIfC/tV3D6eaiDlA6FCQF9
ZsAIFhnj
=58RC
-----END PGP SIGNATURE-----

--NfIAes9kcz8bWzuH--
