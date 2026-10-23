Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11039606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pVMTHB4t;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YjEr6T8v
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8B92813B0;
	Fri, 23 Oct 2026 14:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wmNVuxUndqG1; Fri, 23 Oct 2026 14:26:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8C365812C9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792765579;
	b=ch+GWVcQplMEqdSimpHJg4krqv95EuFXHViFE2f/tcJev3zjjbvryxTMjKAA0LQ3xD/9
	 drjOPND5SGkWRkgRdJ+x0/zJsvAduVZ2XFeUxP3K5jANKTH7+JtO6pKiQ/mZ38FmheDAh
	 ib1mTixQBQOQeafs29i22M8bIxeiyCTMxXjW6UcSMopljT9f3e2v+XmMdyskgPzAR8sHi
	 wkUgjMWFcLv6oixK6bSn31+cAxx58ztecGCxVyY1O7uBEEqyd/3B2N7nVA0jZY3QUEcq1
	 +66+xQzf1uL9nPjyAxg8bldmvaCHx/wFsebNpWDNydxwAgZT13GHKFwHldxKnBuAHDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792765579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AZCtRh/J79NjAYfPW0UaVFILC6BGO5ktbxk1TAmihq8=;
	b=g/WlN97clyd1YUrJrcGZRs36rYUDdN3DUNI9iVODXDud1eZFr3hEebfb3lnIT+0Uujkn
	 sP5Z0aC+NGiCqnKPzxnn9d1yPIvqh3NZwt5JAOukMH68nlILlfxT5xgM3K8DhTwzeuOxd
	 dqW8Wf8wv5n8AynpUnMe9yiyLRs8HcqvxHEE/LGkHo7fpZ+8D9YbMid2V4NEPfazm65Gq
	 BOvEzY7dnDkc4Uad1j53YYJUgjbkyci6OW5NQ5qrfAgajREu9QJUD4U+p7epA2UFGz7GZ
	 z7qRSbUMu+GF39a+OnBftqsrgLFb+WEK6KBQzd4+dBPP1IbkUDdhcxMbmJ6yA/+6lRg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792765579;
	bh=AZCtRh/J79NjAYfPW0UaVFILC6BGO5ktbxk1TAmihq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pVMTHB4t35hUZLKff6KjAPAUs5BoCSxBSaSjKJ8EOI1bj9y0JJaA4MmsBGXWKuVy2
	 1H7YE62jfyvaRyCZoFXv2zwiLwYLKxvXGSE+IDevT3pJMau1viowRo8xVhKvv+HUcJ
	 ZmPxSI/BNaqS4ZZUPxh9IHkDww6MYnT1jPuok53AUBuLvBeUk4xAeFwjf1aMdG0ij0
	 62krGp8YpMyUkN4DTPnLxSa+HVvIQmeXXDZgYhcrtesc5ytuWA02Cu5qVcTQ05mNB7
	 CzgirMYzZx0sI2FzpFpne8GP7twJtXc3FiC8vJA73wbibDErmHCgw6YSxVrBEg/KOY
	 DRAyqOqrwbDvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C365812C9;
	Fri, 23 Oct 2026 14:26:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 24A10371
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2216A401D2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:26:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nnbX-xLrOCgc for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 14:26:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 63EBD401CE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792765577;
 b=WGSIB9QGZgV90Y4siHPiU8QcDS9JdkaNxwlKL3iwXGbEJBjGG18KIkimRyM9JDjBOr5g
 nKomfBC9MUZH7t4NxELr8mkAXsO88nfGHzyJQ+98nDL1BayQimOjaGMfvfuiB3Khw1x5Z
 t+6b5JWrOCGOHS1+guschbKTws04wCRiZYWGsqlipA7VSI89lWJboimCLwzRD7/pIG5+U
 JXR6V1Oos3cbfb2Q205Gx8CuLefPulx0cSiWgnhZ8Mr2sM08uQ5izt/FtnpbKPUVe+QKZ
 N/1yIQvx9tl0mQnxr6lxXqCi1Zyy1jD7WkjSSER2P0wYFXl/+P+M3QF9ALQRXqiV1tg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792765577;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=AZCtRh/J79NjAYfPW0UaVFILC6BGO5ktbxk1TAmihq8=;
 b=Fa/1YBOda6iYDT+4jPWkKUnmHUeNISG56W6i4PMO3JfvRrNbBBsVHUWumgcoX/DONXQk
 3kSE4diOZMV8yk6KuX/cuxdUxsoGrDSK+x0H1iS77yskbh35/PsU1XZqL0heHdtNSInFO
 UzkxSyJBVgwHYJtY2GAaDwfvWfBiwaKiIHlU2FDzCOxUF3yNwMueTu3iZ3hdBW7N/Oq1R
 Qhrtrv/ova/CrLwQvYy9UGtl0BNUHWK+P5cQ4zk3agvZ4wCD9FoAo97ZQUvyVLPD+7soA
 4g1ZNRlmCwoI6E/kpE+MrHfQGIkqf/DoKCuMkFBvYU9JxcdirmgnuqO66mXhAnhpMDQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YjEr6T8v; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YjEr6T8v
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63EBD401CE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:26:17 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7fccba9c675so2273024a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792765576; x=1793370376;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AZCtRh/J79NjAYfPW0UaVFILC6BGO5ktbxk1TAmihq8=;
 b=YjEr6T8v49FRzny3ypOhbJfFbA5eo/FJSXDW296UbUBjCDlfA2A7dl1G7M+CPn6Q5A
 mcd8tfd9+HX2RgqzFkH61Ckb8ZE6RBb4+XxuKwNl8KmgE0hEuR1lt5s9vxtTj6Bj4nOd
 CtxntRmFBzRP3FAvPUoSNu2BAW49VfNFpm2p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792765576; x=1793370376;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AZCtRh/J79NjAYfPW0UaVFILC6BGO5ktbxk1TAmihq8=;
 b=iLIm0Ha358K5colVyWMIMRfuGNVzHf4en9Q4SBuygLRdILCRAuSwrbrxjoXnFWBb2r
 jYnIJyaO+wmZjNeEmp8V0SAZAKW/tSHI1avpZlmb5PgFFg/ehAXAs6KPr/wSLKiRqwev
 Xdd0pnQ/zcbqFeklN3zEWvjnkGXOxF8+0dVcxFgAHR50tt2180En3y89PCML84SsVcwA
 37FZioV5pFAw6IYmE4bVmwmVPkk8sEUOIFbSxoem08PB4mkCg+jkZZqNXx3S5yt7nuQ8
 DssLXYJeWm/PxHIeiUemJBG2DpaHp1ifZVQdbwC98gJqv3gc21kS1+usPDGl57idZ97m
 9ufw==
X-Gm-Message-State: AFq9FYKf0re6wKde9jZLRxwSHAwEaih+XrJP9yWeEdQaVfLHuVoKfr8A
 7GjzphAd5JY+3qBZUkidF2/tdJmMfEr0yuFq6/vQnERrS8Ig6WZ/OAc4A8ODqXsok48=
X-Gm-Gg: AYBFou2ENymQ6tZK63EZxMzAHfUQC3WUb0MmXFHhrbLbhhtZ6oJfJFNKlCNQxRtcYsR
 vvmqZrh9NxDCa5FTbAviUrgIFW9aEDYL4RI1j06b3d0rOL09g7OHwnknz+pFR5rQTUZBE56D6+M
 PYa85Oh9I+VbvuCDaO0ICmMcAWXLpoIwg1Wj8AKEhx+bNMz7zdtCzZMzZZ11SEmzjtjyHPE2dFl
 JPEWfiVHhcvv8QdjinB5CI4n57y0qyRNA0MZubfrh+LHbbC6+wH5plVuWapnibv+WOtIEPY4Tha
 mOeZjkzE947EFtEhYqbUHvw07cADosGUzAu/BPg2Ls+8g9mx7airFl0UtwcwlQYdKs3SCL1QJO3
 q7+LIIZnrpyOosQncjIrLFbcu1rr6OJDQLw54tLOpboYTuNcYgB0pcRARuf6BVAGdC7299zoxag
 v1CTfmihuaiHcDWgayV47J0dvdl+ufJYA+bjAq3S0XGTg4dCRMvLTHCT8DydwTde8HNQBRH4yGY
 6MOcPHsWLVKDmt/3pvkBcUaG4POCVFo21MoXoOdentunfhjhgSXv2nbyHA4o3egc7ZK+YYR9MIL
 n2qUH5jbePLys99ypc9V1sYUTPSJ4LYS3fa0ZG2mQjWwDCyZgfb50vRB8IYNV6BQ1t9HXAwtI6r
 M
X-Received: by 2002:a05:6820:3397:20b0:702:778c:ec68 with SMTP id
 006d021491bc7-70b887e040dmr995929eaf.2.1792765576103; 
 Fri, 23 Oct 2026 07:26:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850ccd51fc9sm59840a34.15.2026.10.23.07.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:26:13 -0700 (PDT)
Date: Fri, 23 Oct 2026 08:26:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io,
 ilias.apalodimas@linaro.org, lukma@nabladev.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org
Subject: Re: [PATCH] clk: qcom: ipq5424: Configure SPI0 clock
Message-ID: <20261023142611.GH3596691@bill-the-cat>
References: <20261023064813.1059535-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vgkITdwTzebvrfbs"
Content-Disposition: inline
In-Reply-To: <20261023064813.1059535-1-gurumoorthy.santhakumar@oss.qualcomm.com>
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


--vgkITdwTzebvrfbs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 12:18:13PM +0530, Gurumoorthy Santhakumar wrote:
> The SPI0 serial engine needs its clock configured before it can be
> used. Add the SPI0 clock gate and set the clock source to 50 MHz for
> the RDP466 board.
>=20
> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualc=
omm.com>
>=20
> diff --git a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi b/arch/arm/dts/ipq54=
24-rdp466-u-boot.dtsi
> index 56677cd6f6d..4da734e2c91 100644
> --- a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
> +++ b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
> @@ -17,6 +17,11 @@
>  	};
>  };
> =20
> +	&spi0 {
> +		assigned-clocks =3D <&gcc GCC_QUPV3_SPI0_CLK>;
> +		assigned-clock-rates =3D <50000000>;
> +	};

Now is as good a time as any I suppose to start asking why this isn't in
the upstream dts file instead, thanks.

--=20
Tom

--vgkITdwTzebvrfbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCattufwAKCRAr4qD1Cr/k
CsU9AP92lU60XFBkhOhr9FP6Ho8QdZrRNvq7pGELLSayyNt28gD/VRM+/h+Oeo2I
yXXFE06aoWa9vEY5H0ly4o4Mhugu4gY=
=nqTb
-----END PGP SIGNATURE-----

--vgkITdwTzebvrfbs--
