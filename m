Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C245BC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 19:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4336686D3C;
	Sun, 12 Nov 2023 20:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DV4hLJVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8172786D3F; Sun, 12 Nov 2023 20:20:02 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DFE786BD6
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 20:20:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699816798; x=1700421598; i=xypron.glpk@gmx.de;
 bh=TmgUugyMokAx4gkQTowTjVnbb5c74GHjGgjSzq4E/WY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=DV4hLJVmqMJbaHavAMC+B2OaOwYYP0rFBvxsFewSA/CiBRD52jIfN6kcJ00ZdXqS
 De+Mg7rjSrdHoqAR003V6OzwENxcXx1h3NH6BwczpjIB+g5yoSNAvsqJc7g7kVJ2B
 2Ftb3mRI7SyoUebuLLJdBl5MzjD3WwTZ8N3tNLf061hYw5XeLsefVJD1rICZzJoN6
 7cpTZBGqFJ+Sf9OAjjLoxJKjrzoaJCs2CIUV2FbgZUhArxT9WFm2C7p1MSr5MTO6s
 DkeeQLc8rtqNm/FwlNodsUpl5uOZcGSM3S6GNzb2k6WFXpgbrE9zIA6cS2I9EDC40
 5S/aB0yVasnev4yRqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1rLQyX27FP-00swgG; Sun, 12
 Nov 2023 20:19:58 +0100
Date: Sun, 12 Nov 2023 20:19:57 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 4/4] efi: Avoid using dm_scan_other()
User-Agent: K-9 Mail for Android
In-Reply-To: <20231112180357.GD6601@bill-the-cat>
References: <20231112155808.135585-1-sjg@chromium.org>
 <20231112155808.135585-5-sjg@chromium.org>
 <20231112180357.GD6601@bill-the-cat>
Message-ID: <C8077CF5-6258-4699-9204-BB9B23F391A8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YHsE3xoGGQcdmJ7edAyqZ2yH8EoZSAFmQZv0kUjybrfoGNBEhFV
 wYj9s/ApWjW2r76F1sYaaqSnnME6RnIklugqxExUWtjyh3C6NS56Z1TmQ/oUKuyOX30ZFA2
 G2a1zOFJxPmR96gA5UyUUNuK6OajpyvOQ4Wxlec+igIx2krsUKnw9Wi4KGhmYBNxIi9+iv5
 cZlGP29qjFYRStyTWKzhg==
UI-OutboundReport: notjunk:1;M01:P0:S54+UbUS+pg=;H6eQF2M7ulCO0h+U0e+UAqC9UuK
 R/b0/64JLzPk+lJH3JQEUCsfIX6Ntfwqx8iINcm2l/tp3kvA6mVNnDYrtMHOTOKUANM/JO3ys
 m5WbbFm9mgKPqyrL8Gq5tk0CH6boUHjJ/jHEPsR6zhUkF5Dx1tWJ13iadGdJh9q63oWOQex1q
 zJ3wqasos8tmIz+TQh0nF+j1Vr5Wnr6ROXa70s8mjJn3kfavinmF1cA+NDNsdYgp9zJ64Jz1M
 yfiqZSwbWqSSGrjUTRwE5tJvTViz9UliQSxpeZnK2hFkEjb+jxxIaE17DbSamOtVq0K2G/XzW
 0r4W0OtHsVwwoZpbW8deSZ/uNNTsncqGDYkUyLW6YMLfgoc8eKnz6Lpd6Jh7nRtS8zZoCyBVd
 xeQTLmFl8bak/TcyJfjTXb3FgE6+cxzqjYxrdT3W6+zXApKSqfIHYf8U/wpEY1hj4KhNyAfuL
 66+iiZUs/5QCyZ65NhMyTQA2yO8ZllJXrX+KFvA/ZbFQRQPkPiVDRjpG8lHiY0yGeCX2Mbk9+
 WVe1dtGoeYQD5Dn6qd9Pq9n8uJmL4F07xq8cWAFZ1RH/LJnk/HcuhMDbQ1O75MvFEd4UETwrn
 au67zjjI6PY3qS2lExIt9VQAMc7pQudaOnPMhj6graoA85BNzQvTuu4Gfb2uKmZpu1yk5yMaZ
 o02N5zSb61CGtnMfSF2EEkjpj6lL4fn9JqommnwYm1kYJNWMEc4MknbwCW4x8DsomXf0rHqX3
 ooRA4ayeK5ZVWaMj7e1UmUnXvyresCTqkBGfDa6rmH3b7hZAGoN9wKVEPBycRfd+I2O930zbG
 hPs4SrUc3G60fk5BtZYUv2ImrWa+wTXE87yTYU91WCGs3z9ZdGXWbUsNmVowCtaIvmRBieNjF
 mTc+aojimM1zW76LAny5XMUgOtTm7BnVNHbLiDQH7u4byfxWHs6PaRSK14q25khzN/GwwICJL
 1EGf1aTkcTqHEv1+nET2v5AeKNA=
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



Am 12=2E November 2023 19:03:57 MEZ schrieb Tom Rini <trini@konsulko=2Ecom=
>:
>On Sun, Nov 12, 2023 at 08:58:05AM -0700, Simon Glass wrote:
>> This function is defined by bootstd so using it precludes using that
>> feature=2E Use the board_early_init_r() feature instead=2E
>>=20
>> Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> ---
>>=20
>>  configs/efi-x86_app64_defconfig | 1 +
>>  lib/efi/efi_app=2Ec               | 5 ++---
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_de=
fconfig
>> index d6b6c3d82995=2E=2Ee6a62b30dd09 100644
>> --- a/configs/efi-x86_app64_defconfig
>> +++ b/configs/efi-x86_app64_defconfig
>> @@ -17,6 +17,7 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>>  CONFIG_BOOTCOMMAND=3D"ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot =
01000000"
>>  CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>> +CONFIG_BOARD_EARLY_INIT_R=3Dy
>>  CONFIG_HUSH_PARSER=3Dy
>>  CONFIG_SYS_PBSIZE=3D532
>>  CONFIG_CMD_BOOTZ=3Dy
>> diff --git a/lib/efi/efi_app=2Ec b/lib/efi/efi_app=2Ec
>> index c5eb816655ea=2E=2E1bced775a4d0 100644
>> --- a/lib/efi/efi_app=2Ec
>> +++ b/lib/efi/efi_app=2Ec
>> @@ -302,15 +302,14 @@ static int setup_block(void)
>>  }
>> =20
>>  /**
>> - * dm_scan_other() - Scan for UEFI devices that should be available to=
 U-Boot
>> + * board_early_init_r() - Scan for UEFI devices that should be availab=
le
>>   *
>>   * This sets up block devices within U-Boot for those found in UEFI=2E=
 With this,
>>   * U-Boot can access those devices
>>   *
>> - * @pre_reloc_only: true to only bind pre-relocation devices (ignored)
>>   * Returns: 0 on success, -ve on error
>>   */
>> -int dm_scan_other(bool pre_reloc_only)
>> +int board_early_init_r(void)
>>  {
>>  	if (gd->flags & GD_FLG_RELOC) {
>>  		int ret;
>
>Should this file really be board/efi/efi-x86_app/something=2Ec ? We don't

The EFI app should not be x86 specific=2E

Best regards

Heinrich


>define this function outside of the board directory today=2E Or should we
>just move the function as the rest of the code is used in other EFI
>applications we build (or no, the hello world one is too simple to need
>this) ? If all of that sounds too wrong-direction, can we use event
>lists or something?
>
