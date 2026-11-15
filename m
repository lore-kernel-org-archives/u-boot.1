Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391C606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Zm13EV+c;
	dkim=temperror header.d=sequanux.org header.i=@sequanux.org header.a=rsa-sha256 header.s=dkim header.b=02w0T9iY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4167480F43;
	Sun, 15 Nov 2026 19:00:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mnatvIhAuPvB; Sun, 15 Nov 2026 19:00:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5AD5580F68
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769257;
	b=MxuPHHsKCUUU1uHEZAlhdVtdDccYJ2LaeP1xeXgK5BKSChuvDmhHMhLpPVsYP6T+OEtp
	 neQ35aFuL0ImbaguMI18OiY+5ahQJi5kaW+cclmf7ClVV9qIb1V6FDlnVwXy+90+2SGjP
	 2+0+DhlHe5bO5iXfxw5BoPV4lUgttf5tlfswUWm3HUVXvCjWeAEqexN+AGx1Y15/syziz
	 QMrTqVhccFJoN6wBuSdILEHj9d0fyI9zY9Ur649bLxnHPRwvkG/zBuXXLpt/T1PN60Ta3
	 LXSY59Dm3EowWeTeggc/KfkKEkNzukB6cpIsqGjwuAIDywO0ay5T5Y9Xkh3qyvG3qlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769257;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Last-TLS-Session-Version:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gAGNasdKTi3iLjjMw2hwBQ+12IYRYFnMgfWPh+K6Wbc=;
	b=mPw+X3DbEWx9asfdxnQhyKXkVCfLiEqNnLVF3KeowQ/WUIDC00l0oYSMsS4XQe7N/nn+
	 GL9YXC/cRCvXkK+RceDDgz0MuP9sMO0hYa1wMSPKQoIxQ/s20AOwSxhpAtHWeDhrj05Nm
	 6zZlpJP3YeYBIjApfGfNIb6ZnFWbOid617tO4n4uMmMnyj6LsKD+5xq+DKwdArefWEMkg
	 hw5CBDoSzuY4DUgzc7XAaruvh/Aiy5CkTA2UKlb9p14PgIVe5v+gjReJmzl9UZmdQURDi
	 c4SsBcoUwxz541ARC64oql0FFwZEwWQVSxLWwh+TEBVNx+zLzhO8bkUj+fNkBQRmibA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769257;
	bh=gAGNasdKTi3iLjjMw2hwBQ+12IYRYFnMgfWPh+K6Wbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zm13EV+cz0ZssgWNI+H4MHXM81IfKzYr47rSIT643l0vRFnLm31IRSwrOYXp2oguS
	 Ls1+FiYyJtbT+ZcsohnJmgMJE6+6cANOZjIDCPeCgaO4n1BzYC+S5/t9xZi04fz2BL
	 pPZKheii0bDuCWrugLlCRw1ix2SOhTP25/wQsMZjSw4zQcM26tHSB+Sp11llFbyYhl
	 KyXTcTyl4S/sXY90os0mC8CcXZhlyGZLu2pqGY8zMpKoXTSJ/VKm7VvhSR7U3CpT0a
	 C6HI6rViehSfU5kTLeWEch9zx8evxnA0UBPAb1S7GqjKLX+j73iYcm6JLox1lNXZBO
	 eFEXXbmMBg7TA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AD5580F68;
	Sun, 15 Nov 2026 19:00:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A8B728C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37B0440644
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:48:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lOjhNj2zuZtt for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 18:48:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 155E340647
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=65.21.30.43
X-Greylist: delayed 440 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 15 Nov 2026 18:48:58 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=sequanux.org
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=65.21.30.43;
 helo=mail.achelem.org; envelope-from=simon.guinot@sequanux.org;
 receiver=<UNKNOWN> 
Received: from mail.achelem.org (mail.achelem.org [65.21.30.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 155E340647
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:48:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 930B788747; Sun, 15 Nov 2026 19:41:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sequanux.org;
 s=dkim; t=1794768095;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=gAGNasdKTi3iLjjMw2hwBQ+12IYRYFnMgfWPh+K6Wbc=;
 b=02w0T9iYkFiix7cRnXFGoao0AVjXTkRo1yH5MWIy/OsPkU5y318ff116km5ajZ4U/k0dmh
 xRg8SqAs2l57yvDPZqC4HcwBQHjbieELhjHK+hbBz3sV1kByrICIHpc5BcvNCcr0yDz+y5
 ZnamsT+rSFQjH/cip/EWKwdgelhsaKR5qbMtbLsnB0u063qJlNVwjZv8dgbTEizZI4vZH2
 qVl/PRNVpAC3/otpIFr+A+0lnHQ5FY1TjQoKaOdzm3PzVTX5JL80IdvETkOqchrflCTvaL
 wIyLnDR+YmHFWtrPFxSDHrgytcfE7bwD3G9fVp+p70vacPBE2CCSNfkGaifn6w==
Date: Sun, 15 Nov 2026 19:41:32 +0100
From: Simon Guinot <simon.guinot@sequanux.org>
To: Tom Rini <trini@konsulko.com>
Cc: George Kola <georgekola@google.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] configs: netspace_mini_v2: disable default netconsole
Message-ID: <avn83NoJA8ZKi1q7@localhost>
References: <CAOTQ16+AbF9iURWBrU6_NOM14KCq5-s1YFbbP9ULe0Ch0hhAZQ@mail.gmail.com>
 <20261115180628.GV554944@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G7d/4ZX6HG9YUxtY"
Content-Disposition: inline
In-Reply-To: <20261115180628.GV554944@bill-the-cat>
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sun, 15 Nov 2026 19:00:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--G7d/4ZX6HG9YUxtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 12:06:28PM -0600, Tom Rini wrote:
> On Sun, Nov 15, 2026 at 09:12:23AM -0800, George Kola wrote:
>=20
> > netspace_mini_v2_defconfig runs dhcp and activates netconsole in
> > CONFIG_BOOTCOMMAND without setting ncip, exposing an unauthenticated
> > UDP port 6666 console that accepts broadcast packets and drops to an
> > interactive U-Boot shell over the local network.
> >=20
> > Remove dhcp and netconsole activation from CONFIG_BOOTCOMMAND and drop
> > CONFIG_NETCONSOLE=3Dy so the board boots directly from local USB or SATA
> > storage by default.
> >=20
> > Fixes: 970bf8603b87 ("Convert CONFIG_USE_BOOTCOMMAND et al to Kconfig")
> > Signed-off-by: George Kola <georgekola@google.com>
>=20
> This is feature working as intended, presumably.

Yes, netconsole is enabled by default on purpose on the LaCie
Kirkwood-based devices.

When installing mainline U-Boot, you need a way to access the U-Boot
console in order to configure the environment for booting the OS you
are installing. The serial port is not always an option, since it
requires opening the case and using a serial adapter (that you may not
have).

Here is a guide describing how to install and configure mainline U-Boot
on these devices: https://lacie-nas.org/doku.php?id=3Duboot. Much of the
procedure relies on netconsole being available.

Note that you can disable netconsole support either at build time or at
run time if/when you don't need it. But I think it is better to keep it
enabled by default.

Simon

--G7d/4ZX6HG9YUxtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmr5/NgACgkQzyg/RDPm
szocvw/8C2ee11L7ylD3CjwQozViJp9JKxUP0a9Y9JfBp5iCUM4UQewtlZcJ/Ac0
Jq/UOqfUYZnJsUBjHvPdLTri2WoHzqhC+yCocHQOVhYUDPdPi65quKYxVaoEVdwz
urG9SwFqYS+Gw0MgEtkQzoPS+a8TkVotKSRbiTnZP4UnIBGPKMxVl30unKxBxTwL
bqoAEARiJtwdt6jsTP09TdoNnUf5H6cyT/HdVfAq4T2lQiDkaW8idg/y1aELwEze
oPwNVQoSljpEb9LImoIk0QyzxlXyvMpAM1C5LlyRJZ0NipJ3vJnYqzzmIj5UGpGT
BOT/kcmFqO7T6t7Vgc//BOortd/tE3l+IZYCv4H3szyDHt/fy6Wyc7BicZSrCVOU
hVx4m/X0j9zCPD/hRyu57XID46gufmh3AB6ZiweGEvFbBElAFw+SFbJI8dIEXbWj
T73BnBsf9lsi3his0P10+29phNfJE5Ukjqvw2lFLD8sB4pZnZJiFoWZFmtEj6Qsn
n+WnixaGl45WW67VSB58TRpHrKWDjobKFD4h6GdZwTt+T+IpDatos+fa+3iymDON
WmGqjCSCbLHiN8it+Q/SfbAji2xRDT26WIB+zLd1ZkxdpmcMacxduJTVOZ9W360M
po9aMg19ST7Q4aHMrH20OennMFw9IQ8aNwZAq94QaLZJzdLNLkI=
=ppv2
-----END PGP SIGNATURE-----

--G7d/4ZX6HG9YUxtY--
