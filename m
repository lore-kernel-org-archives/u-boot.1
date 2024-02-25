Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4BEC47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 10:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A835A87D91;
	Sun, 25 Feb 2024 11:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NJUsqb4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF4587DB0; Sun, 25 Feb 2024 11:31:53 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A047187D8F
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 11:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6e49332d014so406181a34.3
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 02:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708857109; x=1709461909; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yZ5WlsDR6rDQRUu7IGVwq1eAGt135gq4PUvwps53M6Q=;
 b=NJUsqb4LfK8qvTO/RiTjFov7Dbo51MGn4kS3H8i4qVETBEMSQTU5GTNZlSzo2tCmn3
 hlTJSrtxS5n7apFM/i5D8RuNYLTDIR7ml5NgR561Ll0ml/tF14GF29KYw4ADQRIv1TWP
 caYNzx+0TptNO/zSaDeUkt49Sd+kyB9tlKMoioq9wBsfLklUbuJEYXLFwT8gnhHvqOtz
 R3jh6uVmN9+yc77fqOku896bSGq/e9dvs/r71jlbmrGEnfChREcI8VbCF+ZbLe+dwHIH
 gIhVitt9fZxPjslUcy3f1O5L9yCxr3wZqyO4oAyDU1Aa+yKEy74EUOTJJUPqPMXV+/r0
 /qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708857109; x=1709461909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yZ5WlsDR6rDQRUu7IGVwq1eAGt135gq4PUvwps53M6Q=;
 b=Fz3Hz5OweRA9MCf0/IaXQ0Rw993rFxbFuz7w+LHRicWViILwPCUlGxsF0qOkC3qNSz
 l4HY9vPMFmiY0UDJ8arw0jc89wP1O5t5hG0rKBxpyWfE8I+QVBx8/af5UOzb0rYnm+ru
 J726s4F1fKrnehOUz1QlbRrnkMFjilLhWVsmRdVDdIBKqfK2Ua66U+putlgeskEr7x07
 ryzpukj6g8+Ti61ZFspy5dgoWp6K3Th1E7fRGRW/77IXdkkpJekj7QG/yu78BGRyzV6z
 knCGKhKpzZC5/WaUR/UvgbMQi7c42LN/m7gKxc9mtwthchnZ4kU8IdQ3gUf3cHDdvQ5c
 Y6Fg==
X-Gm-Message-State: AOJu0Yzf/cXz2YI4Hmcwa66okD3cMo8kYHEhOcgueSXkv38E5il0SvJj
 ukh4ug+P4bsqSmkkRNpQzgI+MHGW1g2q39qmldOfv9cpwNLHP3x8tuGDFu+OG+oehnG6aBDTJEw
 d9t3fTyDAy7+zV84MU9DAdXQorok=
X-Google-Smtp-Source: AGHT+IEkCNMkTGxHXJMyKazkrm+9nRJHgv5bHPocs4shq0MYY4bkVZywpQ1JqKk/Qz13spBEGiPOVbxbVsorhuPo1kY=
X-Received: by 2002:a05:6830:2a8d:b0:6e4:75cd:85ef with SMTP id
 s13-20020a0568302a8d00b006e475cd85efmr5251597otu.36.1708857109145; Sun, 25
 Feb 2024 02:31:49 -0800 (PST)
MIME-Version: 1.0
References: <CAHseuWAmUbWJtmH8TNtr6_P3ibd6+1yT2kKticNdbfLdMViLqA@mail.gmail.com>
 <CANAwSgR-Bd0ck-LkYb9QcNigP3Ht61RxYds5=YFyX58pdeusCw@mail.gmail.com>
 <CAHseuWD93woj0sq6iMBjdKs2_Ny4=P_3TWtZRGdUFijDMSRzXw@mail.gmail.com>
In-Reply-To: <CAHseuWD93woj0sq6iMBjdKs2_Ny4=P_3TWtZRGdUFijDMSRzXw@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 25 Feb 2024 16:01:33 +0530
Message-ID: <CANAwSgRQMQwTO0GjFpk0a9LHGhcwC2_C-YvWao8FnuQavZibRw@mail.gmail.com>
Subject: Re: Raspberry Pi 3b Plus USB-Ethernet lan78xx_eth address not set
To: Sourabh Hegde Ramu <hrsourabh1107@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi,

On Sun, 25 Feb 2024 at 12:25, Sourabh Hegde Ramu
<hrsourabh1107@gmail.com> wrote:
>
> Hi Anand,
>
> Thanks for the update.
>
> Yes, I can set it manually. But this should be done by u-boot, right? Is there any reason why this is not happening on Pi 3b plus?
> I have other Raspberry Pi (4 & 3b) and they are working fine.
>
> Also, is this MAC address for LAN75xx or LAN78xx? The error message shows lan78xx_eth.
>

Most of the ethernet controllers get the MAC address via EPROM.
or they used some logic to set the MAC address.
check CONFIG_NET_RANDOM_ETHADDR this flag is needed for your device.

Thanks
-Anand
>
> On Sun, Feb 25, 2024, 06:50 Anand Moon <linux.amoon@gmail.com> wrote:
>>
>> Hi,
>>
>> On Sat, 24 Feb 2024 at 01:56, Sourabh Hegde Ramu
>> <hrsourabh1107@gmail.com> wrote:
>> >
>> > Hello,
>> >
>> > I have a Raspberry Pi 3B Plus which I want to integrate with U-boot
>> > (v2023.10) .
>> >
>> > I am using rpi_3_32b_defconfig to generate u-boot.bin. But while booting I
>> > am getting below error
>> >
>> > Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...
>> > In:    serial,usbkbd
>> > Out:   serial,vidconsole
>> > Err:   serial,vidconsole
>> > Net:   No ethernet found.
>> > starting USB...
>> > Bus usb@7e980000: USB DWC2
>> > scanning bus usb@7e980000 for devices...
>> > Error: lan78xx_eth address not set.
>> > 3 USB Device(s) found
>> >        scanning usb for storage devices... 0 Storage Device(s) found
>> > Hit any key to stop autoboot:  0
>> >
>> > In the "bdinfo", "current eth" is not set
>> >
>> > U-Boot> bdinfo
>> > boot_params = 0x00000100
>> > DRAM bank   = 0x00000000
>> > -> start    = 0x00000000
>> > -> size     = 0x3b400000
>> > flashstart  = 0x00000000
>> > flashsize   = 0x00000000
>> > flashoffset = 0x00000000
>> > baudrate    = 115200 bps
>> > relocaddr   = 0x3b360000
>> > reloc off   = 0x3b358000
>> > Build       = 32-bit
>> > current eth = unknown
>> > eth-1addr   = (not set)
>> > IP addr     = <NULL>
>> >
>> > I also enabled LAN75xx in menuconfig and re-compiled u-boot. But still the
>> > same error.
>> >
>> > However on Raspberry Pi 3B, I don't see this error and "current eth" is set
>> > to "smsc95xx_eth" and "ethaddr" is also available.
>> >
>> > Can anyone please let me know the issue with Raspberry Pi 3b plus?
>> >
>> > Thanks in advance.
>>
>> Can you set the MAC address in boot environment?
>>
>> # setenv ethaddr 00:14:05:42:03:BB
>> # saveenv
>>
>> It should update the mac address for LAN75xx
>> printenv should display the mac address
>>
>> Thanks
>> -Anand
