Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9453C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 13:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4577A82B20;
	Tue, 29 Jul 2025 15:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iNRqqEDD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F7B182B20; Tue, 29 Jul 2025 15:24:15 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F9C78129F
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 15:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4brwzb384Kz9t1n;
 Tue, 29 Jul 2025 15:24:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753795451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rON+v19oPY3utCxLqAOI8gLjEDmRD0mwPmm7Y5I0m7c=;
 b=iNRqqEDDax7QY7etnf2uA/YNThkBMrR5c7rWcoFQg5MmLTyKEsrkWtw2CcZMJVJwUeVsMf
 K5FwENheJFErFAft6prLymMu9tmx8hU//HOOvocigqo4MF9A0zSYT8LyzOfZO0wuJJl13C
 5xH+ieoTuRdH8sH1mhwVFjI03NLD2zKTJ7D8Efz8JVXFQ2WYcq0mqP/wxJ0TIpAIdhlEff
 PPpLLU8GhmMjn/fNhFmx8xZNkDZFGMeSC2UzVz3UDaWKWU9KlDFJkpvUfrY7i9mBgIBRJA
 HuEbnSHNbXsiZsohtGNs3wt5e+Zi61tjfI/YCVaC2eo+uHxBqgqu6eIjuw+t4A==
Message-ID: <6ec962cc-7978-4d27-a049-046e2a5ba7ba@mailbox.org>
Date: Tue, 29 Jul 2025 15:24:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] cmd: tlv_eeprom: improve mac_read_from_eeprom() log
 messages
To: Hugo Villeneuve <hugo@hugovil.com>, Tom Rini <trini@konsulko.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
References: <20250618132538.855803-1-hugo@hugovil.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250618132538.855803-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 246fa0c26dddadf7855
X-MBO-RS-META: p64kghuexwjcakaohhu4j5946ob68nyt
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

On 18.06.25 15:25, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> mac_read_from_eeprom() always display debug infos, and this messes up the
> display of the "Net:" section details:
> 
> Before:
>      Net:   EEPROM: TlvInfo v1 len=172
>      eth0: ethernet@11c20000
> 
> After:
>      Net:   eth0: ethernet@11c20000
> 
> Fix by moving unconditional "EEPROM: " header into each message and
> changing debug message to use log_debug().
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
>   cmd/tlv_eeprom.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/cmd/tlv_eeprom.c b/cmd/tlv_eeprom.c
> index d7c229e5441..86fee7771a4 100644
> --- a/cmd/tlv_eeprom.c
> +++ b/cmd/tlv_eeprom.c
> @@ -1033,10 +1033,8 @@ int mac_read_from_eeprom(void)
>   	struct tlvinfo_header *eeprom_hdr = to_header(eeprom);
>   	int devnum = 0; // TODO: support multiple EEPROMs
>   
> -	puts("EEPROM: ");
> -
>   	if (read_eeprom(devnum, eeprom)) {
> -		printf("Read failed.\n");
> +		log_err("EEPROM: read failed\n");
>   		return -1;
>   	}
>   
> @@ -1082,8 +1080,8 @@ int mac_read_from_eeprom(void)
>   		}
>   	}
>   
> -	printf("%s v%u len=%u\n", eeprom_hdr->signature, eeprom_hdr->version,
> -	       be16_to_cpu(eeprom_hdr->totallen));
> +	log_debug("EEPROM: %s v%u len=%u\n", eeprom_hdr->signature, eeprom_hdr->version,
> +		  be16_to_cpu(eeprom_hdr->totallen));
>   
>   	return 0;
>   }
> 
> base-commit: 17012e3068d047ad71460f039eeb0c3be63f82a0

