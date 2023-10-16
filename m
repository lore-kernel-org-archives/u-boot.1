Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC13CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8E8186B71;
	Mon, 16 Oct 2023 14:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hCdbYNcs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 415F186B71; Mon, 16 Oct 2023 14:46:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C50A88667B
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697460412; x=1698065212; i=xypron.glpk@gmx.de;
 bh=hpaCBxDp6vJBEVpp9ZwEHVHrxHL9Yh7LCFFc4r6I7n8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=hCdbYNcs1nxuKPpg64Jn7FfGEZj9sNhSdOcwMyZsjs6YLA3wnTORUjnBgR9xINCcdXzT9minCwY
 A/YNxwbf4U0PtYrkX+EaNqJAaqOtRt3HianyYL9+s8NQGbkoa1ya6wc8LAyt9JHlbvcL/6l+v7Qj8
 qD3HvMtTuzubfr416cCQmJptu4kQFf07GAFDE6KAPuWD3nFlXMo6eS2aNbIn/jLcrRrsLffc5KCQa
 4Ni29U2Rycw5/hS8nbFGQTquP6fs/vyTtEvCIxhLlpmt+Zckk3bxNqXVubZFBJAHitnf7wXj9Fomi
 PWiyjdGLJx0UHZtMhTjnFZ3avHiQrqHaWACw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1r8wTQ0zx6-00IlmE; Mon, 16
 Oct 2023 14:46:52 +0200
Message-ID: <ae12d900-fe7f-4f7b-9eb1-018aa719174f@gmx.de>
Date: Mon, 16 Oct 2023 14:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] efi_loader: create default file boot option
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Takahiro Akashi
 <takahiro.akashi@linaro.org>, Michal Simek <michal.simek@amd.com>
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-5-masahisa.kojima@linaro.org>
 <A2082A91-A1CC-43E8-B151-968D7746B906@gmx.de>
 <CAC_iWj+koNjVBR7TCJH_u_PvY5xDHgtBGRTHBRRgAx_aDeC8-A@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWj+koNjVBR7TCJH_u_PvY5xDHgtBGRTHBRRgAx_aDeC8-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XV4YdCakRoGNXzjaj7cOTYBMRUttEuWFGzT5jpskwmTlai9BCTf
 2DUP07v/ZXDfIjwEcSIRgxgYvFpGmEbFfNoAyoOzDTZeZp5+yUD8GyoLCPhBAaE4wAwFero
 NBJtNjgUVv9U66jsm2zCnH0TwijBx2+hbFqTP9MquKQl7paSz2rtUDLA2CI4CWgKbiBU9zs
 pVzbo3OLVHHbzimFvS7vg==
UI-OutboundReport: notjunk:1;M01:P0:7m36WBUt/N4=;DsGwfYeiFCJteQafQ4TJ+5xAURH
 6XX7u5uFMH/ntCSMjlCwBqm8Y93waqKGyXqQrcXexpMU1zRLJdN8QK1hyMAL21EAiusMLC1ZJ
 WhXGUGJRGIryVzAAU8MbVAKgDAD0Ipp6RTxKrZq17pTdJUj6Lx+Mig78diZOxPZ3jfTpQgznN
 fpEG7Qq66flh+p1AISSTWgFLSqgA+0pnD+J8KG9CzqkxsX9oI2aeoMzlbiPQe3Jcsgex/WKnx
 HN4s0nGruvkTnjoo+I/hsF+xw03kROKNcxtvnySjTxBM45YcZ/JmG2oj4uneuTWrAhfWOwbRg
 48zOoKe9KNlKGgQMDqa39opV110g5RVV8UmDeT/E2E3v7JdcSLQP67DMnoJW85mrngJAsJ4oN
 U8rhItKjq2z/Pjj7dzjrg2mtm5p/+fRiiiTux7YHDv3tzHxkO1LqRZOor3nlrnQR4ie5hzWWY
 Z1SptKiUeHC+03gsvBNc3bFX9w7p8e3lUUioO6AeZO+092r1LpLSRUTGCcGKvVy9okNaEA90k
 5AEAGy/chtrs6kQm5XtFAYu+72qbBT3fUcMfz8dljtIUpvZ206/Wn/oRNTKW6LYSR1VHAMjJ5
 lsvIRgl4DOTPwuqehl2aunngTZDFx1J2ZPlkg+knBjmMq1oakpRSRwMI6V3Cykkwi+RJz1jiu
 eJoVWU61gI8VzrLBkv8XzCgrLFtINY0gZE57JCYs4i/T5wjmUkbXXJtPO+C6+nPrt0dMg9Thq
 DjJh2nSZ/CU3RRAeba2+Me2A4vS4p4tnrZKmT/U6PPKgLac0tRfcYRBARdS/n4FbZEZ2mdTeJ
 +471Vfvyy3C3JSBD/ICVWn430CJb58g2AKJ+2OlVnPY+AE1DRH6RAcGHNazFN4krOtj4KnRed
 GW2NLdqgbnrcjSR08nC0nEwXTtNTN5kN1WpnHplcNE+JcmwV5Tf1FUFy/rFsMpVI2DdYjJTAZ
 SJbHr7+1cRZ3PXmDKc2Z97xkFuKsd5h4A9zjETNBnOqhUqRN4vSsKcpqEgJqxErTcgQzZQ==
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

On 16.10.23 14:31, Ilias Apalodimas wrote:
> Hi Heinrich,
>
> On Mon, 16 Oct 2023 at 10:06, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>>
>>
>> Am 16. Oktober 2023 08:45:21 MESZ schrieb Masahisa Kojima <masahisa.koj=
ima@linaro.org>:
>>> Current efibootmgr automatically creates the
>>> boot options of all disks and partitions installing
>>> EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
>>> Some of the automatically created boot options are
>>> useless if the disk and partition does not have
>>> the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
>>>
>>> This commit only creates the boot option if the disk and
>>> partition have the default file so that system can directly
>>> boot from it.
>>
>> I don't directly see the user benefit.
>
> The user can add an HTTP boot option now and the installer will
> automatically start.  That would allow products to ship with a single
> boot option provisioned and run an installer on first boot

This commit is not about HTTP. It changes how boot options for block
devices are created.

>
>>
>> Reading all file systems will increase the boot time. Shouldn't we avoi=
d this?
>
> Any idea what would be an alternative?  But when we added the
> automatic boot options we said we should avoid dynamic scanning and
> store results in a file.  This is doing a similar thing.  The only
> difference is that it mounts the iso image before adding the boot
> option.

The alternative is to keep showing boot options for block devices even
if there is no BOOTxxxx.EFI file.

>
>>
>> What does EDK II do?
>
> No Idea :)


On my workstation I get generated boot options

Boot0001* UEFI:CD/DVD Drive     BBS(129,,0x0)
Boot0003* UEFI:Removable Device BBS(130,,0x0)
Boot0004* UEFI:Network Device   BBS(131,,0x0)

without any media inserted and without any PXE server available.

Best regards

Heinrich

>
> Thanks
> /Ilias
>>
>> Does the UEFI specification warrant this change?
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>>> ---
>>> lib/efi_loader/efi_bootmgr.c | 86 ++++++++++++++++++++++++++----------
>>> 1 file changed, 63 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr=
.c
>>> index a40762c74c..c8cf1c5506 100644
>>> --- a/lib/efi_loader/efi_bootmgr.c
>>> +++ b/lib/efi_loader/efi_bootmgr.c
>>> @@ -355,40 +355,70 @@ error:
>>>   */
>>> static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig=
_media_boot_option *opt,
>>>                                                      efi_handle_t *vol=
ume_handles,
>>> -                                                    efi_status_t coun=
t)
>>> +                                                    efi_uintn_t *coun=
t)
>>> {
>>> -      u32 i;
>>> +      u32 i, num =3D 0;
>>>        struct efi_handler *handler;
>>>        efi_status_t ret =3D EFI_SUCCESS;
>>>
>>> -      for (i =3D 0; i < count; i++) {
>>> +      for (i =3D 0; i < *count; i++) {
>>>                u16 *p;
>>>                u16 dev_name[BOOTMENU_DEVICE_NAME_MAX];
>>>                char *optional_data;
>>>                struct efi_load_option lo;
>>>                char buf[BOOTMENU_DEVICE_NAME_MAX];
>>> -              struct efi_device_path *device_path;
>>> +              struct efi_device_path *device_path, *full_path, *dp, *=
fp;
>>>                struct efi_device_path *short_dp;
>>> +              struct efi_file_handle *root, *f;
>>> +              struct efi_simple_file_system_protocol *file_system;
>>> +              u16 *default_file_path =3D NULL;
>>>
>>> -              ret =3D efi_search_protocol(volume_handles[i], &efi_gui=
d_device_path, &handler);
>>> +              ret =3D efi_search_protocol(volume_handles[i],
>>> +                                        &efi_guid_device_path, &handl=
er);
>>>                if (ret !=3D EFI_SUCCESS)
>>>                        continue;
>>> -              ret =3D efi_protocol_open(handler, (void **)&device_pat=
h,
>>> -                                      efi_root, NULL, EFI_OPEN_PROTOC=
OL_GET_PROTOCOL);
>>> +
>>> +              device_path =3D handler->protocol_interface;
>>> +              full_path =3D efi_dp_from_file(device_path,
>>> +                                           "/EFI/BOOT/" BOOTEFI_NAME)=
;
>>> +
>>> +              /* check whether the partition or disk have the default=
 file */
>>> +              ret =3D efi_dp_split_file_path(full_path, &dp, &fp);
>>> +              if (ret !=3D EFI_SUCCESS || !fp)
>>> +                      goto next_entry;
>>> +
>>> +              default_file_path =3D efi_dp_str(fp);
>>> +              if (!default_file_path)
>>> +                      goto next_entry;
>>> +
>>> +              ret =3D efi_search_protocol(volume_handles[i],
>>> +                                        &efi_simple_file_system_proto=
col_guid,
>>> +                                        &handler);
>>>                if (ret !=3D EFI_SUCCESS)
>>> -                      continue;
>>> +                      goto next_entry;
>>> +
>>> +              file_system =3D handler->protocol_interface;
>>> +              ret =3D EFI_CALL(file_system->open_volume(file_system, =
&root));
>>> +              if (ret !=3D EFI_SUCCESS)
>>> +                      goto next_entry;
>>> +
>>> +              ret =3D EFI_CALL(root->open(root, &f, default_file_path=
,
>>> +                                        EFI_FILE_MODE_READ, 0));
>>> +              if (ret !=3D EFI_SUCCESS)
>>> +                      goto next_entry;
>>> +
>>> +              EFI_CALL(f->close(f));
>>>
>>>                ret =3D efi_disk_get_device_name(volume_handles[i], buf=
, BOOTMENU_DEVICE_NAME_MAX);
>>>                if (ret !=3D EFI_SUCCESS)
>>> -                      continue;
>>> +                      goto next_entry;
>>>
>>>                p =3D dev_name;
>>>                utf8_utf16_strncpy(&p, buf, strlen(buf));
>>>
>>>                /* prefer to short form device path */
>>> -              short_dp =3D efi_dp_shorten(device_path);
>>> -              if (short_dp)
>>> -                      device_path =3D short_dp;
>>> +              short_dp =3D efi_dp_shorten(full_path);
>>> +              device_path =3D short_dp ? short_dp : full_path;
>>>
>>>                lo.label =3D dev_name;
>>>                lo.attributes =3D LOAD_OPTION_ACTIVE;
>>> @@ -396,24 +426,35 @@ static efi_status_t efi_bootmgr_enumerate_boot_o=
ption(struct eficonfig_media_boo
>>>                lo.file_path_length =3D efi_dp_size(device_path) + size=
of(END);
>>>                /*
>>>                 * Set the dedicated guid to optional_data, it is used =
to identify
>>> -               * the boot option that automatically generated by the =
bootmenu.
>>> +               * the boot option that automatically generated by the =
efibootmgr.
>>>                 * efi_serialize_load_option() expects optional_data is=
 null-terminated
>>>                 * utf8 string, so set the "1234567" string to allocate=
 enough space
>>>                 * to store guid, instead of realloc the load_option.
>>>                 */
>>>                lo.optional_data =3D "1234567";
>>> -              opt[i].size =3D efi_serialize_load_option(&lo, (u8 **)&=
opt[i].lo);
>>> -              if (!opt[i].size) {
>>> -                      ret =3D EFI_OUT_OF_RESOURCES;
>>> -                      goto out;
>>> +              opt[num].size =3D efi_serialize_load_option(&lo, (u8 **=
)&opt[num].lo);
>>> +              if (!opt[num].size) {
>>> +                      efi_free_pool(full_path);
>>> +                      efi_free_pool(dp);
>>> +                      efi_free_pool(fp);
>>> +                      efi_free_pool(default_file_path);
>>> +                      return EFI_OUT_OF_RESOURCES;
>>>                }
>>>                /* set the guid */
>>> -              optional_data =3D (char *)opt[i].lo + (opt[i].size - u1=
6_strsize(u"1234567"));
>>> +              optional_data =3D (char *)opt[num].lo + (opt[num].size =
- u16_strsize(u"1234567"));
>>>                memcpy(optional_data, &efi_guid_bootmenu_auto_generated=
, sizeof(efi_guid_t));
>>> +              num++;
>>> +
>>> +next_entry:
>>> +              efi_free_pool(full_path);
>>> +              efi_free_pool(dp);
>>> +              efi_free_pool(fp);
>>> +              efi_free_pool(default_file_path);
>>>        }
>>>
>>> -out:
>>> -      return ret;
>>> +      *count =3D num;
>>> +
>>> +      return EFI_SUCCESS;
>>> }
>>>
>>> /**
>>> @@ -642,7 +683,7 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 bo=
ot_index)
>>>   * efi_bootmgr_update_media_device_boot_option() - generate the media=
 device boot option
>>>   *
>>>   * This function enumerates all devices supporting EFI_SIMPLE_FILE_SY=
STEM_PROTOCOL
>>> - * and generate the bootmenu entries.
>>> + * and create the boot option with default file if the file exists.
>>>   * This function also provide the BOOT#### variable maintenance for
>>>   * the media device entries.
>>>   * - Automatically create the BOOT#### variable for the newly detecte=
d device,
>>> @@ -674,8 +715,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_=
option(void)
>>>                goto out;
>>>        }
>>>
>>> -      /* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROT=
OCOL */
>>> -      ret =3D efi_bootmgr_enumerate_boot_option(opt, volume_handles, =
count);
>>> +      ret =3D efi_bootmgr_enumerate_boot_option(opt, volume_handles, =
&count);
>>>        if (ret !=3D EFI_SUCCESS)
>>>                goto out;
>>>

