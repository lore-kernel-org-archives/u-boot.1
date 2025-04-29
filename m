Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34167C369CB
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 07:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F2DC80EFB;
	Tue, 29 Apr 2025 09:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PIYXPgVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15CAD80FDA; Tue, 29 Apr 2025 09:04:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF96780BAD
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 09:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745910246; x=1746515046; i=xypron.glpk@gmx.de;
 bh=mSWEyNMtCcaKIgQ1JNdEQPTGnu5Gur5uqwgtz4mmtq0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PIYXPgVUF99+oFPVKqU04LpUA/VIdVemvqY7diYcc+IA7DnUQeioV32E0stVqMGM
 olpPQgz06uMaF9Usg1XOHWDgDuVQppZkPJMDJM11wNi3R+1RWDr2REmJnSh+I53jx
 2xcvsT9CC8NQunn9ctqPX+fZXAqPj8qhpGevifHUGtpE2s9RXjntTZN6e5zXpnDqf
 QX6IVXLLfVJ+kHgELyVsLCAXcaVljIgQZ8uPg2jBORYH6dGJ7CavR56cAG+86OcLl
 uvpXrAiUK+DaZCigr7rYxr2enUySqJr7469HyzTFCg3fIclAfS5hDytX8+deKV1ba
 t62wPbO2hOjt97oPvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.105.79]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1vD8ae2aII-00uMEY; Tue, 29
 Apr 2025 09:04:06 +0200
Message-ID: <2307cf95-6cb6-4c67-a6a8-ef33c9f52759@gmx.de>
Date: Tue, 29 Apr 2025 09:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] efi_loader: bootbin: do not load an initrd if none
 is provided
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250428145341.2091400-1-adriano.cordova@canonical.com>
 <20250428145341.2091400-2-adriano.cordova@canonical.com>
 <CAC_iWjKvcVOTx+1GiGwzfNGsciAa+jeAtvkLteaV01GWNAzWkw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKvcVOTx+1GiGwzfNGsciAa+jeAtvkLteaV01GWNAzWkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sqev5IOtNQ5A9whM7n4Qp3+xtBsoFmA2zqAOPsVfC2tj34B0Odj
 NciRF7TNoJuUYhNgPlR6miqU1S2sNwz/2DqL0wzS51AuAQIbDdhHxNT+kf5uY3FG+HqKSIG
 RrOPq7gkd5gDIy4SMIH3bSiE0dp2CXQmvYwy2s315bR4Xu3ye+URgXWb8zkcdlkLjWmfCDs
 vVcJEue0TY45nSZEp0cGQ==
UI-OutboundReport: notjunk:1;M01:P0:1AGeOqyUPWs=;Y6Z+s9dpJv2jLD05fR6G1h6lmeK
 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
 ++TPfS0kQ7uWI=
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

On 4/29/25 08:24, Ilias Apalodimas wrote:
> On Mon, 28 Apr 2025 at 17:53, Adriano Cordova <adrianox@gmail.com> wrote=
:
>>
>> Do not try to create an initrd device path nor try to register
>> an initrd with the EFI_LOAD_FILE2_PROTOCOL if none is provided.
>>
>> Handle initrd installation in efi_binary_run_dp with
>> efi_install_initrd, imitating what is done for the fdt.
>>
>> Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
>> Reported-by: Weizhao Ouyang <o451686892@gmail.com>
>> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
>> ---
>>   boot/bootm.c                 |  3 +++
>>   include/efi_loader.h         |  2 ++
>>   lib/efi_loader/efi_bootbin.c |  7 +------
>>   lib/efi_loader/efi_helper.c  | 29 +++++++++++++++++++++++++++++
>>   4 files changed, 35 insertions(+), 6 deletions(-)
>>
>> diff --git a/boot/bootm.c b/boot/bootm.c
>> index f5cbb10f0d1..9693e0d336d 100644
>> --- a/boot/bootm.c
>> +++ b/boot/bootm.c
>> @@ -1008,6 +1008,9 @@ int bootm_run_states(struct bootm_info *bmi, int =
states)
>>                          ret =3D 0;
>>          }
>>
>> +       /* Clear the initrd from a previous boot */
>> +       images->initrd_start =3D 0;

The bootm change should be in a different patch than the EFI change.

Bootm passes through multiple stages, see parameter states.

I don't believe that you want to zero images->initrd_start after the=20
BOOTM_STATE_RAMDISK state.

Specically you don't want to zero initrd_start in the BOOTM_STATE_OS_GO=20
state otherwise you will always boot without initrd.

Isn't initialization meant to happen for states =3D=3D BOOTM_STATE_START i=
n=20
bootm_start()?

In test/py/tests/test_efi_fit.py we currently only test the case without=
=20
initrd. We need a test with initrd too.

@Simon, @Tom,

We lack a documentation of the the different BOOTM_STATEs.
The documentation of the bootm command is incomplete, it does not=20
contain the subcommands.

Best regards

Heinrich

>> +
>>          /* Relocate the ramdisk */
>>   #ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
>>          if (!ret && (states & BOOTM_STATE_RAMDISK)) {
>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>> index 144b749278a..84e8cfe320e 100644
>> --- a/include/efi_loader.h
>> +++ b/include/efi_loader.h
>> @@ -597,6 +597,8 @@ efi_status_t efi_env_set_load_options(efi_handle_t =
handle, const char *env_var,
>>   void *efi_get_configuration_table(const efi_guid_t *guid);
>>   /* Install device tree */
>>   efi_status_t efi_install_fdt(void *fdt);
>> +/* Install initrd */
>> +efi_status_t efi_install_initrd(void *initrd, size_t initd_sz);
>>   /* Execute loaded UEFI image */
>>   efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)=
;
>>   /* Run loaded UEFI image with given fdt */
>> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.=
c
>> index d0f7da309ce..6a189c31ffa 100644
>> --- a/lib/efi_loader/efi_bootbin.c
>> +++ b/lib/efi_loader/efi_bootbin.c
>> @@ -220,7 +220,6 @@ static efi_status_t efi_binary_run_dp(void *image, =
size_t size, void *fdt,
>>                                        struct efi_device_path *dp_img)
>>   {
>>          efi_status_t ret;
>> -       struct efi_device_path *dp_initrd;
>>
>>          /* Initialize EFI drivers */
>>          ret =3D efi_init_obj_list();
>> @@ -234,11 +233,7 @@ static efi_status_t efi_binary_run_dp(void *image,=
 size_t size, void *fdt,
>>          if (ret !=3D EFI_SUCCESS)
>>                  return ret;
>>
>> -       dp_initrd =3D efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initr=
d, initd_sz);
>> -       if (!dp_initrd)
>> -               return EFI_OUT_OF_RESOURCES;
>> -
>> -       ret =3D efi_initrd_register(dp_initrd);
>> +       ret =3D efi_install_initrd(initrd, initd_sz);
>>          if (ret !=3D EFI_SUCCESS)
>>                  return ret;
>>
>> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
>> index 3936139ca41..19fb5d03fec 100644
>> --- a/lib/efi_loader/efi_helper.c
>> +++ b/lib/efi_loader/efi_helper.c
>> @@ -622,6 +622,35 @@ efi_status_t efi_install_fdt(void *fdt)
>>          return EFI_SUCCESS;
>>   }
>>
>> +/**
>> + * efi_install_initrd() - install initrd
>> + *
>> + * Install the initrd located at @initrd using the EFI_LOAD_FILE2
>> + * protocol.
>> + *
>> + * @initrd:    address of initrd or NULL if none is provided
>> + * @initrd_sz: size of initrd
>> + * Return:     status code
>> + */
>> +efi_status_t efi_install_initrd(void *initrd, size_t initd_sz)
>> +{
>> +       efi_status_t ret;
>> +       struct efi_device_path *dp_initrd;
>> +
>> +       if (!initrd)
>> +               return EFI_SUCCESS;
>> +
>> +       dp_initrd =3D efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initr=
d, initd_sz);
>> +       if (!dp_initrd)
>> +               return EFI_OUT_OF_RESOURCES;
>> +
>> +       ret =3D efi_initrd_register(dp_initrd);
>> +       if (ret !=3D EFI_SUCCESS)
>> +               efi_free_pool(dp_initrd);
>> +
>> +       return ret;
>> +}
>> +
>>   /**
>>    * do_bootefi_exec() - execute EFI binary
>>    *
>> --
>> 2.48.1
>>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

