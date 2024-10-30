Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC96D6B6D1
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 20:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E76D8925A;
	Wed, 30 Oct 2024 21:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aevYuEay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 477FD89259; Wed, 30 Oct 2024 21:29:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5209889212
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 21:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730320178; x=1730924978; i=xypron.glpk@gmx.de;
 bh=zAez+3gdHPwKWMGaa4tvOnnnPAAoc7NWR8pGKZZP5Hw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=aevYuEayWQEjQwJGkDlwRnvZ4J66JCH6zHFnqX6QqEyM7xeFAwhelN4NV1e9gSOW
 w6Di+d0q5cAwH7jH1sMXl4UNdtSAKmGaWxTONOcdmKV+9lQs+BQ2VylG6q+dTaDSn
 lRT0R8ZHyU/RHORf2Wo54EimraK82SC9wrBlEAV86qmbY5Wz7RITJfsCuW2cGubl5
 6hOZnPAsvnyeE2JdAUoBcjQLlNNr2720qtA2I2VFcJ62IPnsfm/ZW7coB/3YWdvzc
 PB1re0vpXrf9jamm4RzTz8/3V83p64TbeTHsjIDiDPzBM7BQjUazgZsroqoL1I5Ck
 dLc/v4kVY/eZUYOjcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b6l-1tECsB2IBx-002Ikb; Wed, 30
 Oct 2024 21:29:38 +0100
Message-ID: <afbab923-73de-4743-8a7b-0891e4edcc96@gmx.de>
Date: Wed, 30 Oct 2024 21:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: efi_loader: Fix efi_dp_from_mem() call
To: Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, pwildt@google.com
References: <20241030201608.1247488-1-moritzf@google.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241030201608.1247488-1-moritzf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H5lNZ3Q5FiqAurYad4X5A+nAqQkpnjQQn1DYXV9btzdV3e4AJXp
 Ek0zY+RQw9HUGebYpuvLuoEVqhrHtHs8PVwGUbBoE0++AcKWk3UtjEvzESRZLK3y0/02X7/
 vvc1ddUBBLuCHtqAYh0H/UeRpPjWNQzIP9qZf5ngs7bnHhdprhbGI8KJdupfVj0p1Vix3TY
 ylEOoyR+pOXny9bUrAdFw==
UI-OutboundReport: notjunk:1;M01:P0:FjojhGODKZo=;y0krRzBsVAHxloDPfamxExwVBvF
 YgpYooqjJQn7LTea4Y5QqQNN/UC1KT6Kd45GGHRNsDgBSBdqBm+b/vLEHOZDgsbSJMbL2J4s8
 A8ctS5xmMxPp+LodKqlOpg8GOb4FJrfROGiwAKNhNirjgmigWEtuBcppGN3Nv/65pj+qVS9gl
 XYDf7Uj7s1oIvVMjfLBG4qwKN8HFEQQpCcnHmlvSKlsu30lw25ZdBaACQv1lWFUO/KOjvqcMp
 sVSZrgtJpasTfaRUOonY19viaYTGLaRlnDYD8/5Fn5ytK1JD19pVACoKVCl2d0Q4mnIu8Hyli
 Ry2VxmPU47LFDJfbRo3wLxFyqiDNKNEPuYluNpiV2Guhc+KEkwmmTkHey9+ntpfy+dXXNBA4x
 NS0KcgTZbi8NZEWFEvTIVSvrOLoHcErGPxqUnz4MaiQSAJ0L8X6dZ0cyTv6yOvl++T5tMG3pu
 UWxasfghDwAChw2SmJne3WtDBu03X3xLpDYSoWeJbj6zM6QLkAOMOqYCPcHyTAU4JPQpiFNlH
 iKvOy9BUKhAXqiEFGQKLegci1e1st6jmLlxCkS3nxpSHBQG8FjBMFzGleAR7oHgqJF1tLJC5v
 RuHx2xDoTg5lilw9yFjimJfPmlqfUWimFKDncyUpZE50Z/7AsC+5ZtVvbMSFCv5GuYmJNutui
 mcipsODOOMt3R5JM0nIqVNtI9wC7mq+bWjSglW1p/FLBKZLd7K9MPluxu4AzU76HPbCTbB1Gw
 fJLBrmtmUkiGJFinBHfCsPPOgWCBHiUF+IQEnHxUlAw9f+ih0Y/J5kgMNPe2p5QJ2AJEh4pZg
 9DPQF+PpcmsgGW7MIMZLYdzw==
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

On 10/30/24 21:16, Moritz Fischer wrote:
> The function expects an end address but is being called with
> an size instead.
>
> Fixes: 6422820ac3 ("efi_loader: split unrelated code from efi_bootmgr.c"=
)
> Signed-off-by: Moritz Fischer <moritzf@google.com>
> ---
>   lib/efi_loader/efi_bootbin.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index a87006b3c0..798bcd6eee 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -137,7 +137,8 @@ efi_status_t efi_run_image(void *source_buffer, efi_=
uintn_t source_size)
>   		 */
>   		file_path =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
>   					    (uintptr_t)source_buffer,
> -					    source_size);
> +					    (uintptr_t)source_buffer +
> +					    (size_t)source_size);
>   		/*
>   		 * Make sure that device for device_path exist
>   		 * in load_image(). Otherwise, shell and grub will fail.


The  efi_dp_from_mem() invocation in  efi_dp_from_name() seems also to
be affected.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
