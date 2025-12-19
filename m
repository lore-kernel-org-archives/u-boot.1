Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05AEE6689C
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 22:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 035BB803F5;
	Fri, 19 Dec 2025 23:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="O2urRj0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE256808AF; Fri, 19 Dec 2025 23:22:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E54A880050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 23:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766182939; x=1766787739; i=xypron.glpk@gmx.de;
 bh=vcy88OT/8OHHUY0VrR3Pp3QWNTzl3sgNY54XXv8jHc4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=O2urRj0oUdFsNgMhFcWVIOxF4ZcFykiJBd6p1Z5aImxf1apI/DjrPgUlzI2oGxb3
 41CaUatx/1eBexs1V3fnjMyPNScViCgzrqRoWcsF7R4wQtkTp5eHlxXulr0mtZ1gw
 RipYgUDgX1Cp6tDuf7/M3igoVKfBsLAE/eoGvsb0c+FiGxM1Hy/hC45A+cNZTRE6X
 YT96G/SgS2cC/4DK8Pep02d6SDoUpEPVbFSETohqGARbU1bzF6XP6tGms/jL5RNXK
 mNwhCWvEu3hLY5HexibYe2biSHd0E0C/oqg5gU6t8/Jkskw7K0LWJalmjWHBbsCcv
 hFophV8qJBONyUNJcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma24y-1vRAyd1qVg-00RFiL; Fri, 19
 Dec 2025 23:22:19 +0100
Message-ID: <82df5819-5040-4a2d-996a-6456ba223644@gmx.de>
Date: Fri, 19 Dec 2025 23:22:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] timer: tsc_timer: Fix FTRACE support
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251217072558.2949569-1-patrick.rudolph@9elements.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251217072558.2949569-1-patrick.rudolph@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MkLJSjVlIh+qpnF3Ft3e897Fo0ieUiRzlBAxGSvHhojEW6AiPdf
 NULucV9THH+tgVA3u/0BhpBBxdBzoliHwCZLsblqHLc8GB56cLZf0uyD+uvSBwa+vJu21iv
 HIZqDGutMqptqF5+Mc6xoB0BmVyGwFsBXLgGB4av2r5eu2gH4b/5MFwPzRkw62Ny1uToKZD
 pQ2TUToXDCuEpYDmHhc4w==
UI-OutboundReport: notjunk:1;M01:P0:/6O+NwgEXts=;bfstJOYhGltmZBlVgh4cT/4Z2Gm
 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
 9YODWfL4cgkyyDZS8sFZg78xXtd2dDRYJ9o2qk
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

On 12/17/25 08:25, Patrick Rudolph wrote:
> Currently FTRACE aborts on the first function call since getting the
> timestamp causes a recursion and tracing is immediately disabled.
>=20
> Fix that by adding 'notrace' to TSC timer functions.
> TEST=3DThe 'trace' cmd reports that functions have been traced on
>       qemu-q35 when CONFIG_TRACE is enabled and FTRACE=3D1.
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>   drivers/timer/tsc_timer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/timer/tsc_timer.c b/drivers/timer/tsc_timer.c
> index dd16ab320b2..d17fb2337dc 100644
> --- a/drivers/timer/tsc_timer.c
> +++ b/drivers/timer/tsc_timer.c
> @@ -395,14 +395,14 @@ void __udelay(unsigned long usec)
>   #endif
>   }
>  =20
> -static u64 tsc_timer_get_count(struct udevice *dev)
> +static u64 notrace tsc_timer_get_count(struct udevice *dev)
>   {
>   	u64 now_tick =3D rdtsc();
>  =20
>   	return now_tick - gd->arch.tsc_base;
>   }
>  =20
> -static void tsc_timer_ensure_setup(bool early)
> +static void notrace tsc_timer_ensure_setup(bool early)
>   {
>   	if (gd->arch.tsc_inited)
>   		return;

Thank you for reporting your issues with the FTRACE functionality and=20
providing a fix for the x86 platform.

In __cyg_profile_func_enter() and __cyg_profile_func_exit() we call=20
add_ftrace().

In function add_ftrace() we call timer_get_us().

In drivers/timer/tsc_timer.c this function is marked notrace but not in=20
arch/arm/cpu/armv7/s5p-common/timer.c and not in arch/xtensa/lib/time.c.

The drivers/timer/tsc_timer.c implementation calls get_ticks() and=20
get_tbclk_mhz().

get_ticks() is marked notrace in lib/time.c but nowhere else.

get_ticks() in lib/time.c calls timer_get_count() implemented in=20
drivers/timer/timer-uclass.c which is marked notrace.

If CONFIG_TIMER_EARLY=3Dy get_ticks() will call timer_early_get_count()=20
when the timer driver is not set-up yet.

Very few driver implementations of timer_get_count() are marked as=20
notrace (e.g. sandbox, risc-v).

Notrace function xtimer_early_get_rate() calls tsc_timer_ensure_setup().

My conclusion is that function tracing will fail on many more platforms=20
than only x86.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
