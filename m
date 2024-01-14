Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9156CC4707B
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 14:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8B258783D;
	Sun, 14 Jan 2024 15:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FIpMMyfB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE518771E; Sun, 14 Jan 2024 15:52:25 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB6B86EF1
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 15:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a26f73732c5so917044966b.3
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 06:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705243940; x=1705848740; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EMsVySxQbxPkmfKzXwszVZWMbG7DMLmQlYd7W73Wytg=;
 b=FIpMMyfBVBspTqJeW/GdmynHNtFgoyTgFJwTII04QTnjyDIGnLX4hutU146+F1Koe9
 KuHh3J2K9DvJK+dBWzo1Cqs0ej1ai9h4tVnjsuLtwWzyEdvHGVG11wJZLetpaGzjtNBD
 NUPCGbfCqI9Tq27r9qX6wb0KAzYGlzTJJfMxp02irXOXzAkrt/pOssiJSxbXvkUeSZXo
 amvCcX3wCGnd4Gm4LFqtL7kYTC/oGmEcIpeH1I4SULaP7iygtT5qsjkDD6SCFgq6oa0a
 DdZkbU2KAWxMTjmknQlySfFuCKG3d1KbdLBI+SkTBqLpOxXoQuZ9iMiSEjq5+gu2xK+h
 kiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705243940; x=1705848740;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EMsVySxQbxPkmfKzXwszVZWMbG7DMLmQlYd7W73Wytg=;
 b=ErOGwr1/8XE/CoyGJcV6gP+qAipipwL1iSyO4X6mBU8v22YaXYA0ryWIKRqfTJRr1d
 i5X1jO9LeITafVT+Rss99eehlNHsA6yJxUr5HNqSfBSfgP2w7rLzoTKI9cnpIPICHpml
 gnytjfmqMN3HJce1ej7F0sAdKtN0GrX6JZu1RAfB3PS7G1rT75a/B/oWNaIxVI3mPzgp
 kZbiUcv6+4s95ZZbZs+LeVyD/Nvs0t6OY4nt4cnfGGXdzL1lc78oHq/5TzgqWqSomllq
 GFXB77qwg3ybgj8MxdVoHxCUgXVshV2ul4HYjupv/OCPSm9zU16jM0nPoVhuFtJFegGg
 wvMw==
X-Gm-Message-State: AOJu0YxflsF2mTmpd9tZFioZm9RGRZDVSoSNe+UzHTUiyg0SRpkKn70r
 AvfScFtVUJvdjpuLHib/aAM=
X-Google-Smtp-Source: AGHT+IGsjleu7rKysZENzNI/8fEUdU8Sy3ZEGOqDMZtMEY98QD8SN8sLAT8/5HRhCtK7JXrfL50WmQ==
X-Received: by 2002:a17:906:bc56:b0:a2d:1f53:4601 with SMTP id
 s22-20020a170906bc5600b00a2d1f534601mr1106510ejv.24.1705243939736; 
 Sun, 14 Jan 2024 06:52:19 -0800 (PST)
Received: from [127.0.0.1] ([46.211.234.255]) by smtp.gmail.com with ESMTPSA id
 vw15-20020a170907a70f00b00a2d0595cd0dsm2329512ejc.86.2024.01.14.06.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jan 2024 06:52:19 -0800 (PST)
Date: Sun, 14 Jan 2024 16:52:17 +0200
From: Svyatoslav <clamor95@gmail.com>
To: Peter Robinson <pbrobinson@gmail.com>
CC: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] cmd: bootmenu: rename U-Boot console to Exit
User-Agent: K-9 Mail for Android
In-Reply-To: <CALeDE9N6kn9Q-Uafx9-3_3xPUhLj1QN=h6DemYturrBUM5nwmQ@mail.gmail.com>
References: <20240114101701.23070-1-clamor95@gmail.com>
 <20240114101701.23070-2-clamor95@gmail.com>
 <CALeDE9N6kn9Q-Uafx9-3_3xPUhLj1QN=h6DemYturrBUM5nwmQ@mail.gmail.com>
Message-ID: <E7FA443F-DAE6-494E-8552-C4D75E86DE54@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



14 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 16:41:40 GMT+02:0=
0, Peter Robinson <pbrobinson@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Sun, 14 Jan 2024 at 10:23, Svyatoslav Ryhel <clamor95@gmail=2Ecom> wro=
te:
>>
>> It seems that the U-Boot console entry of the bootmenu has lost
>> its original meaning=2E Now, even if it is chosen, the probability
>> that you will enter the actual U-Boot console is quite low=2E
>> Boot env, bootflow, bootcommand script may appear, but not the
>> actual console=2E Hense, let's remove ambiguity and name this
>
>Hence
>
Fair

>> entry by what it actually does: 'Exit' the bootmenu=2E
>>
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  cmd/bootmenu=2Ec | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/cmd/bootmenu=2Ec b/cmd/bootmenu=2Ec
>> index 987b16889f=2E=2E69fca710a8 100644
>> --- a/cmd/bootmenu=2Ec
>> +++ b/cmd/bootmenu=2Ec
>> @@ -119,7 +119,7 @@ static char *bootmenu_choice_entry(void *data)
>>                                 iter =3D iter->next;
>>                         return iter->key;
>>                 case BKEY_QUIT:
>> -                       /* Quit by choosing the last entry - U-Boot con=
sole */
>> +                       /* Quit by choosing the last entry - Exit */
>
>I think just put "Set the last entry to Exit"
>

It can be either Quit or U-Boot console=2E Since U-Boot console is renamed=
 by this patch, all references in comments are replaced with Exit=2E

>>                         iter =3D menu->first;
>>                         while (iter->next)
>>                                 iter =3D iter->next;
>> @@ -361,15 +361,15 @@ static struct bootmenu_data *bootmenu_create(int =
delay)
>>         }
>>  #endif
>>
>> -       /* Add U-Boot console entry at the end */
>> +       /* Add Exit entry at the end */
>>         if (i <=3D MAX_COUNT - 1) {
>>                 entry =3D malloc(sizeof(struct bootmenu_entry));
>>                 if (!entry)
>>                         goto cleanup;
>>
>> -               /* Add Quit entry if entering U-Boot console is disable=
d */
>> +               /* Add Quit entry if exiting to U-Boot console is disab=
led */
>
>s/Quit/Exit/
>
>>                 if (!IS_ENABLED(CONFIG_BOOTMENU_DISABLE_UBOOT_CONSOLE))
>> -                       entry->title =3D strdup("U-Boot console");
>> +                       entry->title =3D strdup("Exit");
>>                 else
>>                         entry->title =3D strdup("Quit");
>>
>> @@ -532,7 +532,7 @@ static enum bootmenu_ret bootmenu_show(int delay)
>>                 title =3D strdup(iter->title);
>>                 command =3D strdup(iter->command);
>>
>> -               /* last entry is U-Boot console or Quit */
>> +               /* last entry is Exit or Quit */
>
>"Last entry is Exit" as I don't see Quit referred to=2E
>

Check above=2E

>>                 if (iter->num =3D=3D iter->menu->count - 1) {
>>                         ret =3D BOOTMENU_RET_QUIT;
>>                         goto cleanup;
>> --
>> 2=2E40=2E1
>>
