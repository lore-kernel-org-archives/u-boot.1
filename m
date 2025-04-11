Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F824C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB8668411C;
	Fri, 11 Apr 2025 17:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="roTDrz6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B492C8413A; Fri, 11 Apr 2025 17:03:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CC6F84107
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744383796; x=1744988596; i=xypron.glpk@gmx.de;
 bh=RJTsrw81clCaOz/Squ4n5syzdGWUAJncZHvaIAzM4GA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=roTDrz6p2NrrO+MSPH0TKDwTxjqTAdZr1FwahMnOpEBkjhED6J8jOw6P+i34pGqj
 yutF8hrhmgUkc8EbzXmUBQh6Sse0w2Ks1v2+3o6AHwshGtrjeDZgeQkU43fsvPcM/
 1xbJekJsDvlRwFYbiA4KpbmgpNpGZpa7v4dg0QVBMykle3tGblOsbSyeUsZzUyPol
 CWyARr/MmHtfq+xjqkkk4QZDHlLYQDXVOYPS2OccKxFePBRy0X1Gb60kIgozeBTHq
 mGIMho6lkEG0dJmjomVnso+xTkzTFeSW5VDa+uDCEf/X+SYM41V4AMNfJl3Xv2MxP
 xCdNB97QyPtstfnMzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVNB1-1teG8J0vAN-00SUs2; Fri, 11
 Apr 2025 17:03:16 +0200
Message-ID: <74336103-ff09-4384-8528-8895c73b1742@gmx.de>
Date: Fri, 11 Apr 2025 17:03:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: efi_loader: Ensure the SMBIOS tables are sent via EFI
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Niklas Sombert <niklas.sombert@uni-duesseldorf.de>,
 Bin Meng <bmeng.cn@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250405204409.420738-1-sjg@chromium.org>
 <CAC_iWjJ07Z4PqZa9mXSnzp5TjsgXr3RL6FxSL2EV0oX7p8uN_g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjJ07Z4PqZa9mXSnzp5TjsgXr3RL6FxSL2EV0oX7p8uN_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TKqUHQLWIK7kjhqBix7pvdx/8DgL7w7GkqXl7DIvBna3AZElPmo
 W5D9sBOu7867bQmJxh5mAgRI2d1TsXhhdcuBr0/bNrBv6RsGzukpVn1berVn//0foFJnQ+h
 zxy07k97hfWK983eKoOBtSnwjd6cS/MSXd9PDbbq7MEtAfFEGcFBie1hO+Dgmot3USVAXFD
 pGyvZeDp13vnfVdbdzi5w==
UI-OutboundReport: notjunk:1;M01:P0:qBiiTCzPnEc=;w1i6HHCTuDS9vlHpJDeiuI8eAGF
 +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
 g==
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

On 11.04.25 12:04, Ilias Apalodimas wrote:
> Hi Simon
>
> On Sat, 5 Apr 2025 at 23:46, Simon Glass <sjg@chromium.org> wrote:
>>
>> The EFI-loader code has not been fully converted to use bloblist, so
>> relies on the SMBIOS-table address being set in global_data.
>
> Can you explain a bit more what this means? The SMBIOS tables for EFI
> are supposed to be on EFI allocated memory
>
>>
>> Set this up in write_tables() so that the SMBIOS tables are actually
>> available.
>>
>> Enable the command for x86 QEMU so that the SMBIOS tests actually run.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Fixes: 83ce35d6ebb ("emulation: Use bloblist to hold tables")
>> Reported-by: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
>> ---
>>
>>   arch/x86/lib/tables.c            | 2 ++
>>   board/emulation/qemu-x86/Kconfig | 1 +
>>   lib/efi_loader/efi_smbios.c      | 1 +
>>   3 files changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
>> index ec52992209f..d7f183f95dc 100644
>> --- a/arch/x86/lib/tables.c
>> +++ b/arch/x86/lib/tables.c
>> @@ -126,6 +126,8 @@ int write_tables(void)
>>                          use_high =3D true;
>>                          if (!gd->arch.table_start_high)
>>                                  gd->arch.table_start_high =3D rom_addr=
;
>> +                       if (table->tag =3D=3D BLOBLISTT_SMBIOS_TABLES)
>> +                               gd_set_smbios_start(rom_addr);
>>                  }
>>                  rom_table_end =3D table->write(rom_addr);
>>                  if (!rom_table_end) {
>> diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x8=
6/Kconfig
>> index b2a4e0891a4..c1564fba7cd 100644
>> --- a/board/emulation/qemu-x86/Kconfig
>> +++ b/board/emulation/qemu-x86/Kconfig
>> @@ -23,5 +23,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>>          imply VIRTIO_PCI
>>          imply VIRTIO_NET
>>          imply VIRTIO_BLK
>> +       imply CMD_SMBIOS
>>
>>   endif
>> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
>> index 8d2ef6deb51..5275e966dfe 100644
>> --- a/lib/efi_loader/efi_smbios.c
>> +++ b/lib/efi_loader/efi_smbios.c
>> @@ -35,6 +35,7 @@ efi_status_t efi_smbios_register(void)
>>          void *buf;
>>
>>          addr =3D gd_smbios_start();
>> +       printf("register %lx\n", addr);

User will not know what "register" relates to.

log_debug() with a meaningful message in the else branch of the if
statement below would be acceptable.

Best regards

Heinrich

>
> I don't think this print is useful at all, why isn't the log_err()
> right below enough?
>
>>          if (!addr) {
>>                  log_err("No SMBIOS tables to install\n");
>>                  return EFI_NOT_FOUND;
>> --
>> 2.43.0
>>
>
> Thanks
> /Ilias

