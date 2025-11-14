Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD9BCE7AA3
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 09:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 124F883B1A;
	Fri, 14 Nov 2025 10:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="nikB603f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C52AE83EF1; Fri, 14 Nov 2025 10:53:29 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2AA883968
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 10:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1763113997; x=1763718797; i=smoch@web.de;
 bh=sfnvE4yK9HHRkAS3AeBlxwcihLwF45lSEFb1kio/OzY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nikB603foUX7uvVhEfi48G/Gt3Vd9z96M9Yd8MLHkJrcabXUlVtUnjIUJYDgPPrb
 Guc+ij70+Xyl3riTeU2RacYZ10Hf3f45jq5HaRqcFeIdfWt0xEihoBjNGgWEVnse7
 x7YFr3iCNXVl7owgW3kNkpaawixpxPEKeOBf3nyd578D2sbjbg9VoSgrXlWVKmsJr
 HQsDJd+DL57E16/XSTl+qS1henVEF7wv8Znba0J2zT/OIxcV/cAlsg9Oqh6OF+jWt
 quhsvyXpfwQ9TckbapvpjZamlsqimceFJ0N4kqP/9TlSR4RI5RW39cH6l/yAHoGme
 Xw0Pz3leySNfhO5T9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.1.40] ([78.54.190.247]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFlm-1vnwS63XD0-00mE3Q; Fri, 14
 Nov 2025 10:53:16 +0100
Message-ID: <4298f3c8-5aa6-49d7-a8c8-693590dbdc32@web.de>
Date: Fri, 14 Nov 2025 10:53:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: tbs2910: Disable EFI partition, MP, sysboot, bind
 commands
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>, Tom Rini <trini@konsulko.com>
References: <20251113151858.1072774-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?S=C3=B6ren_Moch?= <smoch@web.de>
In-Reply-To: <20251113151858.1072774-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:n4Iyk5ccb2KgGY0SE9Kf3BkvTnCgRYh/1OLZSntrE2Kr+LdBIWI
 CkzpjwK2CUvcygMdqnkTx2suGnhZ1tVaXZBQMUCjM37vvPVb+yoG/xc645w4fuhsHCILL/L
 g+PwUm38bfa5LM8rrIm17i62brY9tOsSzxPvoinRgQA8BqVYB8V1/CdjJzIGrpInIBJruI1
 ZX/WYjXbG0dFmcfcJhY0w==
UI-OutboundReport: notjunk:1;M01:P0:wIY7NtRayOA=;kxtzN3lhqRb1Piy6Bw7av2llj8X
 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
 GRo9F/iChONv0CvCcces3u+q5ubxN
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

On 13.11.25 16:18, Marek Vasut wrote:
> This board is just short of overflowing the size limit, disable
> support for EFI partition since EFI support is already disabled,
> and disable a couple of commands which are also likely unused to
> keep the board below limit.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Thanks for finding additional useful options to reduce code size!

Acked-by: Soeren Moch <smoch@web.de>
> ---
> Cc: Dragan Simic <dsimic@manjaro.org>
> Cc: Soeren Moch <smoch@web.de>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   configs/tbs2910_defconfig | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
> index 070dce234d6..ef7d5ca3e2c 100644
> --- a/configs/tbs2910_defconfig
> +++ b/configs/tbs2910_defconfig
> @@ -38,6 +38,8 @@ CONFIG_CMD_BOOTZ=y
>   # CONFIG_BOOTM_VXWORKS is not set
>   # CONFIG_CMD_FDT is not set
>   CONFIG_CMD_MEMTEST=y
> +# CONFIG_CMD_BIND is not set
> +CONFIG_CMD_DM=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_I2C=y
>   # CONFIG_CMD_LOADB is not set
> @@ -53,14 +55,13 @@ CONFIG_CMD_MII=y
>   CONFIG_CMD_PING=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_TIME=y
> -CONFIG_CMD_SYSBOOT=y
> +# CONFIG_CMD_MP is not set
>   # CONFIG_CMD_VIDCONSOLE is not set
>   CONFIG_CMD_EXT2=y
>   CONFIG_CMD_EXT4=y
>   CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_CMD_FAT=y
>   CONFIG_CMD_FS_GENERIC=y
> -CONFIG_EFI_PARTITION=y
>   CONFIG_OF_CONTROL=y
>   CONFIG_OF_EMBED=y
>   CONFIG_OF_DTB_PROPS_REMOVE=y

