Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F75C021B0
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 07:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C8F80F95;
	Thu, 20 Feb 2025 08:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UwWLaltc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B532480F98; Thu, 20 Feb 2025 08:40:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CD1980F95
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 08:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740037237; x=1740642037; i=xypron.glpk@gmx.de;
 bh=WaiwUshpJbK5NYES14EPrONT3Eyg/obOWuYamgcSr8w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UwWLaltcKM6hEyr6G7hEeoJw3b3ONSM2tHhmPdx4nXaIldqM+dF9c6PWOjC9CknM
 vi3khH4sVR9E1tGITW92ZUpKTFiRSvRklKtHVxicQz43iRrXXJGinKjOH1BBlgqtr
 6JTUh60bzFrbfcmyCMiWvpdRXBWV+g3FiBywoQKI1XVJUvFfqpSRNE+O2LzKoPADM
 F91xuB12rCSC/0hPmm41awl3SU/jXDqdFF2ncskIoyaEggvP9cdBRT6hQGK8n8Azr
 kTvEcub+9Fc6zSFYAdpkcLuzGFkIfKqjztjTsNX+L4KRzz6IyB/xgx1PpCO8JSAZG
 hLUO39gN9Old5UDbPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MplXp-1szrdg0mWz-00cmbu; Thu, 20
 Feb 2025 08:40:37 +0100
Message-ID: <6731f7f2-25c0-433f-8bb1-2cb31f204d48@gmx.de>
Date: Thu, 20 Feb 2025 08:40:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: uuid: support more efi protocols in
 uuid_guid_get_str()
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250117171327.1641490-1-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250117171327.1641490-1-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FcggO1FUNPC32zeD5KmtsQlNrsXuSLF63nPQ2vWQJM6eKDHTwzZ
 kaVA+CpNvI7LGvGIQjDZ2SNb2f+eolfUWaJUa3jF30sc+9LgbNhSat/uWGTIC/LQKFxl8UU
 7EUEnQ5y5lKTWY9lZS7+nJ7mwFPLyzEAqcMZ2FTaTyavPcAJ58jUiTCclH2aoByK9yZCj6f
 O4K8mLjqn9q3n2i+FgEhw==
UI-OutboundReport: notjunk:1;M01:P0:u+6b5z1oO5I=;tv8FE5rggutVEsbxrnvQEurN8I3
 JP+4KIhJBD50rQPEwz5BRS3AJjdpi3q18LCWnCsm+P4bOn4Mc3Vyx9EGbcU0IRCwDO6RIKgD7
 aS6f+v99EogU3lzUIi/N65RrLrmZMUBs0/7lW6E5+d3nWVB6H0dJcib2QrMIvgEchgBYpDlb/
 jZhgCaT+FYkdSID4MAizusGCobyYODzRvA1JRdBVf20B7QVg1BeEfHO5sV/cVzmIM5YCT4698
 6QH+NFulblTyMdYRWrtNi9PbiyohKlXVFhap1Gy/Q77YemApSqzFRLajdn9T7v/nm0V7clwWw
 1kYzOqXRZG4jTGYYDi5e6pBf5iTT2aoFFGuNTFxg2jv/eo/fH8g7m5/4PjoGQ5doWp0wstpyW
 TfcFmYhds8XyhPsKq4BUwdwjIERDvXD9K0KOHjLSOlVgrWBnkPE/vq4e1zcSmP48FHks7vjjx
 GlaeB5LHOW+BDSclE0+YC6A3SSD1s5gTKQODU4tuuaqn3Yq2U9lngZcTxlVq+iNcmzhbE2sXk
 5OqRQt7jdY3RGHlM/qweV2CqLGXYNJTRgwmcLruOYKVzph+U1j4lZe/VyO5FEZqNCzfHgBxYk
 7o6q9UKkNz8yucHh3dbALaSWV6OOPgQ2xHkvVgB1LkPo1mjhJk9NzOp0iQgdVP7m0xMvFgo/l
 BX4dKOrDLzMXOLge/Q1mjxhQkTfYAVBHSuQQZTIZYaCxyhbCJxdr+x+8Vqp9LW7VgDi4dSMA/
 OtnYIcTXvb2fSUwCdOFAqXM/N/Dh3kNeiBT020F+hsVIfj0yCGl1dZZXWWc4s9SB6oURxDDCs
 i/aai0VygoJR2xTs+CL2S2aGJBV5OvDa/MOzg6B0gf3F0F5+4E3TBtMTvkKLpGUcrSVrrVH4r
 k32s3QcERHAi9H9y+bUg2aoHKFBjmR4ZMLWcKLPVGsovO84s4OnF8A/6BOCBrfxG2Hnq3FNqS
 ytTKr91FILQ6onHAa7H2SPi//rdfPAsrD4CDXGEVI5/PQdWU/9rtvUhKOlrJS58lmle+Dy/so
 EFe2ffTKQaKv+MtS7rw+tCcCYcOpvi8k32C92PZarzaSCyNQHHtMvcW1b1KpPkfIKK5Y7wyK4
 i2rlh9CMxHyTzuhzHAF8Z7c9tdocWmh0zznACOxf5VTYGL3PSXB/Brb6udAAlqURNk92ndXo0
 Zq7tgq78PRmXyPdldV0sEByJmBfeTjHGo7RwsswgYv36EQGN3aGKbOLwIVr2HnZxq7ZohW6lj
 yCTynDbAr8xsWbL6TGsavi6jSu6Oz2aMLB+Mu62xrINdoZwKBDkJz5Am7hssV6YDC+BUOSp6C
 SgZPhRFOpjjb5OqvfkkVneSfxz8bla/wouchATLHkK4jzzUgdPTpRTz3vuER22RT0XS1edSft
 rMXqkMFNf81aooZWKJCxPajmsRNo+haBwSKCaisPMAI0UOiWLWcQh2eFoE
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

On 1/17/25 18:13, Vincent Stehl=C3=A9 wrote:
> Add more EFI protocols GUIDs to the translation table used by
> uuid_guid_get_str().
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> Hi,
>
> While the EFI_LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID, the
> EFI_HII_CONFIG_ACCESS_PROTOCOL_GUID and the EFI_LOAD_FILE_PROTOCOL_GUID =
are
> actually used by the efi_loader, this is not the case with the
> EFI_DISK_IO_PROTOCOL_GUID.
> I think we should add this GUID to the table nonetheless, as it can help
> with debugging EFI applications and we already have this GUID's definiti=
on
> in the headers.
> If that is not desired, please do not hesitate to drop the first hunk of
> this patch.
>
> Best regards,
> Vincent.
>
>   lib/uuid.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 97388f597a6..75658778044 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -119,6 +119,10 @@ static const struct {
>   		"Block IO",
>   		EFI_BLOCK_IO_PROTOCOL_GUID,
>   	},
> +	{
> +		"Disk IO",
> +		EFI_DISK_IO_PROTOCOL_GUID,
> +	},
>   	{
>   		"Simple File System",
>   		EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID,
> @@ -127,6 +131,10 @@ static const struct {
>   		"Loaded Image",
>   		EFI_LOADED_IMAGE_PROTOCOL_GUID,
>   	},
> +	{
> +		"Loaded Image Device Path",
> +		EFI_LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID,
> +	},
>   	{
>   		"Graphics Output",
>   		EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID,
> @@ -139,10 +147,18 @@ static const struct {
>   		"HII Database",
>   		EFI_HII_DATABASE_PROTOCOL_GUID,
>   	},
> +	{
> +		"HII Config Access",
> +		EFI_HII_CONFIG_ACCESS_PROTOCOL_GUID,
> +	},
>   	{
>   		"HII Config Routing",
>   		EFI_HII_CONFIG_ROUTING_PROTOCOL_GUID,
>   	},
> +	{
> +		"Load File",
> +		EFI_LOAD_FILE_PROTOCOL_GUID,
> +	},
>   	{
>   		"Load File2",
>   		EFI_LOAD_FILE2_PROTOCOL_GUID,

