Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B09C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 15:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E6B88119;
	Thu, 21 Mar 2024 16:00:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jk9q3Ixa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7CE8744F; Thu, 21 Mar 2024 16:00:39 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86B1E8811B
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 16:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3c1e992f060so505943b6e.0
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711033233; x=1711638033; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eTTqUsL6CGIeHEpdOp/JRiamuFPD2DQ9rWuWEmYNSn0=;
 b=jk9q3Ixazfu4a1CYgnGHm7B8PQ2go+/dK2DsDUthNeW0Jyed05Zu1WUtsR0k3tG9l5
 QdtvGv5WM7gFLxz6oNpaN55CVSMo/GLXZFEx6cv14BsBt5MilNC5V0ZCNyqE11ekghUZ
 EvnhGb1yRpJ7SiZxeihOBbF8zk5H5r7WCRgek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711033233; x=1711638033;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTTqUsL6CGIeHEpdOp/JRiamuFPD2DQ9rWuWEmYNSn0=;
 b=hqV/mxx/zzLLqwAfvzOSaOGSeYNyvjPkGFKhliOPwf7cxSFuq4g+EhByhQ6hCrxD3Q
 SAHyVUMP7nDrCnYbk1+4p0HvaITUOYs7jwzibUyFB7M4DYvwWxvw2VXa7CZne7oEVgIN
 6oPICprfc38mbiYXjzHc8HBSYN1CmIN7Bb7RyoqccQmwMYvrjANPertY0cNGpYqypttc
 HWmZrA4IRVmVpCCJm4QEMYBiUPhcXH73CaRsbW3qYiZKIJjvgCgCK8H/RO0WMrinqTIs
 YUFWfxOh3Phd8XLurjB37KoioZV79paR+34uckpxXt4Rf3gTDhdLue4UhQCR3ijYSXc/
 EjnQ==
X-Gm-Message-State: AOJu0Yxe+pvaOV9mi/mEBgUZJuyy54AfghZNEgnmMAtkOV+YyUZoYYX/
 ioS1LNhEG/l4/L6gwoqnEn9JyMNmQtmxVpMZr+NC1BUNbBlno+rA1+FlAdO7z0Y=
X-Google-Smtp-Source: AGHT+IGmMCeMjnGRTAVmw8oNN1jEAoaw/8IuojkkXam7M94r3Ep3juf3gf+8VLMQ42X8TdZR/Y+Qiw==
X-Received: by 2002:a05:6808:209d:b0:3c2:6117:493e with SMTP id
 s29-20020a056808209d00b003c26117493emr2966647oiw.37.1711033233247; 
 Thu, 21 Mar 2024 08:00:33 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 bs17-20020ac86f11000000b00430d8ca2a82sm2714121qtb.66.2024.03.21.08.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 08:00:32 -0700 (PDT)
Date: Thu, 21 Mar 2024 11:00:30 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Janne Grunau <j@jannau.net>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: Pull request efi-next-20240321
Message-ID: <20240321150030.GX3442575@bill-the-cat>
References: <38662008-a812-4fe4-aeee-b160c4e59c12@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0dmu/gbGT89zQ201"
Content-Disposition: inline
In-Reply-To: <38662008-a812-4fe4-aeee-b160c4e59c12@gmx.de>
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


--0dmu/gbGT89zQ201
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 08:48:00AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit e50cb36cb5e772d5bbd30d070faedf73234063=
64:
>=20
>   Merge branch '2024-03-19-assorted-updates' into next (2024-03-20
> 08:39:05 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-next-20240321
>=20
> for you to fetch changes up to 884785adc1dc5e7b91acb542ba83941951ff2b77:
>=20
>   doc: typo Synopis (2024-03-21 07:00:12 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20011
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--0dmu/gbGT89zQ201
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX8S4sACgkQFHw5/5Y0
tyy1dAv9GJmfAuFqILTP+qHhyOTXfaysYplpmBlwX82P9YmPe/2p1mhsj5z9+5A6
7oL4JL0OTrDGmm0Kv2HSGt1LL2Gu6xVryb6j+9zvlcHNVfMu/MsQGow93wn81YHq
pDvm8HCAtwfXfn0tTmCUxi8Kw517ThW0mADMS+2pIPErUNE3k5RC0F6B56dvToBK
PKdBqMICvOTAMgiA3ZB9f4DmIi1t2/UgTcTNGrB2G5AsPtc9l3VjTXj4wxTrM2P0
/0jbFQfQZQ6IyU504+/WDJRIO3ABXYLh/KnOCbgArLknHGhJDbaRyuMQA5ABNOce
jvcQvSfzH4bU22RIBqOgejSXVNZ8If4WS69w6JITFl21lbH1XETLDtjY1U1ckNic
Cez6AKtBspLMAaf7HnO22H8rd5ySJkzAbEfyYK48unr9QPKKuCI2xh6QiFWp9k05
5N+Ao1KaMTrBYJdRNZvrtRPu7Kkh4Nf3M194PPY+4FRZgyX7a9S6mCziZJqzgbXa
O9EWq8pX
=sIWr
-----END PGP SIGNATURE-----

--0dmu/gbGT89zQ201--
