Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC898CDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 20:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59CC686F40;
	Tue, 17 Oct 2023 22:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VHosnWvt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0671C86F4E; Tue, 17 Oct 2023 22:29:51 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE79586F40
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 22:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697574578; x=1698179378; i=xypron.glpk@gmx.de;
 bh=FfdWGpb7ivtW1fSY8Pj9iA8Mv4UL3g+smTtjY8z8u0M=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=VHosnWvt4xdfXSw95m9p3y6GceAUZkaweR3nJcvg5i3cIQ17I7dFRuT47W3D1x9QwcVQesyeoKb
 7yvWnG2AUZEbsbR2cmH4kTtwBMOCq7/xVbJGdwJHhV4FNWv2ISGrY/73uVroMbpWyQXwgST7wYYqe
 E5Ti3HJ7a3NFVc+lNvdixB12OpPCx2tgLxJmsUn+T2qhMBWww54jsEbqisY6EKb7IcuWE12EN/lbQ
 Luyapd1wOWfzfAVxan0KJB5kEeY5nOMZvFYiiTE0igEvOUVHCA2KQBO5/CmWTMncQbdBVp6jsOa8M
 JfdllwlUsovGvNDd2L33s4qiYx5qpkh2lnfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAgq-1rPhTW0wEy-00bdp8; Tue, 17
 Oct 2023 22:29:38 +0200
Message-ID: <10caa00d-8d2f-4b56-8dff-8535b2bb8563@gmx.de>
Date: Tue, 17 Oct 2023 22:29:31 +0200
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
 <050e8bea-771b-491d-8d66-14fadcff0487@gmx.de>
 <CADQ0-X9n24HVJ_AoMszTUQy1wk+q=TfZG915mzd3gd=GScxjMA@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CADQ0-X9n24HVJ_AoMszTUQy1wk+q=TfZG915mzd3gd=GScxjMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rXBtpPkZit8m36HOEjInO6GwqigA87X9g+QVR4ms/dUUqUzRwVY
 lPTQSjcocImNkD5animgXrmQsEUGWy58OBW2+kkkF91t4VDOgY87MD5TcdV1aWJjG0FlYqF
 zTHAajLD9qzoRp6RJ/tx163L6dKZs+dTKudNZfa5/CYZD1gnYerJh1+UGxi55DF2kCQ6XU0
 DK91HNEvPp0h6Ptw5DmJQ==
UI-OutboundReport: notjunk:1;M01:P0:mrHxdhGhyno=;ul6B9DIZkFGcoGnFKO1mm2Rc6bV
 3DMb40uSkZqWwT60hCY7NQ9/anoGlxcOh7Kur3qdPbRKRnIA0QzKPc3eiCbcy8S/BEeun808A
 haj+/PfSr74a63iFmm05JgMsF1JNR24JExs4AkkidyFCQiXiUdWqdwENeJ09VHQnuSQrNeQe7
 DQSR93pjDsvDLnj1VpkR915dZm6gEeg+yTGVel83hdfOI0yp3kFoSX0tGz5DBMdZDSXAfr5HD
 8hPfEsvX5S5Y8A4nc7cqrO1RM7X5a32OXwlAG8Ft18TUN2RsLfQnm3CJkRm4nouvmwwA8j/FJ
 fUf7jqHA7XVTF8Xhg0kKegTzvL8Xs4jn2S4Vqfe3nR3YlX15yWWjCQXRU4KoYkM70XWJjoVT0
 pMfkhsr6HtyOwRoBqbn1B8EkYjCVszYSwweVkC1gmCngilrV59k1SmsJC85RmTlhnfE2vVg2E
 7Aaowx/NJEZBaptubHVKoFORNI2MYpcUplCZEKtRoSg9FgYr/7lCqDdV+qaKAO/K2SC/6M6Vz
 x+4PANeEdhl8pVIINCgGEf3MG2tG77w6bu5FFVk3dow47o8fBhPrHOaJf3BBpgsQ2q6r+zXfz
 sC0NiBw48uMNv9O8pf/rfWFZQlaNDbruXXjWCI/33XsMf4Ip+Sm+DP3O29ANnKpz+CLSO1xI9
 N401V96RuolJRcX9Tixs3tOt7XIBmi53LoAfqjWMksR+Jjy0XBIYCrROF/r4icvJqdR6s+8Zp
 ixod/1U8IvlObdsa1yBHUc4f4wlJsiHJo3loDaP94LyFHo6uieaPGAwG5imfnehECyngIWpu3
 T5pvlTZtoxq3YMS+AcJ9joz4VK+Zeu9hF7hSjEZD5mxkQ3crX+B7+p+17NROWNO3NltI7fdwj
 kSfJflm5X8tN36C2bpo/a79lcs1t4AMf8/rJTInoCUlc+QGdNvvIolJF21oQxskKvO95+qcC4
 vGBDyOSj9SPYbg7a/2ZtZrJ5oO0=
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

On 17.10.23 07:32, Masahisa Kojima wrote:
> Hi Heinrich,
>
> On Mon, 16 Oct 2023 at 23:52, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 16.10.23 15:00, Masahisa Kojima wrote:
>>> On Mon, 16 Oct 2023 at 21:46, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
>>>>
>>>> On 16.10.23 14:31, Ilias Apalodimas wrote:
>>>>> Hi Heinrich,
>>>>>
>>>>> On Mon, 16 Oct 2023 at 10:06, Heinrich Schuchardt <xypron.glpk@gmx.d=
e> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> Am 16. Oktober 2023 08:45:21 MESZ schrieb Masahisa Kojima <masahisa=
.kojima@linaro.org>:
>>>>>>> Current efibootmgr automatically creates the
>>>>>>> boot options of all disks and partitions installing
>>>>>>> EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
>>>>>>> Some of the automatically created boot options are
>>>>>>> useless if the disk and partition does not have
>>>>>>> the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
>>>>>>>
>>>>>>> This commit only creates the boot option if the disk and
>>>>>>> partition have the default file so that system can directly
>>>>>>> boot from it.
>>>>>>
>>>>>> I don't directly see the user benefit.
>>>>>
>>>>> The user can add an HTTP boot option now and the installer will
>>>>> automatically start.  That would allow products to ship with a singl=
e
>>>>> boot option provisioned and run an installer on first boot
>>>>
>>>> This commit is not about HTTP. It changes how boot options for block
>>>> devices are created.
>>>>
>>>>>
>>>>>>
>>>>>> Reading all file systems will increase the boot time. Shouldn't we =
avoid this?
>>>>>
>>>>> Any idea what would be an alternative?  But when we added the
>>>>> automatic boot options we said we should avoid dynamic scanning and
>>>>> store results in a file.  This is doing a similar thing.  The only
>>>>> difference is that it mounts the iso image before adding the boot
>>>>> option.
>>>>
>>>> The alternative is to keep showing boot options for block devices eve=
n
>>>> if there is no BOOTxxxx.EFI file.
>>>>
>>>>>
>>>>>>
>>>>>> What does EDK II do?
>>>>>
>>>>> No Idea :)
>>>>
>>>>
>>>> On my workstation I get generated boot options
>>>>
>>>> Boot0001* UEFI:CD/DVD Drive     BBS(129,,0x0)
>>>> Boot0003* UEFI:Removable Device BBS(130,,0x0)
>>>> Boot0004* UEFI:Network Device   BBS(131,,0x0)
>>>>
>>>> without any media inserted and without any PXE server available.
>>>
>>> It is just information about how the EDK2 works.
>>> When I attach the Fedora installation media on EDK2(OVMF),
>>> the automatically generated boot option is as follows.
>>>
>>> UEFI QEMU HARDDISK QM00001 : PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Mas=
ter,0x0)
>>
>> An ATAPI drive typically is not removable. So I wonder why it is listed=
.
>> Did you set the removable flag on the command line?
>
> I guess it is not removable(actually I don't know how to set the
> device as removable).
> I just attached the iso image to QEMU with something like '-hda
> Fedora_netinst.iso".
>
> According to the EDK II implementation[1], the boot option is
> enumerated with the following order.
>    1. Removable BlockIo
>    2. Fixed BlockIo
>    3. Non-BlockIo SimpleFileSystem
>    4. LoadFile
> So boot option for the fixed device such as HDD is also automatically cr=
eated.
>
> [1] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/U=
efiBootManagerLib/BmBoot.c#L2150
>
>>
>>>
>>> When this boot option is selected, Fedora installer automatically star=
ts.
>>> So EDK II is searching the default file on the fly.
>>
>> What is shown if you attach a medium without Bootaa64.efi?
>
> The same boot option is created.
> UEFI QEMU HARDDISK QM00001 : PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Maste=
r,0x0)

For USB devices there is a flag controlling if the device is removable:

qemu-system-riscv64 -M virt -kernel u-boot.bin -nographic -device
qemu-xhci -drive if=3Dnone,file=3Ddisk.img,format=3Draw,id=3DUSB1 -device
usb-storage,drive=3DUSB1,removable=3Don

This allows us to test the handling of removable devices in the boot
manager.

Best regards

Heinrich


>
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>> Thanks,
>>> Masahisa Kojima
>>>
>>>>
>>>> Best regards
>>>>
>>>> Heinrich
>>>>
>>>>>
>>>>> Thanks
>>>>> /Ilias
>>>>>>
>>>>>> Does the UEFI specification warrant this change?
>>>>>>
>>>>>> Best regards
>>>>>>
>>>>>> Heinrich
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>>>>>>> ---
>>>>>>> lib/efi_loader/efi_bootmgr.c | 86 ++++++++++++++++++++++++++------=
----
>>>>>>> 1 file changed, 63 insertions(+), 23 deletions(-)
>>>>>>>
>>>>>>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_boo=
tmgr.c
>>>>>>> index a40762c74c..c8cf1c5506 100644
>>>>>>> --- a/lib/efi_loader/efi_bootmgr.c
>>>>>>> +++ b/lib/efi_loader/efi_bootmgr.c
>>>>>>> @@ -355,40 +355,70 @@ error:
>>>>>>>     */
>>>>>>> static efi_status_t efi_bootmgr_enumerate_boot_option(struct efico=
nfig_media_boot_option *opt,
>>>>>>>                                                        efi_handle_=
t *volume_handles,
>>>>>>> -                                                    efi_status_t =
count)
>>>>>>> +                                                    efi_uintn_t *=
count)
>>>>>>> {
>>>>>>> -      u32 i;
>>>>>>> +      u32 i, num =3D 0;
>>>>>>>          struct efi_handler *handler;
>>>>>>>          efi_status_t ret =3D EFI_SUCCESS;
>>>>>>>
>>>>>>> -      for (i =3D 0; i < count; i++) {
>>>>>>> +      for (i =3D 0; i < *count; i++) {
>>>>>>>                  u16 *p;
>>>>>>>                  u16 dev_name[BOOTMENU_DEVICE_NAME_MAX];
>>>>>>>                  char *optional_data;
>>>>>>>                  struct efi_load_option lo;
>>>>>>>                  char buf[BOOTMENU_DEVICE_NAME_MAX];
>>>>>>> -              struct efi_device_path *device_path;
>>>>>>> +              struct efi_device_path *device_path, *full_path, *d=
p, *fp;
>>>>>>>                  struct efi_device_path *short_dp;
>>>>>>> +              struct efi_file_handle *root, *f;
>>>>>>> +              struct efi_simple_file_system_protocol *file_system=
;
>>>>>>> +              u16 *default_file_path =3D NULL;
>>>>>>>
>>>>>>> -              ret =3D efi_search_protocol(volume_handles[i], &efi=
_guid_device_path, &handler);
>>>>>>> +              ret =3D efi_search_protocol(volume_handles[i],
>>>>>>> +                                        &efi_guid_device_path, &h=
andler);
>>>>>>>                  if (ret !=3D EFI_SUCCESS)
>>>>>>>                          continue;
>>>>>>> -              ret =3D efi_protocol_open(handler, (void **)&device=
_path,
>>>>>>> -                                      efi_root, NULL, EFI_OPEN_PR=
OTOCOL_GET_PROTOCOL);
>>>>>>> +
>>>>>>> +              device_path =3D handler->protocol_interface;
>>>>>>> +              full_path =3D efi_dp_from_file(device_path,
>>>>>>> +                                           "/EFI/BOOT/" BOOTEFI_N=
AME);
>>>>>>> +
>>>>>>> +              /* check whether the partition or disk have the def=
ault file */
>>>>>>> +              ret =3D efi_dp_split_file_path(full_path, &dp, &fp)=
;
>>>>>>> +              if (ret !=3D EFI_SUCCESS || !fp)
>>>>>>> +                      goto next_entry;
>>>>>>> +
>>>>>>> +              default_file_path =3D efi_dp_str(fp);
>>>>>>> +              if (!default_file_path)
>>>>>>> +                      goto next_entry;
>>>>>>> +
>>>>>>> +              ret =3D efi_search_protocol(volume_handles[i],
>>>>>>> +                                        &efi_simple_file_system_p=
rotocol_guid,
>>>>>>> +                                        &handler);
>>>>>>>                  if (ret !=3D EFI_SUCCESS)
>>>>>>> -                      continue;
>>>>>>> +                      goto next_entry;
>>>>>>> +
>>>>>>> +              file_system =3D handler->protocol_interface;
>>>>>>> +              ret =3D EFI_CALL(file_system->open_volume(file_syst=
em, &root));
>>>>>>> +              if (ret !=3D EFI_SUCCESS)
>>>>>>> +                      goto next_entry;
>>>>>>> +
>>>>>>> +              ret =3D EFI_CALL(root->open(root, &f, default_file_=
path,
>>>>>>> +                                        EFI_FILE_MODE_READ, 0));
>>>>>>> +              if (ret !=3D EFI_SUCCESS)
>>>>>>> +                      goto next_entry;
>>>>>>> +
>>>>>>> +              EFI_CALL(f->close(f));
>>>>>>>
>>>>>>>                  ret =3D efi_disk_get_device_name(volume_handles[i=
], buf, BOOTMENU_DEVICE_NAME_MAX);
>>>>>>>                  if (ret !=3D EFI_SUCCESS)
>>>>>>> -                      continue;
>>>>>>> +                      goto next_entry;
>>>>>>>
>>>>>>>                  p =3D dev_name;
>>>>>>>                  utf8_utf16_strncpy(&p, buf, strlen(buf));
>>>>>>>
>>>>>>>                  /* prefer to short form device path */
>>>>>>> -              short_dp =3D efi_dp_shorten(device_path);
>>>>>>> -              if (short_dp)
>>>>>>> -                      device_path =3D short_dp;
>>>>>>> +              short_dp =3D efi_dp_shorten(full_path);
>>>>>>> +              device_path =3D short_dp ? short_dp : full_path;
>>>>>>>
>>>>>>>                  lo.label =3D dev_name;
>>>>>>>                  lo.attributes =3D LOAD_OPTION_ACTIVE;
>>>>>>> @@ -396,24 +426,35 @@ static efi_status_t efi_bootmgr_enumerate_bo=
ot_option(struct eficonfig_media_boo
>>>>>>>                  lo.file_path_length =3D efi_dp_size(device_path) =
+ sizeof(END);
>>>>>>>                  /*
>>>>>>>                   * Set the dedicated guid to optional_data, it is=
 used to identify
>>>>>>> -               * the boot option that automatically generated by =
the bootmenu.
>>>>>>> +               * the boot option that automatically generated by =
the efibootmgr.
>>>>>>>                   * efi_serialize_load_option() expects optional_d=
ata is null-terminated
>>>>>>>                   * utf8 string, so set the "1234567" string to al=
locate enough space
>>>>>>>                   * to store guid, instead of realloc the load_opt=
ion.
>>>>>>>                   */
>>>>>>>                  lo.optional_data =3D "1234567";
>>>>>>> -              opt[i].size =3D efi_serialize_load_option(&lo, (u8 =
**)&opt[i].lo);
>>>>>>> -              if (!opt[i].size) {
>>>>>>> -                      ret =3D EFI_OUT_OF_RESOURCES;
>>>>>>> -                      goto out;
>>>>>>> +              opt[num].size =3D efi_serialize_load_option(&lo, (u=
8 **)&opt[num].lo);
>>>>>>> +              if (!opt[num].size) {
>>>>>>> +                      efi_free_pool(full_path);
>>>>>>> +                      efi_free_pool(dp);
>>>>>>> +                      efi_free_pool(fp);
>>>>>>> +                      efi_free_pool(default_file_path);
>>>>>>> +                      return EFI_OUT_OF_RESOURCES;
>>>>>>>                  }
>>>>>>>                  /* set the guid */
>>>>>>> -              optional_data =3D (char *)opt[i].lo + (opt[i].size =
- u16_strsize(u"1234567"));
>>>>>>> +              optional_data =3D (char *)opt[num].lo + (opt[num].s=
ize - u16_strsize(u"1234567"));
>>>>>>>                  memcpy(optional_data, &efi_guid_bootmenu_auto_gen=
erated, sizeof(efi_guid_t));
>>>>>>> +              num++;
>>>>>>> +
>>>>>>> +next_entry:
>>>>>>> +              efi_free_pool(full_path);
>>>>>>> +              efi_free_pool(dp);
>>>>>>> +              efi_free_pool(fp);
>>>>>>> +              efi_free_pool(default_file_path);
>>>>>>>          }
>>>>>>>
>>>>>>> -out:
>>>>>>> -      return ret;
>>>>>>> +      *count =3D num;
>>>>>>> +
>>>>>>> +      return EFI_SUCCESS;
>>>>>>> }
>>>>>>>
>>>>>>> /**
>>>>>>> @@ -642,7 +683,7 @@ efi_status_t efi_bootmgr_delete_boot_option(u1=
6 boot_index)
>>>>>>>     * efi_bootmgr_update_media_device_boot_option() - generate the=
 media device boot option
>>>>>>>     *
>>>>>>>     * This function enumerates all devices supporting EFI_SIMPLE_F=
ILE_SYSTEM_PROTOCOL
>>>>>>> - * and generate the bootmenu entries.
>>>>>>> + * and create the boot option with default file if the file exist=
s.
>>>>>>>     * This function also provide the BOOT#### variable maintenance=
 for
>>>>>>>     * the media device entries.
>>>>>>>     * - Automatically create the BOOT#### variable for the newly d=
etected device,
>>>>>>> @@ -674,8 +715,7 @@ efi_status_t efi_bootmgr_update_media_device_b=
oot_option(void)
>>>>>>>                  goto out;
>>>>>>>          }
>>>>>>>
>>>>>>> -      /* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_=
PROTOCOL */
>>>>>>> -      ret =3D efi_bootmgr_enumerate_boot_option(opt, volume_handl=
es, count);
>>>>>>> +      ret =3D efi_bootmgr_enumerate_boot_option(opt, volume_handl=
es, &count);
>>>>>>>          if (ret !=3D EFI_SUCCESS)
>>>>>>>                  goto out;
>>>>>>>
>>>>
>>

