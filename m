Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2250AC0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1793807D6;
	Mon, 10 Feb 2025 17:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="TGXSGK0L";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="jSYlix8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DECC809A4; Mon, 10 Feb 2025 17:50:13 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B45880548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=TGXSGK0Lo76+VT4ZCrixQyfYydx8+QkTYGj3WGtfbQQ6CGX0nBG6fqXBkE5ZadQVdwFEDUgfMQOdX2r0ai6+yDXsTM8NJXBNzyD2FgZjw0BHYla8NeW3c+16ZOWasXZo0UW9IdvonJjTaN9TEQ38uJBia+ckt88fkzb+NwkvPSj53TUmsPCKUhhNUqCt0BB+/WYffvETukgOiOpkQNqkuWINLcwPNioA/1EovVL0FAsGecGaKIXYVoo8Z9XSQcuO78vsCMu/UX83WtoFKpqb+HksjcFjQz4BHqftoiIN3R0+eJCbb2eC0/TRaoiLhGlC0LzEaAHJ4s3vTXj+m/V9NQ==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=CxqAEo17X2fg2aPk4Kl+khd5djQARVHCzMbiu5XL1Lk=;
 h=Received:Received:Received:Received:From:Date:Subject:To; 
DKIM-Signature: a=rsa-sha256;
 b=jSYlix8wp/wTKoMytwW4JdbUft8ugHi3G8yKSI8bWVJfEODSWvTDp7CKquxuc2gzrA09vBnTzRLDF+wZSty77iBIM6XNmsL6AQAanaR27X4K9mKOIx3XvmCSsZHLPnDoSE8ar9BZjvemdyBI7YYJ4Ouc6XyzQo+jyAOaXoDgQMN/g5TCGfxBQliDrYDYmtU6EFpp1s8lJrbhJvBYuYFaCU4c3Lfokms6PWY3eftp2oOcB9nbtRnXrcwEaEe9uV7BIUEPUBdohAzp0Jc5HAveZnpwpdmnVC3MgQTiLGIwq/OO51MlX1mSdvpD7d2PwnfZrnSAVxW9Ysb5n+Ps2oytxw==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=CxqAEo17X2fg2aPk4Kl+khd5djQARVHCzMbiu5XL1Lk=;
 h=Feedback-ID:Received:Received:Received:Received:From:Date:Subject:To; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -957394234
 for <u-boot@lists.denx.de>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 10 Feb 2025 16:50:05 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2fa1a3c88c5so5760123a91.3
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:50:05 -0800 (PST)
X-Gm-Message-State: AOJu0Yzu6AhA0UJr32s50yRCEYJAvhSa5tc/a63LST767bCreFZTw2HL
 k8pKMaDUCtu7+jXNfxH4oVsP2kxpGXZqaE4cAgM7I5OVxtJXQ8izcCjNA4vKKJSNbeKgrY/WfVT
 eO5J1MgsCSNG/GE2730mOY741q/w=
X-Google-Smtp-Source: AGHT+IE386MrzcuanH5PMxAWGzYGh9PmUzeESHz0TdX3c9mvbUxPJi/IoqkHrPr5En3i/XKIVxMN+IGLzKZErovdFak=
X-Received: by 2002:a17:90b:274b:b0:2f8:4589:a305 with SMTP id
 98e67ed59e1d1-2fa9ed5d344mr287270a91.1.1739206204385; Mon, 10 Feb 2025
 08:50:04 -0800 (PST)
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Feb 2025 16:50:03 +0000
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Feb 2025 16:49:59 +0000
MIME-Version: 1.0 (Mimestream 1.5.0)
References: <20250131170622.747101-1-justin@tidylabs.net>
In-Reply-To: <20250131170622.747101-1-justin@tidylabs.net>
From: Justin Klaassen <justin@tidylabs.net>
Date: Mon, 10 Feb 2025 16:50:03 +0000
X-Gmail-Original-Message-ID: <CAK2wXtm9BMXqvP5WW0kMiGyR4n+BT+0bjReMbdrvHXTgxo=+yA@mail.gmail.com>
X-Gm-Features: AWEUYZnTzGlnhwC6r3fn7iIc-HiJiFxQP7dUMV-jTFur6GRMQLrPD-HvK-G29DU
Message-ID: <CAK2wXtm9BMXqvP5WW0kMiGyR4n+BT+0bjReMbdrvHXTgxo=+yA@mail.gmail.com>
Subject: Re: [PATCH] rockchip: nanopi-r4s: Enable second usb port and fix crash
To: u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Justin Klaassen <justin@tidylabs.net>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Xiaobo Tian <peterwillcn@gmail.com>
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

 Hi all,

For reference this is the same issue I was attempting to fix [1] back in
April 2024. Since [2] was merged the issue has manifested as a crash
whenever the usb system is initialized on nanopi-r4s boards.

[1] https://lists.denx.de/pipermail/u-boot/2024-April/551383.html
[2]
https://source.denx.de/u-boot/u-boot/-/commit/cae4707f25105554f94ad5af1199c7c27edd75e1

Thanks,
Justin

On Jan 31, 2025 at 09:06:13, Justin Klaassen <justin@tidylabs.net> wrote:

> The patch enables the second USB3.0 Type-A USB port on the NanoPi R4S
> board, which prevents a crash when initializing the usb system in U-Boot
> and allows both Type-A USB ports to be used for booting.
>
> => usb start
> starting USB...
> Bus usb@fe380000: USB EHCI 1.00
> Bus usb@fe3c0000: "Synchronous Abort" handler, esr 0x96000010, far 0x0
>
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
>
> ---
>
> arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
> b/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
> index 69800cc368d..931499b084c 100644
> --- a/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
> @@ -36,3 +36,8 @@
> };
> };
> };
> +
> +&u2phy1_host {
> + phy-supply = <&vdd_5v>;
> + status = "okay";
> +};
> --
> 2.45.3
>
>
>
