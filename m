Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F800CC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4084280C92;
	Tue, 13 Oct 2026 08:04:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wYDN5VhznNlZ; Tue, 13 Oct 2026 08:04:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8EE9580BE9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791878645;
	b=YH+Ag9eYQhbOXAxbOcNqbwsylR/Z7+96kj7OyaUtFxNGmhNfZSfpbT194yWc7a/TvMle
	 Qf0wfp+ySqEblRmB1AX1YreiJiag1TGMcWBXz1PyhxG7Bvyz95f+CYMDiOI9Zj0kaifyS
	 catqbmU/vHFOzDml7LjP/AcADsvLRhOKfaL8uisKVNaGE14P1gQNkeu4Vv4yH4bmn2lA/
	 Xc1bXsdACRrdjdec1Dfq1cBWznHJPE8l1JWVnmZEKb0EUFgtn/QqaAE66JT14gCeDupOl
	 IKkflR67th52QtqWyd4rGuXXGxxazFRCVN5x+oRG8WqR2/YHpMu3QnE44cyPVpSTLEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791878645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uHVykBOsHlsFyA1ZvRVRYFzUMtW2DgVrGFK0DVbo95w=;
	b=S3nlgmLpr6hqYCK4MYsWheVtuFKMt3bbgiKMVi33SVY5IuVUhlIdHsUrE/XVgjzycb4Y
	 gzISaTwOcvKLzUxOd5J8oEsCD8cszQnhX458U1coTtNCkySApuyAkJoRJTTVA8pxCGniC
	 ITkqrBkiPjNcDbQv0ONiUlJW1GL3c1CEUXKXf58u8rSE7tQnyBN89dNBCz+zLgKoYBBeP
	 hD6Kp6LgvWovwWLQ9ERtfPbmd7CPt8btdyw1mLO/hM6Ga3v0uvn6vDeU2CVn+OVXtpC5x
	 rxTc/zlb3C2RrjqrVr8vghPBP0XXi1XV2vUQoqw8w8RI9bTPQuMS76ymVuHeVDBpqdA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791878645;
	bh=uHVykBOsHlsFyA1ZvRVRYFzUMtW2DgVrGFK0DVbo95w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hgkd15C3me/rot4ls5OWuiHLeGKKuKgbiSBAizudxoHqBNMdde89Wrlayc86WDxKf
	 Cr72ySphIQikN3I6F2SugPlwhcD48mWzlvIctmn2EFhKbazit1sVmarFVmPOPvK/yB
	 ytOBFiQdJTRASz/L9hUyY0L3YShJ9xhUQqMl3iZy64xe3ucjseya0BtHuj/hxdCJNE
	 278fq6tXNT0wL1pqICGCFbZ3ULHtTmKxOmefUE03KqKqT8uiXGrexfRNwFeNyolAvI
	 YAM4c8i3OtASunbkaohEPeAjkTIAqdVXMdLd/CsKFPbQf6sWSrii+mZ/gIxJGkZKpw
	 TCuA0q0gtblHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EE9580BE9;
	Tue, 13 Oct 2026 08:04:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 65F9D788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57D5F401EC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L-j-6_sXtKV9 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:04:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 153614005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791878642;
 b=XJVwOq5guMeCNfB0nQ/TP4AzOEpKM7ynWhxtvwSIi51uheyvNv5uTm7E5E+0Bgz5WtHB
 amUf/J0DSMF5XdvrgOmguZ2XJ6Cdq9nhoke6Ra2GYGF3GxwJhyzzu296FmaodAMJLFBNN
 3H0kDNgPcaIGd4ty5VTkBIgFwmXpOke5sehZWeU2obFptcXSccwb5yCn/p7JM19MizoIQ
 06w7x5hO75wWElzVePnmIuku8dT6PuaIe943uKxipMeYi2TLg7m794cXUlxyhLTxOFK3l
 7Q0c9sMYeddAjSYGyT3qWKVXlB8DW3v89RoBfLr4XlwV0swp/e5Utn1PuzcEXBGhJuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791878642;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=uHVykBOsHlsFyA1ZvRVRYFzUMtW2DgVrGFK0DVbo95w=;
 b=nxEE/kPYyjKdWzPy5gOxdap3zfckx6JtpcB07Wxe+TndUCy5hUd4bnuPsV0dy1IMPiPr
 6u0EY/2YvxizD6psHSH3+3Mh3N1lDZ61EtBzrZGmMNA9r6RijqgZThRQlEngtne8R0+s6
 pJYsqKDUpKIa/4uYoAXuJmGD4Lq1ReIczb/37d6e9BnG3fUXPuxsNDWsYYuiJ7aVghDeo
 3cpelssurgcTamRqr9oubKkxX7wJW7ZJZd+zPf1Rp+1MvZPvcx504xAhPFtfSb8EAvQT1
 2y0JOtfOxy7HxaUxh+BEWrr2L6Q6iDfG8g9iUetVaMTON1b8tineysbqn1qNSAXUJWA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jDnhswRw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=ghidoliemanuele@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jDnhswRw
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 153614005F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:04:01 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48b9d8055dfso2012281f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791878639; x=1792483439;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uHVykBOsHlsFyA1ZvRVRYFzUMtW2DgVrGFK0DVbo95w=;
 b=jDnhswRw1CtdxT8v8e+/GLlikbbct1wP+QGLac5+APC3H5qFwoNamyCpNNWEgvV+7+
 coumik2qoFT4dNbAT6skjdSnj0QiZ0GzJHsIh5kM6r/xvmFzG5BlQVXSaYP26YxntXtX
 iK17SfYX6ecxGAiFhnwt5vKpX6J+K/8BLE1dcQ3JhmZgqeitLJZHO+z4n+z/bDH7qGPZ
 xR3AibIm76DrSs/mWFe0rjZFTy9qRONjG5rx9pgC20YcPLUYfyA3of1CX2ElcaMtdSoK
 DEwA7GlnVSVKZwTbsGsBzHXU7ow2zXefv9pUly/Qd6M2vKqWmdFy/8hPgCuLIupxBJZg
 /t6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791878639; x=1792483439;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uHVykBOsHlsFyA1ZvRVRYFzUMtW2DgVrGFK0DVbo95w=;
 b=JwIsYK7FbbvLxY9tlGNoXDHEOVYtL3SXnfPIADk150wW5kpfITROuBQXgyXENJ0X0p
 bEm2nxxW1s8JUhghstW/afZ+5MURUeLu5eHP8sJc9zkqO7JdW7qahYhQk9v7fcnNEFf4
 TgkNJX+vzNm7vSPaCB1Fvzbg929FTRpRoXca3ctE3IQLoGsQI0a6lLZALxdaSCNUimk0
 ATv5CEx9Gp0lsZGFqDLvSYlymXJRKS1I+ck2TrMtsypIZB75yv7KG21+YJ5jX7ffQxoL
 PVwCBz3Maw8y71coZJ1iGioUmJvVr3HtY1dgViOoCVjWfATcX/xDfBA3tiYCo325rXkt
 gXbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAZfASNuFkMyX6C18UmlavjCCufS4rQ/1JxS0sDfO+erGW+gt/81u+1X4p3MtErMthzmyW0A4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJh9fZKIRi4KUQPQDalSieCg45ysXWODEmpgEyG1qoNZXFNl8BU
 cjed8zd0H2igUCnKF8GfJw0tAveKpDBISiXj8/yxiAtAshwkJJwMasXs
X-Gm-Gg: AYBFou2ptzk3J3f7LmCXgisZtvscPlhnH6ciQGs42/kgYGrXU8EHObU8Mj2Ot4jCXxb
 fnXTSyAknFOcrsmt0i10QYOIe92Dg6Kegfp5fM71xO2qXO2GRRSCVXEef7pxCaHf7FJQGQhDwXy
 yeNIFnjM+hYcUDEjttCa2oECol7mPRR5voW75UscsKCYTGUSSE+bBPwETHgCHjYOYzQgn3cd0Jk
 6zsHInpTNbAu0dVl3FL1wJIcsx17bm6qHBu+N7sfvz4BfG40Ik3/Dbmdn5SbILDO9nGQsXm8iS6
 NhK18UgkOy2c04PvjWOWEK7E7kgdMMVfOhYaFP+aJgQvE1RNeK+a6gsBLTHJaN2kBvVusb7AVtc
 ojUnWC64XsBnSAvgzahE0hqCweVK9LfAaTY8Qh/sX6W1WA22chmoTDAKywa7GIPJ422WGiQA2MT
 5mLo3rNdBW0iJKcV3QeIXjQzxmIW1ca8d19z49gA2H3cev6apZocbafLE1ZgTdiOhtoMf1/eJ5W
 qWxIcrakbUZ/jw/DKCmHYZAuYQu+ucbDV1znv/xHJVSRiq7AJKySlVeDg==
X-Received: by 2002:a05:6000:469b:b0:48b:a4b:5a2c with SMTP id
 ffacd0b85a97d-48dba7893e3mr14775186f8f.3.1791878639275; 
 Tue, 13 Oct 2026 01:03:59 -0700 (PDT)
Received: from [192.168.1.3] (host-80-180-152-220.retail.telecomitalia.it.
 [80.180.152.220]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaa3fsm3757427f8f.10.2026.10.13.01.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 01:03:58 -0700 (PDT)
Message-ID: <700b47ec-af85-4506-a493-0c58c0458033@gmail.com>
Date: Tue, 13 Oct 2026 10:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imx9: scmi: Move u-boot early MMU table to top 2MB of
 first 64MB DDR
To: ye.li@oss.nxp.com, festevam@gmail.com, u-boot@lists.u-boot-project.org,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com
References: <20261010075951.3939861-1-ye.li@oss.nxp.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <20261010075951.3939861-1-ye.li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 10/10/26 09:59, ye.li@oss.nxp.com wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> The default u-boot early MMU table address is at CFG_SYS_SDRAM_BASE.
> The same address is used as alias target on Toradex's iMX95 boards in
> RAM-size probe. When a probe address aliases that location, the test
> temporarily overwrites an entry in the active page tables.
> 
> To avoid such overlap, move u-boot early MMU table to top 2MB of first
> 64MB DDR.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> ---
>  arch/arm/mach-imx/imx9/scmi/soc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
> index 22f9c9d045b..fa6b9a0e53d 100644
> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> @@ -613,9 +613,12 @@ __weak unsigned long board_spl_mmu_tlb_base(void)
>  #endif
>  }
>  
> +/* Uboot early MMU only map first 64MB DDR before DM init.
> + * Set default early MMU table at top 2MB of first 64MB DDR
> + */
>  __weak unsigned long board_early_mmu_tlb_base(void)
>  {
> -	return CFG_SYS_SDRAM_BASE;
> +	return CFG_SYS_SDRAM_BASE + SZ_64M - SZ_2M;
>  }
>  
>  /*
Hello Ye,
thanks for the patch.

Reviewed-by: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Tested-by:  Emanuele Ghidoli <ghidoliemanuele@gmail.com>
