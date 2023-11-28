Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B63C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 16:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A296087741;
	Tue, 28 Nov 2023 17:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CDaWPTCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 152F186F02; Tue, 28 Nov 2023 17:30:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA0D287741
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 17:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1701189014; x=1701793814; i=xypron.glpk@gmx.de;
 bh=a89bHpvsnwDEzWHA9znwkEAYiL9hc9/iUHQ0/yfe1Lw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=CDaWPTCbHBl8AomInncGtzVkukCDJiAvF8KybXYgz7f+tsearuvF9mEq7UBObXe3
 VHZwVPAPrycFm8h8hpfBRGJXxrhDSf0F/8Fpr+F0VoR3blLjSe+ZFvJzkQ9wiJdyX
 YS3zgg27Er52zdISFfTd76Hxqus9HUbjslb7i/uORddHRGj+NNFrwAt9RLWB12EVx
 yywdQyHmPCbZe2jxweV6dbtBohrEn6quQaUZaYS8+VFOsBhM+J6xKzxDNel22f3Gh
 4SVDRszBldYEk1mhYr3HqOAO9OULkt12PDeyGD3TLNoIMpRHZpduN+qmErFDPYTDT
 vtdQ1S4iGNo22Aq0QA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXpK-1qhihK3D9M-00QQhm; Tue, 28
 Nov 2023 17:30:14 +0100
Message-ID: <e27e8bc1-6d8e-4eeb-bc82-66bead193ae5@gmx.de>
Date: Tue, 28 Nov 2023 17:30:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Make DisconnectController follow the EFI spec
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: masahisa.kojima@linaro.org, ryosuke.saito@linaro.org, u-boot@lists.denx.de
References: <20231128154508.465171-1-ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231128154508.465171-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yr6o9lwvEyG+8qe7Ee6Q9kGQbL6dk3MkpVzQqTiqQmnzG0Zr0tW
 et+U4Ym7cA5AyEe86U0IIRwPoUADfiyiyxCHz2xOWaz1WIKwe/I0cefUEeRJx0NRRzdkCxL
 D4+budolvc/KASnPuD3D69hxZK4CLBHXLpXDEE7o9u7eIS3n5w+aIbIYPWfbF2EKiMvB3lb
 eRfV+e7ipsXKclGYnoDpg==
UI-OutboundReport: notjunk:1;M01:P0:fobhq2M2Yzk=;hWDP4faC7BP81w36JpMvMvXox5A
 rDXVZK3hLFxcfD51uj0RESY0R3oWRHfZSZ3kYJjMPWzklDafTSMXBZwbNQ93XqdjQ6F1EE0MX
 ofbrpKOJ+T/PR8OJLi35kMk5YkKvWnwXNmUzn3RCQ3MeWAgUfzyEB1bQzaQXbSjMtGk/YBW/u
 LWmVF1CSsF9U2dEB2PbhxKuCNGfe2LzSKs2OtsSaVQy+3DtkUEmTHtZupk+QSt8496U4ZdAcE
 OAWfzIEDpWEzLqdJs1r4okRuRyxMosc5UtCobSbiKxPMuE/H1NA85QKqkNV6hiZ/oB+9PNieU
 szWcj2u3cTav7tSKNG6UVYDwN1SUDgymEA5HjkMsYeVXQOjzr/5snSSjbVmh/9zwrpJ68jkCO
 YpqbjVDcn67i8UiB4rxVUMO6FUWlquyh4O5oVQyOk045OW4z9Kn2tfkmFs2rHYaEXUdrJIJjO
 5bOWTRUoDWAPB+niEKyO39m1yU3Z6J1LCRWdFCIc2ye+oV6RhsjlT1xyXKhdQo9Xl+FsqFs/i
 DUpAFuAYe4c+9mh/lfha+5OGbH/d7pKnHw3xr7ZHgKEqY+mDT1nc2InyGp1XRAlv46GwTpAZS
 S5G0LqIXvaj18nEinEYyFz77XVvP07Aj8NE19jTNTmeezVDmMYGoMoSo0bx4OSlFwHn6+lyNS
 iACehDiq5dGbGiIcccmtW1lDq9CCib8rHMM8i4UzARfOqBdW9lGXZAT5TRtzylmKlknABRr+I
 u8e3Vti8OvOjMtqaXKUSCUhc6FMPvbD+Ynoa6jrqnyuOwdTHQ6WY6bzFEt5nHxWO2vqu9lhtr
 8zBJPAM+tuWpjUtV/lorXqyBDs418MQEZnw3C4e+/RgQHaLG7ayk/xJ18MzhMZOrwOa/0n9dQ
 XlJj/qF2o3zkoWaYzS8Fa8ZRc5h4iN4imqCi551BzztVNP9VgKUoRVOLFWJm5pq0rasC7/wTW
 GunNXaCj/raad9yzW3TnIgohnBs=
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

On 28.11.23 16:45, Ilias Apalodimas wrote:
> commit 239d59a65e20 ("efi_loader: reconnect drivers on failure")
> tried to fix the UninstallProtocol interface which must reconnect
> any controllers it disconnected by calling ConnectController()
> in case of failure. However, the reconnect functionality was wired in
> efi_disconnect_all_drivers() instead of efi_uninstall_protocol().
>
> As a result some SCT tests started failing.
> Specifically, BBTestOpenProtocolInterfaceTest333CheckPoint3() test
>   - Calls ConnectController for DriverImageHandle1
>   - Calls DisconnectController for DriverImageHandle1 which will
>     disconnect everything apart from TestProtocol4. That will remain
>     open on purpose.
>   - Calls ConnectController for DriverImageHandle2. TestProtocol4
>     which was explicitly preserved was installed wth BY_DRIVER attribute=
s.
>     The new protocol will call DisconnectController since its attributes
>     are BY_DRIVER|EXCLUSIVE, but TestProtocol4 will not be removed. The
>     test expects EFI_ACCESS_DENIED which works fine.
>
>     The problem is that DisconnectController, will eventually call
>     EFI_DRIVER_BINDING_PROTOCOL.Stop(). But on the aforementioned test
>     this will call CloseProtocol -- the binding protocol is defined in
>     'DBindingDriver3.c' and the .Stop function uses CloseProtocol.
>     If that close protocol call fails with EFI_NOT_FOUND, the current co=
de
>     will try to mistakenly reconnect all drivers and the subsequent test=
s
>     that rely on the device being disconnected will fail.



>
> Move the reconnection in efi_uninstall_protocol() were it belongs.
>
> Fixes: commit 239d59a65e20 ("efi_loader: reconnect drivers on failure")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Heinrich this is critical. Although it doesn't break anything on our nor=
mal
> use cases it does break the ACS testing for SystemReady-IR and I prefer
> landing it in -master before the 2024.01 release

Ok

>
>   lib/efi_loader/efi_boottime.c | 23 +++++------------------
>   1 file changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 0b7579cb5af1..370eaee8ce1a 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -1339,7 +1339,7 @@ static efi_status_t efi_disconnect_all_drivers
>   				 const efi_guid_t *protocol,
>   				 efi_handle_t child_handle)
>   {
> -	efi_uintn_t number_of_drivers, tmp;
> +	efi_uintn_t number_of_drivers;
>   	efi_handle_t *driver_handle_buffer;
>   	efi_status_t r, ret;
>
> @@ -1350,31 +1350,17 @@ static efi_status_t efi_disconnect_all_drivers
>   	if (!number_of_drivers)
>   		return EFI_SUCCESS;
>
> -	tmp =3D number_of_drivers;
>   	while (number_of_drivers) {
> -		ret =3D EFI_CALL(efi_disconnect_controller(
> +		r =3D EFI_CALL(efi_disconnect_controller(
>   				handle,
>   				driver_handle_buffer[--number_of_drivers],
>   				child_handle));
> -		if (ret !=3D EFI_SUCCESS)
> -			goto reconnect;
> -	}
> -
> -	free(driver_handle_buffer);
> -	return ret;
> -
> -reconnect:
> -	/* Reconnect all disconnected drivers */
> -	for (; number_of_drivers < tmp; number_of_drivers++) {
> -		r =3D EFI_CALL(efi_connect_controller(handle,
> -						    &driver_handle_buffer[number_of_drivers],
> -						    NULL, true));
>   		if (r !=3D EFI_SUCCESS)
> -			EFI_PRINT("Failed to reconnect controller\n");
> +			ret =3D r;
>   	}
>
>   	free(driver_handle_buffer);
> -	return ret;
> +	return (ret !=3D EFI_SUCCESS ? ret : EFI_SUCCESS);

This will always return ret. Did you want to return another value?

>   }
>
>   /**
> @@ -1409,6 +1395,7 @@ static efi_status_t efi_uninstall_protocol
>   	r =3D efi_disconnect_all_drivers(handle, protocol, NULL);
>   	if (r !=3D EFI_SUCCESS) {
>   		r =3D EFI_ACCESS_DENIED;
> +		EFI_CALL(efi_connect_controller(handle, NULL, NULL, true));

Chapter "EFI_BOOT_SERVICES.UninstallProtocolInterface()" of the EFI
specification says: " In addition, all of the drivers that were
disconnected with the boot service DisconnectController() earlier, are
reconnected with the boot service
EFI_BOOT_SERVICES.ConnectController()." What makes you think that
ConnectController() should be called with DriverImageHandle =3D NULL? I
cannot derive this from the specification.

EDK2's CoreDisconnectControllersUsingProtocolInterface() does so. But
shouldn't such behavior be defined in the specification?

We have 4 places where we use EFI_CALL to call efi_connect_controller.
Should we provide an internal function?

Best regards

Heinrich

>   		goto out;
>   	}
>   	/* Close protocol */
> --
> 2.37.2
>

