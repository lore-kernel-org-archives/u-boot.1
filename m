Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C192C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 05:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA21D8467B;
	Sun, 12 Jul 2026 07:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tqTeQyJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66EE2848A1; Sun, 12 Jul 2026 07:26:42 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643D1844F6
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 07:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783833999; x=1784438799; i=xypron.glpk@gmx.de;
 bh=cE1LGAc1wh6bVaG+X4gzlw43qyfYqD/NSYqvev5cpyA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tqTeQyJgYG+kDGyWEpufvvcOtvtr2R8BEjeobpxaDxRhLuQvOI2q2CVk6Hku64zB
 ZnuZz8hszf5J9Y4yjIm/6nh09IL24aOtVadBVvfV538YRYcc6ncWNfpPCPheCp3cv
 o0qxRT2U0U8mLIMOpg1flVvaDBWHXeP9CA6EruaLz+6yvWwVDZ+u0yYmTRCGKhIxC
 b3Pd/MI00RcV6PJ0WI+mgB/Le6qB8Ma96ZTZNR1wQ0d+NipApvFCPOZu0xNhnwWhu
 4Ui2sbPTkUnlEh3ObDUSojaDXaUETplxqdSvxhJAk8AAQ2HkQFcVC4VoQAlre8x36
 Tyiy/pQR8qQ59zMrDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4z6k-1xARyt1i9E-00yQNr; Sun, 12
 Jul 2026 07:26:39 +0200
Message-ID: <056cc92b-4c2f-417e-a48c-f15aa9786328@gmx.de>
Date: Sun, 12 Jul 2026 07:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] efi_selftest: free handles on teardown()
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260626-rev-v3-0-12a0c0fc0965@arm.com>
 <20260626-rev-v3-1-12a0c0fc0965@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260626-rev-v3-1-12a0c0fc0965@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uf3rSb5eMXExgRg+1FwHLr0rELl+1JkZul4tpC4MKxuM9BZU6IQ
 hbnPhkZlwHmHGblTXRna8iqvp7vZPlQnHznAwE7N6+3mdR+al5cTZR28tYktab/TkTfbwy3
 3sr4wAfOTASKt8E60FmoZm7Bs0cwfzxf/KBTmuZ1q0ZfOyzsy33S38+YHaNq55XeU6RsAAc
 I4wc4ixJ2/drzX3QLe31A==
UI-OutboundReport: notjunk:1;M01:P0:79f+FcY4IIs=;EUOS/dhUZ/FI+SeqEIe4g9zzWq0
 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
 eW8H9uB8DiN+7W3+TZRif
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

On 6/26/26 16:47, Vincent Stehl=C3=A9 wrote:
> In the block device selftest, make the handles pointer global and free i=
t
> also in teardown(), to simplify error handling.
>=20
> We also need to nullify the pointer after freeing it on the normal path,
> to avoid freeing it a second time during teardown().
>=20
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> ---
>   lib/efi_selftest/efi_selftest_block_device.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_self=
test/efi_selftest_block_device.c
> index 9c4be834eeb..b5f6f9353cd 100644
> --- a/lib/efi_selftest/efi_selftest_block_device.c
> +++ b/lib/efi_selftest/efi_selftest_block_device.c
> @@ -58,6 +58,9 @@ static const struct compressed_disk_image img =3D EFI_=
ST_DISK_IMG;
>   /* Decompressed disk image */
>   static u8 *image;
>  =20
> +/* Handles buffer */
> +static efi_handle_t *handles;
> +
>   /*
>    * Reset service of the block IO protocol.
>    *
> @@ -276,6 +279,15 @@ static int teardown(void)
>   			return EFI_ST_FAILURE;
>   		}
>   	}
> +
> +	if (handles) {
> +		r =3D boottime->free_pool(handles);
> +		if (r !=3D EFI_SUCCESS) {
> +			efi_st_error("Failed to free handles\n");
> +			return EFI_ST_FAILURE;
> +		}
> +	}
> +
>   	return r;
>   }
>  =20
> @@ -303,7 +315,6 @@ static int execute(void)
>   {
>   	efi_status_t ret;
>   	efi_uintn_t no_handles, i, len;
> -	efi_handle_t *handles;
>   	efi_handle_t handle_partition =3D NULL;
>   	struct efi_device_path *dp_partition;
>   	struct efi_block_io *block_io_protocol;
> @@ -372,6 +383,7 @@ static int execute(void)
>   		break;
>   	}
>   	ret =3D boottime->free_pool(handles);
> +	handles =3D NULL;	/* Avoid double free on teardown(). */

Thank you for fixing the memory leak.

handles is a static variable. Why do you explicitly set it to NULL?

Best regards

Heinrich

>   	if (ret !=3D EFI_SUCCESS) {
>   		efi_st_error("Failed to free pool memory\n");
>   		return EFI_ST_FAILURE;
>=20

