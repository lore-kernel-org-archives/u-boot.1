Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0E5D44D78
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 10:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E5A089209;
	Thu,  7 Nov 2024 11:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WyUveHQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E394189229; Thu,  7 Nov 2024 11:46:07 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9416D891E1
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 11:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730976349; x=1731581149; i=xypron.glpk@gmx.de;
 bh=yDPMV1CLbChKXsTktCE/3wctqSvSHb2JjlvMbEM6VG4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WyUveHQSGQvSzuKmnisMmsh1CFXwKc5WMNy8zAbnV8VwOgMyVE6FIN7JtSESGdsD
 zHopr3EPAtBJY8Nf1TYmTGr35WuRRn4vIqbq127y90lyDAE1p0Qr/CygLwstZ3D1Y
 wyAiFjtjxuQiIEYd88ODD2HbBkG69QObiVAkRulz7GdMXc4KvQIdQTl8A2waz28on
 i695EnHjBezcqktZMGohz2Maxtc3A+W9wTLkmZWdNDEevOvuUISh8rKW3S3ZgaT4q
 bl4mx0G5M575RrE/uQnyYnjaTOH5Ct5x/b3WCRz2qW392InCGmTAiBmsSUzvnt6OP
 J+fevZI6cL3ZA+M7PA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFzr-1szPmS0Ra1-007RJn; Thu, 07
 Nov 2024 11:45:49 +0100
Message-ID: <bf63e626-0ffa-41a6-b464-9aa3fa3c9cf4@gmx.de>
Date: Thu, 7 Nov 2024 11:45:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/11] efi: Add a test for EFI bootmeth
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sean Anderson <seanga2@gmail.com>, Shantur Rathore <i@shantur.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241101152614.238747-1-sjg@chromium.org>
 <CAFLszTgTX+SSqdJq3ASK4aeciSXrh_YAtYgrKFQYGU-LJABj=Q@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTgTX+SSqdJq3ASK4aeciSXrh_YAtYgrKFQYGU-LJABj=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xbrt1r1GXW98Oj6q5ypCgPoZFLtYwI4aIA7m+ZHGPfONVBJqvSz
 BWJtzjT5QYkJZed9FcxHvuc5NJrHfFysQQh7qKc2ueAZv/MvW2n4A0fSQTkbe28aAo2XRoD
 ZYnlsv0+YUEaCHFeoHC7vjQ/xYxiCdKhVbX71yvzLzRocOQL1BGACaA/oCJVtFtqwrvtvIp
 kEVAG0isFWlN5ALNGDjCQ==
UI-OutboundReport: notjunk:1;M01:P0:bEb4z4Rkmag=;Goillh+UqxydKDtLzVP4if1RfJv
 G2n1Kny8zyCu9LzgUPRHSuU7itGky5Ld2dWwgtkunEj5Aq+XswYhjCd3ie6BgqMQhVOKE2qUF
 u2j+bhV9dlET1W/C5zsrfUxVtFliYFNcs/VSUE0NZImUlI2SiLWuugjUqPJUZCy7ARFVAa2wE
 qkjeMPv/sH845bKLvk83b2lYK42AzuBHpdqw5dvblHv6n1d8fkdIARfjUFk6b1hUivRGksuru
 KeDfsQO0FkK/7TczT14rACBn76HgLqEfg1VlFd4hCtitjDggpOVYSdMRRMYTMq5U7JnetXh8e
 E+l6c0WTbmw+bXwl2xZOzBVV8n6T2vTl05IorH3pwy5jccB9nrk1ClilDsI3o33vqIcgJsSJX
 RtiaS8gvQbxEeUutOul7kV5GQSpC8gpC7vUJhrQ1gBnAmSq0SqAG7i+u5zs4sYhN3Apy0E29g
 soML0/lSdCDG+bWJxxoKjyvmVcFDziVveTuLF+3XXI7PxcZTd7suKZTSeCOmQ/XO1GusLI9qD
 0rCodhHR2csFU3mELmtqLXJtg+9zptyJgbDtjzpWI36/5AnSJIkRvztwyQE+sig1Cnm693JZ6
 ZJubBHSa3/Fmk0U0tR9xAmTNCSwynVkEsvgK5Y7dYUibCt+jLKIJ6kgWmxcvQvG/46twkiXrZ
 3ZqpL04YA4CLgDLFt1n2PLoarCbfBb4Ir1jegWvlYcmamsQX67xt+P1H1jkZJN6AeFzSjMCdz
 0X8x5aHeLr/yJOiKmgVMFeQyJWKiadxPLvUDF+G0b3aDT3D9CVh6qW6z241Gku61HosqcGvCy
 dBsjEpjqmEahGo7JetkIDLLQsTWx/2X1YFtqngV1ExlPvDKLeXzenUnA2U+X63AuZG4QDG7lJ
 KsPwCs0Kt0YICNGmy/3A3YOkCEhLA4Km1+QZ9ptcXf5Yk7UkZYfEbMIVA
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

On 11/1/24 16:32, Simon Glass wrote:
> Hi all,
>
> On Fri, 1 Nov 2024 at 16:26, Simon Glass <sjg@chromium.org> wrote:
>>
>> The test coverage for the EFI bootmeth is incomplete since it does not
>> actually boot the application.
>>
>> This series creates a simple test for this purpose. It includes a few
>> patches to make this work:
>>
>> - Revert of an unreviewed patch to change the sandbox efi filename
>> - Hang in sandbox virtio due to EFI probing all block devices
>>
>> Other necessary fixes have already been applied.
>>
>> Changes in v10:
>> - Drop call to exit-boot-services
>>
>> Changes in v9:
>> - Update license
>> - Fix 'sevices' typo
>> - Move the function into efi_helper.c
>> - Split out into a separate change
>> - Split out into its own patch
>> - Separate into separate patches
>> - Add new patch to drop sandbox PXE architecture
>> - Mark the image as complete after writing it
>> - Fix 'sevices' typo
>>
>> Changes in v8:
>> - Add new patch to control on-host behaviour
>> - Add new patch to move default filename to a function
>> - Add new patch to report host default-filename in native mode
>> - Add new patch to report host default-filename in native mode
>>
>> Changes in v7:
>> - Update commit message
>> - Drop patches already applied
>> - Drop patch 'Disable ANSI output for tests'
>> - Rebase on -master
>>
>> Changes in v6:
>> - Drop the patch to disable sandbox virtio blk with EFI
>> - Add new patch to disable the sandbox virtio blk device
>> - Deal with sandbox CONFIG_LOGF_FUNC
>> - Rebase on -next
>> - Drop patches previously applied
>> - Drop mention of helloworld since it is no-longer used by this test
>>
>> Changes in v4:
>> - Add efi_loader tag to some patches
>> - Split out non-EFI patches into a different series
>>
>> Changes in v2:
>> - Add many new patches to resolve all the outstanding test issues
>>
>> Simon Glass (11):
>>    test: boot: Update bootflow_iter() for console checking
>>    efi_loader: Add a test app
>>    sandbox: Add a -N flag to control on-host behaviour
>>    efi: Move default filename to a function
>>    efi_loader: Move get_efi_pxe_arch() to efi_helper
>>    efi_loader: Allow reporting the host defaults
>>    sandbox: Report host default-filename in native mode
>>    efi_loader: Drop sandbox PXE architecture
>>    sandbox: virtio: Disable the sandbox virtio blk device
>>    test: efi: boot: Set up an image suitable for EFI testing
>>    test: efi: boot: Add a test for the efi bootmeth
>>
>>   arch/Kconfig                        |   3 +-
>>   arch/sandbox/cpu/start.c            |  10 ++++
>>   arch/sandbox/dts/test.dts           |   2 +-
>>   arch/sandbox/include/asm/state.h    |   1 +
>>   boot/bootmeth_efi.c                 |  29 ++----------
>>   cmd/efidebug.c                      |  25 ++++++++++
>>   include/efi.h                       |  34 +++++++++++++
>>   include/efi_default_filename.h      |  56 ----------------------
>>   lib/efi_loader/Kconfig              |  10 ++++
>>   lib/efi_loader/Makefile             |   1 +
>>   lib/efi_loader/efi_bootmgr.c        |  10 ++--
>>   lib/efi_loader/efi_helper.c         |  71 +++++++++++++++++++++++++++=
+
>>   lib/efi_loader/testapp.c            |  64 +++++++++++++++++++++++++
>>   test/boot/bootdev.c                 |  18 ++++++-
>>   test/boot/bootflow.c                |  67 ++++++++++++++++++++++++--
>>   test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 4924 bytes
>>   test/py/tests/test_ut.py            |  53 ++++++++++++++++++---
>>   17 files changed, 356 insertions(+), 98 deletions(-)
>>   delete mode 100644 include/efi_default_filename.h
>>   create mode 100644 lib/efi_loader/testapp.c
>>   create mode 100644 test/py/tests/bootstd/flash1.img.xz
>
> I hope this series can meet with approval and go in. I know it isn't
> perfect, but we can then work on things from there. The first thing is
> to drop the various .xz files, which I'll look at once this lands.
>
> Regards,
> Simon

I tried to apply the series. But it fails in the CI.

https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/941546

Best regards

Heinrich


