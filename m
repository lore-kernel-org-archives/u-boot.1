Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B74C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 10:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44C8C8752B;
	Mon, 25 Dec 2023 11:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="SFVbhOJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA228758C; Mon, 25 Dec 2023 11:05:04 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A078287480
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 11:05:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703498701; x=1704103501; i=xypron.glpk@gmx.de;
 bh=3xQasDYxcykcKPjt9sKPiiQV7JE7GiTwJWNpm+4ian0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=SFVbhOJqc1ZCWuieO7Ns8Nzm2I+VlocGU3/J+/6jMLZMDgI/csL6PeUUl8vw/1xM
 OkfeRP6zI/i9/VknL93LjgoffvzaknwroR0liao6DNPdggvKCGn9oaEFivmKShhuH
 Y1Pu+cjPtP1sE8hwjHoXyxG0zAP5az2jQJm94q+LCxnl/QbH2UXTom9xBczIPIb04
 DIOcKuimogzvzrRDLjD6Au2NGOQQCAYm/Gl2irMFC3GI2hAmILloXfEAyKgz8tdfF
 MF6HmJrzZ5BuxDMrTzWzg9uG9iMQ4/8WUC/5Ks+NL9tFDOa8Rq0tn6NQayQml2BU5
 9+locrx/w9icbByNkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.136] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ3n-1rnHS41Nfp-00WCpP; Mon, 25
 Dec 2023 11:05:01 +0100
Message-ID: <585c8dd4-2fc9-44ff-b71b-ca1ad384c223@gmx.de>
Date: Mon, 25 Dec 2023 11:05:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] efi_loader: avoid pointer access after calling
 efi_delete_handle
Content-Language: en-US
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Takahiro Akashi
 <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
References: <20231225044356.626900-1-masahisa.kojima@linaro.org>
 <20231225044356.626900-3-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231225044356.626900-3-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vzZIodXM/yMV7PUdvoc4vsLQ5Kpfx2YurhmVBqBiEhKJo8upVoO
 vipcMoNeI0UujPkgYMF6tiG6Aa9+OX86PMU1a0VKa56XGweE2aL4yejWa6CfsQlSM9oYDAT
 2P5DiUsKEOQm/QPpoS6/XBOpHTicaO59rut38bEP0WOQZ8dVT2xbOQp+eMT8aq/3PmEqTz3
 BCz7uV0eM6Aq4ZEFQsdpg==
UI-OutboundReport: notjunk:1;M01:P0:KH21HDpTUQs=;HYJuPkKXSGgAGPY2uRfCDcyZ2M5
 U1uDs1kTljpuLMoHyXH9IDEEayd/vkuabkU35zYI6Vm8Z3J1w7JlZOFSRFcdthvGjTOov1PLO
 9+BQjvavi+svqjp9ZTqHX8AqLevLQHqcA3wDnpue3/QoUMK9muhMsqrxu0MAqLbEX5vYIqTb1
 j17leuz/MOUQydoz/oi1y5u4h0elt8xRMm1uHemFBF9CANhbFDeDGw6bdxRlnZ2tKqvtQ11RN
 tI6IfmKFoRe43MSJQupb7JlAX6vj4gfCl4pP9l8VbsF8aeqqfSo/PCXcousXlP4ntOXZwzJzw
 EpSWntX64TMzb95Z74/aiKMXSw+8FTPp2mRknNVMNBZGRMb6KZAcLg37luj23jsx90+556+42
 AwlgtX6Ea1jHpp5zt6kbiqs/r5nNJldNmc/xAQVslgBY0XXAB7eNsfsNVGJyLAwPv42QI9cYJ
 4MLOyiZz5szf9OMhGZLKIIJwrbL7Y9zz4JCHiNJw4FV3ofZauDw3TZKvhf6DmklDVihEXYUwA
 69OvXeRFqzZdKtYwg2aNLC3+EQqUpq7ZPOL31qaDbFXJiWRWlA/oi3iJmMgUC44nqzlLMJkgV
 sZdYdbEcKPNMnXRoFM1Fgk+4R85yoP0cSw/MlRUw0l3TxI8GAjIq/tEMiBdCWuEj711q7oSNO
 277egMdn4J3pNi9kI9wjxMEwJBTEDb6JtJrH9ulitTxUU+K+fW4HXYAF6EAj22CJDn+uCZOwe
 JU1S0EQJFIjNsdOxzR/UMH/8zWMmHXlXInmZUAls0pxNKS54d2fL5UYs5lMpbihjPySmmN8MU
 rMokts6lL/A53y24Icwnt8U2JZX/oW5dxYf84uGIsovHaYtFoD6mDoCoBhaP66LSpLmOAWIvK
 VPJduFe8bnGds9rte9vaFzCcNw7nuVjAHtPRBJgIxWVdAjg1uTARCB+WUwnZVilJymTcvjbhr
 GoAxKw==
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

On 12/25/23 05:43, Masahisa Kojima wrote:
> efi_delete_handle() calls efi_purge_handle(), then it finally
> frees the efi handle.
> Both diskobj and handle variables in efi_disk_remove() have
> the same pointer, we can not access diskobj->dp after calling
> efi_delete_handle().
>
> This commit saves the struct efi_device_path pointer before
> calling efi_delete_handle(). This commit also fixes the
> missing free for volume member in struct efi_disk_obj.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>   lib/efi_loader/efi_disk.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index a2f8b531a3..415d8601ba 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -701,7 +701,9 @@ int efi_disk_remove(void *ctx, struct event *event)
>   	struct udevice *dev =3D event->data.dm.dev;
>   	efi_handle_t handle;
>   	struct blk_desc *desc;
> +	struct efi_device_path *dp =3D NULL;
>   	struct efi_disk_obj *diskobj =3D NULL;
> +	struct efi_simple_file_system_protocol *volume =3D NULL;
>   	efi_status_t ret;
>
>   	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
> @@ -722,14 +724,18 @@ int efi_disk_remove(void *ctx, struct event *event=
)
>   		return 0;
>   	}
>
> +	if (diskobj) {


   diskobj =3D container_of(handle, struct efi_disk_obj, header);

can be replaced by

   diskobj =3D handle

We should check the handle immediately after dev_tag_get_ptr() and
return 0 if the handle =3D=3D NULL.

> +		dp =3D diskobj->dp;
> +		volume =3D diskobj->volume;
> +	}
> +
>   	ret =3D efi_delete_handle(handle);

We must not delete the handle in case of UCLASS_EFI_LOADER.

Instead of calling efi_delete_handle we should uninstall all protocols
that we have installed. If no protocol is left the handle will go away.

To make the protocols to delete tractable they should be opened with
BY_DRIVER.

When a partition is removed we must close the protocol interfaces opened
with EFI_OPEN_PROTOCOL_BY_CHILD_CONTROLLER (cf. efi_disk_add_dev()).

Best regards

Heinrich

>   	/* Do not delete DM device if there are still EFI drivers attached. *=
/
>   	if (ret !=3D EFI_SUCCESS)
>   		return -1;
>
> -	if (diskobj)
> -		efi_free_pool(diskobj->dp);
> -
> +	efi_free_pool(dp);
> +	free(volume);
>   	dev_tag_del(dev, DM_TAG_EFI);
>
>   	return 0;

