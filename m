Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B330C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 13:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F7F82B20;
	Tue, 29 Jul 2025 15:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="I93xJXmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1098182BA1; Tue, 29 Jul 2025 15:23:51 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FB0B8129F
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 15:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4brwz71GYyz9sbt;
 Tue, 29 Jul 2025 15:23:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753795427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=my5zpqTXWxGbaQKgf+sA/XuB34VpwvMS8aE2SyY5n8s=;
 b=I93xJXmFmchYB+1h7jYZOKV9k4zkMO3v/vV2JQb8j0txeSLq+49CePQvH2jocpS8Bh+tLi
 xqpXgrIUoSlq/BeOw8ZyzQ6EgKOzxx3BJL67WD58OkXQuGbUS/ybD498tKKVqKHxNaZucI
 UAwEjHXm7DPuRvE6+Iq9fFWIPzIC0hOhe8vQYBHQ4vWocVo0XzfqJ4nqaltpGk4f3nME7X
 reMG0Xkbr/+BjJ4fEq4cKX9Uvpvr0fqLRhsAFEex28XxrOt8FPJKkaCdw/pSGUM1RxCMIb
 U3TI6xcRVt8FiAh4Khmq1Poa8fIrbcdU8tXp+abKJLIC+iWGUPDRkdv6nlVa5w==
Message-ID: <6a059cd6-487c-4597-b97c-14d65208fbf3@mailbox.org>
Date: Tue, 29 Jul 2025 15:23:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] cmd: tlv_eeprom: fix typo errors in comments and error msg
To: Hugo Villeneuve <hugo@hugovil.com>, Tom Rini <trini@konsulko.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
References: <20250612140410.768650-1-hugo@hugovil.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250612140410.768650-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qh446zmooy6mn78hop4gqgux45snab5d
X-MBO-RS-ID: 328ddc2f71be7c2fdd2
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

On 12.06.25 16:04, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Fix typo errors in comments and error message by replacing EERPOM->EEPROM.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
>   cmd/tlv_eeprom.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/cmd/tlv_eeprom.c b/cmd/tlv_eeprom.c
> index d7c229e5441..89546cef16f 100644
> --- a/cmd/tlv_eeprom.c
> +++ b/cmd/tlv_eeprom.c
> @@ -41,7 +41,7 @@ static int set_date(char *buf, const char *string);
>   static int set_bytes(char *buf, const char *string, int *converted_accum);
>   static void show_tlv_devices(int current_dev);
>   
> -/* The EERPOM contents after being read into memory */
> +/* The EEPROM contents after being read into memory */
>   static u8 eeprom[TLV_INFO_MAX_LEN];
>   
>   static struct udevice *tlv_devices[MAX_TLV_DEVICES];
> @@ -430,7 +430,7 @@ int do_tlv_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   	static int has_been_read;
>   	int ret;
>   
> -	// If no arguments, read the EERPOM and display its contents
> +	// If no arguments, read the EEPROM and display its contents
>   	if (argc == 1) {
>   		if (!has_been_read) {
>   			ret = read_eeprom(current_dev, eeprom);
> @@ -560,7 +560,7 @@ U_BOOT_CMD(tlv_eeprom, 4, 1,  do_tlv_eeprom,
>   /**
>    *  tlvinfo_find_tlv
>    *
> - *  This function finds the TLV with the supplied code in the EERPOM.
> + *  This function finds the TLV with the supplied code in the EEPROM.
>    *  An offset from the beginning of the EEPROM is returned in the
>    *  eeprom_index parameter if the TLV is found.
>    */
> @@ -631,7 +631,7 @@ static bool tlvinfo_add_tlv(u8 *eeprom, int tcode, char *strval)
>   	char data[MAX_TLV_VALUE_LEN];
>   	int eeprom_index;
>   
> -	// Encode each TLV type into the format to be stored in the EERPOM
> +	// Encode each TLV type into the format to be stored in the EEPROM
>   	switch (tcode) {
>   	case TLV_CODE_PRODUCT_NAME:
>   	case TLV_CODE_PART_NUMBER:
> @@ -691,7 +691,7 @@ static bool tlvinfo_add_tlv(u8 *eeprom, int tcode, char *strval)
>   	// Is there room for this TLV?
>   	if ((be16_to_cpu(eeprom_hdr->totallen) + ENT_SIZE + new_tlv_len) >
>   			TLV_TOTAL_LEN_MAX) {
> -		printf("ERROR: There is not enough room in the EERPOM to save data.\n");
> +		printf("ERROR: There is not enough room in the EEPROM to save data.\n");
>   		return false;
>   	}
>   
> 
> base-commit: d7c449c3d83a986d61e38d1762433c0607caf5c5

