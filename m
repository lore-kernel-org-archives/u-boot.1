Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A23C7EE3A
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 08:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D210688966;
	Thu, 29 Aug 2024 10:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="g3U1ns0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E05788B8E; Thu, 29 Aug 2024 10:43:58 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DCAF8891E
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1724921034; x=1725525834; i=smoch@web.de;
 bh=zSANLzi9uAAZqdMWQJX2oGUv9CtF5dT+E2Zb/c/8gZw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=g3U1ns0lN+INq7QfaWTA4awrzLHLyw5AfD/Nk4cKj1jEuA5H9Bny5yk2o43RSfO7
 XxvYB4g55vpIvUJL/d0UCcyyskMqkLpryK7md1/n+P+CP2698W4erxVuEwCPkK1XM
 soScScu4YtsxAR/lWAWDqwkj5//FyxtGStV134a8rbtawyBP+mJZXFJfDDwfTZOHz
 /V9F/Ye6LrkI198iq34do0RhYAuLXZzdkuO+f0KqmuYU14S7L5BZr61lKV8Y7LGO9
 tyPwip+SkHWkMr9FuCzQ275w83L84xiy/Li16WLwvfKYF5UCCuBzfP2eDAPAVxS49
 9qT3zWG16WC0PeExlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.1.40] ([77.191.136.96]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZMD-1sdJLs46ED-00ZBQh; Thu, 29
 Aug 2024 10:43:54 +0200
Message-ID: <9b177470-a138-42f8-9ddb-5f4fa01e5d32@web.de>
Date: Thu, 29 Aug 2024 10:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] imx: Remove CFG_MXC_USB_PORTSC
To: Fabio Estevam <festevam@gmail.com>, peng.fan@nxp.com
Cc: marex@denx.de, u-boot@lists.denx.de, tharvey@gateworks.com,
 Fabio Estevam <festevam@denx.de>
References: <20240828132529.3098961-1-festevam@gmail.com>
 <20240828132529.3098961-4-festevam@gmail.com>
Content-Language: en-US
From: Soeren Moch <smoch@web.de>
In-Reply-To: <20240828132529.3098961-4-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:t+jSAXjTBeOfDTcWhMbCg2Y7vEJrjBVY1r2C/GJ5im2dcvu+767
 y4vvmua+ySke3ryUxJgONcsMnBXUp+/EOSvlmrwsCb++yr3bB4spaAiMD2h+YNJqRk4eywZ
 7JZb7Uu93lyyFgOJGl3JiQINBfi8T5UWH8LovcW70HhVpuSnVUNdjf9GB9GyveQoUwFybWh
 f+ZF+rmCDvD05c1Fzf+gg==
UI-OutboundReport: notjunk:1;M01:P0:ctoGCMolHpk=;zf6dQMPaggKEoBJBgFpwHQW2RC7
 2m5y8DcNaTQU4NFgAh3pauX6swIkF8EqobLgTC+khizwzl+ln3lJszJM4e4Wk3KkjgcLIoCwb
 P4/9nBO/4EP4iFqJmzSnZJQ/jD0lBqgVXn5y5V5QrHYL9q+c1+RS8jSdjv9bQV1bmtMXMkKxg
 aTgbgkruW4Qd6VoIBN04rX4MR7b0aZFKSlkuellVe8qk6SDTmP4+cfxJ2hZuS4eush+DQeYsu
 9rfVYNHzXmDchSA39QGEmrAU9MbIk0yPw+ItfOe46awc2TIHEilRgtSHQR0dqu9DZejNvMS1t
 JHNzBYrKrUVu6Bb0mirxRtM3AJncxFq1JfNU3TUU4RQD8lAX0ik0a6pwxOAX3NXdl334d45sn
 5VocMESQtGF6V2BCI5sAgUr6mQZBZVNxYwvOR7gAsk0VEAGvC6Lh8faACrYx9PmtkG/Sp867s
 6XhMvOVuW2xx32eGWOrK5PlREKCEl+2mlMMd0FHO3cpwtk8yX99T1mwK7ze/RnFKHiBrlg8rp
 2dYVTsOSvh9d7ABwBzBGqdJnh+hdoWx3YvkaYBYfE4rfCB2hXG2NzSAFciX0+jpqkyY1AfRwT
 ycSP6cIGM84Z4GblaUtrNxCc+tFPs5xW/VD+2a5jCriYjm26w0YKys5O80RNfEMCcwv+NF/Ko
 eAWQR9sFVcjQf/2vR9GP2BXykNOL9fkFdykGqQBjX75PYj5a9SRXt46GMljGisi56ECg+yLyM
 3dYieyrGde3V9PPEtqHBs1jT/90dSWy7DR6t5DA+SXLkJB45hMmMtay/JBKcBcpTHoNbiYBfJ
 T5N4fiR0Qyr3iaakROI2V3kA==
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

On 28.08.24 15:25, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>
> The definition of CFG_MXC_USB_PORTSC as (PORT_PTS_UTMI | PORT_PTS_PTW)
> can be removed from mx5/mx6/mx7/mx8m board config files as it is the
> default in drivers/usb/host/ehci-mx5.c and drivers/usb/host/ehci-mx6.c.
>
> Suggested-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> ---
> Changes since v2:
> - Keep mx51evk.h intact as it uses a different CFG_MXC_USB_PORTSC
> definition.
>
>   include/configs/apalis_imx6.h            | 4 ----
>   include/configs/aristainetos2.h          | 3 ---
>   include/configs/brppt2.h                 | 3 ---
>   include/configs/cl-som-imx7.h            | 3 ---
>   include/configs/cm_fx6.h                 | 3 ---
>   include/configs/colibri-imx6ull.h        | 4 ----
>   include/configs/colibri_imx6.h           | 4 ----
>   include/configs/colibri_imx7.h           | 4 ----
>   include/configs/dart_6ul.h               | 3 ---
>   include/configs/dh_imx6.h                | 3 ---
>   include/configs/display5.h               | 1 -
>   include/configs/embestmx6boards.h        | 3 ---
>   include/configs/ge_b1x5v2.h              | 3 ---
>   include/configs/gw_ventana.h             | 3 ---
>   include/configs/imx6_logic.h             | 5 -----
>   include/configs/imx6dl-mamoj.h           | 3 ---
>   include/configs/imx6q-bosch-acc.h        | 1 -
>   include/configs/imx7-cm.h                | 3 ---
>   include/configs/imx8mm-cl-iot-gate.h     | 3 ---
>   include/configs/kontron-sl-mx6ul.h       | 4 ----
>   include/configs/kontron-sl-mx8mm.h       | 4 ----
>   include/configs/kp_imx53.h               | 3 ---
>   include/configs/kp_imx6q_tpc.h           | 5 -----
>   include/configs/liteboard.h              | 5 -----
>   include/configs/m53menlo.h               | 7 -------
>   include/configs/meerkat96.h              | 3 ---
>   include/configs/mx53cx9020.h             | 3 ---
>   include/configs/mx53loco.h               | 3 ---
>   include/configs/mx53ppd.h                | 3 ---
>   include/configs/mx6cuboxi.h              | 3 ---
>   include/configs/mx6memcal.h              | 1 -
>   include/configs/mx6sabreauto.h           | 3 ---
>   include/configs/mx6sabresd.h             | 5 -----
>   include/configs/mx6slevk.h               | 5 -----
>   include/configs/mx6sllevk.h              | 5 -----
>   include/configs/mx6sxsabreauto.h         | 4 ----
>   include/configs/mx6sxsabresd.h           | 4 ----
>   include/configs/mx6ul_14x14_evk.h        | 5 -----
>   include/configs/mx7dsabresd.h            | 3 ---
>   include/configs/mx7ulp_com.h             | 1 -
>   include/configs/mys_6ulx.h               | 3 ---
>   include/configs/nitrogen6x.h             | 3 ---
>   include/configs/novena.h                 | 5 -----
>   include/configs/npi_imx6ull.h            | 3 ---
>   include/configs/o4-imx6ull-nano.h        | 4 ----
>   include/configs/opos6uldev.h             | 5 -----
>   include/configs/pcl063.h                 | 3 ---
>   include/configs/pcl063_ull.h             | 3 ---
>   include/configs/pico-imx6.h              | 3 ---
>   include/configs/pico-imx6ul.h            | 3 ---
>   include/configs/pico-imx7d.h             | 3 ---
>   include/configs/somlabs_visionsom_6ull.h | 5 -----
>   include/configs/tbs2910.h                | 5 -----
>   include/configs/tqma6.h                  | 3 ---
>   include/configs/usbarmory.h              | 3 ---
>   include/configs/verdin-imx8mm.h          | 3 ---
>   include/configs/vining_2000.h            | 1 -
>   include/configs/wandboard.h              | 3 ---
>   include/configs/warp7.h                  | 1 -
>   include/configs/xpress.h                 | 3 ---
>   60 files changed, 203 deletions(-)

Reviewed-by: Soeren Moch <smoch@web.de>

Thanks,
Soeren

