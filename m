Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0423C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 20:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CEB180820;
	Sat,  8 Feb 2025 21:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BWBWnN69";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D01EC80821; Sat,  8 Feb 2025 21:26:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCCD480805
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 21:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739046403; x=1739651203; i=xypron.glpk@gmx.de;
 bh=4eFa7JLKRdePe5P+fqkzltDZG2bG6HttfmXXB7XeiTg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BWBWnN69DZPoIfcdiMbxpW9KVcYeBXp4yeikbgrQSK72LidC5s/Hp8t/GR3Kz+yB
 fM3RqpML8DAjEXpKX7/YWjeCX0Ve2IKpiwDxoT2xmalmH6yb9V+4FYO7kqb2OC33B
 yV2gZeHLwQD9b78PtA8pNSul42mP2d/YOnoBTN4C5HmQre3niI5JzPJVD6eQs+VEQ
 er2CltV7a3VnnVEyVOaODLS5LoedWGfg32QbBwMcLhAAhQnlj6LJxPEcQlxeX0qya
 AAcNOnfIx4wgJppCBti2McUQ4cXwfN0WizrcU11tsI1v6s+1buzDpG3WeTYeYQa/P
 e2oSJH4pgHb4lld2zQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UZ6-1tgJBB34bK-006cGr; Sat, 08
 Feb 2025 21:26:43 +0100
Message-ID: <aba91521-ca8d-4eb3-83b5-04f44385ee3f@gmx.de>
Date: Sat, 8 Feb 2025 21:26:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] efi_loader: Support for file renaming
To: Daniel Venzin <Daniel.Venzin@mt.com>
Cc: burak@gerz.io, gabriel.dalimonte@gmail.com, Manuel.Traut@mt.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250207124523.85026-1-Daniel.Venzin@mt.com>
 <20250207124523.85026-3-Daniel.Venzin@mt.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250207124523.85026-3-Daniel.Venzin@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RfvYU21N0BXZ938vFlTHDgnDNqPHPiAo9DcXtDawBd8/6G/ak9l
 RYsKxiXjU5joEEkEqvhw5cEAQYP1uWVL48Ro/iTXJTxrv/xuB65DLglenIDw3+KRqDareDk
 9EpalKUeG/ZqX6ptX/Qs3g0L32bJ/VH+c/q8dLHQEMPQd0s+1WZTNMJ4qRY6o2cpSSoiZid
 9CnG1ZYxhCC2HCT0M8llA==
UI-OutboundReport: notjunk:1;M01:P0:5ilc9XEwQXw=;P28PIIeegj/mRiUwa2KeIVT2ava
 6mqgJ/NQ1dATZBTjMr/xtKgbIannEmhWmAh0qBpyHrFj73CJwMO8TLGbJnfExJ/fAkBREA4uZ
 WLUk3D1d7TCXuzVaJplOYTcPn7zF1x4M6Y+eLTw46fXCxXx5gvQpCB4rOVVxq5ORLfB/s+yY3
 aLxPj60SddaA4kIHaTzD34fP7RHsuNb88hFYAUbNGueTjq6IPNkjoYsMrNCJ8lJuJgROTvqtY
 +ao2F5BE76gXVBV2WgcZiIbkYF0FB5xkz/Y+fokCsMlOBN9RhTpAZi2wMY8A5O1cuXFUDUiUL
 8HpPpZTTtoOSUXKZg4Mgu0VwPITBDuDP3vv+IU+UmQk2gJIzIk9IQeb24RbPrmxY02+Vy7s27
 v0IuxvYBRlSd0JV8RVBUVKMjtFZIi+twwBiyitZ/CbVf3I1gGvWTIbvZ+SJVR+Sg0myglBrK9
 LztzNkuBrlG8I5CoHRzwl9y7bOcwvhNCOj6BaAenYEz4bUluSdsi4dvPLwzEz+Ig5ZAgpUNnA
 UhE0Xkj7/57ErRP3G/yc/lixW5eHwEExd/b5kuzLUqn/vASKthtwguCGgmmwKj9chQ+DFzf0Z
 Oan3SaU+grxZW5MBGyx35aa4HXqzhfv6yR0lXSHdcGr9vzyNe3ZqTpg6bRoOIVvFTML1zCzd8
 1RpwHW0NrfQJiofz6w+3LeFSOTzwKockR/TTpN93HCCyyKzP91oIdqzmwZziuj99zsEg2hNP8
 MZUYdV48b3DT7Czm5CUPueSpD1YmXMfsvxSQyzTl992nm67JgAQIAKAWtKOAnSiK/NvHuyw28
 TYLKeB4I4EDDIZPP/PkMv+xM5SFPKNuZAhZBq2j96gGf6KsCApQMIzECl/yaYgbMJd4AECc+5
 27+O44aA/8emvIbt7LCGGvrkOnNvwUU5zNLSg7R9uc+Q98zk1lyQI/6KFaKmE8N41nvt5ZEu4
 16jWUZdKHbc/R8y6aff6F8/4wZCp81MG8tivErs8q6bK1Zmld8WePlGUflbbzf6YSbHrtSPsS
 dhTE/ElcLzif5QhcVVr8+GX0WIk7tps5kLR2ew23bNqUPvUHB/JEp1VbL+S/k+TqRD2INErD0
 PFUHtHREZqil+dmseJnzfv4PrVAQJzqpQLDccMcGUh/6/xGX6joV8EX1hjOhjaBixu66JM/ts
 JTAei+ZnOqhilhaqKMU9mYgiewuOptHOpOGIUXI+xcn8vGdU5IFiHFShcp7pHd0LWBmJWLb94
 OI2XrhzQenaAPzW8rtQWjsjw6vSWrBfR3xxVvIXWNpVFvKvFbkopyThRvzfb0WessYKSIg6tA
 xMQQdPmj57xJCURlmNN9GqNs72hsfUXwZREQVHKCocJKuLnKePlnPFPjP3Ap25XXyZj2rXslc
 IHWGMguadg5opwFxQhKNsaUyY6pMOWDJUAbP72vyKlfBEg7QpVPNsUlyM+
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

On 2/7/25 13:45, Daniel Venzin wrote:
> File renaming is necessary for features like systemd-boot
> bootcounting.
>
> Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>
>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Use EFI_ACCESS_DENIED for unsuccessful renames
> - Avoid using of "=3D=3D 0"
> - Move the call to set_blk_dev earlier in the sequence
>
>   lib/efi_loader/efi_file.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> index 201fa5f8f3c..9a5a345bfc0 100644
> --- a/lib/efi_loader/efi_file.c
> +++ b/lib/efi_loader/efi_file.c
> @@ -969,6 +969,10 @@ static efi_status_t EFIAPI efi_file_setinfo(struct =
efi_file_handle *file,
>   			ret =3D EFI_ACCESS_DENIED;
>   			goto out;
>   		}
> +		if (set_blk_dev(fh)) {
> +			ret =3D EFI_DEVICE_ERROR;
> +			goto out;
> +		}
>   		/* Check for renaming */
>   		new_file_name =3D malloc(utf16_utf8_strlen(info->file_name) + 1);
>   		if (!new_file_name) {
> @@ -978,10 +982,11 @@ static efi_status_t EFIAPI efi_file_setinfo(struct=
 efi_file_handle *file,
>   		pos =3D new_file_name;
>   		utf16_utf8_strcpy(&pos, info->file_name);
>   		if (strcmp(new_file_name, filename)) {
> -			/* TODO: we do not support renaming */
> -			EFI_PRINT("Renaming not supported\n");
> +			if (fs_rename(fh->path, new_file_name) !=3D 0)
> +				ret =3D EFI_ACCESS_DENIED;
> +			else
> +				ret =3D EFI_SUCCESS;
>   			free(new_file_name);
> -			ret =3D EFI_ACCESS_DENIED;
>   			goto out;

Why would you ignore truncation or any attribute change other than
EFI_FILE_DIRECTORY here?

Best regards

Heinrich

>   		}
>   		free(new_file_name);

