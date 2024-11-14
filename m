Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45073D65C6F
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 10:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2FED88F4B;
	Thu, 14 Nov 2024 11:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="i75O8nyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2753A8960D; Thu, 14 Nov 2024 11:49:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 276F888E31
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 11:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731581372; x=1732186172; i=xypron.glpk@gmx.de;
 bh=eOqsX1lRbLi+QTz1rxBAqovUwX7tyDOp1S37ezLAz3w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=i75O8nyVv/mCk9v7JAEfjDAShjReGKkhP5/JKt7yRtOAacG2i7CC6UZLlxpigsUN
 Pzcso2vmOgQiPky5zQiLLEWdWEdx59pcSIEDQJBuSAh3coUS8F2x46FXNU+lqA7zD
 K6dxqLKs4z+cE5s6M2Px6DDi5n45EcxaqxAVVwTxHrndy48+ueL6Q0a3sdZmpPtji
 NWsmSh+1Xf+CxQpIsh9rgaVqczmjvbDgujddcuarmCgZSj/h0mRzHGVh6vGMn2IdY
 UyVV+lOqAuZoTZM7kzkstokq7kUsSltZ3LeYp+QJgSzGmsGTk9cG1+KS4yWvNj6y7
 yYjb7SZ6078bRARx8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmULx-1tbYYn1H1d-00kNqo; Thu, 14
 Nov 2024 11:49:32 +0100
Message-ID: <2d8aced2-e1e9-46a4-8fb4-8e8cf5bb3a46@gmx.de>
Date: Thu, 14 Nov 2024 11:49:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] bloblist: test: Move test into common
To: Simon Glass <sjg@chromium.org>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241102193715.432529-1-sjg@chromium.org>
 <20241102193715.432529-2-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241102193715.432529-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qa+sCvosxMWGjpX2T6UppS/CI/wRaJjQ/ryL/8dQsImroomlSPk
 71rI5vqKboY25YV0dSJiVs9nVntzPMSqy3hwtP1NR/W6wjP6JbDKZ3kY4HIv6HOpJYv96HP
 B8y5bOvYXqB2WjqEBj264YdtlDK4jIMNb85C1jgq70K17qDjXDhmI+AfSvxd/feHXIxki5T
 JWBWYs4CsO4xRNzN2tQLg==
UI-OutboundReport: notjunk:1;M01:P0:4t7VM6wIrcI=;S9lDXU6u9hkozmT1LzMbMSh5+Nc
 MME4252yTTK379210xekvjklHIqcLMflvEc9EtoLTZ7g2Ym6nxz8+7z50Pl4Q9pjHGAvk2CcN
 GaMtfuvVPClVqBwAxCnncAzDEHAmJDwJWXDBJSWIp9yHMAG5V0m8tFdIh0HOJG0ea/LoD0cWW
 jPWfFmsO3zf8Dw1lAlyHmwaRCv70xTYA/WL610+zzN0SQL62ZsLPpxH3JhMuQNToGpkk7RfQQ
 SgmgyubZIqHpaEtEAwmJLC4SevEO+gUdcWxNXzlxq+GeeBZQ+OEplWRgIF7gcAvVGcXHgi1kH
 M1hedzsAr64NsYRbhakrVC1Qr8TofmcqagLDdxoXRJVLLlK1Lwm06Z/+JVnoN+ak0zgLpqTEf
 V5v0/Kmf4eyQjScT3srOuO3FYwoKE4h/Wug0sxTRSzfGovtQcamUw2gseI15YbyJOWhEZDlR7
 WZvObcgVbf/GNUXKRTCvCyeGwvo1FgQcBFbOl8uVGTuoVGtRhjGDFHdUQa43vgRCxeo0qdRJG
 BGBfzCFrycKZi31VrMnj5Ac0jriG4wDr4FUBt4GYFUhMJTK2TeQjEoNXdzkdMHbkSry0Az/fZ
 /zthNtnIKntC0gYjihiLbaOJAdLTTxz9my3Tsc1lIZeL1ktMjGpMiWs+L65uMMefUDtXI5L/J
 z3gWrFj3HGut0MpYcC1yYKhm6BfDiHpBANbANIbTHFOEivA69xQNcWKaW1rra+FsY/UyfyIYw
 S1TL5R4HDMvkoaEJilzow1itgrgjDkRMaRon8m2E6ZA9KlpTS/d4D9tLgAujOqRy1cj1oka2W
 1eUIsK8QcFx8HfEXtw3GGZlXqbPMFAzYSZ96PuTud1c6uJK9UPhShIGGZ++aryBpm4KxDVxKC
 ty0kgOEN6GW0nlwjo6/4xbwU+u2ey/9kz68gswBiYDMnZlTUv7ayIwfhi
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
> This test doesn't belong at the top level. Move it into the common/
> directory, to match its implementation.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
>
> ---
>
> Changes in v2:
> - Leave the bootm rule alone, as the bootm test only runs on sandbox
>
>   test/Makefile                | 1 -
>   test/common/Makefile         | 3 +++
>   test/{ =3D> common}/bloblist.c | 0
>   3 files changed, 3 insertions(+), 1 deletion(-)
>   rename test/{ =3D> common}/bloblist.c (100%)
>
> diff --git a/test/Makefile b/test/Makefile
> index 145c952d2c3..5d62b5c3357 100644
> --- a/test/Makefile
> +++ b/test/Makefile
> @@ -5,7 +5,6 @@
>   obj-y +=3D test-main.o
>
>   ifneq ($(CONFIG_$(XPL_)BLOBLIST),)

Shouldn't this be CONFIG_$(PHASE_)BLOBLIST, see common/Makefile.

> -obj-$(CONFIG_$(XPL_)CMDLINE) +=3D bloblist.o

Why do we need the command line for running this test?

The only thing we need the command line for is issuing the 'ut' command?

Can be remove the CMDLINE dependency or move it to 'config UNIT_TEST'.

>   obj-$(CONFIG_$(XPL_)CMDLINE) +=3D bootm.o
>   endif
>   obj-$(CONFIG_$(XPL_)CMDLINE) +=3D cmd/
> diff --git a/test/common/Makefile b/test/common/Makefile
> index 12c65f8c951..b6bff9201ec 100644
> --- a/test/common/Makefile
> +++ b/test/common/Makefile
> @@ -1,6 +1,9 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   obj-y +=3D cmd_ut_common.o
>   obj-$(CONFIG_AUTOBOOT) +=3D test_autoboot.o
> +ifneq ($(CONFIG_$(XPL_)BLOBLIST),)

ditto

Best regards

Heinrich

> +obj-$(CONFIG_$(XPL_)CMDLINE) +=3D bloblist.o
> +endif
>   obj-$(CONFIG_CYCLIC) +=3D cyclic.o
>   obj-$(CONFIG_EVENT_DYNAMIC) +=3D event.o
>   obj-y +=3D cread.o
> diff --git a/test/bloblist.c b/test/common/bloblist.c
> similarity index 100%
> rename from test/bloblist.c
> rename to test/common/bloblist.c

