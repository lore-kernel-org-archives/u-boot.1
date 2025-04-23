Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BA3C369D5
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 18:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0714B805D7;
	Wed, 23 Apr 2025 20:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rKLcp7Ri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87CF38070C; Wed, 23 Apr 2025 20:55:58 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1FD380194
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 20:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72c09f8369cso105419a34.3
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745434554; x=1746039354; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6kZhC4vefljo21OzwyJxTvkR8+AJTYuC7/mVUVOsbbo=;
 b=rKLcp7RioN6IDwFlO73VyfALlzkYLSQaLLkBymlKwI0CLg6EfTKnwFAWTG/bw6bb2Z
 Yyvm5CDSZFs8J5MpaO6jckUgfWNs2VSnEUV4B8QsENuqaxr93986ooHRyzdQg+q+2zCU
 wC5rkIW5TNuNuFIHDRzJYbKAfmdJxs/qshNl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745434554; x=1746039354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6kZhC4vefljo21OzwyJxTvkR8+AJTYuC7/mVUVOsbbo=;
 b=qfbFLGWooTi+83u/12gLDREqQnxYyPsjrMXFbUYGx1KMC/6N5xMuNtcHPB/J96w6t0
 KQgnS+WU0y25u/TTEbOt3MD8BZ5dTnN8p7m8Og1u0Q3tdVgL004aUQCOSIHewUUdvN7J
 utbIeSkEsGRz4enDsellbiKYVOpL56/f7lmDocODByQ867raQB2rZEhSCkSJOeud8MZC
 mtIS0BPaJKxPWvRcIM0OeocuB3B4uE7pkDkSgVT5R66UY9a6Hk9panpTH6dnEEjKBDiw
 6eQsGfKoUbu+li/GzRqHhWh3t7+V9+9BQPrTYrEHAnVPA/ggXgyvALRlwhbXKgbI3rej
 Iqtw==
X-Gm-Message-State: AOJu0Yyy/G3bwod2ndS0R5mFIcvzFxoga5o7R9bZoVchxHvt8/rZPhf+
 l2mVZWsIfeppaUGSvRNoi/2Pa2VI9iFqHvZpL58f/0+liU3LHNrpDYyeIM9f+z0GGARrsp49v8c
 m6pc=
X-Gm-Gg: ASbGncslV0jLdgttlSWwqWMNRUeb4lDWGEHrGt3612inrJcPc6Fj+LtoL+ajPi7wNXO
 ro4Yw2ufr8Fj1w/ognOWdjyaoeDIPxPa3hj0gc8ZTNw6V2CywYKq5XP9p0KUn4ynHwjb51gLFdm
 LAY7Ea9WuIh1icuhZi1F7vaP/7aRsClwItOnehebbDNBHop+rGb/pa/XLbxVZd+pOk+lGh15w0z
 fUn9Z6w+EuHT8Gs7YAOCFp/tLXBXnmnZRWlGplFCToCrkRxyGFvsAsyvIMNeyBoZDvuCIc1rE5M
 4xXxcI2ACGNqJuDSe5ChO80Vg8y4vFwR8m26CYudjbhVvSdBxFhCwVPEH+gr5okHV/IKqx3k61e
 3zA==
X-Google-Smtp-Source: AGHT+IH9LEnPc60NOldl9yvBiR/p3LTbR3xxHMEXuyzio/MJdeQ5YTJ9TAnbh11Fv6Zy6gsmnJOP5A==
X-Received: by 2002:a05:6830:61ca:b0:72b:7eeb:93fe with SMTP id
 46e09a7af769-7304da81b14mr23008a34.11.1745434554613; 
 Wed, 23 Apr 2025 11:55:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7300478e34asm2616021a34.4.2025.04.23.11.55.53
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 11:55:53 -0700 (PDT)
Date: Wed, 23 Apr 2025 12:55:51 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: Community meeting tomorrow (22 April 2025)
Message-ID: <20250423185551.GG5495@bill-the-cat>
References: <20250421153042.GW5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cI6+jLye7awy0cOz"
Content-Disposition: inline
In-Reply-To: <20250421153042.GW5495@bill-the-cat>
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


--cI6+jLye7awy0cOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 09:30:42AM -0600, Tom Rini wrote:

> Hey all,
>=20
> As a reminder we're having the next community meeting tomorrow. The
> details are the same as always:
> https://meet.google.com/btj-wgcg-euw and the calendar link on
> https://www.u-boot.org/ and the dail-in numbers are at:
> https://meet.google.com/tel/btj-wgcg-euw?pin=3D3D1307528552322&hs=3D3D1
>=20
> The meeting will be on Tuesday, April 22nd at 9am (-0600).
>=20
> This is slightly off-schedule in that merge window is 3 weeks and
> release canidates are a two week cadence. Last call it was suggested
> that we have a meeting mid-merge window.

Here are the notes for the call this week, sorry for the delay in
sending them out. Please note there will be another one next week as
that follows the normal schedule.

- Heinrich asked about RISC-V PR as there's a number of outstanding
  changes, Tom to follow up to maintainers off list (aside: Done, PR
  expected this week).
- Tom noted that applying the UTHREADS series is on his TODO list for
  this merge window.
- Heinrich has posted an RFC of efi boot manager + bootstd, hopes Simon
  has time to review and comment.
  - He has found some problems for example with lwIP and PXE and things
    they aren't related. But the concept is ready for comments.
- Henrich posted patches to allow buildman to apply fragments to every
  part of a build, Simon was reviewing the patches prior to NAK'ing
  them[1], and it's unclear why. Tom suggested adding defconfigs and
  Heinrich has done this for  the immediate problem and awaits further
  comments from Simon.
- Heinrich noted Adriano has some patches for more network devices but
  likely next release. Tom noted he forgot to apply the hook patch for
  testing of these and will do so after the call (aside: Done).
- Daniel Maslowski wanted to bring up falcon mode and DRAM init.  On
  DRAM, binary blobs are used on some platforms, he's reverse
  engineering some of them, is there interest in this? This is for the
  K1X/M1/X1 SoC (aka Spacemit). Currently also looking at RK3568. In
  both cases, this is done in Rust and not C.
  Heinrich asked if the file format had been reversed and it hasn't yet,
  he's using some other tooling instead. Heinrich asked Daniel to RFC
  it. Bradley suggested that might be beneficial for a different
  engineer to translate the Rust code to C.
  - For Falcon Mode, finds this interesting for the Linux Boot project,
    wonders how actively used falcon mode is?  Heinrich noted that this
    can be used on RISCV too, as one part of this is just using a FIT
    image and that can contain opensbi.
- Tom asked Bradley for a high level summary on the re-licensing of the
  bloblist file. Bradley has comments, but needs to confirm with Simon
  first about a number of assumptions. This was tabled until the next
  meeting when Simon will hopefully be able to attend.

[1]: https://lore.kernel.org/u-boot/CAFLszTh29kgQ_bE8_gnORWH0PQ=3DH94=3Dq77=
57mFOfiopCUL3eTg@mail.gmail.com/

--=20
Tom

--cI6+jLye7awy0cOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgJN7MACgkQFHw5/5Y0
tyyuGwv7BIUzpzH1L6+PcfWS3XmLZ75oZs03OJ7IiUvhjmngczNVMp0IUloXYHAJ
dEA1MTg5DPl96QHTC3/eXw34uisLGM+Wy5Lgc3MiKigVo41MxNpBUgs5A9u3uU3u
XlPrTqY2ZrwgNL37wwJvLKUeGkokcgPRfAy1wisNe/75MvnraMkb51iPDwFCwixn
cHR4rUa+DjVOLS+hLozMaqhFrriBIuYGVac3WSfL4JonFyGhXzF3Bp4/WAbc5yTO
U84CY1Tw7i7MjIWYCOtzfJsY7TwPn5E3mIwCT3YYvqUtq+x8/I/XYmpA8yMAc9fL
jX1WguRJocbBQ9VXt5FjDad6wrwNyMUKWcQirXlgZzvdtbOf6Wiau1wOcmn/xqvu
lOH/+9agNYnNKFqUlythcRoLoPVWL51i0Qw6AWoVCRum/8AY4NEy/SgGlBWQwRmZ
5BwM9kTIZYHGVLgn8mE7LzzisDF+c1DgbFaFi3vIsqYJmBEWHHYzdCBPTCpU9X+G
UdKt4y+6
=pc6A
-----END PGP SIGNATURE-----

--cI6+jLye7awy0cOz--
