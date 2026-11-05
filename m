Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C10606A6C9
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Trov/ew6;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=JNemSzrF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2165240825;
	Thu,  5 Nov 2026 19:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uf3DlwhOqQah; Thu,  5 Nov 2026 19:42:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 250C640818
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793907720;
	b=D/t+L1++M/Iv7kbKZep2Iq4/Enuhcb8yfyJMfpRF9MvZ2McyVeCqCJzlblMe4FHxFwJz
	 JKThfN4k7wmhOGJXfAHS5HOEvBFYbhTP2P4pQICDTm9sz1yAEuylFxdzkLXO7sTPyKU+G
	 agXBcM9qtCHpMXlKyXjYEKtStLsUucYOQcXELXLfk4NRbSDGb6jeRulSAYc6hdkcexcVg
	 Y5POJljEdYoRxyJIPbm65g6iSvb0pXB6NFwbtxBx+crEhajSv0xXO/p6mF25S8LJoNWMo
	 B++ZsQ4usghdHxL1UAjWOxHUgs3WV8jUuSOeXNwaMgYnTwpgzYCXNAT2Xg3EgxTRtlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793907720;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=819G5jFnn6MpM+m8UjRRNMnlCOgmTnXObvgtZo9wS34=;
	b=EXE9Z2dMeFee49COIRP+My1wUXw06xrb/8Ac+PbW+MckaAkwpaKX1FWCPvjHN+2cVUgm
	 GaqDR+qbKdwOm4DujvpedT9+jvaUHqU/Sl8SUx9GoHWLWenhJ+dZsMenj7LEYXM91MykO
	 A1YdTUVastieRantk1CYAjkncvWJ507+z9YXOMqsKJh4tD3I66I15B7QkB6COtpX1F2iG
	 LAqDjAvxAxSWBur+5mkdOKdZ3hKnUOP24/MHLi1QYwrv2XFAN45ufYJPM9v1onEFQw10H
	 YXziOuxhAggoB6MtoOUwzQiSQIeFF93WRk0d9ehnlPXmx29aLXsT+oOX1kFEOoMvDsg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=JNemSzrF;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793907720;
	bh=819G5jFnn6MpM+m8UjRRNMnlCOgmTnXObvgtZo9wS34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Trov/ew60kMXqMY3MPiigUFwxx85K1MWXEqycmlm3/nQ1/O5O4yYEm5DQPEZHN2Vq
	 3AdBy3WhDNpNxvKoJrGQrGx+AOmaGLyxUNL6P3TnTp9lDzzAAq4mkAubhzDgL8nTb9
	 nBieiMB6FrNJB3MHtUq4AsTWbAOCIBeFKlyS9I+vCyIPyeZpRQldNgi3yUHQmMMchL
	 ypM9N7Ulzv1sAfA1SrYSHAPnQSRgxf6mA1tggnAiMTIxcp34U6MBLRoTUT2UDmR/YS
	 WcTiIn3oKouRURaZ/qOupAQoIAP42hZdeNmw5KgARLIytxPZLNrqXuCW2seiO2oJ9/
	 IOFHUOzWGOiCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 250C640818;
	Thu,  5 Nov 2026 19:42:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EAD372AC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D065240804
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:41:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MSkd_WTNo3Qa for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 19:41:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DF9E840802
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::8;
 helo=mail-oi2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JNemSzrF
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF9E840802
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:41:57 +0000 (UTC)
Received: by mail-oi2-x08.google.com with SMTP id
 5614622812f47-4f742fc5d09so685416b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 11:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793907716; x=1794512516;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=819G5jFnn6MpM+m8UjRRNMnlCOgmTnXObvgtZo9wS34=;
 b=JNemSzrF/A+20bHad3cIAGdPSOg2SngFUkQ3QnVArQ5BvcQWJAaPyuHEI/rytlzXB/
 7+YMTwPVDe9ECRVl1SEcQHTu2zq2iiI54jIo5vLfMrVaYJP8OWbE6R7Mlg5ZlaAM7VoO
 +te3hR02VIaJCe+5+pr6pWA6vHKIXDG+LW7UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793907716; x=1794512516;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=819G5jFnn6MpM+m8UjRRNMnlCOgmTnXObvgtZo9wS34=;
 b=ETu11LmuWljRUvcdwOdT8CRdMCDN740/C3ji+UuVtsObZq5OoC7dF9Pu/IuYCmpaz/
 tiDc9kR6XZquhG9ulSpb4/Rl4O7z783Gr+6ZjefbMpKtueZHl5YoKZgG5XbaRdy/waHr
 X8SisQkUSxamjBhlXcOXQyQ7fjOeYi+Lyhp/2sVSb+emLhXe1z/zYV3cxLSy9cV2OdJL
 oUqmscpkgqqJUvGDzXo/aP9VTqYLpnbNJXkDSLpUHmR3fsNMFDNncO0FvOUXBIFuFVcO
 N0dJXX7DRarX0oMOGxhMfzcljZ97fg9XcuXcZIx1Kv8O8yZ5GciLa2+1bAjfc089NIKp
 pWBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzn0NIyE4aBhlPF9/Qa0yjO7lLijmYBS9rNNot9fr0+j98ESv2zh/H447uVZfJ6ouaCDy09ezU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+M7DtqH9gx5shAaZ6dMQjT0c2kyHC97FzzqUiU3z9NkTk8lMLy
 xI5TSUmZ3Xa1J6hbuvKB/RefJElHkRmi47WHwmFUfhUfOgQy8Qdu9SZ1DdkMg84rlCE=
X-Gm-Gg: AYBFou1fSQXDd3gNiseO738YpAwX6CwIBWZFWSNE+srdvzE/NEXezv4UVZLF8vR2a9s
 +ABV1zGjP/oPOX3Ex/+ovvjhkw6f45aAJZCHqnrSIKsVZ4so4XrD+gvEEcfj7iPD8ouXZlU6AUd
 HN2sZ4Hd53IHl8hwiBoB+SuyLEuTRBMfrftMQa70WuXKBTLnc7WAnfCrv5txTU/kejojZl+awdt
 Ijv7IqmWX2ml117cCqINyA+iwurzA46sibUxL2Tk+gw70e4pQ0Rl1nrpLRRxn62vjN2WhkJPrAy
 VhVX3hGK7YlSfIkriEj/Uw/D1i2RpPunHhEU0nrZknFBwLtsyTHJsAIf/EKIsuxb5Y9gTjCABGd
 X/xt7T8bohDSZNHvNQSvuIhp9XR3hG8DWrVwwkTybfn0UbOtlxl1LNwy+1o+yINufq6zLQ00mLL
 i7ZbCS+flBc01vx69WsHmgH/Bp0lb84ZxwDg6gR1AjVDqtO5+oPfR9KUx5vaeNhtirJy8PzDsmp
 3W1MP2rsRUCsP8vrMwqYLL9hI/vzYY2AjtFhc71fUsqr1T+M8+NvKKPsCzDDxTmqFbJnFPH2wKY
 hXh0Ei1zECW6GEq7zMJFF4umWCo0cEQ126xZUIvf2Whj3qDeiTP9L/5myppoj8tNX0xlkwJibtH
 Nm7NVzjB9avFzTAGatcSlie+kC2vc+xgwjdqP0a5oCf4Pgjr7kIzBEJ7/9ZucPYAHCsoAsE0WYn
 lRZBzDE8hvj+kndN0L2Fs69yQ2wGMPgg==
X-Received: by 2002:a05:6808:5148:b0:564:3fe1:2f95 with SMTP id
 5614622812f47-567e13e2140mr140376b6e.56.1793907716160; 
 Thu, 05 Nov 2026 11:41:56 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9f9f8basm4979795b6e.12.2026.11.05.11.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:41:55 -0800 (PST)
Date: Thu, 5 Nov 2026 13:41:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
Message-ID: <20261105194153.GP1164024@bill-the-cat>
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
 <20261104142958.GA1112376@bill-the-cat>
 <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
 <20261105144209.GL1164024@bill-the-cat>
 <CAC928HbGeoLQuHjiDN+qBU7A=wLa=EgM7xQMppv9LvFh5kV_xg@mail.gmail.com>
 <e6f06550-772f-426f-8b43-da13b58b0202@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YPpegwSe/AkemA5i"
Content-Disposition: inline
In-Reply-To: <e6f06550-772f-426f-8b43-da13b58b0202@mailbox.org>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--YPpegwSe/AkemA5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026 at 08:10:26PM +0100, Marek Vasut wrote:
> On 11/5/26 7:51 PM, Massimo Pegorer wrote:
> > Hi,
> >=20
> > Il giorno gio 5 nov 2026 alle ore 15:42 Tom Rini <trini@konsulko.com>
> > ha scritto:
> > >=20
> > > On Wed, Nov 04, 2026 at 06:33:21PM +0100, Marek Vasut wrote:
> > > > On 11/4/26 3:29 PM, Tom Rini wrote:
> > > > > On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wrote:
> > > > >=20
> > > > > > Add conditional around REMOTEPROC menu entries, turn REMOTEPROC=
 into
> > > > > > configurable boolean, and update all defconfigs and Kconfigs wh=
ich
> > > > > > previously only selected REMOTEPROC driver to also select REMOT=
EPROC
> > > > > > itself.
> > > > > >=20
> > > > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > > > ---
> > > > > > Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > > > > > Cc: MD Danish Anwar <danishanwar@ti.com>
> > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > Cc: u-boot@lists.u-boot-project.org
> > > > >=20
> > > > > Unfortunately this misses some handful of at least TI K3 platform=
s. I
> > > > > think using qconfig.py to confirm which configs have REMOTEPROC s=
et
> > > > > before / after, and that they match would make sorting that part =
of the
> > > > > problem out easier. Do you have time to do that, or should I pick=
 it up
> > > > > and do a v2? Thanks.
> > > > I can respin this, but do you know which platforms got missed ?
> > >=20
> > > I lost the list, sorry. It was a number of the r5 builds. Perhaps some
> > > fragment got missed? But qconfig.py -f REMOTEPROC, with a db built wi=
th
> > > and without the patch will quickly show which oens it is.
> >=20
> > This is the result of comparing the two qoconfig.py outputs:
>=20
> u-boot$ git log --oneline HEAD~4..
> 1e29311663e (HEAD -> master) Revert "remoteproc: Hide REMOTEPROC options =
in
> REMOTEPROC conditional"
> 97162e533ca remoteproc: Hide REMOTEPROC options in REMOTEPROC conditional
> df3b8e16e6d remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC
> d1d45c926a5 (origin/main) Merge branch 'main' of
> https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv

Wait, your new patch didn't just replace the old patch?

--=20
Tom

--YPpegwSe/AkemA5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauzb/QAKCRAr4qD1Cr/k
CuZMAQCWGnLk0MIrqRdzmbg7t8QPYU1K82iB13lGgsW3VAxa2AEAo+oHLaIE5v2x
AeaPeW+Xf5bYBYvNkTFAn9knfQFabAg=
=z5K4
-----END PGP SIGNATURE-----

--YPpegwSe/AkemA5i--
