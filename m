Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C5DC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 09:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 185E187FAC;
	Thu, 28 Mar 2024 10:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711619786;
	bh=+UoV1kc2MCEffgNvuUpnZ6bJum+7y3DEGzCQLOX9HPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WV9RXVsrpo06WYllpx//DEMUaQ1xfbpa6m7Gc0I7TNg9FFA2JJiOQRIgBa/M/oinc
	 LTpsXnchWG1oyjuObpjhuIpz69/3icPmsQ9a3kQ7o3thxjV1beqxTL+UZzK1cApd9Z
	 GWQ91kIVnCLPALl2FxODeiRANd/fMOjBEIpFMxV7buTbREMamy5vQco/nfMMc7CBe2
	 AhZbxdPM0GqazpkbLZh6cU46Ys5H7WTf6/hbbVzPQEWYDv/vwuzYbt7DoUHL3es3wF
	 i5mU4B09/uFZ2LUxuxHILdLkh0BBD+4iWoniMMMyFEcmnVk421+C88MPbwZa4+U57y
	 jYbJTV3KpkNaQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EBC887E75; Thu, 28 Mar 2024 10:56:25 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A08F88124
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4V4zT113X5z9sq8;
 Thu, 28 Mar 2024 10:56:21 +0100 (CET)
Message-ID: <3e8280f1-a1ad-486f-9bf1-875c70f43f35@denx.de>
Date: Thu, 28 Mar 2024 10:56:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 06/18] arm: mvebu: turris_omnia: Print
 board ECDSA public key if available
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-7-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240327162355.24584-7-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V4zT113X5z9sq8
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

On 3/27/24 17:23, Marek Behún wrote:
> If MCU supports the FEAT_CRYPTO feature, read board ECDSA public key
> from MCU and print it.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   board/CZ.NIC/turris_omnia/turris_omnia.c | 25 +++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
> index f63640ad64..b2f0088e5e 100644
> --- a/board/CZ.NIC/turris_omnia/turris_omnia.c
> +++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
> @@ -253,6 +253,24 @@ static int omnia_mcu_board_info(char *serial, u8 *mac, char *version)
>   	return 0;
>   }
>   
> +static int omnia_mcu_get_board_public_key(char pub_key[static 67])
> +{
> +	u8 reply[34];
> +	int ret;
> +
> +	ret = omnia_mcu_read(CMD_CRYPTO_GET_PUBLIC_KEY, reply, sizeof(reply));
> +	if (ret)
> +		return ret;
> +
> +	if (reply[0] != 33)
> +		return -EBADMSG;
> +
> +	bin2hex(pub_key, &reply[1], 33);
> +	pub_key[66] = '\0';
> +
> +	return 0;
> +}
> +
>   static void enable_a385_watchdog(unsigned int timeout_minutes)
>   {
>   	struct sar_freq_modes sar_freq;
> @@ -1032,7 +1050,7 @@ int board_late_init(void)
>   
>   int checkboard(void)
>   {
> -	char serial[17], version[4];
> +	char serial[17], version[4], pub_key[67];
>   	bool has_version;
>   	int err;
>   
> @@ -1051,6 +1069,11 @@ int checkboard(void)
>   	printf("  Board version: %s\n", has_version ? version : "unknown");
>   	printf("  Serial Number: %s\n", !err ? serial : "unknown");
>   
> +	if (omnia_mcu_has_feature(FEAT_CRYPTO)) {
> +		err = omnia_mcu_get_board_public_key(pub_key);
> +		printf("  ECDSA Public Key: %s\n", !err ? pub_key : "unknown");
> +	}
> +
>   	return 0;
>   }
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
