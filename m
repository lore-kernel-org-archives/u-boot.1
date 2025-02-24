Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADA2C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 17:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F424807B1;
	Mon, 24 Feb 2025 18:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="dG3fx9L4";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="skrvxmLk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F034A807B1; Mon, 24 Feb 2025 18:15:09 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD3A80079
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 18:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=dG3fx9L4IuvfXdywwANDmKo5Au/Brnp+iaCZbA2SWhbZtZw1TO1bp4a4O2zE44h6KTDyxdcm5BNv4JpXL4p/2h1Mj2LfGOUHRjhisxVQR4bZvEwn0kPNOGpMzo4bMJvzoMaZr9bQgOUyTb8zQv+6I+MChHjzOX0p9U4GwYdLv3DY5jWCOt5x+MjMH+tKgmOfbQOZDIiRYeQxsuePW5qv5HAAe4GzIrW3zFFs0CedXEaJ5uechb16KJsi+UkuclC6Ydor5rz0Z603ebDpWtjDUWvS5gDjetYQzVODUaI7jH1g1khuK3tVxRM4PVaaMVq0B8X31at5oYlWost06nyJFQ==;
 s=purelymail1; d=tidylabs.net; v=1;
 bh=yyxayR+h6mb8XaQtb26wZJsirNv1p0WS8Dm4HR4tBFQ=;
 h=Received:Received:Received:Received:From:Date:Subject:To; 
DKIM-Signature: a=rsa-sha256;
 b=skrvxmLkQ+SaM1t65YGjTWCRCyNbY3db5lh8ng90PzqhzYbSrtm3g7+lSRkYS+J7R7nUi7Lxot/cstxZ3LUYe4Y53jXEt/Fn95JJx28qukAAhRQG25oNNS51DbacS4OEqJNhBsOUZWTI8AQE/szK9ldaEXrWg9KlQjYRCwvBqu5TumRlVkFAG70/gmzQjhSQiJWaFRS4HdWslq7eJLzFkgTP8Mgv0CctBIrZpRoWzkWkTLcIYMz05wvP58KSZ4EawaltNld4dCmmmwb1lH2MoCs9q8K8ELdVvqBq0UJTm4wi0GLqVVsXIYYEqaDtN+iK7l7uUUDrIl1XQ3q/LSiH5w==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=yyxayR+h6mb8XaQtb26wZJsirNv1p0WS8Dm4HR4tBFQ=;
 h=Feedback-ID:Received:Received:Received:Received:From:Date:Subject:To; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 249222182
 for <u-boot@lists.denx.de>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 24 Feb 2025 17:15:02 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fcff77ff9bso4696149a91.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 09:15:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV2fes8F1mSGRtUW92qjnFNoHzpgPk8KiCPfpZezzs3f2YtyUUJW6UEkt+wnwvJvNd+TRt5vn8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2KztjNxsGrwIWI+DeTj6g+aGZahn6XzFhqX/V4TkeTlB/q5Cv
 XMw5BEpYM1JmCS7fCfIBbriKm5oXSPTD7ehy3fbUoHND58yp5fLjG63+5axt6Ip/K6i2BxuScpQ
 p0k4P5uMcNjm/CTDZQ0oDsgYMt1A=
X-Google-Smtp-Source: AGHT+IG8i+uUJygKSPuUnl6jBPEYnrWnfr0nPfZOj8c5gQluilvYYi/LftknpQEGka9gQZ0mfLlPQp2NeTw8oS//Hnc=
X-Received: by 2002:a17:90b:2d4e:b0:2ee:db1a:2e3c with SMTP id
 98e67ed59e1d1-2fce779bc35mr21785571a91.1.1740417301585; Mon, 24 Feb 2025
 09:15:01 -0800 (PST)
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Feb 2025 09:15:00 -0800
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Feb 2025 09:14:56 -0800
MIME-Version: 1.0 (Mimestream 1.5.0)
References: <20250131170622.747101-1-justin@tidylabs.net>
 <704d3a73-cbbf-43eb-ba1b-160a4284324a@rock-chips.com>
In-Reply-To: <704d3a73-cbbf-43eb-ba1b-160a4284324a@rock-chips.com>
From: Justin Klaassen <justin@tidylabs.net>
Date: Mon, 24 Feb 2025 09:15:00 -0800
X-Gmail-Original-Message-ID: <CAK2wXtmEm5uc3pF7cQ4n3KgtvOz+6QrR9sE6oypZjM9iWsSSyw@mail.gmail.com>
X-Gm-Features: AWEUYZm5dVoz_tZjL8rns8Rh6p6AEgn2zZN7gPkAte6cvQ-8OHxboSxjrQbLfIY
Message-ID: <CAK2wXtmEm5uc3pF7cQ4n3KgtvOz+6QrR9sE6oypZjM9iWsSSyw@mail.gmail.com>
Subject: Re: [PATCH] rockchip: nanopi-r4s: Enable second usb port and fix crash
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Xiaobo Tian <peterwillcn@gmail.com>,
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

 Hi Kever,

On Feb 19, 2025 at 07:02:25, Kever Yang <kever.yang@rock-chips.com> wrote:

> Hi Justin,
>
> On 2025/2/1 01:06, Justin Klaassen wrote:
>
> The patch enables the second USB3.0 Type-A USB port on the NanoPi R4S
>
> board, which prevents a crash when initializing the usb system in U-Boot
>
> and allows both Type-A USB ports to be used for booting.
>
>
> => usb start
>
> starting USB...
>
> Bus usb@fe380000: USB EHCI 1.00
>
> Bus usb@fe3c0000: "Synchronous Abort" handler, esr 0x96000010, far 0x0
>
>
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
>
>
> ---
>
>
>   arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi | 5 +++++
>
>   1 file changed, 5 insertions(+)
>
>
> diff --git a/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
> b/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
>
> index 69800cc368d..931499b084c 100644
>
> --- a/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
>
> +++ b/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
>
> @@ -36,3 +36,8 @@
>
>    };
>
>    };
>
>   };
>
> +
>
> +&u2phy1_host {
>
> + phy-supply = <&vdd_5v>;
>
> + status = "okay";
>
> +};
>
>
> This was disabled in upstream kernel in
> dts/upstream/src/arm64/rockchip/rk3399-nanopi-r4s.dtsi
>
> Can you also update the upstream kernel dts?
>

I have sent a patch[1] to make the change upstream in the kernel dts.

[1] https://lore.kernel.org/all/20250224170925.39126-1-justin@tidylabs.net/


> this u2phy1_host should always have the same status as usb_host1_ehci.
>
>
> Thanks,
>
> - Kever
>
>
>
Thanks,
Justin
