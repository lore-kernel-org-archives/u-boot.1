Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8E2C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 10:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F422876AE;
	Sun, 17 Dec 2023 11:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cy6Ck6yb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 129E587705; Sun, 17 Dec 2023 11:26:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2AA6874CA
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 11:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702808800; x=1703413600; i=xypron.glpk@gmx.de;
 bh=leCF2ZM/NpCV/Llebj3a0c02Q0EC4gNnzLmSF06pJ3M=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=cy6Ck6ybqc3sKw+62r7Hc0Pit2H/oRlJJKucuHD369BYxzqiLbdn3YsD45zsh+Tu
 w4c5XIAzB5sqzKvN+anfy+SRlTJAhW4AQXo+NuBOl6fYM+18oE5D1ru2vLMSdJ+CO
 AZF0ggvXo6HRcYjjABh1Ixpf3lvSFhPLZOxgSsusfs18zNCSeu8evRtnJB8YBfcQh
 BBqmBF3N6C0K3LeuzsSr5dOXVCp4jpwm94Wtfc/bdeE9NajMA8YuFHZY9DtDU9ZlZ
 xqfdrLnlg1D2S1p0cRGZ0pPVJelwyMM5R7vPuA+zoGW86X11HfJCXyWB1bISvbor5
 g1f9tTJFUZss7UBzmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTqg-1qiLMk0xR0-00WWtZ; Sun, 17
 Dec 2023 11:26:40 +0100
Message-ID: <e1485c74-9481-4dd6-a405-672173afdd7a@gmx.de>
Date: Sun, 17 Dec 2023 11:26:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: eliminate efi_disk_obj structure
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20231213085737.299773-1-masahisa.kojima@linaro.org>
 <dcc6a681-2ede-49ba-ad0d-069933ad32ca@gmx.de>
 <CADQ0-X9cBm4uVyMXNVL++exgoHkgB3RGAH=cPjtPO5JKh+CgHA@mail.gmail.com>
 <DE130DBC-CB76-4F6C-966E-1B3FDC63C0B0@gmx.de>
 <CADQ0-X-PEOJqgA7emrHWBvFiEESfToLtmVk=57D_NrCskXdAWw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CADQ0-X-PEOJqgA7emrHWBvFiEESfToLtmVk=57D_NrCskXdAWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RMEDoj/6Hm3Vo9/hZNP8thEhi8pc+8gldoWKTUGQGnks0h4bl/G
 y334xDs0XnLIqps2yQCevnz02WqkHrNBHyzlvLauu30e2QR4V4h2U8fhQvxHFYT0sw4pTdP
 BajatXhSf61zdHCPfIZ4hj8C/6UIeygl/mnWMBG5J+JrEDhkNTYBzdAz1NRTL0GJkv68L2Q
 JidDCehpG6XXiGSW1Vg1w==
UI-OutboundReport: notjunk:1;M01:P0:b9tfBsICvhs=;wq8Mb1BGWB1FNr+FAWnt9jqlcxF
 L1OF1AkhBRTLRrisl1zlLzIFXsRzJrSvyZZnyxhREZ07SU7Jc6z/DzXBVdOiQZpEFouGYQp89
 M083lcmmiAgnWN91TwmEBsHq70kqK6RFKiivvTQCACrfEkyDiXu56nQ6OV7b6IQ2mu2w5NYEL
 JtNMGtRKxcQiI4peR3auk7PVTvt+TtkffjBW1mpPEjAm9p1XKuS0lDM+6Q4xHQ0gB5TSc0BCa
 offXslQptx2Ve+0BJj3nTvT02IQ4IxfvlHXdQzy2dVPjxMpt+r38mM+Uo78bco9bMccQFepKi
 DKnJflqdleazrXiRBEZMfJFOiugjV15H9ZCZUpFCKx7s25cKNMuev8F6RL8BKDQp+oQybv74F
 xmYZbU0GUB9ZlB8xNATLWANVmW8JS5v1xdZEe+fO9saO7rYckFSMspNZu2xiXRcIA16fkE1O7
 OTHI5KkTg8J4vMwubi1qwutVJI+JEcqhCgaS5y3Hj/UWTxD+ftmCB+A/7C7PJePernyZxByFG
 JGyAy3c6C5M4BJfO9dsf2ThMLWOVFdSv7djs+j0AexNURueRXMGjZJZalbhpq+q1PaFIVUES1
 gGH2VwVStKh8iVu3trX51Gd+5o/SKb97tSjIefTXzQsHjfUj68HId0FefkQDqNMkCO8zadUCC
 2b5pnLttU53w9WeDwtNA/vfht6j5M5B9SRt9g5XS7E3yDGj79yIfLNaYkegC7Tejkg63ASsv9
 K60ocEOco/gP6JNhIP6YdoqT6NsbHceURJBS6KzJ/FQHf/9V5decJkMA6Na1/TbA0HeQpxImU
 PzbPXieY62aEes38Q3JDRSaRDcEKUB7EqkNCr0mahHJQsjpBJy4PlJP67cX4CeucC1UHooUIa
 q/MzcTU2ZlANls1UithqgH399gOF0EzSaYMl3CRxRK0Y9yqUkt/fU+6TLShxWkHigqXlR9zQy
 5LbS6AyrNTucPyR4dmAp/fhLQws=
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

On 12/14/23 09:23, Masahisa Kojima wrote:
>>>> Depending on the number of handles and pointers this will take a
>>>> considerable time. A private field for the handle appended to struct
>>>> efi_block_io would allow a fast lookup.
>>>>
>>>> EDK II does the same. See the definition of RAM_DISK_PRIVATE_FROM_BLK=
IO
>>>> which uses macro BASE_CR() to find the private fields.
>>> This patch tries to address this issue[0].
>>>
>>> If I understand correctly, two options are suggested here.
>>> 1) a private field for the handle appended to struct efi_block_io
>>> 2) keep the private struct something like current struct
>>> efi_disk_obj, same as EDK II does
>> Edk II uses 1) as I indicated above.
> Probably I misunderstand your suggestion, let me clarify again.
>
> EDK II RamDisk implementation defines the private structure
> RAM_DISK_PRIVATE_DATA[1].
> RAM_DISK_PRIVATE_FROM_BLKIO macro returns the pointer to the
> RAM_DISK_PRIVATE_DATA structure from the BLKIO protocol interface.
> EFI_BLOCK_IO_PROTOCOL does not have a private field.
>
> It is the same as the current U-Boot implementation of efi_disk.c using
> struct efi_disk_obj and following code.
>    diskobj =3D container_of(this, struct efi_disk_obj, ops);
>
> Do you suggest modifying struct efi_block_io to add private fields?

efi_block_io currently is what is defined in the UEFI specification.

We could define a new structure that includes efi_block_io and
additional private fields:

struct efi_block_io_plus_private {
	struct efi_block_io block_io;
	efi_handle_t handle;
}

Or we can change the definition of efi_block_io by adding private fields:

struct efi_block_io {
         u64 revision;
         struct efi_block_io_media *media;
...
         efi_status_t (EFIAPI *flush_blocks)(struct efi_block_io *this);
         # U-Boot private fields start here
	efi_handle_t handle;
};

In either case we must not try to access the private fields if the
structure is not allocated by us.

The second option will require less code changes.

I would try to avoid using container_of() for accessing private fields
as it static code analysis and reading the code more difficult.

Best regards

Heinrich

>
> [1]https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Universal/=
Disk/RamDiskDxe/RamDiskImpl.h#L95
>
> Thanks,
> Masahisa Kojima

