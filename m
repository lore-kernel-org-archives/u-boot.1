Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B73C606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wPtcznU8;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=UtN8PH6R
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A56081138;
	Tue, 17 Nov 2026 14:29:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 10hf5RS21Z_k; Tue, 17 Nov 2026 14:29:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8482781132
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794925779;
	b=jBYOdjATpCbI3be2BOdlbP2FSEWUqZeHcSZWP0dhqJUc2raH4FEHnEvyCq/X/QBVd7ec
	 gdpEz9sXCHvaMTP02VPqOQIKIxGy6qfPXuMIwNC5159C3YKIQgagkAt34yT3/bRqsWaNJ
	 DE0+NrP0KQ7qg14LMatWKuvRDQ9h2NY9z/1Oh/PVFJKe5N5zJ3fXyMGUuVHb5B0WhN+R7
	 h34HEUDxIrgH9BNNk5mnmZya6K9YvVhfMesP/Kh2ptCt7ypG0J/lsjxz3Vl1jDURf7Dvn
	 ZHqJYM0DioFkmHctI9VX0QR39e5lhyiUiFwlMloTYFDKrPC9jaH3Upckx0YoKbDJIyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794925779;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7k8oZK14XtN3uPaseTRbDc1UJ/hKoH3/S4/Zzhyu5ws=;
	b=E7ouID8wh7c3fsJ+3BW1cQ/YpHOKJrZbrcS89wxio3UBRKD9lz0l0Gft/mHfuTHRN56k
	 dQjabbGKuy5bFaQk1L+p82NlWZuCh1F0seJEDnB+SkpcReG//otKLf9TDQGtyRN/5y6Rl
	 XHkRnKb/cNw86znfiGq1A5NRdOReaKSwka/iiUpfyY5rOEO5MuIMFHCAuE+4xuIhcoHDc
	 YMlTxNi9avprLK/fecTAh8Gbq54l5zK6NcBBvfbBdJxkTnyjsIPGPBgPnBRnozOy7e2DC
	 7erniZX8tkngqR3mn0KwxNRA9oU3LdtJ5/6FDcZcRtDWOH4PSQtmN9+nxTS8Pga98GQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794925779;
	bh=7k8oZK14XtN3uPaseTRbDc1UJ/hKoH3/S4/Zzhyu5ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wPtcznU8/GMWRlBSVFWs0M4kMgnxXTODUNFh4rjttyRVDOPKqlh90RwAIAai+aM8l
	 kgcE39tMUlkeWZKFFughsyt/NOQ+Az+X9DJwG/BxQADqtTDZLd1grOuhmve/ZHqZFM
	 saYwtCmd/8VqWjUwrLBqY/aHcvp0V53IaZXrRMMPdqlhBusaxRVGl0VxbFVa1n21S2
	 NvR2fg2KnOW6kUxiHe64Tq2xk2r62vJDKu8kh+ofcDKYFTDJK6eFdNy1cnkt3AUneA
	 3ewIHAnfU9KJUjytdeKrkszQmJAowM5hSO3BBq5BxO++Ao1ghwN7iqJKFzfvB+lC24
	 fH545alOv7duQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8482781132;
	Tue, 17 Nov 2026 14:29:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3AED70B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C59C1401C2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:29:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VqFwlnVS6JvK for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 14:29:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 05982400FF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UtN8PH6R
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05982400FF
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:29:37 +0000 (UTC)
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6798af41644so3498286d50.2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794925776; x=1795530576;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7k8oZK14XtN3uPaseTRbDc1UJ/hKoH3/S4/Zzhyu5ws=;
 b=UtN8PH6RZ48abc4UoWe91mJ2WXp36s3CHIc5hH3QMA4Mn4KEON8fSvpTWd5LyO3wBL
 b5IFvcYrC/5nc6mv9cR6+8QGIp4r0FGZPb/fsk9/yiD7a4sSZnt0TcSqOh94Rf2HYcSf
 Y8+cJMdqoL6uD3Pv6KLcr5mQKO3CykMk7nois=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794925776; x=1795530576;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7k8oZK14XtN3uPaseTRbDc1UJ/hKoH3/S4/Zzhyu5ws=;
 b=bPEK6tEK/+rAeOVQaHmaiaMcsAugK+KrQk7lXDQoIqDgc80G4btT0fpYfO4oBftDio
 o8oDpEbtKyqptAEoHs6fgWTF2rpvpkLrLaaQiRSob+3jxHGIxfSW5oqqAHWNsc5gUwAr
 yMzIbgScOk9eetBkFTsJrESRA2qz7hSKuScrljZfZpev8BdcipVhL8+Nf4M7Elk5c1H3
 DmHipc/yYN1ohAElT2t6CcXUuvUVGf+dmv7/i0v3Aa2SC9+eXojfe8WrhMTcKCD/R020
 wGfVsJfDkW0d0JuG1En7ZABtNIkG1HZ2Fp2flPzdfqfLGRryNTIZweNCsJE2niEH78FF
 bxUQ==
X-Gm-Message-State: APuU4Z9KZ4640bgfv0ZzBcIGfWTDj9gbKPeAIGRMYNm63+sitZQwav9I
 RFWPMuQCnCh5fmblp5wiDCrs41/R/bDjM6FfXTDkeE5bQ7q0MUIN7AflrdQenN2VqUs=
X-Gm-Gg: AZFdTZe3pE1t6xwF2t5svGdPAajU7ElOXYSx08VAX7zUq7a2IFv8Tav3kpm8sUbo0zk
 QUNtnMimiu0AYAL3KgGgLrfY+aOn2rcfcfJwIjml5TSjVUzHtSHbWogU6Se98GiFuZtIfgPWGpV
 Gpy/UJgx0qfGVcez9XKiTqXOqw+QScQoGhvNHHNtcnS+FQzKABcyyzH+am19jsODWzOTdJGAkpC
 MKvFz4uoFlVRQ8BPToTg1Nt3rIDhg6vX3okIFauR2RnRfhnkZevRJelqe4ZQj8IJsNqqr+37aPg
 FFOAUOp+x1jKSK6sgA+qyfV56YvBKlAG2+EJ//7d2OwDhBSLC54AUIgI6nZPHRnDgw2pJn6ZylS
 nyQNNOACHfUQrxzBKZ+iKAnRjeTYyeJMRFgE77wU2CeaOx4ifHeLout4DAcdt5WW6q9oPdChBCx
 E5r7Nyi8PLptUN4ZIoALkCXdsEWML+Zak22VVINsWKDmOO+dZTd9L+4huEvvdvdk6SqJ2kBcSwS
 6C7NdiKhsvlvxhgjvWtOJdg6SRXkT3bO8nzaRpSzTt/0OoHmMJSf1uFiPh9pY2wgfsxB50boF8W
 NDNEjoz/Wbq4h3lANyZqF23zBk1BqPkplWkArsWSN4RLrFzDNo0eHxKCOwzwNfnmCxYUvdiV0iZ
 Unydg+4pY/tycxz6bpjei4yYOXdlYUiFx/KFqktUbcUc/UivOhMwBHrnP4nSOe6pSajmG/A==
X-Received: by 2002:a05:690e:b89:b0:67d:b381:8dff with SMTP id
 956f58d0204a3-67db3819123mr3585218d50.99.1794925776202; 
 Tue, 17 Nov 2026 06:29:36 -0800 (PST)
Received: from bill-the-cat ([189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67daec74216sm7241406d50.15.2026.11.17.06.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:29:33 -0800 (PST)
Date: Tue, 17 Nov 2026 08:29:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v4 0/2] optee: two RPMB fixes for RPMB requests served by
 U-Boot
Message-ID: <20261117142920.GP554944@bill-the-cat>
References: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
 <179486007040.2550799.14265493913048935825.b4-ty@konsulko.com>
 <CAC_iWj+0wVosYVrq3pAyDF+ekjf=sq7oOnRZfb_CfddDZq4c-Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QEO2FlGE/k/16RCH"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+0wVosYVrq3pAyDF+ekjf=sq7oOnRZfb_CfddDZq4c-Q@mail.gmail.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--QEO2FlGE/k/16RCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 08:38:27AM +0200, Ilias Apalodimas wrote:

> Hi Tom
>=20
> That's partially my bad, but we only had to apply patch #2. I'll send a
> revert for patch #1

Bah.. Thanks.

>=20
> Cheers
> /Ilias
>=20
>=20
> On Mon, Nov 16, 2026, 22:14 Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Thu, 29 Oct 2026 16:44:49 +0100, Igor Opaniuk wrote:
> >
> > > When U-Boot serves OP-TEE's RPMB requests itself
> > > (CONFIG_SUPPORT_EMMC_RPMB, drivers/tee/optee/rpmb_emmc.c), two proble=
ms
> > > show up as soon as a TA uses RPMB secure storage while other code is
> > > using the same eMMC. Both were found running the OP-TEE AVB TA from t=
he
> > > Android bootmeth on QEMU virt with QEMU's eMMC/RPMB model, but neither
> > > is specific to QEMU.
> > >
> > > [...]
> >
> > Applied to u-boot/main, thanks!
> >
> > [1/2] optee: rpmb: select the RPMB partition per request
> >       commit: f473480c43a85961b62a45436a7e095e16c2cdab
> > [2/2] optee: do not announce RPMB from within a supplicant RPC
> >       commit: 35c7097a69f64daa4571216bd45b341ca09044c6
> > --
> > Tom
> >
> >
> >

--=20
Tom

--QEO2FlGE/k/16RCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavxkvAAKCRAr4qD1Cr/k
CgJ2AQChYQiq4r2rh/c11hOLssyydCYCY3v++W/0Cz66mWIjfQD+KZx7k16WMG71
JBIuaZEZFHQSR5LBM/HZgnyB2gW75AA=
=G/Af
-----END PGP SIGNATURE-----

--QEO2FlGE/k/16RCH--
