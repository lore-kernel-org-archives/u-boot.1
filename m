Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EBFC282C6
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 02:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64F4680842;
	Tue,  4 Mar 2025 03:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RAUl3ykK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBCCB811B3; Tue,  4 Mar 2025 03:38:32 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF7D8059D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 03:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-abf628d653eso356620666b.0
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 18:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741055858; x=1741660658; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DYAx1yisFbryBVtnd6adTdD98nFFmxtegPmBn6js5Y=;
 b=RAUl3ykKe7keokZ0Jd893wlXdUJ7SymZssguJdnH9/KwPqhEGQ3ZIa89jR018QO5Az
 WOlCBPIj9J4E8Kd/ZEoAnU8oJZNt6QJXh2hl3pClOhb3ojvWDnWdyU8h9J+k5UJYDJRF
 umQQu3XN7Wr+EWB8bQLYD1CrgIKQKzs1OGj09GiJhUZ9om5P3KJq3kz/cQenPIrYkpa8
 1TvVMToihQe/CAxKTXsFZ4JHXipKpXCYkjSEZ/z2V7SWKq4tmddFr1ESB0QD+E9YJI/B
 kmSHLi9qA44QMwz98f6v2e+wwnJnmVxJg6Zy0UbEsVKcWE356hJsvVuLNHaEpwmIFZyw
 CjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741055858; x=1741660658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DYAx1yisFbryBVtnd6adTdD98nFFmxtegPmBn6js5Y=;
 b=g6RmRpihTA7NApuiPEQt2Am0Y44UxVKE+gk7KVm4YRAb5dbhBmmg05scIQpjUdMG0U
 9ZqekFNoFuIKVDfrZm/9MYzuKM7gOgfYtnRP+Ucf8lDxzSOs/MWjEax/s5+zx/HAko+g
 bJ2odDcQB0g0lFQ62JiGQcVWBvoIB5SQz+4hBPZEBJJjWwNyPlkjlLWKWYfWDCtsy1rA
 WNYuyVYYygkEMo132rpJlq+/QEXym2ObmjfLe89a4bluiHMz27WdAFUhAYZXomDqphv8
 ZzSYaR3kJH/g8TctNLlwbk642dL8CdUXzPK1Bti+WTG8Fo+rGF+gwHR+SWGj0XnumzBo
 I9VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJhC1bCkzle/7miS7OrGPD5N6bXC1wlXf0odhS08XuPrFf/7M/P0vfvTNxkJr0vS1goo/Myro=@lists.denx.de
X-Gm-Message-State: AOJu0YwgWIX6zwRdwielN3b/XJ7eXrfpO9Kk40YNm2pm1d+waeQlNShd
 hC8NbN1e4T/QZpw0L1MIQcNCA2NSgVcBmpwhQT+bL21/Dp0SCxb+w1XpdGJNMptbJG/T4F9uXsq
 nhVrplfL47FeW4KDkEnyMsD3EYYA=
X-Gm-Gg: ASbGncsy+ul9m6Fwhdr0DBoYM6ylUWq4AjPj63JSXqDyxClLrv7Il0CqnVWK7Mhe8gx
 iWypSKc/8zRTKo638ZNOcTBZ7JSJDbK5MF2AOl+LBkEXGVozAdWI2JBKyDY/zuu02WiBbi8tllW
 tA3e9y0iUVwwG7dTkzezI925svOD+u9jOOyRlBvTSx/MKjJPJQNFIULjvKAg==
X-Google-Smtp-Source: AGHT+IFnGEvDhpTCBLfyQXyYYbjunM6UM+XNtGiugbdTevNCZwEo/049stwFpM54nXtWcHGUjD6hSwNe6HCT8hQFko4=
X-Received: by 2002:a17:906:c149:b0:abf:67de:2f25 with SMTP id
 a640c23a62f3a-abf67de36cdmr939981066b.33.1741055858237; Mon, 03 Mar 2025
 18:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-17-CFSworks@gmail.com>
 <CAM=mAOkE6A9XnYxW4Y-n88H9rVDP4wkQVeMNqXuxot1i0hs0hA@mail.gmail.com>
In-Reply-To: <CAM=mAOkE6A9XnYxW4Y-n88H9rVDP4wkQVeMNqXuxot1i0hs0hA@mail.gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Mon, 3 Mar 2025 18:37:27 -0800
X-Gm-Features: AQ5f1JrbTP0l7kY0d0YvA77TwEpkeC0e1Z5sFRyeANuMkAO0W3gwLz1yFUCui4s
Message-ID: <CAH5Ym4ivipuzYZYwF_bkmVudOn36GenEjeks6GRmqqgHC4Qr6Q@mail.gmail.com>
Subject: Re: [PATCH 16/17] efi_loader: Move .dynamic out of .text in EFI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sun, Feb 23, 2025 at 11:34=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> Sam Edwards <cfsworks@gmail.com> schrieb am Mo., 24. Feb. 2025, 06:56:
>>
>> This was not proper: A .text section is SHT_PROGBITS, while the .dynamic
>> section is SHT_DYNAMIC. Attempting to combine them like this creates a
>> section type mismatch.
>>
>> It seems that while GNU ld does not complain, LLVM's lld considers this
>> an error.
>>
>> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
>> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>  lib/efi_loader/elf_efi.ldsi | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/efi_loader/elf_efi.ldsi b/lib/efi_loader/elf_efi.ldsi
>> index dc4d1a3660e..acf02eba4d6 100644
>> --- a/lib/efi_loader/elf_efi.ldsi
>> +++ b/lib/efi_loader/elf_efi.ldsi
>> @@ -20,10 +20,10 @@ SECTIONS
>>                 *(.gnu.linkonce.t.*)
>>                 *(.srodata)
>>                 *(.rodata*)
>> -               . =3D ALIGN(16);
>> -               *(.dynamic);
>> -               . =3D ALIGN(512);
>>         }
>> +       . =3D ALIGN(16);
>> +       .dynamic : { *(.dynamic) }
>
>
> .dynamic is related to dynamic linking of libraries.
>
> Under which circumstances would we have content in .dynamic? Why would it=
 be needed for executing an EFI application?

Hey Heinrich,

Apologies for the late response; I didn't have sufficient time/tuits
to get to this until now.

While EFI applications are indeed statically linked, they need to be
relocatable. The .dynamic section contains the ELF dynamic table
(exposed via the _DYNAMIC symbol), which is passed to _relocate by the
crt0_[arch]_efi.S stubs. _relocate finds the relocations table by
querying the DT_RELA/_RELASZ/_RELAENT entries in the dynamic table.
Normally, the PE loader handles relocation of EFI applications before
transferring control by applying the PE relocations in .reloc, but
generating PE-format relocations would require some toolchain
trickery. Hence the ELF dynamic information (and relocations) in a PE
file. :)

Happy Monday,
Sam

>
> Best regards
>
> Heinrich
>
>
>> +       . =3D ALIGN(512);
>>         .rela.dyn : { *(.rela.dyn) }
>>         .rela.plt : { *(.rela.plt) }
>>         .rela.got : { *(.rela.got) }
>> --
>> 2.45.2
>>
