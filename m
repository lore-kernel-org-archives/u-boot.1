Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E96DC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 16:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24873878B8;
	Sun, 31 Dec 2023 17:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HOhpzqcK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7446B878BA; Sun, 31 Dec 2023 17:02:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 184B487883
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 17:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704038524; x=1704643324; i=xypron.glpk@gmx.de;
 bh=sFlWTiDqs+LBJAk2wxyeVwCD2dkybCSsupKkMy9qGR4=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
 In-Reply-To;
 b=HOhpzqcKs7d6M5UA/gkcgm/yvPGDEU/pGYN4fe4py13zMed2dMC7xTPIDQmMf0DW
 iOZsltDqV5Mgl5QgEAjOBGkOUVRkmj4BhjH9Gfvt3m21017/19BoaFtXEOC6jFOmE
 vE9w/a9HcFGKjF4rGQvlbKTgNQRcZP4GNgSgHRzTZZDxTrFfA82Of4JZMZ1oonsRX
 wAc+BhiAwQgJjNQdzZXC1/rVXoFTTqTm6gnv7ctbeU55s7coNW6D2wT0QWdHlkw2C
 tyPz2HruNMRSMOGsqyAhrlNEtZieklgiW45tlFhe8KMqq0I9Y2v4MtVwtW4YI2li3
 HFINoWl0pK1aJCf4mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1rRyjL1TWJ-00HRQW; Sun, 31
 Dec 2023 17:02:04 +0100
Message-ID: <54057bef-4466-43cb-a832-4b904f03b559@gmx.de>
Date: Sun, 31 Dec 2023 17:01:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/12] smbios: Deal with tables beyond 4GB
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
References: <20231231152555.464874-1-sjg@chromium.org>
 <4683F3D9-7D61-4D26-B1F2-3DB07D009AE1@gmx.de>
Content-Language: en-US
In-Reply-To: <4683F3D9-7D61-4D26-B1F2-3DB07D009AE1@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JP/W+4AEy+WNrEGMu5qnqOxYnyhe0HKXyoUO63V7yQKarjYPmuW
 +5cDD3ebe7J7KkZVPR/3T/oWuX9iDS+4eCzpErVNXGOLuVE7WKxGpEkVNAQ9YSBuOhgHj/9
 HiGhOzDN1Ncq4LYqomiVlfZADO1FQnFBcaqcac5AxIYOeMaIW4IPpbuKghtetsDAAqkbomk
 8V0K8mE89bnND+TOGJGnw==
UI-OutboundReport: notjunk:1;M01:P0:ywzSLTijCnA=;IH7RCL9x6XFVYFQo3ntkxu/EhFq
 4SYt/paccd8fux8vlf4cWGNXa78yKTPHSJmaNpqB4XaiWZRFrfNDXo+NBrVLNgY4r1xJByCnD
 yGGkjQfA8hoU6je2G08B7SzCmhQe04sUmkKbCJlVFYjbkfgPEfs3uxZ6sOtIVSm47evMcghG+
 dRsgy/avvTLM1cslsDjiNwjZlcCH4abqQnUAG6X32c1vQ1OU27COIrOBVQXez/KMm6gHP6YQi
 cdKse9CcBsrb6kZWN1nmunnPYXAzREW5rVAImNdDbZrmC59YIUXmGY2gkjg+AenlhL1/j47yI
 2PEcD7tRfYFF4mu8Ibg8+XgIvUhgfdS+LT9LSlSPuzjahHfGhpZZ2cv9/ahWxY+2HreQFGQ+I
 2/EHrdzXXJ5XaoF6Kl0Hd4wsfiKU6oNQvkE0oZJzUxD8wWkYIsPbjs0IptbrUCvn84N1jrAGL
 YyOpxOvtdPlRCl7g2IgmKy/aF9rpMCkORyPK4HYvBPKFSlrwyVQrjgx9ST3Hj45JyNUXYTisQ
 WKO93LqqP20UYoneoasQzrECmiWzi5TC9Rvo0H5wTXcyN3yIvwq3TAutsozFJkKEToSAgmcxK
 2p2VZaeIny/FwsUE01onj+/mBhB2ClLGY7hPPNBPtwziTY9GHtPpBOw9l+0HXEe+cvLorj/Uv
 uM5/rQm5mfgS41g3WBB5fx1AVb+iBmTi8gg06E/OmxUnYK9npr51sOL5x/E7GB+uwzldPybZA
 h9sNgDvyHsrhOME2bjXeL7LJ5mi5qCEWHRYAHASTg13MRrpRVhBL+aDSHCXFQIM5MR+2pqo7W
 XAClqizEutcEVB7UhvRmWoi7ujf5sYdDqnjQMZgoo94wjN3whNPsy46ZErcgb2u/tAmi/kIK1
 v0xzyxQIClnt7n6jQMLUmiYUIINta2smyVTS9fH4wqegbeby12xzpDYpGCVPl2fMaLGgxKl2u
 UFbK2zCB69ZgIjoRScunJnoXZfA=
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

On 12/31/23 16:56, Heinrich Schuchardt wrote:
>
>
> Am 31. Dezember 2023 16:25:43 MEZ schrieb Simon Glass <sjg@chromium.org>=
:
>> When the malloc() region extends beyond 4GB on ARM we may end up with
>> an SMBIOS table in that region.
>>
>> Add support for writing an SMBIOS3 table, which supports a 64-bit
>> address.
>>
>> Note that this problem does not happen on x86 since it requires the
>> tables to be placed just below 1MB in memory, unless
>> CONFIG_BLOBLIST_TABLES is enabled.
>
> The ACPI specification only requires that a low memory RSDP exists on no=
n-UEFI x86 systems.
>
> Nothing stops us from copying the RSDP only to low memory when not booti=
ng via EFI. Maybe that way we could have more common code. But this is bey=
ond the scope of this series.
>

Same is true for the SMBIOS anchor. You could have all tables in high
memory and only copy the anchor to low memory when booting non-UEFI x86.

Best regards

Heinrich

>
>>
>> v5 drops support for SMBIOS2 tables as well. It also adds some changes
>> to memory mapping which should allow an EFI app (launched from sandbox)
>> to read the ACPI tables correctly.
>>
>> Changes in v5:
>> - Update comment to mention x86 alignment
>> - Add new patch to drop support for SMBIOS2 tables
>> - Add new patch to drop support for SMBIOS2 tables with EFI
>> - Add new patch to rename test dm_test_setup_ctx_and_base_tables()
>> - Add new patch to write pointers to tables instead of addresses
>> - Add new patch to correct smbios-table installation
>>
>> Changes in v4:
>> - Bring in this patch from Heinrich's series
>> - Check the start of the table rather than the end
>>
>> Changes in v2:
>> - Check the end of the table rather than the start.
>> - Add a new patch to correct gd_smbios_start()
>> - Add a note about why unmap_system() is called
>>
>> Heinrich Schuchardt (1):
>>   smbios: SMBIOS 3.0 (64-bit) Entry Point structure
>>
>> Simon Glass (11):
>>   smbios: Refactor 32-bit code into an else statement
>>   smbios: Move the rest of the SMBIOS2 code
>>   smbios: Use SMBIOS 3.0 to support an address above 4GB
>>   smbios: Correct gd_smbios_start()
>>   efi: Use the correct GUID for the SMBIOS table
>>   smbios: Require the caller to align the SMBIOS table
>>   smbios: Drop support for SMBIOS2 tables
>>   efi: smbios: Drop support for SMBIOS2 tables
>>   acpi: Rename test dm_test_setup_ctx_and_base_tables()
>>   acpi: Write pointers to tables instead of addresses
>>   efi: Correct smbios-table installation
>>
>> arch/sandbox/include/asm/io.h     | 16 +++++++++
>> arch/x86/lib/acpi_table.c         |  6 ++--
>> cmd/acpi.c                        | 12 +++----
>> include/asm-generic/global_data.h |  2 +-
>> include/efi_api.h                 |  4 +++
>> include/mapmem.h                  | 18 ++++++++++
>> include/smbios.h                  | 41 ++++++++++++++++++++---
>> lib/acpi/acpi.c                   | 12 +++----
>> lib/acpi/acpi_table.c             |  4 +--
>> lib/acpi/base.c                   |  4 +--
>> lib/efi_loader/efi_smbios.c       | 28 +++++++++-------
>> lib/smbios.c                      | 55 ++++++++++---------------------
>> test/dm/acpi.c                    | 14 ++++----
>> 13 files changed, 134 insertions(+), 82 deletions(-)
>>

