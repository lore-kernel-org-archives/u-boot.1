Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62A1C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 09:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E53880FC;
	Thu, 28 Mar 2024 10:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711619634;
	bh=67y9uXcPCO8g0OK5Sl/kjROJh1snN20DOazw7pu+Xz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tKFMbwfGG0tLLYe4+J40dNgySNAIO+cICn/DfF0EHcCDYv1GQ0ml1b6xj1Ak6GidG
	 AyKH60CCqedXtCgd/oR9ISnD87goN7Om0MiGs64qwMttlW6aUGBkzLEUXGL+i93S9x
	 mrl9tOVeMQKzCNvEoIR/yLvFzr7hGpmOpVGOlZpBpMipcRtUFjDBURUfWQBqSbaOJq
	 yprnCrePtBC1up9IfzO9O+c51HaoZS7WiZldmnUCb8PbdQlc6lB7E87++S7DaP86mu
	 Py86ccGnXXSLL1mdtdn5JTkQ+TGzNQuEF5pv9G9y3jKw+EzTEzOI0d2CWeaK4sqLpf
	 9CTpLLNOCgLtQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 510AB880FB; Thu, 28 Mar 2024 10:53:52 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8249787FAC
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4V4zQ43fLyz9spM;
 Thu, 28 Mar 2024 10:53:48 +0100 (CET)
Message-ID: <05d392c7-125c-4cd0-98b6-8b9151dad2e0@denx.de>
Date: Thu, 28 Mar 2024 10:53:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 03/18] arm: mvebu: turris_{omnia, mox}:
 Don't print model two times
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-4-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240327162355.24584-4-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V4zQ43fLyz9spM
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
> Since commit 8cd4bf7dc9ba ("turris: Use checkboard() instead of
> show_board_info()") the model is show two times during boot:
>    Model: Turris Omnia
>    Model: Turris Omnia
> 
> This is because the common function show_board_info() shows it, and
> Turris' checkboard() also does.
> 
> Remove the second print.
> 
> Fixes: 8cd4bf7dc9ba ("turris: Use checkboard() instead of show_board_info()")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   board/CZ.NIC/turris_mox/turris_mox.c     | 5 +----
>   board/CZ.NIC/turris_omnia/turris_omnia.c | 1 -
>   2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/board/CZ.NIC/turris_mox/turris_mox.c b/board/CZ.NIC/turris_mox/turris_mox.c
> index 3489bdd74b..1a2f60e3d1 100644
> --- a/board/CZ.NIC/turris_mox/turris_mox.c
> +++ b/board/CZ.NIC/turris_mox/turris_mox.c
> @@ -565,13 +565,10 @@ static void handle_reset_button(void)
>   int checkboard(void)
>   {
>   	int i, ret, board_version, ram_size, is_sd;
> -	const char *pub_key, *model;
> +	const char *pub_key;
>   	const u8 *topology;
>   	u64 serial_number;
>   
> -	model = fdt_getprop(gd->fdt_blob, 0, "model", NULL);
> -	printf("Model: %s\n", model);
> -
>   	ret = mbox_sp_get_board_info(&serial_number, NULL, NULL, &board_version,
>   				     &ram_size, NULL);
>   	if (ret < 0) {
> diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
> index 6c2d7da528..87e33d88c4 100644
> --- a/board/CZ.NIC/turris_omnia/turris_omnia.c
> +++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
> @@ -933,7 +933,6 @@ int checkboard(void)
>   	int err;
>   
>   	err = turris_atsha_otp_get_serial_number(serial);
> -	printf("Model: Turris Omnia\n");
>   	printf("  MCU type: %s\n", omnia_get_mcu_type());
>   	printf("  MCU version: %s\n", omnia_get_mcu_version());
>   	printf("  RAM size: %i MiB\n", omnia_get_ram_size_gb() * 1024);

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
