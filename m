Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C98606A693
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 00:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Oo0v4+ID;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=nFxS5Znq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46237816F8;
	Sat, 21 Nov 2026 00:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PSlHTzE755Iv; Sat, 21 Nov 2026 00:17:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76BB881766
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795220259;
	b=BiG7Psl17KO3tLjOGh2wl4R97/JF2ZC6zcuixSPxQRU5LpSHKCICmLd64gkY62ds3Kn6
	 gvYgMZ9H0rGxmsmcSvD2a6k6Rkgrc/vK6qjsHbmYarFzwEMxd0WiTtg3xY9H8yj2+nmuA
	 p+Q7ZfbkodseMvo8lblR87+Q9g0yvTj+wJKXj79Y26joHkQcXAP+vzTqijh/ixFTlFAl2
	 NRMJ5y2NiDlHIS1X0pHggEofWU3wVwCS2uMmqJEFw4qXCJjIkvSsm36ByVhTCJyu6xcZY
	 CRfwirKVxmgABHNRMbqNXQP1YmhA98mu1CcPe9mMVwOllBV13o/y6APQX5ob8JxgMMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795220259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Lj9tq6J/emNf2XVO/ohSLlJz+mldTouHOCs4mMQ/efQ=;
	b=HAtgqC7HVoHaUJdd24W6QaJ+4EtZtcukG5LZvTIK8TMtu4ONoJdzwHnhxQSNcz6ei1yw
	 Ry/Rk+GeDAo/UMDAraiKDJLNqg/ecpb9fywGlfyQ29nfzSfLFzhcgGktwCXRli+18qzFs
	 u14BPwMAhOR7sPtJgChL3OFo4Fg6WsEHsGXqqfN86WFa+SpTUAYQZbymgWAmdouPEfm7O
	 eJiGqMAgKevv0GE3PrHG17yqiJENQVKoYklC3p/5aj40/RZNPbPGtilvHtPoloqYDouMm
	 UX6Nk+mUILwl67fJmtIv77OGUFK/X/kF65SSk/Pqk/49F6ydbNBToi2ipFHu0igosWw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795220259;
	bh=Lj9tq6J/emNf2XVO/ohSLlJz+mldTouHOCs4mMQ/efQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oo0v4+IDPeuIx6kOkWao7QlzIydwIUNd1eKJwiQmSbOyZTKumnN9dtrz8M4bkjF3E
	 wFcSCztIOUT/i3CawjwIRqxmcERdXBy3V7v6E+1ojPbowvPOpLY9jtl8B3o3hp3ICT
	 UGP52fO7iXZoU25pFluIMDL6BeNul8HmvIurxluF8HCfNkvblMTnxzcSKjEDd2tQ2n
	 J2rjKSEAReMiS4gZaz+P8OqwNfb8vMXBbt2KPUIupln9T3MRbrHy8rnPh6S4UsRLTN
	 H5e/nIQ6H8RBSITzfqptSS9nXTceNV3JOMWKi4g7molN2mvnmOcEI+qeedE/ba3mT0
	 k47GmMHU1P+7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76BB881766;
	Sat, 21 Nov 2026 00:17:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 98C1F465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 00:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8956740E13
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 00:17:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aTcso8-gELMr for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 00:17:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 817B140E10
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nFxS5Znq
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 817B140E10
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 00:17:35 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-717080a2d50so1355954eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795220255; x=1795825055;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lj9tq6J/emNf2XVO/ohSLlJz+mldTouHOCs4mMQ/efQ=;
 b=nFxS5ZnqW1MNUveFmMrfMmN1bD6f0pZjYfPM4LIZ4QoCjkn5y/NU0BYqkYfc5v0LeG
 IYBhEEsoFxA6y2KlR6dhBpV0woLLHT8GPZ2rb3VMbX+0a2/3sibsiN6Er0y2PGGjrjyS
 YRD7r1/zUQyzD7wYB/4H9NaPNL31fQX43t1L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795220255; x=1795825055;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lj9tq6J/emNf2XVO/ohSLlJz+mldTouHOCs4mMQ/efQ=;
 b=O/tBixe0ij4KBl0O4UyagbquD1L5AHGt7TAFn4RdIrrC/9FpaNjH8j5d6GjZI2iDjO
 zNlhAHkhjLyDsRkJCXt4mV95SsKTXY00pR6H6Wa+nSqfArpbHOJhPs+001pSC2CJptoE
 9Dv/yoS10H2VsDp41uofke/jdT/EnNHJpt2M5a5scoXNP+FJKbJJcoeZGcylJA6BSxEN
 s9zpjSiS8AzV+tlCLzvB47KjNsbHHwBRfu9EndSNYWV4rWjH7SiEGDCTiSVWtUtkFsZa
 ZcEwZ+3Pad2EZ1G1CX712MuTP/aKhkKj1zZz2RmrjkCrBW62WthMjRqZugfYi+fxksP4
 jVvw==
X-Gm-Message-State: APuU4Z8PAx3JIUREECajXGNUs+ahUmZNizpcs+jTJMAbwpYhyjvbtczM
 Rf89G4iEkZ3UAzCBTmi/4y9mmFeQeDmZKwLNOo5Skb002QENba2m8IdXnJ0176Fu4CwDi1QheVt
 43hPx+4MwTQ==
X-Gm-Gg: AYBFou108Zv1JKPkGRTcZoFKtsToIi2oRIZXgd/GdrJYXGTwVaqL8mA3SogjcvXSZlL
 RRV6Rq0sU1Z4/rOwCpAA0uiNPQFqyz8eWa6LS5eVBAr4yy60kLrGMvH2Q3fogk7S0WbnMX89wwc
 ViWUgJSn4fIH+KRU+YTcNEPeiWo7a3SbDPXPjzKZ4Gf16sDFRpnIbYr65dVJAgNj9djtYt013Nt
 1QagwjO0jnkUaaHAOAtOJfE3e57Dr3FesE9O/lCSmRenjcYhkltYElcv3oohbOR91N5fVeR143S
 OyaxYBGg8YeFBbN68Yt8xJYiLVAYXYu5y7pdy/dSzd82FWjAnnxRm0kRMCTOfHKQsZ0WMiIPKcl
 dcAtNhpqcUymYX3VrpMDJDJuYw2dJqfqOa3qrLHXneGhwSqk4Arv2m0GvgbWK65wCxeATPgL0bm
 wNocyTXiG/rCd7tjFlcOtSWqg+TQ/9IEvEu2UixygRjJuiSC1CDqrlFMIo1X3mQPXaEPQYUrUgW
 FPUdLQAtrTOKSx4/qNZ4FS3QJygLf42CiPEWoOymZAJcWmKAnFTZqRnS5CnChXV/KTB6Av9DLIM
 nr5DpPrjrZ9NRJfVf1F1TO2xDwf+Ex/d4LtDvDRP7e12NtiASY/6G/+UgxHY30Ih6VaUBDe6yKI
 uYoZs6TW6hjH79uWXWdgm4upoIgieNTokAyYGMSQ7OchYIhoDcJxN8WlNSbpCp0Ptxv0A5s3gwS
 aZE/84w5Yy/OThLD0PYzV77+84E2D5iw==
X-Received: by 2002:a05:6820:7090:10b0:71a:f498:303f with SMTP id
 006d021491bc7-71b39528bd4mr2745291eaf.64.1795220254327; 
 Fri, 20 Nov 2026 16:17:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60891cf6sm4549534fac.13.2026.11.20.16.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 16:17:33 -0800 (PST)
Date: Fri, 20 Nov 2026 18:17:31 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream@mediatek.com,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-next-2026-11-20 into next
Message-ID: <20261121001731.GH3176972@bill-the-cat>
References: <20261120223414.3914-1-dlechner@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fVrRualq2TvDdLf1"
Content-Disposition: inline
In-Reply-To: <20261120223414.3914-1-dlechner@baylibre.com>
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--fVrRualq2TvDdLf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 04:33:36PM -0600, David Lechner wrote:

> The following changes since commit d22f61a39fb68bc697e67df45f2e3103378bc7=
cd:
>=20
>   Merge patch series "Prepare devicetrees from FIT configurations with fd=
t fit" (2026-11-20 11:47:13 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git ta=
gs/mediatek-for-next-2026-11-20
>=20
> for you to fetch changes up to 80d7646f39e7b610a838bb5ec38f7f618387f92d:
>=20
>   doc: board: mediatek: document Genio 520 and 720 boot (2026-11-20 16:12=
:05 -0600)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--fVrRualq2TvDdLf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawDjEAAKCRAr4qD1Cr/k
CthmAQCeFdPFWMO96WynZuDjwaRS44Zpr8fJ20aga+8CR9up9AD9FP3D1PdGoqzS
+PzNlJ2s8+hqp+Ao0HVCmUemwum8XgQ=
=UaEZ
-----END PGP SIGNATURE-----

--fVrRualq2TvDdLf1--
