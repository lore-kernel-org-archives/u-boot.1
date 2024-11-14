Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C02D65C70
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 11:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FEF9895CE;
	Thu, 14 Nov 2024 12:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Kxad1aRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC19189611; Thu, 14 Nov 2024 12:07:35 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFA3989574
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 12:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731582452; x=1732187252; i=xypron.glpk@gmx.de;
 bh=Poft6D7dRdt5HOW2fiG9lFuHi7Vo2rAQENhWYqXcWcE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Kxad1aRxwX1vdxbnNBYPLF+ERYAd/jodllqWk8n+0gRzqpgiC0hWgHWQRWHtKFnj
 Aor0SeAEVUEmSB8K/kt9MymOpv7VwuBXOCLaxgJ+AKg0Co1OaDHkizPB+gdi60Z2s
 XCVZNJdqfZIGXZwwJhLfiDc3RaSOj7JHlGVioPG2kPyfOBwqlF7xzPdeCOuGNFjq6
 yBpmQ+6rbEJhsp3hNmj1PJWKoqG85Q40Ogy/1G4WmlHTwbu2AoGflJmAy4/Re34TT
 iSqV1culyg1kAlIcVyAQFJ3yQo/BMUaNOZAd37yFl0oA+bDzxSXYItCMaRzNFMmOY
 eRRA6NBQCN3NZRm+Wg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAci-1tmnG80Ex6-00ZbtO; Thu, 14
 Nov 2024 12:07:32 +0100
Message-ID: <076d440e-6667-490a-94f5-cd010fb5da49@gmx.de>
Date: Thu, 14 Nov 2024 12:07:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/20] bootm: test: Move test into boot
To: Simon Glass <sjg@chromium.org>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241102193715.432529-1-sjg@chromium.org>
 <20241102193715.432529-10-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241102193715.432529-10-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cdeNypncfCAwB+G/N8HPXzXlkAvQCH31oW7A0zaze40m2CmWY9D
 I0uw3c/jMsyo0FfnJCUcTSAXxtYTWwXwet0Ctkmp8/U8kXMofXEmx7fijQwYn9yqOQ2UGTU
 hFJWjbVYzD4WxIiMPekmFCmFSwNtbljjz1Ivfknw+EcvjSluOWp82EyeQb1StWNSnfs8NYb
 Fp9iWcFDOR7PmBonfFN+A==
UI-OutboundReport: notjunk:1;M01:P0:MecbvG3m3Yc=;YEUGiEtXrpCiWNzg6nGeQbUkDMJ
 XMTnneKZti9ffyxaM+c1b+aQgvE4K50Q70T1G2o/cZPRzTSsItpyJG3NL6oG3ZKqSTexA0X8e
 5l7GP9e+mSzcgEUTJcOVYuZBYU4/qWNz4t+FAaTtEGyccxpeQ1t/VsuPG4iWQd8t09lwEIsb6
 6UuLeF+aEem0OPY1JdgjjS37lzJC5W7LyJ/UP1r3AMgEeekuukJQ0ieb36uFIbF7fJpLD1gTc
 y66cd7D3L4sQX0gEWW8TRV2burNQFnuyyZQsjLIHSyVLi3IervsAPdo/5OmXDekLfE2AmKKLW
 zFqiKZVhqeHbE6U14m/vOhILevIyUWSyAoQdkEroxSczatu/qoR0+jtOEtfd3PS+BW7Jmtid1
 H/FnJZTRubOHMjhVTYbGkrPWSCY4YiT46ErpPuOiy59Bvq/mwvJGg01zisV0hEvnk6w1hHhRU
 Ymqxef4El+47+4xdcEDhnmN/Hd6SN8Ab+4RZn9fuFYaQJFqoxpkNQdBGBtW+ZndFtOYTVw/ah
 0HfrquDLerJ8NvNQ5KD8BjJZWf3dLXRVq5kjd1KxS6Dg9WCFPE/pW/Nn5uCuhGnwniDJC4qIE
 sVpCWK0bgQICwzq6SN+qwWNJqTX4qOXXbYKAUgQDXvZA2CqogqkpWSccrUwHefuvNXmHovLFr
 O4fgf9R83rW4GTaDoo1ce65agJw+f0S71k5LbeexW57DEAPfZ3hUq0JwW9lLlswCKg4i2aV1H
 KnIwutZ/G2YEbOkCH2FFdVT1DBf0BEdJTUCAW8mQXsU5pTqfJ5aQ8ht3MJA4EqUg7DCFXQ4aG
 5QLsTspsqbh+udppjWaPrYC9YbtHzQcRfxRv7ERpRlBsJMPNcPXjmkiBxRHRb60me+3OZCtaJ
 OmfaqOEShYKYPEPj/+8oV153M5o5ry3uVFW1S4bG8wkXZwUSxOjRpo4kV
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
> This test doesn't belong at the top level. Move it into the boot/
> directory, to match its implementation.
>
> This test is currently dependent on bloblist, but the real dependency is
> on sandbox, so update that.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Make the test dependent on sandbox
>
>   test/Makefile           | 3 ---
>   test/boot/Makefile      | 3 +++
>   test/{ =3D> boot}/bootm.c | 0
>   3 files changed, 3 insertions(+), 3 deletions(-)
>   rename test/{ =3D> boot}/bootm.c (100%)
>
> diff --git a/test/Makefile b/test/Makefile
> index 48d8bc91ae6..4366e495a15 100644
> --- a/test/Makefile
> +++ b/test/Makefile
> @@ -4,9 +4,6 @@
>
>   obj-y +=3D test-main.o
>
> -ifneq ($(CONFIG_$(XPL_)BLOBLIST),)

Shouldn't this be CONFIG_$(PHASE_)BLOBLIST, see common/Makefile.

Best regards

Heinrich

> -obj-$(CONFIG_$(XPL_)CMDLINE) +=3D bootm.o
> -endif
>   obj-$(CONFIG_$(XPL_)CMDLINE) +=3D cmd/
>   obj-$(CONFIG_$(XPL_)CMDLINE) +=3D cmd_ut.o
>   obj-y +=3D dm/
> diff --git a/test/boot/Makefile b/test/boot/Makefile
> index d8eded20d4f..63487e8d29e 100644
> --- a/test/boot/Makefile
> +++ b/test/boot/Makefile
> @@ -10,6 +10,9 @@ obj-$(CONFIG_EXPO) +=3D expo.o
>   obj-$(CONFIG_CEDIT) +=3D cedit.o
>   endif
>
> +ifdef CONFIG_SANDBOX
> +obj-$(CONFIG_$(XPL_)CMDLINE) +=3D bootm.o
> +endif
>   obj-$(CONFIG_MEASURED_BOOT) +=3D measurement.o
>
>   ifdef CONFIG_OF_LIVE
> diff --git a/test/bootm.c b/test/boot/bootm.c
> similarity index 100%
> rename from test/bootm.c
> rename to test/boot/bootm.c

