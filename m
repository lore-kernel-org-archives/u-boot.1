Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12AECD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 18:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23928847C4;
	Wed, 27 May 2026 20:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jZlciTIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F5C584878; Wed, 27 May 2026 20:47:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B44384704
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 20:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779907623; x=1780512423; i=xypron.glpk@gmx.de;
 bh=iApPnzSX4ZVAAhpSbWu8PcVeA6iIPtVcJtm65iUwCQM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jZlciTIWZmZUpqcNTK89m14++logq3L/usA/0DWr5PEvb73pZm6Wtq80TKTBr1zH
 +Q7RQyl1C0dZDrubWmrCTqCTI+20PtDVzKRc0DPMPBRFT9w8Szy71x054lkT6YVUV
 xJQaCMSxvTHEY2Cj+WEL5B0e/fr4o4s1SHzPVYVZs8rjAasRCyBTlMAHwLx4W/mP8
 8+YCxoPSVxIIanspVMl/PGx92Wy1476EqRQSljPJWYPa8eSnXKcFuqxjCL25SuLMJ
 hnpbD0RFVS9bgPpRLsVXg31DOvj0AAmW42F2FIEqWrfeZAJyBd5fvCayyY/nwTmb4
 b0FLQMufNKzHeoytFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1wQNs01hgt-005HxV; Wed, 27
 May 2026 20:47:03 +0200
Message-ID: <1f9a1b3f-9894-45db-a777-e2f15f5f2d24@gmx.de>
Date: Wed, 27 May 2026 20:47:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] virtio: emul_blk: Free disk data on remove
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260527161033.3273795-1-sjg@chromium.org>
 <20260527161033.3273795-12-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260527161033.3273795-12-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1ZxmkUu6RuCNbJF52o5nFfB4+8j8PRfb50OPEdJs5tBrbXFqJOA
 8DLtycZNWjjAlIGtvZeqAh87F/41fOu8KMihO8T6o8YFiw5ayaH3w5CwK4wmTg3Ac1cbaNC
 ixUGNA8Xq7ZFPEyoXZ+mPAtZgvnmQSGXn9he0m7uLZb8DxA8v8ZnlxHlJ76nHMyW1+R0dkS
 +srmPQI97JzPMdQhzo8wQ==
UI-OutboundReport: notjunk:1;M01:P0:cZW9uRVUG+0=;+rNH7tQ6wZ1u/zaKGyUdIgP3AP8
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

On 5/27/26 18:10, Simon Glass wrote:
> The probe function allocates 1MB for the emulated disk contents but
> there is no corresponding free on remove, so the memory leaks every
> time the device is torn down. This shows up as a 1MB leak per test in
> several bootstd tests.
>=20
> Add a remove method to free the buffer.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Why don't you add the function in the patch introducing
drivers/virtio/emul_blk.c?

Best regards

Heinrich

> ---
>=20
>   drivers/virtio/emul_blk.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/virtio/emul_blk.c b/drivers/virtio/emul_blk.c
> index 62ee125cf3c..ec5e715a460 100644
> --- a/drivers/virtio/emul_blk.c
> +++ b/drivers/virtio/emul_blk.c
> @@ -154,6 +154,15 @@ static int virtio_blk_emul_probe(struct udevice *de=
v)
>   	return 0;
>   }
>  =20
> +static int virtio_blk_emul_remove(struct udevice *dev)
> +{
> +	struct virtio_blk_emul_priv *priv =3D dev_get_priv(dev);
> +
> +	free(priv->disk_data);
> +
> +	return 0;
> +}
> +
>   static struct virtio_emul_ops blk_emul_ops =3D {
>   	.process_request =3D blk_emul_process_req,
>   	.get_config =3D blk_emul_get_config,
> @@ -171,6 +180,7 @@ U_BOOT_DRIVER(virtio_blk_emul) =3D {
>   	.id	=3D UCLASS_VIRTIO_EMUL,
>   	.of_match =3D virtio_blk_emul_ids,
>   	.probe	=3D virtio_blk_emul_probe,
> +	.remove	=3D virtio_blk_emul_remove,
>   	.ops	=3D &blk_emul_ops,
>   	.priv_auto	=3D sizeof(struct virtio_blk_emul_priv),
>   };

