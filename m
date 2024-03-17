Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8B0C54E67
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 17:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 360A987F39;
	Sun, 17 Mar 2024 18:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="T7A3S5m9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pfk2ka3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F1D87EDF; Sun, 17 Mar 2024 18:10:41 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88BAC87DD8
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 18:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TyPdB1R2dz9sWZ;
 Sun, 17 Mar 2024 18:10:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710695438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjAsDaSo1GLQNETbm0ZfqsU17/sNhT7fuMyO8bvI8+8=;
 b=T7A3S5m9BM57QG52HmOEc0ktStJwerODINjTJsM5yGw+inWJdceuNno3ypWVU2kXMvRpm9
 /Ms6fyzTkC7lpwwLl+iDHzgT4fqrsFz8SRMPzNb2cCtqxnKcDRLqW8HnyD2tJ+MWrFuP9R
 Ncjx/rCXZC4wLqWvrCNrrCSORDLQnzHT8LI8YJU5LlOAhy1iEACDJ/Qh644wQVMsESr7Gx
 l1R178DqvF15IVvaOZeaYW14WEMw69TpM7peKD6jcMjHFzkLf66WoaYpasyuoN4AyCh4v3
 kVP9Et8YPPyfIN5yuYt1bld4rPJIj4nWr4XnUKe18Z3qeiAy9l1n2LjI/VK+jQ==
Message-ID: <8e3c811d-5935-49a8-a41c-cc45e91be024@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710695436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjAsDaSo1GLQNETbm0ZfqsU17/sNhT7fuMyO8bvI8+8=;
 b=pfk2ka3H2+VbnZGqyC7vn1SDWYN9CvH0XhTt5i66P0RvfjxPLNYOP53K1JdXDGulVSq4JM
 K0aJ9X1dl9KKg8q5/kRBlnrtggH5WV38YPMwkvPkUIVj4wZcqfWI4UNI1xXLpCAQOSBoOt
 6K5O1E2nkttRSgP09M2FX31zpGFLX0+ign5fsYXUeL/SEBQjjQjzbqUm3uqLrrjhmGKe0K
 mWlfoUcT2CqvXeCRn7RfDyrTNoyXl73u8FDjg/CEh9ZlSOwqVJpBUYemcNsekbbIvwjqw6
 l7oV/TyKQ+moAjGcvivakIan6Lvmr0Q0lcjijJ0qkCg7aaD+8ePMZVUSyYA0Xg==
Date: Sun, 17 Mar 2024 17:59:14 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] boot: fdt: Change type of env_get_bootm_low() to
 phys_addr_t
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
 <20240317111818.GE9082@pendragon.ideasonboard.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240317111818.GE9082@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: n9wwrez7fz37j45y3g5p1whxb9geoezh
X-MBO-RS-ID: 837964d82db97e6c02b
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

On 3/17/24 12:18 PM, Laurent Pinchart wrote:
> Hi Marek,
> 
> Thank you for the patch.
> 
> On Sun, Mar 17, 2024 at 07:16:29AM +0100, Marek Vasut wrote:
>> Change type of ulong env_get_bootm_low() to phys_addr_t env_get_bootm_low().
>> The PPC/LS systems already treat env_get_bootm_low() result as phys_addr_t,
>> while the function itself still returns ulong. This is potentially dangerous
>> on 64bit systems, where ulong might not be large enough to hold the content
>> of "bootm_low" environment variable. Fix it by using phys_addr_t, similar to
>> what env_get_bootm_size() does, which returns phys_size_t .
>>
>> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>>   boot/bootm.c       |  2 +-
>>   boot/image-board.c | 11 ++++++-----
>>   boot/image-fdt.c   |  9 +++++----
>>   include/image.h    |  2 +-
>>   4 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/boot/bootm.c b/boot/bootm.c
>> index d071537d692..2e818264f5f 100644
>> --- a/boot/bootm.c
>> +++ b/boot/bootm.c
>> @@ -242,7 +242,7 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
>>   #ifdef CONFIG_LMB
>>   static void boot_start_lmb(struct bootm_headers *images)
>>   {
>> -	ulong		mem_start;
>> +	phys_addr_t	mem_start;
>>   	phys_size_t	mem_size;
>>   
>>   	mem_start = env_get_bootm_low();
>> diff --git a/boot/image-board.c b/boot/image-board.c
>> index 75f6906cd56..447ced2678a 100644
>> --- a/boot/image-board.c
>> +++ b/boot/image-board.c
>> @@ -107,12 +107,13 @@ static int on_loadaddr(const char *name, const char *value, enum env_op op,
>>   }
>>   U_BOOT_ENV_CALLBACK(loadaddr, on_loadaddr);
>>   
>> -ulong env_get_bootm_low(void)
>> +phys_addr_t env_get_bootm_low(void)
>>   {
>>   	char *s = env_get("bootm_low");
>> +	phys_size_t tmp;
>>   
>>   	if (s) {
>> -		ulong tmp = hextoul(s, NULL);
>> +		tmp = (phys_addr_t)simple_strtoull(s, NULL, 16);
>>   		return tmp;
> 
> Can't you write
> 
> 		return (phys_addr_t)simple_strtoull(s, NULL, 16);
> 
> and avoid the temporary variable ?

Fixed in V2, thanks
