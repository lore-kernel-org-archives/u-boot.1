Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98852CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 18:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD3E847C4;
	Wed, 27 May 2026 20:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dl62fvLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3C08484F; Wed, 27 May 2026 20:39:48 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B509484704
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 20:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779907185; x=1780511985; i=xypron.glpk@gmx.de;
 bh=pMf07RwIQLBmemVmSvrEu7foSFLM1p8nThaNPd+VLA4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dl62fvLxoMSaGQi4RQIrL0Qyg9Rz6NBAGzoi6rQZJ4fl1Kl5Nk3wq9tLxlfkHWFf
 4Q/zgNfoTC9T67zZBCwrRJotQiaotk9o9QYDbYL8lzl9A6Wt7oWr0AMFgtGaDfgUJ
 MN+1Kj93fvbfBREfnAqDZRZX6W5PO4SUusg4Sf5zbftlH9MJ4eXpBGaJfVDRYXvXd
 mXlz3ZLxfvsHc0w8/+9+v41XLKApM5aMlbWcWr7H2i+9HhlOq5G878AGypvU4kp4I
 WBFSFz6j/t2bptFtprKSlzl00yreOVMW5NcSGp6vw/wfewhegL+IvZUBdnYY8s5Zt
 4GPYe1KMS1cGVJPf2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQkE-1xEtVZ2Ddw-013xh2; Wed, 27
 May 2026 20:39:45 +0200
Message-ID: <6ff7e849-150d-4c2a-a56b-566a615009d6@gmx.de>
Date: Wed, 27 May 2026 20:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] virtio: Rename a few legacy-PCI functions
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260527161033.3273795-1-sjg@chromium.org>
 <20260527161033.3273795-10-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260527161033.3273795-10-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6oHzF/iBNBg18ObVHNWXdARXMFZiiHv1YtpH+AyRZ4shy5DnqOz
 2jFnCyDtdYbU6pLzLcGuUb/42JcjL6+LeK/VyUhu/ommZEmjnUQjN2+BKdK94McyRTi9QBY
 hsn4aR/mW/I8R3OIhaN9sLW8Z4AcTpuT4qzkZ+2pUw7D1il4OHEwj/ypdSeq3KY2c0s8mDE
 Tp/qtOW0ze+3UvlIGQhAA==
UI-OutboundReport: notjunk:1;M01:P0:ul72B2MTmEo=;NWav+gu2nI9QUiFJktY2pOXeeQo
 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
 5+tObnNYRlf/mJq+gM=
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

On 5/27/26 18:10, Simon Glass wrote:
> With LSP it is confusing to have two functions named the same in
> different files. Rename a few of the legacy ones.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

LGTM

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>=20
>   drivers/virtio/virtio_pci_legacy.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_=
pci_legacy.c
> index 15f8c6e7d25..fe3e3b475ea 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -277,7 +277,7 @@ static int virtio_pci_notify(struct udevice *udev, s=
truct virtqueue *vq)
>   	return 0;
>   }
>  =20
> -static int virtio_pci_bind(struct udevice *udev)
> +static int virtio_pci_bind_legacy(struct udevice *udev)
>   {
>   	static unsigned int num_devs;
>   	char name[20];
> @@ -289,7 +289,7 @@ static int virtio_pci_bind(struct udevice *udev)
>   	return 0;
>   }
>  =20
> -static int virtio_pci_probe(struct udevice *udev)
> +static int virtio_pci_probe_legacy(struct udevice *udev)
>   {
>   	struct pci_child_plat *pplat =3D dev_get_parent_plat(udev);
>   	struct virtio_dev_priv *uc_priv =3D dev_get_uclass_priv(udev);
> @@ -348,8 +348,8 @@ U_BOOT_DRIVER(virtio_pci_legacy) =3D {
>   	.name	=3D VIRTIO_PCI_DRV_NAME,
>   	.id	=3D UCLASS_VIRTIO,
>   	.ops	=3D &virtio_pci_ops,
> -	.bind	=3D virtio_pci_bind,
> -	.probe	=3D virtio_pci_probe,
> +	.bind	=3D virtio_pci_bind_legacy,
> +	.probe	=3D virtio_pci_probe_legacy,
>   	.priv_auto	=3D sizeof(struct virtio_pci_priv),
>   };
>  =20

