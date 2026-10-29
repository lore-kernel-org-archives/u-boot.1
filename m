Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC394606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OSJ+MoyF;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=tdmz+oQT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71BCC81061;
	Thu, 29 Oct 2026 17:49:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3_BaALZeAhb; Thu, 29 Oct 2026 17:49:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A27E081062
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793296159;
	b=klLtXeuWYqC2AFnsLBh0wChAbPi90DthuQnLr9VMukFkSMWQMwJeLvrbMMbv6aUr/clV
	 +3w4cmLdEfGdnOZGEgQP0cTrOrxzNsPyUppBt8Aj9Qj6Z+ieiLzN1Krjc5D2VGGyj/kFV
	 wd2Pnc1/9A+u+ffdmYhfu5fGPqlXHp78X3wz6ZR6bA9LbJjSbXEjwo4S7/EnbnvX0y0A5
	 dluf07MnE8wrZMpXEdq+TS/rWq8N8yGgUFYmg3XhRHf02wdLCY2hDqceKWI+iAPnNi8i7
	 zapGRMsf4fImGs73GNwFYL1DjDkDPZDAguetBsx9d15rH2Msy1Ru7/MqkA3s8q1FVvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793296159;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VRsJ+E2VVia9iJKyI9vA26MOUlycPnsgM9hDP47qz0I=;
	b=XADhwmC2spLJPDsNr5rSQRse8MZO73kXVSAQDps14kA2NW4koolMWBPPMySAyVDCjYoC
	 nUIBa3nwZnnlV9HsIYt6X/4hr9pcmNZPuPvFzcXcSmvmUblgz2Np28K2E8/4xD+DCcBUn
	 gb9ozXAOMGAPo2E324wSvpyy3DJjF/tRzmX75zFFTBQHgiOn6AoImO21RsvTuxWIZXcMq
	 DYa4ytulVrToN1ln0/iQ4CvW6TXtuopr2oC3iwMifi5syki3e2CvZ1nW98WlpX9umK+Ym
	 2iDJTNhr6gJ9klALKlkitKuKjgRXy1hW3Yta/nJKs1GvuPzDTwMzuWOAOVJWfafqR3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793296159;
	bh=VRsJ+E2VVia9iJKyI9vA26MOUlycPnsgM9hDP47qz0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OSJ+MoyFc5uRGFQ7dOVV9aYfPYWTXsidvz0o6FW8ZMQ99pt5aNTOexNpW6ll9889A
	 UkcK2D51BwGk5DsHd62GoGZRWkcoDC3+5ZPqUOO8gdbQwhjoR732e7czwayYajU2AO
	 L/A4CkYQ3a26sgqeO3t1ewT9HCqLS1DKRH9EdGu4AtyeYDsQk4gwm9zv7KIhZUP9cv
	 zgtTkb5uSQZVTALewJSIP13n5rt8oV5RM4uwiZl8P+YHjKSddV+gK30Uk75zIJtrX6
	 YZpm/jTO2iGdnIA0NPO/9kI+HJCxcXf+IAYFFN96pySsWfp6NZH4XIg4nriXYfcOA2
	 pHUlJTD9pFVow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A27E081062;
	Thu, 29 Oct 2026 17:49:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C30D3A7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:49:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A85760A6F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:49:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9LmSgfhL8i-S for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:49:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 957EA60A5D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793296157;
 b=mc0JFIakCUw8n1aa3oQ4mv4V8NDF/JaAAyTcLZPwaVeGR+jJmQa82yqop4eUtq5On6cU
 yy5W2treWR0ou+7jkhEGocNodR1vDDCepzxXPSe322vPhIBG/Wv+r1P3JxH1l0raQV0ZG
 /BcrQsBiAM60MluQ+Nb8DP9NZogZzqqkZrIRBUzQiWvX5AVC9ljh02iiCPJvmY2N3mfq/
 R9LKSAlZ90i/sasJbYeMDNoGdXJfHD8MspNis7SkP7/rYwtUP9TsqOFJomYqZyLCMuZXm
 p8emquYXzfGHKJCk2o9UBWXQuE5WWCT50LLcC8BR+ITEJKa9Jo3S4W1YTGnzb/tidhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793296157;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=VRsJ+E2VVia9iJKyI9vA26MOUlycPnsgM9hDP47qz0I=;
 b=Lko3PwF+U0TVefbXAI146vk+SoaiysiZjFJSgsaCfEZrQYLbtxTQdNFYZFS02hu72UTo
 n2SxaZicZIFpdbIAU5xN6lk3yUuUQbF3APjuTaiL7wrl20NI5VADPUkek/surgPl352kV
 LWbRixcjCIKdXZw0I2JW9XA0EEIE+swvH8+sMITFVguYpRseJqUrNqc6oZZa030UwCTa2
 nD4+nqRQbMM7VCyCGprMxozIThrKQLTmMER1XpELxsqf13yAhqqBXArUPZ0Ap4DZIFpTT
 OsQYS7aGyEJGLUZp2jVZSpkLrjyARnuLidRQMfXywGnpgK5fWCntGYm7UXEShiUR56Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=tdmz+oQT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=tdmz+oQT
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 957EA60A5D
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:49:16 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-8490a7d6696so1494537a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793296155; x=1793900955;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VRsJ+E2VVia9iJKyI9vA26MOUlycPnsgM9hDP47qz0I=;
 b=tdmz+oQTqAy8DumY74NFAlDoUPqNNcdlQrjWWnfJT1NO4BSPd9EPNIZp2KmkjpTSHh
 OIj2T1gq6PWPaQPV1ayPEFjVxawyczzjmn1j2i+0g/EHfNWnIKicDeXPREYROSnVf7Il
 jEUkKIV4doX8aur1GCTMWRXO3Hg/aesWPS8XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793296155; x=1793900955;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VRsJ+E2VVia9iJKyI9vA26MOUlycPnsgM9hDP47qz0I=;
 b=lr55N9ibVZub/d4W9VdC1I9AbRpYZGeKdG2gOmem6WZEF3U7tbCfYvraqfrYoa1xqg
 83B+1Oz4YC5xs8P5YnFxzmO8yJEXtZ+B91LW14AUX1E1PSVCtdDHv2+l6XbPJmYdAt9n
 FgNUEh2QAGE4QqTniPk4GzEUSVcmi5x3Ddy0cK965QM6hKVK7FpqVFqPj1WE0XWbIYwE
 GVJywwzTYFf5H63TnX7tnPzojayyGrl/BczQhrQB7JCzhIT9WPJoejvP6qhRQ7kOtd1c
 Cz6GHoy7EHWqpaClUVNUuuz/jm7EDcCZKkWlEQru9oR2eSQh8oGIFOFcbOb12qvmoEkn
 nxWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbbIk6RCdurI8t/zbiydD87hiAZVPmvxC8RAyr1AFebnSkf7ufZMrHTHBpaDqWG75wmKk3zQ8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK8wtzeWljPD2jqS+7Fp/eW76n/YYPK/O/ZhgDhDa1gF1rSDU1r
 hSgXkyv75pbsLdDEsh17hcQeBZ7O0uC5IVinyYlH7q1jU6JvurlVHZtabt5Gv0pZQUI=
X-Gm-Gg: AYBFou0fjL2xfNdFGswOWb3G2JkfXdu6ULaHfD1By2e/vRgrfK5jJAcmTY1htvK6NQ4
 54xZyn47icZTGf646bhqMO2d54zw0GdE3aBbwHT6F7q3Eh/v5wycGYXIpbF05lYJKfBMpuRPxsM
 HYTSi7cRED7+VJGF2MplVEV/aK7ACvmv91Y898dULU+FidSFRzpsU8dCt0tJRNIC4laJm18glXT
 eCvbcQ0Xnhx6BokRugUe/iSovL2I7LtENr4zYOG5ji862k9v39G7J9DbZBqT8T/3N+pueQ6R7dm
 2TjzpyviFGk5aq4sxvN0DEMGEw7XYbTYxlHZM2QKdz6y/QyZwxZMfPjEiRzFDApG1/KR61T7+4e
 jd+RhCiyYpVRbbOO1uikbijyg7fJJ7hUI0A6pOn1sffSaGMjN7OBLtLBLxyu+EsrqhubelqHVfE
 vx4UjFFGaeWfRZJjJNQjraRl9CuznvYY3TFS5q1q1zCmmcZcdvyJ62cfFq+mBpTojPfXCNHZfPB
 nBAD5V/DEUaYrE9gNXmi0RhClksGJINySwHblE8vtQsOoxcW5n4QfnB0+SPR6BSInxTI2IUy4/2
 CzNg7b3Xhq3KtA8Y4fumIy0k6Y+VbKrlLMDfaVV9Zjzagd7kJphDxfFMXqAjYoBoVHQoa8FQeHa
 ua50b8bJuPSI+X0jCa2Np4EUI+0yifRBrVM5sT1SVLWEczNMW388VYyOf3jnM4mQ4yo0j7Cb2cj
 98ifXfTiEFbB1jIXOp0wmprYOhx+yA0w8=
X-Received: by 2002:a05:6830:680f:b0:81c:a8c5:633c with SMTP id
 46e09a7af769-85ab7b0d6b0mr5543248a34.17.1793296155193; 
 Thu, 29 Oct 2026 10:49:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545b89asm137805a34.6.2026.10.29.10.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:49:14 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:49:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: ilias.apalodimas@linaro.org, afd@ti.com, u-kumar1@ti.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] arm: omap: Hardcode control_status register for
 OMAP54xx
Message-ID: <20261029174912.GE3011578@bill-the-cat>
References: <20261029173914.3771786-1-b-padhi@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZYZIYogiOnO4X9Ke"
Content-Disposition: inline
In-Reply-To: <20261029173914.3771786-1-b-padhi@ti.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--ZYZIYogiOnO4X9Ke
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 11:09:14PM +0530, Beleswar Padhi wrote:

> Currently, the control status register address is obtained from the
> ctrl global pointer. ctrl points to a fixed SRAM scratch slot
> (OMAP_SRAM_SCRATCH_SYS_CTRL), which holds (*ctrl) pointing to the
> omap5_ctrl/dra7xx_ctrl struct at DDR address 0x8086XXXX in the
> pre-relocation U-Boot image.
>=20
> Since the SRAM slot is outside the U-Boot image, (*ctrl) is not updated
> during relocation and becomes stale. The kernel section from the
> fitImage is loaded to address 0x80008000. So, a larger kernel image
> (~8.4 MB) overwrites the value at the address (0x8086XXXX) pointed by
> the (*ctrl) pointer. This corrupts the (*ctrl)->control_status value
> and CPU goes into a data abort when it tries to access the data at
> addr=3D(*ctrl)->control_status
>=20
> Before relocation:
>   +-------------+     +--------------+     +--------------------+
>   | ctrl        | --> | *ctrl        | --> | **ctrl             |
>   | .data       |     | SRAM scratch |     | .rodata            |
>   | 0x8088XXXX  |     | 0x4037BC20   |     | 0x8086XXXX         |
>   +-------------+     +--------------+     +--------------------+
>=20
> After relocation:
>   +-------------+     +--------------+     +--------------------+
>   | ctrl        | --> | *ctrl        | --> | **ctrl             |
>   | .data       |     | SRAM scratch |     | old .rodata        |
>   | relocated   |     | 0x4037BC20   |     | 0x8086XXXX (stale) |
>   |             |     | (unchanged)  |     |                    |
>   +-------------+     +--------------+     +--------------------+

So this brings up a similar question as v1. It's never going to be safe
for SRAM to be pointing at some pre-relocation address in DDR. That's a
problem, full stop. Going to the patch:

[snip]
> diff --git a/arch/arm/mach-omap2/sysinfo-common.c b/arch/arm/mach-omap2/s=
ysinfo-common.c
> index 49bc3a634fb..1b7bca3ee37 100644
> --- a/arch/arm/mach-omap2/sysinfo-common.c
> +++ b/arch/arm/mach-omap2/sysinfo-common.c
> @@ -22,6 +22,9 @@ u32 get_device_type(void)
>  	 */
>  	return (readl(OMAP34XX_CTRL_BASE + 0x2f0) & DEVICE_TYPE_MASK) >>
>  		DEVICE_TYPE_SHIFT;
> +#elif defined(CONFIG_OMAP54XX)
> +	return (readl(OMAP54XX_CTRL_BASE + 0x134) & DEVICE_TYPE_MASK) >>
> +		DEVICE_TYPE_SHIFT;
>  #else
>  	return (readl((*ctrl)->control_status) & DEVICE_TYPE_MASK) >>
>  		DEVICE_TYPE_SHIFT;

There's not enough context to see what chips are in that final "else"
clause, but they're all likely in a fragile and breakable state, and
that needs to be fixed. Is there still a reason we're shadowing that
information anymore, rather than always reading it? And, while we're in
here, what other fragile things do we have SRAM pointing to
pre-relocation-DRAM in? Thanks!

--=20
Tom

--ZYZIYogiOnO4X9Ke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauOHFAAKCRAr4qD1Cr/k
Cog1AQDPc6poOLX1J98F9Bf90WUr/otKopfguS6RSqqwIG5zNAD/RkIufsEl0qM/
iEnqJti2EaFJ4m5hhyJCRNbNlEZAlQk=
=wBt3
-----END PGP SIGNATURE-----

--ZYZIYogiOnO4X9Ke--
