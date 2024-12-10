Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A9FE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 08:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699458932C;
	Tue, 10 Dec 2024 09:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JU7YEDkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D577E89490; Tue, 10 Dec 2024 09:45:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F6E89206
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 09:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733820347; x=1734425147; i=xypron.glpk@gmx.de;
 bh=poCiGqWZZa49xbX5ig29Z3I+VGOozjvcl3UnuxzEK+Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JU7YEDkXskqSfJlcm8s7MH5P8fFLDY80d7YN7g5UXLOveBZBZy2GqYm3yk+o4jOz
 k/Eu3cwT05l3McSvUfOWujvPH8klYC67mnmQ1MsKV4RMkwU4ZntjXdwPeeNrXMWCg
 dCWJ25MorBrP1/F3xXhUtH/aiCAhLNfbjvsT4SqRZDcRUVpZ+0I0VQQ39vITV8Xc4
 QVLvdGiFGEne0xk9dbbkW3hjpFbwN4e2EgHHMYDSFE/kGZ1X96/P2TD0htkG8DwNS
 lyNWINz9H74EgKFcTaPPDvkkh4od9wmnF/w3/g6qlThe4p/xvZdJiOgHjax0vTH39
 kypxx892x0aDuYcJfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlKy-1tpZj11YP2-00fCBB; Tue, 10
 Dec 2024 09:45:47 +0100
Message-ID: <1a9d7b81-b06f-43bd-969e-2961ad8cd1e0@gmx.de>
Date: Tue, 10 Dec 2024 09:45:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] Fix efi_bind_block.
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Janis Danisevskis <jdanisevskis@aurora.tech>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-10-mjg59@srcf.ucam.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241123195616.305687-10-mjg59@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tHYXZ7zMqVgFUt9KyfNLGfWNgYbJx10Y7rT0Rzx0r/YHbpu63f7
 6AyLNFTPC6Za85eSUpDTWJ6mKUXoo2bUj7v3txJJAx1uq8H/tZGKZvvSzzKxeyM5xLlynFz
 NE+oO6DGLqivlPuKMvcxAB94BGkj7iV3t7qVvaeTgS+YsXL/Lw0oLkZhvHm4d/uLjaC/Kl/
 OOXD+Mc83YsE50eX3VKJg==
UI-OutboundReport: notjunk:1;M01:P0:D78u+AhUSSU=;ejbeo55UU0JWm6y0FcNgTgWrAhe
 +aW8eZtPNK7RJn/xDx86T74JoFVQ0dtPgUp6fudziguHKW2+jwT3F1C6eA6Qe0j8m5cWeqEoL
 a/7DtFOLzwfkA7l5o0nsjUP4X2js7NnCoY/N3xzOvOAIqq/QADvjDWRyGzGAUtrUBgIivo6Pf
 rWBsVF427gsuOLo0BhV/Ht090xn0+zsIYG81pzUrMOMHCiQGjMpNVtd3uz21FEqw7O8QV8Q35
 T8dPeKFghhY41g1uoc/97WSk6mZ5WrNeffvC7TqPJRqYp/yMhI7SK18szZ/HA6nUc/dxtdYRc
 3mRThXMiTyvSiXsJH4haD+4hHV8g49sGSnuSI3NV9xWb+lf6N8IR2Nyi5OEUf4N+ZeDUAqOKq
 TBeOXWnjoEBTI7RtlfIWQqrmfyrdXFIDxDn0jiJ30no+xEVQu0npz2YorVPBBiSD6rvG0xmsT
 ZpfM+yBTy9FBo/Y0PDqBdbweOaTZALI1j6M9jBoCKsy35Fm6qhiogvChvxEwFnjFbnHA0YoE2
 689F5fcZ+KVLIxwwcZN/bYiYzbvyZO+9A3KvofpDM/T5cK7KauSAfXQsyi7pxySVTTtld2XC+
 4l2TVS0hKSGGARF98qYil2rAQY5cX7fRG+7sM3rdE5BQOXa9YazY/+ERa4gCcwvscQuD/JARg
 XCpXNsGe3TUYwpyiHTG8Y8phnR3ZeDjjHqvKKOlc0d0mvPoxjL+R1KXmIsVrpN3H5n/XtCh/o
 5erubr8DPMg86WPYxHiUlKZM/tOGfnd2RA+UtGA+9XMNzeTM9WbPyeMBjHm2w5z/OZCiAnYKV
 NMKMolPpBTT7N+4fgbm35+gZLZX6fEtHxbjdv5brfrZaRePeASYf/1MShFOP6B/H1IQ2388IO
 kspBhAmoZY7/G8sO5/a6VMXmD/WIEN3YLerpenKm53dtd44vkGMFWp9H0fq7Rm7W9Zfrjxdb/
 kV7ez5vJmlTAbmau4dh9SpZ2OgB0XkEJ2lLR/lr337EENpIa3lZGLLTPEsxWoYbjMAOUsusMy
 +Q1I7hQrS9gbVGOSDo6vMqWYG2xYbS9OtcF6D2cb4rkkZoopzuvz44+/pjZp2if2TY67oi6mQ
 4pFT8hbaBUjpesiDIcTfdtpvz6WnZL
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

On 23.11.24 20:55, Matthew Garrett wrote:
> From: Janis Danisevskis <jdanisevskis@aurora.tech>
>
> efi_bind_block had two issues.
> 1. A pointer to a the stack was inserted as plat structure and thus used
> beyond its life time.
> 2. Only the first segment of the device path was copied into the
> platfom data structure resulting in an unterminated device path.
>
> Signed-off-by: Janis Danisevskis <jdanisevskis@aurora.tech>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>   lib/efi/efi_app_init.c | 29 +++++++++++++++++++++--------
>   1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
> index 9704020b749..cc91e1d74b8 100644
> --- a/lib/efi/efi_app_init.c
> +++ b/lib/efi/efi_app_init.c
> @@ -19,6 +19,15 @@
>
>   DECLARE_GLOBAL_DATA_PTR;
>
> +static size_t device_path_length(const struct efi_device_path *device_p=
ath)
> +{
> +	const struct efi_device_path *d;
> +
> +	for (d =3D device_path; d->type !=3D DEVICE_PATH_TYPE_END; d =3D (void=
 *)d + d->length) {
> +	}
> +	return (void *)d - (void *)device_path + d->length;
> +}
> +
>   /**
>    * efi_bind_block() - bind a new block device to an EFI device
>    *
> @@ -39,19 +48,23 @@ int efi_bind_block(efi_handle_t handle, struct efi_b=
lock_io *blkio,
>   		   struct efi_device_path *device_path, int len,
>   		   struct udevice **devp)
>   {
> -	struct efi_media_plat plat;
> +	struct efi_media_plat *plat;
>   	struct udevice *dev;
>   	char name[18];
>   	int ret;
> -
> -	plat.handle =3D handle;
> -	plat.blkio =3D blkio;
> -	plat.device_path =3D malloc(device_path->length);
> -	if (!plat.device_path)
> +	size_t device_path_len =3D device_path_length(device_path);
> +
> +	plat =3D malloc(sizeof(struct efi_media_plat));
> +	if (!plat)
> +		return log_msg_ret("plat", -ENOMEM);
> +	plat->handle =3D handle;
> +	plat->blkio =3D blkio;
> +	plat->device_path =3D malloc(device_path_len);
> +	if (!plat->device_path)
>   		return log_msg_ret("path", -ENOMEM);
> -	memcpy(plat.device_path, device_path, device_path->length);
> +	memcpy(plat->device_path, device_path, device_path_len);
>   	ret =3D device_bind(dm_root(), DM_DRIVER_GET(efi_media), "efi_media",
> -			  &plat, ofnode_null(), &dev);
> +			  plat, ofnode_null(), &dev);
>   	if (ret)
>   		return log_msg_ret("bind", ret);

Here you have a memory leak for pointer plat if ret !=3D 0.

Simon suggested a follow up patch. Instead we should fix it in this patch.

@Simon
The logic in the caller setup_block() looks wrong.

LocateHandle() does not ensure that when you try to read from the block
device the same still does exist. E.g. if a USB device is removed the
block IO protocol could be uninstalled and the handle deleted and the
EFI app may crash. Please, call OpenProtocol() with attribute BY_DRIVER.

HandleProtocol() is considered deprecated. Please, use OpenProtocol()
instead.

Best regards

Heinrich
