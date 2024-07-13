Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2CCC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 19:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C43884EA;
	Sat, 13 Jul 2024 21:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="tAPW6QzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 880B088676; Sat, 13 Jul 2024 21:24:38 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8157E884C3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 21:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1720898665; x=1721503465; i=smoch@web.de;
 bh=i7+x7BUXZloEhUkP1TwyKc0V1w081mvJwqip2PmPwY4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tAPW6QzMGiwPf2Arv5N8uVBtVal8e+96CQizIvzCdTqzUjo4vY3DptOHuWl1ZJNN
 FXbFaU7YWiv7DS8WaAohy0WnfsUFVldM1dIlqT7syjdPE97XK4NxTA2bNPlS8a3mj
 NOKNCeXG29EoQTUiuteADT95CHKUwiwXNgt9Gd7uEWrMW2kjng5bTDEPCv1O5KAHZ
 b3z5fyL14N9bVeHCsn4BHwlh1hJR8ad0gqM1JzODnQ4xUp07Pm9nhWjtcPnQ1WGL7
 gBOLWfNPMRDUgcYkt4f/S3wv3YHKxjfnZ6I2ONrqwnN7/oM/+pdTTcPQIjXJc2vMT
 r3XrzFRfFCk6JAV8Og==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.1.40] ([77.191.71.176]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mav6f-1rvJg340Zn-00gQZo; Sat, 13
 Jul 2024 21:24:25 +0200
Message-ID: <1e06e086-4447-422f-9055-49fb25a1cb7b@web.de>
Date: Sat, 13 Jul 2024 21:24:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] usb: tcpm: add core framework
To: Simon Glass <sjg@chromium.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman
 <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Wang Jie <dave.wang@rock-chips.com>
References: <20240604163546.60225-1-sebastian.reichel@collabora.com>
 <20240604163546.60225-2-sebastian.reichel@collabora.com>
 <CAFLszTiZsNVpRrzd0PfA_d369TN-HFpKe_5pZq1eXbLc34dZ3w@mail.gmail.com>
Content-Language: en-US
From: Soeren Moch <smoch@web.de>
In-Reply-To: <CAFLszTiZsNVpRrzd0PfA_d369TN-HFpKe_5pZq1eXbLc34dZ3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NJFhzFX+C11eRkFUn1I5Yv5wjrSnhDkQQJUSm6FPR3CUTdC9YIJ
 KaM+GcjzDWTW/bbtnQjgZpIgaKaFRmtBUF3Xzk2E3Bdp7lvLr6hEUT1ZCP5ICQeEp+4LYz6
 FWvP8siJlySGLKanvW2QqA7N59fiD8Dk5ImZL4ktbOzv0k4ixufAfE6XUAsPrfGAf3QlYGH
 yUwwN7I8xkRIPpln2PjnQ==
UI-OutboundReport: notjunk:1;M01:P0:gIbJzzM0S/w=;jQ9Hp+oSIVGtSGb4Ibb02a+hMgK
 8PXDEbeZBzG4I36bkO47vfeZXur6dScRbNhO8wLt9+aRoUoUysI32/RSRvyHSz9R268X2gTtJ
 0yfSoXybgvaWNj+2hZnsRaKp2jn9BTJdnmo8MHElmFpLSsaq37c1SeJnVoPUWD5m/LCQw5uZF
 4I42cwbilzRF5IeR0y8hcpV6VcM+qAOzvyb+13veGm5ZDdyfaWZ4nWwDSsdRE6tq2ORlC0ZsV
 fjLQNItcVZ6XRk1G7b2KwGk4bYhLBDZj929OPcS7JKLoaW3QPg6YoEzLOjQz8IvvG/a5ZBVrm
 e51x0ZRp4XQ2wMKLv0UwOkGS9el7sOLWnUE6TiLodGeRWLw5d79RqTMhNzvkYJa1kpOlG15MP
 +OtgcxifLT2rQo34DNzB6yS77abTgYUQqaMMMKOgcpr52Tzb+wZYH7Z6mI45J4kiH4A/KYlxA
 Pax/RfovxfSb9r55p9UVyeSe6jj+k8bBUlv911DwexUqb8RPlC5/9mTvz+SqlmnavULimEqq8
 ZRZXDT011bohk/elTRvITsiSUAH8txo9efFwFgp/Vme4hJbzPqT+BdDaApZ6c/Sf65mEJvsTc
 HfWqXwXRM/JUrY6TVE21bC6gGwwIIgCbHaC95JhxEXBf7xjaSl7B2HjAnXHbPEnkJpCh+73re
 JMFhxaCt6xLX3puXBTfUv81jocUHhVnqSXf9JeuzC8KoLW6T9DtjnM9/UZMcAwz1CHuhmPk5s
 BDvhCeVnWpg86A4fztDRKDNwE1pa3JvNi2dJ16KXdj5hkHSftAHBxvQv9b4eK4lKncJX3POv4
 lXvoaSBMKKPuyOmXwvzs44gQ==
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

On 13.07.24 17:13, Simon Glass wrote:
> 00000000000000000000000000000000000000000000000000000000000000000000Hi
> Sebastian,
>
> On Tue, 4 Jun 2024 at 17:35, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
>> This adds TCPM framework in preparation for fusb302 support, which can
>> handle USB power delivery messages. This is needed to solve issues with
>> devices, that are running from a USB-C port supporting USB-PD, but not
>> having a battery.
>>
>> Such a device currently boots to the kernel without interacting with
>> the power-supply at all. If there are no USB-PD message replies within
>> 5 seconds, the power-supply assumes the peripheral is not capable of
>> USB-PD. It usually takes more than 5 seconds for the system to reach
>> the kernel and probe the I2C based fusb302 chip driver. Thus the
>> system always runs into this state. The power-supply's solution to
>> fix this error state is a hard reset, which involves removing the
>> power from VBUS. Boards without a battery (or huge capacitors) will
>> reset at this point resulting in a boot loop.
>>
>> This imports the TCPM framework from the kernel. The porting has
>> originally been done by Rockchip using hardware timers and the Linux
>> kernel's TCPM code from some years ago.
>>
>> I had a look at upgrading to the latest TCPM kernel code, but that
>> beast became a lot more complex due to adding more USB-C features.
>> I believe these features are not needed in U-Boot and with multiple
>> kthreads and hrtimers being involved it is non-trivial to port them.
>> Instead I worked on stripping down features from the Rockchip port
>> to an even more basic level. Also the TCPM code has been reworked
>> to avoid complete use of any timers (Rockchip used SoC specific
>> hardware timers + IRQ to implement delayed work mechanism). Instead
>> the delayed state changes are handled directly from the poll loop.
>>
>> Note, that (in contrast to the original Rockchip port) the state
>> machine has the same hard reset quirk, that the kernel has - i.e.
>> it avoids disabling the CC pin resistors for devices that are not
>> self-powered. Without that quirk, the Radxa Rock 5B will not just
>> end up doing a machine reset when a hard reset is triggered, but will
>> not even recover, because the CPU will loose power and the FUSB302
>> will keep this state because of leak voltage arriving through the RX
>> serial pin (assuming a serial adapter is connected).
>>
>> This also includes a 'tcpm' command, which can be used to get
>> information about the current state and the negotiated voltage
>> and current.
>>
>> Co-developed-by: Wang Jie <dave.wang@rock-chips.com>
>> Signed-off-by: Wang Jie <dave.wang@rock-chips.com>
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> ---
>>   Makefile                         |    1 +
>>   cmd/Kconfig                      |    7 +
>>   cmd/Makefile                     |    1 +
>>   cmd/tcpm.c                       |  142 ++
>>   drivers/usb/Kconfig              |    2 +
>>   drivers/usb/tcpm/Kconfig         |    8 +
>>   drivers/usb/tcpm/Makefile        |    3 +
>>   drivers/usb/tcpm/tcpm-internal.h |  174 +++
>>   drivers/usb/tcpm/tcpm-uclass.c   |  102 ++
>>   drivers/usb/tcpm/tcpm.c          | 2251 ++++++++++++++++++++++++++++++
>>   include/dm/uclass-id.h           |    1 +
>>   include/usb/pd.h                 |  516 +++++++
>>   include/usb/tcpm.h               |   99 ++
>>   13 files changed, 3307 insertions(+)
>>   create mode 100644 cmd/tcpm.c
>>   create mode 100644 drivers/usb/tcpm/Kconfig
>>   create mode 100644 drivers/usb/tcpm/Makefile
>>   create mode 100644 drivers/usb/tcpm/tcpm-internal.h
>>   create mode 100644 drivers/usb/tcpm/tcpm-uclass.c
>>   create mode 100644 drivers/usb/tcpm/tcpm.c
>>   create mode 100644 include/usb/pd.h
>>   create mode 100644 include/usb/tcpm.h
> Can you please add docs for the command (and perhaps the whole feature)?
>
> How is this tested?
Asks the developer who caused the most u-boot regressions for me within
the last decade.

Did you notice this is a 5 part series?

It was tested on the board this was developed for. You received a t-b
~5 weeks ago.

Regards,
Soeren

> It should be possible to write a simple i2c
> emulator for the chip as a way to cover this in CI (search for
> UCLASS_I2C_EMUL to see examples).
>
> Regards,
> Simon

