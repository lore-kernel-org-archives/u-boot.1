Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A5CE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 23:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B6F18043F;
	Sun,  5 Jan 2025 00:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TmzqeB/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5A0F8056B; Sun,  5 Jan 2025 00:02:42 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E52E803DC
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 00:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736031753; x=1736636553; i=xypron.glpk@gmx.de;
 bh=olPuDLKBOE9HkKFdw1vXh2DIImQTc8L3hpishJbRxbI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=TmzqeB/bf2ZX/6nibWy62mwytYn5roajaR6NJzUtNzFHtDKrWvPIU/0+KvKlADCi
 tX9OIXTfXjZo+FmJ8PSAZAqImL+ehaArgv8hss/bjGu65vYn/gaYXEMhwrK5/5PSf
 nmZt8oOSABI4IiADfXa87fxumxYFYFZuV9U5VdN1KoK5oI3Ytn9J7E1dskb4TBtZU
 Xka+Fc0Ybil0lsq4cWzwo9CPELeQzbE+1yCwSxTb+SfOSYDy669YdbZIRXhh51bW5
 ddVFLbkoTl6ftuS2GJy5RcHB5byMwy/zgJT4IOTGuXhDVBknDM27v9TAp0AdpkhWv
 xrpnQwwyG4UaCjF7vQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.106.210]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0G1d-1tih9L3KJ5-00wXaS; Sun, 05
 Jan 2025 00:02:33 +0100
Date: Sun, 05 Jan 2025 00:02:30 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Kever Yang <kever.yang@rock-chips.com>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] config: efi-x86_payload: Enable DEBUG_UART
User-Agent: Thunderbird for Android
In-Reply-To: <CAFLszTikmQfBsQTJ5FLfvOv2GgPWPj0GyDCoCxYnXVtbruvf-A@mail.gmail.com>
References: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
 <20241128114737.2.I03b59e1d26d2a79a666adc8ef313077da8dce145@changeid>
 <c31b3d7a-c840-4b3d-a6fe-90f9a576ffb4@gmx.de>
 <CAFLszTikmQfBsQTJ5FLfvOv2GgPWPj0GyDCoCxYnXVtbruvf-A@mail.gmail.com>
Message-ID: <3EE77A40-CD92-4330-B66D-7F00CCEA7BE4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iI0Y/AsF3/eEsn6pShAMzFS96wMP6XZS/ymZ0h2RRqX6xvEbEA1
 ZA/tOiS0Z0/aZK+3H0HKhZri9yFwOcxOJz0WixClagG8dTmImrEXiw5EyU077IAMx5Mt1SC
 a9PGGKbm+nd6Ys3ljRU21kkbdsy42m7byfJez49a9KKNDYM40yK626OqOAHYgfxOYItyBZw
 +Bez1LlBqwj26KMiB/lDA==
UI-OutboundReport: notjunk:1;M01:P0:LZ9HmEQkwSM=;dKMSwTz4gLguuAyr6gMfWvyfNUB
 EBNjzFMb6/STzFBn23y5Y5E9PO6j28Q8hTavosLsTVdROVJ5vDgz+JBwue6mAHi5tou6jB0hn
 FsULgHCvjkqdg3oQQr6EqAy7lewAq7Uk5YmJ3SJ4TSnm7qxnx18GrY7fYUBSmqtCWmibMV0dz
 6XzoWj1aC+q28xFHuBc5evdUQvsj3jDrtPcZe0RrDYAJhOEb5qERo+dM+BGa1+GHVVP91v0c0
 QyhUCuT6OynLtIXDXVmlSvgJc8GNJdfo3NryIvpV71FXPRl9G3p8CerHuBFyxj5PJWOk0ittk
 UaTX6e2L3X7QUv5BIFTGSGxOKCybTs9wasJoj3Z/2z5QefLWW1h09TuTsngZAG8tRYaCULHh7
 f8PoS3K9LRqgwMUFRuG7TY5kk67oZdI/Lq34HTKm3MyvH8+F5/0axfMoP8c4aj6myjeKPxw/h
 BYVhB0iR/hDK7aOX4VQecUtwrBa9ZH5951SQADliBjIF/7pOlOb89/9gg22yf8r+2sHWQxUpV
 uw02NPfITqnwgTZNQdF7JmCuL7yX/3uuJ+XoQ3lNJaGorYrualUxksOSLuB5kfRiVTssI8jwO
 VNF3V+k/oO4RaB3LsnU8r13s/M1jMZy8yl4HyAIbr2rcJkIo0JW6Qf7pZ8cVU9oZRzYWQYq4M
 pVMgHmeF4WtWY6Tk7pFuNnHiIVTWb4BYCGPbYNxcuMTlzaEaqwmKkN+X+q8TzSZeVRNxxhCs7
 nFwu3/CzX27H6TEgThztxIj8D3sEgvRBTcVxXKbX15a8PFB1PNZfOzZBYtSPNM3qL3zZu6yyr
 BOIaek3UB0xgG2lU63u7jo2Y5Iuac4ViomeAp9PRNPnQPpjI5u2qJhRSw27gugSxXpMKTMZZz
 wiZze5hd+wGmrfdl5cA3WwT+xolRWcr7ZUnBHDijtMu6W5hCwiErgzoJNaKIClNRNDka6m7g3
 rmVUjQjqkLLYHLt6yTvJXZHgdgXmLHkthJxfOfEodg+Abw7OJE2sUhoQhVXAPCt48n9O+eNTo
 Nmtp6tap52l6UJtcG5O1vPzpRJb7oVEfKle3pQvv5GQHVctQNSPXGsMYwLyhP7dR2Sm2aD72s
 Be03vyRwEgMcwyuDygtZxmkCQ+oaYj
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

Am 4=2E Januar 2025 20:29:43 MEZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Hi Heinrich,
>
>On Sat, 4 Jan 2025 at 05:16, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>=
 wrote:
>>
>> On 28=2E11=2E24 04:47, Kever Yang wrote:
>> > The efi_stub is useing DEBUG_UART interface by default, Enable it=2E
>>
>> As Simon already wrote in a code comment the implementation of the EFI
>> stub is broken as it is not hardware agnostic=2E
>
>If I said that I was wrong, sorry=2E Actually that is the stub's intent,
>to take over the machine, exit boot-services and carry on=2E It is the
>EFI app which is designed to use boot services=2E
>
>So the stub cannot be hardware-agnostic, unfortunately=2E It only runs
>on x86 hardware, unless, for example, EFI has something like
>serial_getinfo() or we disable the UART / keyboard input=2E

I would assume that there is no serial console that the user has access to=
 on many x86 systems (like on my laptop)=2E

In the stub itself we can use the Simple Text Output Protocol and the Simp=
le Text Input Protocol offered by the UEFI implementation that started the =
stub=2E

The UEFI specification defines a Serial Io Protocol which may be implement=
ed but I would not know why we should restrict the usability in this way=2E

Once we start U-Boot of course we will use hardware specific IO, e=2Eg=2E =
on a RISC-V system use the debug console offered by the SBI=20

Best regards

Heinrich

>
>>
>> In the EFI stub we should never directly access hardware=2E Please, use
>> SimpleTextOutputProtocol=2EOutputString() for printing=2E
>
>Once the stub starts, boot services are gone=2E See efi_main() for how
>this works=2E There is a definite point at which we stop using that and
>start using U-Boot's own thing=2E
>
>At this point I think I may be misunderstanding what you said=2E=2E=2E
>
>>
>> >
>> > Signed-off-by: Kever Yang <kever=2Eyang@rock-chips=2Ecom>
>> > ---
>> >
>> >   configs/efi-x86_payload32_defconfig | 1 +
>> >   configs/efi-x86_payload64_defconfig | 1 +
>> >   2 files changed, 2 insertions(+)
>> >
>> > diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_pa=
yload32_defconfig
>> > index 071ddb8e36d=2E=2Ef0b9acc358d 100644
>> > --- a/configs/efi-x86_payload32_defconfig
>> > +++ b/configs/efi-x86_payload32_defconfig
>> > @@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"efi-x86_payload"
>> >   CONFIG_PRE_CON_BUF_ADDR=3D0x100000
>> >   CONFIG_VENDOR_EFI=3Dy
>> >   CONFIG_TARGET_EFI_PAYLOAD=3Dy
>> > +CONFIG_DEBUG_UART=3Dy
>>
>> On x86 this uses the NS16550 UART driver=2E This is fine as long as we
>> don't use the debug UART in the EFI stub=2E But correcting this is for =
a
>> separate patch=2E
>>
>> Having a debug UART available after the EFI stub makes sense=2E
>>
>> I will update the commit message when merging=2E
>>
>> Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>>
>> >   CONFIG_EFI=3Dy
>> >   CONFIG_EFI_STUB=3Dy
>> >   CONFIG_FIT=3Dy
>> > diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_pa=
yload64_defconfig
>> > index 71612d7fb19=2E=2Eb02a861e59c 100644
>> > --- a/configs/efi-x86_payload64_defconfig
>> > +++ b/configs/efi-x86_payload64_defconfig
>> > @@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"efi-x86_payload"
>> >   CONFIG_PRE_CON_BUF_ADDR=3D0x100000
>> >   CONFIG_VENDOR_EFI=3Dy
>> >   CONFIG_TARGET_EFI_PAYLOAD=3Dy
>> > +CONFIG_DEBUG_UART=3Dy
>> >   CONFIG_EFI=3Dy
>> >   CONFIG_EFI_STUB=3Dy
>> >   CONFIG_EFI_STUB_64BIT=3Dy
>>
>
>Regards,
>Simon

