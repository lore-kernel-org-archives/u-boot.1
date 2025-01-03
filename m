Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38489E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 19:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 630B0802EF;
	Fri,  3 Jan 2025 20:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QoVtYTOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 336D28035E; Fri,  3 Jan 2025 20:50:10 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0984380295
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 20:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735933803; x=1736538603; i=xypron.glpk@gmx.de;
 bh=H5NCcFhW4jgwYHjwHCgb5vtlQPUugXJwNCs6JSVcwso=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QoVtYTOdbMG2IrcgKC3QfhULS29EhsfpXeH4S26SWBgqB4W0Wj5UYVLQ/6hH3Dzq
 8ZPzIr8i769YnMGfGoVm88ds/U4qkanscMhTllKYIXLMILzG//7gzN5SI8a5C9l7z
 f8tTt2MYMl14pjtP03gqvUeKPreCFo5gDBhBbuBrjZahIR6vdFPYJQKiLsnHjrsVQ
 5CfFL1pgY9lCv2No9EJjuxbbYZzlsIPCrzff36FMrpZ1LLfl2xqNC7D8Tb+AOL2rb
 d8JQY8AgIYtegORhaVrd+bY/aW+eF3h+OAn4E1qcCkss2BamDDfwPuWnXokQ+yfNt
 hPI6w3iN7is/FgkbFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.106] ([46.114.109.94]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1tolxH0mfE-00qgBY; Fri, 03
 Jan 2025 20:50:03 +0100
Message-ID: <9cc4a4e0-1a80-4bdc-9fd7-a04260ff7cb7@gmx.de>
Date: Fri, 3 Jan 2025 20:50:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_loader: efi_setup: Add efi_start_obj_list() to
 efi_setup.c
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20241206173033.2403998-1-adriano.cordova@canonical.com>
 <20241206173033.2403998-2-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241206173033.2403998-2-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jAwoEmyjCdfRovos4VOSo4px8tFZPIrorQt4sy//6VuVFB4wvAY
 WeXm0HRJvM3jkFHdbeO+if0I9q50Lrz/smXbXDPBymcnhUNVYuHkKaCzOOQKukt6EHGWd0k
 9me82NwQD62yUMjwfTunNzZE8FKhM+YGrmcxmMFsLKnwrksuIwF9TwYq3/+Mi7QneUMrbbf
 u7nJFHyX9vcsQgGBx/T1g==
UI-OutboundReport: notjunk:1;M01:P0:buNGwliR3vk=;yI241DJcee5QxMIWjKTBjw0Wv1O
 /DMYNE48WmDhIem2ze6mrm3Gbf2fyu/qGLwi+io+ffTxh333jX7mXYniJoThwJwHQjBGR1vc8
 2LwSPlx26cY6P2g+0pEFqQF174Ilxya0Qtx14gP0qh0mLioRMQq7BJMpgOUXj0w9LxZMgBqpq
 RjDX1SV3AfRZUwuerVUkn7HbpNRyO0UNSnuNfegcpr3dmB+dhrAGhQ65IVAVXcCDqeTpwM4c3
 E9lMQqshjp1pQkOihnJXu+yBauAyao6HfdS1EtLj2t3WBeKFrXeaaSJppldM7VnmTUAdkCZK0
 Ce0b2gACzjn7XnITu7Kzfiw20mbf639O0bN5u5ZAGIgUtEUvS0PlWBA4gy6SXhUmZOvjlypVu
 f4f4u7IQlfQqEf4faJhx5GhKxCbdcUGIhViyQ+V38A2feycU6y0hVful9zGp+MszuLPBkRdtB
 q1tgMLTRC43vj8Eyc9ZAxIvbz3r9ehM21RG5ls1yy9nZKsSf3ZdrMDU7qADhRFf0/RxKFTviY
 6cXqBeWGccK/LjhkAlNp+IkjOfJ2pmGpqn9sNH+27Lk0yaZfMQyB9TpMy6SDAahllbW36Us8w
 Lf2fXVgErPeMAABnetN/YE75ithWT3VDxGuNaHxMFVqk+EV/3AatQcfch40L8R9zcjwIAcE8K
 dL8sR6MTS4CGVZe9B0u5W9Hss0p0OLxSHjc6MK9yPKpOK2oE/ns7p0UwlRKPwLpbwGvIr8eaU
 n/AWI0g2xj2YP3Nc9v5kA3WCl3XjtjyzwAn7YUteDfINfNhxfbQXupHTWf0+yyOS9Wh9mlbL8
 ttXkSW0wpf95d6z0JObx8LLwq4OTDyzl0KW0CQDSNAotTSFHRPf5Zkv/ygnk+wJq4NyS8D6Xw
 j6UYLYKMOSG6vsxc5BSTte1K0av2FwKJIoscK81VNx4Ggjdk4tiDZYqlfFAcnvrnCEFK+bDit
 2AhBWcDwd+/hSmw6aOU+O6kgAevGlMjrjv9kZ72d0u6TOv08J2Q12MRaigQz8pGy0/IC9lUvR
 fUA3jyv/+eYeJi4INK9SGUilwICo+IffxlEfckusTIxoQq33sA0jcKlnBjutaaVVRZSPRuLIa
 ww6ZYX79p/FLK2fpfQ7mfUIkzTw55x
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

On 06.12.24 18:30, Adriano Cordova wrote:
> The command bootefi calls efi_init_obj_list to do the efi set up
> before launching an .efi payload, but efi_init_obj_list is called
> only once. There are some initializations which depend on the
> environment and should be done each time a payload gets launched and
> not only once and can now be done in efi_start_obj_list(). A motivation
> for this change is the following order of events:
>
> 1. Launch an EFI application (e.g. bootefi hello)
> 2. Change the ip address
> 3. Launch another application which uses the pxe protocol

Hello Adriano,

Thanks for addressing this issue.

There are a number of events that can lead to updating the IP address:

* EFI_PXE_BASE_CODE_PROTOCOL.Dhcp()
* EFI_PXE_BASE_CODE_PROTOCOL.SetStationIp()
* EFI_HTTP_PROTOCOL.Configure()
* command set env ethaddr#
* command dhcp

All of these events require:

* Updating the relevant ethaddr* variable.
* Updating any other references to the IP address.

When not only considering EFI applications but also EFI drivers
installed via the bootefi command all of these events can occur during
the runtime of EFI binaries.

Function efi_init_obj_list() is used for setups that are needed only
once before accessing the UEFI sub-system. It is not able to handle events=
.

If we need to update any internal UEFI data structures, we should do
this instantaneously when the event occurs and not when executing a UEFI
related shell command.

U-Boot already has callbacks invoked when variables are changed. These
are set up with U_BOOT_ENV_CALLBACK(). There is even a command 'env
callbacks' to list these callbacks.

You could define a new function to handle changes of the IP address and
invoke it via U_BOOT_ENV_CALLBACK(ipaddr, <function name>) or
U_BOOT_ENV_CALLBACK(netmask, <function name>).

With lwIP we can have multiple network interfaces. Each has a different
variable ipaddr# assigned to it. We will have to extend the concept of
U_BOOT_ENV_CALLBACK() to allow for wildcard matches by adjusting
find_env_callback(). With CONFIG_REGEX=3Dy regular expressions could be
used for this purpose (cf. include/slre.h) but we should better avoid
the code size increase.

Best regards

Heinrich

>
> As the EFI pxe protocol was initialized when the handles
> for efi net were created in 1., the ip was hardcoded there.
>
> In this example, another possibility would be to make a callback for ip
> address changes to go all the way up to efi_net.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   lib/efi_loader/efi_setup.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index aa59bc7779..164586742a 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -12,6 +12,7 @@
>   #include <log.h>
>   #include <asm-generic/unaligned.h>
>
> +#define OBJ_LIST_INITIALIZED 0
>   #define OBJ_LIST_NOT_INITIALIZED 1
>
>   efi_status_t efi_obj_list_initialized =3D OBJ_LIST_NOT_INITIALIZED;
> @@ -208,6 +209,18 @@ out:
>   	return -1;
>   }
>
> +/**
> + * efi_start_obj_list() - Start EFI object list
> + *
> + * Return:	status code
> + */
> +static efi_status_t efi_start_obj_list(void)
> +{
> +	efi_status_t ret =3D EFI_SUCCESS;
> +
> +	return ret;
> +}
> +
>   /**
>    * efi_init_obj_list() - Initialize and populate EFI object list
>    *
> @@ -217,7 +230,9 @@ efi_status_t efi_init_obj_list(void)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
>
> -	/* Initialize once only */
> +	/* Initialize only once, but start every time if correctly initialized=
*/
> +	if (efi_obj_list_initialized =3D=3D OBJ_LIST_INITIALIZED)
> +		return efi_start_obj_list();
>   	if (efi_obj_list_initialized !=3D OBJ_LIST_NOT_INITIALIZED)
>   		return efi_obj_list_initialized;
>
> @@ -349,6 +364,10 @@ efi_status_t efi_init_obj_list(void)
>   	if (IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK) &&
>   	    !IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK_EARLY))
>   		ret =3D efi_launch_capsules();
> +	if (ret !=3D EFI_SUCCESS)
> +		goto out;
> +
> +	ret =3D efi_start_obj_list();
>   out:
>   	efi_obj_list_initialized =3D ret;
>   	return ret;

