Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBA6C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 11:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D949F81F0B;
	Wed, 30 Apr 2025 13:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Hnu4v9vW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E5BB81F7E; Wed, 30 Apr 2025 13:30:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BF68807B1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 13:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746012654; x=1746617454; i=xypron.glpk@gmx.de;
 bh=9LkJfCekCp1jXHZOeQOqURrEVrRTJ64XaEJEuIi4cQE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Hnu4v9vWLaKjOx+z3Me9foRA0uPyHWolos6PzSwoLSfedisBC5OI/4vK2wOuPRQL
 DH8/I0yFfNYPmForGlQ1UFf0x2Kh2r7Ne6Q4+us872+9KEUVR97v4mrGL5jHIOBPM
 fdGyb86YQRTrNUjaLX2WOFWxB1bRNS8AKhJTqEZ6DtdMejzj8HJrgom5g44KRl6kM
 CQkKu7cIb7ReTvekqcJelbxgy6j4Ml7Zkv5xV4uym78HvkJDHc6b+JRM/Wfd8Opow
 ckKpoVvEJ7NFlL24TlotuKQ+9Fpob1Ihq5RnGLv71eECh9IBr0vu+oX9iL3qIakWu
 ZA+SkpfIrTWFDkmiGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm27-1uGSV30bJD-005RfM; Wed, 30
 Apr 2025 13:30:54 +0200
Message-ID: <afc3301f-c364-400f-80f4-ca6b81b5484b@gmx.de>
Date: Wed, 30 Apr 2025 13:30:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] efi_loader: bootbin: do not load an initrd if none
 is provided
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de, Masahisa Kojima <kojima.masahisa@socionext.com>
References: <20250429132756.2105309-1-adriano.cordova@canonical.com>
 <20250429132756.2105309-2-adriano.cordova@canonical.com>
 <5516429f-074e-4ae6-bd7d-d49f020eae4a@gmx.de>
 <0aba7595-018d-4288-a8d4-a262da9a4580@gmx.de>
Content-Language: en-US
In-Reply-To: <0aba7595-018d-4288-a8d4-a262da9a4580@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xgFymNTnFbOwG4vLRa3MxBTVAgRiJxFzfeSen7aJIjH0SXqajCg
 rAx3x3lxI893dExpIA16cObgZz1p8ZvdMNj8FsEeG4xoyZUmrewwV4oMHhPVHrDyZ706oJZ
 V+PbLM4RFzpP1iwXaY8lZalf9azZjkn/RZKT913DSYCKr3kC+bILXIICvnW0rOHI7siD6my
 iOGwmyXV8GvjkJuSA/dlw==
UI-OutboundReport: notjunk:1;M01:P0:Mk9XqvqV70s=;rvkaWXfLoxHhhntpW9NYewMZayf
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

On 30.04.25 13:00, Heinrich Schuchardt wrote:
> On 30.04.25 09:03, Heinrich Schuchardt wrote:
>> On 4/29/25 15:27, Adriano Cordova wrote:
>>> Do not try to create an initrd device path nor try to register
>>> an initrd with the EFI_LOAD_FILE2_PROTOCOL if none is provided.
>>>
>>> Handle initrd installation in efi_binary_run_dp with
>>> efi_install_initrd, imitating what is done for the fdt.
>>>
>>> Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
>>> Reported-by: Weizhao Ouyang <o451686892@gmail.com>
>>> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
>>> Tested-by: Weizhao Ouyang <o451686892@gmail.com>
>>
>> I built and installed U-Boot for the StarFive VisionFive 2 based on=20
>> origin/master plus this series.
>>
>> I created a FIT images using the its file listed below.
>>
>> I loaded and tried to run the FIT image:
>>
>> StarFive # load nvme 0:1 $kernel_addr_r initrd.itb
>> StarFive # bootm $kernel_addr_r
>>
>> and saw the following failure:
>>
>> ## Transferring control to EFI (at address 00000000) ...
>> Card did not respond to voltage select! : -110
>> Booting /initrd.itb
>> Not a PE-COFF file
>> Loading image failed
>>
>> We use the entry point instead of the load address when transferring=20
>> control to the EFI sub-system.
>>
>> This bug was introduced by ecc7fdaa9ef1 ("bootm: Add a bootm command=20
>> for type IH_OS_EFI") and is not related to your patches but we still=20
>> need to fix it.
>=20
> Addressed by:
> bootm: pass kernel load address not entry point for IH_OS_EFI
> https://patchwork.ozlabs.org/project/uboot/=20
> patch/20250430105546.327442-1-heinrich.schuchardt@canonical.com/
>=20
>>
>> Afterwards I tried to boot into Ubuntu and got:
>>
>> =C2=A0=C2=A0 Loading Linux 6.14.0-13-generic ...
>> =C2=A0=C2=A0 Loading initial ramdisk ...
>> =C2=A0=C2=A0 error: failed to install protocols.
>> =C2=A0=C2=A0 Loading device tree blob...
>>
>> =C2=A0=C2=A0 Press any key to continue...
>>
>> It seems that U-Boot did not uninstall the LoadFile2 protocol when=20
>> discovering that the EFI image was invalid. We should have a look at=20
>> the error handling.
>=20
> This issue still has to be resolved.

For FIT images we don't trigger the event group related to=20
efi_guid_event_group_return_to_efibootmgr which calls event=20
efi_initrd_return_notify() which in turn calls efi_initrd_deregister().

A call to efi_initrd_deregister() is missing in do_bootm_efi().

Maybe adding the call to efi_binary_run() and getting rid of the event=20
group would be preferable.

@Ilias, @Masahisa
Any preferences?

Best regards

Heinrich

>=20
>>
>> The initrd for my test case can be created with:
>>
>> echo 'hello world' > hello
>> echo hello | cpio -o -H newc > initrd
>>
>=20
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>=20

