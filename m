Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EA7CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 08:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE3A8499C;
	Sun, 21 Jun 2026 10:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TICJUbgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0032849AE; Sun, 21 Jun 2026 10:51:30 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6ADC848DC
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 10:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782031886; x=1782636686; i=xypron.glpk@gmx.de;
 bh=BDm8ogOLejQs2OlOlO6f2Fvt2h5LIrmyqmPFZVgBC4o=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TICJUbgdgz8cKoPLkJaRMbQEAnR+e6vQMl5qr9jpiW3UmmnzYiDVwdEEC1C0+B5C
 1phWDFskYJ2Jxy03d5ysb3T8dMYNxVkf2+VnoUnmiK3j+FvnyYhLAWnxZm2stFE3G
 qDaNNd72GvmOA3LudXByejSqkEHmOUWIVIushGLgR3HwZ5MZshDDRAc5PwoXqN2+z
 NQoQDScD2XuqJrCRrIliTWRYjPDpTBKKTPwMrPzGiOeo35yFZLU7TPFeHWP4sTIyD
 N4+2ulyPdeEoyhTXdulHoP/puYWoK5euji2YCrHIOwSgTdlfujH1Sa/G5IKb8H/Z8
 2sC8t/Hj8h6LPr94nA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhhX-1wQSXB0lQV-003nEB; Sun, 21
 Jun 2026 10:51:26 +0200
Message-ID: <95af39e2-2f7a-4886-b0dc-2aded14b46c3@gmx.de>
Date: Sun, 21 Jun 2026 10:51:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lib/efi_selftest: test block io revision
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260609-rev-v1-0-0ccae5bf0fc5@arm.com>
 <20260609-rev-v1-2-0ccae5bf0fc5@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260609-rev-v1-2-0ccae5bf0fc5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b+1Zq4AIPnN0mripDIBIOOzkHD7tLIbBDBEyuLhcI5GEMl+P93J
 GEHN17DoCfevBE8jBpMfMq70qqrXnLo7A/dRk6OmifAy9pMyg72bfx+GHWIA+u5T9Bp4DFk
 ce0oMEEDYMtlupSiy30mTfAvqrkPW/RvgdZbQUWO+BHmQbMPC0KKdmjTY5aqdU09mCsWy94
 6hPNcl1GjpwJMQ72/wHwQ==
UI-OutboundReport: notjunk:1;M01:P0:SGHEf6E8i0Q=;iqw7lglXLueAz+JRxEQicD0wSnw
 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
 sJR9wKV9+Rpr+iOSqdpJsv4zrAk=
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

On 6/9/26 10:07, Vincent Stehl=C3=A9 wrote:
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
>   lib/efi_selftest/efi_selftest_block_device.c | 50 ++++++++++++++++++++=
++++++++
>   1 file changed, 50 insertions(+)
>=20
> diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_self=
test/efi_selftest_block_device.c
> index 9c4be834eeb..6fade3e9159 100644
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
> @@ -603,6 +604,55 @@ static int execute(void)
>   		return EFI_ST_FAILURE;
>   	}
>  =20
> +	/* Get all handles with block io. */
> +	ret =3D boottime->locate_handle_buffer(BY_PROTOCOL,
> +					     &block_io_protocol_guid, NULL,
> +					     &no_handles, &handles);
> +	if (ret !=3D EFI_SUCCESS) {
> +		efi_st_error("Failed to locate block io handles\n");
> +		return EFI_ST_FAILURE;
> +	}

Thank you for providing this test.

The test should pass when invoking U-Boot without any block device.

EFI_NOT_FOUND should not be reported as failure instead you should leave=
=20
with EFI_ST_SUCCESS.

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
> +			efi_st_error("Bad block io revision %d\n",

The field is unsigned. So we need %u here.

Best regards

Heinrich

> +				     (unsigned int)rev);
> +			break;
> +		}
> +	}
> +
> +	/* Free handles buffer. */
> +	ret =3D boottime->free_pool(handles);
> +	if (ret !=3D EFI_SUCCESS) {
> +		efi_st_error("Failed to free block io handles\n");
> +		return EFI_ST_FAILURE;
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

