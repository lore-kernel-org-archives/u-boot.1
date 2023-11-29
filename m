Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09831C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 01:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 183D886D12;
	Wed, 29 Nov 2023 02:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="N69DiS9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7375B87605; Wed, 29 Nov 2023 02:26:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75EF686A3C
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 02:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1701221176; x=1701825976; i=xypron.glpk@gmx.de;
 bh=DKWlmAF72ewyJnWznbQPuUaLFBbGDb4L0mBD3cw1tps=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=N69DiS9c9yrCqmxEBKKuNTaayWcfjGmbitewSOA/GwDQA4Fz0DvKO+oA8M0PxJ6u
 mAdcPb9j+EOzUtIFeNd3JnSIJmRmAvMF1x1PIBxKPNG79mf8Gs1mWN88K9+BKpjVW
 LS0hXrXTjTtgF3H68bXyVrofMCvpFglDAN7Cr2VDrUg0N4vResIRQP8OoIcwvP0RR
 o6z/3SA4zsTRmZD9JiUJymKrpka95sN8qPXlpF/KIyMX4BRwXLopPr2CK1ciQmk3P
 6CR3FZwiKsG9ULqNlBlg36YmzZu5I7s1VSFFiRU9FYyAtxsaDuo/ZmDy8FNUYRYar
 Fu405PgukiX+pQ4SeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1r9GKq1blU-003NZU; Wed, 29
 Nov 2023 02:26:16 +0100
Message-ID: <e68eab24-0927-4d8b-9bed-6f1278dc3292@gmx.de>
Date: Wed, 29 Nov 2023 02:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi_loader: Make DisconnectController follow the EFI
 spec
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: masahisa.kojima@linaro.org, ryosuke.saito@linaro.org, u-boot@lists.denx.de
References: <20231128191031.467222-1-ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231128191031.467222-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b55LvkUaw9Yq2SVQhT5F3FzxLq7IYn3YP/fd7WP1Ss0f3OIQAyE
 jDL+igKGVWFPB3S5kWbAEJhfrB6pZ/4k6Ofz6bqZqX6b0PLdbh9orDWi1jo/+3yCR6SQQ8J
 AB1QII2PeQxi54f3tlvwG9vYUrFLswGgJp0eS7OpcFqNeOskd0EJAcIqj3sPqD2bGvhGmUQ
 psHVOHh88Q2/5lGblQ3hg==
UI-OutboundReport: notjunk:1;M01:P0:EKQuruOLZpI=;6MZRezJDx/FUqJ6IyPg+dUfcu4h
 MMbu2CJq5SppYx05RhEGTYX2dLB2ASJt20D99KYb7d6JRx76Hz9cv1BXU/wm344BuKefj31kM
 aR4wffdNCGNODnNUba9XyXBbCR+RIbU4H5MJ1/YvSQp2ZGxwCw622c61tnXwW983C548R9yuI
 mL2snlpoc3AiYvxkv56MmsQRCcoJ34juV0BptoJu7z98LjA0c577aXds5S7wLLoxtfzX9Q8NB
 5iETgB8CAT/0DdeLRYhwfGyoFeujjwuNdnIrNjlKZqLS/DHJG7cnsnrYygP6nco1wjHRj9E/V
 f4LeClIctZPAH/rsQ8DnL2Ks/AapX+4fVB3+qXrw+t9RFsT18KK3heZeYvgzU29P2fad5VXZs
 qTAPMRrJ8izHsN2eEas0kNiyEqqqUw2RDcBTwd1mgf9y6agq2UF4q75CCXIf91mSY0HkElWgn
 DJnMsueuXvj5FQlOH1NQTYhE4sOuoDD3gFMH91wfU8XXZuXr9MI0qDJwCQMJ+SQH1I3XNBD2R
 /i1AzhDsOpfi8/hRPiSJf0AxBecJuZjeDDkj2Wg0BuoGg9DNN+xLYbN/8I+yKnqY9ARJ4yCJw
 /iQ4StAnbaWp1ICDPaav383P+I6mXID8QCNcjCxKCGTXXdQyf/EKUSIjCBTcMJLxG1bs0sTBU
 0WUwpdFmkUPMMIlz5fs6RgBZMvYZNCvVhPM4/ZxOxPVe4ye2n/UYAOLH39vmV02U6YjfLig/x
 XtmuolGCFfXNcdEYcee3hKZX7nrFcuPoWnUONnsihNu5BJvkL4ajy3uimsTFvAQG1xDq0rgco
 sKW8dI+tzQAuWsF7VtBrQGt82f2snrk9vL6PO/3sfVjB+UEmACaR7LIcRrqPovGPpXaLHMaUa
 p1cfxHKdJ7j+rsfRngxade4Fa6rBOD3NsGn7rcsiaBal3GT0hvPMAXbJMOZXqJeZJsGtHWssO
 fqJ0EWGHuB9mMBMzZj2Pt1PEKrY=
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

On 11/28/23 20:10, Ilias Apalodimas wrote:
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
> Apologies for the fast resend, but since Heinrich reviewed it and
> we want it in 2024.01 resending
> Changes since v1:
> - return ret instead of (ret !=3D EFI_SUCCESS ? ret : EFI_SUCCESS) which=
 does the
>    same thing...
> - Add a comment about reconnecting all controllers
>   lib/efi_loader/efi_boottime.c | 27 ++++++++++-----------------
>   1 file changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 0b7579cb5af1..ea711919630b 100644
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
> @@ -1350,27 +1350,13 @@ static efi_status_t efi_disconnect_all_drivers
>   	if (!number_of_drivers)
>   		return EFI_SUCCESS;
>
> -	tmp =3D number_of_drivers;
>   	while (number_of_drivers) {

You assume here that drivers can be removed in reverse order.

Please, have a look at CoreDisconnectControllersUsingProtocolInterface()
in EDK II.

Here the code continues iterating over all connected controllers while
at least one controller can be removed in each round.

Reverse order is more promising than forward order. But maybe we should
combine this with retrying like in EDK II.

Best regards

Heinrich

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
> @@ -1409,6 +1395,13 @@ static efi_status_t efi_uninstall_protocol
>   	r =3D efi_disconnect_all_drivers(handle, protocol, NULL);
>   	if (r !=3D EFI_SUCCESS) {
>   		r =3D EFI_ACCESS_DENIED;
> +		/*
> +		 * This will reconnect all controllers of the handle, even ones
> +		 * that were not connected before. This can be done better
> +		 * but we are following the EDKII implementation on this for
> +		 * now
> +		 */
> +		EFI_CALL(efi_connect_controller(handle, NULL, NULL, true));
>   		goto out;
>   	}
>   	/* Close protocol */
> --
> 2.37.2
>

