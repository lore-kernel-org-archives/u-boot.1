Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7DBC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 16:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37DDD87D14;
	Sat, 22 Jun 2024 18:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YG5ukm+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B2087FC2; Sat, 22 Jun 2024 18:36:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B005887A09
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 18:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719074212; x=1719679012; i=xypron.glpk@gmx.de;
 bh=p/zyx1UTv/cpYi62snKjhBWR/HMgAU3y6LmHOsqgXT8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YG5ukm+DnKqsaYFej8Y/r4N+LC8DGY27J6SMsGDTBl37T6ZHOBqe/MW37AqssgxT
 s4lSF1YSS6Ly4z/NUSrhSAFFmexe5dNk+2W3mleQIdet5dgQ7TZrqQ8nCDRYLyq0f
 fiAp+4OLY95mg2QpPg8aQi0bzxMZ3BfVxQsbJHi1N7fo7zaYxmW2qpCXIMbrPddFO
 SZxo/0nsuQui2ojFYozWneNosdEgA1NIwDUOUpTLCsUrkls9ioi/Noe/DQNkn3bdm
 iyDE9eXcLitge/DS6Ksq8CDWMkKXoC9ngKn6hdfjT57cbgvj3zUv60yF5/UfekvHT
 oZA37Yq0+IdNtaQ0CA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOKc-1sczUY0v3m-0144Ej; Sat, 22
 Jun 2024 18:36:52 +0200
Message-ID: <2a1d9bf4-1790-4186-b8e0-3a5001af9f72@gmx.de>
Date: Sat, 22 Jun 2024 18:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: adjust config options for capsule updates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, jhumphreysti@gmail.com
References: <20240620201531.321110-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240620201531.321110-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SLiSBA5Tc4MWS2U5U8sW+kMF0LnNNjwk5lUwYNQTfjjvC1FIf2D
 MINp4f/iGMOjmszisti7xvwigqORIPmCcnQRPzgweLJUoC/f0lZ1mJOn8pNytjI0mQq2Cy8
 SmcgZsNbsQbbI22XmiVV46Flw6tCn/EaFyZt3tOS3K2/kDVfhOjSgxY9evUti2SmXlRenSO
 o+j3sfsqDaf+3X9jBor6A==
UI-OutboundReport: notjunk:1;M01:P0:zegR/XAr/m0=;+PwbyqcHsogFxGmjCPRLh1YHYF/
 tDjRALi5A+VyZvifrpD/82qOxfkQh+faMZ1nxH4kVZu/ETCos5yg5JSCTHONnDrEBvOqsIiW0
 rteFBwl1yCaNcMg8S1sXpuNswoRssN3QrM+a2kg5Yo3TTe8fj/WKso5vd05b0daOI9/u/TpsL
 MsqZLHiFZxzJj+QASVYLsY7Voh5/AYgtpNAnUzN4UWR4SvIc1ch9PYYwJ1gaZ1u+V2FmSipjf
 kKyqBuDhfV1z1yYiPEqGQ8nR0hAcvukQxbvN0NI7Mqwnu1/NrduK6kh4vl/pn3gIN5Ug4G6bd
 cQznamdsOcyYnXIhWTASJSuWTW3KWC0YwhOA1QHva8PSKxdoybP6jwWYMECXlz+tIzq5qdECl
 IvDDHZ6gQeDSN6C4cW4G5lE9O65CA6AyPALIGW8WYFLQqKRO/vonyyYxQJHwa4MyJTizD1Wpo
 RBJbaXN4TTdNB6nvVSYLYPzBis9w+zsCMba0Rm03tSxviYuV4ofhI3eackwdaaUMJwLl4uViB
 LRRlb1hEZsVNbfsOqCL67OPFQEzx5LYneLp5Zu48MoOW/H02tO0zzpHLoWcYsZcXbW3feYcvV
 s6s4R45ZtSaKUare+1KfJ78n/W8ZqFGbr3pX0aSmxGUvEr659J5LFligGGyUEO+QL67eZCfpW
 LaTCNDf28yxIY2Ki+OY8qOy4k2a+llt1NM/G2KF612ATXOR10eogiDZwC2BjwekAL+8+Dzcel
 zXA021yXLYGGwNeSdStiH0DA51xUk1PUNmoOZU1Cppxn4RhJxVfW866g37T9OBFbclrtIRcBs
 q13phErUDCWiPEEiszRSTQFUXY9J+j1WPqTPWsKC7llrM=
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

On 20.06.24 22:15, Ilias Apalodimas wrote:
> EFI_IGNORE_OSINDICATIONS is used to ignore OsIndications if setvariable
> at runtime is not supported and allow the platform to perform capsule
> updates on disk. With the recent changes boards can conditionally enable
> setvariable at runtime using EFI_RT_VOLATILE_STORE.
>
> Let's make that visible in our Kconfigs and enable EFI_IGNORE_OSINDICATI=
ONS
> when set variable at runtime is disabled.
>
> Since EFI_RT_VOLATILE_STORE needs help from the OS to persist the
> variables, allow users to ignore OsIndications even if setvariable at
> runtime is enabled.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

So this v2:

v2:
	allow EFI_IGNORE_OSINDICATIONS if EFI_RT_VOLATILE_STORE=3Dy

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index ee71f417147a..6006e845cb1f 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -220,6 +220,7 @@ config EFI_CAPSULE_ON_DISK
>   config EFI_IGNORE_OSINDICATIONS
>   	bool "Ignore OsIndications for CapsuleUpdate on-disk"
>   	depends on EFI_CAPSULE_ON_DISK
> +	default y if !EFI_RT_VOLATILE_STORE
>   	help
>   	  There are boards where U-Boot does not support SetVariable at runti=
me.
>   	  Select this option if you want to use the capsule-on-disk feature
> --
> 2.43.0
>

