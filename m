Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6340CC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 17:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF20805E7;
	Wed,  5 Feb 2025 18:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="XrmCKr+5";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="fexETUiy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D681380104; Wed,  5 Feb 2025 18:14:34 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99839805E7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=XrmCKr+5JzjZspluLjYQIEXd2PtA/KQJrOcKtBw5/ORmYuyT9pbI7Y5stmcrf4JLABPNT+EmaH+mwlivF+6qEVpIkXs9f4msW/P3JGeTFsK5UO4GtYXlG+OBAm9iu7r/Z75HyjK6rgSrMbYROy9/PR9OBw4KuxGzn4CxcQmPW9c5H3J/SJH0pOiNoTZkcoQcXd7iCX4Bv6KU2jSpEUDh5vvOQgMY0hsl6R5VmEyeIu9bVRdiVDsZZdM3VOEWKQBaNnqKV0HpArITpHo1b8jBR/W4xptgl5NGmHnczVDfR9CKqGQBFiy6qwUwAU33hzTDUMZ8noupHHeEz8MF4PA5jQ==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=Aus5FplPAz8IiFB9lo9H/2aspPCT5y7RibOPtLYUDDU=;
 h=Received:Received:Received:Received:From:Date:Subject:To; 
DKIM-Signature: a=rsa-sha256;
 b=fexETUiyvxlAQg6ftm+I+UwSsnjvgiOS59n+HboefJeCB4jXS7bSSh2grv0OkX2NUbXoJia5i4Twyxpf0CsmtD4i/M6UzK+uhCmTryoccNbBt9JyRAL9Wok9ZXzdtj1pGJYaxTySIyK7orHgGXPu4dls8QLYe4DG6KCy7Z2RFckisN7ro2jQRlMrnYxoT7BtAiyoj2MijLqLls/WMCgwhHCJr+Pi1iVlNj3k8n6uWSpgFWAvTpcwahAsvfZ1blEfVaruPre1cZf4nOLqAC2LZ+uF9Y8BiocuPaOdm9GDLw0M5KpvGpz1PGQJ4Oxq8dCulD96VTk9gzg0I0DdsoYkUw==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=Aus5FplPAz8IiFB9lo9H/2aspPCT5y7RibOPtLYUDDU=;
 h=Feedback-ID:Received:Received:Received:Received:From:Date:Subject:To; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1184889205
 for <u-boot@lists.denx.de>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 05 Feb 2025 17:14:20 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2f9d5f8a4b9so2620831a91.0
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 09:14:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWteVmk+exkQEadx/QYfMXV50Iwcrg4ozeNjSPBj3KABSVGn+NwM/wNBZSu92lXqwKRio6rnB4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywxksk6k2ITD+Mx8w9F2hInLfB48aKUR1m6HbyyyULvag2YwFDv
 WpQbMqXN16+QL2yfwhqQ3CKM8EJ4YKKTbJ2xnl1yJnwld8KvdXrwDdCTPE10jl6oH68fcDa0wM5
 n+LYfUYJ9+kTpefKfVPbB/Qa9Cjc=
X-Google-Smtp-Source: AGHT+IF3pcwA7V/thICrqBnNAlfma7ih4zbnRT5XbhrVR/fI0yGylvHZjX/PGbmB+Cei4GIqt/9sjlvyLJRoF2m16L0=
X-Received: by 2002:a05:6a00:448a:b0:728:927b:7de2 with SMTP id
 d2e1a72fcca58-73035107efdmr6853161b3a.8.1738775659752; Wed, 05 Feb 2025
 09:14:19 -0800 (PST)
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Feb 2025 17:14:19 +0000
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Feb 2025 17:14:15 +0000
MIME-Version: 1.0 (Mimestream 1.5.0)
References: <20250128213852.465664-1-justin@tidylabs.net>
 <20250128213852.465664-3-justin@tidylabs.net>
 <022f76fb-a713-4778-97dc-cd78cb02fa57@cherry.de>
In-Reply-To: <022f76fb-a713-4778-97dc-cd78cb02fa57@cherry.de>
From: Justin Klaassen <justin@tidylabs.net>
Date: Wed, 5 Feb 2025 17:14:19 +0000
X-Gmail-Original-Message-ID: <CAK2wXtm9YmXPsAyWj=iUgALH2DXSh43oD9zP66OEBduToxcd9w@mail.gmail.com>
X-Gm-Features: AWEUYZkdQ4PmqAoCLnyM3VxoKiUfzwm5jRofMeuSo7DNm1VEtuh3CQTk45TFF4c
Message-ID: <CAK2wXtm9YmXPsAyWj=iUgALH2DXSh43oD9zP66OEBduToxcd9w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] rockchip: io-domain: Add
 CONFIG_SPL_ROCKCHIP_IODOMAIN
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, 
 Tom Rini <trini@konsulko.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

 Hi Quentin,

On Feb 4, 2025 at 09:20:56, Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Justin
>
> On 1/28/25 10:37 PM, Justin Klaassen wrote:
>
> Allows use of the Rockchip IO-domain driver in SPL to configure
>
> the GPIO to match the voltage supplied by specific regulators
>
> (e.g. "vcc_sdio").
>
>
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
>
> ---
>
>
> Changes in v2:
>
> - Added separate patch for added CONFIG_SPL_ROCKCHIP_IODOMAIN Kconfig
>
>
>   drivers/misc/Kconfig | 8 ++++++++
>
>   1 file changed, 8 insertions(+)
>
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>
> index da84b35e804..ad935b81ae1 100644
>
> --- a/drivers/misc/Kconfig
>
> +++ b/drivers/misc/Kconfig
>
> @@ -110,6 +110,14 @@ config ROCKCHIP_IODOMAIN
>
>     for the IO-domain setting of the SoC to match the voltage supplied
>
>     by the regulators.
>
>
>
> +config SPL_ROCKCHIP_IODOMAIN
>
> + bool "Rockchip IO-domain driver support in SPL"
>
> + depends on SPL_MISC && ARCH_ROCKCHIP
>
>
> I believe this is missing SPL_DM_REGULATOR as well?
>

Good catch. Fixed.


> Cheers,
> Quentin
>
>
Thanks,
Justin
