Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC1ED13C36
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 15:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E40483C04;
	Mon, 26 Jan 2026 16:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="XoZhNoSD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C60EC83C65; Mon, 26 Jan 2026 16:46:22 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A25083BD2
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 16:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A6621109F9B; Mon, 26 Jan 2026 16:46:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769442374;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=l+84om3PKCv7urRYVon7zoHGyOJl2VSVtmVC75OkjMk=;
 b=XoZhNoSDNBVQoAkTCrfO4+i/AD5vnqnP6TdyNixhOjCiEO5toXv5ygWxXD+9U1uij3Fiwe
 86WCs4SNAzNwyT0PPfsuSQEXpWXTV+C7L9wJ1A5+vQ/b8WgZK+R0AMou+HDVXkP80eso02
 U4Cwg2FQsQU8bZ7B8g0qSn7Ak13km3JTCsTpQvjZL/YiZxHtGsmwq4MZ2gdWQTmxQ2HcUX
 ZmlkNPR4RFl+66Hl+tg1txEJNW8lGKZ3H6tHtTYZ5KXL8201ThZ9LJXpMaIbM+iVitLjpv
 UOVLigSIg+6iJ6j9sHPXB3Ns9WlwQRtf8fGozKKv47JzUmYEdju4gzdjW/0pcw==
Message-ID: <e7917bc9-11b1-18d0-1f04-9d6af003c1cd@nabladev.com>
Date: Mon, 26 Jan 2026 16:46:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 0/2] fastboot: mmc: fix bootloader offset
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20260124054712.7939-1-hs@nabladev.com> <87y0lkogbt.fsf@kernel.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <87y0lkogbt.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Mattijs,

On 26.01.26 10:48, Mattijs Korpershoek wrote:
> Hi Heiko,
> 
> Thank you for the patch.

You are welcome!

> 
> On Sat, Jan 24, 2026 at 06:47, Heiko Schocher <hs@nabladev.com> wrote:
> 
>> Not for all SoCs the bootloader start at offset 0x0,
>> in a hardware partition of an emmc. So we need the possibility to
>> set the correct offset, where bootloader starts.
>>
>> Example:
>>
>> imx8qxp revision C0 emmc Partition layout
>>
>> | eMMC block / partition | Offset     | Size  | Purpose                        |
>> | ---------------------- | ---------- | ----- | ------------------------------ |
>> | /dev/mmcblk0boot0      | 0x0        | 2MB   | imx-boot-container A           |
>> |                        | 0x00220000 | 128kB | secure boot signature rootfs A |
>> | /dev/mmcblk0boot1      | 0x0        | 2MB   | imx-boot-container B           |
>> |                        | 0x00200000 | 8kB   | U-Boot env 0                   |
>> |                        | 0x00202000 | 8kB   | U-Boot env 1                   |
>> |                        | 0x00220000 | 128kB | secure boot signature rootfs B |
>>
>> imx8qxp rev B0 emmc Partition layout
>>
>> | eMMC block / partition | Offset     | Size  | Purpose                        |
>> | ---------------------- | ---------- | ----- | ------------------------------ |
>> | /dev/mmcblk0boot0      | 0x00008000 | 2MB   | imx-boot-container A           |
>> |                        | 0x00220000 | 128kB | secure boot signature rootfs A |
>> | /dev/mmcblk0boot1      | 0x0        | 8kB   | U-Boot env 0                   |
>> |                        | 0x00002000 | 8kB   | U-Boot env 1                   |
>> |                        | 0x00008000 | 2MB   | imx-boot-container B           |
>>
> 
> Why can't we use raw partition descriptors for this?
> 
> See:
> https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-descriptors

Thanks for this hint!

Possible yes ( I must try)... but this will lead in adding
complexity to scripts people use all over there and needs
to adapt CI setups, as siemens has B0 and C0 variants.

If we introduce this series, user has nothing to know about
offsets for different CPU modules as no change in API for
them...

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
