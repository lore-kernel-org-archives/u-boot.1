Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE0606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PZcLzOln;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gyXGVtgA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 486B640851;
	Thu, 29 Oct 2026 00:32:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1zcB7PWYNopA; Thu, 29 Oct 2026 00:32:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5770940846
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793233975;
	b=Oj+jof0gsuw7Qwf81IKfM5fbKFUWD2xiQXzKnkj2hm94ib3VQl6k0jDpipKEhh0VER0a
	 fW433FLBrEUBT3fLzTQ0G7g4tQUzMW/r2vnJeL7cBLMGUbi4lwJTNnYozMbZuaRxguwos
	 gquth9/kZnim9IaSMmVg6pIUhESNYsehE5vWOxK12owtyhzlUnaaXkZupCsaaeARdPo3J
	 RDTlXE46m0kiHbHKEP2FSHEFvYutADievV11BgRasL5wu/7GY1381vZvc4iQnOFhzOdXc
	 l5Yr1Y6MjNmS/byoIvogeAA1uL7zBVg7uwckCYIVlTo5WDffWXff/sX7u5377ORPhng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793233975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nmGIXESLGBV/cfsVB6aAWzfZFpiO9LTLMV9BHHoeugg=;
	b=IPesBNmgJDRVgAIjd20feb3zus7OBJMjXlMsPU8r8CS/dz2ljlPmgC9eWPIuktZ3a0nM
	 +F6zAxctwTR49yusGY3/1TKGIko9C/FHct1/hgXl8cXmSNNQRfpWwbhw4Ln+EWrdm6SZ6
	 spXtJM8ngss0MUquSKRxNMaT7jBsdqOyayPmwfcFM3lndX8CvJIMAf9PWj2RMnBbk03Un
	 HC/NbPJYRZZxj/ty7HCvZVRtn0m287RUdbgK4X2Rn23iUqjv6DWTKVmrbH1GxOhWSP1Rw
	 Rh/HHT5NhUDIQUUu+ZyG0t3IOFHZQJVN24lHhdtNMuG7Vc5GFMPnhEsl6aA0r9xhlAg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gyXGVtgA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793233975;
	bh=nmGIXESLGBV/cfsVB6aAWzfZFpiO9LTLMV9BHHoeugg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PZcLzOln6tb8UnXSnxg/A4Ij5i9D9WCXHlxjsKxiMBUdjhKwLqWXJNhYa305EMJ4u
	 E43mPgsZ4Oscff9lScWxcxJBGIIVfPflNaWeyvAKEcGMJkey2qMXuHQQ9Pk1SRdx3l
	 GpbZbRL5F1AZFHwfCZnTnTtp1IaCE8UfMufaMXwKC4NXH2EioE/qvlt4B9dcmjuQM6
	 braB5zTJy8vq9rWY3uGSI74OReCFdKFZGZtBS/29qWQm5DXA6zCNnLuXzddK7GppD5
	 mzF/d+9LpqNrp2J+6kFIQssSYrla0Kzu/hIaWJd4z0M36+C6U88cCrgGXfUTVlVsqn
	 GSOneH0CXJDjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5770940846;
	Thu, 29 Oct 2026 00:32:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E27B2E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23BF040846
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:32:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SUENY-9sXC8X for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 00:32:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2AD294040C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793233973;
 b=IbXN55N2ga9I1qjGBrFrlCG+F0gQr3qp3q38GieFGAOmqszP6Lxp5k/O4EUMFitHAmBc
 njOWClG1Re1u8gj5g1oC08KBaWNl6WDLvN34UEGxOzXTdyoDFK69KqlsS811KuHcmaQf6
 +RD0FuEcFgFXJz2DNRmHuDGWUaxWgnKxO6ZwPsnb30xOwTGpMJA6l+zkrusSBR3+yqDIh
 vktwXQdmw7cRGLqaiYSwucdLAvC+Eo85y3B9qjBgIzUyYtPboIL035MnIbO4FhwqtLpwH
 BO8KflK6SFvCXUBK4Tsls6WgxLruw1vo4To2tU3eSpnhhesN2/jBroAWz7RE5/E6ZuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793233973;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=nmGIXESLGBV/cfsVB6aAWzfZFpiO9LTLMV9BHHoeugg=;
 b=lzXLbEK5AkSP6RFuMjZFsVAKlx6Y/kckUbObvAwXzXoEEkaxMJeN2iDk7HQMBgITZPmc
 Z6FZf92ga6YxXVba85PZrq0lzt6HVwVn9kRQ55McF+rR4yToQMcN/jD3GAzgaUu+SilO2
 /4mbJ2Wh9HuCNJrfLY7393L6e9mWzKP4ayccEA3X5vnuhR4a11nK4SweZuYJckT+4d1gI
 xzq3iL35FeeKjCRp1GLZbATsWnzpOC2Rwa2HVe8XpMwLCqWzhezLwkTUG3hYLO9boqct8
 GGB97wQcTWmsxZlyP80rghWw7dzyAvB8BjiZXGsr7bqqtpaa7qx4cjAsV2vOdRtrYGg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gyXGVtgA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::7;
 helo=mail-oi2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gyXGVtgA
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AD294040C
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:32:52 +0000 (UTC)
Received: by mail-oi2-x07.google.com with SMTP id
 5614622812f47-4f2a0576df3so48831b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 17:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793233971; x=1793838771;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nmGIXESLGBV/cfsVB6aAWzfZFpiO9LTLMV9BHHoeugg=;
 b=gyXGVtgAYRH8hVpKQrgEF5GsXj0C0P6mr9yM0BwTyRrrAG8X8hu+m2DlFSycxHz9ea
 Y5sSXlwqCb8CDy9JKUp+x1zUJVFrpwzoZgqaEt8lvCdpfPpxGQtKXarUYJDNC2g1+hLU
 EHsBR4ENkhSv6xdDMm+soVfnGEcAzwId2YAJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793233971; x=1793838771;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nmGIXESLGBV/cfsVB6aAWzfZFpiO9LTLMV9BHHoeugg=;
 b=xyGA4e/KC3nnZ3Rsi8pioVq/y3XahKIX5ZPmPBIeihCmYZJuxDx7mLFLGKCVNPPdzW
 C+QNFTco7i84c3Nbymv5SyHUm5H6JmXEnTYaL/KkxP+UtIKTi2ph7Td4W6x/PGLHDs4p
 3XU6oEh+Bb9mG7oeDkhr5ITo15dWFqhGhQzTEidWdPymn+HegwGXNY/49/6UiMfw9L8N
 2L6SpqWE6ULTOExIPFeVLDxVcrQ0Irv2+HqB93tZ5TLNO6Xh5fnGvh2UgboEACryiRsM
 aD8zpqqzbjW5BLJXa5aST8KyPiqbiPwuq0L2kWa9kQEGmI0BmD5c7Kfp/Lqgk/Sj9O7v
 PTEw==
X-Gm-Message-State: AFq9FYJGeHUt6Ms9NHnKiiHwtYurVtJRwL2ZtFZt4wePJ15co4zuG03k
 gJZBd/itXyePQY0PM/NFSa3w7Y7Qn0jZWrRmsxVIgIA4n9UknBYpfY82Nx6sfTIWs70=
X-Gm-Gg: AYBFou2OogBKD5bkRo5qsnIvyOvsV/zjCmu3WK45XC8TGHdzvJ9q9DLKX8mnL2Kwna/
 +dXBnAgAkOkuuVpQiTVVlie0ZxX1CiddLnMupRe/ffdAs2WaQ4QExcQAjZox9n/qVK/vMb7bGhn
 KapxwBLSde4xdk+KQ73DzH5FmEuj+L0PFeJH1IKJWsBz851iEqMvP14GB8cT2PhP52B/+Tb98l0
 6hAXu6dELqPLeWdaxA654VWMRXUL5/2zSzPWz5PbxyzyBJMlGY4vuEEi8OInCJfInpwvp43TwQ/
 CMcx6l3iksj0vHQiXNWnYhRuPQAjm9zaOQNl33AKpksch6BPD7o0viiSLdS7CDNUhKHWKIcnFrf
 xqiE7AKMD5JLt5muI0pIMGdzT9+l187HSCqh7oJD99uETGlO6QfsbszV5e/9qeH5XRov5msQjzV
 bxZVG7zoeVbWF4iYmXRxsjXraSv7HBtnteWI1e3tv8+Wo63dTYOxIResUoqARh+T41ARfvFD879
 oscK7r7WcEDzuT3M3FL4CpZfmWwZh8k9KYUs5LxoNbMIPr3/3FVSxtqVmZ84A5zNXNpfxVvCRBU
 dgKtsm84nStBQfSSvurXNm6lnI/JSYd511NIM9FmRkGncsgjAVXhXRNDKT/aAhC6YQPazcqjACm
 tJvFqieIaT9Gc8gtAcQD2baAL+0k4nbGfvIbHsmvNKVa538uq3n2KOdBLhRY+djgiPVihojD5tk
 FH7lwdIgDgTuJrKad931Msd96dHL3jg/Y=
X-Received: by 2002:a05:6870:31b6:b0:448:6ba8:539f with SMTP id
 586e51a60fabf-4a8e05aada9mr688887fac.6.1793233971422; 
 Wed, 28 Oct 2026 17:32:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8b785d108sm3623142fac.9.2026.10.28.17.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 17:32:50 -0700 (PDT)
Date: Wed, 28 Oct 2026 18:32:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 David Heidelberg <david@ixit.cz>,
 Francois Berder <fberder@outlook.fr>, Han Gao <gaohan@iscas.ac.cn>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 Petr Hodina <petr.hodina@protonmail.com>
Subject: Re: [PULL] Please pull qcom-main
Message-ID: <20261029003217.GE2677024@bill-the-cat>
References: <20261028205507.1705522-2-casey.connolly@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bltVaAG8D5QPTKhn"
Content-Disposition: inline
In-Reply-To: <20261028205507.1705522-2-casey.connolly@linaro.org>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--bltVaAG8D5QPTKhn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 09:51:26PM +0100, Casey Connolly wrote:

> Hi Tom,
>=20
> Sorry this missed -rc1.
>=20
> The larger changes will follow (likely for -next unless there's some
> folks are particularly keen to get in?).
>=20
> * Add scsi_scan_new(), handle scsi scan in mach-snapdragon without relyin=
g on preboot
> * Small docs cleanup
> * MMC HS200/HS400 support
> * SDM845 rpmh regulator and USB3 PHY support
> * Support for switching to EL2 (replacing gunyah) via SMC call
> * GENI UART minor RX fixes
> * GENI minicore support (GENI QUPs which don't require firmware)
> * Added proper support for various GDSC reset flags
> * SDM845 pinctrl/clk fixes
> * QMP USB phy orientation support
> * Fix SMEM memory map not including some carveouts
>=20
> * ufetch: fixed LBA size wrapping on 32-bit systems
>=20
> Small rebase, CI run from before: https://git.u-boot-project.org/u-boot/c=
ustodians/u-boot-snapdragon/-/pipelines/1779

Erm, that CI run fails on qcom_sdm845_spl which also merging this fails
to build.

--=20
Tom

--bltVaAG8D5QPTKhn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauKUDQAKCRAr4qD1Cr/k
Ck8yAQCc/GBsAJvHAaMN2M42rcLU+/4Uk824si+CfBKf7ujdVgD8DkM72jVc8P0c
gFSTSvjH3PG1CPmd/JK3LGFIDHEsngs=
=FfLL
-----END PGP SIGNATURE-----

--bltVaAG8D5QPTKhn--
