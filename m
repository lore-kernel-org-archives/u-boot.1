Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086EDC3ABC5
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 11:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E908091A;
	Sun, 11 May 2025 13:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Cb4hwZB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2105980F03; Sun, 11 May 2025 13:58:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9CDE8070C
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 13:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746964694; x=1747569494; i=xypron.glpk@gmx.de;
 bh=mj+S4T8NUBqspVKGiniEpqIdI0bXC9Oy2NZOwi6NWrs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Cb4hwZB9pFNcElDI7DHmSQ3CjRuquRksrLDGDdTaosNoBUxcr7W67yL+sXA59L4P
 n2hYPWao0F3DgvM7Mw2rCC0NlgA1XBxrnRZuneGGfoiCbL+kLIV1p8lyTIecj9nlf
 WRkn5EAwFcOVylaVU0h1sT9RLoVeylOFLsUtQx4yRHpAp9TpjrKJMqkUNzeZP8//Q
 wXuhI3Z/p/Dq6/ZWFaUE1dlM6lxsPGSOFVIFp8dQremacPEveDgOB9PAIIXPiPUQi
 CbggQc8UQy2F/MG98eTx7Uh9NabqyJuymeKYU8mFjtaomq1c1hwCwgZhwqWBsi4fQ
 C1KuCaByL2NGAEgWXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.101.1.247] ([185.104.138.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1uJINZ0zwJ-004iyX; Sun, 11
 May 2025 13:58:14 +0200
Message-ID: <563ba0a1-e2cf-4e6c-a9b9-b537e676cdfc@gmx.de>
Date: Sun, 11 May 2025 13:58:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] scripts/Makefile.lib: add PLATFORM_LIBS to efi
 linking
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20250508183034.3439777-1-adriano.cordova@canonical.com>
 <20250508183034.3439777-2-adriano.cordova@canonical.com>
 <90eb6297-8b7f-4549-9bb2-5182f7e904c6@gmx.de>
Content-Language: en-US
In-Reply-To: <90eb6297-8b7f-4549-9bb2-5182f7e904c6@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5LL3Ye74yKGpocyXYCe4AQy1xSI3bcPqa1XXgs7bwBQS5YxlurJ
 Y/z+0Ct7Urj2s3TeXvKzFZGf00+MAX8ELRW7ZGBl8v9Il38WQnJiMaZIXw0j4PYFdNkjlqh
 lGdRA8F/MvtfFpe9r0rHtqEBfYUBIwJSfMPTqGfiP1wZ931j8GRewct20zzcy+MOCfXpajO
 JM4QDi1siogzRw/BZVBRA==
UI-OutboundReport: notjunk:1;M01:P0:kRxcaTXloko=;sH7d3cpVCKKi1/sxLja06Y+zQog
 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
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

On 5/11/25 12:52, Heinrich Schuchardt wrote:
> On 5/8/25 20:30, Adriano Cordova wrote:
>> Link .efi applications using libgcc
>>
>> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
>> ---
>>
>> changes in v2:
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Address the root of the problem. In v1 I was=
 modifying
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printx in initrddump.efi not to ge=
nerate __lshrdi3 instructions,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 but a better fix is to provide tho=
se instructions with libgcc
>>
>> =C2=A0 scripts/Makefile.lib | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index 83fd5ff6c31..3a86cf375c3 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -497,7 +497,7 @@ KBUILD_EFILDFLAGS =3D -nostdlib -zexecstack -=20
>> znocombreloc -znorelro
>> =C2=A0 KBUILD_EFILDFLAGS +=3D $(call ld-option,--no-warn-rwx-segments)
>> =C2=A0 quiet_cmd_efi_ld =3D LD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $@
>> =C2=A0 cmd_efi_ld =3D $(LD) $(KBUILD_EFILDFLAGS) -L $(srctree) -T=20
>> $(EFI_LDS_PATH) \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -shared -Bsymbolic -s $^ -o=
 $@
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -shared -Bsymbolic -s $^ $(=
PLATFORM_LIBS) -o $@
>> =C2=A0 EFI_LDS_PATH =3D arch/$(ARCH)/lib/$(EFI_LDS)
>=20
> Building with this series fails:
>=20
>  =C2=A0=C2=A0 sandbox:=C2=A0 +=C2=A0=C2=A0 sandbox_noinst
> +ld.bfd: cannot find -lrt: No such file or directory
> +ld.bfd: cannot find -lSDL2: No such file or directory
> +make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/=20
> helloworld_efi.so] Error 1
> +make[2]: *** [scripts/Makefile.build:398: lib/efi_loader] Error 2
> +make[1]: *** [Makefile:1919: lib] Error 2
> +make: *** [Makefile:177: sub-make] Error 2
>=20
>  =C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 1 /1=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
andbox_noinst
>=20
> See https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/1131665/r=
aw
>=20
> Best regards
>=20
> Heinrich

Using PLATFORM_LIBGCC instead of PLATFORM_LIBS resolves the problem.

PLATFORM_LIBGCC should match your intention to link in libgcc according=20
to our prior communication. I will adjust the patch accordingly.

Best regards

Heinrich
