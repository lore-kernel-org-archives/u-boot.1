Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B004606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0AlooTJH;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=dfoCCV56
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCDE181546;
	Fri, 30 Oct 2026 17:24:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XqEP5CF3RAr4; Fri, 30 Oct 2026 17:24:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1561F815B6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793381089;
	b=MAs+l8DK3tZGGs2Z9ea8Hd/yX7xODFtqD7PMyaGMo8bC4/qYvhLcqEh4xsr0eL3J7Eoc
	 6ZKsChWCQ1cK7j2OW5HTZ9Kannc0mNT+ivP4M9ZqHvqBZierMrA+yt+DSIsPHwuHmd1Wg
	 z+tS9obNSwH7tQAcaxlM32C2safhaFClAQxAj9/a/IoSGWQCheERYR8abUEWFwjuvWvl7
	 Yf9HF4B6+TJHRR6JEu6DixGS1DZa3VOYzqmN7y8+fok9FY+AH8+eFMX8MArZOJsVCyB0u
	 jyzoolExSTlqMVYvt9RuJ6/NbgraNm41qDJsZgpZ5lFuR8krlDIxEleqyBOYZTaOU5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793381089;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qDHknVWsbD9yg5C1f0HX7unVB0iUn5ppzQQYgTnfyrE=;
	b=ouFK7rs91WMPqkxZipSAfben4qCjb6uB5wfL3iANaTRtu3Hpg5UJYNmv8E3dZBURy6rN
	 Uyf0338cx7Xb/uRpiHp3B23I8/8qcmcMTM6xXilPaevC6ovGbfkXBCJ2e7uGxvzvss180
	 ic02Pr5llRg7xOVujFRjtL9OpqSF/sgci9qmvO3l5sp+AzuzTGCJoaF5rvFtMIc2x/KOj
	 y63Fz1TtHmZ8TToESxnvYWOMTVSveMGrTZcaMIknd9UgWtxNvAJdJIARndI0GfJnDsGaF
	 NIQa0RvrRRh8Vz1kfB1es8JBPfPGEJLyewhAFHQrZhW10u1ut3a6YX0/cSb05o6XbZg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793381089;
	bh=qDHknVWsbD9yg5C1f0HX7unVB0iUn5ppzQQYgTnfyrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0AlooTJHe6YBJkv+pshoIJVTSnAWZuo3Npv5kTICdYj9O5lrBp7c3JpcPMYdqcQMt
	 1ciW0UGjiQZqeCuUK14IX6w4t4cLv+UILEEdU30FKxPpk0v/6yfR4WyxQCZS8oMlNL
	 4ix/AkeRP5ya2qDIRsVbuo+fOLYXiBgGc+fhSbG+/VyC2eR/1RpImSgK53zkTf+D4D
	 hx86Aoc00e9VQsIaVnfOvLjA15MBhoqyZejF9Ww4hoEFKfFXVIZFkDEtH/Dy34QCHr
	 CGT+bNTjhVGqHNtLiDmPO73ZxtnrM1iGPW+9DJHN9URKieQplFAIaGv0n9OUWy89JE
	 ylmi0wGA/3wuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1561F815B6;
	Fri, 30 Oct 2026 17:24:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B8704235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:24:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E77260AA4
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:24:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cL6ek-QLNobP for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:24:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E394C607B4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::3"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793381087;
 b=Tn7otAr4WrkyhjWt/zKt9gzSJfdaNUi+nFFJJzyrYshomXNHc2EZOZwT7buqlzIA+7e9
 wsgu8uFGVoTaObw5T6f1J/SYNZGYkGYxdRwVQYsLW00E+Aan9Y86aLQrzAihZBCBP0mrI
 XPLlFlheYdYCYcIxwYzBP8wVDXY+ggm6nL4NyPAIPRey02JhXVRKS4Jq+/yxQ3Vqqdi9R
 WJ9PcNw/okP5TxcQQO1krnH0BTmCNcsuyAWl8OsnRmEJpo80GXLzlg7b3gwo0oX1A2Iko
 8/NMGH1ZhL4BSZkRq87ZnRp/UfmzZbArrhC78B6R0yizMeFXzyP202Tgad/fSkHBcQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793381087;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=qDHknVWsbD9yg5C1f0HX7unVB0iUn5ppzQQYgTnfyrE=;
 b=Yy2cp66rCao9/N6NxUueQBta6Y/j7Rdyp8lkrrq5m/mH9jjjqKlhnTNEbabLvwfrvnAa
 JCw/GRREfNF/95dingZp/kJgQ2Z1hiqYUn+opQB926qvRN4wje51czI+sDq+64mUDgQxg
 M/VQx6gY5F0t98JME2CsaJFHngCIYCkC7Wn/t2/NwSE8t1f3SWSAHHRsyuqIG21t0o9mR
 xzXpnqxtabKFeuojMQsG7W8b8OtCRF1LFEEostjT8JYCBAr6eM0+nd6zG0qo8s/mhs4fv
 E1diyDKYbsFo7ub1iBUzE4VjXe7WK3Dvozuj9FdnmY/B3/t68c4SC1T1F2tHuqErgeA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dfoCCV56; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::3;
 helo=mail-oi2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dfoCCV56
Received: from mail-oi2-x03.google.com (mail-oi2-x03.google.com
 [IPv6:2607:f8b0:4864:32::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E394C607B4
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:24:46 +0000 (UTC)
Received: by mail-oi2-x03.google.com with SMTP id
 5614622812f47-5413fa881a9so353971b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793381085; x=1793985885;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qDHknVWsbD9yg5C1f0HX7unVB0iUn5ppzQQYgTnfyrE=;
 b=dfoCCV56MRsRKzjRe0bh/m+XS8Evbo21jTHG9bzGYKSW14iY+YgHHf3c2tiy5wDKbk
 r8loE9KnsdaVxaVmsBkvg4i4Y4BSoo0bq/XaCJF869YF35xGLxUpllXX4/RvM+i+RNKF
 nuOpwtRO9oqULYrNsNt6Ia0EqF4hduhJ7ukIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793381085; x=1793985885;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qDHknVWsbD9yg5C1f0HX7unVB0iUn5ppzQQYgTnfyrE=;
 b=a+wwK7RmKxqC7fANN5o90xcqWW/vEuS+cGb06CV3ZAfGGjrGU8MgHHcR+zQQZEFbvl
 10698ErJFYLP7m4cs/BBzY6/fAZJH8hq2w/U00spZdSZ+6wVETdX4B5hTOlczNxpl3Xb
 F8hxW/Ycg8jRj4+Scc/nuHv3m/Nz52G/lvSLPfA3VDzmpZ1D0vmmM7AfkSmquEcDq04Y
 1SeMayvia1hMcTUq+B/VS5Lh47Nz+3qkjXZuCRKjJo2AkOcpzV98K1en6b4WReuH5sKw
 9TtoS8ZsDzY5T8iju+RJbM25xoZIGy4irpw4740B6rZMVoVKLlixbdun/p1mV7BCKsqW
 pa1w==
X-Gm-Message-State: AFq9FYJ/e9Nor0tonYHCnsx0jaZSE93LoJkStqgC6rVbY08JEyjMggCU
 4G5FyV3FQceWLEOrP4Y46JiXLgXvUPsf7Fe42T59MGR/oLDnr+0o/6yitp4Y2scifO8=
X-Gm-Gg: AYBFou2aP0InNw5OHHJGqIM3n/yWe/fiRD/OyBVBB50SU96kX4zqrhypMIlUzka3gJH
 qJFynj5rYfIcRwaTTip0WB0eoLfjmjqNN39ll2sYqllUteMEwLqgnFJUzSVicPmnAcv1qM111jU
 9Jb46hxf0f8h8ocHJbB/CCXyQcceH5NLFVnXxNID4FpFPdCaYLwf7db/IruHCW/+RoEsyAkFlAv
 zV87D+iGFULuLdt93C3FYpJhnu5Ko45KjqWyjwZZ/c7vFgMWR11mQVPWIVzBPn+RU8ciRw5wxbi
 YruKfhtYgqUOqXhF6y1ld6MF+BJSN/zAA5SGLkTV1RiF/goTi7n3u9kL0pRfIKkHGwDIK6quOXj
 zk2eKa0xe3ZZai3UFhUvDU50qkD3ZJDW2QVXRKJvl9fNnUlSjUlHGXLQVnloP6/gNf1NI5qo+Lk
 l1dzel1cphZrSvBgmiejilIxP2fdJgi4H1AgeM2djDwgIHSHOcuy4AZ8vjHEGqvmEDHQx9sy7n7
 1DWShBXi6DduCY+1D6XMinzFGXPnLwYrPwSKPU3jSWHxs3h0r2aE5/i9ndEo5uzLCDcg3yuq6iI
 qQ6nsE0cihEyMLaBbcLm9h8z1rgI+/bmh4GqvEzyJddWTlrktomCXhw+ZUnC4uQRUyh46bHahg+
 5503hYJM3tfDrK8RDO17ljCE+8Xj912PtOR1S9rluZ8vUTcJMEEYEGWznNhrIk3Ervg3k2nBPdB
 f9CT3IDV/79rzOf6k9ZJchHryPAv/1Pb0=
X-Received: by 2002:a05:6808:244e:b0:4b5:5bfd:518f with SMTP id
 5614622812f47-5640dd09c20mr2249262b6e.21.1793381085381; 
 Fri, 30 Oct 2026 10:24:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fe45587sm1928652b6e.15.2026.10.30.10.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:24:44 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:24:42 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?WWFsw6fEsW4=?= Can <ylcncn@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] arm: clang: use -mthumb when -mthumb-interwork is not
 supported
Message-ID: <20261030172442.GG3309461@bill-the-cat>
References: <20261030073738.165179-1-ylcncn@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/sxNNcwVDIpltmr9"
Content-Disposition: inline
In-Reply-To: <20261030073738.165179-1-ylcncn@gmail.com>
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


--/sxNNcwVDIpltmr9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:37:38AM +0300, Yal=C3=A7=C4=B1n Can wrote:

> With SYS_THUMB_BUILD, config.mk asks for "-mthumb -mthumb-interwork" and
> falls back to ARM code (-marm) if the compiler rejects the pair. Clang has
> no -mthumb-interwork (interworking is always on), so clang builds come out
> as ARM code, about 30 % larger than gcc's Thumb-2 build.
>=20
> Try plain -mthumb before falling back to -marm.
>=20
> Tested with clang 19 on mk808_defconfig: 467 KB instead of ~600 KB, boots
> on an MK808B (RK3066); the interworking veneers around save_boot_params
> were checked in the disassembly.
>=20
> Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
> Signed-off-by: Yal=C3=A7=C4=B1n Can <ylcncn@gmail.com>
> ---
>  arch/arm/config.mk | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/config.mk b/arch/arm/config.mk
> index bce9a31e..b14c5590 100644
> --- a/arch/arm/config.mk
> +++ b/arch/arm/config.mk
> @@ -48,9 +48,10 @@ ifeq ($(CONFIG_$(PHASE_)SYS_THUMB_BUILD),y)
>  AFLAGS_IMPLICIT_IT	:=3D $(call as-option,-Wa$(comma)-mimplicit-it=3Dalwa=
ys)
>  PF_CPPFLAGS_ARM		:=3D $(AFLAGS_IMPLICIT_IT) \
>  			$(call cc-option, -mthumb -mthumb-interwork,\
> +			$(call cc-option, -mthumb,\
>  			$(call cc-option,-marm,)\
>  			$(call cc-option,-mno-thumb-interwork,)\
> -		)
> +		))
>  else ifneq ($(CONFIG_ARM64),y)
>  PF_CPPFLAGS_ARM :=3D $(call cc-option,-marm,) \
>  		$(call cc-option,-mno-thumb-interwork,)

This is a case where I'm glad someone looked at the overall failure.
It's maybe why using clang overflows on a bunch of other targets, too.
The fix however, is wrong. Looking at where everything came from, we
need to look at the linux kernel, and then can see:

commit 22905a24306c8c312c2d66da9f90d09af0414f81
Author: Stefan Agner <stefan@agner.ch>
Date:   Tue May 8 22:49:49 2018 +0100

    ARM: 8766/1: drop no-thumb-interwork in EABI mode

    According to GCC documentation -m(no-)thumb-interwork is
    meaningless in AAPCS configurations. Also clang does not
    support the flag:
      clang-5.0: error: unknown argument: '-mno-thumb-interwork'

    Just drop -mno-thumb-interwork in AEABI configuration.

    Signed-off-by: Stefan Agner <stefan@agner.ch>
    Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

And we should just do the same in U-Boot and reference the kernel
having made this correction in the above commit.

--=20
Tom

--/sxNNcwVDIpltmr9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauTS2gAKCRAr4qD1Cr/k
CpUZAP0b07JeMfRjELMHqCnAsWBhs188jwzpe3MC0nbMpzc19wD8CtPW3/YlDNmG
TL1U6/16d4ODDPHizwoVfzxscJjiXA8=
=quMR
-----END PGP SIGNATURE-----

--/sxNNcwVDIpltmr9--
