Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB7EC88E7D
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2843C80A84;
	Tue, 15 Sep 2026 20:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KUuFtuWsNJ_P; Tue, 15 Sep 2026 20:01:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3A99C809B7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789502517;
	b=ROqCt4K9lxMugw/mbpNiQuc/jGTCbFPDBXji+YXtHSF8W3xfbAmWcj+LjKCrt2+Fbcph
	 Wj79y1vTo6jkswIXiICdoyqFCLSocc0HNLuxu105uRr2ZFoA+lg68iJ4ikW/XyaCD3KRY
	 43ODJbvz3lNqStTUiUeujUyUnIZBrTm/Cg/uNc7HPk1gRYazlvp0PDymvx2seLZfNAQcx
	 igFlFUhCoatzeDS3eUDbz1pxVl7skP1x012ixeNITvDLp4ZP+KxenlTxy6rT1mWDhA4ER
	 Y6h9nvqavEXvGzvCIULXFgy0ZnZW3eJeTtdicLw6YfxOoTvXDl7pnekjqdQSYr8c9rw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789502517;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4u3Xzw6NdEQRajA/8xaQQMJxWemennZWJYIcg71P6Ew=;
	b=tApzkfBhN1/37xcdnBqcqL3FZkwiz4nFESJ/dFbb5wiM5LVC9Kd5bLB95EFkU8ZmnLEb
	 3T7mWIAfFodLmO+lDCjzi/iQenTFq0aElt4LV+H2tCPilEW3urZLQEPJbNBO1IGsLq7qf
	 0ollhQEDL7HpMknbrxDJKtJVbiXzBpIAX1tXkPWAVjQwBjU98oQsLG5Nesv2H12il+MBX
	 Muw/xk6ALov3wuzggtcfE/Ij2AQzHCuna/39KV3W9Ne/dMoQF+tmVNQVYvCaba65y53ta
	 nTvRE0Nz28s32432lABweCYWNyf124bO3s01RM8UN28Dne/iB9HlKIkG3WB3jYhi9hg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789502517;
	bh=4u3Xzw6NdEQRajA/8xaQQMJxWemennZWJYIcg71P6Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oK3GtWI3Oft3tr/n8tZZ61LSA1ydVev+MxuZvpQiB2OWKbyD8YxjcPagIUyUIru6L
	 aNSkK1JAL2pD2cCmIfhGpcjWFQdQXlgoguigjnOo13mqEXK3+DwqC23XnMVs8NDNWM
	 lJxB7i0pnmI38WFdWk1peWcDy0MxwRHN+sPBvGWXlXqvBaD0TQvumv/uyOyp6QyiPt
	 PfmLtkQvj6ln4UhMDFD5E/PO2jw/5ieKE+r9PBzLapuQPi05+uOVpFys6xUdJTcSkz
	 eogRc6CrHz368L2g0322Fz9lXHFxlTvmr5jipVZeeGt8OpwS1NJz/xAOZR43/0WNdm
	 j75ICZfGBEodg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A99C809B7;
	Tue, 15 Sep 2026 20:01:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 60551352
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 519DD60761
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:01:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f-wGP5gNDR5K for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:01:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6DC0E605E0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789502514;
 b=ZfkfYiK2LcEpz79lsGIPWPWb6OdqThDf39MyNIgfRc/v5hmusV++quM9wtcplIW5cCbO
 VtxJj3OonkztWdfKaDds1PiWQD52qSvkrgjaKcrGW1Og0aEnOA3HINazE9k4WDyOaneLn
 uiKHYb+A5k7WJU2wqimEGEReXiMwuremLonQ0Of3LCMdX/NToooAe2rNQoFH5vMmFIeA3
 QFPeQwayMFTmiE5Ah3Bm9PExcbBsRvUwFfMmHl3xkajCeN/In/wIvZGisyUGauwaXoqvX
 ifF/VZ50DOoirFV7UXZZqaf77kx1hQTcp4mbE5e3CSFoBCH1jktcw7kTJr78K+Pq5ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789502514;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=4u3Xzw6NdEQRajA/8xaQQMJxWemennZWJYIcg71P6Ew=;
 b=IrhJWbtxFcTeSrSI2/J2TFsxwMfdZJBY6rzLrYXQzq5EwZRM0N7lFdiiYkwZzBM2pvtR
 6MCLooS23VwqNpoKa8o4DjNm1YPkIC3IrynSVuSQijFP+LDxTbSClFACm+L6iQqqaAzBX
 JehUFjLOX5orsVZwyIZkL6zuCjzfcgiNChNS9Z7O395+vkpDZ+iEhUUUl9UwKHPcmc5qH
 OTuryF5iPbhCkLdaa/meNCFse6Ljx3vGjLE2OklzQEiKf8GHmP0f5XzvqCpXAVgNVYXrE
 chYqfDA7ItDLKtXwPlw5oZ1+CjrBQ2TmvzWp6ZafFSYBBrTeHhPqMohrCc+kE8BBIAg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="roYr/WQd"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::1d; helo=mail-oa2-x1d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=roYr/WQd
Received: from mail-oa2-x1d.google.com (mail-oa2-x1d.google.com
 [IPv6:2607:f8b0:4864:30::1d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6DC0E605E0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:01:54 +0000 (UTC)
Received: by mail-oa2-x1d.google.com with SMTP id
 586e51a60fabf-466cc88a0d7so168779fac.2
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789502513; x=1790107313;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4u3Xzw6NdEQRajA/8xaQQMJxWemennZWJYIcg71P6Ew=;
 b=roYr/WQdi21ZX6Yrc89L4e3eW7qNLWPQbDp6lu7OZuY08vePlun70P9UIDDIFAGU+t
 /QR1ravdDabMkbJOLWOgsALBf5dR4vUYDYbQrDoKb9lg9GeUriF7AuvS/Xf6tO3aiqfZ
 MsiTvBmxM+lJZFtLnoYQVuzIPQEQ6AAxxBuFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789502513; x=1790107313;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4u3Xzw6NdEQRajA/8xaQQMJxWemennZWJYIcg71P6Ew=;
 b=pFGJ2lld6laQmQjHLQdIB5Vg4jl2eWOaxvRkxMxqlThC5zrUoceFpClsC69HrWMCBt
 JZAq5HkQhw6MehxskVP6PcE/CuYaz27hCMMf6XRnNab5VKyPD6rU8yogFeo20W+p73hH
 wIEED7vrQUWP7XJdu6meo4/IgO1/Mzp3ihR1bHM1da3rlrlbI4cCehU/oyI4XlIPBwDu
 ZaosVDWa5eCJ/ArZ22JLKCotigX2XRTWUAeuCfrKqNUe3jAdoK+w2TZ+XU39K54rSRno
 x8mjeGBLiO0TWoJd887CYwFiNmo+e8UlwzAlWA5NV/VnlDhVuqV3o9kQzKb+U2WLGUKo
 Trdw==
X-Gm-Message-State: AFuF++kx2pox6aBD+16m5D36IrSpBVg4N8zkOnCn9WKiSg0KDAE1iMbR
 5Sl/7QybjQGzuGGf2lMFrlUUUY882czh1iWJtjyUkDWwry2fE8IB7EL2Eew8n9KCoj8=
X-Gm-Gg: AYBFou2fps4Hl0qjU/2+xFkajfKNOYVavYBa9rRaiKoS607gP7obF+9DxwUvbfzlCcg
 gPFmF6KvLJzOMfl4rep33kmxbsAxySh46bxjLauQ2Rjqxny3lHhJuXWHleAp4uEK4YWJWEf+hh4
 hMWvzGjKE9hxEYpDxwG4zPqibb5G6D1iqt2mfV/GQB9Qmx7U6KGo4i37yf857HJEtKn+UEhdhmD
 bXqXbsZj+jKT/2TqXCbhpInlLKqKALzlE1UQ++UahTJH4HgDBGpgZEH1YMoDaqnLNik9UPp6gJa
 EPK2w8YeaN3eOkFPSDxtTWOomjE+Eidf9WO6cy9iGwLqFl+f6MUbnqui3n3DV6FroOuH9Hnz+PH
 D5dJt5BV+TE0qYKOdbrlbqxUfuia+bvsQRMarj32i7V/aaoKv5c65RpdhoL+EeoXovaGIilwn6v
 zfQn0sX6m9oAvS42fBqaxMFDBBh7UnEBf/T20Izr+mLILVEyudETA1hAGXFXE3f+TlX65dn68uy
 kcUgmGoBVRRfVNqzsxb5MWX29u+XcddKrOxyfjlcuBsa9lz2Bz708HJJsHlIzn/JkSqyx8S/PS2
 khMOaSJ/ec+3szQb5Rls
X-Received: by 2002:a05:6870:7a0b:b0:463:ef96:b995 with SMTP id
 586e51a60fabf-481f7c2f750mr7337429fac.8.1789502513073; 
 Tue, 15 Sep 2026 13:01:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48429cf9b1asm885457fac.8.2026.09.15.13.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:01:51 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:01:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Sriram Sriram <sriramsriram@linux.microsoft.com>
Cc: u-boot@lists.u-boot-project.org, jerome.forissier@arm.com,
 ankluemk@microsoft.com
Subject: Re: [PATCH 3/4] net: tftp: use bounded string compare for OACK
Message-ID: <20260915200148.GD858934@bill-the-cat>
References: <aqmSGDU2o0OawMEc@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QWis+FsHmZoNbmDh"
Content-Disposition: inline
In-Reply-To: <aqmSGDU2o0OawMEc@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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


--QWis+FsHmZoNbmDh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 11:44:40AM -0700, Sriram Sriram wrote:
> option parsing=20
> Reply-To:=20
> Bcc:=20
> Subject: Re: [PATCH 3/4] net: tftp: use bounded string compare for OACK
>  option parsing
> Reply-To:=20
> In-Reply-To: <20260910192538.GO1764417@bill-the-cat>
>=20
> On Thu, Sep 10, 2026 at 01:25:38PM -0600, Tom Rini wrote:
> > On Wed, Sep 09, 2026 at 12:20:15PM -0700, Sriram Sriram wrote:
> >=20
> > > From: Drew Kluemke <ankluemk@microsoft.com>
> > >=20
> > > The TFTP OACK handler matches option names in the received packet with
> > > strcasecmp(), which scans until a NUL byte. A malformed or truncated
> > > OACK packet may not contain a NUL within the received length, causing
> > > an out-of-bounds read past the packet buffer.
> > >=20
> > > Replace each strcasecmp() with a strncasecmp() bounded to the option
> > > name length plus an explicit check that the name is NUL-terminated at
> > > the expected position. For the "windowsize" option, whose name and
> > > value extend beyond the loop's "i + 8 < len" guard, add an explicit
> > > "i + 11 < len" bound before the comparison.
> > >=20
> > > Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
> > > Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
> > > ---
> > >  net/tftp.c | 13 +++++++++----
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> > Does the spec/RFC ensure that we're being given a NULL terminated
> > string here? It certainly makes sense to be using strncasecmp here,
> > but since we're a size constrained bootloader, we do need to find the
> > right balance between defense-in-depth and potential exposure.
>=20
> Yes.  RFC 2347 defines the OACK as
>=20
>   +-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+
>   |  opc  |  opt1  | 0 | value1 | 0 |  optN  | 0 | valueN | 0 |
>   +-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+
>=20
> so every option name and value is a NUL terminated netascii string, and
> the last byte of a well-formed OACK is always a NUL.  What we do not
> have is any guarantee that the packet on the wire is well-formed --
> nothing in tftp_handler() checks that before the strcasecmp()s run.
>=20
> On exposure: it is real but small.  strcasecmp() bails at the first
> mismatching byte, so we only read past the packet when it ends part-way
> through something that matches an option name, and the over-read is
> then at most strlen("windowsize") + 1 =3D=3D 11 bytes.  Those bytes are
> normally stale data in the same 1536 byte net_rx_packets[] buffer (the
> receive buffers are one contiguous pool, net_rx_packets[i] =3D
> net_tx_packet + (i + 1) * PKTSIZE_ALIGN), so we only leave the
> allocation for a near-MTU OACK landing in the last rx buffer.
>=20
> The nastier case is the dectoul() right after a match: if the name and
> its NUL end exactly at the end of the packet, dectoul() starts past the
> end and runs until it hits a non-digit byte.  v1 of this patch does not
> address that at all.
>=20
> So I think the balance you are asking about argues for a smaller patch
> than the one I sent.  Since the RFC guarantees the trailing NUL, we can
> check for it once instead of bounding four comparisons:
>=20
> 	case TFTP_OACK:
> 		/*
> 		 * RFC 2347 requires every option name and value to be
> 		 * NUL terminated, so a well-formed OACK always ends in
> 		 * a NUL.  Verifying that once keeps the option parsing
> 		 * below in bounds.
> 		 */
> 		if (!len || pkt[len - 1] !=3D '\0')
> 			return;
>=20
> That leaves the existing strcasecmp()/dectoul() code untouched, covers
> the dectoul() calls as well as the name comparisons, and is cheaper.
> net/tftp.o .text on am335x_evm_defconfig (arm-linux-gnueabi-, with
> CONFIG_TFTP_TSIZE=3Dy and CONFIG_TFTP_WINDOWSIZE=3D1):
>=20
>   3222  unpatched
>   3246  v1, strncasecmp       (+24)
>   3238  trailing NUL check    (+16)
>=20
> The one behaviour change is that a non-conforming OACK is dropped
> rather than half parsed, so we fall back to the retry path instead of
> ACKing with whatever the loop happened to pick up.
>=20
> I will send that as v2 unless you would rather not spend the 16 bytes
> at all, in which case I will drop this patch -- the other three in the
> series are independent of it.

Thanks for looking harder at this, yes, a 16 byte increase seems very
reasonable.

--=20
Tom

--QWis+FsHmZoNbmDh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqmkKAAKCRAr4qD1Cr/k
CskIAQD55zS0SSaKU61PGg9T/Lj6xrYrn/Wl+7NgGc2tagOEsAEAwwITSFt9NScN
tkUXWeUYYFMosDSViCqy+NMxT1Yvegg=
=9Abw
-----END PGP SIGNATURE-----

--QWis+FsHmZoNbmDh--
