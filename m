Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85D3CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 20:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 211CB847C3;
	Wed, 24 Jun 2026 22:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lsj9QWIN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3458B847C8; Wed, 24 Jun 2026 22:21:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F528460E
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 22:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782332471; x=1782937271; i=xypron.glpk@gmx.de;
 bh=FnfGDLi+BMKU4gtiEPvedjAi8GEAd29VaOAiRnPEiMY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lsj9QWINzvx/X6AbARYzHd7MA4vUumrUZrnXPUumJqMVmg1dL5Aw17dDH1kpzwue
 l4ZcfEaEYi2e7s/Bwv8xF8raxMPiqoDVGDBH6SntWAuSoFJze7eICRmVx9ryl/Lua
 YNJk53s+HcFFs8QvKwcdN/FcsFaqouKW9WcIJYOYooit8j03/8qD49KOgyIx3aZJo
 c+xM2vkDoD1z5L+bB/Zt9JVwu2iPBWtD6yrM6WrW/Ou3TSjHM60CyZ93k1HsDWIde
 IJqt4PZtS5Wx11JsXyUpcGyL0MzJ7R2bH4UBrmNbGAlf8QEW0dOyudyeOsB5Ho9xM
 DXDdDHAFKTY7MQe24w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0G1n-1xOnLs35zL-00wG7N; Wed, 24
 Jun 2026 22:21:11 +0200
Message-ID: <f7900ff1-e515-4cba-963b-84d2d6c89ad5@gmx.de>
Date: Wed, 24 Jun 2026 22:21:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lib/efi_selftest: test block io revision
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260609-rev-v1-0-0ccae5bf0fc5@arm.com>
 <20260624-rev-v2-1-68beb809891a@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260624-rev-v2-1-68beb809891a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9qI729U38HIpJzdJjTfM+fDTNW74BTG2FhKrMcoA3aTRjw7Bbig
 ZKkm8tnx1bVXUl8oj7+yLI1E7TacYuFygxEIB/tNug92NkxCO7/8tLA9z9/wj+WVYCuaq5T
 HYlr52mtZDpvXoXKD2J11g6aqReJ/89JCuXZ8Mq+9/Uw1UIVQKE1eS19Z7uW5V4mw6KkW0H
 kYhyxxmszh73f9R9+JYYg==
UI-OutboundReport: notjunk:1;M01:P0:t7YitZYLFXI=;poQwgZgCRsZb4kpibBotBoX8irI
 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
 tHOCqRDz0piq8pY/IMjWR09G/D7ZHbRxQeJrMch
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

On 6/24/26 11:26, Vincent Stehl=C3=A9 wrote:
> Enhance the unit test to verify all Revision fields of all the
> EFI_BLOCK_IO_PROTOCOL structures.
> As the unit test registers its own block io protocol for test purposes,
> make sure to initialize its revision properly, as it will be verified as
> well.
>=20
> This can run on the sandbox with the following command:
>=20
>    ./u-boot -T -c 'setenv efi_selftest block device; bootefi selftest'
>=20
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Changes for v2:
> - Deal gracefully with no block io protocol found.
> - Print revision with %u in case of error as it is unsigned.
> ---
>   lib/efi_selftest/efi_selftest_block_device.c | 56 ++++++++++++++++++++=
++++++++
>   1 file changed, 56 insertions(+)
>=20
> diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_self=
test/efi_selftest_block_device.c
> index 9c4be834eeb..d2a1f2dc5d4 100644
> --- a/lib/efi_selftest/efi_selftest_block_device.c
> +++ b/lib/efi_selftest/efi_selftest_block_device.c
> @@ -170,6 +170,7 @@ static efi_status_t decompress(u8 **image)
>   static struct efi_block_io_media media;
>  =20
>   static struct efi_block_io block_io =3D {
> +	.revision =3D EFI_BLOCK_IO_PROTOCOL_REVISION3,
>   	.media =3D &media,
>   	.reset =3D reset,
>   	.read_blocks =3D read_blocks,
> @@ -603,6 +604,61 @@ static int execute(void)
>   		return EFI_ST_FAILURE;
>   	}
>  =20
> +	/* Get all handles with block io. */
> +	ret =3D boottime->locate_handle_buffer(BY_PROTOCOL,
> +					     &block_io_protocol_guid, NULL,
> +					     &no_handles, &handles);
> +	switch (ret) {
> +	case EFI_SUCCESS:

If EFI_SUCCESS and no_handles =3D 0 or handles =3D NULL, we have a bug.

> +	case EFI_NOT_FOUND:	/* no_handles =3D=3D 0, handles =3D=3D NULL */
> +		break;

Only for EFI_SUCCESS updating the two variables is mandated in the UEFI=20
specification. Don't expect no_handles =3D=3D 0 or handles =3D NULL here.
(I know EDK II and U-Boot currently do it. But here we are testing.)

In my v1 review I misguided you.

EFI_NOT_FOUND is a legal value but needs special treatment here:

In setup() we installed a block IO protocol. The protocol is not=20
uninstalled before teardown(). Execute() is only called if setup()=20
succeeded.

If we can't find any block IO protocol here, then something is badly=20
broken and we should error out with a specific error message, e.g.

"No block IO protocol found though one installed in setup\n"

> +	default:
> +		efi_st_error("Locate handle buffer failed\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
> +	/*
> +	 * Verify all handles with block io.
> +	 * If an error is encountered, the loop exits early instead of
> +	 * returning, to free the handles buffer.
> +	 */
> +	for (i =3D 0; i < no_handles; ++i) {
> +		u64 rev;
> +
> +		ret =3D boottime->open_protocol(handles[i],
> +					      &block_io_protocol_guid,
> +					      (void *)&block_io_protocol,
> +					      NULL, NULL,
> +					      EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("Failed to open block io protocol %d\n",
> +				     (unsigned int)i);
> +			break;
> +		}
> +
> +		/* Verify block io revision. */
> +		rev =3D block_io_protocol->revision;
> +		if (rev !=3D EFI_BLOCK_IO_PROTOCOL_REVISION2 &&
> +		    rev !=3D EFI_BLOCK_IO_PROTOCOL_REVISION3) {
> +			efi_st_error("Bad block io revision %u\n",
> +				     (unsigned int)rev);
> +			break;

Should we check that all function pointers are non-NULL, too?

Best regards

Heinrich

> +		}
> +	}
> +
> +	/* Free handles buffer. */
> +	if (handles) {
> +		ret =3D boottime->free_pool(handles);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("Failed to free block io handles\n");
> +			return EFI_ST_FAILURE;
> +		}
> +	}
> +
> +	/* If we exited the loop on block io handles early this is a failure. =
*/
> +	if (i !=3D no_handles)
> +		return EFI_ST_FAILURE;
> +
>   	return EFI_ST_SUCCESS;
>   }
>  =20
>=20
> ---
> base-commit: fcda974e36033ad5331a9b4a4a551af4e141ad7d
> change-id: 20260608-rev-772dedbb2fda
>=20
> Best regards,

