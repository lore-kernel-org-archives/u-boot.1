Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B5FD3E787
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 10:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0BBF89234;
	Thu,  7 Nov 2024 11:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oNVmIkmR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D799C89209; Thu,  7 Nov 2024 11:34:14 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6AD988B0C
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 11:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730975647; x=1731580447; i=xypron.glpk@gmx.de;
 bh=s6tsuESP/fXE2OpBqiV2ZEw+Oovr7ENtx9v+OL7kisg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oNVmIkmRz2IKblevHZjQ8OS0PxGRTu+LselU5ZZIbJySiiztKGxXTHNvprPhOqd6
 3jOboglF/g3EiHGuyjQwRbnV4PEpdE6vkqGb15LRQgngIknTecrc7+rk4xkhj9N8J
 E91iOnjrtGjHtU+9/wXODYuOBebNfb0Ga18fPDGlNLCyWatpwJ7/UEwoM0FLoM21a
 +saSsUVEvDJA/bsbVCtddCo9AwdVFq9VpTdpGidH+Rj3ypsay5lhNYdTc500Uculi
 9NiLTVbVUzhOCYEwvz+0iiJV0iqHTX7NhKdOooSkELilJqJQ+H9a15+igfkeZsSfC
 bM93811RQoWVhUwChw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MulqD-1u0Xtd49Rr-017pW1; Thu, 07
 Nov 2024 11:34:07 +0100
Message-ID: <c10a5fce-6e4d-4ed5-beb1-14d1b706560e@gmx.de>
Date: Thu, 7 Nov 2024 11:34:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] efi_loader: Allow reporting the host defaults
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
References: <20241101152614.238747-1-sjg@chromium.org>
 <20241101152614.238747-7-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241101152614.238747-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W2zA7kYV6lZX1f4ybRno561zJmEgb5jw8A7YQVJQVxYkVZjL/Mh
 hFHvqXk7s99WP9LzWQXaaEXB0d6NhAx/NUwXiQF2uHWg6AuEzq//vv1sfFs2cA8xo0bVpP3
 5SGfq1W/vFSnB7e99hVWi3fPoe4Jtn1wNVzi0bJg8mXJwKr/v+X+na1cQi4gGHLCUKHRlWk
 /GpbJY3u1Zgy5JONNqbUA==
UI-OutboundReport: notjunk:1;M01:P0:fW1SUPMl9f8=;DlWOXwYtxO+M+enWDIvlH4G/XHz
 eTnQguJ3a6r0rLfE0bV5Y7T0LoaaWdXnBdVeFx94ftN0CFRXX+8w5gJw+tBcjuu6Ts21BkpAS
 0f3LbUSF6wuQ2gG6Hxhq01Uebqhde0pkCyVl+UByn41AVHiFzReeFRxIeBynxXCFsfZUvDQTU
 3GIec+Xtc2xiTffAdCuqmIXKAQOJW9IiifVjMaU4CJtd+NKeskTjelcznY3EkhC0aTDhZ8TvX
 wmjWkwrab3WW57Z9xQjf6EUjjm7sSriJ2NMCFjse+s+bx70Neg9RFZeCxcSiWrMtwCTrKwup5
 EfK2Wnzt77+Hu0g+kxlMD5rcvZrEZRg8ppozDBLchNmVVjGyDKHXdWCTzn+v/05qUBPbWNE6K
 lSFIor/yvookEIh25K+eyl363bd40xjlnM2yqr/+HgDPJ8FLk7lORJFcXa/ik23t4NBDpkU+n
 hBii0X5GjPFUc0p3BN/etx8AjJ6NGxp/sdzfB9iULmgcGF81XSzuuyzlQ+gVFMtbFt4yetWMd
 gmOBEoHpBAK9UhbVZe6CeVPy4BaPaI9UFBirheDIGQOff28uAN1MuOGSSm1FRt/V+/+AdOZgZ
 1nCddZcfuJNgctq4vPqQuVAdiymFyut+/Abxza5BLNJXtWuo2rtyhG4bTX5kFpAHg/IJOduZu
 3G0eUYb/rZ8vCDHlPWfS6NkWuYqI4BgS3CbFUjUoY4GYBKqSkjOLiJO5XOyLuV5RE6j5zcMbQ
 x/y7UMcpV9B5IT4psWiPWF0gglW5705YZqqnOFcsr+55cYlii2ivZ3WHN6XuNdtnyiC+MwdsM
 jXsvjP81JpyWaMSOf2HNwxPDpKP7IJy+vxmCYKaIMrk5t92JSVRjylFLXW9duuOelLU9qPPHX
 Dz80uGdFlMCA2eIG1KV33IL1a+tqYqkchgNYfxFgBNfTDZqjSvotShnmG
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

On 11/1/24 16:26, Simon Glass wrote:
> Add an 'efidebug filename' command to report the default filename and
> PXE architecture.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v9)
>
> Changes in v9:
> - Split out into its own patch
>
> Changes in v8:
> - Add new patch to report host default-filename in native mode
>
>   cmd/efidebug.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index bba984b2b75..ff6d118876d 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -536,6 +536,27 @@ static int do_efi_show_log(struct cmd_tbl *cmdtp, i=
nt flag,
>   		return CMD_RET_FAILURE;
>   	}
>
> +	return 0;
> +}
> +
> +/**
> + * do_efi_show_defaults() - show UEFI default filename and PXE architec=
ture
> + *
> + * @cmdtp:	Command table
> + * @flag:	Command flag
> + * @argc:	Number of arguments
> + * @argv:	Argument array
> + * Return:	CMD_RET_SUCCESS on success, CMD_RET_RET_FAILURE on failure
> + *
> + * Implement efidebug "defaults" sub-command.
> + * Shows the default EFI filename and PXE architecture
> + */
> +static int do_efi_show_defaults(struct cmd_tbl *cmdtp, int flag,
> +				int argc, char *const argv[])
> +{
> +	printf("Default boot path: EFI\\BOOT\\%s\n", efi_get_basename());
> +	printf("PXE arch: 0x%02x\n", efi_get_pxe_arch());
> +
>   	return CMD_RET_SUCCESS;
>   }

This should not be guarded by
#ifdef CONFIG_EFI_HAVE_CAPSULE_SUPPORT
Otherwise build errors occur on some platforms.

I will move that function behind the corresponding #endif.

Best regards

Heinrich

>
> @@ -1589,6 +1610,8 @@ static struct cmd_tbl cmd_efidebug_sub[] =3D {
>   			 "", ""),
>   	U_BOOT_CMD_MKENT(dh, CONFIG_SYS_MAXARGS, 1, do_efi_show_handles,
>   			 "", ""),
> +	U_BOOT_CMD_MKENT(defaults, CONFIG_SYS_MAXARGS, 1, do_efi_show_defaults=
,
> +			 "", ""),
>   	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_show_images,
>   			 "", ""),
>   	U_BOOT_CMD_MKENT(log, CONFIG_SYS_MAXARGS, 1, do_efi_show_log, "", "")=
,
> @@ -1688,6 +1711,8 @@ U_BOOT_LONGHELP(efidebug,
>   	"  - show UEFI drivers\n"
>   	"efidebug dh\n"
>   	"  - show UEFI handles\n"
> +	"efidebug defaults\n"
> +	"  - show default EFI filename and PXE architecture\n"
>   	"efidebug images\n"
>   	"  - show loaded images\n"
>   	"efidebug log\n"

