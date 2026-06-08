Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7B3CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 14:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E05846E6;
	Mon,  8 Jun 2026 16:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I4UzOFYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17DCF846E6; Mon,  8 Jun 2026 16:01:06 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA89A846B1
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 16:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e6f27619e7so3542393a34.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 07:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780927262; x=1781532062; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bEqDdmYJqJRrYmEIPjCv4wHLf8/f39vpuyrvn7hAoo0=;
 b=I4UzOFYZfF7AmRImjfcuM8CePnX1kVcsnr8GxwjphoAmv5fIAAwbaXUFotvay5DVI3
 7qKtFQVG1iT3dH8AGQro+jTiOFF6zQMKwpQ4BAg+pXgJVtFJBZGQDjHhjIwrwt8kN+Qr
 301qXIQuxtm4XEsDWXGv02n9gCpGjJwKFET8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780927262; x=1781532062;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEqDdmYJqJRrYmEIPjCv4wHLf8/f39vpuyrvn7hAoo0=;
 b=Zs9aqXoAsyek/Ba6ro/8rxYdpKXvmbWNvfE+dUnzUzSRKwksMhCFdmBEFWRNhbPHvM
 ymC+OlfJPntH8dQD7tXcLzk2YTnxSVGcj5HdCGF9PqGBAWaLr5R5eW9JujkqcyhKW68p
 6CE63/e4xr4fhe0/hZs/9n0idGJhfwelZjt9QPK5gqFjF18q9KX+UGBLZLtLfFhtQ7yt
 olXuQp0zUEgao0+h/5ybDcVPBa0t8bhrW29641O4Z9G6d7aBrhNQ5Ri5JHQJ6dPBjGot
 BMi/x7Jqz+2l7rEqjj8QJ3EhazF+pmuzI1mVVzW6656Z/+UIxGG3O5ccsaoZ/UMUrSOa
 8aKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4UN6SpN0RfioRoGGbnGvagGkg3VD6VCZfcQ5jvJmZT3smdIjWyh1RWUGNVRXHr7AGm/izGN4=@lists.denx.de
X-Gm-Message-State: AOJu0YzSi1O2thyr30zb/9buO1RS/JL8CTJNx2GpYd0Bdm7ypkVBdNBF
 oXielVZT3TH6PjeZO/c+HkreYAf2m4NpMruBLjgqbD+uvwvOp77+Jbc51gndofzKgic=
X-Gm-Gg: Acq92OFTTLQxpENSrZgmfAd6THpihutKNw6Wvr0xsskW6eXDFi21bHHYAj8VfVEl3NM
 JhH30ZQVZrOpoueEfqQP8t4Vho/eDPqJR7H9IE95rUi0AFIROODjdNXauvfJEx3gL8NNioTyJuf
 yVSglDH91JMBKVby14J0tLojA/f1WIA8lP+F4qWgdqRF21Tpl88xILor4rnzpT8li3MLjzK8bqw
 6PjiiwPCTUaolOGP5guGMEXWF/9RnlQoQOU82rkIF8DKzir7GM9U8RQBy07bsCgcuGUiK0nr6Vm
 NIBNqjpMvjR8KByUL9gef3/Zkq9ZON+MpLzfMycIPK5PgTidcoe3LxZ6RgDn8Ffq1a/BbVCzSVc
 GH4ytpMf5RkNZT3S6FWtF1fMbDbrZPUF0w1HnfJHwQk5OJoVHUglTEY9Ry0IVjoBHDx35UZxUqJ
 ZsBiD9it30wAmFdjP4oDcYt9r27fUck/aBNYh/FxFYM4LMVNBxW80i6OWXajhfMphMG9FCjxnqt
 qCm7IeeHDGkrhQxvOObFEZLPIVaCmiZrudXehRR2u7S0cMiMxCH4aEzJwZEQg==
X-Received: by 2002:a05:6830:6d18:b0:7d9:7201:1acf with SMTP id
 46e09a7af769-7e70c61c92emr8357282a34.5.1780927262436; 
 Mon, 08 Jun 2026 07:01:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e7974f22sm12067362a34.25.2026.06.08.07.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:01:01 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:00:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: Re: [PATCH 3/5] x86: edison: Align U-Boot via binman to fix the boot
Message-ID: <20260608140058.GG382693@bill-the-cat>
References: <20260607230519.3022520-1-sjg@chromium.org>
 <20260607230519.3022520-4-sjg@chromium.org>
 <20260607234726.GF382693@bill-the-cat>
 <aiZ9W3ClrZ-B31VD@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V3FY0hNfxjmRNSin"
Content-Disposition: inline
In-Reply-To: <aiZ9W3ClrZ-B31VD@ashevche-desk.local>
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


--V3FY0hNfxjmRNSin
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 11:29:15AM +0300, Andy Shevchenko wrote:
> On Sun, Jun 07, 2026 at 05:47:26PM -0600, Tom Rini wrote:
> > On Sun, Jun 07, 2026 at 05:05:12PM -0600, Simon Glass wrote:
> >=20
> > > The mask ROM loads the OS image to 0x01100000 but enters it at
> > > 0x01101000, so U-Boot must sit 0x1000 (4KB) into the loaded image. Th=
is
> > > was arranged by board/intel/edison/config.mk, which prepended 4096 ze=
ro
> > > bytes to u-boot.bin through an 'INPUTS-y +=3D u-boot-align.bin' rule =
whose
> > > recipe moved its output back over u-boot.bin.
> > >=20
> > > Commit bd3f9ee679b4 ("kbuild: Bump the build system to 6.1") stopped
> > > that rule from running, so u-boot.bin no longer gains the 4KB prefix.
> > > The mask ROM then jumps 4KB into U-Boot's code and the board never
> > > starts, sitting in BootROM download mode (DnX) and cycling.
> > >=20
> > > Since the Edison image is assembled by binman, provide the gap there
> > > instead: pad with a 'fill' of 4096 zero bytes ahead of the u-boot ent=
ry.
> > > Drop the now-redundant alignment hack from the board config.mk.
> > >=20
> > > Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >=20
> > That's an unintentional behavior change we should understand why
> > happened, and then do whatever needs to be done to fix it, so that other
> > platforms that might have been in a similar spot can also be fixed.
>=20
> While I agree on this, the Intel Edison case gets rectified by this serie=
s in
> terms of getting rid of the known hack as Simon mentioned. Yes, it was me=
 who
> invented that hack long time ago for quicker ramping up the board.

That's good to know, thanks. As I agree that this is a better long-term
solution, but for the upcoming release the right answer is to fix the
direct regression (and so potentially other platforms, depending on root
cause).

--=20
Tom

--V3FY0hNfxjmRNSin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaibLFgAKCRAr4qD1Cr/k
Cu4KAP9ySEDXTX6Mxjdy2wZh+np/ty8dZ7b2TGFzZtHEQuE3pgD/c7z10UfG5RN5
i7V5yg4GrFxNmil1BM/evxoOw1H8+g8=
=tmng
-----END PGP SIGNATURE-----

--V3FY0hNfxjmRNSin--
