Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4F1D49C6F
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 08:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF20E8426E;
	Fri, 30 Jan 2026 09:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="XxC6FTFN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D726842B7; Fri, 30 Jan 2026 09:17:56 +0100 (CET)
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19B5B8421E
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 09:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=vagrant@debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
 Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/ZMIXhCzp3YpElwmg7I792v/s57thx+sGZXn/AjuGEw=; b=XxC6FTFNCOStmGIBIuRR4Fy+xv
 Nxmws5r8wAxP3CsEj8Axh//CDcjwWCcFvzPqHoaS1dkAyOCtKvM7GsAJPgnzNpSV0SsvRAxukOYRN
 vRV9mBg2L1+Pqz2ijs0TO1fQzpUHyPkzJnJuS/5xS0+UwEv5AVVbpek9/10qUz9B33xTCLuOgW/Mx
 FDTcNwIBbXA6PSqgk7m+BWb63Hv6MmYUCT81ihuDcNoDWWkRSN2KCxReqqbzPhftonbRk6kogePiA
 AtaZna2A5QWVxjKU14/MC7rLIS+fY9tPK6ruAiL1h3aqV0+8kjnR2y//hEwjdMeC1EJNhZ/Nx1mSt
 LWkz2KLw==;
Received: from authenticated user by stravinsky.debian.org with utf8esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <vagrant@debian.org>)
 id 1vljhQ-001Zww-Tm; Fri, 30 Jan 2026 08:17:53 +0000
From: Vagrant Cascadian <vagrant@debian.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: rk3588 MNT Reform2 fails to boot from SD card
In-Reply-To: <aXwo28QQQ0IwjIBW@shlinux89>
References: <87ikcjc1oc.fsf@wireframe> <aXwo28QQQ0IwjIBW@shlinux89>
Date: Fri, 30 Jan 2026 00:16:59 -0800
Message-ID: <87fr7nbjlw.fsf@wireframe>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Debian-User: vagrant
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

--=-=-=
Content-Type: text/plain

On 2026-01-30, Peng Fan wrote:
> On Thu, Jan 29, 2026 at 05:46:43PM -0800, Vagrant Cascadian wrote:
>>Thanks for adding support for rk3588 MNT Reform2!
>>
>>I tried using u-boot 2026.01 with the rk3588 MNT Reform2, but it only
>>gets as far as SPL, and then fails:
>>
>>  U-Boot SPL 2026.01 (Jan 01 1970 - 00:00:01 +0000)
>>  Trying to boot from MMC1
>>  mmc_load_image_raw_sector: mmc block read error
>>  Error: -38
>>  SPL: Unsupported Boot Device!
>>  SPL: failed to boot from all boot devices
>>  ### ERROR ### Please RESET the board ###
>>
>>I *think* MMC1 is eMMC, which I currently have blanked, as recovering
>>from a failed install on eMMC is trickier.
>>
>>The vendor u-boot works fine on either eMMC or SD.
>>
>>Any suggestions to get it to support booting off SD card?
>
> Please check whether you have this patch in your tree:
>
> commit c4f5b1d4b037beeb538cf6dee0a16cd196539273
> Revert "mmc: mmc-uclass: Use max-frequency from device tree with default handling"
>
> This reverts commit aebb523a23818a8ee4199c9532b51e3d4020696f.

Thanks for the suggestion! Just tested with v2026.04-rc1, which appears
to contain both if I am reading this right::

  git describe --contains c4f5b1d4b037beeb538cf6dee0a16cd196539273
  v2026.04-rc1~56^2

  git describe --contains aebb523a23818a8ee4199c9532b51e3d4020696f
  v2026.04-rc1~52^2~23^2~7

But the behavior was about the same:

  U-Boot SPL 2026.04-rc1 (Jan 01 1970 - 00:00:01 +0000)
  Trying to boot from MMC1
  mmc_load_image_raw_sector: mmc block read error
  Error: -38
  SPL: Unsupported Boot Device!
  SPL: failed to boot from all boot devices
  ### ERROR ### Please RESET the board ###

There are 63 commits since v2026.04-rc1 currently on master, but nothing
immediately leaps out as relevent to my untrained eyes... :)

I could test the initial commit it was introduced in and if it works,
bisect from there (looks to bee about 600 commits between introduction
of the platform and v2026.01)...


live well,
  vagrant

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRlgHNhO/zFx+LkXUXcUY/If5cWqgUCaXxo+wAKCRDcUY/If5cW
qqoKAPwLlCK53GX9MhCLmonzYgF1AA+LYUhV3sSUlUg31CAkYQD+M9GORCyOPhrN
ANIPF+0K+mraJIQrvkC8UWdoRyN2Pw4=
=f4p1
-----END PGP SIGNATURE-----
--=-=-=--
