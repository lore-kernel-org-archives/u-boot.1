Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D56C77B7F
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 08:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D85F82B34;
	Thu, 26 Jun 2025 10:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VqjC4mNP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4605B82C4C; Thu, 26 Jun 2025 10:06:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1B2B82AA4
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 10:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750925156; x=1751529956; i=xypron.glpk@gmx.de;
 bh=AumVnxW0VSHn0Dr9yC3cX2yEKDq0M1hxho93nMz2GWQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VqjC4mNPDH8N1k7VH5n2gli0k/28XexxQ5mXpQO9GNwNTkqo/SvvvT2B4w8lqYMq
 aQ9kCtcmMDMlK34Bt25tmnf2vzSSLAEbicmIwXdRQhVv+qpK8ghkNyCWckHNSjU+n
 UZWvl+VSXAC6WEdobTVHDa8ztNKKe2Z4vDpf/i8tRkrGcnEXzxhPijR+7frzdmRPV
 sCzF+QnaI61MxBYtzS/oOHrN5knypg5CrRUxyynnU+JWVbwHnubMBTqmWfIDIpfkO
 LGP5wxQFHajkI/3RFAeRILjUKg/v44JDyRJ5o/kI4DskIaqk5RPQGj5+okTZuNv3b
 xeGR1rzNmaKRZ8A5MQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42nS-1uUhcK18vQ-002sxg; Thu, 26
 Jun 2025 10:05:56 +0200
Message-ID: <688f0e0c-7acd-452a-b941-188b76aa9c2f@gmx.de>
Date: Thu, 26 Jun 2025 10:05:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: initialize 'total' variable
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
References: <20250625171528.1062540-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250625171528.1062540-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BDDejI6vPi+xI/N+ZjfXbSsmzoAHXSNvwfqf8NOY/In+eFkELoL
 hMVQ7onBNz/R5lpp4aWVhcXOAFE+3Mgy7LEc9LfQcNdwJBPtKoFQeCcrIiIcaVWyHYCm6M1
 I2x+WuoIpcpxeA6JKoG/SFiHDEwt7vTGoHcsTTSyHLAxA1BjvIOyGowH6R7n0LzW39frnKX
 M1jSjH4P6eI8nilW+nSmA==
UI-OutboundReport: notjunk:1;M01:P0:Per26Ub0Zo8=;AXmatxMzuVTl0uEa4R1qWcmQCYN
 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
 xaGQ+J1sTyGDVZEpk6GK7zMRvVShsL5o=
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

On 25.06.25 19:15, Ilias Apalodimas wrote:
> This variable might end up being uninitialized if we exit early.
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/efi_bootmgr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index b9437a81c642..662993fb8095 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1134,7 +1134,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_=
option(void)
>   {
>   	u32 i;
>   	efi_status_t ret;
> -	efi_uintn_t count, num, total;
> +	efi_uintn_t count, num, total =3D 0;

'total' is a non-static local variable.
The first line using it in origin/next initializes the variable:

     total =3D num;

If we exit early, local variables are discarded.
Could you, please, explain your concern.

Best regards

Heinrich

>   	efi_handle_t *handles =3D NULL;
>   	struct eficonfig_media_boot_option *opt =3D NULL;
>=20
> --
> 2.49.0
>=20

