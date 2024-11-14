Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811F9D65C6C
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 10:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7A9089601;
	Thu, 14 Nov 2024 11:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gM49Kobm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29CC89607; Thu, 14 Nov 2024 11:53:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E3B89227
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 11:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731581595; x=1732186395; i=xypron.glpk@gmx.de;
 bh=CDEGqBNQ7Z9qJ24/eIcH4uYE7wluZSjogSWpmiRHLAQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gM49Kobm4C7+XmxIAfTlmVkMiLAMd0TpUuXtBQIc+TqM9nam9Zf/f2hFB3L30kH9
 dwrcS9sIrFAypCAWXw+LYRdxAd7fzpOVyT/e8BnKs5smFd569QFoVSP2JnYPU8oKf
 jcDu+X9BOwXQWrt/v5rwcfZWQCaO4Sy2C/W3AjY8DP1sCwCRVta2FROoCHVB8inM6
 TbQ9JIM3S/3+LguyiCOHsrGEwCkLlpnKFqfl0mStUocXneMbi+8YUeYnJ12gAN+Fn
 +XLg6PlRb2nB4MauSnFSBP3MHEEKZtvWebTU1uch0/tHOgZuXJqPUT2o6nliUyUVy
 SWTSZ224V5VpODgG0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95iR-1to7Iq2cA3-0186xR; Thu, 14
 Nov 2024 11:53:15 +0100
Message-ID: <135727bd-d2e0-4370-954c-644fdd995036@gmx.de>
Date: Thu, 14 Nov 2024 11:53:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/20] compression: test: Move test into lib
To: Simon Glass <sjg@chromium.org>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241102193715.432529-1-sjg@chromium.org>
 <20241102193715.432529-5-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241102193715.432529-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CTqKq1ZFHzVDfRPqGKJALrEiolnq9axw87xpwJCoDDkoTNdY+OH
 XYYdi37GHOelqLEkn8O3ofmDNr/cLMOKGyBA5I5IMUafPkuvLcQJMmixpkSCN0LXutM+vUI
 bDSQ/wt1kZmSuVJ3cyUdlXYkwzlTGaemeF8EVtQywVWRo/GE7Y5S4ZPMM1JQ1Xbp41h/72G
 TGDbJ/notgfBBdPncBb2w==
UI-OutboundReport: notjunk:1;M01:P0:UNBbrvCQ/ik=;mn0qrlMiNmbA/57+tFn1zZPqXJo
 pDMWNfo3t3SnL/zIqf/EXInMurO5X9sMHNFn9qxZFl04NmGKH9lbUBOeOqMDcy2PuH8qP88J1
 vAtMsRaMZMWNoXMv47XLRgQE6ueX0nxC/UO48N8zjk5h+eEPMoXfWSl4scnhQ5ZAbzGxxDK2u
 by/HO2YSWkqd5gyK86Rz2ZidxA3qrHR7MNnb2porC8Sov4y/flGGrr0FmplnC+RarepcAN88P
 tOKeTCqTImmR2xrzRihOcn/d+qM+/8rAEZpFR7AHmUbtatsqgviuZTxs+P6w5dfNhp8CEUOes
 BwTl8yJv1BT4Wn4N9EcSJZBHGdKAH9+bPaL/cLuURC6FbmYe3Zj177DtPa6j+J6xrB0G4cxuu
 fAV9R7Qirjt42QYA73YrDOoqaDNUNwnInR0qaFswOSjBHpZ4WS52Tvv/GHDalx/0qEPou2pxJ
 LHXGP2nhYM+0nlO6l7h5VLLcfL58GWdaVw7yT1saWY+K3EXMU5vDTDPi2etVxGONlS7n3MB/r
 89fAgvDnbvgrZemvnoSfoO2S6+Za+54ikdAkuGaYc5JrIR39gtBOcRIY55vfuZCLeWVIUWFK6
 17h6zGxze9BIl/iCkYcAVif3//grkleN3U5VW4Kf83PpPtus1kjIG+LEDQudKNUnAuK90nNp0
 rH4epggkJgbAFha3B9f1gh5xECc8vUCXFWRuiRuVq2fTyjK11PWNziXOslgZ0pObTLPCc3Iiq
 jnAadv3AqVSX8SdWQWLoY8/Sn5iA9+m0VWlKn6zNHkhFTFj6Mvb3b0oifA9cZHlzzQ4ouKbnW
 d9JQR8Ymuxm66vqZx0PDA7HVTnQlxXqWgPbJ6kPpdVLWVcWtR6/CAS0GlRpWcK9heUjDns/Ut
 UOA8ymH6XPT/JnFRcv1R3j1vXHXeK4burbX0HqjsgaUAFiAnyXpZU87xE
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

On 11/2/24 20:36, Simon Glass wrote:
> This test doesn't belong at the top level. Move it into the lib/
> directory, since that is where compression is implemented.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   test/Makefile                | 1 -
>   test/lib/Makefile            | 3 +++
>   test/{ =3D> lib}/compression.c | 0
>   3 files changed, 3 insertions(+), 1 deletion(-)
>   rename test/{ =3D> lib}/compression.c (100%)
>
> diff --git a/test/Makefile b/test/Makefile
> index 5d62b5c3357..ff621344a03 100644
> --- a/test/Makefile
> +++ b/test/Makefile
> @@ -10,7 +10,6 @@ endif
>   obj-$(CONFIG_$(XPL_)CMDLINE) +=3D cmd/
>   obj-$(CONFIG_$(XPL_)CMDLINE) +=3D cmd_ut.o
>   obj-$(CONFIG_$(XPL_)CMDLINE) +=3D command_ut.o
> -obj-$(CONFIG_$(XPL_)UT_COMPRESSION) +=3D compression.o
>   obj-y +=3D dm/
>   obj-$(CONFIG_FUZZ) +=3D fuzz/
>   ifndef CONFIG_SANDBOX_VPL
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index a54387a058e..ce22780eed8 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -2,6 +2,9 @@
>   #
>   # (C) Copyright 2018
>   # Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
> +
> +obj-$(CONFIG_$(XPL_)UT_COMPRESSION) +=3D compression.o
> +
>   ifeq ($(CONFIG_XPL_BUILD),)
>   obj-y +=3D cmd_ut_lib.o
>   obj-y +=3D abuf.o
> diff --git a/test/compression.c b/test/lib/compression.c
> similarity index 100%
> rename from test/compression.c
> rename to test/lib/compression.c

Can we now use LIB_TEST instead of the COMPRESSION_TEST macro?

Best regards

Heinrich

