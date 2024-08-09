Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EE5C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 19:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4634988521;
	Fri,  9 Aug 2024 21:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="OtjzimkZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B2B28863B; Fri,  9 Aug 2024 21:02:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2881A884A9
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 21:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723230124; x=1723834924; i=xypron.glpk@gmx.de;
 bh=GCnES4SY4S9Snavx3OVzlhqC8UTAFDKdcDmcQC1ZxnA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=OtjzimkZkhU4+W7GYLq3glc+K97DOQqDTKtHC/EspWOPvpAJH8YA3HAo3JNzAKKQ
 dcK1zm94RcEWI8wEuhXKREvYv9+RU4UxtRmipM+YvjLlrWPtEJj7kzbX0nFNGkMYJ
 ztYR7y0HomLAJXUw2UYxvBjo5NXggmqBQkSdDCLNbozNtqpSf7gEAchjnVD3KOzFy
 szh7Mofp3mzGMQI/p+710eh16MWhDVr56V9TZ/mU+RqmJV6AFcm0iV7VcnTOtCmVB
 b2kbHwp9XlKZCEyGY7PZjo+6z3IrC42xifBpB/b4KTz/JCOadoCY6YHFkmd/9ZS3u
 gNSO0FTbTwYyTf5S6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.41.98]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1sCgVu07qw-0117SK; Fri, 09
 Aug 2024 21:02:04 +0200
Date: Fri, 09 Aug 2024 21:02:01 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/3] efi: Show the location of the bounce buffer
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTgmRMCK9E==O-sz51ONfaGENnoStXPY4LL5HS0F-=cDfA@mail.gmail.com>
References: <20240801173637.1071068-1-sjg@chromium.org>
 <20240801173637.1071068-4-sjg@chromium.org>
 <4594d522-bb63-45ee-b660-0130ae55d341@gmx.de>
 <CAFLszTgmRMCK9E==O-sz51ONfaGENnoStXPY4LL5HS0F-=cDfA@mail.gmail.com>
Message-ID: <5EA6AA2B-533E-424D-B2E9-13A4CA8C2E9A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:29l96b4sPPcxjh6rvucTf26DUGunCc1Q+V9Yo6wsZEpwlac79Rh
 K+dCwHH0Zq0VOZf87OscAU79JHI5Wj1U1aGDt1Lm3iThqt+MqF7vx5ICad66EOtaNpZh6+B
 PPET9itHgKWmyVfKcJTxf070XYugfQ9am6pYxH00ZmfibgGwQfNOXawt6cWelWKDYkovEms
 kypP9rt9KBxqaO0iLbEpw==
UI-OutboundReport: notjunk:1;M01:P0:G5BTLsCFLts=;BUd/KQqFadOzoG3Pznsz8INWt2h
 gdaOjz+JkMqY6u4rs3t6Whsups29efCZadF7biFYuGePhX1kqHKVOBKyod07dNkj7PUm6UQMe
 tMZvy0nWYi9fjbKlcrwfBZSxUCOZ3C7Cky7lGkqCJjcErj/91fE/BVTvFQSa9NoTt5EfkhFGt
 iU5g7vQrQ850qJb4xZmPuVUtjPC9YAZoK5Dir+RyVPgD7kAsWzduiD/58Y5PMpYF7MGdtyT11
 yZykt5ckofRMEEtUyFKLh/UOzba0qh4PLTv23/Arzl/Zy+e5pqrd3jHMrvI3aMzTA28EdA54Z
 IXLFmMooooTRkBq3iKyPCWTurZacrRTCIq71Uyo1NeB9mA0VjMaVYaJRH0H0K28GNa+DkfHd6
 bKW+Ht5hNh2FJwNherFbSYo3UMOIctsIVGEK+mwCQTnMoaSK4+Nyr56I7AijA1NHR+DTzN6nU
 3UCxDTiRcEdjMKKSoVeAIWLsZz85hpKER7MhXIUw1K5+o0VaIEjIPIRcCNt5kpgOMm9vWNayh
 uEHjXobnU3Y6NV6PyVr7Q0jkT9My303SYdsiplMcR67ES8YLVI09A4c66o8TZ67cH72NhSw+D
 dNLIPtTjwYJslzp6YaPgBiPN+dqZp4jKNzJjiMQ6Gp8hkmvR3jGc+AY6N5T2ntNYFrSqfhV5l
 /ifvpWOMNbJ7USLrv7P1mTd9txthHnhsckMo+Vio+B6sC/nkCsZDUHT5HdobjninBeHDYaZTf
 2rcjin5YzrFgzE5+z1XwXxgWqjbA7Gxm4kRronu+P5uZXgL3O2eGzUgg9zOrwv5Pa/nw+hCLT
 k4MYT5VIhKHf+8rfrlZnAerA==
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



Am 9=2E August 2024 20:36:35 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>=
:
>Hi Heinrich,
>
>On Fri, 9 Aug 2024 at 11:32, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>=
 wrote:
>>
>> On 01=2E08=2E24 19:36, Simon Glass wrote:
>> > The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago=2E It i=
s not
>> > clear whether it is still needed, but 24 boards (lx2160ardb_tfa_stmm,
>> > lx2162aqds_tfa_SECURE_BOOT and the like) use it=2E
>> >
>> > This feature uses EFI page allocation to create a 64MB buffer 'in spa=
ce'
>> > without any knowledge of where boards intend to load their images=2E =
This
>> > may result in image corruption or other problems=2E
>> >
>> > For example, if the feature is enabled on qemu_arm64 it puts the EFI
>> > bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
>> > 1088MB=2E The kernel is probably smaller than 27MB but the buffer doe=
s
>> > overlap the ramdisk=2E
>> >
>> > The solution is probably to use BOUNCE_BUFFER instead, with the EFI
>> > version being dropped=2E For now, show the address of the EFI bounce
>> > buffer so people have a better chance to detect the problem=2E
>> >
>> > Note: I avoided converting this #ifdef to use IS_ENABLED() since I ho=
pe
>> > that the feature may be removed=2E
>>
>> EFI_BLOCK_IO_PROTOCOL=2EReadBlocks() and
>> EFI_BLOCK_IO_PROTOCOL=2EWriteBlocks() are expected to block until all
>> bytes are transferred=2E
>>
>> The complete file transfer is chunked according to the size of the EFI
>> bounce buffer=2E
>>
>> Taking care of alignment issues would best handled by the block uclass=
=2E
>>
>> When CONFIG_BOUNCE_BUFFER=3Dy, bounce_buffer_start_extalign() uses
>> memalign() which limits the bounce buffer to available malloc() memory
>> (typically < 2 MiB)=2E
>>
>> I cannot see how blk_read() with CONFIG_BOUNCE_BUFFER=3Dy will work if
>> blkcnt * desc->blksz is greater than the available malloc memory=2E
>
>Yes, it uses malloc()=2E The maximum read length on MMC, for example,
>seems to default to 32MB, although it is only 128KB on a few
>platforms=2E
>
>I am thinking we should be allocating space in the bloblist to hold
>all these sorts of things=2E=2E=2Eit can be as large as needed and we can
>allocate space for it during relocation=2E
>
>>
>> Shouldn't the block uclass support chunking?
>
>It only supports readling whole blocks, if that is what you mean=2E Are
>you suggesting changing the blk API, or something else?

It supports reading multiple blocks=2E If not all blocks fit into the memo=
ry that can be assigned via memalgn, the block layer coud separate the bloc=
ks into chunks=2E This would replace the EFI bounce buffer=2E




>
>Regards,
>Simon
>
>
>
>>
>> Best regards
>>
>> Heinrich
>>
>> >
>> > Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> > ---
>> >
>> > Changes in v2:
>> > - Drop patch 'Show more information in efi index'
>> > - Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
>> > - Add the word 'warning', use log_warning() and show the end address
>> > - Reorder patches a little
>> >
>> >   lib/efi_loader/efi_bootbin=2Ec | 9 +++++++++
>> >   1 file changed, 9 insertions(+)
>> >
>> > diff --git a/lib/efi_loader/efi_bootbin=2Ec b/lib/efi_loader/efi_boot=
bin=2Ec
>> > index 5bb0fdcf75d=2E=2E9779dc09b5e 100644
>> > --- a/lib/efi_loader/efi_bootbin=2Ec
>> > +++ b/lib/efi_loader/efi_bootbin=2Ec
>> > @@ -211,6 +211,15 @@ efi_status_t efi_binary_run(void *image, size_t =
size, void *fdt)
>> >               return -1;
>> >       }
>> >
>> > +#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
>> > +     /*
>> > +      * Add a warning about this buffer, since it may conflict with =
other
>> > +      * things
>> > +      */
>> > +     log_warning("Warning: EFI bounce buffer %p-%p\n", efi_bounce_bu=
ffer,
>> > +                 efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
>> > +#endif
>> > +
>> >       ret =3D efi_install_fdt(fdt);
>> >       if (ret !=3D EFI_SUCCESS)
>> >               return ret;
>>
