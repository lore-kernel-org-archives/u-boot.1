Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABE5606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Om+YjKIS;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=COJ1vlnj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41DC880D93;
	Tue, 20 Oct 2026 20:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OESmGoEbZHDJ; Tue, 20 Oct 2026 20:26:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E55580DE4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792527974;
	b=JBvy90o8g8dgo88yt0I0TQPh+IeAtNFz/LA8eb/pzOJaInjWUGA3J316lb9k0PNnhxul
	 fJx+GqdALvBT5ZSnmoxlyG9ZMEAbPVruTxN9d1+FFUJlCO7FS6Z2C/j28XXHebwb1/vFq
	 CIe4BnkkcLFYrgEKZg7y4t70AaeDYjsgvveArdPsE4w3nozqtWrmAWwpa6HA2UIiEAeUL
	 GmNw1mNO3vLTL+au5koZ6S9RU6FcBjbbSal/HVhUR380W2XiGBRUc8zAFn3Szp3X1x47x
	 UP/klh602DQyzWNpkeXiYWUZ0aKD4zLGef119mH9LBKzdgejSMLXFCLwdhLN3miNzYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792527974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NhcvbQgtgBSYCXw4Bpj//3puzvmYtwAr86tTq/zHyMM=;
	b=nH2puGjuvdaqQiZgKYj0i0qeuBuLSBn6ElwrmTng/TK+4qQlVozFwxYx1hIlQ5RH8LMX
	 whu2KVgWU2zhgBbgk7F+MIGPqWaDo0SDZ8jUhWG6wjHOkgJ+35kmRGxKuAgb3mCihBx75
	 RJVlUG6cBn9PfG+kxeU6VR9awjzGs9M2EudF0ZPbXPFITEPI83PFtWOVNVMkiy8Bq8SMn
	 SVxBUFc0NmweIKwUQviUrfF4hviHkrkAakkCXBCoA9GFgrr6WjH3kM0Cbfyb51noC+Pj4
	 Ylmge68RFLvnLP62ZtZucJ0C8r9Cz8H+rEbzYBIJcB/BGAqWK1iihqDBXpKxQYFKnww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792527974;
	bh=NhcvbQgtgBSYCXw4Bpj//3puzvmYtwAr86tTq/zHyMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Om+YjKISkRB059CY/0XSFETLvrAD14U1yz2Dtjx4/YdKtGpxRxW+lBZecxyqNtW2x
	 qcTylzCMZNZhLt+GCciA49cAM3chNegl2mxOLAQb8mw8VJ/6Y+k9aPs39ZLq9ATJgj
	 3nIRGyW2zhukKZG24n07dcfcjfecU9sVev+kxyJjQAjuFSxcNGVGK3l07hfqdOEikS
	 /Mmp0pDMVSG50KiqJw7k/shhlbsM/HqdHQYyz7HaCJ61SWF7lxYipBkxn/WS1/CgpZ
	 R3ySkD35qBc7IVf/Axc/jsF9e8DXV4/tgB/WIPnzdNFts8gyZWt3p1yUQBSzqESMNy
	 KjTpeXg/AdpkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E55580DE4;
	Tue, 20 Oct 2026 20:26:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A2289380
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 20:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8AD196070C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 20:26:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YAio3sUHc6Pm for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 20:26:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B21BA606ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792527972;
 b=cnHPGehFfQqWvp/oMx6W70WfiaiWsU2eCWL0PRdeXnZzRJggGsc9Ku+S3u/grzU1J8DP
 gAj1dnAedIVturOgZdmH4I2GvCOEUzoxro5J+goULVvQjHcTj5M0cAHLGFv+FKW5TWQxM
 IJ9gcwoLILMKILTUpOGArSojmCTFWhJ3m94ZfyDm/rirGyUJL2lI/7UkzgO+f5H1Eio2k
 weLn+h/lpA+u8zFwKaYo2/aL3bWFvs/fcPUpx5Sy19YmRJdpboKUMvlejkgFY8ubNs7Ra
 CC4UzAGq3wTZ4bBgO+KDNS4c/W0vs9mZIurR8CqN3phahMPRCfYLfPs3MYESbhglgRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792527972;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=NhcvbQgtgBSYCXw4Bpj//3puzvmYtwAr86tTq/zHyMM=;
 b=gSRo+ehEhWLFaaP1pA5Xixs8s76m2nlk1kQjCJT1PHsIOvxz1eyy2CR5vcVaDMnHXtwX
 UgYCdS+cH28bNiM/2Xp0QZ/IyQi/u/iS3wmN8rfq7Tw/pxDdoabOCDAB1WjR5KW0MkBJo
 +HwYY2/jdzgyNDnDNbAdNq17FO0/w4oyy61kSbpR/OJ+tG/ll948jbuRFet+g3EPFxsqi
 bM7VoGxYCBLehUHffvauYSGF4OKZPGTgxEaEZz8oEAVdJlCxZuBB4vQQFTVhIrcUH0EtM
 DkqmeS2MNbccXuxDDtw+9Zte4X0ipHSqWWy5dWdnH0cJwCj2k4WGmD+If8iIxm+CcDQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=COJ1vlnj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=COJ1vlnj
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B21BA606ED
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 20:26:11 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6f5a0893610so2421440eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792527970; x=1793132770;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NhcvbQgtgBSYCXw4Bpj//3puzvmYtwAr86tTq/zHyMM=;
 b=COJ1vlnjCRF+W7kHVq8UvOaHJD/ol3FHraOBdr01LyPFihqR0n8X+mdyDgp9vsaNBa
 WuORn789PuymgzWB3OBka/lxdB5S5aT7hcyd8LHRh35SFfy3mVayhBZD5S7arJ2IYrjQ
 lyF7rchIZRCy9Am7tdxvszee7BBXOdW2wylpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792527970; x=1793132770;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NhcvbQgtgBSYCXw4Bpj//3puzvmYtwAr86tTq/zHyMM=;
 b=VgzXKS672mVKxk6EVwDEhYXsiQHvOOm8g/Gzttycy5amIjya9tO2tA9VDcazSqTbrr
 joVOSGKy39CRb+2/Bs2K2M3H3Ku3QGLNYHfTRRLiKomcX9hR/ZYTNLNcPSkXg6E5II9T
 9sWJN6HTESBbODRxkM6qMxv9oK/dIq/xss7/ppPvCsZKhq5YWYzEYNizwD6cRQ2Boln5
 9i+kySbboj8Onf5btLuHhOANFcHiSbBPMVOR+S+olkYJ4Dg2sJeYGJhXGTNri1hwWyTj
 ZH7UeBl+8Ub1cDEq4WoJBZGy3WoXGQDHcqC1R+6VYfAV3mDZM3UAL91At5GV/x029sK0
 I3Vw==
X-Gm-Message-State: AFq9FYLp1rpBTNEc8rMXCM+NiAZ8rM6E1uV9iEDiIK8fesb6eU9FeNd0
 baP3+Yh/HH2Yk56l3Ipl8t9Ywmb5crF1e4tZAlkyvX2GreNp78awH+Q4yzPGEY+t/ysZWowhw5r
 EVVCqxlLj6hdP
X-Gm-Gg: AYBFou1bGRdcxRA0IJudgY1qowCV1eDjnm0A6A2pLbOJNaLMbF4o82GxA2hbhb8pNgn
 ZjLqVZKJ3Dj/E9kiWW9a/pGhZJ5JXvac8iUiKsBMnVfcZWMn3z3E8bBpBqT5YlVR6vtgGK2L7sj
 rrjhzUd/8SaudhfrqVTjQ3B0bss3cU/MJCD5T4d8YVzkjBjhKXb8qwQKS+EoASXEqDqkYMRdeoj
 NDIm07q+PE+ewYBA+PEzc7Qtto9MlbW257/kelYd375w7lJPWSDKHcCuzBgfabj7bLsSsfJsy9p
 KUow3NUvHaYuAxgr7P8syJLbbcVoTfXmx/1nz35WvMCDQIiAZTs9sFIVwfeLvaskFXarLTtvgLH
 tzmMV8wc0tXgQMYJvoaHTanM5Gxyk0dt2WmOQMOnqO/TCgB6UW+enJ6LPSo25efX+VpGVJaoQkJ
 djtRFw+Awj+H6G7kE76nbzo5ZUITsDBtStANP4UJeSixqPlVrJeQPfAriimZZhe/vRb6NBLa3St
 7DERZ0YK8nZFbdNBiLj8qeL8X8EJ13dj6DdbVrdS9HKCmf90Og5KTgKYhOynqewDpm7NC9bDp52
 V05ZTzoSk6R6FgzNS7Y=
X-Received: by 2002:a4a:ee19:0:b0:6b1:afc8:3162 with SMTP id
 006d021491bc7-7093d88c0f8mr31918eaf.7.1792527970354; 
 Tue, 20 Oct 2026 13:26:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d5eb8fc0sm414183fac.1.2026.10.20.13.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 13:26:09 -0700 (PDT)
Date: Tue, 20 Oct 2026 14:26:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Umut Tezduyar Lindskog <umut@tezduyar.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: U-Boot UEFI implementation vs EDK II UEFI Payload
Message-ID: <20261020202607.GJ720525@bill-the-cat>
References: <CAFKnvs4jwfemfGE0i0zvg3LyjePU0KZU_1fb68PVeOBD+nqZDw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gs3LP0CR5IwXNDab"
Content-Disposition: inline
In-Reply-To: <CAFKnvs4jwfemfGE0i0zvg3LyjePU0KZU_1fb68PVeOBD+nqZDw@mail.gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Gs3LP0CR5IwXNDab
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 02:15:44PM +0200, Umut Tezduyar Lindskog wrote:
> Hi,
>=20
> I have been looking into U-Boot=E2=80=99s UEFI implementation and trying =
to
> understand some of the architectural decisions behind it.
>=20
> I noticed that EDK II has a UefiPayloadPkg component, which is intended to
> provide UEFI services on top of an existing bootloader. This made me
> curious why U-Boot maintains its own UEFI implementation rather than using
> EDK II=E2=80=99s.
>=20
> I am not suggesting that one approach is better than the other. I am just
> trying to understand the history and the trade-offs.
>=20
> I have a few questions:
>=20
> 1. Was integrating EDK II=E2=80=99s UefiPayloadPkg ever considered for U-=
Boot? If
> so, what were the main reasons for choosing a native implementation?

UefiPayloadPkg didn't exist until about 3 years after U-Boot started
implementing our efi_loader code.

> 2. What are the main advantages of U-Boot=E2=80=99s native UEFI implement=
ation
> compared to using EDK II? Is it primarily about binary size, complexity,
> dependencies, or having better control over the implementation?
> 3. Are there any significant disadvantages to maintaining a separate UEFI
> implementation? For example, keeping up with UEFI specifications,
> compatibility with EFI applications, or implementing features such as
> Secure Boot.

I think having this separate implementation has *helped* because it has
at times brought to light inconsistencies within the spec and fostered
cooperation. In general having multiple implementations of something
rather than a single implementation of something is beneficial in many
ways.

--=20
Tom

--Gs3LP0CR5IwXNDab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatfOXAAKCRAr4qD1Cr/k
CgSaAQCJBctFvtGHr2vmHkNE3bpSg2TLPXEDq7fYk5uOiV3UmAD/bdb6yIzfjfUJ
ufI9PXHf6tMSvDL+YWRT2tmbzrXO1Qg=
=+ATl
-----END PGP SIGNATURE-----

--Gs3LP0CR5IwXNDab--
