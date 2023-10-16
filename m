Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A9ECDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4342D86DD5;
	Mon, 16 Oct 2023 16:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QQGY/DK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF7E86DD5; Mon, 16 Oct 2023 16:47:28 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D16DE86940
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697467642; x=1698072442; i=xypron.glpk@gmx.de;
 bh=GeIJGIasW9HcoAgv7XqjdkCRanOofQdWnQE6K8UFXMQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=QQGY/DK7tpjn4q557dmjH9sLvWw2QsWZSuYDztxUk2ehH09seQg5kkI8lthE/tax5j4OICm0aqO
 zgvH5c8M82N50AYlI4gvau3/WQpfUOu9vpWz7/nCuRh9PCx8aYvDEIXOdSXrUYoCYd4x76QP54yeL
 23NB/oZDm7Gq3QZSN+NouRXDObhADAhtzBar8kzTz+nXMzEHWZaPWnPmCLGod1KHgySDuSqSjt/qY
 QaTXcwXa3No00PTbU85so5vlG6dlzw88wkeugw24cn1FlXYu4O80NFp27jCm/9B00C63RXh5YkKQi
 /gv5l0X++Q9qptYgNLshTENVRZu6aWmuYAAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeMA-1r03p741Ia-00RcHn; Mon, 16
 Oct 2023 16:47:22 +0200
Message-ID: <050e8bea-771b-491d-8d66-14fadcff0487@gmx.de>
Date: Mon, 16 Oct 2023 16:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] efi_loader: create default file boot option
Content-Language: en-US
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Takahiro Akashi
 <takahiro.akashi@linaro.org>, Michal Simek <michal.simek@amd.com>
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-5-masahisa.kojima@linaro.org>
 <A2082A91-A1CC-43E8-B151-968D7746B906@gmx.de>
 <CAC_iWj+koNjVBR7TCJH_u_PvY5xDHgtBGRTHBRRgAx_aDeC8-A@mail.gmail.com>
 <ae12d900-fe7f-4f7b-9eb1-018aa719174f@gmx.de>
 <CADQ0-X8XGiek9oBEFeDtXaR2vcBsQS-NhJK5mL9TRLK+9gTJ2A@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CADQ0-X8XGiek9oBEFeDtXaR2vcBsQS-NhJK5mL9TRLK+9gTJ2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b/guYVpLLd9C7ytBY7j6/KIAwwHb6m+I9N3jdNMQIwwznYDznRi
 TinBtdqapC40fM65M1oUnXM2izoLWk7yFBdTzCqAmhfXgiPfYDvxIEZeWZuStN5F/++aLza
 YibFsqDPzrbpyi4a4marC3i46o5tX0nmYJFAl3IqoS9FDiR4ivwup+MzMKnKNjE3D29bkEP
 fjKSe4ThaqXxCV7EcjOHw==
UI-OutboundReport: notjunk:1;M01:P0:siWOo7+TulQ=;tA0fhf1MFkwNh5ykgTgrvbCmAJX
 bnjcj/cl11FwaQjm5OFzLOLsXbXo62+gPzncfEFEYB9wDG8yZ+KPo+W0JfNS0RvXs0FHNJUix
 Yb33pJNPtldqQ350hLAyv7JrAXhIrmC5rySykV30ARSuJkReErzzKMcZ7njuVYxY4S/HG0V/S
 w2B7xg4AEQj+pUEr5kd3DA80gnT9hg6QyRsoL7jzZnbAyZerDamdtQuUjoNSBO9iPHc1d2BWN
 NDw3599cZZAKWtOxVSr/HdSBbu/4i8qlikSHxHF8EYVUUekdnjraVZDe4WSXdOkYLk/A1kFCO
 rbiKp0ADpgQN23iL9evIhwavPKdx5n0bfPw67L1UILNySNJkj8xmtM2kpQzWlv3Nz3hXWOb2L
 FYxth+olADUappx3TCuxS/HC1LAyqbyOgCRa1g3Lbz07BIGphlpvIHK7WjAToEH4CYFgxv5rK
 Ntmv0qSNLnS1+2Wq96RKyJnkXGfgQ175twz0yeuqtEwXTw58pqJFnB2WPSHYitVIC/fl062SF
 B+iRwcOUXwL4ykHntQ/QXX0/pCRsPhhN7J6TVcVw8puElT48uM3YfFk6DpXF2iUnH/Fd4yqVR
 ydhOLlyjBdFTmHRft5+yGdGof0cO4MZd/vmJMsb4IX4bw8UxX2yZoSlUQaDX+5ZAk+YmvRsBN
 Q32tfAbPgPnNj+bmLDb8LHTvOHMDiE9dudhit/Lus8fH/eYK5QWwPEZj3l6VhlR8mnuwGe/Cd
 vyGseE/vC/uFT+0cxrjNK8LalIR/j/xsPBZCEi+ec36Pf/ycGmtfuooquOLhrKbqiO9NNxN5S
 MW+21DxSjZaFV3KznMP9zDZN9gSHwCtVl2s1wHpGuEYDZMXrYJp83BkeOnogYN7uHUk7euu50
 AttTs9F+cHZ+P48r7MW33C/bXONSAGl/pKJ3PAwkpz7S/DjeJy7BZ6wvpU8oHQW+70E+uBP3f
 f+quYXQ0tPj8JGiQMyQ77n3aPBFQRZyOhVq8ABAKk48AxSfIG7c/TefzwtPR2K8KL5vl9Q==
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

On 16.10.23 15:00, Masahisa Kojima wrote:
> On Mon, 16 Oct 2023 at 21:46, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 16.10.23 14:31, Ilias Apalodimas wrote:
>>> Hi Heinrich,
>>>
>>> On Mon, 16 Oct 2023 at 10:06, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
>>>>
>>>>
>>>>
>>>> Am 16. Oktober 2023 08:45:21 MESZ schrieb Masahisa Kojima <masahisa.k=
ojima@linaro.org>:
>>>>> Current efibootmgr automatically creates the
>>>>> boot options of all disks and partitions installing
>>>>> EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
>>>>> Some of the automatically created boot options are
>>>>> useless if the disk and partition does not have
>>>>> the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
>>>>>
>>>>> This commit only creates the boot option if the disk and
>>>>> partition have the default file so that system can directly
>>>>> boot from it.
>>>>
>>>> I don't directly see the user benefit.
>>>
>>> The user can add an HTTP boot option now and the installer will
>>> automatically start.  That would allow products to ship with a single
>>> boot option provisioned and run an installer on first boot
>>
>> This commit is not about HTTP. It changes how boot options for block
>> devices are created.
>>
>>>
>>>>
>>>> Reading all file systems will increase the boot time. Shouldn't we av=
oid this?
>>>
>>> Any idea what would be an alternative?  But when we added the
>>> automatic boot options we said we should avoid dynamic scanning and
>>> store results in a file.  This is doing a similar thing.  The only
>>> difference is that it mounts the iso image before adding the boot
>>> option.
>>
>> The alternative is to keep showing boot options for block devices even
>> if there is no BOOTxxxx.EFI file.
>>
>>>
>>>>
>>>> What does EDK II do?
>>>
>>> No Idea :)
>>
>>
>> On my workstation I get generated boot options
>>
>> Boot0001* UEFI:CD/DVD Drive     BBS(129,,0x0)
>> Boot0003* UEFI:Removable Device BBS(130,,0x0)
>> Boot0004* UEFI:Network Device   BBS(131,,0x0)
>>
>> without any media inserted and without any PXE server available.
>
> It is just information about how the EDK2 works.
> When I attach the Fedora installation media on EDK2(OVMF),
> the automatically generated boot option is as follows.
>
> UEFI QEMU HARDDISK QM00001 : PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Maste=
r,0x0)

An ATAPI drive typically is not removable. So I wonder why it is listed.
Did you set the removable flag on the command line?

>
> When this boot option is selected, Fedora installer automatically starts=
.
> So EDK II is searching the default file on the fly.

What is shown if you attach a medium without Bootaa64.efi?

Best regards

Heinrich

>
> Thanks,
> Masahisa Kojima
>
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>> Thanks
>>> /Ilias
>>>>
>>>> Does the UEFI specification warrant this change?
>>>>
>>>> Best regards
>>>>
>>>> Heinrich
>>>>
>>>>>
>>>>> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>>>>> ---
>>>>> lib/efi_loader/efi_bootmgr.c | 86 ++++++++++++++++++++++++++--------=
--
>>>>> 1 file changed, 63 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootm=
gr.c
>>>>> index a40762c74c..c8cf1c5506 100644
>>>>> --- a/lib/efi_loader/efi_bootmgr.c
>>>>> +++ b/lib/efi_loader/efi_bootmgr.c
>>>>> @@ -355,40 +355,70 @@ error:
>>>>>    */
>>>>> static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonf=
ig_media_boot_option *opt,
>>>>>                                                       efi_handle_t *=
volume_handles,
>>>>> -                                                    efi_status_t co=
unt)
>>>>> +                                                    efi_uintn_t *co=
unt)
>>>>> {
>>>>> -      u32 i;
>>>>> +      u32 i, num =3D 0;
>>>>>         struct efi_handler *handler;
>>>>>         efi_status_t ret =3D EFI_SUCCESS;
>>>>>
>>>>> -      for (i =3D 0; i < count; i++) {
>>>>> +      for (i =3D 0; i < *count; i++) {
>>>>>                 u16 *p;
>>>>>                 u16 dev_name[BOOTMENU_DEVICE_NAME_MAX];
>>>>>                 char *optional_data;
>>>>>                 struct efi_load_option lo;
>>>>>                 char buf[BOOTMENU_DEVICE_NAME_MAX];
>>>>> -              struct efi_device_path *device_path;
>>>>> +              struct efi_device_path *device_path, *full_path, *dp,=
 *fp;
>>>>>                 struct efi_device_path *short_dp;
>>>>> +              struct efi_file_handle *root, *f;
>>>>> +              struct efi_simple_file_system_protocol *file_system;
>>>>> +              u16 *default_file_path =3D NULL;
>>>>>
>>>>> -              ret =3D efi_search_protocol(volume_handles[i], &efi_g=
uid_device_path, &handler);
>>>>> +              ret =3D efi_search_protocol(volume_handles[i],
>>>>> +                                        &efi_guid_device_path, &han=
dler);
>>>>>                 if (ret !=3D EFI_SUCCESS)
>>>>>                         continue;
>>>>> -              ret =3D efi_protocol_open(handler, (void **)&device_p=
ath,
>>>>> -                                      efi_root, NULL, EFI_OPEN_PROT=
OCOL_GET_PROTOCOL);
>>>>> +
>>>>> +              device_path =3D handler->protocol_interface;
>>>>> +              full_path =3D efi_dp_from_file(device_path,
>>>>> +                                           "/EFI/BOOT/" BOOTEFI_NAM=
E);
>>>>> +
>>>>> +              /* check whether the partition or disk have the defau=
lt file */
>>>>> +              ret =3D efi_dp_split_file_path(full_path, &dp, &fp);
>>>>> +              if (ret !=3D EFI_SUCCESS || !fp)
>>>>> +                      goto next_entry;
>>>>> +
>>>>> +              default_file_path =3D efi_dp_str(fp);
>>>>> +              if (!default_file_path)
>>>>> +                      goto next_entry;
>>>>> +
>>>>> +              ret =3D efi_search_protocol(volume_handles[i],
>>>>> +                                        &efi_simple_file_system_pro=
tocol_guid,
>>>>> +                                        &handler);
>>>>>                 if (ret !=3D EFI_SUCCESS)
>>>>> -                      continue;
>>>>> +                      goto next_entry;
>>>>> +
>>>>> +              file_system =3D handler->protocol_interface;
>>>>> +              ret =3D EFI_CALL(file_system->open_volume(file_system=
, &root));
>>>>> +              if (ret !=3D EFI_SUCCESS)
>>>>> +                      goto next_entry;
>>>>> +
>>>>> +              ret =3D EFI_CALL(root->open(root, &f, default_file_pa=
th,
>>>>> +                                        EFI_FILE_MODE_READ, 0));
>>>>> +              if (ret !=3D EFI_SUCCESS)
>>>>> +                      goto next_entry;
>>>>> +
>>>>> +              EFI_CALL(f->close(f));
>>>>>
>>>>>                 ret =3D efi_disk_get_device_name(volume_handles[i], =
buf, BOOTMENU_DEVICE_NAME_MAX);
>>>>>                 if (ret !=3D EFI_SUCCESS)
>>>>> -                      continue;
>>>>> +                      goto next_entry;
>>>>>
>>>>>                 p =3D dev_name;
>>>>>                 utf8_utf16_strncpy(&p, buf, strlen(buf));
>>>>>
>>>>>                 /* prefer to short form device path */
>>>>> -              short_dp =3D efi_dp_shorten(device_path);
>>>>> -              if (short_dp)
>>>>> -                      device_path =3D short_dp;
>>>>> +              short_dp =3D efi_dp_shorten(full_path);
>>>>> +              device_path =3D short_dp ? short_dp : full_path;
>>>>>
>>>>>                 lo.label =3D dev_name;
>>>>>                 lo.attributes =3D LOAD_OPTION_ACTIVE;
>>>>> @@ -396,24 +426,35 @@ static efi_status_t efi_bootmgr_enumerate_boot=
_option(struct eficonfig_media_boo
>>>>>                 lo.file_path_length =3D efi_dp_size(device_path) + s=
izeof(END);
>>>>>                 /*
>>>>>                  * Set the dedicated guid to optional_data, it is us=
ed to identify
>>>>> -               * the boot option that automatically generated by th=
e bootmenu.
>>>>> +               * the boot option that automatically generated by th=
e efibootmgr.
>>>>>                  * efi_serialize_load_option() expects optional_data=
 is null-terminated
>>>>>                  * utf8 string, so set the "1234567" string to alloc=
ate enough space
>>>>>                  * to store guid, instead of realloc the load_option=
.
>>>>>                  */
>>>>>                 lo.optional_data =3D "1234567";
>>>>> -              opt[i].size =3D efi_serialize_load_option(&lo, (u8 **=
)&opt[i].lo);
>>>>> -              if (!opt[i].size) {
>>>>> -                      ret =3D EFI_OUT_OF_RESOURCES;
>>>>> -                      goto out;
>>>>> +              opt[num].size =3D efi_serialize_load_option(&lo, (u8 =
**)&opt[num].lo);
>>>>> +              if (!opt[num].size) {
>>>>> +                      efi_free_pool(full_path);
>>>>> +                      efi_free_pool(dp);
>>>>> +                      efi_free_pool(fp);
>>>>> +                      efi_free_pool(default_file_path);
>>>>> +                      return EFI_OUT_OF_RESOURCES;
>>>>>                 }
>>>>>                 /* set the guid */
>>>>> -              optional_data =3D (char *)opt[i].lo + (opt[i].size - =
u16_strsize(u"1234567"));
>>>>> +              optional_data =3D (char *)opt[num].lo + (opt[num].siz=
e - u16_strsize(u"1234567"));
>>>>>                 memcpy(optional_data, &efi_guid_bootmenu_auto_genera=
ted, sizeof(efi_guid_t));
>>>>> +              num++;
>>>>> +
>>>>> +next_entry:
>>>>> +              efi_free_pool(full_path);
>>>>> +              efi_free_pool(dp);
>>>>> +              efi_free_pool(fp);
>>>>> +              efi_free_pool(default_file_path);
>>>>>         }
>>>>>
>>>>> -out:
>>>>> -      return ret;
>>>>> +      *count =3D num;
>>>>> +
>>>>> +      return EFI_SUCCESS;
>>>>> }
>>>>>
>>>>> /**
>>>>> @@ -642,7 +683,7 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 =
boot_index)
>>>>>    * efi_bootmgr_update_media_device_boot_option() - generate the me=
dia device boot option
>>>>>    *
>>>>>    * This function enumerates all devices supporting EFI_SIMPLE_FILE=
_SYSTEM_PROTOCOL
>>>>> - * and generate the bootmenu entries.
>>>>> + * and create the boot option with default file if the file exists.
>>>>>    * This function also provide the BOOT#### variable maintenance fo=
r
>>>>>    * the media device entries.
>>>>>    * - Automatically create the BOOT#### variable for the newly dete=
cted device,
>>>>> @@ -674,8 +715,7 @@ efi_status_t efi_bootmgr_update_media_device_boo=
t_option(void)
>>>>>                 goto out;
>>>>>         }
>>>>>
>>>>> -      /* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PR=
OTOCOL */
>>>>> -      ret =3D efi_bootmgr_enumerate_boot_option(opt, volume_handles=
, count);
>>>>> +      ret =3D efi_bootmgr_enumerate_boot_option(opt, volume_handles=
, &count);
>>>>>         if (ret !=3D EFI_SUCCESS)
>>>>>                 goto out;
>>>>>
>>

