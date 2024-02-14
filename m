Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AF2C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 21:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFC1087CAB;
	Wed, 14 Feb 2024 22:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kIpspcJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A4E087CAB; Wed, 14 Feb 2024 22:41:35 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19539879E0
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 22:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707946887; x=1708551687; i=xypron.glpk@gmx.de;
 bh=aRKezAtsOP/at5Uax17rG2oC3dln9skP7DRritjGEZs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=kIpspcJrN2GYBfFSVBSQQ3RwkQsEcA4b9VvlcHpKu7x092gxP7+Livk0Vk6ZPCT1
 0C4hux7WiCDor+n0s3RG4vZKJt87RqNV4Yr8cjbiFyRpF10V03i9xCm0rcP58hjgx
 FJ8dEU2VgySbxuIzG1dm+FUnSwWk5PUjnFFuRYYnFPoHAIrCmh1Vzb4M++uIlaL4L
 787Oma1EY/YYekKfdPK6XLpnuGViV9qbQUyLSa7XP7vEw9+nzuASGQ5cQ4MoXoreT
 rcceUgEzK1ALXFZk0Zrj0A+CqY7yeKqcDO9Rjl5qRWV+tWlLJfprA30/zeGZbvoF6
 y/KkNRVFr1VBaLRjpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlw7f-1rALWm2Wg7-00j5dq; Wed, 14
 Feb 2024 22:41:27 +0100
Message-ID: <782e7a88-b8ad-4220-8c86-113f7d1277a2@gmx.de>
Date: Wed, 14 Feb 2024 22:41:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] tee: sandbox: fix spelling errors
Content-Language: en-US, de-DE
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
 <20240214183444.493629-3-igor.opaniuk@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240214183444.493629-3-igor.opaniuk@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+4+3p/vURkHuFaBBEFtZmz1liKK3m6lSrVTNDGsD3dffJ6798Kj
 tk3SUd6W4enMyVqlvWaUSpznSluF2Zo2S6WLlRo4CIgO9CG69BAB7B/P7qlIL/168sugnVe
 R50ccyYiZA7oDZuATCzH3tyVIBfIUY6OZZvu6jXXiZO7/5JCrpQKrQpqAwur26U7UxDoZxB
 Tstu/YLyvuIgb7p0znYoA==
UI-OutboundReport: notjunk:1;M01:P0:VhNGMFJczjM=;db+97DBo6b3vsdpcjM3jmf41W8T
 geAo1h34smNlOtHEBk49iBCA1AL4WO1GIy1BQdfklw3NAHzJF92181QBqwfZYvArOplOndU9P
 lGS/nO87Ue6AG/H7nEtvZ4NUKmarKKPUcx4wnpDs0SRmjINwDilNzhVcwKumhLIYIzApkFiZX
 mJOQSANqQVfI+1ja5L3wvQv7QxugItYkJSEAR77YTpXMBLY8cpdOUVvcWhn8fZluXywDkilnh
 Q6qscjHEmEeQ666fdr3MxHKYPqrTJJLoNhRosmFvgG3yow8ngeTFR4OAZGNsQudr2NDIFygEK
 mnE10BrI3S0yDac7NTVFQIRtaySAHQL2y6wIRQ7H7kZrDidxBo2k/xJPnvO6qIH3//QcNjNss
 YPZOfwGb+RkGuSwaw04CkzN9jkBmoWr/BEwga5RrOtZHKabzBYA+wr7lMUm0vi4ohbt/Ginhb
 QrGkJ3lmnopTAq4tuzanDl26DNX0vkooOzxWlXMs3G/gZb4BjrISKVCfulsEJ1RofusmlX6m4
 OUSvMgdQKSFbXtksMv9pfVWp0+HIy65thQfQeNOQ0KPKaRx2sT5uCw79Jbz5DLGgiXiPs45ei
 SuF7XHFbpPsDe/6Glxkv1f0HpZ9Fptw+ekvjeBaDchouooFjGqkbb4V3Fud7OHIVX1ePLdTkq
 HRCkRqHxKoV4CnVj06hLY7B2F85MQ27lVkoM7dNnhEiNDQtvWRlZwo1BRhq1NwADEU0iAsGQK
 k0zzQo5ByQF2bnH2eohAP3xz8WJMw34M9nVC4SnIfa7JuUD6TprKjShgpjfitOh5Kmg4nG/7c
 5jW0/iT7G9w6SkLBgpUrrnxVfRKxwA6TC8Mq6Im7cyJKE=
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

On 2/14/24 7:34 PM, Igor Opaniuk wrote:
> Fix spelling errors in comments.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
>   drivers/tee/sandbox.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
> index 86219a9bb1a..ec66401878c 100644
> --- a/drivers/tee/sandbox.c
> +++ b/drivers/tee/sandbox.c
> @@ -14,7 +14,7 @@
>   #include "optee/optee_private.h"
>
>   /*
> - * The sandbox tee driver tries to emulate a generic Trusted Exectution
> + * The sandbox tee driver tries to emulate a generic Trusted Execution
>    * Environment (TEE) with the Trusted Applications (TA) OPTEE_TA_AVB a=
nd
>    * OPTEE_TA_RPC_TEST available.
>    */
> @@ -23,7 +23,7 @@ static const u32 pstorage_max =3D 16;
>   /**
>    * struct ta_entry - TA entries
>    * @uuid:		UUID of an emulated TA
> - * @open_session	Called when a session is openened to the TA
> + * @open_session	Called when a session is opened to the TA
>    * @invoke_func		Called when a function in the TA is to be invoked
>    *
>    * This struct is used to register TAs in this sandbox emulation of a =
TEE.
> @@ -140,8 +140,8 @@ static u32 pta_scp03_invoke_func(struct udevice *dev=
, u32 func, uint num_params,
>   			provisioned =3D true;
>
>   		/*
> -		 * Either way, we asume both operations succeeded and that
> -		 * the communication channel has now been stablished
> +		 * Either way, we assume both operations succeeded and that
> +		 * the communication channel has now been established
>   		 */
>
>   		return TEE_SUCCESS;

