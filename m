Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE309C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 12:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B8308077D;
	Thu, 24 Aug 2023 14:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="J71bewTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5654F807C4; Thu, 24 Aug 2023 14:10:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A114B8056B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 14:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692879051; x=1693483851; i=xypron.glpk@gmx.de;
 bh=Kp2w9dt267t9OcdKQBLdXx+hcflIumWX/Kl6rgDG4ps=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
 b=J71bewTA5XaY2POmgZ2TgTDor1xK/HqYcX9ufusme98r2Rld3R073GOjiB3bZNiXg73ameB
 g2ZJ0sS7Teh3xXUEzkrfW+FKihV2glKFO10BxZKQtMrp7GhcdfmP9IcWj5W9Tg/2HEocVnviA
 tF3IfBvawc+UwmlVFpevoD41g7AW4tj9SZX7rIxckzng9uT/rosc+q9sQm0uH24804ZT9QFk0
 YmYZimb+zHIyk9uJ6mBHSp7rc0VXvtN6Gw19FcCUWNHDqvvphIeU1Ggx/ORFy+7lqCxozJ/fZ
 DaGW35IfEC3/6mukHhFJNxb7CHz3MBoxq6sbLvdLtEpoO/KJ8XdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hzj-1pXjh636KF-011iNw; Thu, 24
 Aug 2023 14:10:51 +0200
Message-ID: <b84b35df-c146-5255-f9b6-427688cd7eeb@gmx.de>
Date: Thu, 24 Aug 2023 14:10:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] efi_loader: delete handle from events when a protocol is
 uninstalled
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20230824115500.2388636-1-ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230824115500.2388636-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8gwJ0CNVO4480SQLJtM+SOP+k6QglmxLGuo0sS3W4TY08ZPQfae
 xYKLJFROm39c2+rf38LWIxrZ4+nT63mMB3zKAwRaiVRrrgsolSPNADxxs7wy6urr7++tU7/
 O/fzhlFDa33MhWMDgxgnokYrEHg4K3C0bl6e+EJsLN8I/bkaUzBAy6bnE+Y0YmdQI4jGwFp
 M2FipODlgYMS8D6x8DL4g==
UI-OutboundReport: notjunk:1;M01:P0:lrMjz/rEvXc=;zcy/WNaxkb0W0yozfj0u/Y+596m
 T4IVBJNEpKAVegSWKK/NgC644znQPrqyV32rTXE2omfNDFq9sbP8W5wiIWXnLemqMdME5gnlE
 1GIbrAE5yUcuBBeS2sr9BtRf/hsjhQCEqcQn68/d0w0F5tLsM6fHZUD53LVqjOf9884Ec6Rqm
 LzXrdLJLRs87EHirnU7Od8cmhIPDMki4C05U3lyJ7c8sa3Nm4+NjIUjyb6V3/BiIOLGy+7Hsa
 QZUlTW67FVr/ykqV8mQIWUEbEgjcSFhtj7M1FNTLziMICAYeHwX2ZXpDeIpBcNUGPz3sZOqcN
 OtHjVnQ8JoLWtb+gtTFUHI5An/l3weVl1v8iMZDIHwdQQahcnCTKweJzUK4xsBzw9q7blrqog
 oj/mdBF/s3W1dej1S1RQPkEJ9/qP0XC7YW8ieSFQpmb1uBjwPmIDBu7N54LaYIoB3dkwsaHL3
 6dpKwUPyvMa9+5YYZTEJe9Jp0nBQf6NED/06sgFbhkS2ENBvyZjjahXo9Ex/KPIP6EsoZQt9F
 3UvhBzNFcZzeafxCXGZeHLsXspfZXYfLxiBvof5ZYhtXbRSVyeEI6uFYkJOnedaQx5eYSqwgq
 5Sk80mVofvXaTkJcsIuFfPxqHvNUfrfHEOaLqKAGku8eyT2N2EN/Qcir3nAqUfHjx92EXYdOX
 YqBQw2JIuZeSNrwtTYqQ9W9ksvzZKFQjFEve0jnt3OmbnnojzlNiCFoNTlPRILlWdjmkI5x/X
 PxEI9l9UtfZ3/xEs1Sm56VjRvjhCylClhVmu7iZ+krIDsUOSU3EFsMUyFdE0zAK6IcsK7Rxvh
 lQ2off1wx003FUZU+17Cp2QDf/QCZ7knDnwbjcCUmn1hkaRG1fQhDKT6KISNKi5F0jxpmr2Zr
 DbSVbF57XdV1UVYDE6UATRBifbNjRcfISSgVyU/kW/pcVzGwfn4LrCGO3KlIbdei+V9rXDUfS
 gw9N7sHCt+8oQskqC76CCtHsrV0=
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

On 24.08.23 13:55, Ilias Apalodimas wrote:
> When a notification event is registered for a protocol the handle of the
> protocol is added in our event notification list.  When all the protocol=
s
> of the handle are uninstalled we delete the handle but we do not remove
> it from the event notification list.
>
> Clean up the protocol removal functions and add a wrapper which
> - Removes the to-be deleted handle from any lists it participates
> - Remove the handle if no more protocols are present
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/efi_boottime.c | 80 ++++++++++++++++++++++++-----------
>   1 file changed, 56 insertions(+), 24 deletions(-)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 0e89c8505b11..96950790ba2a 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -61,7 +61,7 @@ static volatile gd_t *efi_gd, *app_gd;
>
>   static efi_status_t efi_uninstall_protocol
>   			(efi_handle_t handle, const efi_guid_t *protocol,
> -			 void *protocol_interface);
> +			 void *protocol_interface, bool preserve);
>
>   /* 1 if inside U-Boot code, 0 if inside EFI payload code */
>   static int entry_count =3D 1;
> @@ -207,6 +207,36 @@ static bool efi_event_is_queued(struct efi_event *e=
vent)
>   	return !!event->queue_link.next;
>   }
>
> +/**
> + * efi_purge_handle() - Clean the deleted handle from the various lists
> + * @handle: handle to remove
> + *
> + * Return: status code
> + */
> +static efi_status_t efi_purge_handle(efi_handle_t handle)
> +{
> +	struct efi_register_notify_event *item, *next;
> +
> +	if (!list_empty(&handle->protocols))
> +		return EFI_ACCESS_DENIED;
> +	/* The handle is about to be freed. Remove it from events */
> +	list_for_each_entry_safe(item, next, &efi_register_notify_events, link=
) {

You are not deleting from efi_register_notify_events. Why do you use the
safe version of the iterator?

> +		struct efi_protocol_notification *hitem, *hnext;
> +
> +		list_for_each_entry_safe(hitem, hnext, &item->handles, link) {
> +			if (handle =3D=3D hitem->handle) {
> +				list_del(&hitem->link);
> +				free(hitem);
> +			}
> +		}
> +	}
> +	/* The last protocol has been removed, delete the handle. */
> +	list_del(&handle->link);
> +	free(handle);
> +
> +	return EFI_SUCCESS;
> +}
> +
>   /**
>    * efi_process_event_queue() - process event queue
>    */
> @@ -615,7 +645,7 @@ static efi_status_t efi_remove_all_protocols(const e=
fi_handle_t handle)
>   		efi_status_t ret;
>
>   		ret =3D efi_uninstall_protocol(handle, &protocol->guid,
> -					     protocol->protocol_interface);
> +					     protocol->protocol_interface, true);
>   		if (ret !=3D EFI_SUCCESS)
>   			return ret;
>   	}
> @@ -639,10 +669,7 @@ efi_status_t efi_delete_handle(efi_handle_t handle)
>   		return ret;
>   	}
>
> -	list_del(&handle->link);
> -	free(handle);
> -
> -	return ret;
> +	return efi_purge_handle(handle);
>   }
>
>   /**
> @@ -1356,6 +1383,8 @@ reconnect:
>    * @handle:             handle from which the protocol shall be remove=
d
>    * @protocol:           GUID of the protocol to be removed
>    * @protocol_interface: interface to be removed
> + * @preserve:		preserve or delete the handle and remove it from any
> + *			list it participates if no protocols remain
>    *
>    * This function DOES NOT delete a handle without installed protocol.
>    *
> @@ -1363,7 +1392,7 @@ reconnect:
>    */
>   static efi_status_t efi_uninstall_protocol
>   			(efi_handle_t handle, const efi_guid_t *protocol,
> -			 void *protocol_interface)
> +			 void *protocol_interface, bool preserve)
>   {
>   	struct efi_handler *handler;
>   	struct efi_open_protocol_info_item *item;
> @@ -1397,6 +1426,14 @@ static efi_status_t efi_uninstall_protocol
>   		goto out;
>   	}
>   	r =3D efi_remove_protocol(handle, protocol, protocol_interface);
> +	if (r !=3D EFI_SUCCESS)
> +		return r;
> +	/*
> +	 * We don't care about the return value here since the
> +	 * handle might have more protocols installed
> +	 */
> +	if (!preserve)
> +		efi_purge_handle(handle);
>   out:
>   	return r;
>   }
> @@ -1422,15 +1459,10 @@ static efi_status_t EFIAPI efi_uninstall_protoco=
l_interface
>
>   	EFI_ENTRY("%p, %pUs, %p", handle, protocol, protocol_interface);
>
> -	ret =3D efi_uninstall_protocol(handle, protocol, protocol_interface);
> +	ret =3D efi_uninstall_protocol(handle, protocol, protocol_interface, f=
alse);
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>
> -	/* If the last protocol has been removed, delete the handle. */
> -	if (list_empty(&handle->protocols)) {
> -		list_del(&handle->link);
> -		free(handle);
> -	}
>   out:
>   	return EFI_EXIT(ret);
>   }
> @@ -2785,7 +2817,7 @@ static efi_status_t EFIAPI
>   efi_uninstall_multiple_protocol_interfaces_int(efi_handle_t handle,
>   					       efi_va_list argptr)
>   {
> -	const efi_guid_t *protocol;
> +	const efi_guid_t *protocol, *next_protocol;
>   	void *protocol_interface;
>   	efi_status_t ret =3D EFI_SUCCESS;
>   	size_t i =3D 0;
> @@ -2795,25 +2827,25 @@ efi_uninstall_multiple_protocol_interfaces_int(e=
fi_handle_t handle,
>   		return EFI_INVALID_PARAMETER;
>
>   	efi_va_copy(argptr_copy, argptr);
> +	protocol =3D efi_va_arg(argptr, efi_guid_t*);
>   	for (;;) {
> -		protocol =3D efi_va_arg(argptr, efi_guid_t*);
> +		bool preserve =3D true;
> +
>   		if (!protocol)
>   			break;
>   		protocol_interface =3D efi_va_arg(argptr, void*);
> +		next_protocol =3D efi_va_arg(argptr, efi_guid_t*);
> +		if (!next_protocol)
> +			preserve =3D false;

Is your idea that if 5 protocols are to be removed but only the first 3
are installed your want to reinstall the first 3?

Can we have some code comment describing what the function should do? In
5 years nobody will remember why the code was implemented this way.

Best regards

Heinrich


>   		ret =3D efi_uninstall_protocol(handle, protocol,
> -					     protocol_interface);
> +					     protocol_interface, preserve);
>   		if (ret !=3D EFI_SUCCESS)
>   			break;
>   		i++;
> +		protocol =3D next_protocol;
>   	}
> -	if (ret =3D=3D EFI_SUCCESS) {
> -		/* If the last protocol has been removed, delete the handle. */
> -		if (list_empty(&handle->protocols)) {
> -			list_del(&handle->link);
> -			free(handle);
> -		}
> +	if (ret =3D=3D EFI_SUCCESS)
>   		goto out;
> -	}
>
>   	/* If an error occurred undo all changes. */
>   	for (; i; --i) {
> @@ -3712,7 +3744,7 @@ static efi_status_t EFIAPI efi_reinstall_protocol_=
interface(
>   		  new_interface);
>
>   	/* Uninstall protocol but do not delete handle */
> -	ret =3D efi_uninstall_protocol(handle, protocol, old_interface);
> +	ret =3D efi_uninstall_protocol(handle, protocol, old_interface, true);
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>

