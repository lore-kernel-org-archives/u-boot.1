Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B59F3C9A5
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE67E83981;
	Tue, 24 Feb 2026 16:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="k4n2HGQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B45AC83D8A; Tue, 24 Feb 2026 16:55:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE7AD83642
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771948552; x=1772553352; i=xypron.glpk@gmx.de;
 bh=xPsfdM/NcHI29RZ6w6wRIgZhwfumXOU946d3Hf4o+d0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=k4n2HGQYJFcdPtEn7Txx6NqT5iwu1SZa10HGMqx5anotOZXdhSnVLmMKWSuDMslU
 4yYdp5CuqQ/7VD+HExHTQsuhDPEVRzJQei+/hqsu/q/yEc7iWQ6rTN3mQDI1xGXqP
 9yYD5Zub3uEopGv8ukojdwDbT81zCMqv1e1pz8AeAiaWzPC/8l9r/KK8djdR0EOV7
 bkZUECOlnrLvu3XeeoLj91BRzYEVGOCyzQ5F6t5Nw0rK9Q4CRlGwrZY0+P137B8LV
 ZrwZ9S1PprLpqlVn1irGtfNiJlZFkVrUqLnlpxCIm+5dwjVtBI+zO98wrNpT5Xkrd
 JAT2pmwhAauCwxpKwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLi8g-1wCReB3jdo-00U86T; Tue, 24
 Feb 2026 16:55:51 +0100
Message-ID: <30557a69-fe8f-46dd-8486-e6e293287a3e@gmx.de>
Date: Tue, 24 Feb 2026 16:55:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] efi_selftest: cosmetic: fix spelling in comments
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260219184400.257008-1-vincent.stehle@arm.com>
 <20260219184400.257008-6-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260219184400.257008-6-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sxwwx3EAAyiIJNkfN2FkSEjIXfvh65xo65to+67kj4a0y6wwebl
 2muW1LHRgWOoVrcVbGaXDJOB/elEdYJ+l9Cmz4NySTXgPoSx1Uq01v62pt2GI07IVjOcuTq
 fpzrcfp8n58z2MCYEFMTPjmA3ZI2ohdYN+EeIjlPLu80PC+88wcIhZJg4R3i513PRrPB963
 afhN1ZNjB4TgfTA0UFdLA==
UI-OutboundReport: notjunk:1;M01:P0:yJmqUqddJkc=;BTW3MjvoHBA1u0I+Yt9c/+Fb6dp
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

On 2/19/26 19:44, Vincent Stehl=C3=A9 wrote:
> Fix a few UEFI function names, as well as a typo.
>=20
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_selftest/efi_selftest_manageprotocols.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/lib/efi_selftest/efi_selftest_manageprotocols.c b/lib/efi_s=
elftest/efi_selftest_manageprotocols.c
> index f07ff256ce1..a096e8c2b01 100644
> --- a/lib/efi_selftest/efi_selftest_manageprotocols.c
> +++ b/lib/efi_selftest/efi_selftest_manageprotocols.c
> @@ -6,7 +6,7 @@
>    *
>    * This unit test checks the following protocol services:
>    * InstallProtocolInterface, UninstallProtocolInterface,
> - * InstallMultipleProtocolsInterfaces, UninstallMultipleProtocolsInterf=
aces,
> + * InstallMultipleProtocolInterfaces, UninstallMultipleProtocolInterfac=
es,
>    * HandleProtocol, ProtocolsPerHandle,
>    * LocateHandle, LocateHandleBuffer.
>    */
> @@ -188,7 +188,7 @@ static int execute(void)
>   	}
>  =20
>   	/*
> -	 * Test error handling in UninstallMultipleProtocols
> +	 * Test error handling in UninstallMultipleProtocolInterfaces
>   	 *
>   	 * These are the installed protocol interfaces on handle 2:
>   	 *
> @@ -238,7 +238,7 @@ static int execute(void)
>   		efi_st_error("LocateHandleBuffer failed to locate new handle\n");
>   		return EFI_ST_FAILURE;
>   	}
> -	/* Clear the buffer, we are reusing it it the next step. */
> +	/* Clear the buffer, we are reusing it in the next step. */
>   	boottime->set_mem(buffer, sizeof(efi_handle_t) * count, 0);
>  =20
>   	/*
> @@ -287,7 +287,7 @@ static int execute(void)
>   	}
>  =20
>   	/*
> -	 * Test UninstallMultipleProtocols
> +	 * Test UninstallMultipleProtocolInterfaces
>   	 */
>   	ret =3D boottime->uninstall_multiple_protocol_interfaces(
>   						handle2,

