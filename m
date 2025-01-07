Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6412E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 206258036D;
	Tue,  7 Jan 2025 14:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Irg5tbKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16912803DC; Tue,  7 Jan 2025 14:11:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45EE38007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 14:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736255476; x=1736860276; i=xypron.glpk@gmx.de;
 bh=GiFQu3qFm1IKwmYVTpwsdif9BzkMAYTBxPX2BwJeQEE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Irg5tbKXAkhdhbalHUwp6TcmUiv5jZ7Sdns8zlA15dpja2ZzesmVEdvUlw2bA93f
 Xp/u2qkgKHn1rVy5OKF9mKJj5/T3w+eW1F8F0/2gAoMNwIvXTIShPYI/tVRoeYuY9
 yjCL28Z49aIQW8zd4/pTMDHRVEVR3PWR4qIHB4cKryxBzdn5k2e1SrQcSsFOfHX1U
 49zxHNi+1P9kkmsNQ+ScO/yQHnLi/JRtq2KLy86T6HmelZZEXgnxVH12qrkMFnS5/
 STBMJyqgrcAn3/u39I83R1/m1ilfNDAIjcCQNS3TH/V5jLNBsf/JnSjst+QUk1aJ0
 3xrb4EXfgKS5UIvIng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeI2-1t3gJM3Yay-00SOui; Tue, 07
 Jan 2025 14:11:16 +0100
Message-ID: <3b854695-990e-47f3-a9b8-34b1b2790d28@gmx.de>
Date: Tue, 7 Jan 2025 14:11:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250106144755.3054780-1-sjg@chromium.org>
 <51c61e63-82ae-4660-b2c8-987a63c7d091@gmx.de>
 <CAFLszTi5dxQyf_wRpGWRz9S7YsETpeRxA3_YJrhm+Lp0uw7bmw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTi5dxQyf_wRpGWRz9S7YsETpeRxA3_YJrhm+Lp0uw7bmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mVkiGJlxtor7/6VY28WiLym9izBchuG7CyOwnKitCtGaIYcVKKc
 7d8BGEsvdmPzwwz1E/hLAAZmuDNq0ItzZUaKNCVg4qO+kVtyReYfw2RO/Tr1czB2eGTnWjR
 IVfyTA03nQmYNhRHHvZBige+Tg2QjSVZ9+9m4Tx5mwKwHd5jj2pmZgsR5vdCR7yz29ylZtK
 xZ5yX0Y7n/Kbfz9YT/cqQ==
UI-OutboundReport: notjunk:1;M01:P0:fgxSeZZr8vc=;5p2eZ3aeKiMOOaPBmu19I8Q0dzg
 xULX29CrdJ8fF+c2dqlT0eUMhMRTylq5E0J6OjH8dXSwg//fwM+YGRigS7gqC95re72FxTA0/
 XtFyT9zBtxBNoXY4OWJ8iHS8dpqEsFWVwthft82+VsPLso21zMY2cVOU59oIM4LhLJVkFZQaB
 zCfnUy7/AsMDGqqUNnuJf+4ob/bYZ9Ct3EroJOWGXdU8cvdkRmVcWrsteJIXwCPFLacdIdFuw
 iB+GKyu7a6x3UbP3TyeCmNEqaqbv17E4aS3pTI3onWLRS9SdhRsIEbSYQQwwmlr26S9urRSV2
 UuRjqh+tcka86Ui6l2UUX3AtiB0UXsv9OxQICS1rib8TwULUsebDlHKi+sOZ+VvbVX/dFcU2a
 oiTKwiBUrqhjfZFUgcBCtxKoqGmbZmfeht6yU76vVVONkzd+IWXdLq53uIgSM6p57FfQTOjJI
 PA86ZvZpLJoDFxF1op9kMqcR4VGmBidRNrrWdQRNgCbJOedZs3AMVbWYIwUuRdrlMmhZm1OBh
 /CfAl4OpfZBKiEoGG6HvlcSlgGPaoUi6N4mRC+ns0/IzABtoE36wtk0pNP1x/PTVogbn7HTRX
 i8LYMHqzN9WzvueBhGnLia6y+17vIetG53QJpGZSvQOc8NNCKmEe1Dt7RYWfTJF1VNt0JbQ81
 8qDA4pBarg8MrmBi2lMHZJxchFt4QxehyCbdRznC831Otz919yiLBPm7P99CItgPrZqQkyjx9
 4K+kbVxpSGtSL1ODCcbc+ui6fB1AeOuoy0OCanAUR5bmISTcMxA2erYXCksYfXX8Pv6KHe5L0
 1rPTRYtHy7b4EpqLUFT95Lb7ZLAbscQxNbFEQMpTBp1qJURDqBwW2cED72LrhYthevpZ4rFEa
 AtI0y+1nT63iHjEXhJsgdeA+A00JsgxjLHlhvGgWP3TPUbPpUr3FNDigTfePqzk2q+G/lVEtw
 dZjDiJVl/QQKcEa9JBMi/qTI7N/KraJwSB5UUhJZDPnfiGW9Yab77wwNDtK3KQmG+ptuBf6tH
 BLg9lbQuR/i5niiMm2u1tTBLkTruUrfLPdp/TKvtBgfHredr5OFps5Y9oGi07dCsP9qM93eQT
 rQfbQLRLNoYfmwn1IzL9ihmy87eIK3
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

On 07.01.25 13:15, Simon Glass wrote:
> Hi Heinrich,
>
> On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> On 06.01.25 15:47, Simon Glass wrote:
>>> This test was hamstrung in code review so this series is an attempt to
>>> complete the intended functionality:
>>>
>>> - Check memory allocations look correct
>>> - Check that exit-boot-services removes active-DMA devices
>>> - Check that the bootflow is still present after testapp finishes
>>>
>>> The EFI functionality duplicates bootm_announce_and_cleanup() and stil=
l
>>> uses the defunct board_quiesce_devices() so a nice cleanup would be to
>>> call the bootm function instead, with suitable modifications. That wou=
ld
>>> allow bootstage to work too.
>>>
>>> This series is based on sjg/master since the EFI logging was rejected =
so
>>> far.
>>
>> Yes, it was rejected because a solution at the lib/log.c level would be
>> more generic.
>
> As I mentioned, that idea isn't suitable for programmatic use.

What can be done with show_addr("mem", rec->memory); that log_debug()
does not offer or which you could not do with a new log function in
lib/log.c that takes variadic arguments?

Best regards

Heinrich

>
>>
>> Tom suggested not to send patches that are for private enjoyment to the
>> mailing list.
>
> My contributions to U-Boot are only ever about private enjoyment :-)
>
> Do you have any comments on the patches?
>
> Regards,
> Simon

