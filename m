Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B338AC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 12:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAD2A879E5;
	Thu, 18 Jan 2024 13:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="N4Wc+Q9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B82CE879F7; Thu, 18 Jan 2024 13:54:16 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB2468798D
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 13:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.161] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 78A443F6F1; 
 Thu, 18 Jan 2024 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705582453;
 bh=EZimukUMaE8yo6GkKBrZuh0yshiXtjgMNhEFZg7UkEI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=N4Wc+Q9kZuww05hwdlUN+KNbdZeustLxkDSR2K/vjDaoyoBNcYWFxAhWa6HiZgJkR
 Uq/PXJy1Gm7tLwwYYeJ6koe9YxW7sZ81Sb0MEB1VAPFIBLThuDP0LOstcDw+zCGnsf
 E9by1NHtAa28Esn9rcvf7U3xveJmHvhoU5xjq9A0hC8khGYyoFxdvhgbN/sV0MP0GG
 fmozaF6A1FVB2qKcyZZkscEBsiZolvJTt5ATg1bY6e+5qbxuP7ehyZ/6+8/vyBe/OW
 xXxuTZSQbAqyHVH9yzhk1EMcTuVk2QUVvgTZciLiWU0JBzk6thneDOwQlbDXq+r4M5
 qbOpXDqOGM2+w==
Message-ID: <c7941f3b-177e-4f51-b9b1-602b88229c66@canonical.com>
Date: Thu, 18 Jan 2024 13:54:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cmd: provide command to display SMBIOS information
Content-Language: en-US, de-DE
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
 <20240117153347.85074-2-heinrich.schuchardt@canonical.com>
 <Zakb7ozkAU994FBj@hera>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <Zakb7ozkAU994FBj@hera>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/18/24 13:39, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> A few nits below
> 
> On Wed, Jan 17, 2024 at 04:33:45PM +0100, Heinrich Schuchardt wrote:
>> U-Boot can either generated an SMBIOS table or copy it from a prior boot
>> stage, e.g. QEMU.
>>
>> Provide a command to display the SMBIOS information.
>>
>> Currently only type 1 and 2 are translated to human readable text.
>> Other types may be added later. Currently only a hexdump and the list of
>> strings is provided for these.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>> v2:
> 
> [...]
> 
>> 	email address updated
>> +static struct smbios_header *next_table(struct smbios_header *table)
>> +{
>> +	const char *str;
>> +
>> +	if (table->type == SMBIOS_END_OF_TABLE)
>> +		return NULL;
>> +
>> +	str = smbios_get_string(table, 0);
>> +	return (struct smbios_header *)(++str);
> 
> That can lead to unaligned access when we dereference that pointer, do we
> care?

SMBIOS tables are always byte aligned. This is why struct smbios_header 
is marked as packed. The GCCj documentation has this sentence:

"The packed attribute specifies that a variable or structure field 
should have the smallest possible alignment - one byte for a variable, 
and one bit for a field, unless you specify a larger value with the 
aligned attribute."

So shouldn't the compiler care about non-alignment? If there were a 
problematic usage, GCC would throw -Waddress-of-packed-member.

Best regards

Heinrich

> 
>> +}
>> +
>> +static void smbios_print_generic(struct smbios_header *table)
>> +{
>> +	char *str = (char *)table + table->length;
>> +
> 
> Do we want the header below printed if there are no strings?
> IOW can we exit early if (!*str) ?
> 
>> +	if (CONFIG_IS_ENABLED(HEXDUMP)) {
>> +		printf("Header and Data:\n");
>> +		print_hex_dump("\t", DUMP_PREFIX_OFFSET, 16, 1,
>> +			       table, table->length, false);
>> +	}
>> +	if (*str) {
>> +		printf("Strings:\n");
>> +		for (int index = 1; *str; ++index) {
>> +			printf("\tString %u: %s\n", index, str);
>> +			str += strlen(str) + 1;
>> +		}
>> +	}
>> +}
>> +
>> +void smbios_print_str(const char *label, void *table, u8 index)
>> +{
>> +	printf("\t%s: %s\n", label, smbios_get_string(table, index));
>> +}
>> +
> 
> 
> Other than that, LGTM
> 
> Thanks
> /Ilias

