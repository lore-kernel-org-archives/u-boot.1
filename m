Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71939C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 03:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9FEE87A07;
	Thu, 18 Jan 2024 04:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="cmK82geU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20FEE87A0E; Thu, 18 Jan 2024 04:38:54 +0100 (CET)
Received: from mail-m12810.netease.com (mail-m12810.netease.com
 [103.209.128.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17EFB876B1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 04:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=cmK82geU7RaEJK2HJGQbmBlxcBfxE0UgKeedzfhrq2kV2+43jzzocglsGjjqczSQ02b6qB9wlyN80BJMCU3yEYpVss4aj/H01qRRzzIxlT4ng073lv6YQtcIqxElH+2wFdTuTcWV8OrIwxjMrXZEtC/uPp56ozmqbUal/EQ+3UQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=uPODjKJ818MatOBVasUMiBLlgM7zi+iSWrkqaARNb/I=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 86E8A900268;
 Thu, 18 Jan 2024 11:38:45 +0800 (CST)
Message-ID: <61fa5f2f-1847-4831-a3f2-8acab93fb964@rock-chips.com>
Date: Thu, 18 Jan 2024 11:38:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Black and White Artifact on BMP (24BPP) logo during boot
Content-Language: en-US
To: Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Andy Yan <andyshrk@163.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <CAMty3ZCq_d24p68fg1EfWCqmHyDVKZ54UgPDF09GVy0mh4ME=Q@mail.gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <CAMty3ZCq_d24p68fg1EfWCqmHyDVKZ54UgPDF09GVy0mh4ME=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGklJHVZLS0xPHUhKSxoYQx1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1aa658a42eafkusn86e8a900268
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRQ6KDo6LTwtTREtHyoRCSE4
 AUkwCQFVSlVKTEtOTk9CSklNSUJCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPT01ONwY+
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

Hi Jagan,

     Have you check the memory area, does it maybe overlap with other 
area? eg. heap, stack, malloc area and etc.


Thanks,

- Kever

On 2024/1/17 18:36, Jagan Teki wrote:
> Hi All,
>
> Artifact occurred only during boot but loading via the bmp command on
> the u-boot console seems fine.
>
> I have observed the contents of bmp hex codes have changed during the
> function switch after memory to ddr address. (The same cannot happen
> on downstream u-boot)
>
> diff --git a/common/splash.c b/common/splash.c
> index 6820db683b..f97edf8732 100644
> --- a/common/splash.c
> +++ b/common/splash.c
> @@ -175,6 +175,11 @@ int splash_display(void)
>
>          splash_get_pos(&x, &y);
>
> +       if (memcmp((void *)addr, bmp_logo_bitmap, len2) == 0)
> +               printf("%s: SAME\n", __func__);
> +       else
> +               printf("%s: NOTSAME\n", __func__);
> +
>          if (CONFIG_IS_ENABLED(BMP))
>                  ret = bmp_display(addr, x, y);
>          else
> diff --git a/drivers/video/bmp.c b/drivers/video/bmp.c
> index bab6fa7265..dc2928ccdb 100644
> --- a/drivers/video/bmp.c
> +++ b/drivers/video/bmp.c
> @@ -111,10 +111,15 @@ int bmp_display(ulong addr, int x, int y)
>   {
>          struct udevice *dev;
>          int ret;
> -       struct bmp_image *bmp = map_sysmem(addr, 0);
>          void *bmp_alloc_addr = NULL;
>          unsigned long len;
>
> +       if (memcmp((void *)addr, bmp_logo_bitmap, len2) == 0)
> +               printf("%s: SAME\n", __func__);
> +       else
> +               printf("%s: NOTSAME\n", __func__);
> +
> +       struct bmp_image *bmp = map_sysmem(addr, 0);
>          if (!((bmp->header.signature[0] == 'B') &&
>                (bmp->header.signature[1] == 'M')))
>                  bmp = gunzip_bmp(addr, &len, &bmp_alloc_addr);
>
> So, the contents in splash_display show SAME and the contents in
> bmp_display show NOTSAME.
>
> This issue is reproducing on specifics like
> - 24-bit BMP (attached).
> rockchip.bmp: PC bitmap, Windows 98/2000 and newer format, 480 x 270 x 24
> - Rockchip 64-bit SoC (32-bit, RK3288 has no issue).
> - Allwinner 64-bit SoC seems no issues.
> - Downstream u-boot rockchip has no issues. (with mainline vide
> drivers not with drm drivers)
> - Issue observed in boot but loading via bmp command on u-boot console
> seems no issue.
>
> I did check the clock, cache, and memory but none of them showed any
> clue. I did port clock, mach-rockchip code to rockchip u-boot but none
> of the cases resulted in the same.
>
> Any input on this is appreciated.
>
> Thanks,
> Jagan.
>
