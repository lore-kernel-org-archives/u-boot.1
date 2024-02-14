Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E275C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 21:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E4A987CF9;
	Wed, 14 Feb 2024 22:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="s2Zo9V0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C24F87CAB; Wed, 14 Feb 2024 22:40:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F3A87BBA
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 22:40:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707946816; x=1708551616; i=xypron.glpk@gmx.de;
 bh=9DfDLuuYzvixSqbPrE4eJ2CBdB/uKDDYaOFVSxFbuh8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=s2Zo9V0gNKbL7XT+2quit9MWa/cp4Hc7v5G/SFLDhlW4GGl69sTIENhxD7G+4Or5
 +65fkyqeKZCMcF15j9ZMjaB6XglOPBnI+4PM0MRPBrdK1pCbf3HAztVKHZ/wJgbvY
 337Wnanf3LA/QGpLx/keglu1XY22Z9UT3g3ntvXfvKTPG1qGnwSmUPxVDiJT8Ynln
 o0FIfzg6VsGbzooJfg20jfPJGWrXBi7WhXX0Yqb4TaLIioZCEqYmL9XqDR2OX5Mw3
 I6ptknyRpq8/B1VODsd4cME6LQdOnCz0q+k72+63xS5qIinUc8+3qTrdRouFkN6fe
 +qI1jZ+cjS/BHWvwtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzBp-1rIZ1K3emP-00Hulu; Wed, 14
 Feb 2024 22:40:15 +0100
Message-ID: <2a659d15-1b1f-4187-b700-827558591084@gmx.de>
Date: Wed, 14 Feb 2024 22:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] tee: optee: fix description in Kconfig
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
 <20240214183444.493629-2-igor.opaniuk@gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240214183444.493629-2-igor.opaniuk@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I0GVI2jQ7aV1HRtZimqJWI4VlYcgkiXg55COHVfCnxlsALHVehu
 5nGB4yhLjn9jQyCOrN1xxreA96YfWEKGX9z2jyPpOIojatuT24Xy5yQoyblxzKqDVPJLSF/
 rUVH9BzQARUZxXGWBwOryLkTVxMBnpFC36+FCHHFypU4FRiamSE+UpD7yeIcAeKV9/VpiWC
 5ev9amLdBOVOQXli22lrA==
UI-OutboundReport: notjunk:1;M01:P0:QZp2WNzDSOY=;NViugOch7p+PWzVHsIuxU7IZA5H
 TBgkwjsSk9aiHhfg2rZRowVYI8dPq2Rfamhxm74GLZJzbIEh/oLsAIc0gaw9jfg55vgKWbGsL
 bN96rKQroD5Ya+25lQsSHGrE42i/1U2wdo9jO4P//cW+2SPRYpUJllfsecaKni3nD3zHeUEYM
 9d/eAhqy1eedQD6tkJPokpg2Jp11j8Cf2X6q1288LBcTZgIj5RHrhBI70yLXQCKmRMsekddqx
 ekcCBBEUFkCvUwLPUck/NSk3AN61hOIpZPbILaxYUeoeruwW6mZwz/G6BtktADccF3/qZUdyY
 cOPZ8zFiNPWWPrOEtwraxcFA3/hPmuvquCCiOoBdz1RAe6doRVWoFlLPYSIA1BkTk0lEDDDjn
 V7WUIlIXWxuyZxI1uifk/g8XTb2nbOYFhuYGJ0d4j7TroRWtIyV8M93DUAEvRHiNz+eCGVOud
 THmPBs3RdiN9wMGykzD2sOLTEY9gmfUG+ZHnFcOkI71iwyTdSkIsWaO30YsM3Av34pzZIkrBJ
 Uo4X4wDoLqv+4SUGG14oAVhtQKhM3cQUmoXBmlcjDEKnTzzoNTlLOop8pki3x58W5c+uRafE0
 BXjqwXCB/SU6JONRmEPzW5YzwQYgYy8zfAA+3qxlwd+CqCW1pSU6dHkAJ/1hkeCjKeKe3VRsY
 FAdgSgnFeIM+zOKB6SvcfaglcONXbszjuNj9P+AsuFmTLRKcMq1CU0kh5eT4lSpPW1+mBp8S3
 IWNoqvybmfv7AxdrOaTmSF4Y/doKUjvi22DcqtnRPTQsLSRS+bXE6snB77BbPjQKz+bXNMKhH
 QARPdUVWg1CigCn8+3CWzE49IueWMaAFJd4yLa9pxJi4I=
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
> Fix OPTEE_TA_AVB symbol description in Kconfig:
> s/"write"rb"/"write_rb"/g
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

The change is consistent with
cmd/avb.c:424:
U_BOOT_CMD_MKENT(write_rb, 3, 0, do_avb_write_rb, "", ""),

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
>   drivers/tee/optee/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index 9dc65b0501e..db0bcfa6f15 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -19,7 +19,7 @@ config OPTEE_TA_AVB
>   	default y
>   	help
>   	  Enables support for the AVB Trusted Application (TA) in OP-TEE.
> -	  The TA can support the "avb" subcommands "read_rb", "write"rb"
> +	  The TA can support the "avb" subcommands "read_rb", "write_rb"
>   	  and "is_unlocked".
>
>   config OPTEE_TA_RPC_TEST

