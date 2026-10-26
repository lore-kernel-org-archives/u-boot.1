Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC99560A2613
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gsTzBn+s;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=fFVjZoX0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2E4480BA6;
	Mon, 26 Oct 2026 19:18:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yNItjtk-RvXH; Mon, 26 Oct 2026 19:18:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E7C4380C11
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793042306;
	b=AIAl8Hj7FoukvVZeJByID08/u3s//opL7HXCtBuNH/5bNmXCuvPmF3QMMH/tMvhP2W5N
	 qLf0X/rPhp3WvvIMxpQDedqg1HpoZ0y/d47pz52tfDgGxuyo9B/5NBEJRU9YCZdWvAOsd
	 9wR7CLfai/ObYhOoXG5FwaPMt6b5suhnnJuG/zx2BPsHaDXGD4KcLHoGDcTd7xuRIItKS
	 c4QSKXuuyCXsgewLfAKQ8dsovx7IsBdmxH+HJdN9R+en6TOcOtl5+of/akE3vV7u247Yr
	 r4hjxqWjGFXN9+8nw2iw86xsCNVaq0UacC8fFeKiOT8t8MnKObnf+aZ17x9A8pnH2Fw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793042306;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3M4q9OMG3/WOeHP8MDwcbjdta+OzqHksIRAFWuBDnHM=;
	b=Gtmu0sircXRCt5uWAtI58F+ZA2GLhK2+knW9ABqJnXbvGnvjIrEdnlPgt0eG3HdFcKCA
	 wshJzQaFl9BiPk5YPvukmRKDIE9dp9wRtXg5vZnhePdANzFwezDX/5v93JDedYcJLNNTO
	 4+HtQ7Tv6Ey+lnqGkVGk3y+xX+mF5/mH3P5Nk7b8qQCZcv0V8h1/+zaFCOZ8JikhPctpE
	 dB+7okYeXXPMxX4bDXuN2Oedc6YBH279bBV7ATBjRxtBym5ZmmG8V0k1J/MvaZiJT/wkK
	 XKdQeyvkwC4FotFCO5/8Yc12zQRcunEK11rFzxfPzxB7DSjGqmbfhhy3jIW//nCfiEA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793042306;
	bh=3M4q9OMG3/WOeHP8MDwcbjdta+OzqHksIRAFWuBDnHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gsTzBn+saj5MScsn5EHGv3phGpYWvessOOFNQHMsQAbdN3O8Z58txF67J1kpx87Y0
	 hPAJ+JbYgIe04BKGvsm+C/HgBwHen+c2E+BzmuKqN7a8gcXE4G86ugvOHn5/nd8jAF
	 DKzZlAswVAB86ICsn9KNXv1LH44Hd3lESH3HBIht7L2JvuE8kyzzfpIR/iyij7Hsl8
	 TbR+bw1ffjb0rYvVabugHYlzZlOoK4fK92AzJ2Zt4X5fchmn2sCPoIJsraYjmBGxX4
	 I9BHFbAYt97Q61CXGUHva5u1S9yYV1jgXd6Perx9Rmv73SouPR0Nr6ths16w2ByKCv
	 AqeYx3qwZgGxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7C4380C11;
	Mon, 26 Oct 2026 19:18:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 67398380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 19:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D3DE40505
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 19:18:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cdgtyT8ayfUr for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 19:18:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7682D40501
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793042303;
 b=En2r5L4Z4L0ZVp9KcLFqu4gXT9hXXRKVDwjW8MmYZS0KtLKXLGP6rBU7qPbcC3y9zA4h
 MmALWjjInm/aaC100cm8JZZtVG/u7YuYbKYUywiiioDMXi752dgQq+olFP/ABnIlazcR9
 tGkioKqiv59co+TCggBB1eatJ3LYRPpOQL0VaaZp/EGMauzDI3MQcuUsLX+J1wk0BvLXV
 Jh1mIDKT3SANRsLPfIJ2jx3xUyubEgg0M9D8C50VbhCt6OpaoG/Fy6OjF78es414yuls1
 aV2vaS3GqizlCn4boUt/B9/CDv6EUda8HDSeSOOY/kCF1bOdKi4XJUPUcxN3o+OBSsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793042303;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=3M4q9OMG3/WOeHP8MDwcbjdta+OzqHksIRAFWuBDnHM=;
 b=XXDy/pTmRVEaOSUKXxn7DBLhXpJbu0Rac8yS4wsVmRlO4fwlje0J8Hdv1TiarfTzx09n
 rJsnlxeL6ei0vAXtCMB72fpCpsmizWY+xjPprwmejoYTnOscG5ymLqDXZgu37o7SxjRtZ
 nY9ZoeLog/VasGFYFnAXyec8QSsD06HQR1+Ren6iZ2qlK+njSkqhYSY43IHNSVWpCdvye
 8LUK2/o0NA6amBgjHeDa2JCbwztpTDQh6oC6+Eu0gaMshT/TYuv0sah8oFa4DaX1EQqS0
 kkom+I5L40tpCprQuIeOxsPpSdFpdScT2BbWaKuD2Sj/iMUHpvjZ01ZN09si2WNtNYg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fFVjZoX0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fFVjZoX0
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7682D40501
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 19:18:21 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6fe4372c5f3so2440864eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793042300; x=1793647100;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3M4q9OMG3/WOeHP8MDwcbjdta+OzqHksIRAFWuBDnHM=;
 b=fFVjZoX0fcu3p90RRmaxv/FFlA+blVOkOE41j6Q08YS8fEbQhfG1Rg6EOrRwMM7YXt
 /IbIFMU+xDKlT5DOCNbMXqbciHOOVSj5uy8SaCfQLUlAC2FRjAEZMK3mnaF+3v37IxDS
 OIl4xy4EDzs6MT6CGsuzec6aN7yqbJJB2nniY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793042300; x=1793647100;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3M4q9OMG3/WOeHP8MDwcbjdta+OzqHksIRAFWuBDnHM=;
 b=Pqx2yl4+qRSKTnJnWYY1BgqwzLpeukbG7ayoTmxaJO0iWArjaq+aUzVUYQ6Q9kpLDF
 BgL8RUmflv+e8LcJJbwih1J8l8E1shQGFjim1qfS5sLv5BBhZSwSjLFCV8Kh002ui4EY
 +6yGEvO4DP8F7eAQCRH86kqR9FG7hOZBKLiC9hjG2HHEEbagizHmdP8c0woQhncS/piG
 Iv+iO/+NvlSYVVtjjeM1q85pq/+tmjB5TREazuVq6T6dfO7/2zhqMDS+vtyYC1Et8+4j
 BKZ7/tCM77+cqGVnq8gm6tglYcjX/MinqlxMcZErszzs92lLX6WlCnrRNN3LMG9pcpET
 oW0g==
X-Forwarded-Encrypted: i=1;
 AKwUvByKdnUnxJBXYQbp/SCr//tXh5T0qocSK3EXkQHl/1hjl+n5ha7HfE4Qu/r/qdQ0nlxxmeAarE8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLZALY6O67Mn+vPMGBWZqdG6Aef/7dblmWUOUlj5uqQOxNY8dQf
 Tec1rDC42Xl4aO94h4usY+yFhbU7xWk5XhQBD7CEsE4JRU94KSHiIVGmOjcr3sxWL0g=
X-Gm-Gg: AYBFou3w/pUuGw/uU/zQ5s+E+IFC9v/yfRwqFNV3DzaL+Iilaese0ReMLN7uxliYj4E
 5u81jUT3wXUPEMHsnF/IY6T/QnjexQ85t6j6taR6a3Kz+yxH1pdj7vAmj1sfFzhhVGqRAXSK5Pu
 lnfwTC+oxKjUhv30ASXVx5G1oOxhBtQ8EPg4XcC8sV4z/Wv4Wz3ZKvUV+LqgNi5rCArD6RinC+o
 tUpKA/n8DsqN/ngqnVwB5RygHHsPMejy/UY3z0pu0WWSzBkJGxIAxcmAwivGcpEAr5kZ1ivlMl3
 UokQkvC0v0qsWFvOmdEIIYuIH4FU8gdIoagSHMMJ/RCBfrmJrP4jDW4sOtZ+YXOo/hMOcnI9Zt8
 2ZOmdNHnoM5J2YhlrxUu3N00FizkUPmuK0+RHLybUM6JUBtAfD91RhImiRnr6i/8Ul9IwaqFdrF
 c0EZhkRu84e9GOMl/W8fg2KBDId9G77z0fcVYe8aoyaDdUfNtTWwQTpjIGbDenmaDLsEr+mK6Oe
 QYxXmszz+jSt/+MmA1Wn5gZYgmnos7K6OT0QgPzJT2zaeSTNlU0W32N1/oKp5fanqprfJEg407B
 q7tyvcghxG6Weecc9R1JOCUuT9JGIDZ2X90ZfwPibarhS3Z29SbdCXNTn1RBI8ubHSQ74+EXL+/
 +u6Dc1Wc5aMUMOLoJ5Z0VMq1h5hyFyfIqZkkUQnjRVytNo/+cvQSWaT2jsA==
X-Received: by 2002:a05:6820:a294:10b0:6f4:d9d4:393b with SMTP id
 006d021491bc7-70ba0b2368fmr2926625eaf.2.1793042300291; 
 Mon, 26 Oct 2026 12:18:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9da521b6sm8234619eaf.0.2026.10.26.12.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:18:19 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:18:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH] board: qemu-arm: keep U-Boot below 4 GiB for 32-bit DMA
Message-ID: <20261026191817.GJ646438@bill-the-cat>
References: <20261026-upstream-u-boot_qemu_arm_b4-v1-1-223dd8060db0@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y7arXoBfgo80S44t"
Content-Disposition: inline
In-Reply-To: <20261026-upstream-u-boot_qemu_arm_b4-v1-1-223dd8060db0@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Y7arXoBfgo80S44t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 07:44:50PM +0100, Igor Opaniuk wrote:

> U-Boot relocates itself and its heap to the top of RAM. On the QEMU
> virt machine that is fine with -m 3072 and below, where RAM ends at or
> under the 4 GiB boundary, but with more memory (e.g. -m 6144) U-Boot
> ends up around 7 GiB. Every buffer it then hands to a DMA engine that
> is limited to 32-bit addresses is unreachable by the device.
>=20
> The generic SDHCI driver is such a consumer: it transfers via 32-bit
> SDMA or 32-bit ADMA2 descriptors. With an emulated sdhci-pci eMMC on
> the virt machine and 6 GiB of RAM, card initialization data transfers
> fail silently, the MMC block device never probes, and bootstd finds no
> bootflow on the eMMC: autoboot drops to the prompt with an empty 'pci'
> listing as the only visible symptom (enumeration not yet run), while
> 'dm tree' after a manual 'pci enum' shows the controller bound but the
> blk child never probed.
>=20
> Clamp the usable RAM top to 4 GiB like other boards with 32-bit DMA
> constraints do, so U-Boot and its buffers stay DMA-addressable however
> much memory the VM is given. The OS still sees and uses all of it.
>=20
> Fixes: f37770c7707b ("ARM: qemu-arm: Bump RAM size in AArch64 MMU table")
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
> A single fix for running U-Boot on the QEMU virt machine with more
> than 3 GiB of RAM: relocation then places U-Boot (and its DMA
> buffers) above the 32-bit boundary, which the generic SDHCI driver
> cannot address with SDMA or 32-bit ADMA2 descriptors, so an emulated
> sdhci-pci eMMC silently loses its block device and bootstd finds no
> bootflow on it. Clamp the usable RAM top to 4 GiB, as other boards
> with 32-bit DMA constraints do.
>=20
> Found while bringing up an Android boot chain (TF-A + OP-TEE +
> U-Boot AVB + eMMC/RPMB) on qemu_arm64 and raising the VM memory
> from 3 GiB to 6 GiB.

This is another case for LMB_LIMIT_DMA_BELOW_RAM_TOP too, isn't it? In
this case the generic SDHCI driver should select it?

--=20
Tom

--Y7arXoBfgo80S44t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat+ncgAKCRAr4qD1Cr/k
CmahAQCye4UWRsUjMtHuZKXWAy23w6O5qZtLl1Zt4xVHVW+nQwD/bFFS/m8/Z408
RR+y/lM1MUzWkQ7o8CWxZ9Qmh81F5Aw=
=tBbH
-----END PGP SIGNATURE-----

--Y7arXoBfgo80S44t--
