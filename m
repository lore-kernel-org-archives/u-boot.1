Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CE2C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 17:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A8E38882D;
	Mon, 29 Jul 2024 19:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="mBMVoXdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2578F88835; Mon, 29 Jul 2024 19:58:04 +0200 (CEST)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3436188791
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 19:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id D48F6240104
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 19:58:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1722275881; bh=JdvW2nU/jaz6yIZS70rbzYQok3EkKm52SoB8VMDvfng=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=mBMVoXdDDFHUWqaIa9JpEnqzgH3XUQ2G3BY8A2LdijaB225BPM8xZSch6R/B1hzhT
 gyhLdYhu5ycyyx2hi44By/9schqHvTjZ1lRcDlHehHgX/ORPOwzOn7aebOTfQtoQKK
 5d/r+745HZXRfehKcOp+kPAD0h5zp1wQuD1MrdJvAWk+B7Lbxg/7lcJj4EdAYNKmAZ
 BzgpfdanB4hZAj6XIP+le0u07fM/iRoiPxn5s8VxYAcbq89pC5fDSpiOkjN7MqTklk
 KBCrsHmlxSxVIQy0eP0tpMxrMfXMz5T4FGh8g7u+ra5owSQjeDpYBrWuL9ncvjnb04
 x5C4tGBhjcwfw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4WXmL10MQ6z6twV;
 Mon, 29 Jul 2024 19:58:00 +0200 (CEST)
Message-ID: <8babad6c-92c0-7299-19e0-904b62e6143c@posteo.net>
Date: Mon, 29 Jul 2024 17:57:32 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 06/35] arm: friendlyarm: Avoid accessing global_data
 fb_base
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Albert Aribaud
 <albert.u.boot@aribaud.net>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240724150922.2343249-1-sjg@chromium.org>
 <20240724150922.2343249-7-sjg@chromium.org>
Content-Language: en-US, de-DE
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20240724150922.2343249-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On 24.07.24 17:08, Simon Glass wrote:
> Use the new video function to get the framebuffer base.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

Tested-by: Stefan Bosch <stefan_b@posteo.net>

Looks OK, tested on FriendlyElec-Board NanoPC-T2 
(s5p4418_nanopi2_defconfig).

Thanks!

> 
>   board/friendlyarm/nanopi2/board.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
> index c8cbc5a15fa..b32dfc6b570 100644
> --- a/board/friendlyarm/nanopi2/board.c
> +++ b/board/friendlyarm/nanopi2/board.c
> @@ -11,6 +11,7 @@
>   #ifdef CONFIG_PWM_NX
>   #include <pwm.h>
>   #endif
> +#include <video.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   
> @@ -492,12 +493,8 @@ int splash_screen_prepare(void)
>   					 ARRAY_SIZE(splash_locations));
>   	}
>   
> -	if (!err) {
> -		char addr[64];
> -
> -		sprintf(addr, "0x%lx", gd->fb_base);
> -		env_set("fb_addr", addr);
> -	}
> +	if (!err)
> +		env_set_hex("fb_addr", video_get_fb());
>   
>   	return err;
>   }

Regards,
Stefan
