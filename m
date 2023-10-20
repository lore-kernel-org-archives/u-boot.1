Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04406CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 06:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A4B786F89;
	Fri, 20 Oct 2023 08:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697782703;
	bh=v1qeW+RqvmlQUqMtTKNbGg3qnH7FkFOlLQ/5fqbGaz4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s/1LohXaTAEenc7cyagETI/wkczm4uAO4Iz6OTsSkCqh21lsuw0OCEfcZ+Sw5TTHG
	 /JESY169s9TYMQghFRmIrMSmUirJLV5eYXyOuqLTGAOfaYh03n6UZ22C/pDls3TEOY
	 UCIIkMWMbXhKgxBtI3y6ze43bmeOTWihMD56SOryyJn6MaKi0Cc4ka8urOgHxO2m2R
	 DLbjXXBG//GC/nAdz1Ljpl5P5fvRfq6I3CsPPE74PwaAizNb9LSV2kdTy3OPvEnhw0
	 xnKlCFDTQVqlJ03hZc9ZKUfptYAtb7cwZNpI6AeqbVUOBFpl9hBGIEc8o0MzsoEMnc
	 Wb+NitxsDaY8g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CEC587207; Fri, 20 Oct 2023 08:18:22 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7477486F03
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 08:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4SBZCG30stz9sRx;
 Fri, 20 Oct 2023 08:18:18 +0200 (CEST)
Message-ID: <637b7903-e40c-4760-8f37-5dbbea5184a3@denx.de>
Date: Fri, 20 Oct 2023 08:18:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: mvebu: AC5/AC5X: use fixed page table size
Content-Language: en-US
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Marc Zyngier <maz@kernel.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20231018205358.1557234-1-judge.packham@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231018205358.1557234-1-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Chris,

On 10/18/23 22:53, Chris Packham wrote:
> Since commit 6cdf6b7a340d ("arm64: Use FEAT_HAFDBS to track dirty pages
> when available") the default get_page_table_size() sets some flags for
> more efficient handling of dirty page table entries. This causes
> problems on the AC5/AC5X SoC (specifically a lockup when calling
> __asm_switch_ttbr() via mmu_set_region_dcache_behaviour()).
> 
> The reason for the lockup isn't at all clear but it can be avoided if we
> provide our own get_page_table_size() which stops gd->arch.has_hafdbs
> from being set to true effectively returning the AC5/AC5X to the older
> behaviour. This also opts for a simple fixed page table size rather than
> trying to duplicate the more complicated logic to optimise the table
> size.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

I'm not 100% happy with this approach / workaround - still it fixes an
issue on your board, so:

Reviewed-by: Stefan Roese <sr@denx.de>

Perhaps you (or someone else) can look into this in more depth to get
to the root of this issue at a later time.

Thanks,
Stefan

> ---
> 
>   arch/arm/mach-mvebu/alleycat5/cpu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-mvebu/alleycat5/cpu.c b/arch/arm/mach-mvebu/alleycat5/cpu.c
> index 8204d9627515..7ba57ae75e76 100644
> --- a/arch/arm/mach-mvebu/alleycat5/cpu.c
> +++ b/arch/arm/mach-mvebu/alleycat5/cpu.c
> @@ -63,6 +63,11 @@ static struct mm_region ac5_mem_map[] = {
>   
>   struct mm_region *mem_map = ac5_mem_map;
>   
> +u64 get_page_table_size(void)
> +{
> +	return 0x80000;
> +}
> +
>   void reset_cpu(void)
>   {
>   }

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
