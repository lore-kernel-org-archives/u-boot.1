Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D555C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 11:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0284C81D5D;
	Fri,  4 Jul 2025 13:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PUvSh06I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1956C82ED0; Fri,  4 Jul 2025 13:41:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1B82803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 13:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751629285; x=1752234085; i=xypron.glpk@gmx.de;
 bh=nXkS9lCK/fmerGdSRoQKW90ZWI1CRfXjvFwZ5W2sur8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PUvSh06I0hG/+sjl2+7CdLtWTmggq7nz71H2Ct+QGzEmFKVQqSUjsAgcsHMZwBqe
 sTCiFRBRLLAO6NBfBO+CVsLFNYEgt2200Ivv1Bo/i0xvUF2fgAlaXLWxMDsKsaSEm
 MIqX5KbnVvLYT7BZexB2WsPjTBf04gDbp1M813EIKcLxWQc3yDZq77o8cZpBIT2gu
 HGEIjZqFo7iJ6KZYsHVyrM8fWqvQmaC/cuYDIyCrvOjdjq+YPRPm512hy4g10X2tn
 u3cqBjwwjpD+7tH2Cn4mJyxgjo2XGnRMI8CnIVLJLAlFmreqqN3sLHw3T6cGDhOGL
 t00nO6IAkeNnI8nlPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1uSeqV16TS-00Faem; Fri, 04
 Jul 2025 13:41:25 +0200
Message-ID: <64c4cb36-2be8-425c-b3ee-dca1b25d0f9f@gmx.de>
Date: Fri, 4 Jul 2025 13:41:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/25] efi_loader: capsule: Add runtime capsule flags
 checks
To: abdellatif.elkhlifi@arm.com
Cc: trini@konsulko.com, Emekcan Aras <emekcan.aras@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
References: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
 <20250702152528.1180414-21-abdellatif.elkhlifi@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250702152528.1180414-21-abdellatif.elkhlifi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yk/33A9KVqdKg+gKunQe+6ca0J15gAJLmsIGF/Y4qIXk6zutnP9
 9FQruWOHzVm878lEwcie/op63RUG9Yd4alep7syLv1/3Zk5TmVC2Lf19uzm+4rIIZFI3bH0
 t9jH/utTwJPbnTziYiwP4lFgfVs4+oPWAHoDrN8aETl8Ka+WjYwM6qiKvsWo0JUjQ0OwYJJ
 Q4mUY8wQTVaZV3NxDky+A==
UI-OutboundReport: notjunk:1;M01:P0:MNKo1LlrcvI=;EXoGFUc+p+cPPjgEDosEHpxB3U3
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

On 02.07.25 17:25, abdellatif.elkhlifi@arm.com wrote:
> From: Emekcan Aras <emekcan.aras@arm.com>
>=20
> Add missing checks according to the UEFI specification [1]
>=20
> checks added for these capsule flags:
>=20
> CAPSULE_FLAGS_PERSIST_ACROSS_RESET
> CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE
> CAPSULE_FLAGS_INITIATE_RESET
>=20
> [1]: Table 8.8 Flag Firmware Behavior,
>          https://uefi.org/specs/UEFI/2.10/08_Services_Runtime_Services.h=
tml
>=20
> Signed-off-by: Emekcan Aras <emekcan.aras@arm.com>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   lib/efi_loader/efi_capsule.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>=20
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index 113cfe30fde..a5ebe4994dc 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -769,6 +769,36 @@ efi_status_t EFIAPI efi_update_capsule(
>   			continue;
>   		}
>  =20
> +		/*
> +		 * ScatterGatherList must point to a list when the
> +		 * CAPSULE_FLAGS_PERSIST_ACROSS_RESET flag is set.
> +		 */
> +		if ((capsule->flags & CAPSULE_FLAGS_PERSIST_ACROSS_RESET) &&
> +		    !scatter_gather_list) {
> +			ret =3D EFI_INVALID_PARAMETER;
> +			goto out;
> +		}
> +
> +		/*
> +		 * The CAPSULE_FLAGS_PERSIST_ACROSS_RESET flag must be set
> +		 * along with the CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE flag.
> +		 */
> +		if ((capsule->flags & CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE) &&
> +		    !(capsule->flags & CAPSULE_FLAGS_PERSIST_ACROSS_RESET)) {
> +			ret =3D EFI_INVALID_PARAMETER;
> +			goto out;
> +		}
> +
> +		/*
> +		 * The CAPSULE_FLAGS_PERSIST_ACROSS_RESET flag must be set
> +		 * along with the CAPSULE_FLAGS_INITIATE_RESET flag.
> +		 */
> +		if ((capsule->flags & CAPSULE_FLAGS_INITIATE_RESET) &&
> +		    !(capsule->flags & CAPSULE_FLAGS_PERSIST_ACROSS_RESET)) {
> +			ret =3D EFI_INVALID_PARAMETER;
> +			goto out;
> +		}
> +

Should we simplify this?

if (capsule->flags & CAPSULE_FLAGS_PERSIST_ACROSS_RESET) {
	if (!scatter_gather flags) {
		ret =3D EFI_INVALID_PARAMETER;
		goto out;
	}
} else if (capsule->flags &
	   (CAPSULE_FLAGS_INITIATE_RESET |
	    CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE) {
	ret =3D EFI_INVALID_PARAMETER;
	goto out;
}

Best regards

Heinrich

>   		log_debug("Capsule[%d] (guid:%pUs)\n",
>   			  i, &capsule->capsule_guid);
>   		ret  =3D efi_capsule_update_firmware(capsule);

