Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1FFC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 12:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E4882A33;
	Tue, 15 Apr 2025 14:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rsgeESvx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECCA582A96; Tue, 15 Apr 2025 14:53:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E39CB8214D
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744721590; x=1745326390; i=xypron.glpk@gmx.de;
 bh=b8+ZwmyzP+XpmQkzKehMf+EpuLJUKZKF6cpqjyhTDLk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rsgeESvx8bPodyDueYgHFTovO8vPtP/2XUQny9tvWwLgnRB/NWFG2DV0DmiCYuJL
 FbHZPwAMGC70lX/k+JraI+34oY6TAaYIe/JQ+1T0SPWPgZuQ7UsDQCErROvOeUAIj
 BZFX2frcfVFenv6+bjtbiWM5P6RBeMf98KQEDAV7k+MZnkBwsuyebPEFxYcuvvyQ7
 4Sap/GDVGeZDknBTkz71xprL95xGUMaC7yRNQ8sBPBppkDP8xFcO6+g3+DKmxU07X
 G/nJlz07h9SVrgQeZiasZNDM+6ILBdH/l/d8CwDCek9mJ+AJuERdX8EDsRopOijJH
 Ov0rKgz8odkymRnEHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([46.114.110.131]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1tH38z1CdT-00geyM; Tue, 15
 Apr 2025 14:53:10 +0200
Message-ID: <6f04a803-cc70-4220-b859-593aa36d578b@gmx.de>
Date: Tue, 15 Apr 2025 14:53:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] efi_driver: efi_uclass: Add unbind method to
 efi_driver_ops
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 =trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
 <20250311164758.421900-10-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250311164758.421900-10-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aiXHWV4Pya805vOZlj7hRZ+J0tke3CNFDYCmaQcE8/l0gPT33xA
 ElHKiOC47oTK5cbHCGhV4+Lrf3Zm7OnbsIjo+ONyvwP/PP6VEc6PhVGfEETdXzy1mLmTgI3
 T12eIhv8tIArI3qeQEILKONI7wHYvR92ygRLWEEYNkE055U0S4sK7ADHUkoKngx5SOLMoj/
 e/VRPAOlkHAh3tn6Qc/TA==
UI-OutboundReport: notjunk:1;M01:P0:QpUGlIzBo38=;yIRTu3PMyPrzbmwr0tZ+E7qfLT7
 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
 3icORcplotbtKLxnyjf5L4=
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

On 11.03.25 17:47, Adriano Cordova wrote:
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   include/efi_driver.h        | 4 ++++
>   lib/efi_driver/efi_uclass.c | 4 ++++
>   2 files changed, 8 insertions(+)
>=20
> diff --git a/include/efi_driver.h b/include/efi_driver.h
> index 63a95e4cf80..8f785f79459 100644
> --- a/include/efi_driver.h
> +++ b/include/efi_driver.h
> @@ -36,6 +36,8 @@ struct efi_driver_binding_extended_protocol {
>    *			driver binding protocol.
>    * @bind:		Function called by the EFI uclass to attach the
>    *			driver to EFI driver to a handle.
> + * @unbind:		Function called by the EFI uclass to detach the
> + *			driver to EFI driver to a handle.
>    */
>   struct efi_driver_ops {
>   	const efi_guid_t *protocol;
> @@ -43,6 +45,8 @@ struct efi_driver_ops {
>   	efi_status_t (*init)(struct efi_driver_binding_extended_protocol *thi=
s);
>   	efi_status_t (*bind)(struct efi_driver_binding_extended_protocol *thi=
s,
>   			     efi_handle_t handle, void *interface);
> +	efi_status_t (*unbind)(struct efi_driver_binding_extended_protocol *th=
is,
> +			       efi_handle_t handle);
>   };
>  =20
>   #endif /* _EFI_DRIVER_H */
> diff --git a/lib/efi_driver/efi_uclass.c b/lib/efi_driver/efi_uclass.c
> index fc8808374a1..36a86817eb7 100644
> --- a/lib/efi_driver/efi_uclass.c
> +++ b/lib/efi_driver/efi_uclass.c
> @@ -249,6 +249,10 @@ static efi_status_t EFIAPI efi_uc_stop(
>   	if (ret !=3D EFI_SUCCESS)
>   		log_err("Cannot free EFI memory pool\n");
>  =20
> +	ret =3D bp->ops->unbind(bp, controller_handle);

This leads to a crash as unbind() has neither been implemented for EFI=20
block devices nor for EFI network devices at this point.

Please, check if unbind() is non-zero, and return EFI_DEVICE_ERROR in=20
this case.

Best regards

Heinrich

> +	if (ret !=3D EFI_SUCCESS)
> +		goto out;
> +
>   	/* Detach driver from controller */
>   	ret =3D efi_close_protocol(controller_handle, bp->ops->protocol,
>   				 this->driver_binding_handle,

