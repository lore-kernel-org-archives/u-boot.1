Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A91C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 14:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2239839A9;
	Fri, 25 Jul 2025 16:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iCniPe7+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCE07839B9; Fri, 25 Jul 2025 16:01:41 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F63883987
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 16:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753452081; x=1754056881; i=xypron.glpk@gmx.de;
 bh=3WvWlrNwKzPwFJKRw/rbWSY1FfZNJhOqNqf0TQMTXe4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iCniPe7+B0ZDPxlgoTN/3693UZBXP9ratQnz+JeGnzP0veLNgKNmRYwYZGbHiDB+
 jPWoAhn4ize82Od2vJHM4x25YnGJXX0Ztkx4xWtvncRmOhMwK7kjM+JF70e1IKv3+
 nkkD94t79SqjkcE9BVEIsGpBhkqFv+QhS9WJSWy7yT7Xbn960QhHrZ8sdTunMg1g2
 H4HvbTv1nLET/zEAKPWEjjwF19zq/VkqkqexHcevtyQ0lBjRcN2VLHPGcYRCu+ok4
 u0mv6gFlCr0FfLxacrJtFGlnygZQ6dTgmqUIkdIfSMsZ5xoewCrhtotcR13kZtRXr
 l5UM9JdKYq8YerxJAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDnC-1uqsEZ0G7y-00EGTF; Fri, 25
 Jul 2025 16:01:21 +0200
Message-ID: <0ccad71c-6fc8-4c10-b017-85f31f77c161@gmx.de>
Date: Fri, 25 Jul 2025 16:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] efi_loader: improve device path matching for
 partition lookup
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
 <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
Content-Language: en-US
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, ilias.apalodimas@linaro.org, adrianox@gmail.com,
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZhvoavAZG+IYuneIWVfliBZz5ykicariHCsHGXeFTfGpXg2wOgy
 xzgvxVS8sXhB7Ke2lh7OPVCmtmPDz1W4vg8nSKOv4c60MarE3UXN6LPfc6C5UyhN3CffAu+
 9G+e12FjN3uvjNdrwdKTaMFtIU5PE4SvPIQcdUztBimctyl+cHcncO4+aCODrINNB8Uvhba
 kfWKRyVR1ndWPyp7WKREg==
UI-OutboundReport: notjunk:1;M01:P0:DQSlptzojUI=;GInMXDTavIOsOtGdCOuNu9X6TQS
 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
 rNzNAw/SdRLZb6F7jg3zX0Y=
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

On 24.07.25 11:00, Balaji Selvanathan wrote:
> - Refactor find_handle() to improve device path comparison logic.
> - Original logic only compared paths when len_current <=3D len.
> - This fails when searching for ESP inside a larger boot device.
> - ESP partition path is longer than boot device path by design.

Thank you for reporting an issue you have with capsule updates.

Could you, please, describe how to reproduce the issue you are seeing.

Which caller fails for you?
What are the values of the UEFI Boot####, BootNext variables that you=20
use to find the capsule?
What is the device-path of the ESP?

Best regards

Heinrich


> - New logic allows matching when dp is a prefix of dp_current.
> - Without this change, it was not able to find ESP and capsule
>    update fails to start.
>=20
> - Also update efi_fs_from_path() to use system partition GUID.
> - Above ensures ESP's EFI handle is returned which contains
>    file system protocol.
> - Without this change, it was returning a wrong EFI handle
>    that was not ESP handle.
>=20
> - These changes improves reliability for capsule updates.
>=20
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   lib/efi_loader/efi_device_path.c | 62 ++++++++++++++++++++++----------
>   lib/efi_loader/efi_disk.c        |  2 +-
>   2 files changed, 45 insertions(+), 19 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index b3fb20b2501..3716165e963 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -107,54 +107,80 @@ struct efi_device_path *efi_dp_shorten(struct efi_=
device_path *dp)
>    * @rem:	pointer to receive remaining device path
>    * Return:	matching handle
>    */
> +
>   static efi_handle_t find_handle(struct efi_device_path *dp,
>   				const efi_guid_t *guid, bool short_path,
>   				struct efi_device_path **rem)
>   {
>   	efi_handle_t handle, best_handle =3D NULL;
> -	efi_uintn_t len, best_len =3D 0;
> +	efi_uintn_t len, len_current, best_len =3D 0;
> +	efi_status_t ret;
> +	struct efi_device_path *dp_current;
> +	struct efi_handler *handler;
>  =20
>   	len =3D efi_dp_instance_size(dp);
>  =20
>   	list_for_each_entry(handle, &efi_obj_list, link) {
> -		struct efi_handler *handler;
> -		struct efi_device_path *dp_current;
> -		efi_uintn_t len_current;
> -		efi_status_t ret;
> -
>   		if (guid) {
>   			ret =3D efi_search_protocol(handle, guid, &handler);
>   			if (ret !=3D EFI_SUCCESS)
>   				continue;
>   		}
> -		ret =3D efi_search_protocol(handle, &efi_guid_device_path,
> -					  &handler);
> +
> +		ret =3D efi_search_protocol(handle, &efi_guid_device_path, &handler);
>   		if (ret !=3D EFI_SUCCESS)
>   			continue;
> +
>   		dp_current =3D handler->protocol_interface;
>   		if (short_path) {
>   			dp_current =3D efi_dp_shorten(dp_current);
>   			if (!dp_current)
>   				continue;
>   		}
> +
>   		len_current =3D efi_dp_instance_size(dp_current);
> +
>   		if (rem) {
> -			if (len_current > len)
> +			/* If current path is shorter than or equal to input path */
> +			if (len_current <=3D len) {
> +				if (memcmp(dp_current, dp, len_current))
> +					continue;
> +				if (!rem)
> +					return handle;
> +				if (len_current > best_len) {
> +					best_len =3D len_current;
> +					best_handle =3D handle;
> +					*rem =3D (void *)((u8 *)dp + len_current);
> +				}
> +			}
> +			/* If current path is greater than input path */
> +			else if (len_current > len) {
> +				if (memcmp(dp, dp_current, len))
> +					continue;
> +				if (len > best_len) {
> +					best_len =3D len;
> +					best_handle =3D handle;
> +					*rem =3D (struct efi_device_path *)((u8 *)dp_current + len);
> +				}
> +			} else {
>   				continue;
> +			}
>   		} else {
> -			if (len_current !=3D len)
> +			if (len_current =3D=3D len) {
> +				if (memcmp(dp_current, dp, len_current))
> +					continue;
> +			}
> +			/* If current path is greater than input path */
> +			else if (len_current > len) {
> +				if (memcmp(dp, dp_current, len))
> +					continue;
> +			} else {
>   				continue;
> -		}
> -		if (memcmp(dp_current, dp, len_current))
> -			continue;
> -		if (!rem)
> +			}
>   			return handle;
> -		if (len_current > best_len) {
> -			best_len =3D len_current;
> -			best_handle =3D handle;
> -			*rem =3D (void*)((u8 *)dp + len_current);
>   		}
>   	}
> +
>   	return best_handle;
>   }
>  =20
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 130c4db9606..49f8b5935f4 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -339,7 +339,7 @@ efi_fs_from_path(struct efi_device_path *full_path)
>   	efi_free_pool(file_path);
>  =20
>   	/* Get the EFI object for the partition */
> -	efiobj =3D efi_dp_find_obj(device_path, NULL, NULL);
> +	efiobj =3D efi_dp_find_obj(device_path, &efi_system_partition_guid, NU=
LL);
>   	efi_free_pool(device_path);
>   	if (!efiobj)
>   		return NULL;

