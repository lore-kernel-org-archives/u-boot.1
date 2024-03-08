Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEC4C54798
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 02:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1422C87B82;
	Fri,  8 Mar 2024 03:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZJXpRxEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8C81877FB; Fri,  8 Mar 2024 03:06:33 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3150D87DC1
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 03:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7da728b0597so687578241.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 18:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709863588; x=1710468388; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R4eoYdgCFfHZH38zha3ga3AS5I4SkO5vxYZvyb1TCHk=;
 b=ZJXpRxEpRKvAIfwb87RKNTxfn5VJ0EH7ZiVnUX1gwKIiP+C58fz/cRc+jBtEyf9o/+
 fTeYmwtNfCIKLAqTXgRu4rwukUFmEzNSDMCV35G8r74++dIDvT8rtG9CAQiICe+1Vgt+
 /FLOguYsY+RQNxqM0qKUWyG6LxMeodWKf9kJysuC8qfV5gZe4afoa9RSrFVXXHW/7OdX
 xrDc3JROSdQaYo7WrP718RJoR0mat7u2jvc5vvXlktEXkonzjwaNvLEt0Vsb5hOkFozI
 x6faYAADFEo4u0eNSB+erc77ITo9SYoKdtEFlq/j7PdPanwkDyRuve5fqXAAP6kVHQYi
 SGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709863588; x=1710468388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R4eoYdgCFfHZH38zha3ga3AS5I4SkO5vxYZvyb1TCHk=;
 b=kbtGBaA/FMZzHwaDznXv5IUbddQceoHVQQnXBcQAuLfjz4HUvSUAx2Di2mwWCROxW2
 e2KOpzWhgn1sX6azN6iiuQ4nlGhC4b0uj2JDlyn3sjYEEP3W+Sc5RgRyRlkIsVg1s450
 tFqqRKNrluM4aZ3Eud/Eb8c8m1Jp2WmiQbgRZLxPqjkt0mVMGyYRaCDL6LbyeY395pAu
 JwTwX8YiVsJnkK8N3q7J9SLYcwlzbGpybqg2mqVaVfBADxPMH26pxWnpVdzEmaKIvKSD
 Smm/DJmW8S3JfaXL0lz+WR08DN7Jpz34pb/EIR3ov4uMvWMgqCZl8LnO/U5I2e0xBice
 LC4g==
X-Gm-Message-State: AOJu0YxYG2vkpMx37p2c2CZxjoKzIBHJFB022HcyuYQGCTlZMNpmH8s+
 OlzLAGXCVODXEe1YEeWrOI1WDF1/xlkyQNWoUP9r7jqU1aZeHdtKasOnG4bMPySPZhcgYw1uVyC
 9D1YkOAlB5BuiOIXFU0e3mS8Wiee8uOOrBRU=
X-Google-Smtp-Source: AGHT+IHpT/wb/vzkxs79yGxateqdqdb0KwZYCYytPCIkLalEygvbTH5AySvw0MgoVhMDgpLCpZyOEXiPRaMtZ8hzOU8=
X-Received: by 2002:ac5:c5d7:0:b0:4d3:1ef2:c97d with SMTP id
 g23-20020ac5c5d7000000b004d31ef2c97dmr8093914vkl.2.1709863587790; Thu, 07 Mar
 2024 18:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
 <20240303130122.29983-4-heinrich.schuchardt@canonical.com>
 <CANV2PTMcS800x8OTuDbv8orqUD=-frNpa+0dHu4=L__D_Rmk_g@mail.gmail.com>
In-Reply-To: <CANV2PTMcS800x8OTuDbv8orqUD=-frNpa+0dHu4=L__D_Rmk_g@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Thu, 7 Mar 2024 18:06:16 -0800
Message-ID: <CANV2PTMtPggmS0hxxuovDfUnSAGM7tDXSewQ-eRTmd_+xR_L-g@mail.gmail.com>
Subject: Re: [RFC 3/5] board: starfive: support Milk-V Mars board
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

P.S. Found the longer description at
https://github.com/milkv-mars/mars-buildroot-sdk/commit/d381610c92827de01b2=
5843786012351b3f35519
as follows: "if configured as 24c04, its address will occupy 0x51,
conflicting with the RTC chip pcf85063 on the IO-Board. Refer to:
Documentation/misc-devices/eeprom.rst". What does that even mean, it is for
Raspberry Pi Compute IO carrier only?

On Thu, Mar 7, 2024 at 3:03=E2=80=AFPM E Shattow <lucent@gmail.com> wrote:

>
> On Sun, Mar 3, 2024 at 5:02=E2=80=AFAM Heinrich Schuchardt <
> heinrich.schuchardt@canonical.com> wrote:
> ...
>
>> * The EEPROM is atmel,24c02 according to the vendor U-Boot.
>>
> ...
>
> The same vendor (Milk-V) U-Boot change is present on their branch for Mar=
s
> CM Lite (which despite the naming has more in common with Pine64 Star64
> than Mars); However on visual inspection the silkscreen markings are for
> 24c04. See: [Photo flatbed scans of Mars CM Lite 4GB rev 1.01](
> https://github.com/geerlingguy/sbc-reviews/issues/22#issuecomment-1872478=
605).
> Can this be determined at runtime, or I must trust that this is not a
> wrongly marked chip?
>
