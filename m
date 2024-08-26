Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BF7C5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 18:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80F50886A7;
	Mon, 26 Aug 2024 20:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="m9ZSqZbP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC2A88A7B; Mon, 26 Aug 2024 20:16:50 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5630D88210
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 20:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1724696206; x=1725301006; i=xypron.glpk@gmx.de;
 bh=FpEfLbu0lqOzUJ8FuTfXhQILDIivXjqyy/yuk5J/bjU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=m9ZSqZbPawKg+OgxrAYtn1vdExCcNq7+j4L4GT+k72j+mkWxIMSOTc4GP2EjKCpl
 zP94TOWcmFBI3uUNxrakxLGe7rqjUiDYpKNKxMGhXed/6wXPT99AU+JYSiHUCMXX5
 izSsyPL9ULIgL8cJkOuHNS+rPh6bS4YvDxMkfeIiOGJJp1Tjctu2na1Yy7Cayk5Qb
 A9gGNtOTaEYulGqEeI2Lc9VpsBW20xSN0xc4VxM32qVsOBGs57AvB1hXuGUVKJare
 3LodQq1Q/pU+ddrWClzx3nQ09S3dTxIOCLe4heAu5AiCvn5iercpNen0TiUv/zsrL
 KZOCdLm7APW02b0Gig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.229.134]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNpH-1sF7wp2ZoL-00ntrr; Mon, 26
 Aug 2024 20:16:46 +0200
Message-ID: <ba46d2c2-38ac-411a-a48c-429295cf6efb@gmx.de>
Date: Mon, 26 Aug 2024 20:16:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/14] efi_loader: Disable ANSI output for tests
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-11-sjg@chromium.org>
 <CAC_iWjJARSNuFRE4x85fNMkT68NnB74bCZe6ryKm2Rp5axTJEg@mail.gmail.com>
 <CAFLszTjwstB4PdPR4Rf0FpJDJuSQkSw=9-nZTkSNedLv5iaKyg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTjwstB4PdPR4Rf0FpJDJuSQkSw=9-nZTkSNedLv5iaKyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bkW4fMJPlXwHErrbhy5zgjJmAHTCXHCuPVngDh1AyrqUzEMAtju
 NPfl7/vJzEUXovCqpK0kjPafh344Fe3jVm8Aor0WlQ/iIza81sx8Btdp70nWJxUvqEPA7W2
 r8H4k92BoeYKZgYOndUZVZr5NQcHwIXf6724+sxyK63t/tkmvBEMTHXTFwH/624qQjHy8j0
 zZUbktgdReC1m3/+xejqQ==
UI-OutboundReport: notjunk:1;M01:P0:cMbPYV/yTz8=;WF+haazfS8Oa+GhzQzMU5Q6RKk0
 FD16V01SxqJLWyZMV95OSVK4QyoOnh6EdQEuUUhpGUFJgjKihB0G2CFP6FpF3fVm8Hm3GPTBq
 LQdh7U/ZR8dgGP2sxOZ6vMJOzi1yI0U8H42mz8/vDIUfHnA/+DPbiEhQ5OPeKLnqPSHbZRKXp
 H5KQHUOLIgknFtVG1YQDhjQq6YBKAKFImuWrQgIpjZjU+K84nBagwViNnZWtGVtKUYbfvrghp
 UJPUiVxZRWopzASlVHTTjLFROyHIj6A2tXN3G1diTHLXHQVK7Mh5Q/m1BYDap2Tvq6XHOqttR
 VKaxpGVHjchUT5ydxyoJuxmO/WRkW4bBoZRyE/phbhPamcIoo5B2S5F5sS8SyuP3psLOKt2Mb
 mFri5JqehcduGD3SxD/wrI1OpxMKitK7cEkqvskKOVLg/A8L+X22KCrNaGC6FQJIK07ju3400
 QpLTf2fsVXVWWz2/6Q3Q/nkBGvHUK5FlY4reBkHKdDpx9zJ17jL1JwqE0bPzCzPurwZyk5uz9
 GCr2YQDH+iskdDLq2qmWQqJuChlmBr+fNNnaPXvWPUODf6h1N/qtSSWsF1FcgkcQtBlLV/52d
 vr1TAA3TT3jIjuXAiC52dksJMiEQIf7esPnSJyCdHCwmFblQdhaWVYCC33e5bDyP/aVsFLfSc
 tNdoISw6hwXgACZ7gGQevGDPTSrv5+SSYfrCBTqYLvvTP9H7Jpj1q+D3NhqC9MJrTUQPVKWA+
 Ery3zpjfuY+WSX9DAl4ZRwYFQuIQVgsKP6I+C+UCo3Itu2PDrjKliO/ptaHa+nZioEIwcz4rM
 p5dvEaaFQdBn3jz1JOiMTgYj8W5IthxddHKFT+fOuli4Y=
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

On 8/26/24 19:57, Simon Glass wrote:
> Hi Ilias,
>
> On Mon, 26 Aug 2024 at 05:47, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On Thu, 15 Aug 2024 at 23:24, Simon Glass <sjg@chromium.org> wrote:
>>>
>>> We don't want ANSI characters written in tests since it is a pain to
>>> check the output with ut_assert_nextline() et al.
>>>
>>> Provide a way to tests to request that ANSI characters not be sent.
>>>
>>> Add a proper function comment while we are here, to encourage others.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>   include/efi_loader.h         | 21 ++++++++++++++++++++-
>>>   lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
>>>   2 files changed, 37 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>>> index f84852e384f..82b90ee0f1d 100644
>>> --- a/include/efi_loader.h
>>> +++ b/include/efi_loader.h
>>> @@ -531,8 +531,27 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 b=
oot_index);
>>>   efi_status_t efi_bootmgr_run(void *fdt);
>>>   /* search the boot option index in BootOrder */
>>>   bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 targe=
t, u32 *index);
>>> -/* Set up console modes */
>>> +
>>> +/**
>>> + * efi_setup_console_size() - update the mode table.
>>> + *
>>> + * By default the only mode available is 80x25. If the console has at=
 least 50
>>> + * lines, enable mode 80x50. If we can query the console size and it =
is neither
>>> + * 80x25 nor 80x50, set it as an additional mode.
>>> + */
>>>   void efi_setup_console_size(void);
>>> +
>>> +/**
>>> + * efi_console_set_ansi() - Set whether ANSI characters should be emi=
tted
>>> + *
>>> + * These characters mess up tests which use ut_assert_nextline(). Cal=
l this
>>> + * function to tell efi_loader not to emit these characters when star=
ting up the
>>> + * terminal
>>> + *
>>> + * @allow_ansi: Allow emitting ANSI characters
>>> + */
>>> +void efi_console_set_ansi(bool allow_ansi);
>>> +
>>>   /* Set up load options from environment variable */
>>>   efi_status_t efi_env_set_load_options(efi_handle_t handle, const cha=
r *env_var,
>>>                                        u16 **load_options);
>>> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console=
.c
>>> index cea50c748aa..569fc9199bc 100644
>>> --- a/lib/efi_loader/efi_console.c
>>> +++ b/lib/efi_loader/efi_console.c
>>> @@ -30,6 +30,17 @@ struct cout_mode {
>>>
>>>   __maybe_unused static struct efi_object uart_obj;
>>>
>>> +/*
>>> + * suppress emission of ANSI codes for use by unit tests. Leave it as=
 0 for the
>>> + * default behaviour
>>> + */
>>> +static bool no_ansi;
>>> +
>>> +void efi_console_set_ansi(bool allow_ansi)
>>> +{
>>> +       no_ansi =3D !allow_ansi;
>>> +}
>>> +
>>>   static struct cout_mode efi_cout_modes[] =3D {
>>>          /* EFI Mode 0 is 80x25 and always present */
>>>          {
>>> @@ -348,13 +359,6 @@ static int __maybe_unused query_vidconsole(int *r=
ows, int *cols)
>>>          return 0;
>>>   }
>>>
>>> -/**
>>> - * efi_setup_console_size() - update the mode table.
>>> - *
>>> - * By default the only mode available is 80x25. If the console has at=
 least 50
>>> - * lines, enable mode 80x50. If we can query the console size and it =
is neither
>>> - * 80x25 nor 80x50, set it as an additional mode.
>>> - */
>>>   void efi_setup_console_size(void)
>>>   {
>>>          int rows =3D 25, cols =3D 80;
>>> @@ -362,8 +366,12 @@ void efi_setup_console_size(void)
>>>
>>>          if (IS_ENABLED(CONFIG_VIDEO))
>>>                  ret =3D query_vidconsole(&rows, &cols);
>>> -       if (ret)
>>> -               ret =3D query_console_serial(&rows, &cols);
>>> +       if (ret) {
>>> +               if (no_ansi)
>>
>> What are you trying to do here? The function you are skipping just
>> queries the number of columns and rows. The defaults on the function
>> are 80x25, so the setup will continue
>
> Well, the query works by sending out some ANSI characters to the
> terminal, then checking the result. In a unit test, these characters
> are captured and the unit test fails when ut_assert_nextline() gets
> unexpected output.

We should be able to compile U-Boot with all tests enabled such that it
is still usable on real hardware.

Your patch is not compatible with this.

Please, adjust readline_check() to strip out non-printing ANSI codes.

Best regards

Heinrich

>
>>
>> Thanks
>> /Ilias
>>> +                       ret =3D 0;
>>> +               else
>>> +                       ret =3D query_console_serial(&rows, &cols);
>>> +       }
>>>          if (ret)
>>>                  return;
>>>
>>> --
>>> 2.34.1
>>>
>
> Regards,
> Simon

