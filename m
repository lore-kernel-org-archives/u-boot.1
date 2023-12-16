Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A34C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 21:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E90BE87BF2;
	Sat, 16 Dec 2023 22:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uhNBwvCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F99787BFA; Sat, 16 Dec 2023 22:08:45 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75AAB87B59
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 22:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702760922; x=1703365722; i=xypron.glpk@gmx.de;
 bh=EdFUJt+UyNn4yMo0yGnBdcYF0aTXfLpG/NkSlmuLKfE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=uhNBwvCCYBivwgtf8lxJmbfBgG5zpyPd3Bkuq2uKuLzk69w8zDBHoApFlLaLxOm0
 56OhQEmFWrCTHuwknrQrSvMISWZ2pB1+WJFjpx/nTeFb1WPB2/IfwUtrFmK5/k1b0
 Ru58fyRUXWMBfpNDYGoFt2dX/QB0bQ3tIrNce3ffHqxGfO2SctuHSm4jfyQBVE6l3
 gX/yc7Mye1lD1POdVIZP2Fn9/FX3pgzfaB0LrLQeb1JQVdOqryfDzdRKAQ/PNCsZM
 NuzD3zUHDUD9dTOPzYJ06dqpUfjcC3xrtndTCi3DfRo09VgxHYQ11+DZc3XPPzOu1
 yVt2vEepiDuYQdvJmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.0.170] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVDM-1qut9e1POS-00Js85; Sat, 16
 Dec 2023 22:08:42 +0100
Message-ID: <6d926cc2-6100-4b1a-8ee1-11a19ac36f35@gmx.de>
Date: Sat, 16 Dec 2023 22:08:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Booting fails on the sandbox
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <acfe7ea1-a25a-4293-9e05-bfe4ed7c2a05@gmx.de>
 <CAPnjgZ1CmmEHxOKPRVbo1zjQ8FDQ1HxdU9ww6c5fJBFc7+Dtjw@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ1CmmEHxOKPRVbo1zjQ8FDQ1HxdU9ww6c5fJBFc7+Dtjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3I7h+5OER2lbX7J1dxT9uYYzFI1dI3kMGNH87a8R+vx1GDnc5I2
 FuzDiATxXdmAZWoJY6KIHCmme6EvAkZIZrhNuwcwerRlCphjAQPt8h1VJJIhAfl2HXJMaZc
 b/AKRkjl9jkmy9Wmji5dSSdXrFmq8tHbbaQalqjln3udyua1sp5V+XWd8Fp9xQk/T/ZP60R
 +nveN0OfRhC/QXqiA2d3w==
UI-OutboundReport: notjunk:1;M01:P0:VtTcSFLverw=;FzmYO/oCIbCgxB4fvtqhJBrwnP0
 dijQvNRwFTamP11bvJKDvodt4V8fTp7M8XESMeTOtdKnm8D9xKj2QtXYSxM7HMLv1zjD+Z6OA
 aflPwcfvxYtJjLZ+foxp+lBG2oHvPwB6pb/9wNIbpmRpeNN++NvMmLKkqiRZZxLczftT1t05Z
 +t1DbFCcqAZcL3cMNctjSGby6S+izwX0mgqKx69CvkufOcZ+v/hdezNM6Ufjo0tu74PP5LF/O
 tqvuUFv4sTrd3C/C/hufxzz7ZNkcgwy+WrqGBiZA1enVnhxa7qskjvBdqMVi1RfTqe56uyU1F
 mxn0BIO73pxfBYjfKaNG4jpcJoPXMsqKFHgzcNs2OoEXFVDM4f6s0F5s1qzDZXYxvBT7k4BPv
 4Ue3D5F4S0DZB0OCwPTY69IT2CbUoXsPgVED5pOmd9M52CMvdlGu/AmovKfrsGAnEeco5uq/B
 8cYNk/qeh/9qRif5f0q0ER8rLoYpKiCV7IRKMxR+/wiltx4dknIfrsqBaD3VDm+nOmrrrXIeQ
 kWpgybi/3hu6AdKnQ9WoYIDgGWRXDBEMhJv76VgQSsYxRbK/nZkHm8HO8x2FekbuRKht4Pf/r
 CjRcRODs5vvFeMvlRuIsKSgXmkSfmwo+Ns/ROhxYS2QXNJsp1b/zJXlNw/ylu5bw94l9tCQz8
 pz/49g5xBN5qeIUEhm+JkPhWPB+Yl/4pR8OTKg+uFZ7vupS+Q3vRJ6vqSYjDV4yH969Aw8+Ab
 Kyzsk9yzqwaFSR5OnKml/zg843YHPsUOtDofCSWVX2L/SkkMtPzfWJIFzpHCBmbyHCk6WLwQ7
 /x0RJOZH9z4Mt1fa7U4jI8NjwpS3Gg26YsQLDM8CUI2vsclCuRKJP/lPavKIUStYvQ4avxOqr
 eP3nlIfP7M3uimqQ7YW1aktPr4hPapUpf3kdRRN2AywTQT8bsaY2mI3bC/oQN3YQpLcdBrBZN
 6d/6NNElfvwqqis/57wD06trsdg=
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

On 12/16/23 19:45, Simon Glass wrote:
> Hi Heinrich,
>
> On Sat, 16 Dec 2023 at 07:50, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> Hello Simon,
>>
>> I have built sandbox_defconfig with PREBOOT=3D'host bind 0 ../sct.img'
>>
>> On the image I have an ESP with file EFI/BOOT/BOOTX64.EFI.
>>
>> I would expect the sandbox to boot from the ESP.
>>
>> But when starting the sandbox is does not boot. Instead it shows a menu
>> with some Fedora related entry:
>>
>> Fedora-Workstation-armhfp-31-1.9 Boot Options.
>> 1:      Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
>>
>> This makes absolutely no sense on an x86_64 system. Could you, please,
>> fix sandbox_defconfig to boot according to distroboot.
>
> What sort of 'fix' are you thinking of? You should be able to discover
> all the options with 'bootflow scan' and then use 'bootflow select' or
> 'bootflow menu' to choose which one you want.
>
> The Fedora thing is used for testing and development.

I want to autoboot the sandbox without manual intervention. This
requires a sane state.

If that Fedora thingy is only needed in CI, can't we put it into a
config segment that only used by the CI scripts and have the sandbox in
a generally usable state? Or can we let the Python tests add the
otherwise not needed bootflow?

Best regards

Heinrich
