Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293F9606E031
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OJR7GoKI;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=JsM1u5K3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F35B980E00;
	Mon,  2 Nov 2026 16:50:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ygPxCMz_bJxE; Mon,  2 Nov 2026 16:50:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3AE0580E03
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793638212;
	b=e3cmWFxnfXV2XF2Ll34vx1GtkrH6eiAD/yM1O2onN3iqejZm3ertdGNYJMM687U9x8XP
	 LXEtwkq8h1zhijLmFFACbDMEAa6aRHAldxMhcCGskZr12ewm/Lu4CSkuREeqdlajN1Ge4
	 qpY0ezZW4veJxaMOt7Se0Ltjy2KQDCZqxuzExEEA5Djka3+jZlDlTE7V8j78euBAtQj6R
	 Y1Q6RygmC2PsLZuYeLRXbK28VQUTBKNauy9o+6mfkjsGVlmht4K0dGLAkHldZ1xQhF9uD
	 qk8ewousN8geYTksFbO3zl19Q0sU3mQA4hHG21FwxWvBngsBLdgz8jeOf+joobMx3Gw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793638212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0g/CtcOxXT8nkVhZ/Rd3oBPXcaxODRE+lhGi/2h0yj4=;
	b=NBhgdC4NQXJEFu2a64TjQDgEspqvXZPyWgU8zrpGZvFDxLh4I96iRVpUvI+sdauPi2pi
	 7rjcPDxpHku04PcTmzje6mhJ+kwIkVV+95ieXbnVvbt+KY9i+q4vnWSLPlkZEmiWU+LRb
	 I2nDnRO7kD1qdwGbtT5qdpGAO8XuEcEdiCe/niwceUNeko4wSeafDKf6sn4cCMTkL88E4
	 27+AFflBvXgtP5XKck//0M2pbelknnUtlcdtY3VB5wg5hczJu3EET+VtQBoh2p9HQZDH/
	 M3KW9XEFBWlk39O9ndKTpCNNw8p5ZeRJtuYh8WhZOPND4ed5Zg6qcw7Ixzbg+2ulbAQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793638212;
	bh=0g/CtcOxXT8nkVhZ/Rd3oBPXcaxODRE+lhGi/2h0yj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OJR7GoKIK/auDIS/NP8MnmGsqBQPu73y3onnM37xsDzTsTyxmU5mMM6gk1/vhc5vc
	 lcGeWSDpj3QEqxtSY/jTXrcLEzfG6N+rta1MNFSTD1ChQRqGXCgdOvtQJQWCToKzfX
	 J8zUIyKAJAMuuJO/dIezAhztZh3p3dFNPsDILkri6zRHtjMwxwkf15vRFZ2W3DjpRo
	 Z6BhL8GsEZtw089vmufT0K/B9x6whG16/b9wYAq2NHy8TqozY0xHDc6O5O5CBfLWD7
	 oF1aP+IKm41f/aS91QhIbGkR3UP1oK/wGJcMztUYfUY6uX1GQcnaupatProhT5XNx4
	 3OymE+VWvMBwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AE0580E03;
	Mon,  2 Nov 2026 16:50:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DF0A235
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C294400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:50:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zlOIxD02FGXt for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:50:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 919D34007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793638210;
 b=JUant4EyqIsLEa503pSQTf2LRFRc0a6FUyKundNctyF9loLHAwYTFivmC6wBHb6mUMw1
 o2aTd0mUwmb+OqGoyTNt1u7mSOG5EIQYtbuOlcT7jN73AUTB5aoZYfnM5b268faRTQnsq
 MAdGgghzjK1ojUg9wkDqva/JWEGSti9mcDDPp0uv31LREntlMc0sQUHg+ZyXvIvixmaBN
 5JGYSmXwdPWEdMf8E8McnV0kqvZWtLbih7vkTRsPkrkqV3ciX6aeI1fmYbnhKpfAhIIvd
 9gkkhaMHBcfnFYGKgA3Jfz29S+nLhHWEfFHEgRPkbbkdx7vLAp3lhBkuZqXWFaqbgwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793638210;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=0g/CtcOxXT8nkVhZ/Rd3oBPXcaxODRE+lhGi/2h0yj4=;
 b=sTzgk+QG089TtRou+fwVM2ZPItCpyv2CJORfpOWRvDrSfrjZJ065ZWxq8j2C4ZWHnRzO
 cVo+OcumXFSRrvBlJlma/XBn/uSEfV+Pyo1G3f9v3Gjwg4v2oK+Fipwp0ESUShjrMLJxp
 8p+ezok1tSxOwPtYbZtytwMvWdl0TKSKUeFWpWBWtvuS88jlPA4wx++y3XMum3EZoWeZZ
 C1fowRt0LHyB0wLb9FlPHGELTcAKIc1/sRsT44o2x0Z/Dlwj+A0LpKD0tupHImyjoRcY4
 gbr53pqCjKcGC3RKrPCb0x+vGpu5RWIFDgO/KLaQUQBr7Z0S90TqjcQOP5z8oDPqtxA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JsM1u5K3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JsM1u5K3
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 919D34007E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:50:10 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-702fd86d674so2180848eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 08:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793638209; x=1794243009;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0g/CtcOxXT8nkVhZ/Rd3oBPXcaxODRE+lhGi/2h0yj4=;
 b=JsM1u5K3SWYzkmXJuhn/IV7jyR/Dc5GRwMcXMk+jLMgq8ZjWFioKwAJJMz9udGPHO4
 7RAKnKZWxHemODtC7TITczNOgEXcOkagt8oQCo0df66dyR4ZUhn+o3KcacGtzwxCD2U0
 we+bM7+2kVqaWg+ip4DWOFbt1r/LYWcaCbXmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793638209; x=1794243009;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0g/CtcOxXT8nkVhZ/Rd3oBPXcaxODRE+lhGi/2h0yj4=;
 b=AiGQGgKFLlUZM2PWVOmS52QzrRZau2nI7LrOlSE/yfkGAJwKbnTS16q9xnQwEnU3pR
 RbDD9hPLum/2LWot2k3DtG7Rt7Xdni7I0Fy1Y8/LpjqsgMzVErFB6bSh0GYiLHdPhGBj
 /f65NkvgePkjd6S90xWcNbeiuyapj6k/buDt8lqKlxZUaXVYX7KRRIU8ziFsm88R4cRO
 vX4KpoSbDkWF7H24/v+f8HjRNOAHUG73Dmxwd3+c30dM1IsO9w7T0St+x0yMI8RmZ8T9
 7J3U2T6HfwjmCQ2+KUCVgIoXLJ8iWEKLPSql8NkC8UoxwGTBPP6gCnud7Ow9mNo/XpLS
 2ctg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTm/Zfzcegr97m53XmQYvbnpaShMVzR3a5Gp1Voy/X1ARNVg6JK4IptQm+GjRbDy814s2hSBc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLI5YdVg4kJydqtzb+p3yYlKX7J7MU0GFa+eWPOVSpn5z54S421
 /IBIwXpqV73phHKxpDQl5y+AwCSwfo6BNC5hnbn5gw1ZNG7SUtnZbsPCdC2DHiOWojQ=
X-Gm-Gg: AYBFou3LSVyFKiiOTMvxsNHFthh3csYcxejjD5qla8jh8dd+O0udlwRNF+nA5IQxuJM
 vPx88EYJKiP/s8vD7qXrZ+OO2c5wLM6LGJi893+E+kpk8VW2Rm3WOJ/Pwuh0MCM4nxFfy5d9QZe
 eQu9OFJHQQXW8NU/252TUtMyOJvP3KlXMzA4PRSzwLF+BgZ9LgECVHICPGPnTwboMsxHmOgZiLA
 ZpqBze1wzS7QY3/xYzfbj1Gh4HGv6gYHWzyyuDqrX0O6w8Iir8N4f/1MCPa84A0V9Ib7IRuRf3p
 OFR5/G8gQeTYFVmUOhgI1Gw78P4j5x6J84OScJG+Kc/A1rG+nXnrr7EMNKd7PBt5V21KWLJeSY+
 1onk54U3lKnzOmnFiCBVJFtUGQMgrx0VLnC+3pAJEhYHmOHWqGb50odMCyoMVSj6h238LJwsWUa
 p5qZucGMp/EI95O/m8hxOFydoElk2XmqbIwL/JdystM35XmqIJ7WivdtGVrJl9Sdvk+XkS58aor
 xtjCtJkz3d7wOuP2JpwmVppyJ1sij3qMyVJMt445QsORsmcuWnVCHVMFhi94wU0wtyB94yt1eqH
 AV/b89+DFstdKGyzZZjSMZcuhHB2dgL5CExzwdi5PpTjt1h4rF4My/TndTHquQz+/WMifrYdO3s
 8ZoVBnrDUWfVNsQGnbG1rcYE9smcFGgXfyPeOmcaNG5qVKd5W8GQv6Pwr3KZsuw/srElyTqqCKZ
 tb2NszyINtHn5B62oji+uJ1Q2w87xQ1w==
X-Received: by 2002:a05:6820:1c84:b0:6e2:2dcf:2cd4 with SMTP id
 006d021491bc7-714f2380f9bmr6141361eaf.16.1793638208950; 
 Mon, 02 Nov 2026 08:50:08 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a92196578fsm7608647fac.7.2026.11.02.08.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:50:08 -0800 (PST)
Date: Mon, 2 Nov 2026 10:50:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Lukasz Majewski <lukma@denx.de>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>
Subject: Re: [PATCH RESEND v10 05/15] mach-snapdragon: spl: Add support for
 MMC booting in SPL
Message-ID: <20261102165005.GZ3309461@bill-the-cat>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
 <20261102-spl-v10-5-224d421c6201@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DwaG2ROZqAASInHz"
Content-Disposition: inline
In-Reply-To: <20261102-spl-v10-5-224d421c6201@oss.qualcomm.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--DwaG2ROZqAASInHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 11:18:37AM +0530, Varadarajan Narayanan wrote:
> Add routines to enable U-Boot SPL to be able to proceed with the boot from
> MMC partitions.
>=20
> Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>
> ---
>  arch/arm/mach-snapdragon/board_spl.c | 57 ++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 57 insertions(+)
>=20
> diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdra=
gon/board_spl.c
> index 460d07ef0a3..2445ae8b17d 100644
> --- a/arch/arm/mach-snapdragon/board_spl.c
> +++ b/arch/arm/mach-snapdragon/board_spl.c
> @@ -63,3 +63,60 @@ static int qcom_spl_populate_smem(void *ctx)
>  	return -ENOENT;
>  }
>  #endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
> +
> +#if CONFIG_IS_ENABLED(MMC)

Using CONFIG_IS_ENABLED in a file we only build for SPL is silly. I'm
not sure if we even need to guard it, or if it should get discarded at
link time.

--=20
Tom

--DwaG2ROZqAASInHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaui/PAAKCRAr4qD1Cr/k
CkxZAQCBImCFoc+gp3SooDG8F1vAUG5TimOaJcS1HpmRzigeLgEA7S+Q/DJH2flm
G5RmBGOArurCdMbLCFSPhL8Y4DwJaQM=
=07+z
-----END PGP SIGNATURE-----

--DwaG2ROZqAASInHz--
