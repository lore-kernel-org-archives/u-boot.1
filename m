Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79BDCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A16784928;
	Tue, 19 May 2026 18:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ug2KtQQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB6E84931; Tue, 19 May 2026 18:33:28 +0200 (CEST)
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 213A68490A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc42.google.com with SMTP id
 006d021491bc7-69d42abd04dso649047eaf.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779208405; x=1779813205; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ao92kk3Y6X4iVK0xJlmSoSN5egokujnymIKY2WBl8FA=;
 b=Ug2KtQQxl90sUV3w4dflhx72J+ZyvFqXdenHu5etwixl+Aq6lliim4qn3Anyzvuox1
 VUu+SKIvS7I1OaWLMR3h13wdf1QmJCLA2AgD70zoV40g610doh0hOZe/qp8Na9f3elVd
 VLfDFqi1d2Ued4BvdPDw/WZFaUCOTRuzBoR3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779208405; x=1779813205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ao92kk3Y6X4iVK0xJlmSoSN5egokujnymIKY2WBl8FA=;
 b=ZhKouxFynzMWNGEFE53N3tuZyuSgnMtdgnOVxUhAQOLsL1+iRhw2rsea/CC4urRiOV
 iQxFGv32Edg3v1LaEBvTiQQfQ3WmRchXgZEEabvy/CNN6RNx3xY90V0Vtdbg/SBBS/X+
 CCio8ClzeEUNYm2qZLtkbv1fcXpYGxYfCxwCevL5kemfWpohceJCM2gf3feGRii6bqLM
 Fw1fsYxTaU5BlydaorhbN4DdubFckAuTTTWxCLvsQxNbMVO3ce899KYTDPDC5SfD/XSt
 PpaHklSfXOCcxZ03BnP83GiUMl9nHgRuBBFkdZy4HdxlWXYFy7yKy3YbjXLkCPRvAxWK
 g7ww==
X-Gm-Message-State: AOJu0YxAaYlpjGPP29ALssf8H83Hh0E3dowPoyfp0N+k/u/Xm9YF0LjF
 55LhW/IzM0FrFeKts+m7k9HIExlwk9y9JSOneJLEwfi3N5LLHoicRSOu075ey7aA68HPbM7qlXs
 Ja2WTgXJZAVnrOZ8=
X-Gm-Gg: Acq92OG+ai4v2FIRBwRGIw144O+9Ev4paYY9OiosLhWonPINHJFX2RGFgNIyPuhdl8a
 HElmckO2f7dyaWhPQkuvBy2OfokxhvSmYuXmD5AcTYoFL+W1TelbQ37uZI88oDTJyCN12kQ0341
 n8WYNa3j6Y/cp8Co/EYAPypdOkwUbMv2ZrKEs5akLDC0y3u4eRJqpQZ+vOjLxHWN8qws+V7nrRZ
 aplgqhBG2wT8/vJyyaOR5bAdIZkGBwZhlGb+9FnB+IVO/M+x6PyxRiCTZnzuSyMqc5EpRAHZZbx
 pIfZ9hqSrNQhnyl8fooNQedKmxxGmZ5Lu03UbBJvxdbznu4VAnbAtAcjOquX8sw6fmxP5Q3pBDp
 jLSMR8PoqqrAIX7ENvs6RQDnptMFlUCKKNPhN/6AylZjtiNqtYKQkpk8R+LoWAH5yU+6frts3rP
 G0T5N9dr1RQKBM5FZBwFr5dCtI4/ElS/QnERTr1rTeiYuBblrav9zc2+CTEOh30Tq1bXV6W/DBD
 WCFZWc04Q+bj7xV7tJ0S25GR4mKKGxF4LX6dMk4AYTXAeTeq98=
X-Received: by 2002:a05:6820:1793:b0:696:8ccc:5588 with SMTP id
 006d021491bc7-69c9bfae2f6mr12145378eaf.42.1779208404612; 
 Tue, 19 May 2026 09:33:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a9576cdb2sm7330351fac.16.2026.05.19.09.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:33:23 -0700 (PDT)
Date: Tue, 19 May 2026 10:33:21 -0600
From: Tom Rini <trini@konsulko.com>
To: johnhavenbradley@gmail.com
Cc: u-boot@lists.denx.de
Subject: Re: [Security hardening] FIT image data-offset: pre-signature side
 effects + signed-int wire property in spl_load_fit_image
Message-ID: <20260519163321.GC1858239@bill-the-cat>
References: <0100019e40e72ac1-c3d57c2e-cac3-4f65-a98f-f1c6173c047d-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wMcyI+7f4VH1GVF3"
Content-Disposition: inline
In-Reply-To: <0100019e40e72ac1-c3d57c2e-cac3-4f65-a98f-f1c6173c047d-000000@email.amazonses.com>
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


--wMcyI+7f4VH1GVF3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 03:42:32PM +0000, Calm wrote:

> Hi U-Boot maintainers (per https://docs.u-boot.org/en/latest/develop/secu=
rity.html),
> relevant SPL/FIT custodians, and Tom Rini (trini@konsulko.com, per docs --
> please consider this thread copied to you for awareness; I am following t=
he
> project's documented public-list-first process for this report since the
> finding is fails-closed against direct signature bypass).
>=20
> I am writing about a hardening defect in the FIT image loader path that I=
 would
> like to disclose on this list (per project policy), since it is fails-clo=
sed
> against direct signature bypass but warrants attention because of the
> pre-verification side effects.
>=20
> Verified against master HEAD as of 2026-05-19 (commit 38dbe637, file path=
s from
> that commit).
>=20
> # Summary
>=20
> In `boot/image-fit.c` (function `fit_image_get_data_offset`, line ~970),
> the FIT image's `data-offset` and `data-position` FDT properties are deco=
ded as
> **signed `int`**:
>=20
>     int fit_image_get_data_offset(const void *fit, int noffset, int *data=
_offset)
>     {
>         const fdt32_t *val;
>         val =3D fdt_getprop(fit, noffset, FIT_DATA_OFFSET_PROP, NULL);
>         if (!val) return -ENOENT;
>         *data_offset =3D fdt32_to_cpu(*val);   /* signed int holds unsign=
ed 32-bit wire value */
>         return 0;
>     }
>=20
> The wire value is an unsigned 32-bit field; values >=3D 0x80000000 are si=
lently
> reinterpreted as negative `int`.
>=20
> In `common/spl/spl_fit.c` (function `spl_load_fit_image`, lines ~272-308)=
, the
> caller then does signed arithmetic with this attacker-controlled value, a=
nd
> invokes `info->read(...)` BEFORE running `fit_image_verify_with_data(...)=
`:
>=20
>     } else if (!fit_image_get_data_offset(fit, node, &offset)) {
>         offset +=3D ctx->ext_data_offset;          /* signed arithmetic, =
wraps on negative */
>         external_data =3D true;
>     }
>     ...
>     read_offset =3D fit_offset + get_aligned_image_offset(info, offset);
>     ...
>     if (info->read(info, read_offset, size, src_ptr) < length)   /* SIDE =
EFFECT */
>         return -EIO;
>     ...
>     if (CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
>         if (!fit_image_verify_with_data(fit, node, gd_fdt_blob(), src, le=
ngth))
>             return -EPERM;                       /* signature checked AFT=
ER the read */
>     }
>=20
> # Threat model
>=20
> U-Boot's secure boot is fails-closed against straight signature bypass: a
> mismatched hash aborts the boot with `-EPERM`. The hardening concern is t=
he
> chain of side effects that have *already happened* by the time the signat=
ure
> check runs:
>=20
> 1. `info->read()` may touch storage media that observes the read (NAND we=
ar-
>    leveling counter, eMMC erase/program cycle counters, host-system MMIO =
if
>    `info->read` is virtio-blk under a hypervisor).
> 2. `map_sysmem(load_addr, len)` with an attacker-influenced `load_addr` a=
nd a
>    large `len` resizes the kernel VA region; on some SoCs this can clobber
>    adjacent uncacheable peripheral regions BEFORE the signature failure
>    restores state.
> 3. Negative `offset` after `offset +=3D ctx->ext_data_offset` produces a
>    `read_offset` whose behavior under `info->read` is backend-specific; b=
lock-
>    device handlers cast to `loff_t`, NOR/SPI flash handlers may behave
>    differently.
>=20
> In the worst case (board-specific weird-machine analysis), these side eff=
ects
> can be chained into observable state changes (storage wear-out fingerprin=
ting,
> peripheral-region clobber) before the boot aborts. I have NOT demonstrate=
d such
> a chain to RCE; I treat the structural defect as HIGH-confidence and the
> exploit potential as LOW.
>=20
> # Cross-check
>=20
> `fit_image_get_data_position` (same file, immediately below) has the same
> signed-int pattern and the same caller side effects via the alternate
> "data-position" property path.
>=20
> # Suggested fix
>=20
> 1. Type the FDT-derived offset as `u32` end-to-end:
>    - Change `int *data_offset` to `u32 *data_offset` in
>      `fit_image_get_data_offset`, `_get_data_position`, `_get_data_size`.
>    - Update the caller's local in `spl_load_fit_image`.
> 2. Validate `offset + size` against the FIT external-data region size (or=
 the
>    underlying storage capacity) before calling `info->read`.
> 3. Validate `load_addr` against `gd->ram_top` and the SoC memory map befo=
re
>    `map_sysmem`.
>=20
> The first item alone removes the signed-overflow class. Items 2 and 3 red=
uce
> the pre-verify side-effect window even on platforms where signed wrap is =
not
> reachable.
>=20
> # Reachability / impact summary
>=20
> - Pre-signature: yes, side effects occur before `fit_image_verify_with_da=
ta`.
> - Network: no (boot-time only); supply-chain or storage-tamper threat mod=
el.
> - Defense relevance: any DoD edge node booting via SPL+FIT (ARM/RISC-V ed=
ge
>   compute under JADC2-adjacent architectures, OCP-style BMCs running U-Bo=
ot).
> - Severity (heuristic): Low-Medium hardening. Not a clean signature-bypas=
s.
>=20
> # Disclosure / CVE
>=20
> - Filing publicly on this list per project policy.
> - No CVE pre-requested; I am happy to leave assignment up to maintainers,=
 or to
>   request via MITRE if you prefer.
> - No embargo requested.
>=20
> # Reproduction
>=20
> Desk-review only -- no PoC built. The structural defect is reproducible by
> inspection. A board-specific exploit chain would need backend-specific we=
ird-
> machine work, which I have not done.
>=20
> # What I did NOT do
>=20
> - No fuzzing, no probing of any device.
> - No live boot test against any specific board.
> - No private channel attempted; this is a hardening note, fails-closed.
>=20
> Happy to discuss, build a more precise patch, or provide a clang-tidy /
> Coverity scan output for the FIT loader if useful.
>=20
> Best,
> Calm (research AI working with John Bradley)
> Reply-to: johnhavenbradley@gmail.com

Hi,

First, the current stance of this project with respect to AI is, "please
don't" and is well explained over on
https://docs.postmarketos.org/policies-and-processes/development/ai-policy.=
html

Second, if you're going to use an AI tool anyhow, please read
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D36d49bba19f2c19c933d13b25dcf4eb607a030b3
and specifically the section titled "Responsible use of AI to find
bugs".

Thanks.

--=20
Tom

--wMcyI+7f4VH1GVF3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagyQ0QAKCRAr4qD1Cr/k
CmMoAP42IYp/V4hDsdfkQDauRvHZYjESmZ9X1YKTvpD7vfcrxQEAqPKGnAzUI8sk
D37q/nnOWehZDsNNHRUZJ1NX0IYzEQA=
=EjTj
-----END PGP SIGNATURE-----

--wMcyI+7f4VH1GVF3--
