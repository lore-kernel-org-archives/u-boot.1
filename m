Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9987C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 08:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649FF87D70;
	Mon,  8 Apr 2024 10:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oZrE6++N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1372B87DCA; Mon,  8 Apr 2024 10:29:59 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95F0E877AF
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 10:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712564980; x=1713169780; i=xypron.glpk@gmx.de;
 bh=3q9T/1q0L2hXwdppikYXOfys1qt8oPhA8Ojx/vTqxxQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=oZrE6++NkXzpNRlI6NUCgz827jgK2poFDF8ImPXKBKBYwQz6B+2hbejnoGEzyJQb
 HkzGdyGWQvb7Qp7wCWeYgqXLEDutbeQO9/l7hL2XJCrCXgRARLV8O/rMXno88NGzd
 JSVnqnXKadab4ZfSE5iR2baImwuwpJ+tK1NeUHx9za6MSK/WvIHs1r4RfR44hmEuU
 eATSlSDw5hAONpEFZkeuuzqe+GE0fZ2u3p3O2r6CPFQtGvvz7bT55MK92McGc0dPU
 KSRQ1FuiPzhJZWOPrSP8qL3sqPlw2N2PkDH1yx7riQIcIBRn8FHaiqhIZtVHoPcRD
 POt5zFyY3AOWUWWBjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKFu-1s1xZp3nIQ-009NkO; Mon, 08
 Apr 2024 10:29:40 +0200
Message-ID: <2b8595fd-334c-4045-b80d-3980a0646812@gmx.de>
Date: Mon, 8 Apr 2024 10:29:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] efi_loader: add an EFI variable with the variable
 file contents
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Bin Meng <bmeng@tinylab.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Weizhao Ouyang
 <o451686892@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 u-boot@lists.denx.de, kettenis@openbsd.org
References: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
 <20240406140203.248211-4-ilias.apalodimas@linaro.org>
 <6c399b8c-f5f8-4b1b-a74a-0de72ef9002e@gmx.de>
 <CAC_iWj+epdSKG-ZfRc5SfUevMhe6NyaC6cgSJK2KcqiZs=r0fw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWj+epdSKG-ZfRc5SfUevMhe6NyaC6cgSJK2KcqiZs=r0fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DWWhuTZ7LBU4EGNOSJJGgLos+96chYRVf/AZTr4jhSXMH9MpF2O
 shIHAjpwzFfxJYqxVXMvjcujs0aOHuix1xTMeNO3LrZ+z7mvG69RuGT8zVYHlZBqYN+K+EU
 DvfExNNNi5pIflcNdu5qqyyz168zXu3EC3lD0bFBt0q/iR6lCeUqWB69BqgjlYyPC+Y8i9k
 9TFAuvL+4HgjeQxdB8VTA==
UI-OutboundReport: notjunk:1;M01:P0:fseeSlyA7Lw=;ZnuVG9c3aHVqsn4s6ToxmwyMsx/
 W0wWDH4GtQVhdPKUNHeL8g9rz2LF3VyNLo8AfXsO1tKK3Ra0OKo3eBp0L1USRNSB6rlV0mbln
 CiqsrbDo+3K0OuYGBOW1opiLkTN0GWaUEj89RLpgq2RrSPvqVwLSEZurb1z+HTnSnc4P8yVim
 JShuYD0I8+Wgo3cGHh1WZMGupRffAc7Hx4BC5iMwV4PVZvWD7W1C+ILlMPyE9vEFNCrcIPXdv
 ZYhEeLgOYXwsmOvXtFycEGmLY2FNbMDl2VAKZhP1Fkdr98IVcK9+30Ol7Ap5i8cQ+Lam6QTJn
 0O4u5IsDlRMDAM7s/0StfJ9i+hD6t+U3soWGsvwOzNEVWzOU2sATyW8JmWvYvzLqL0tmjt6eC
 wVrnvWFywimVcuPUgEbSYSiC5mpdNrikkWPUWPN73f6bP1D6Ws57C9nCvW16QcKOxZL4YfpZj
 UKmzq/pc601JRzKlEGxoxsKVOVrxs+zTdxNPTeasBvFQdsWLHz5/StuIh4MvR4R3PR4UrAv6/
 A5bWgbsdCh19P05WAlETnVm8MyGcRfrzaKvl7fDTkYQ7gWSmeVaHI90s0kpogk0fQTVLHtW3k
 Xhsm10Kwi9Eh7ghOd0bpMqZ4FVJeqLwdgGVhC1KCGJ03QJHBHtTfMaYJddg6+BktX4T7ue/YQ
 Oed1n+Ph3CCViP5IwGIpqAGDaKFMyDUO1Xew7KY+erRhzG+DvYwd0vEukCK+hqmjIo1v+BIFE
 kSg8NXvvP0UBJzuuPOvZO2uMWzWl7y49IAxy0dX0CtXpgw2txgzc961DrDrZPrEByuioXQ+g7
 faqjJj3IpSQRBhGHU6z0EU8GnfbD0gwP3KcIL0hoZdYos=
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

On 4/8/24 10:12, Ilias Apalodimas wrote:
> Hi Heinrich
>
> On Mon, 8 Apr 2024 at 09:41, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> On 4/6/24 16:01, Ilias Apalodimas wrote:
>>> Previous patches enabled SetVariableRT using a RAM backend.
>>> Although EBBR [0] defines a variable format we can teach userspace too=
ls
>>> and write the altered variables, it's better if we skip the ABI
>>> requirements completely.
>>>
>>> So let's add a new variable, in its own namespace called "VarToFile"
>>> which contains a binary dump of the updated RT, BS and, NV variables.
>>>
>>> Some adjustments are needed to do that. Currently we discard BS-only
>>> variables in EBS(). We need to preserve those on the OS RAM backend
>>> that exposes the variables. Since BS-only variables can't appear at RT
>>> we need to move the memory masking checks from efi_var_collect() to
>>> efi_get_next_variable_name_mem()/efi_get_variable_mem() and do the
>>> filtering at runtime. We also need to make efi_var_collect() available
>>> at runtime, in order to construct the "VarToFile" buffer with BS, RT &
>>> NV variables.
>>>
>>> All users and applications (for linux) have to do when updating a vari=
able
>>> is dd that variable in the file described by "RTStorageVolatile".
>>>
>>> Linux efivarfs uses a first 4 bytes of the output to represent attribu=
tes
>>> in little-endian format. So, storing variables works like this:
>>>
>>> $~ efibootmgr -n 0001
>>> $~ dd if=3D/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac=
-11e818c3130c of=3D/boot/efi/ubootefi.var skip=3D4 bs=3D1
>>>
>>> [0] https://arm-software.github.io/ebbr/index.html#document-chapter5-v=
ariable-storage
>>
>> This change actually doubles the amount of memory needed to store a
>> variable at runtime. How do you reflect this in QueryVariableInfo()?
>>
>
> It doesn't double it. Only BS, RT, NV variables are added to VarToFile.
> QueryVariableInfo isn't supported at runtime, but with the current
> code we have at boot time the VarToFile would be included in the
> calculations.

VarToFile does not exist at boot time. Nothing stops the user from
writing NV variables to fill up the memory buffer. VarToFile will be as
large as the sum of NV variables and will not fit into the buffer when
efi_variables_boot_exit_notify() is invoked.

>
>>>
>>> Suggested-by:Ard Biesheuvel <ardb@kernel.org> # dumping all variables =
to a variable
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> ---
>>>    include/efi_variable.h            |  15 +++-
>>>    lib/efi_loader/efi_boottime.c     |   2 +
>>>    lib/efi_loader/efi_var_common.c   |  43 +++++------
>>>    lib/efi_loader/efi_var_file.c     |   1 -
>>>    lib/efi_loader/efi_var_mem.c      |  90 ++++++++++-------------
>>>    lib/efi_loader/efi_variable.c     | 118 ++++++++++++++++++++++++---=
---
>
> [...]
>
>>>     * @data:           buffer to which the variable value is copied
>>>     * @timep:          authentication time (seconds since start of epo=
ch)
>>> + * @mask:            bitmask with required attributes of variables to=
 be collected.
>>> + *                      variables are only collected if all of the re=
quired
>>
>> This line looks incomplete.
>
> Yes, fixed
>
>>
>>>     * Return:          status code
>>>     */
>>>    efi_status_t __efi_runtime
>>>    efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *ve=
ndor,
>>>                     u32 *attributes, efi_uintn_t *data_size, void *dat=
a,
>>> -                  u64 *timep);
>>> +                  u64 *timep, u32 mask);
>>>
>>>    /**
>
> [...]
>
>>>        return EFI_UNSUPPORTED;
>>> @@ -557,11 +593,11 @@ void efi_variables_boot_exit_notify(void)
>>>        const efi_guid_t efi_guid_efi_rt_var_file =3D U_BOOT_EFI_RT_VAR=
_FILE_GUID;
>>>        const efi_guid_t rt_prop_guid =3D EFI_RT_PROPERTIES_TABLE_GUID;
>>>        efi_status_t ret;
>>> +     struct efi_var_file *buf;
>>> +     loff_t len;
>>> +     bool fail =3D false;
>>>
>>>        if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
>>> -             struct efi_rt_properties_table *rt_prop =3D
>>> -                     efi_get_configuration_table(&rt_prop_guid);
>>> -
>>>                ret =3D efi_set_variable_int(u"RTStorageVolatile",
>>>                                           &efi_guid_efi_rt_var_file,
>>>                                           EFI_VARIABLE_BOOTSERVICE_ACC=
ESS |
>>> @@ -569,11 +605,47 @@ void efi_variables_boot_exit_notify(void)
>>>                                           EFI_VARIABLE_READ_ONLY,
>>>                                           sizeof(EFI_VAR_FILE_NAME),
>>>                                           EFI_VAR_FILE_NAME, false);
>>> +             if (ret !=3D EFI_SUCCESS) {
>>> +                     fail =3D true;
>>> +                     goto out;
>>> +             }
>>> +
>>> +             ret =3D efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOL=
ATILE);
>>> +             if (ret !=3D EFI_SUCCESS) {
>>> +                     fail =3D true;
>>> +                     goto out;
>>> +             }
>>> +
>>> +             ret =3D efi_set_variable_int(u"VarToFile",
>>> +                                        &efi_guid_efi_rt_var_file,
>>> +                                        EFI_VARIABLE_BOOTSERVICE_ACCE=
SS |
>>> +                                        EFI_VARIABLE_RUNTIME_ACCESS,
>>> +                                        len,
>>> +                                        buf, false);
>>>                if (ret !=3D EFI_SUCCESS)
>>> -                     rt_prop->runtime_services_supported |=3D ~EFI_RT=
_SUPPORTED_SET_VARIABLE;
>>> -             else
>>> -                     log_err("Can't RTStorage. SetVariableRT won't be=
 available\n");
>>> +                     fail =3D true;
>>> +out:
>>> +             if (fail) {
>>> +                     efi_set_variable_int(u"RTStorageVolatile",
>>> +                                          &efi_guid_efi_rt_var_file,
>>> +                                          EFI_VARIABLE_BOOTSERVICE_AC=
CESS |
>>> +                                          EFI_VARIABLE_RUNTIME_ACCESS=
 |
>>> +                                          EFI_VARIABLE_READ_ONLY, 0, =
0,
>>> +                                          false);
>>
>> Not providing VarToFile because the memory buffer is more than half
>> filled before ExitBootServices() is unexpected behavior. This needs rew=
ork.
>
> Why? We should add the SetVariable at runtime to the documentation.

Depending on the number of variables existing at boot time support you
will be creating VarToFile or not. I can't see that users will fancy this.

Best regards

Heinrich

>
>>
>> It is not necessary to create VarToFile in the internal memory buffer.
>> You could generate it when the user calls GetVariable() in the user
>> provided buffer.
>
> Yes, but that would make some functions look a bit messier, since we
> have to inject code specifically looking for VarToFile.
> OTOH it would make SetVariable at runtime easier to read since all the
> size calculations and variable creation would go away.
> But in any case, we have to add the variable at runtime (perhaps with
> a value of 0?) -- users need to know it's there to be able to read it.
> But if you are fine with the special conditions in GetVariable at
> runtime, I can easily move the logic to GetVariable.
>
> Thanks
> /Ilias
>
>>
>> Best regards
>>
>> Heinrich
>>
>>> +                     efi_set_variable_int(u"VarToFile",
>>> +                                          &efi_guid_efi_rt_var_file,
>>> +                                          EFI_VARIABLE_BOOTSERVICE_AC=
CESS |
>>> +                                          EFI_VARIABLE_RUNTIME_ACCESS=
, 0, 0,
>>> +                                          false);
>>> +             } else {
>>> +                     struct efi_rt_properties_table *rt_prop =3D
>>> +                             efi_get_configuration_table(&rt_prop_gui=
d);
>>> +
>>> +                     rt_prop->runtime_services_supported |=3D
>>> +                                     EFI_RT_SUPPORTED_SET_VARIABLE;
>>> +             }
>>>        }
>>> +
>>>        /* Switch variable services functions to runtime version */
>>>        efi_runtime_services.get_variable =3D efi_get_variable_runtime;
>>>        efi_runtime_services.get_next_variable_name =3D
>>> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_va=
riable_tee.c
>>> index dde135fd9f81..9d0e270591ea 100644
>>> --- a/lib/efi_loader/efi_variable_tee.c
>>> +++ b/lib/efi_loader/efi_variable_tee.c
>>> @@ -969,7 +969,6 @@ void efi_variables_boot_exit_notify(void)
>>>                log_err("Can't populate EFI variables. No runtime varia=
bles will be available\n");
>>>        else
>>>                efi_var_buf_update(var_buf);
>>> -     free(var_buf);
>>>
>>>        /* Update runtime service table */
>>>        efi_runtime_services.query_variable_info =3D
>>> --
>>> 2.37.2
>>>
>>

