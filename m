Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C732CC04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 13:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 394A68844B;
	Wed,  8 May 2024 15:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ubKZibbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6ACD884E5; Wed,  8 May 2024 15:53:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D47882FA
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 15:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715176391; x=1715781191; i=xypron.glpk@gmx.de;
 bh=c4Ht9ueVCV/dqeWdoCksjkzFvieBt09UhuL4Bw4D2no=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ubKZibbSHBAKqqLkqSb10G2dp8tpjzM+BHC16VTS4iZtZs9B0HEVeNYoE4QU8UcI
 a1aZkGMxgoNNhcibJX435LuK4C/cuCjlQBfJpkuAy34ZRz1ZPR26ZpSqalC7DE9rE
 OKSnLW4JTeRegWwiEHblB40UDSVYMDSBs8CZtKHZwvfABCJU5ZrR4+QYup0aAKDUf
 INyowmCupAUIqS1dkycwUNTVtk2dP4QdMGTSPyKEKPvaScPiq4nWisoTwpV/THo95
 D4GQSyPFD8+KKVhYaxi2hM47HIgRQABFCAzbUPsj8l/Igmu3bPsM2rhTgOuBGiz79
 OjkoLIYNEjt/Flko8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.55.2.71] ([149.11.192.251]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1s3sNo1h5f-004E16; Wed, 08
 May 2024 15:53:11 +0200
Message-ID: <b78070db-a972-4469-ac95-541929d8d43d@gmx.de>
Date: Wed, 8 May 2024 15:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: capsule: detect possible ESP device path
To: Weizhao Ouyang <o451686892@gmail.com>
References: <20240508112401.155528-1-o451686892@gmail.com>
 <f4caebe2-d218-4ce7-9c3d-4dc83a0e1c76@gmx.de>
 <CAHk0Hou9neEiVDLBRAsFhqu9wrWq-amSde+p2GJ6BLqwxV98_g@mail.gmail.com>
Content-Language: en-US
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAHk0Hou9neEiVDLBRAsFhqu9wrWq-amSde+p2GJ6BLqwxV98_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QhqBLFOrHY+QJir+VT4yAzlFDWPRKTfc2Tenn4RpBJkQY2xkh1o
 KluQ8vtBiurGvavODQHIAkF6ieF6jt4Eqmxwc+mIHmim3a5McnMlQTmnAuG1PwxK1/WSXDk
 03A51ak+mHzfoUHHdTYZ+IJUZY8wh+TEEz9Gkm8gXR9vwNegcJ1HRBd9lBp7VjQBuMJjFHD
 rPssvWPHdT22AzEt43ClQ==
UI-OutboundReport: notjunk:1;M01:P0:IYtLrLPezSc=;2Y5ZrGCmfkXs7H7DjRO8ZO8Ji3A
 cXjRY7bL/hP103DMZQq45/bEndC2lDbNKVKNl2qA1XCxAYsw7cHniaXIk+tHAZP6SKaU9Bs58
 YQripal8HTEw1wye7MkxtMbIkTT16hHJf7gLXjvdbBLebeMHlIHQYnMwlc3RNXp0Mt5E2XRnf
 teN9wRZuH+hGBMRSWMf+4y1kStod+gKTKFTMMvemvDJJ02jJ19FTXj9y/eNNecynf81pKASv+
 DvuWxjWgJxXLh8W4+e+B7HaVuLoeVBQv2yzDw4WTlBmFYeEyydJAp8Sk0SKR6qvhKSDTkZlGi
 v1M91Z74H7U2HmdjswgP/bmVQatyq6pqUq44KHjEY3ayPjKfZgVOlxVHtdbyhpJob0oq+Zthi
 Eqt84nG1IhlQUe0JNlyWAhGonsIo9c2GupzByS1Sc4/nVsRj0/HxnZXBNkZwhiKR/y6ajfhJb
 t0M4mafqw6JH1N5k9fNomlC8hmYgSLazl2zzfqEk1sLp+Ymh1tapN0d3fu77gVjlBmcJJuFlR
 8qs4LTFEaFV3l918D7ttjN/BHcG9s3kWNdVMIZEF9wQHEY2Zjj4Z7a1LQDVzsna6AfXd0dFlc
 NOUv7WQ0y6dmGNlA2qzACraUbPutVVXWgEK5xmD/OHlvpUCpiUJv/vkQMhWLNSaJd9PEsU3Wt
 d8wYtXQoOAZpgW3c0D70OjzhZjS170SEucnV0wEauQ6b1tMNed4USFDmymDeQVCzUB6z+Gtm6
 GMfEMTkhyOrG6L+cHVHpKD6m8Rq6Ve2twx7rIhtDmd7MEKLnHTft3D9RtToSBlj/dJk06FLUT
 we6d6bRq3rzZ2zEnsf1P1zi8e70ysbzgDORMH6/5BuLvc=
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

On 5/8/24 14:59, Weizhao Ouyang wrote:
> On Wed, May 8, 2024 at 7:52=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@=
gmx.de> wrote:
>>
>> On 5/8/24 13:24, Weizhao Ouyang wrote:
>>> When using CapsuleApp to execute on-disk update, it will choose the
>>> first boot option as BootNext entry to perform the capsule update afte=
r
>>> a reboot. But auto-generate boot option will ignore the logical
>>> partition which might be an ESP, thus it could not find the capsule
>>> file.
>>>
>>> Align with the EDK II, detect the possible ESP device path by expandin=
g
>>> the media path.
>>
>> Hello Wheizhoa,
>>
>>   From the description I would not know how to reproduce the problem yo=
u
>> face.
>>
>> Could you, please, provide an example (including disk image and capsule=
)
>> for QEMU and describe expected and observed behavior.
>>
>> We should add a CI test case covering the observed bug.
>
> Hi Heinrich,
>
> Here is a brief description, I'll add a testcase in the next patch.
>
> background:
> - there is an ESP in an mmc logical partition
> - in the edk2 shell payload, running "CapsuleApp.efi -OD" to perform
> the capsule on-disk update
>
> workflow:
> - currently, u-boot will auto-generate boot option and install with
> eliminating logical partitions. So we will have a boot variable
> Boot0000 that its file_path seems like: "/VenHw/eMMC(0)/eMMC(0)"
> - then we run the efi app in the edk shell payload. The CapsuleApp
> will find this boot entry, and it will detect that there is an ESP
> in this mmc device. According to the on-disk update flow, it will
> copy the capsule to the ESP, and add the Boot0000 to the BootNext.

Why do you need an EFI app? Shouldn't the operating system place the
capsule file?

What makes you expect that there is any ESP on whatever Boot0000 points
to? You should evaluate BootCurrent if you want to know from which boot
entry the current application was started from.

> - After CapsuleApp.efi reset the device, u-boot will check
> OsIndications and perform the on-disk update flow. Then it will

U-Boot does not check OsIndications.

Best regards

Heirnich

> search for the capsule file from the boot entry indicated by the
> BootNext. Unfortunately, its file_path is "/VenHw/eMMC(0)/eMMC(0)",
> so the search will fail.
> - Using this patch, u-boot will expand the Boot0000 file path to
> detect its ESP, so the capsule file will be found in the expanded
> device path, eg: "/VenHw/eMMC(0)/eMMC(0)/HD(2)".
>
> BR,
> Weizhao
>
>>
>>>
>>> Fixes: f86fba8adbf3 ("efi_loader: auto-generate boot option for each b=
lkio device")
>>> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
>>> ---
>>>    include/efi_loader.h          |   6 ++
>>>    lib/efi_loader/efi_boottime.c |  15 ++---
>>>    lib/efi_loader/efi_capsule.c  | 110 +++++++++++++++++++++++++++++++=
++-
>>>    3 files changed, 118 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>>> index 9600941aa327..9d78fa936701 100644
>>> --- a/include/efi_loader.h
>>> +++ b/include/efi_loader.h
>>> @@ -683,6 +683,12 @@ efi_status_t efi_protocol_open(struct efi_handler=
 *handler,
>>>                               void **protocol_interface, void *agent_h=
andle,
>>>                               void *controller_handle, uint32_t attrib=
utes);
>>>
>>> +/* Connect drivers to controller */
>>> +efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_ha=
ndle,
>>> +                                        efi_handle_t *driver_image_ha=
ndle,
>>> +                                        struct efi_device_path *remai=
n_device_path,
>>> +                                        bool recursive);
>>> +
>>>    /* Install multiple protocol interfaces */
>>>    efi_status_t EFIAPI
>>>    efi_install_multiple_protocol_interfaces(efi_handle_t *handle, ...)=
;
>>> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_bootti=
me.c
>>> index 1951291747cd..2c86d78208b2 100644
>>> --- a/lib/efi_loader/efi_boottime.c
>>> +++ b/lib/efi_loader/efi_boottime.c
>>> @@ -103,12 +103,6 @@ static efi_status_t EFIAPI efi_disconnect_control=
ler(
>>>                                        efi_handle_t driver_image_handl=
e,
>>>                                        efi_handle_t child_handle);
>>>
>>> -static
>>> -efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_ha=
ndle,
>>> -                                        efi_handle_t *driver_image_ha=
ndle,
>>> -                                        struct efi_device_path *remai=
n_device_path,
>>> -                                        bool recursive);
>>> -
>>>    /* Called on every callback entry */
>>>    int __efi_entry_check(void)
>>>    {
>>> @@ -3670,11 +3664,10 @@ static efi_status_t efi_connect_single_control=
ler(
>>>     *
>>>     * Return: status code
>>>     */
>>> -static efi_status_t EFIAPI efi_connect_controller(
>>> -                     efi_handle_t controller_handle,
>>> -                     efi_handle_t *driver_image_handle,
>>> -                     struct efi_device_path *remain_device_path,
>>> -                     bool recursive)
>>> +efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_ha=
ndle,
>>> +                                        efi_handle_t *driver_image_ha=
ndle,
>>> +                                        struct efi_device_path *remai=
n_device_path,
>>> +                                        bool recursive)
>>>    {
>>>        efi_status_t r;
>>>        efi_status_t ret =3D EFI_NOT_FOUND;
>>> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule=
.c
>>> index de0d49ebebda..919e3cba071b 100644
>>> --- a/lib/efi_loader/efi_capsule.c
>>> +++ b/lib/efi_loader/efi_capsule.c
>>> @@ -922,6 +922,105 @@ static bool device_is_present_and_system_part(st=
ruct efi_device_path *dp)
>>>        return true;
>>>    }
>>>
>>> +/**
>>> + * get_esp_from_boot_option_file_path - get the expand device path
>>> + *
>>> + * Get a possible efi system partition by expanding a boot option
>>> + * file path.
>>> + *
>>> + * @boot_dev The device path pointing to a boot option
>>> + * Return:   The full ESP device path or NULL if fail
>>> + */
>>> +static struct efi_device_path *get_esp_from_boot_option_file_path(str=
uct efi_device_path *boot_dev)
>>> +{
>>> +     efi_status_t ret =3D EFI_SUCCESS;
>>> +     efi_handle_t handle;
>>> +     struct efi_device_path *dp =3D boot_dev;
>>> +     struct efi_device_path *full_path =3D NULL;
>>> +
>>> +     ret =3D EFI_CALL(efi_locate_device_path(&efi_simple_file_system_=
protocol_guid,
>>> +                                           &dp,
>>> +                                           &handle));
>>> +     if (ret !=3D EFI_SUCCESS)
>>> +             ret =3D EFI_CALL(efi_locate_device_path(&efi_block_io_gu=
id, &dp, &handle));
>>> +
>>> +     /* Expand Media Device Path */
>>> +     if (ret =3D=3D EFI_SUCCESS && EFI_DP_TYPE(dp, END, END)) {
>>> +             struct efi_device_path *temp_dp;
>>> +             struct efi_block_io *block_io;
>>> +             void *buffer;
>>> +             efi_handle_t *simple_file_system_handle;
>>> +             efi_uintn_t number_handles, index;
>>> +             u32 size;
>>> +             u32 temp_size;
>>> +
>>> +             temp_dp =3D boot_dev;
>>> +             ret =3D EFI_CALL(efi_locate_device_path(&efi_simple_file=
_system_protocol_guid,
>>> +                                                   &temp_dp,
>>> +                                                   &handle));
>>> +             /*
>>> +              * For device path pointing to simple file system, it on=
ly expands to one
>>> +              * full path
>>> +              */
>>> +             if (ret =3D=3D EFI_SUCCESS && EFI_DP_TYPE(temp_dp, END, =
END)) {
>>> +                     if (device_is_present_and_system_part(temp_dp))
>>> +                             return temp_dp;
>>> +             }
>>> +
>>> +             /*
>>> +              * For device path only pointing to the removable device=
 handle, try to
>>> +              * search all its children handles
>>> +              */
>>> +             ret =3D EFI_CALL(efi_locate_device_path(&efi_block_io_gu=
id, &temp_dp, &handle));
>>> +             EFI_CALL(efi_connect_controller(handle, NULL, NULL, true=
));
>>
>> Which driver do you expect to connect here?
>>
>>> +
>>> +             /* Align with edk2, issue a dummy read to the device to =
check the device change */
>>> +             ret =3D EFI_CALL(efi_handle_protocol(handle, &efi_block_=
io_guid, (void **)&block_io));
>>> +             if (ret =3D=3D EFI_SUCCESS) {
>>> +                     buffer =3D memalign(block_io->media->io_align, b=
lock_io->media->block_size);
>>> +                     if (buffer) {
>>> +                             ret =3D EFI_CALL(block_io->read_blocks(b=
lock_io,
>>> +                                                                  blo=
ck_io->media->media_id,
>>> +                                                                  0,
>>> +                                                                  blo=
ck_io->media->block_size,
>>> +                                                                  buf=
fer));
>>> +                             free(buffer);
>>> +                     } else {
>>> +                             return full_path;
>>> +                     }
>>> +             } else {
>>> +                     return full_path;
>>> +             }
>>> +
>>> +             /* detect the default boot file from removable media */
>>> +             size =3D efi_dp_size(boot_dev) - sizeof(struct efi_devic=
e_path);
>>> +             EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
>>> +                                               &efi_simple_file_syste=
m_protocol_guid,
>>
>> If you are looking for an ESP shouldn't you use the ESP GUID to find it=
?
>> It is installed on the ESP in efi_status_t efi_disk_add_dev().
>>
>> Best regards
>>
>> Heinrich
>>
>>> +                                               NULL,
>>> +                                               &number_handles,
>>> +                                               &simple_file_system_ha=
ndle));
>>> +             for (index =3D 0; index < number_handles; index++) {
>>> +                     EFI_CALL(efi_handle_protocol(simple_file_system_=
handle[index],
>>> +                                                  &efi_guid_device_pa=
th,
>>> +                                                  (void **)&temp_dp))=
;
>>> +
>>> +                     log_debug("Search ESP %pD\n", temp_dp);
>>> +                     temp_size =3D efi_dp_size(temp_dp) - sizeof(stru=
ct efi_device_path);
>>> +                     if (size <=3D temp_size && !memcmp(temp_dp, boot=
_dev, size)) {
>>> +                             if (device_is_present_and_system_part(te=
mp_dp)) {
>>> +                                     efi_free_pool(simple_file_system=
_handle);
>>> +                                     return temp_dp;
>>> +                             }
>>> +                     }
>>> +             }
>>> +
>>> +             if (simple_file_system_handle)
>>> +                     efi_free_pool(simple_file_system_handle);
>>> +     }
>>> +
>>> +     return full_path;
>>> +}
>>> +
>>>    /**
>>>     * find_boot_device - identify the boot device
>>>     *
>>> @@ -938,6 +1037,7 @@ static efi_status_t find_boot_device(void)
>>>        int i, num;
>>>        struct efi_simple_file_system_protocol *volume;
>>>        struct efi_device_path *boot_dev =3D NULL;
>>> +     struct efi_device_path *full_path =3D NULL;
>>>        efi_status_t ret;
>>>
>>>        /* find active boot device in BootNext */
>>> @@ -961,8 +1061,14 @@ static efi_status_t find_boot_device(void)
>>>                        if (device_is_present_and_system_part(boot_dev)=
) {
>>>                                goto found;
>>>                        } else {
>>> -                             efi_free_pool(boot_dev);
>>> -                             boot_dev =3D NULL;
>>> +                             full_path =3D get_esp_from_boot_option_f=
ile_path(boot_dev);
>>> +                             if (full_path) {
>>> +                                     boot_dev =3D full_path;
>>> +                                     goto found;
>>> +                             } else {
>>> +                                     efi_free_pool(boot_dev);
>>> +                                     boot_dev =3D NULL;
>>> +                             }
>>>                        }
>>>                }
>>>        }
>>

