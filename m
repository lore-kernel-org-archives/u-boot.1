Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC7FC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2201786BA4;
	Mon, 13 Nov 2023 15:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dZJpaV9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81F128710B; Mon, 13 Nov 2023 15:12:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E108286B2E
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699884756; x=1700489556; i=xypron.glpk@gmx.de;
 bh=1v96vZrp79QBIZO0RNaa06BcIKlAaS38kCT0NZNrUcw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=dZJpaV9xsge0zZMOuQunFwQjdJczRBVULk7Snw1cKkrrS/sa84P4shePX8/doTdt
 58s6V3aZkTCUqecg/3szAawykjduTaAF9kPsnyS3Fk6/deyF5fM4zSp+oDaAGecBA
 +YSRHbD0pGdB6t74SEl/a+Asl9Yiu+vxCA2Q+Thu7XhmYc0KmchKnya8KCVqRYkoe
 IEYML1h6UYlxdKRSF844NiA86HfnHvVzr5UoDzgVX4+nAYDrUpNJFgXTMbhsYic7C
 1RcXQMU39ZlzCJTvVt5iI1f4O7eaJQ9zguVE6KeiUxDAf6ESoPcprkS/Jhu0A0i4D
 jnOXZ4sDSIjd41+3oQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeQr-1qp7Op2QL5-00VdT9; Mon, 13
 Nov 2023 15:12:36 +0100
Message-ID: <f07290f8-a02c-4a9f-8985-12c0b7f7c541@gmx.de>
Date: Mon, 13 Nov 2023 15:12:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Correctly account the SCRTM event creation
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: eajames@linux.ibm.com, u-boot@lists.denx.de
References: <20231107113134.81029-1-ilias.apalodimas@linaro.org>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231107113134.81029-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EMoOPC0DkLhpmakFbz1OaENZwz4BdywtuV75M19hKRriDk9DHGL
 1ZM0VLJbdsqtwulwc4kLp8GJ0Wn4aThkNloQGEnvaNCfTu3JCMT5eetNgFLUkHyU4eV6foe
 MwtjGiXdxcVrTjHxMfLQlBN9rjt1kPywCHrE5fhyrzyjbrkBLgmMDLnz13XGmacSv5fMM98
 nygcpItbHAfy+STgsj02g==
UI-OutboundReport: notjunk:1;M01:P0:VBeDz5XutrI=;goneqNb3BOP6LSQ/XImL2/LtR3b
 vKQUAi4DwophOP5S1sKFhkJp8kvkFWX8oSpEc2UTGBbaFLVMMNTw63o8LFpkjf/4aCTWObqbQ
 74X7TxjCbgHZx+9nJhfLjRsTN6PNnS+6tDw7Vki/kpzj5SxeqjnaFFbtnPUJYsH6X4OoanO5f
 11HIVO/3vBs6/ZhQUmhQ402vsBSZi1ePR2Ra9Ho/z0+V14NYp0DN+2CUIg3pBPUkEJbQwtfuO
 wNzg0d4UmlQOqKiuVG4IN8wyUB3DXf0RDE3TmK4T5rzmJoOB5kHOtcic/HNO1jIgw348NXDQ1
 1WzjsX2JUQsgXKWhb3Vyh2pphrCtPahIZ5U3x57Y64NOlVkdXf61H6B4s26RKhEtrVVVx9Lez
 o9ojKpre76t/peTqA4JejB3xcUfREvx2WkwzKd+p3MDIMzXWqmUmbYryhHShZWl406ibE0jrs
 +XzGV6xvTvrUaEPlLH2rlNDFdrUVqm5QJ1nnp/3w9zhFqhKSQ2nS5H39noODqIkDuYSdoxPD6
 E2XBvUnLSO0Vlr4xUKVrOVNqjs6KU4gIcl8I0Ek39h1xm7LMoN90i/ubip3I4EXAErovNYbUq
 Rz7109YuuA4hOOv2mE9CjYBdvkUd+nJio5Vk0vsXN9W7I05Pxd1DOxsD0L0qHfFZct9dbBa+b
 CMp/4WpK1DPt594jzmTYJZpJNHJ5h+pXNKQjClMtHyAlC6OiRqFymsDeosTGBnDUCI3KWFu7S
 pTcD+cut3ZSeW/BKeCv/MmFrp3qve1zHn9YJrW3u8AeqlfzoiD8eGzsf779OtZ5F1/YEq6RMP
 NDSrk3eh+z7vnOa+iozNewcKSZyU0qyu/Z9WKQO0A1GG595e5AyMDsjNH3tAdS5ECORXeJeQ8
 8Zqzw6yY6XfDauLf/R4xU0bfE3lucNlXtYzzwK1LZjXJBERuITr2QmoVz5hmNILdKr38zyWWD
 nGMB53Nc97PnpIHmddKQlpAc+JE=
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

On 11/7/23 12:31, Ilias Apalodimas wrote:
> The result of efi_append_scrtm_version() is overwritten before anyone
> checks its result. Check it and exit the function on failures
>
> Addresses-Coverity-ID: 467399 Code maintainability issues (UNUSED_VALUE)
> Fixes: commit 97707f12fdab ("tpm: Support boot measurements")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_tcg2.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index 2eaa12b83b16..463ea4c15416 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -944,8 +944,11 @@ static efi_status_t efi_init_event_log(void)
>   	 * Add SCRTM version to the log if previous firmmware
>   	 * doesn't pass an eventlog.
>   	 */
> -	if (!elog.found)
> +	if (!elog.found) {
>   		ret =3D efi_append_scrtm_version(dev);
> +		if (ret !=3D EFI_SUCCESS)
> +			goto free_pool;
> +	}
>
>   	ret =3D create_final_event();
>   	if (ret !=3D EFI_SUCCESS)

