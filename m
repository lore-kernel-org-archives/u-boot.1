Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7241DC7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 19:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF8FF81D5D;
	Fri, 27 Jun 2025 21:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0580682B6B; Fri, 27 Jun 2025 21:16:03 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F883806D8
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 21:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.144])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 9F7D1B4D0305;
 Fri, 27 Jun 2025 21:15:46 +0200 (CEST)
Message-ID: <fa087253-3804-4db7-9b4a-49b9a51e4968@freeshell.de>
Date: Fri, 27 Jun 2025 12:15:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] env: mmc: specify that the address is a block address
 when erasing
To: Quentin Schulz <foss+uboot@0leil.net>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250627-env-mmc-erase-blk-v1-1-d4b8fa90f68b@cherry.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250627-env-mmc-erase-blk-v1-1-d4b8fa90f68b@cherry.de>
Content-Type: text/plain; charset=UTF-8
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



On 6/27/25 07:04, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> I got very confused by the address printed when erasing the environment
> because I clearly didn't remember setting it at that location.
> 
> It turns out, it's the block offset and not the byte offset that is
> reported, so let's make this a bit more obvious to the user.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Another option would be to report the byte offset by multiplying
> blk_start by desc->blksz I guess. The result needs to be stored in a u64
> though instead of uint otherwise we'll be limited to 4GiB offset (which
> should be fine in most cases but eh).
> ---
>  env/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/env/mmc.c b/env/mmc.c
> index 8848371eb4f5df58da2be5398f159fdd0a00da21..f16926dc74c594b15f0bc82301aa89e1d4456d59 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -383,7 +383,7 @@ static inline int erase_env(struct mmc *mmc, unsigned long size,
>  	blk_cnt = ALIGN(size, erase_size) / desc->blksz;
>  
>  	n = blk_derase(desc, blk_start, blk_cnt);
> -	printf("%d blocks erased at 0x%x: %s\n", n, blk_start,
> +	printf("%d blocks erased starting from block at 0x%x: %s\n", n, blk_start,
>  	       (n == blk_cnt) ? "OK" : "ERROR");
>  
>  	return (n == blk_cnt) ? 0 : 1;
> 
> ---
> base-commit: 359e3012921f2fc2d43f3c4e320a752173f82b82
> change-id: 20250627-env-mmc-erase-blk-7a46a3e63c78
> 
> Best regards,

NAK. This is more text on the line and less readable; by doing this here
and nowhere else the overall effect is adding to the confusion.

Look at this (topically related) snippet output:

"Bytes transferred = 534773760 (1fe00000 hex)

MMC read: dev # 0, block # 8355840, count 1044480 ... 1044480 blocks
read: OK
Total of 534773760 byte(s) were the same"

What units and packet lengths are these numbers? It's hopeless. All of
that output is garbage to me as the user, missing context required to
make sense of it.  Adding word-qualifiers I suppose attempts to add
clarity but the result lacks any meaning. The command which does get it
right about hexadecimal v. decimal units does so with a displaying a
literal word qualifier "hex" suffix, not consistent with what we're
doing elsewhere.

I do agree with your premise that hex address locations and sizes, and
block counts, are presented in a confusing mix-and-match to the user.
Decimal numbering is the exception and not the rule but we somehow all
decide that it's *not important* to make this obvious to the user who
will have to input everything (except only some things, some times, but
non-obviously) as hexadecimal. We insist on showing "0x" prefix but user
input without this prefix is still considered as hexadecimal which is
just terrible UX all around.

Instead of this one patch in one place and nowhere else - I suggest to
fix the problem which is U-Boot code base (and code style) has no
discernible convention for documenting and displaying these outputs. I
understand the technical limitations of decimal user input/output
exceeding the memory type sizes, but...


#1 rule: DO NOT show me decimal output while only accepting hexadecimal
at input, it is ridiculous.

also #1 rule: Packet length not-equal-to-one? Display the packet length
with the output.

Our consistency of units in both documentation and display of
information is the problem - which I really do want to see resolved...
can we?

-E
