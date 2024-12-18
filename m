Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B75E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 19:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 076218021D;
	Wed, 18 Dec 2024 20:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=writeme.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=writeme.com header.i=sinan@writeme.com header.b="BbWl5elA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5234480291; Wed, 18 Dec 2024 20:19:08 +0100 (CET)
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C43628021A
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 20:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=writeme.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sinan@writeme.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=writeme.com;
 s=s1089575; t=1734549537; x=1735154337; i=sinan@writeme.com;
 bh=DDQZiBJ4CF8RHGFLGvwAZV4pxnV+UrB8QBQXfXl3ELM=;
 h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:From:In-Reply-To:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BbWl5elA+5IwYtjszwE7WDNh3hwmJXVXM5maJcLOeEnme1GQqbaVTK+Y6AmcvPG4
 peanoN1s5m0V5qaauEqjHfz50ydgnUAUMOMq3MJJaetwHQHelSSIkDxCbPUUmA0VW
 N9WnvHaB0n53WJwFQ0+wmzv3DGedprA1US9kIkjPp+rHw5VLUScYPD2cUyppk8Dji
 12juEUCkzaCRiQ2srpDqwxiSXb+WtqLnh3ZsJsxAaDipy4TjjMMYNtKc7uG5KUDTU
 4aws1zSt1QahNzAV46gQkDuG+rxLTQB5h94GTQ9KGmpkvrMa5qw/+W9/H8IqKaUWj
 OjvyQ8dm3spmN3wo3A==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [192.168.4.12] ([208.111.77.233]) by smtp.mail.com (mrgmxus003
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0MKow2-1tNzZQ45XE-00A29W;
 Wed, 18 Dec 2024 20:18:57 +0100
Message-ID: <8941d7ad-84d8-480b-be64-fcc0a3e48dd0@writeme.com>
Date: Wed, 18 Dec 2024 14:18:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] powerpc: mpc83xx: Allow including initreg.h into
 multiple files
To: j.ne@posteo.net, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
 <20241215-mpc83xx-misc-v1-2-8cd6daae4f93@posteo.net>
Content-Language: en-US
From: Sinan Akman <sinan@writeme.com>
In-Reply-To: <20241215-mpc83xx-misc-v1-2-8cd6daae4f93@posteo.net>
X-Provags-ID: V03:K1:1yDZokY/KqRvl77kdux3r7At/iP+l7CzdpvWuk+b5lsKOHAZsoQ
 3SFNmB0t0UeCYz5nrPShV7WWVZxevCZdLaKZo4OUc3eGdDLuGd9pUlFcVgA1oxiv/OVKWNz
 h8H0Ebs+gsqoJAxdve+zPgxNsu6i/F2lFRrh7o1rbS9qADgW7yWMUKj2dXjZX4h/OJ0R8ov
 bFw+5P2Cvjb5qQYZ51+Ew==
UI-OutboundReport: notjunk:1;M01:P0:HHGqVvL9cRM=;AFT+c4AXtclgSQ3KLIyd4XtOfs/
 /dzVbcffA+/q0/M+QxfmHbCP/mvTM/JkXDLqCVwfmmNrA3+JgldaLbKlio/Ct1wH+oDTGket/
 cHPwZNtC8NngOCWHkDBsjLoDCmTJNyOSSgrAVjjQdXZjMbw1lKoIlGhHkUUldJN2FhMv+ez5d
 XXur9I6xyPZnqK4Yeo4LiZTIgQM/b1n1hmfbp9qPK9NOmntymO/ggoeDQh3vByuEFTwTZdA+w
 Qc+rH7LOU6mO1/x2mPmmVwm/7lpBSTalaBbl9K9FfM26a10p+Qv1fa9LtvguTcmSXxHPMLbiH
 pRd2iSSwM6r6bQym66i8Hf/KmP8PZfw7sW7DIYa4uPpDrlf6OcSPpW6XrYmmGlH4LD9xI3Drx
 fDNNir9gwuHBl2htVcdPE8fKy47GapX4E1nMJJcmepT8qvb3S8iZWzP4V7zPTpcohqCYnqnjB
 LglFbBLdfkNgyM3NxpL6vBS/embRs6KVH5+8CAU51xI3LjH7hJ87cMwox56E4oN1SlFsu0LPX
 J70lJNFt8fB1Ziphu7ZGEtB8TIGGR8vY6lvZnizovcsd9icOCU+JLkdY7D7CfJPmJFed5byoF
 oglHa8uGAUipTe6ypxrkHHs7mDSEnQwurUGUtp+m78j/Lpk7zeMXqWRS/4KqioL0Frx7YAyQU
 /Jk9uHxHpm9HPm8InRhnlZXTYA8gGkkTBzmtfAbTgSgHvGUiw3+fo5AcCaLFY4V/hAvc0SujD
 fIsE+29oWkGLhTtzCaCssrWk/SXGCaY4SPlEND5JXzI33+wpdnP3OrwTLS0O0SbPR7tcwvdZ2
 /onCNkAbkd9X8lz6q3KMy6b2qhvOwCQIHSaYeHTrfab2Puy7QKs6jOUmuCGT9p8hOIm4wKamf
 8uHasDEoonxnyPYkLLUzHDfRKRG/tGyaiSTQgiLvblA346sQXrsLLQ68p/fk3fx/Oqzwxo5eE
 3xe6NB/DvdL/P82JGFMVDccZYc/iPtZv2UEudtCGHmNWBCjrPuT1A/ZKIlAk5HhSoNogXhp2R
 tj7wry+NsHIgc3/MHQQxLS4gVE5D3ME8j1plcZlt66lGQEbVrg1HrVaz6sRYkmhYOCFrC53FV
 O/qJh8F9vsvdSpteYlpqiroazUuymDS48GmW/EYknjr+Pqm0oQ7Tm4A8OYZIN/5XXAnmnhqx8
 =
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi

On 2024-12-15 10:18, J. Neusch=C3=A4fer via B4 Relay wrote:
> From: "J. Neusch=C3=A4fer"<j.ne@posteo.net>
>
> Globals defined in headers can result in multiple-definition errors
> while linking, if they are visible beyond the current translation unit.

Is this happening anywhere ? It seems you introduced this in your other
patch :
[PATCH 3/4] powerpc: mpc83xx: Use defined constant for SPCR[TBEN]

If this is the only place you are seeing the problem, can we not protect
that the file
is not included multiple times ?

>
> Signed-off-by: J. Neusch=C3=A4fer<j.ne@posteo.net>
> ---
>   arch/powerpc/cpu/mpc83xx/initreg/initreg.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/cpu/mpc83xx/initreg/initreg.h b/arch/powerpc/c=
pu/mpc83xx/initreg/initreg.h
> index 63aa5c946696ee0368bb3453b40ff0110f0fbcfd..ea1176e7fe10dbb549125ab6=
b2706fee05a92734 100644
> --- a/arch/powerpc/cpu/mpc83xx/initreg/initreg.h
> +++ b/arch/powerpc/cpu/mpc83xx/initreg/initreg.h
> @@ -13,7 +13,7 @@
>   #define SPCR_TSECBDP_MASK	0x00000C00
>   #define SPCR_TSECEP_MASK	0x00000300
>
> -	const __be32 spcr_mask =3D
> +	static const __be32 spcr_mask =3D
>   #if defined(CONFIG_SPCR_OPT) && !defined(CONFIG_SPCR_OPT_UNSET)
>   		SPCR_OPT_MASK |
>   #endif
> @@ -27,7 +27,7 @@
>   		SPCR_TSEC2EP_MASK |
>   #endif
>   		0;
> -	const __be32 spcr_val =3D
> +	static const __be32 spcr_val =3D
>   #if defined(CONFIG_SPCR_OPT) && !defined(CONFIG_SPCR_OPT_UNSET)
>   		CONFIG_SPCR_OPT |
>   #endif
> @@ -42,7 +42,7 @@
>   #endif
>   		0;
>
> -	const __be32 lcrr_mask =3D
> +	static const __be32 lcrr_mask =3D
>   #if defined(CONFIG_LCRR_DBYP) && !defined(CONFIG_LCRR_DBYP_UNSET)
>   		LCRR_DBYP |
>   #endif
> @@ -60,7 +60,7 @@
>   #endif
>   		0;
>
> -	const __be32 lcrr_val =3D
> +	static const __be32 lcrr_val =3D
>   #if defined(CONFIG_LCRR_DBYP) && !defined(CONFIG_LCRR_DBYP_UNSET)
>   		CONFIG_LCRR_DBYP |
>   #endif
>
