Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D8FCE79AC
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 08:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A02986AFA;
	Wed, 20 Sep 2023 10:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D2xX6KCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61F2386B10; Wed, 20 Sep 2023 10:14:35 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE59E86AEE
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 10:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-578b4981526so1205780a12.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695197671; x=1695802471; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzAOnsl4Qs5yUwYCOEOTQxj8ETOWpza7NsWK4otbvoQ=;
 b=D2xX6KCTNg+tLcSfhLjqD7de+GKQ5iV8z54M0EMt/UsIBwEOusIoffzfI0DH/+J+Kl
 WP2Lt21jQlFQ32hKpvFRXjz7uZ/1bmCMQ8HIJuwkKJoeWphodmYLp2T2R4XaeOK4Y9CB
 n6klmsl/ELbZkULOddtUBo2d5Zj3HQmeGQwiXFHufmKLY3xWsIE0IAY2zeo9iWqfXMxQ
 bAqgPk2BU///rMYH0ZgSeJ2eIw6/lKFjTsIHjuW/OKX2V6vCHRVp3HRRwWIFjR1st9ua
 kXoVP4rmbIfQVe1/Jwn21RiTr1/UfEHokpuYbgZvRCKPuSnjIP65VC2BWi1EW89e3WAv
 7M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695197671; x=1695802471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzAOnsl4Qs5yUwYCOEOTQxj8ETOWpza7NsWK4otbvoQ=;
 b=PCl7+/+1ouQSl+QpXBgrsmPEIgGsVPbDUBXUUrC4mfLlk6UMf50aFMcvLU9ukno9bL
 GUxpzhZGKnWg1qTDA38mpAnk9e/E1rrw/lMNQDNBsoQMsW54UWEmlQYBXOE9oLlM9npI
 CfUWqJPVM1oUzw9edzZ/Md6rlsX/cvkSfIOlguJOaddyNexweVYSBDphvkSXlxv2eDeo
 RusqakMm9j461y7SultG3q+Q6vKCsd2cE24WChXJMx9sYGCxAo1S5O30uBoPW2nHnmBH
 vvZtix54Up5w8l1tvOZTD9tcJD6txHVtEC5BcYSzdB7h85lHdj4KQBm7GghNHU2aOMsZ
 W2uQ==
X-Gm-Message-State: AOJu0YxNX6xA0omCzZ/7hi8w3iJIXbukKFHfikqwPAHNKO1LQaMgRs3X
 Y4STh3Gy9DgknJpwtx7ivhW8YVhs860ZtUAUDfIifg==
X-Google-Smtp-Source: AGHT+IHejbWoyOhScD5GU4NjSHpzPEfNJTtt2a22dlMOcJDuEUDPl15PQdgVpn7Q7d890MFOSqxW3Gzmo/XEF93a+gM=
X-Received: by 2002:a17:90a:8048:b0:26b:6095:bc3f with SMTP id
 e8-20020a17090a804800b0026b6095bc3fmr1786233pjw.33.1695197670641; Wed, 20 Sep
 2023 01:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230619212303.128288-1-raymond.mao@linaro.org>
 <20230619212303.128288-4-raymond.mao@linaro.org>
 <bc6db8a2-1e30-8707-8263-13f417b176dd@gmx.de>
 <4171409a-6da4-8075-4dd9-140adeb78f3b@gmx.de>
 <CAEfUkUJWj=+3gt=aTbenUUjkpRPpWPb_W6tNsyOVOcE9JENuBA@mail.gmail.com>
 <CADQ0-X9JaYxxT4ySmKiFs3xjA88wx-1iNxHQJ+ZZq7hwSL6=1g@mail.gmail.com>
 <91930fc5-d588-128d-6f83-f627e27bfd32@gmx.de>
 <CAEfUkULzueHM7nER3RcAJJEzNt16vOgpVfB3QJO+Kn3B9rtFSQ@mail.gmail.com>
In-Reply-To: <CAEfUkULzueHM7nER3RcAJJEzNt16vOgpVfB3QJO+Kn3B9rtFSQ@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Wed, 20 Sep 2023 17:14:19 +0900
Message-ID: <CADQ0-X-GDHr754Vp3+pKABpP4FBuYbSfZnx9pfQVVUtnerFDwQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] Boot var automatic management for removable medias
To: Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Raymond, Heinrich, Ilias,

On Wed, 19 Jul 2023 at 07:11, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Heinrich,
>
> I checkouted the 'origin/removable_medias' branch from the 'EFI U-Boot Cu=
stodian Tree'.
> Run the secureboot test suite on the sandbox locally by './test/py/test.p=
y --bd sandbox --build -k efi_secboot'.
> But there are no errors observed for 'test_signed.py'.
> Below is the output logs:
> ```
> ./test/py/test.py --bd sandbox --build -k efi_secboot
> +make O=3D/home/raymond/upstream/U-Boot-custodian/u-boot-efi/build-sandbo=
x -s sandbox_defconfig
> +make O=3D/home/raymond/upstream/U-Boot-custodian/u-boot-efi/build-sandbo=
x -s -j2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D test session starts =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> platform linux -- Python 3.10.9, pytest-6.2.5, py-1.10.0, pluggy-0.13.0
> rootdir: /home/raymond/upstream/U-Boot-custodian/u-boot-efi/test/py, conf=
igfile: pytest.ini
> plugins: xdist-2.5.0, forked-1.6.0
> collected 1147 items / 1128 deselected / 19 selected
>
> test/py/tests/test_efi_secboot/test_authvar.py .....                     =
                                                                           =
                                                [ 26%]
> test/py/tests/test_efi_secboot/test_signed.py ........                   =
                                                                           =
                                                [ 68%]
> test/py/tests/test_efi_secboot/test_signed_intca.py ...                  =
                                                                           =
                                                [ 84%]
> test/py/tests/test_efi_secboot/test_unsigned.py ...                      =
                                                                           =
                                                [100%]
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D 19 passed, 1128 deselected in 78.28s (0:01:18) =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ```
> Is it a pipeline issue? I didn't find a button to retrigger the failed jo=
bs. Do I have the permissions?
>
>
> The HEAD of my testing workspace is on:
> ```
> commit c88c134c29934654a696aef61ba63ff2c9a8481e (HEAD -> removable_medias=
, origin/removable_medias)
> Author: Raymond Mao <raymond.mao@linaro.org>
> Date:   Mon Jun 19 14:23:00 2023 -0700
>
>     Boot var automatic management for removable medias
> ```
> Same as the one for pipeline: https://source.denx.de/u-boot/custodians/u-=
boot-efi/-/pipelines/16948

I could reproduce the error on efi_secboot tests and find the cause.

The efi_secboot tests expect that BootOrder is not defined.
WIth this "Boot var automatic management for removable medias" patch,
BootOrder is added when the disk is detected.
In my testing, the BootOrder variable has two entries and the test ends up =
with
an unexpected failure since efibootmgr falls back to BootOrder when
loading from BootNext failed.

=3D=3D=3D
Loading from BootNext failed, falling back to BootOrder
Loading Boot0000 'mmc 1:1' failed
Loading Boot0001 'host 0:1' failed
efi_bootmgr_load() returned: 14
efi_start_image() returned: 2
=3D=3D=3D

I think we need to clear the BootOrder variable at the beginning of tests.
I will resend this patch with efi_secboot pytest modification.

Thanks,
Masahisa Kojima

>
> Thanks!
> Regards,
> Raymond
>
> On Tue, 18 Jul 2023 at 11:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> On 18.07.23 11:03, Masahisa Kojima wrote:
>> > Hi Raymond,
>> >
>> > On Tue, 18 Jul 2023 at 05:23, Raymond Mao <raymond.mao@linaro.org> wro=
te:
>> >>
>> >> Hi Heinrich,
>> >>
>> >> I run 'make tests' with the patches locally but no errors observed fr=
om 'test_signed.py', below are few lines from the output console:
>> >> ```
>> >> test/py/tests/test_efi_secboot/test_signed.py ssssssss               =
                                                                           =
                                                    [      90%]
>> >> ```
>> >
>> > I think the test cases are just skipped, not executed.
>> >
>> > I guess that some required packages are missing on the host machine,
>> > such as sbsigntool, efitools and libguestfs-tools.
>> > build-sandbox/test-log.html will help to analyze why the tests are ski=
pped.
>> >
>> > The following document describes prerequisites to run python tests.
>> > https://u-boot.readthedocs.io/en/latest/develop/py_testing.html
>> >
>> > 'make tests' runs many test cases and takes time.
>> > './test/py/test.py --bd sandbox --build -k efi_secboot' will run only
>> > the efi_secboot test
>> > and it will be useful for debugging purposes.
>> >
>> > Thanks,
>> > Masahisa Kojima
>>
>> To get more output describing why tests are skipped or fail use
>>
>>     export PYTEST_ADDOPTS=3D"-ra"
>>
>> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/16948
>> shows the errors with the suggested patch.
>>
>> Best regards
>>
>> Heinrich
>>
>> >
>> >
>> >>
>> >> Regards,
>> >> Raymond
>> >>
>> >> On Sat, 15 Jul 2023 at 05:19, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
>> >>>
>> >>> On 7/9/23 10:56, Heinrich Schuchardt wrote:
>> >>>> On 6/19/23 23:23, Raymond Mao wrote:
>> >>>>> Changes for complying to EFI spec =C2=A73.5.1.1
>> >>>>> 'Removable Media Boot Behavior'.
>> >>>>> Boot variables can be automatically generated during a removable
>> >>>>> media is probed. At the same time, unused boot variables will be
>> >>>>> detected and removed.
>> >>>>>
>> >>>>> Please note that currently the function 'efi_disk_remove' has no
>> >>>>> ability to distinguish below two scenarios
>> >>>>> a) Unplugging of a removable media under U-Boot
>> >>>>> b) U-Boot exiting and booting an OS
>> >>>>> Thus currently the boot variables management is not added into
>> >>>>> 'efi_disk_remove' to avoid boot options being added/erased
>> >>>>> repeatedly under scenario b) during power cycles
>> >>>>> See TODO comments under function 'efi_disk_remove' for more detail=
s
>> >>>>>
>> >>>>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> >>>>> ---
>> >>>>> Changes in v3
>> >>>>> - Split the patch into moving and renaming functions and
>> >>>>>     individual patches for each changed functionality
>> >>>>> Changes in v5
>> >>>>> - Move function call of efi_bootmgr_update_media_device_boot_optio=
n()
>> >>>>>     from efi_init_variables() to efi_init_obj_list()
>> >>>>> Changes in v6
>> >>>>> - Revert unrelated changes
>> >>>>> Changes in v7
>> >>>>> - adapt the return code of function
>> >>>>>     efi_bootmgr_update_media_device_boot_option()
>> >>>>> Changes in v8
>> >>>>> - add a note in the commit message for future reference
>> >>>>> Changes in v9
>> >>>>> - amend the note text in the commit message
>> >>>>> - add a TODO comment in 'efi_disk_remove'
>> >>>>> Changes in v10
>> >>>>> - fix typo and build failures with 'CONFIG_CMD_BOOTEFI_BOOTMGR=3Dn=
'
>> >>>>>
>> >>>>>    lib/efi_loader/efi_disk.c  | 18 ++++++++++++++++++
>> >>>>>    lib/efi_loader/efi_setup.c |  7 +++++++
>> >>>>>    2 files changed, 25 insertions(+)
>> >>>>>
>> >>>>> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
>> >>>>> index d2256713a8..911a4adfb1 100644
>> >>>>> --- a/lib/efi_loader/efi_disk.c
>> >>>>> +++ b/lib/efi_loader/efi_disk.c
>> >>>>> @@ -687,6 +687,13 @@ int efi_disk_probe(void *ctx, struct event *e=
vent)
>> >>>>>                return -1;
>> >>>>>        }
>> >>>>> +    /* only do the boot option management when UEFI sub-system is
>> >>>>> initialized */
>> >>>>> +    if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
>> >>>>> efi_obj_list_initialized =3D=3D EFI_SUCCESS) {
>> >>>>> +        ret =3D efi_bootmgr_update_media_device_boot_option();
>> >>>>> +        if (ret !=3D EFI_SUCCESS)
>> >>>>> +            return -1;
>> >>>>> +    }
>> >>>>> +
>> >>>>>        return 0;
>> >>>>>    }
>> >>>>> @@ -773,6 +780,17 @@ int efi_disk_remove(void *ctx, struct event *=
event)
>> >>>>>            return efi_disk_delete_part(dev);
>> >>>>>        else
>> >>>>>            return 0;
>> >>>>> +
>> >>>>> +    /*
>> >>>>> +     * TODO A flag to distinguish below 2 different scenarios of =
this
>> >>>>> +     * function call is needed:
>> >>>>> +     * a) Unplugging of a removable media under U-Boot
>> >>>>> +     * b) U-Boot exiting and booting an OS
>> >>>>> +     * In case of scenario a),
>> >>>>> efi_bootmgr_update_media_device_boot_option()
>> >>>>> +     * needs to be invoked here to update the boot options and re=
move
>> >>>>> the
>> >>>>> +     * unnecessary ones.
>> >>>>> +     */
>> >>>>
>> >>>> As in future we want to integrate more EFI drivers with the driver =
model
>> >>>> such a status should be in a global variable. It will have to be se=
t in
>> >>>> ExitBootServices() before invoking dm_remove_devices_flags().
>> >>>>
>> >>>> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> >>>>
>> >>>>> +
>> >>>>>    }
>> >>>>>    /**
>> >>>>> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup=
.c
>> >>>>> index 58d4e13402..69c8b27730 100644
>> >>>>> --- a/lib/efi_loader/efi_setup.c
>> >>>>> +++ b/lib/efi_loader/efi_setup.c
>> >>>>> @@ -245,6 +245,13 @@ efi_status_t efi_init_obj_list(void)
>> >>>>>        if (ret !=3D EFI_SUCCESS)
>> >>>>>            goto out;
>> >>>>> +    if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) {
>> >>>>> +        /* update boot option after variable service initialized =
*/
>> >>>>> +        ret =3D efi_bootmgr_update_media_device_boot_option();
>> >>>>> +        if (ret !=3D EFI_SUCCESS)
>> >>>>> +            goto out;
>> >>>>> +    }
>> >>>>> +
>> >>>>>        /* Define supported languages */
>> >>>>>        ret =3D efi_init_platform_lang();
>> >>>>>        if (ret !=3D EFI_SUCCESS)
>> >>>>
>> >>>
>> >>> This patch leads to a test failure in
>> >>>
>> >>> test/py/tests/test_efi_secboot/test_signed.py::TestEfiSignedImage::t=
est_efi_signed_image_auth2
>> >>>
>> >>> No EFI system partition
>> >>> Failed to persist EFI variables
>> >>>
>> >>> Please, run 'make tests' before resubmitting.
>> >>>
>> >>> Best regards
>> >>>
>> >>> Heinrich
>>
