Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91004C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 06:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA1B18890F;
	Wed, 31 Jul 2024 08:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GOoiyuMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 683B38890F; Wed, 31 Jul 2024 08:19:18 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C4818889C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 08:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722406755; x=1723011555; i=xypron.glpk@gmx.de;
 bh=nnI1GKpvTnq+a4O2F5YrcWKouY5nosOxxNcNA5lWiqE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GOoiyuMIIxKOb/dXSc/ZQYk3ogilXx7y7O2N15PWS9haALE1iLUbfCmPahebl0M5
 rEuT763inohzksAub2Wzqx/NDO1ttHyx8m678r7rP4viwO5rsXibsbxi/v0E9xueg
 Z/dMcIwUv4kSbS0+PvzBa+tBjUWEyo1JhqKog3E1Fd3hcqa6U7pRUD7jPBvMnNh5z
 +Ke49Bxqjo1GdSP/NCWa1KPXcJeoIacWhxLsjwY4LPxClCMg21PD94HR65gKkOEey
 STXY8Qk84MqOimjlEsEQ34X02kxM/UizcdwvUgu8nkZ6hYiKqv4Vg/BmzkD2mJje+
 sJQ/ozBK2iE9SMC+pQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU0q-1s0nrD1nqm-00icrM; Wed, 31
 Jul 2024 08:19:15 +0200
Message-ID: <ee72476f-7926-4cea-9525-3f494ec1ce72@gmx.de>
Date: Wed, 31 Jul 2024 08:19:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] efi_memory: avoid possible null pointer dereference
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
 <20240730111132.1097315-3-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240730111132.1097315-3-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lO3kE7D5XcDrH/78oXMUY65JCDF4+U05SKGMT0J6+jV6s9djoaz
 CG1UxXwYe/nj+b+9DdbVWqd8Mp81F8sK5EtSV+YbUjoGZ0T0jCcX1P5uD1CeO6kHljRJqS6
 2WODbWlgMNModnjcjRJ3xIIJs0r9QA1k+3ttNifwFDXEqbJ4kdyrfuvmFaOMx+IYC/c+DoX
 pcVYUB9d2W4njcioyy1Pg==
UI-OutboundReport: notjunk:1;M01:P0:ksngAR1gQ9M=;+L7RmdtY3hMb1DkE0WMxXrq2B68
 hsD1yzc3aXEXWvWpfcZfF8JgFu6FKkVnRolky9MXqB2J36ZG07xLlTmYXhmKALFMjpDACnpHx
 AoHTc1fLCYhiiR/VVLhmA9JxMU4uJnILc6JjylW9E8w+SzePhqyzpp/tSHefhh8TifJil5HE5
 pQbPhAJSAn5LHv5T6JpesGkvnAzpa3DtcaxdQOkHHONGacWE9q7nj5AV+V+fncSZGd8beEaey
 WPUrtk/ISnBMELCzULW4L6IeZySIuVUvUpsqesEVWgH7JotbuUMM6aIfmARjvrDYifSPOir1N
 x5W46P55siwUvgWXMSWSjzN5Xf6IQ3MvpvJWU8Yl/2NibN1IX59ZrS53lwrJZZEF9T/q4N05h
 mphUYhkxk1mg7rK2nODlL5qu1ElYZBnMKubUbPkBxmGSG/CZ+XgoLNQs/XJ0mSyzprhUne7zM
 p7+WZndM9p69oCh+dY+gyStlas1oJmkklUS/X7gDOBZSssj78szL10fCRp7BADzNfxx+21rW8
 SP/zPJCwqsi30HMO6a3ovmj5IU6LHL79zkNly4eZN9gaG4ER1xdsZRJ4Lou6VpLC96//WiDfL
 otTWSi0fRRND1oQA0NlB7fGIdeQQA000MLs7ouR+quPhMiS3gYaltono1p6PZ0c9BWdIIJHmz
 DGd7n4g0JTErSw5YAjbq6Xvdh/aDQCjTNM6jGr00jYXBClaD+dWOs7nU6UShhgvVy7eqT/iUQ
 Cc3L8UnPEXFMiWyFfAs466mN0l5Q0LEON07cV0x1nprHeMn58IUMXL+gvCE33QeGSs3VrLHYl
 ArWC24zhhKfheV9ZIqqAMtbQ==
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

On 7/30/24 13:11, Sughosh Ganu wrote:
> Populate the previous memory descriptor node pointer only after it's
> parent struct has been initialised. The compiler fixes this logic to
> do the right thing, but it is better to have correct code in place.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Fixes: 7b05667ce239 ("efi_loader: Merge memory map entries")
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_memory.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index bfadd6bd41..8d4f6e339d 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -138,7 +138,7 @@ static void efi_mem_sort(void)
>   		merge_again =3D false;
>   		list_for_each(lhandle, &efi_mem) {
>   			struct efi_mem_list *lmem;
> -			struct efi_mem_desc *prev =3D &prevmem->desc;
> +			struct efi_mem_desc *prev;
>   			struct efi_mem_desc *cur;
>   			uint64_t pages;
>
> @@ -149,6 +149,7 @@ static void efi_mem_sort(void)
>   			}
>
>   			cur =3D &lmem->desc;
> +			prev =3D &prevmem->desc;
>
>   			if ((desc_get_end(cur) =3D=3D prev->physical_start) &&
>   			    (prev->type =3D=3D cur->type) &&

