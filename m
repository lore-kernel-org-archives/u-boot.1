Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4034CFC293
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 11:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24E1688E5F;
	Tue, 15 Oct 2024 13:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="F1TgIrgW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C246788E84; Tue, 15 Oct 2024 13:36:37 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9FB088E3F
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 13:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728992194; x=1729596994; i=xypron.glpk@gmx.de;
 bh=27gWFAMoeQ9Ip+Nz92VG+77GaOmhpggw4VKZT3q84oI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=F1TgIrgW2Uywtv3pMv4vO9/DH8+sE66mxAtIrGS5afpiwdEbqXBQULjtftb/3KIk
 amUmHPXnHajuE4lHOCXYTm930QHBLeQYAUm/sVHm/LnM/30AlKlqOj6X8oVRA0AJY
 MaihOl2TcLeEWYA4k3ugy9YJ8/hr+JEEJZ31H0YFh4IizPfW32kIXr7VRs8N6Pvcj
 FO0vLNEo59kzfAASSD4v+hpzslcfAIHRFgrN5O6VjulPJm9PjQR1LYZLFdmttsg6B
 1DYgWFfzsLkGqJOYQJR2nQiKnqcC4q2jQJ4o4FTKCMZzbV88YA40luyOZ5GNQzvrR
 GBrXDg77L838jg2Dzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJVDW-1tG0qY15wm-00RxVv; Tue, 15
 Oct 2024 13:36:34 +0200
Message-ID: <23757cf3-c27a-498d-9e66-59261f060102@gmx.de>
Date: Tue, 15 Oct 2024 13:36:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/12] test: efi: boot: Add a test for the efi bootmeth
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: sjg@chromium.org, u-boot@lists.denx.de, ilias.apalodimas@linaro.org,
 Tom Rini <trini@konsulko.com>
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-13-sjg@chromium.org>
 <20241011223227.GA630742@bill-the-cat>
 <CAFLszTgoxND_qi8WzdgC8-mQLf0e14Mt=KgXy=bqWkqo4svG9Q@mail.gmail.com>
 <20241014035122.GE53053@bill-the-cat>
 <CAFLszTiVsoTdKiKmPVugc9cLk-A+XM2EdiPUE0AFK=g8RPx+0g@mail.gmail.com>
 <20241014211150.GX53053@bill-the-cat>
 <87cyk1hdne.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <87cyk1hdne.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qEFk9wkAkQN021Dc70p24mOXF7AgTfwaDzfZc5iCVKIAJXI0x+/
 5GERG1Ng8YNRS5i6jWKoYgA5LFu8PJ8pXIAr9HhulPj5FOFV1s/+AZzZTBpXJLV8zeY5tdF
 sIMGHTkwwegh1GlUvHuQUBDy65onJMETHsgQ3i2G7kRsODjZsDaLeqSEt0N5CEaD/tq2MEd
 7j/I96eqCDh3NS0orCtTg==
UI-OutboundReport: notjunk:1;M01:P0:k2mAv3Tesr4=;1DE2io1BaklqRUfvwG4hYdp3ok4
 AvqY1NjzBJIWavN4V32LTpDEvsOLts9Hc3ZagK05kT4sJKdR/OjB0vzK1a45kHFjaUrHm3acT
 CAbc4m5QpqV9ivm+7CQrQEZHdTr3P7+ZrhsiFGSSaTUXhTbeQ68bdIf2AMhlTgKKj0fT6Iqdn
 dsc60XexuAD8IYtiIaqhipYN6OlMU5LzW1e2ZoYTLWZiSJpyNPHFTthSK5Pj3kXUyC9tSiXjy
 XafMH/67ITlooqSl0FAXivRrdqcW6fUjOc08r9hLihmtc/8PkvAxrnnZ0ODWf6toN6XkD8Ozl
 LPrUHCX/q3wtKHJM57Ev0iH4Ta+Kt3sNl368XEW6xsUIHVuyhDRpPX2IsqcBKp5N82v0I6BMf
 u2FMs5PPzfnktJbvo1DjKrMtJ3oIbaKGiQYweerPjECRKBlPUAl5d6r9i+wv398Bs7FQRyORF
 DvHsyCChSdWoWZVaX21jpYdegYeQzCni54DnJYoJSDMDJ7NNOnTohk9YSue2hgUw8LD3PsjbO
 ikuemwFHJJvAdvEJr0Stxs5mOwdAmXcpmBVbKJlgB3mlWsWcIxMYhNABhXrbkhIOAQkVT971M
 Zy8uvu4bkjquEz9dtO78XCNZHsuK7cl1dDTVge0AHfBq3CW53TNx8/G0geslU6TgT7HNUaQ5y
 JAUigz6UL7EYcTi/GXRFszW4kJq1iqxT/zT4HJPXTZyyYcNLfdjIu+lTLF6cpXCDSBcOJAP+R
 V+b90P8jqekIHeG+upCf6l3NvSHfkWPykMGlzgcJQXdhH9reAYGmkhTGSNTELxkIwdvUYfjSM
 EHXuxiS/e4vbErJZOYycvl8g==
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

On 15.10.24 12:19, Mark Kettenis wrote:
>> Date: Mon, 14 Oct 2024 15:11:50 -0600
>> From: Tom Rini <trini@konsulko.com>
>>
>> On Mon, Oct 14, 2024 at 01:13:41PM -0600, Simon Glass wrote:
>>
>> [snip]
>>> Or perhaps just have a way to turn it off? I first sent this patch
>>> last November. It is just wrong to generate output like this which we
>>> don't want. There isn't even a test for it, so just add a way to
>>> disable it, and be done!
>>
>> I don't know that it's unwanted. As I'm trying to get Heinrich to
>> explain, _why_ does efi_setup_console_size need to exist, and do what i=
t
>> does? This isn't the case of color-coding the output of tests as they
>> happen, there must be a reason we care about knowing the console size.
>> At that point we can figure out if the right answer is:
>> - Don't generate that check on serial ports, it's somewhere between
>>    misleading to wrong.
>> - text-based tests just need to expect and skip it because there's a
>>    good reason to need to know the console size and not just assume
>>    80x24.
>> - Something else we won't know until it's clearly explained why we do
>>    this.
>
> Sadly this is a misfeature of UEFI.  The EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL
> is required if console devices are supported by the UEFI
> implementation, and is built around the concept of "text mode" with a
> fixed number of character rows and columns.  That pretty much assumes
> there is some sort of terminal emulator on the other end.  And this is
> pretty much incompatible with anything that just want to log serial
> output.
>
> I think it is possible to do better though.  Instead of calling
> efi_setup_console_size() in efi_init_obj_list(), we could postpone
> this until the application makes a call that requires us to know the
> size.  This would mean that a simple EFI application that just uses
> EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.OutputString() (such as the Hello
> world EFI application or the OpenBSD EFI bootloader) wouldn't have to
> do the size query.

The implementation of EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.OutputString()
needs to know the output size to update the cursor position in

   EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.MODE.CursorColumn
   EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.MODE.CursorRow

The EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL is passed to the entry point of any
EFI application via the system table.

We could delay the invocation of efi_setup_console_size() to the launch
of the first EFI application (efi_start_image()).

Best regards

Heinrich
