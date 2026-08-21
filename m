Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385CBC5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 18:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2BE140A09;
	Fri, 21 Aug 2026 18:55:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRegShUvnThj; Fri, 21 Aug 2026 18:55:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787338521;
	bh=U/GMGczohtHjqG0p9Io1Go//HM4H/6Lv4F31m8BwqPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vt3xnNWDd7WROzu+/PrpOTAwtKhEh6+MmFPad/CV4CEj9czHi4JQr86GnKOqFXslx
	 VcEI4BNrB6TsR1WhiEzSEDRWILVnFw8kwbBYY8o1jvQBe2bn2paPD8maLf9AM54tU4
	 oMCcYEciK0t5YdBAreEeDlC8R1TRWi4ja4f2SQq1p0cQUHkQlH9XTMokTvhWsO06UU
	 JdefOug24MQeguGk234Zs1+/XYmNDtbmQZYAekQQKweSJb9PMFVLKCaI0IzboIPVtx
	 EDkFOIyLBjqv38npTwhW/SyiM/ZcAtVX8sOcyK4vtRFMGN1QX4Oehs6IKt5zrL7bnN
	 Eo8quwlzTY4Lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF42440A0B;
	Fri, 21 Aug 2026 18:55:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 38C944C4
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 18:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 164C540447
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 18:55:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aW5T582jaIni for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 18:55:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::4;
 helo=mail-oi2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dX+bvh6a
Received: from mail-oi2-x04.google.com (mail-oi2-x04.google.com
 [IPv6:2607:f8b0:4864:32::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E276A4011F
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 18:55:16 +0000 (UTC)
Received: by mail-oi2-x04.google.com with SMTP id
 5614622812f47-4960cd51443so109403b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787338515; x=1787943315;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U/GMGczohtHjqG0p9Io1Go//HM4H/6Lv4F31m8BwqPg=;
 b=dX+bvh6aW/w7HWcq+TCg4+yB3VPpGuaMWh4fROTETjzcycNX5catY3jy+iECJNDDiJ
 7WV8iZLXak+l5bx60fk/wgYj5OP4NIpN9ddumiwGeUwmA4vVqeQ0+CUwXXjstQbzUiBs
 TeHWu7olNvKvvpAvfNJ3aDnryFJ9Pmvw7sEaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787338515; x=1787943315;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U/GMGczohtHjqG0p9Io1Go//HM4H/6Lv4F31m8BwqPg=;
 b=HaBdXRDxxtlORg9DVYunA22tIJEB19H++ZmGGg0MbJjkEV3U99Wg2Bi3mrH7aZ3KeF
 QdhOt2TbK7Ta0irWnwK0dJzaeKItpOVP69bHxJEoQUDX+8L7Dp6iDHuNnc2Qq9buawBO
 YSV+OEOs6PGx+GgDkc2/FoPX+wbU0GSy0fo3zG5uketZdE2ljSCEKcPlECQLLfeEmwO1
 t9t0GUtRZoh/wC9vnOiuN5LsxJ28j2Q4VqRbq6c6q/mBDy14/l+Q2Zwbgz6Z40cOfmqF
 znxTTRnRH1dmWNBpEXh1Qh2jhd3DYJZ3GMTlTwqEv9dYGsagAM2+/IFEDd8bJl8yZ1Z0
 ouXg==
X-Gm-Message-State: AOJu0YwqcSGj5aQ3KyJdvuth/NclvLxhINfW9TffD8AvIX/1GQj85wLh
 Zm6cf02wZ/Fv2Vw768TQDBPn4DqTo6xv5enrMcVDJxOQ0p23bauWQ3zh5AdLF2ipnYg=
X-Gm-Gg: AR+sD10XVvRjNUVPda2ZEHK/f8UcBwKVBGgmu3aujCc3mGYeIW+iuaR3e5SOXcvY7mS
 rAqvfV7swagImbMXVoHfZRpYUtH9Qj7fg1PDoVfzs11nHBVR8p5IggEWqzxt0Ky1TbBAIwfYo8S
 mS40EvRqItYSivzSYvOopgLsXJQ9Do6B+SAIDtm4HUEOG9pU/6VJb9Jt5ZPJ0D7etA4Sl7fXI8U
 ycbZN015j1F3W3cGoturI73ElOgIVk92SJUVQYrcYJv4ax4ctByaKLJgO+891nIK5z8TBF04sYb
 vNJBanWAVHmdYzPeJwGpZjfS9qUK3uytEv66W3wXD5KnC2VvahPts+CovYsTcnkfM0OKrhzysVO
 G/nxQXBwsM6jFbLL8NAHL8ZZqe8J/MrlF0OQf9JlBNjjvZRT3mfR8qNgM07mJz0Y0V09fsZb695
 vA4qADW8QuCxMVGLxd0n4AjNe11LeNHh7EyncJsZEA+8LM2LztMWLyolU84cnWmj3aYBRacmTr4
 8aCZ3DwvfMApQ/nJ5W16rNyXU2R3PczJBkv942+zDa02NQZtLBMW0z5ZaJG95dveIZFkTChJamI
 OAc1tgzmgeygK94MlF0R
X-Received: by 2002:a05:6808:bc9:b0:496:2b3:ae71 with SMTP id
 5614622812f47-4b309bc09e2mr1193078b6e.18.1787338515578; 
 Fri, 21 Aug 2026 11:55:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2d68769e1sm5421329b6e.8.2026.08.21.11.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 11:55:14 -0700 (PDT)
Date: Fri, 21 Aug 2026 12:55:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org,
 nora.schiffer@ew.tq-group.com
Subject: Re: [PATCH v2 0/8] bootm: size the noload buffer from the compressor
 header
Message-ID: <20260821185512.GQ523975@bill-the-cat>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260818132332.324173-1-aristo.chen@canonical.com>
 <20260818221019.GE523975@bill-the-cat>
 <CAA=k7==gD0A2Ri=-=4ogTf=yJH5s6mOUMF7k5LGYGRR-Sommfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iKtsM+GJNOQ1pd0E"
Content-Disposition: inline
In-Reply-To: <CAA=k7==gD0A2Ri=-=4ogTf=yJH5s6mOUMF7k5LGYGRR-Sommfg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--iKtsM+GJNOQ1pd0E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 10:53:57PM +0800, Aristo Chen wrote:
> Hi Tom,
>=20
> On Wed, Aug 19, 2026 at 6:10=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Tue, Aug 18, 2026 at 01:23:14PM +0000, Aristo Chen wrote:
> >
> > > This is v2 of "bootm: size the noload decompression buffer from the
> > > compressor header". Tom pushed back on v1
> > > (https://patchwork.ozlabs.org/project/uboot/patch/20260809042338.6339=
7-2-aristo.chen@canonical.com/)
> > > on two grounds:
> > >
> > >   1. No concrete problem report driving the change.
> > >   2. ~1297 platforms grew by ~170-400 bytes; the change is not
> > >      opt-in, so the size cost falls on everyone.
> >
> > So, the first example that pops up in my builds is imx8mn_beacon_2g.
> > And for v1 of the series:
> >    aarch64: (for 1/1 boards) all +16384.0 data +14336.0 text +2048.0
> >             imx8mn_beacon_2g: all +16384 data +14336 text +2048
> >                u-boot: add: 0/0, grow: 1/0 bytes: 328/0 (328)
> >                  function                                   old     new=
   delta
> >                  bootm_run_states                          3316    3644=
    +328
> >
> > And now for v2:
> >    aarch64: (for 1/1 boards) all +16384.0 data +14336.0 text +2048.0
> >             imx8mn_beacon_2g: all +16384 data +14336 text +2048
> >                u-boot: add: 0/0, grow: 1/0 bytes: 368/0 (368)
> >                  function                                   old     new=
   delta
> >                  bootm_run_states                          3316    3684=
    +368
> >
> > Next, picking turris_mox as it enables ZSTD:
> > v1:
> >    aarch64: (for 1/1 boards) all +472.0 text +472.0
> >             turris_mox     : all +472 text +472
> >                u-boot: add: 2/0, grow: 1/0 bytes: 472/0 (472)
> >                  function                                   old     new=
   delta
> >                  image_decomp_get_uncompressed_size           -     416=
    +416
> >                  bootm_run_states                          2360    2412=
     +52
> >                  zstd_get_frame_header                        -       4=
      +4
> > v2:
> >    aarch64: (for 1/1 boards) all +428.0 text +428.0
> >             turris_mox     : all +428 text +428
> >                u-boot: add: 1/0, grow: 1/0 bytes: 428/0 (428)
> >                  function                                   old     new=
   delta
> >                  bootm_run_states                          2360    2784=
    +424
> >                  zstd_get_frame_header                        -       4=
      +4
> >
> > So, that is better. Looking at smartweb, both iterations are the same:
> >        arm: (for 1/1 boards) all +96.0 text +96.0
> >             smartweb       : all +96 text +96
> >                u-boot: add: 0/0, grow: 1/0 bytes: 76/0 (76)
> >                  function                                   old     new=
   delta
> >                  bootm_run_states                          3592    3668=
     +76
> >
> > What's honestly concerning is chromebook_coral where v2 *shrinks*:
> >                u-boot: add: 0/0, grow: 0/-1 bytes: 0/-2 (-2)
> >                  function                                   old     new=
   delta
> >                  bootm_load_os                              520     518=
      -2
> > but v1 grows:
> >                u-boot: add: 1/0, grow: 1/0 bytes: 110/0 (110)
> >                  function                                   old     new=
   delta
> >                  bootm_load_os                              520     587=
     +67
> >                  image_decomp_get_uncompressed_size           -      43=
     +43
> >
>=20
> That one is working as intended: chromebook_coral enables none of
> GZIP/LZMA/LZ4/ZSTD, so it is one of the "bootm with no decompressor
> at all" boards from the cover letter. In v2 every helper and its
> switch case sit behind CONFIG_IS_ENABLED(<format>), so on that board
> they all compile away and only the unchanged 8x fallback remains.
> The -2 bytes is codegen noise from the restructure; I diffed the
> disassembly and the function is otherwise unchanged. v1 grew there
> because its helper in image.c was built unconditionally. Behaviour is
> unchanged either way: with no decompressor enabled, a compressed
> kernel_noload image already fails in image_decomp().
>=20
> The imx8mn_beacon_2g result has a similar shape to what I measured
> on am62x_evm_a53: both enable LTO, and on these LTO configurations
> compiler inlining and layout make v2 a few tens of bytes larger
> than v1 (+368 vs +328 here, with the growth landing inside
> bootm_run_states either way). That is the trade of the per-format
> split, which is what makes the no-decompressor boards free, trims
> the gzip-only majority, and keeps each format individually
> droppable.
>=20
> turris_mox is the non-LTO counterpart and shows the intended
> direction for the multi-algorithm case: v2 comes in 44 bytes below
> v1 there (+428 vs +472 in your run).
>=20
> smartweb is the expected gzip-only LTO case: both versions cost
> essentially the same (+96 in your run).
>=20
> Thanks for the u-boot-size-test.sh pointer. I re-ran your four
> boards with it against this series' base and reproduce your numbers
> to within a few bytes of toolchain difference, including coral's -2
> (here: v1 +108 with bootm_load_os +65 plus the unconditional helper
> +43, v2 -2). I will use the script for the size numbers from now on;
> if you would like the cover letter regenerated with those numbers, I
> am happy to respin as v3 with the code unchanged.

Thanks for explaining and digging a bit more. At the end of the day, I
wish we could solve this problem, but have smaller growth, but I don't
see it. So v2 is fine as-is from my point of view, no need to spin a v3
unless there's other feedback.

--=20
Tom

--iKtsM+GJNOQ1pd0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoifDAAKCRAr4qD1Cr/k
CtCFAP9drWX+Qt4PevEBEUm1HIZMnD7ywMgmL0RWdDrgCmdGJAEA1RPb9VG3on4U
mxl+VsdST9O+ldZ0MeJRyx/H17bNcAE=
=aiBP
-----END PGP SIGNATURE-----

--iKtsM+GJNOQ1pd0E--
