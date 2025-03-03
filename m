Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CF7C282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 07:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCAC2810EA;
	Mon,  3 Mar 2025 08:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MCJcu59l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D3F811E1; Mon,  3 Mar 2025 08:38:44 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DEA2809A5
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 08:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abf518748cbso285071366b.2
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 23:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740987521; x=1741592321; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IIwCqSzRPI6Hmou7Beo7Q+hNKH4DH42uD3QksI0C1e0=;
 b=MCJcu59lQLAsnBEpnMLFlUNkxq+SnO/+ciI54Zg3/S2xDs+Iik+hfXaXDUAV31V2QU
 4ev2fykFKyyyCh6x28mLwNaj/Zbwyxx2GaaGRGrwdDlNdMwAn/UoTQUmWKLIJw+lHXTW
 3MCmvK39xWiLIciSx4N+J/daA3EJXrSVm3bHqbjnLI9NcuqfGJf+bkFhP0vonbaz2GO4
 co4l5dsLbGIl52zhmQtov/IGUq9VXFFQbcb8L6kZu0ORSKU2i6fqMSCNP9sNEcjNM1hp
 PGpbO1WP92AwrY0XIzZkmkGfCpwAQY+zElzoOKtLEPngtfwCfFvsL0TZC64IG/8I5W9N
 XLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740987521; x=1741592321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IIwCqSzRPI6Hmou7Beo7Q+hNKH4DH42uD3QksI0C1e0=;
 b=PnJvUurprXFrdYTvEH5xKUT8tE/sX38y/2Fvj+JF7gDCDUKwxz5b5xtZ1X3BRh348F
 nk5GPhcv6h5yzPgP+3EPUGMgvn8/uCFSNCt4e6VsVm5Tx5ajdn4q5e2k0MBewo3PBoiI
 6QB1fqEXOuH7geeWa9181KSf7JS2x71H7VUmc/ZrLYgJioZDXMVFUILwX9Rb/7tu7HX0
 ml4iSpMUrmpoMYRujJjFMdGHu8Om5DAsnKaZ633jwV1u2JFRRIhx8D8MVZOHLuDliLgb
 owsvh+d4ANT3hJTv8nuV9FWk8ffswAJPAo9gtnO4JPXyLdQfTYfqwGosm4eQU4Qitv1l
 sLwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+Ua9T4en3V0DEtHxAj6T6bA8B40/Hl8dFE5LeWYdzbSr5K1iCfE4g6UP2fu/4cC6yUHoWaGA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywu6upTWAtMf9fLLjXyhlubQV8/XqoahBxhkZVzMh1YD3aTiUQa
 Bu72ukVTp0C48CsQI2CXYDZusl+0nkUsfhGWL7SXwEZ29Mz7lPQD8IA7iRNbzZ8AL6gKFZYxAoE
 8zEaa+EsZihCws2qrfUmIzurqjlY=
X-Gm-Gg: ASbGncu2uYo5oCsSW8U4LH2FT7JjCdzq08U6UjFRUgSv9Sme6pVtNuxOeGsHttTvoKJ
 y/4d0HnqmrYDkRqd/yr3BqcaFZotpnUsH0EowtvRT1GjV93QrkC/MM2bafBa8LqxRueAZEXBgCt
 09vPB5YeeIoLTjrKjiDBuBXiqckA==
X-Google-Smtp-Source: AGHT+IFITLRAqqcWZEl9dTlXpzHTr8FtMjeTn9FSr4s/odmng5QoPI2hOqxO28kj8grlrf9vXtJIghvQBL3WLWWufEE=
X-Received: by 2002:a17:906:f141:b0:abf:497d:a23d with SMTP id
 a640c23a62f3a-abf497da819mr1005180366b.53.1740987521317; Sun, 02 Mar 2025
 23:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20250226184506.64114-1-sebastian.reichel@collabora.com>
 <CANAwSgSur2VawHniSEZBD3AO63YnvUGf9m1_8p-XMNxQF+yziQ@mail.gmail.com>
 <CALeDE9Nq_xbOc3W8hefPQuVBi_Xc_2r18cw6+jeEHeGKyHEa-g@mail.gmail.com>
In-Reply-To: <CALeDE9Nq_xbOc3W8hefPQuVBi_Xc_2r18cw6+jeEHeGKyHEa-g@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 3 Mar 2025 13:08:24 +0530
X-Gm-Features: AQ5f1Joe1Hoo_KU-98RawnxIw-IGIxkPJVto5JdiGjqObGihkn76Cj6_MSMzDc4
Message-ID: <CANAwSgTu3ixjQRLZRqx_+nHNinDJSdphHHELtiHLANs+LF9YCw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] USB-PD TCPM improvements
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>,
 Tim Harvey <tharvey@gateworks.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Maxim Kiselev <bigunclemax@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Peter / Sebastian,

On Sat, 1 Mar 2025 at 23:41, Peter Robinson <pbrobinson@gmail.com> wrote:
>
>
>
> On Thu, 27 Feb 2025 at 06:01, Anand Moon <linux.amoon@gmail.com> wrote:
>>
>> Hi Sebastian,
>>
>> On Thu, 27 Feb 2025 at 00:15, Sebastian Reichel
>> <sebastian.reichel@collabora.com> wrote:
>> >
>> > Hi,
>> >
>> > I have a couple of fixes/improvements for the TCPM code. Three are fixing
>> > actual problems I noticed on the Rock 5B, which prevented booting up the
>> > system. One of them simply adds an error print before potentially committing
>> > hara-kiri by triggering a hard reset, which helps people understanding
>> > why their boards reset themself in case there are more problems. I've
>> > recently added the same print to the kernel TCPM code.
>> >
>> I have encountered issues with the Raspberry Pi Type C power supply on
>> a few occasions.
>> Thanks for these changes, but it dose not resolve the issue completely.
>
>
> I don't believe the RPi Type-C power supply supports power delivery.

RPi 5 Type-C power supply is generally compatible with the Rock 5B for
daily use.
I also have the Radxa 65W official Type-C power supply for the Radxa
Rock 5B board.
I was checking the connection messages with different power sources.

>
>>
>> Do you have plans to add a device tree node for this board?
>
>
> For which board?

Radxa Rock 5B and Rock 5B+ indeed have a versatile USB Type-C port that
can be used both as a display port and a power source.

During my investigation, I discovered that the Type-C port uses the
FCS, FUSB302 the
driver instead of the TCPM driver. The FUSB302 driver is specifically
designed for
USB Power Delivery (USB PD) and supports various power delivery protocols.

Here is the device node

[1] https://github.com/radxa/kernel/blob/linux-6.1-stan-rkr4.1/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts#L744-L814
[2] https://github.com/Ralim/usb-pd

As of now, I don't have a Type-C power source monitor to test the feature

Thanks
-Anand
