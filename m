Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4EEC0219F
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 14:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6645886DF;
	Sat, 14 Sep 2024 16:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NPc0pxzT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 011FF886F3; Sat, 14 Sep 2024 16:44:47 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D9CA88675
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 16:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726325081; x=1726929881; i=xypron.glpk@gmx.de;
 bh=HpRIvt+wevprDNji9QprGD4R5mJLPXJD4TZu8mLdoqM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NPc0pxzTl9cHKiJqXx12gTVokISRV9OKNKkb8b8GcacPu8AX2QDArjwIkj4Kw+/m
 GFIoREoUefm6ACI8IjWAvrFmaZDwDzx4zqzNA8tSxfEGcCjK2sqdNtPuxGyiof+Bq
 UDdAy9827jm+CXPwe8adIXZ6yP4bWBaK5YrS7n1uCd5V0jmSHUAIuy8CamyA6yeJc
 +4V+HWOXTSotM4lQFC9hnA1Il87vDfMKxgBnNzb72C43jtDqa50deNy1JhRKP3aCV
 wqZufU7QB7tM3k/Xz9K0A4MjKk41XUZKDN7QOGTdhdzW3WpJ2yz/+LX437k7PvIuA
 pm9kI12x1SLJLjS7Lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiDd-1sdl5C30AB-00WSql; Sat, 14
 Sep 2024 16:44:41 +0200
Message-ID: <b83d04eb-bc3a-4387-b812-6973d851ae90@gmx.de>
Date: Sat, 14 Sep 2024 16:44:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] lmb: add a flag to allow suppressing memory map
 change notification
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-3-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240905082811.1585467-3-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vWL3OT7VxdZYh4vzvQPYB/s1MsyMypm72+9uYONGXG+OKO0oBXv
 CpEQAQrBPNlFs89wFpC8IIHEIJHZlMSSyo7TascZult6M57tIeySobL3hJ34EJhnWXP40d6
 zD/dQa1bKVl/xHmiijRsiM0HrfUAVSHc9ym6rl5+6LDUV70ra6BooNG1VS54RMfV+RUTPX7
 0nFEMuePR0ZreFK3JKPyA==
UI-OutboundReport: notjunk:1;M01:P0:9oyfe1rNZUY=;S6uGOCyyUnzubDwhsLOo2jWCfI3
 Gs+dBKUc5pIXXGLfQYVjCB0J8j/Quu/NpWv6Kn65NMxHpc+SG0s+LVQMzzGSCfE1NGOKmV4/L
 djz5IjIHHGi3nMerYWcacFwuU6hwndGE2gkRpMp8veW8FNmiqmf1jIMYeELDKJMULCtJROVP/
 PS39MNHePtpCO7jZCxBWAklLEVr7BF3Nmea7upzVwCaKJJO4r+2y5t1r2XOReVsK2Jz0+IqlQ
 8rLvJgkKbIargC/lQdPKZ+4pua0UKIAd5QpwZdaN/eXOAMpGWax+NfjMS6jo13igTyTjctyVM
 22pgxR3OsiHQnRf8pUh3LaVoukD6lqlygb5klEqIuFc8GzT+DGmcfEXlIK8CLuPntCIthTtUp
 7h61BztjYDcYBMvktV4qMOeuDE8a0P8pHilLPFdjYUiafMWw5RLb9UVSIKv3SaseW3AIPKFI7
 6BzINwpM2UOA20InZB4DnkMggyj4EDp9AH+V6GEfo70QK/TJZuei2zXQXhy5uTmKRZnNhRu0/
 vqJ20NKJ+a0GUU3x3174kVZ75c1V4YnePafT9LwG0Zs8r4bfe/NVH6guMErGo+SqfQI0VpoA/
 sVKUCbi2xc3kh7C9AYyut/zo+yEvxxuF2uGiA8jqUHTVL2duo7idHc7NpKrjA9Kxppl6JmbWx
 Uf5ue/HJVmZmHO19L9Ej1rPxCdtuZZ58n4fhQ92Are+JlfTsmj9uT7B/Xd4BrTpr2Qta9ozzh
 ILnMzyixZItHvbtX3th1XqNRcO5+ArquHQfCOs9DWFfgtnSGNto8XE8oZmFqxtuplvm0DvMvN
 oGOS5yjx1WnsMyb+Y5mDRYxw==
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

On 9/5/24 10:27, Sughosh Ganu wrote:
> Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
> reserving memory. This will then result in no notification being sent
> from the LMB module for the changes to the LMB's memory map.

You seem to be using this in patch 3 and 7.

Please, describe in this patch why you want to be able to suppress
notification.

In the EFI context we should use LMB notification to notify the
EFI_EVENT_GROUP_MEMORY_MAP_CHANGE event.

See chapter 7.1.2 EFI_BOOT_SERVICES.CreateEventEx() in the UEFI
specification.

Best regards

Heinrich

>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   include/lmb.h | 1 +
>   lib/lmb.c     | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index 45a06c3b99..ffba7e2889 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -23,6 +23,7 @@ enum lmb_flags {
>   	LMB_NONE		=3D 0,
>   	LMB_NOMAP		=3D BIT(1),
>   	LMB_NOOVERWRITE		=3D BIT(2),
> +	LMB_NONOTIFY		=3D BIT(3),
>   };
>
>   /**
> diff --git a/lib/lmb.c b/lib/lmb.c
> index da6a1595cc..419b31a651 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -30,7 +30,7 @@ static struct lmb lmb;
>   static void lmb_print_region_flags(enum lmb_flags flags)
>   {
>   	u64 bitpos;
> -	const char *flag_str[] =3D { "none", "no-map", "no-overwrite" };
> +	const char *flag_str[] =3D { "none", "no-map", "no-overwrite", "no-not=
ify" };
>
>   	do {
>   		bitpos =3D flags ? fls(flags) - 1 : 0;

