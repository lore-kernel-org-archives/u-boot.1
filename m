Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6DAC83F0C
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 02:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6CD86B03;
	Sat, 26 Aug 2023 04:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CM575ndX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAF3086B19; Sat, 26 Aug 2023 04:20:33 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5A7686AF8
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 04:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693016429; x=1693621229; i=xypron.glpk@gmx.de;
 bh=eVqcpclQxoedlC5fPpGEwesFVgEg3NlnoPNYWRuVM4w=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
 b=CM575ndXoyqDDBKTvFlyj/40f5lalxch4UlVM1grC/3PS3hX7n9AWQY8PZ/ORNHLrk4OwCp
 z9yO9U/rlDN2Y/vkuBYm3XEjWSDwShgDWsDwCVX2qypKquEtZmw25/G9n2kyt85u8aX5dwQ+n
 Xab36EIZ7ZxDiGdsMnt2Io0zJIcDOxwatLU8XOg0K/KFVgEs4Cji9fbv3ZMPC5QC2F9i4aa0i
 d113mdQTn0E9IbeQcfvkER9lIiq6Z5IDFsKqwxSLMYCqMq5F4NR6xdXdLGEv0wTtIOEruEx0L
 ROXbg5i1EF7l7Wa91hQR0Iku52/ftfP/ovows7eJbbtwE/BS3C0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9MpS-1pfgPR2Su4-015Gck; Sat, 26
 Aug 2023 04:20:29 +0200
Message-ID: <d03a441a-a7a9-f6f8-5eb1-36ed5924d70b@gmx.de>
Date: Sat, 26 Aug 2023 04:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] cmd: efidebug: add uri device path
Content-Language: en-US, de-DE
To: Masahisa Kojima <masahisa.kojima@linaro.org>
References: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
 <20230823083721.1318097-2-masahisa.kojima@linaro.org>
 <ZOagOlRLw8cOsFM7@octopus>
 <CADQ0-X_3KeWE72jO2ymiCgE-_uU8URBsQVHGryi_41O7oqXYUg@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <CADQ0-X_3KeWE72jO2ymiCgE-_uU8URBsQVHGryi_41O7oqXYUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HYv5AR6naoOthTIBApIEb0YmL8G64BOjnrPQpQSi7bgKJ2oKJLG
 tlRsEqsyhlQu24d9r47IQT9dqiqmJdhl7LNV+L9rhK81mFHbxND9/I5qucwp1JznqJ7XIh7
 PpIavfSWzOcpEADOUU0RhcCYOC6YZ8CWrZHpo5Fc82oImzaMtnsgJpEkryqC9pNXC8CGhFw
 NU1qBcA4iNVl8NAziBJ4A==
UI-OutboundReport: notjunk:1;M01:P0:WC+5wHnu7XA=;KmwzFHr8wExKGKbnuNSzTiU4tMk
 0oC8L3mU2JT3onzuPJ6MIoKV1ZW1gYyIE4KSv05A60LSrI0iJ+V0o7xo7tb1cKGBFzS3dUS8e
 Z0L7acVmn4TK4AU3R/jdZb+7D2VKNcwdUNi8poMwy1rnxjfaAc/yosZ/eBWOWTzjd8SlxWpja
 zQl9MPI5iM+GqdPkwkjwF6aXLjwHJUjHKPJJXK+NfJTqKiyEpUzsFYTGaugK0N+gAzsbHWXg1
 p1an9ywiol1SCD7pg230SNRF0tOpr5o1UUWY2m4D6DvuzG0bz9udEprnTPFM/i9Wt7DyiNbBT
 w+OAAduwadZsaYt+dmDsoO9p43zdc6hFKlu/Tr40ZqpaEq6fL3nb0af0vUssw8Xz/kjONP47O
 yimvs7JI3xYEUEVO3h5jTpZAl3plyQvgOOm/iQTqt2oLqCJkuYDVJPkg7PaXMT17CtbRsKeQb
 PwcgKUm7Wsg2cUAOfCAqOeT8slAvOrhwKuTudp3D/4vMl3vmJL8iEqAGDmeg4nEW5ejHH31UU
 tcc1lKu40exAIuBXuj0MibznOi5qHcEzDvBCc2Ky9xiyRP9Z1QsHu/i2FCU4KxbqDhIPp6zAt
 /0t5twMVeb2uBTr0Qtaf+wbyZBY/sgVZQF9OKC5LrDZlROzqJ3CURgzte8jXWJvH4XkKc7FWG
 t/JNiU7FZkBoU6F89lM9aY1BMdPciUaRHNufTZ9mb0jbAcX8+ztHWVv1Vu92fANeDeER302tP
 erPAZsyaCxb1I4HAKKQKIhQW+Qkbu7F+B06QWpTyZclQQWcNMRqlY59qaaL4nIvEkmOXXggVL
 X91wi7E0TgxzAbbXEp72QjMsfUX96uXuh/uqMqJIaMo58a+Eg0ly6jUqGsuSQDJQQZAXHn9Vs
 nmfA/pZk895KU3fzlXvByUdcfO0ZbkxtTDcx6gRbnDkdPKLrQebfK5fi/y3lnprF7lwJZSlXU
 aEsfFgXbYJ9Qdy1qf7Ariduicg4=
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

On 8/25/23 07:57, Masahisa Kojima wrote:
> On Thu, 24 Aug 2023 at 09:11, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
>>
>> Hi Kojima-san,
>>
>> On Wed, Aug 23, 2023 at 05:37:19PM +0900, Masahisa Kojima wrote:
>>> This adds the URI device path option for 'boot add' subcommand.
>>> User can add the URI load option for downloading ISO image file
>>> or EFI application through network(e.g. HTTP).
>>>
>>> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>>> ---
>>>   cmd/efidebug.c | 39 +++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 39 insertions(+)
>>>
>>> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
>>> index 0be3af3e76..62f867df2a 100644
>>> --- a/cmd/efidebug.c
>>> +++ b/cmd/efidebug.c
>>> @@ -829,6 +829,44 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp,=
 int flag,
>>>                        argc -=3D 1;
>>>                        argv +=3D 1;
>>>                        break;
>>> +             case 'u':
>>> +             {
>>> +                     char *pos;
>>> +                     int uridp_len;
>>> +                     struct efi_device_path_uri *uridp;
>>> +
>>> +                     if (argc <  3 || lo.label) {
>>> +                             r =3D CMD_RET_USAGE;
>>> +                             goto out;
>>> +                     }
>>> +                     id =3D (int)hextoul(argv[1], &endp);
>>> +                     if (*endp !=3D '\0' || id > 0xffff)
>>> +                             return CMD_RET_USAGE;
>>> +
>>> +                     efi_create_indexed_name(var_name16, sizeof(var_n=
ame16),
>>> +                                             "Boot", id);
>>> +
>>> +                     label =3D efi_convert_string(argv[2]);
>>> +                     if (!label)
>>> +                             return CMD_RET_FAILURE;
>>> +                     lo.label =3D label;
>>> +
>>> +                     uridp_len =3D sizeof(struct efi_device_path) + s=
trlen(argv[3]) + 1;
>>> +                     fp_free =3D efi_alloc(uridp_len + sizeof(END));
>>> +                     uridp =3D (struct efi_device_path_uri *)fp_free;
>>> +                     uridp->dp.type =3D DEVICE_PATH_TYPE_MESSAGING_DE=
VICE;
>>> +                     uridp->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MSG_=
URI;
>>> +                     uridp->dp.length =3D uridp_len;
>>> +                     strcpy(uridp->uri, argv[3]);
>>> +                     pos =3D (char *)uridp + uridp_len;
>>> +                     memcpy(pos, &END, sizeof(END));
>>> +                     fp_size +=3D uridp_len + sizeof(END);
>>> +                     file_path =3D (struct efi_device_path *)uridp;
>>> +                     argc -=3D 3;
>>> +                     argv +=3D 3;
>>> +                     break;
>>> +             }
>>> +
>>>                default:
>>>                        r =3D CMD_RET_USAGE;
>>>                        goto out;
>>> @@ -1492,6 +1530,7 @@ static char efidebug_help_text[] =3D
>>>        "  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file p=
ath>\n"
>>>        "  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
>>>        "  (-b, -i for short form device path)\n"
>>> +     "  -u <bootid> <label> <uri>\n"
>>
>> It might be a matter of personal preference, but
>> since the current syntax of efidebug is already much complex,
>> I don't want to add more options unless it's necessary.
>> How about re-using "-B" option, say
>>     =3D> efidebug -B 3 debian-netinst uri - https://foo.com/baa

You just replace one set of alternatives (-B -b -u) against another
(mmc, nvme, uri, ...). I cannot see that this reduces complexity.

>
> I understand your concern. OK, I will add uri in -b|B and also update
> documentation.

It is unclear to me what the difference between -b and -B shall be for
URIs. Would -B be with the device path of the network device
(/VenHw()/MAC()/URI()) and -b without (/URI())?

Best regards

Heinrich

>
> Thanks,
> Masahisa Kojima
>
>>
>> BTW, I think that <bootid> and <label> should have been moved out of "-=
b|B"
>> when Ilias introduced this new syntax.
>>
>> -Takahiro Akashi
>>
>>
>>>        "  -s '<optional data>'\n"
>>>        "efidebug boot rm <bootid#1> [<bootid#2> [<bootid#3> [...]]]\n"
>>>        "  - delete UEFI BootXXXX variables\n"
>>> --
>>> 2.34.1
>>>

