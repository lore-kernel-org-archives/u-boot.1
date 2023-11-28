Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD24C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 17:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D78A687753;
	Tue, 28 Nov 2023 18:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="f/ZVLa7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82BBF87778; Tue, 28 Nov 2023 18:57:31 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6502787630
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 18:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1701194248; x=1701799048; i=xypron.glpk@gmx.de;
 bh=veRfib/PDlZJpVlcBrYgHX9Q0y4KkHWnNlwifg5Wz6Y=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=f/ZVLa7B90xg3IwEK9riTRZK0cpXOtfVRJu73TRM8D7zrXA92qEnWOdP+6TqdKM3
 z1hyZP3VnVHHVV2U6eFewwnZI7cnmUk6Fle2EfrRowAYVV7qu4dUPKTVV6ormA9xR
 0NHDZjutJf5alX9i2m8AjNAbaV/xzeVOK1YjuPmaAACIw/eiYV0PBLSYjbMrcH+vP
 cZsscLM3AMedrjOIB/+a+juJo//rWV4ZOA8qbd08c/Qs0mjHnLQLtQXD93mju5KKQ
 mE+ZaapTcMiErMLKQB2lmY7C50o/n/Uch98FlH0r1hEhGrR9kHW7KoOe7ajLk4Wkd
 GAmA3W1OSmHAMYdReg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUosN-1qhwuf1hRp-00QiVG; Tue, 28
 Nov 2023 18:57:28 +0100
Message-ID: <2f8920fc-e24e-42fc-8e88-46f6604495b2@gmx.de>
Date: Tue, 28 Nov 2023 18:57:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Make DisconnectController follow the EFI spec
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: masahisa.kojima@linaro.org, ryosuke.saito@linaro.org, u-boot@lists.denx.de
References: <20231128154508.465171-1-ilias.apalodimas@linaro.org>
 <e27e8bc1-6d8e-4eeb-bc82-66bead193ae5@gmx.de>
 <CAC_iWjKBWOpLkLi=+nKAzUWzYzOG20VQ-Zyxhhhd6_568TZ0WA@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKBWOpLkLi=+nKAzUWzYzOG20VQ-Zyxhhhd6_568TZ0WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pbupwDg1IV96A5XsK87LURHm6OBo6BfZvk+80iur1ukdj0pCAE/
 iWfbnFD/mHYI4k/OusGvXLcQu6xw/hL4vg19qh8A04ygkqZiEFM3lPecrSnFvx4nMm0SELD
 pXPLTCToCLXy6uKlroczlXpZco0Zbw92H31hRUGFH7OUm/u15Djd0+M2f0P3iK87VX5SXTb
 RjCZiVgmpENPojF5lu5Cg==
UI-OutboundReport: notjunk:1;M01:P0:/gA2XaDqw1c=;djRVzslY3Y6P1WwbVR0L4qgPRQi
 uC5R578SECuXTR7/5912BC26NjIgw9drWDOqepJGkQ3A3STPrnlEyBSLO114ySW5kp6jXZ3Cj
 BY7UDePLjdOAQfTdk3/55kZIrHSyeId3i+nVP7X8cimiVp9PworBYCmp7fBxYFnsK4xU+QF+e
 xa+KISRPfjsz/c2r+xZn3g/pdf3jCQkTvTlTKQYMjMOK4BfLAHCJBQhJSq4zF5dZKx62YSNv1
 1PQHfQ/+CzRINzCW/viJzykJd6WEPRQ8dSAXXJ3GRkow9HPhdGeIBJEtNUbclzQH4JNgzX/a/
 j6rR599R+x8My+dSMKkyHJNB05hx9z50fEBaLl9fhAQUXZLz3dvjn+njGzsArrtHxg2hkb1Pj
 YmhJxhv0HWhCVmCwQeAn8GyyEL7QPQTOWipeOnZ0+4c0+28VphUNO0pj2B9m4BfFCxwnHjTk5
 Vjh0Lxvzbnwea+2pC4jUQvvoIrsYAfUmW+lYrmjcaBnmCu0nZuHnvS5GXZp+0nB4gEZMrr3jl
 CNUN4ntEE1J1g3Zk1MoXGMABO9jrFnVwXw9qaw0I6L6ZPkgYWGKlo202j3vfo1HqX1sESoK4P
 56lVgIzwxsRMBvK1fC1UEoMZY0ryRnqOLcpWAz5J0/d7X8JP5+LGC0BcQwGw0RioZHnC98pKe
 BHFKZp7hQaYGALPD43xD7So2Ql1T0cnoUD0A+/L0wrFbpuueDg6gR4Zlhfms80kQLnqfae6Xg
 YRrfG6DEmyeP1fIkGf0lqu1FWVo30rHwov1+9AzIpjg+C83YqJ9us8U0IX7UopoysWuksH8XQ
 0uxNzLliBX6vM8SzdGkoQ6qjCtxWmUWIbO6jSrZZ+iaMxS/fvMIF1oGHyDDRbIe/8gchlOsrR
 jxMiLf0W8ONEVjgWMFJIwiNjcDrWe92IfkiEnLyhSRECy3uO9Vtr0yGrWnSf+GwHaDPYXCcFg
 EpheiA==
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

On 28.11.23 18:40, Ilias Apalodimas wrote:
> Hi Heinrich
>
> On Tue, 28 Nov 2023 at 18:30, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 28.11.23 16:45, Ilias Apalodimas wrote:
>>> commit 239d59a65e20 ("efi_loader: reconnect drivers on failure")
>>> tried to fix the UninstallProtocol interface which must reconnect
>>> any controllers it disconnected by calling ConnectController()
>>> in case of failure. However, the reconnect functionality was wired in
>>> efi_disconnect_all_drivers() instead of efi_uninstall_protocol().
>>>
>>> As a result some SCT tests started failing.
>>> Specifically, BBTestOpenProtocolInterfaceTest333CheckPoint3() test
>>>    - Calls ConnectController for DriverImageHandle1
>>>    - Calls DisconnectController for DriverImageHandle1 which will
>>>      disconnect everything apart from TestProtocol4. That will remain
>>>      open on purpose.
>>>    - Calls ConnectController for DriverImageHandle2. TestProtocol4
>>>      which was explicitly preserved was installed wth BY_DRIVER attrib=
utes.
>>>      The new protocol will call DisconnectController since its attribu=
tes
>>>      are BY_DRIVER|EXCLUSIVE, but TestProtocol4 will not be removed. T=
he
>>>      test expects EFI_ACCESS_DENIED which works fine.
>>>
>>>      The problem is that DisconnectController, will eventually call
>>>      EFI_DRIVER_BINDING_PROTOCOL.Stop(). But on the aforementioned tes=
t
>>>      this will call CloseProtocol -- the binding protocol is defined i=
n
>>>      'DBindingDriver3.c' and the .Stop function uses CloseProtocol.
>>>      If that close protocol call fails with EFI_NOT_FOUND, the current=
 code
>>>      will try to mistakenly reconnect all drivers and the subsequent t=
ests
>>>      that rely on the device being disconnected will fail.
>>
>>
>>
>>>
>>> Move the reconnection in efi_uninstall_protocol() were it belongs.
>>>
>>> Fixes: commit 239d59a65e20 ("efi_loader: reconnect drivers on failure"=
)
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> ---
>>> Heinrich this is critical. Although it doesn't break anything on our n=
ormal
>>> use cases it does break the ACS testing for SystemReady-IR and I prefe=
r
>>> landing it in -master before the 2024.01 release
>>
>> Ok
>>
>>>
>>>    lib/efi_loader/efi_boottime.c | 23 +++++------------------
>>>    1 file changed, 5 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_bootti=
me.c
>>> index 0b7579cb5af1..370eaee8ce1a 100644
>>> --- a/lib/efi_loader/efi_boottime.c
>>> +++ b/lib/efi_loader/efi_boottime.c
>>> @@ -1339,7 +1339,7 @@ static efi_status_t efi_disconnect_all_drivers
>>>                                 const efi_guid_t *protocol,
>>>                                 efi_handle_t child_handle)
>>>    {
>>> -     efi_uintn_t number_of_drivers, tmp;
>>> +     efi_uintn_t number_of_drivers;
>>>        efi_handle_t *driver_handle_buffer;
>>>        efi_status_t r, ret;
>>>
>>> @@ -1350,31 +1350,17 @@ static efi_status_t efi_disconnect_all_drivers
>>>        if (!number_of_drivers)
>>>                return EFI_SUCCESS;
>>>
>>> -     tmp =3D number_of_drivers;
>>>        while (number_of_drivers) {
>>> -             ret =3D EFI_CALL(efi_disconnect_controller(
>>> +             r =3D EFI_CALL(efi_disconnect_controller(
>>>                                handle,
>>>                                driver_handle_buffer[--number_of_driver=
s],
>>>                                child_handle));
>>> -             if (ret !=3D EFI_SUCCESS)
>>> -                     goto reconnect;
>>> -     }
>>> -
>>> -     free(driver_handle_buffer);
>>> -     return ret;
>>> -
>>> -reconnect:
>>> -     /* Reconnect all disconnected drivers */
>>> -     for (; number_of_drivers < tmp; number_of_drivers++) {
>>> -             r =3D EFI_CALL(efi_connect_controller(handle,
>>> -                                                 &driver_handle_buffe=
r[number_of_drivers],

DriverHandleBuffer must be a NULL terminated array of handles.

Our implementation of ConnectController() is wrong as it does not
implement this.

Best regards

Heinrich

>>> -                                                 NULL, true));
>>>                if (r !=3D EFI_SUCCESS)
>>> -                     EFI_PRINT("Failed to reconnect controller\n");
>>> +                     ret =3D r;
>>>        }
>>>
>>>        free(driver_handle_buffer);
>>> -     return ret;
>>> +     return (ret !=3D EFI_SUCCESS ? ret : EFI_SUCCESS);
>>
>> This will always return ret. Did you want to return another value?
>
> No just ret
>
>>>    }
>>>
>>>    /**
>>> @@ -1409,6 +1395,7 @@ static efi_status_t efi_uninstall_protocol
>>>        r =3D efi_disconnect_all_drivers(handle, protocol, NULL);
>>>        if (r !=3D EFI_SUCCESS) {
>>>                r =3D EFI_ACCESS_DENIED;
>>> +             EFI_CALL(efi_connect_controller(handle, NULL, NULL, true=
));
>>
>> Chapter "EFI_BOOT_SERVICES.UninstallProtocolInterface()" of the EFI
>> specification says: " In addition, all of the drivers that were
>> disconnected with the boot service DisconnectController() earlier, are
>> reconnected with the boot service
>> EFI_BOOT_SERVICES.ConnectController()." What makes you think that
>> ConnectController() should be called with DriverImageHandle =3D NULL? I
>> cannot derive this from the specification.
>
> EDK2 does this as well to reconnect all controllers. Don't  we have
> the same functionality?
>
>>
>> EDK2's CoreDisconnectControllersUsingProtocolInterface() does so. But
>> shouldn't such behavior be defined in the specification?
>
> This is what confused me in the first place and I added the reconnect
> code in disconnect_controller. But if you look more closely they also
> have CoreDisconnectController() which *is* the EFI protocol they
> expose.
>
> CoreDisconnectControllersUsingProtocolInterface is just a wrapper they
> use on UninstallProtocol()
>
>>
>> We have 4 places where we use EFI_CALL to call efi_connect_controller.
>> Should we provide an internal function?
>
> Sure, but not for 2024.01
>
>>
>> Best regards
>>
>> Heinrich
>
> Thanks
> /Ilias
>>
>>>                goto out;
>>>        }
>>>        /* Close protocol */
>>> --
>>> 2.37.2
>>>
>>

