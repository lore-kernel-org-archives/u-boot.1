Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CF9C27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 10:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ADBB87FC2;
	Sun, 16 Jun 2024 12:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="U2rn/Rd/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68938880E5; Sun, 16 Jun 2024 12:34:25 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 716B387964
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 12:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718534059; x=1719138859; i=xypron.glpk@gmx.de;
 bh=4WBs9+jhomsmqsTsJUaGCjeP15pm3/ojkuMNdn/Dcjc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=U2rn/Rd/XH8bxEQtZAETaWrb/O8nTD39nC3hHAx1PaPp3l3x2CRm2kDhq0G71Jjk
 hyi0mzfgx/WtvUcUo32suGlJfmUN1U3tpmH7I1NpVswC5CfgpryEHx2xZRme+kaNe
 rwqKU0uyLXJdndUU8tDK0V/oh5WjQDYOAMuXljMuN2UOi7FskUxDg/6V2bOUwco6s
 +g7Ymm+HZcUzq6fQAwwd8Y9YokRYP5UJ8/97dG+b+3jaqzeJBBOH6oQIcmP3Uj9L8
 IqCa5MN4dQmhTpjZNlJxGFv/1kZeXXmA4Zu+u+7L5Lw4DodQHgMxDQuLRRTxXXYmN
 6ourzjVFx5QJ1t7kAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPogF-1s5Mpk0fi7-00UBNa; Sun, 16
 Jun 2024 12:34:19 +0200
Message-ID: <9a67f17d-b6b4-4843-aef4-394b2a34122f@gmx.de>
Date: Sun, 16 Jun 2024 12:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] elf.h Define LoongArch bits
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-4-1407e0b69678@flygoat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240522-loongarch-v1-4-1407e0b69678@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rvK3bkglM/2WNY48OuvqOUX/54Wvub31LZsm8FHIrk18+3CnX9O
 EzD5Wiy1YLFAooLn6Fh6mC3NyBZ8hkEZcQ+pQNpZ0puinfrrMHDd0rht+Dc4OWxsPW+/HyR
 7E9KyQ/5ZgodExPI4TphORbAbHTSh5+1YjO2siWdQZ+bZRITAJ39ba3e+UZ25wOMdRchcTl
 lrS7U+dFIq4DeGCrb0xzQ==
UI-OutboundReport: notjunk:1;M01:P0:zlFax/jfURg=;eHzo3b94TA8mHn0ReTv8u6wxCiR
 HMz5yzi8HvSWdoBmlMHRjsg6SKSLXL9mcd+ggoUJqgCKWNIZO8e1lH6ej+73S0C7McrcV93/W
 mzbY5Rqvtf/3NsIwfcrfQrmrRQbNKs1fTU77YuFbwKiDbjVJ6tMfHJLyBXO2ijhjH1LO9jd2/
 WWMZ0O3zwtJZRPZXRzt8n7XBjyCj1kEobN1yEPIN/SQTJu/+1KsqWyMELmC2GB2yTTIfXEmOO
 F1p+b+bmWAFX0agfaPtYJ5l/bReJzdMJpG7NcDePyJLJrmGERUV9KvLOtYanuw1Isw4hiEDXh
 W2FRwQo4G8Od2PCHASXQJwCsAMyOQwZ/t/tHPvLb/IkkvTskdxfN626kSeUjG8WSdLbGnwjcB
 Zx62xKbAJTZyzFEm2GbKNULl7bQAfdtLFh+VFk92doph2dK5fRD3epbrSH3W/OYoYhb07namM
 TPPWVcCyFXF+H3Ic8fD6G0XGc+QEVIhb/xdBQTsEOcuZHWsUXms2ZaN+V2aLbpbIYGvCJdoa7
 8ZcC/tpI+rnevZpnp2mGKOF5lwqNd9gVsHaUC4E5zI05YxCLy/GDnJwPH4m7gPV1AKvn/4plt
 PP8+3m8wpUlHSfgODsn30cy09TEa4S6f97YyJRbKawvNwYJsH9B0w8MyAcZvDU0eM0imYAA6M
 uiSX5kmr/z6esm8EgP4cKwYEaCY3hzbZAURxMQtNcGZdnT1RR6zeH5IZl+UlLVY3mfLTJSREv
 pYjukaFy5DTGmFURgq9L9t3+drssFIDd4fD6gp/lJA4FvPVtgtrfaP5aGp6vz/4iGMtDYFKKM
 ftGOMLbph7GeeUo1W8ZPAhFPV7ir3HNblVWmV98ckO+xo=
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

On 5/22/24 17:34, Jiaxun Yang wrote:
> They all come from glibc's elf.h
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   include/elf.h | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/elf.h b/include/elf.h
> index a4ba74d8abeb..cb3bb20c4f2e 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -219,7 +219,8 @@ typedef struct {
>   #define EM_MN10300	89		/* Matsushita MN10200 */
>   #define EM_MN10200	90		/* Matsushita MN10200 */
>   #define EM_PJ		91		/* picoJava */
> -#define EM_NUM		92		/* number of machine types */
> +#define EM_LOONGARCH	258	/* LoongArch */
> +
>
>   /* Version */
>   #define EV_NONE		0		/* Invalid */
> @@ -699,6 +700,12 @@ unsigned long elf_hash(const unsigned char *name);
>   #define R_RISCV_64		2
>   #define R_RISCV_RELATIVE	3
>
> +/* LoongArch Relocations */
> +#define R_LARCH_NONE				0
> +#define R_LARCH_32				1
> +#define R_LARCH_64				2
> +#define R_LARCH_RELATIVE			3
> +
>   #ifndef __ASSEMBLY__
>   int valid_elf_image(unsigned long addr);
>   unsigned long load_elf64_image_phdr(unsigned long addr);
>

