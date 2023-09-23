Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8973CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 999FF86AE6;
	Sat, 23 Sep 2023 20:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DRNU1EWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2F2686AF7; Sat, 23 Sep 2023 20:42:50 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02EB486AFB
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-533c8f8f91dso1207332a12.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695494568; x=1696099368; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6NzajYygC7KpvGBYWIfG+CZ633sWWNWBnZmvA0E4WWI=;
 b=DRNU1EWEAcdB6D1I+gZ/SBdheaW8XfkenVJWBN3xHoYJEK97XeTRR6qEjna/aNIKzb
 HdH3jyHBDr1G9KTbO5FpUOT1djcFXLozGSuB1jIqLGsl8Cjm19w6u3ijmWwwQVeVpjsT
 mZad2eeiS5eJXVZwxQZR8whSpz//SpOgZL13Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695494568; x=1696099368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6NzajYygC7KpvGBYWIfG+CZ633sWWNWBnZmvA0E4WWI=;
 b=Kw280ecFTN2JPAQzf3pu6FIURKTYK+QB1VKCMuSJRdg6qUaMrHND2/3g4FweebgebV
 vz/PmOuyl3wgmD+FpklZ28WXxezoyIU6qUDE3KyHuiPZohEIHNxNHZcpbpcCd0Uf9ZG+
 I54uD5e+4g6qmiK4Auh0J9TyTg8hUVnxbqF+8Hcm0xNMYFkbE59HbXEnTWInE/eKqaOv
 7xiJ+PgGIlNLOagj+r714HY1680mfnWBvyv3wZyGMEi8T5vkpw7weAlZ3hy1ktxLIzJp
 fq/i21dTfR5yIfiwmeustweP1jcwhCbGWCqvJGCiltSE28FuaQbY8fesjzJcfGJgcDDi
 YjuA==
X-Gm-Message-State: AOJu0YyGVB07/lYXgvpGjcY2ZTYRUHVBZ9J8fdmF24xjubAvrV4dDFSA
 AQmr76zZepjdH+74/WuXkJVBnTQei3N+frYCTAI61F9EOITwV1oFR3c=
X-Google-Smtp-Source: AGHT+IFYNbsUK/BH/OpNz06FD12D9L9Yjre08bPAahKGwow6GqibH4PNvtadlp1huUuRE2CnrOWxUBR8Mm5GvLkaG9U=
X-Received: by 2002:aa7:d705:0:b0:530:a61f:ed1 with SMTP id
 t5-20020aa7d705000000b00530a61f0ed1mr1995123edq.42.1695494568363; Sat, 23 Sep
 2023 11:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <MAZP287MB050324B04DDD0AA9C6DD905CE4FEA@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MAZP287MB050324B04DDD0AA9C6DD905CE4FEA@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 Sep 2023 12:42:36 -0600
Message-ID: <CAPnjgZ2Hg+b50MmiXrgQQdxmjrkeHW+wqHLfyvuJoUYj1mGAgQ@mail.gmail.com>
Subject: Re: [PATCH] arm: rpi: set boot_targets with correct macro expansion
To: Date Huang <tjjh89017@hotmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Date,

On Sat, 23 Sept 2023 at 12:34, Date Huang <tjjh89017@hotmail.com> wrote:
>
> rpi uboot will only try to load mmcnr@7e300000.bootdev
> which is wlan interface if boot_targets only has `mmc`
> Change it to `mmc0 mmc1 mmc2 usb0 pxe dhcp`
>
> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
> ---
>  board/raspberrypi/rpi/rpi.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> index 30228285ed..08a3648838 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -74,4 +74,4 @@ pxefile_addr_r=0x02500000
>  fdt_addr_r=0x02600000
>  ramdisk_addr_r=0x02700000
>
> -boot_targets=mmc usb pxe dhcp
> +boot_targets=mmc0 mmc1 mmc2 usb0 pxe dhcp

Yes, this is a 'feature' of standard boot, which I hope to fix.

The order you specify should be the same as the default one, so does
it work for you if you just remove the boot_targets variable?

Regards,
Simon
