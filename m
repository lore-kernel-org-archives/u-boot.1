Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652D8C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CEDF88456;
	Thu,  2 May 2024 15:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vn+kpqJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD2288B06; Thu,  2 May 2024 09:41:01 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E33FF88D2D
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 09:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41bab13ca81so58172925e9.1
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714635657; x=1715240457;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RhGKmefDxnVN0BBtdf1L/zApZQpKymNV9pvjetIZ81s=;
 b=Vn+kpqJ3DVsS15Kfnm6gBhjspbkHv5mE9xaKJM0zwOlcbMVQX2ltbqKL5YiO8Eo4Aa
 0T/dXnpdRkTgeACh/9mQ5Ce2/ZcZnLord/ZSZY84RhNEi3o5S0jzC79M9ZT8hHNbdxWk
 0SEOXdE8fK2gc2gPr14bZ5dIuOiKxP9lgCBq/zSKNqsWx/4y67yfYa07Lvh6gIIAGsuk
 USb/t+WklMH3nYQApD5/sapCF0RsCsCzJbkvoziTi7t+iMW4V0n/Jpab8DhsS0Hb6JXn
 q/q9juZKcC3xKAr6E3GIlUSiltyfCjvhZDEMfw/GdHxBG6A9JnzQcdw/38TsPI5sXbD8
 g6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714635657; x=1715240457;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RhGKmefDxnVN0BBtdf1L/zApZQpKymNV9pvjetIZ81s=;
 b=sv5e9Cj/qWRZGX13nkwyrFeES5sQAHbETpUj7GwBB+xScIB+pKzox/cc/j4sfhNFxc
 3wmTnbRvDe68dWuy6lSTeFd/w62hHmgymODHO8Lpo2ikRQEA1+pQB0ayn7U/R6KYzRh3
 0YBLttj6IVs7mfLpGnbnw4IhClAqTQuSsqH4UhYfgbqEjPnv5lI62oXpiVUFmX1hwVqW
 Hde8JVLitIMomI9Ekm1cKHOe9Ag4Schh6qSTqUeDh9MfZ2+4Y6cKL2WaOsaVn3oDf8RB
 HtIGbOg10+k+jxoknsma9EUxaoT8URPUXOkyiFanJynRedLh3n9PhfmOJNAlBef/zv3T
 D/nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXas/1fqlmuz5Z9MJ1wwBECrw+wNGwXH9PHe7KvXmJ0FB1PdP4PnD5NlsGeoxClnVekQc7bMHA5x763dK8c/Wii+LNG+g==
X-Gm-Message-State: AOJu0YxuVLNtVMOwzE0Zph4htbUM4x6oo4Ns4H9IpYWf3sSJ27oy7C2l
 +PDh+WX3nW6mWLaNzHNzsSjgiEvhHLjTPv2tJNkeNFL544y+1TC1h0/+9zYPq2U=
X-Google-Smtp-Source: AGHT+IEPHMJZR/hIk142TQpi8SoSqvbg/dmjzXgxbaMWDH2nSk23U4qlIANRcJjuCRcSn3PwLS+/Kw==
X-Received: by 2002:adf:a443:0:b0:34d:a518:ca86 with SMTP id
 e3-20020adfa443000000b0034da518ca86mr4531397wra.46.1714635657187; 
 Thu, 02 May 2024 00:40:57 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 e7-20020adffd07000000b0034dbeb12515sm563785wrr.41.2024.05.02.00.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 00:40:56 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Eddie Cai <eddie.cai.linux@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, Michal
 Simek <michal.simek@amd.com>, Bin Meng <bmeng.cn@gmail.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Stephan Gerhold <stephan@gerhold.net>, Linus
 Walleij <linus.walleij@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Nishanth Menon <nm@ti.com>, Igor Prusov
 <ivprusov@salutedevices.com>, Roger Quadros <rogerq@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Peter Korsgaard <peter@korsgaard.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Alexey Romanov
 <avromanov@salutedevices.com>, Sean Anderson <seanga2@gmail.com>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Teik Heng Chong
 <teik.heng.chong@intel.com>, Tim Harvey <tharvey@gateworks.com>, Mathieu
 Othacehe <othacehe@gnu.org>, Fabio Estevam <festevam@gmail.com>, Johan
 Jonker <jbx6244@gmail.com>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Sam Edwards <cfsworks@gmail.com>, Andre
 Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 73/81] usb: Remove <common.h> and add needed includes
In-Reply-To: <20240502013138.2383421-73-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-73-trini@konsulko.com>
Date: Thu, 02 May 2024 09:40:52 +0200
Message-ID: <87o79o4q63.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 02 May 2024 15:17:58 +0200
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

Hi Tom,

Thank you for the patch

On mer., mai 01, 2024 at 19:31, Tom Rini <trini@konsulko.com> wrote:

> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

[...]

> diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
> index fedcf7869295..38c5928faed5 100644
> --- a/drivers/usb/host/xhci-rcar.c
> +++ b/drivers/usb/host/xhci-rcar.c
> @@ -5,7 +5,6 @@
>   * Renesas RCar USB HOST xHCI Controller
>   */
>  
> -#include <common.h>
>  #include <clk.h>
>  #include <dm.h>
>  #include <fdtdec.h>
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 910c5f3352b8..1360a5940fa0 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -13,7 +13,6 @@
>   *	    Vikas Sajjan <vikas.sajjan@samsung.com>
>   */
>  
> -#include <common.h>

This generates the following build warning with
khadas-vim3_android_defconfig:

drivers/usb/host/xhci-ring.c: In function 'xhci_wait_for_event':
drivers/usb/host/xhci-ring.c:464:28: warning: implicit declaration of function 'get_timer'; did you mean 'get_mem'? [-Wimplicit-function-declaration]
  464 |         unsigned long ts = get_timer(0);
      |                            ^~~~~~~~~
      |                            get_mem

Adding: "#include <time.h>" fixes the warning.

With the above fix included:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>  #include <cpu_func.h>
>  #include <log.h>
>  #include <asm/byteorder.h>
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 741e186ee05b..d30725d3fcaa 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -19,7 +19,6 @@
>   * The quirk devices support hasn't been given yet.
>   */
>  
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <dm/device_compat.h>

[...]

