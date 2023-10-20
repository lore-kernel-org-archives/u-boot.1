Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58E6CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 13:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54C186FD9;
	Fri, 20 Oct 2023 15:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WwR95ljm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 719F98746A; Fri, 20 Oct 2023 15:04:54 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34DED86FBD
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 15:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=maz@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id BC259B831BE;
 Fri, 20 Oct 2023 13:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2374FC433C8;
 Fri, 20 Oct 2023 13:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697807091;
 bh=zgaA1Gcsoaj3h8hAPD3KssZnADaHhZ1RGbHMvE3l9E0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WwR95ljmhLf1LmlrFCy7LAYdaRkWkj80hocvZveTi3vy7ndAr6e1oJoaOoA6eWD6H
 VaSAGO7d005ssZL6biKiBc+HB2NVKpJb4jS/BaZdW6cL3zBXIwYpyG2zIXlj9Voqec
 IXQODYePXIGahzMkZFikh2WhbmtWj5RxJo5VW04x9QvnsAUY5Yg7hJ8n1U0yicb5pq
 GwRnJlNnN0qsgPXUxkrHIsPYZBTq+yzgurBIinKzBltfKb1ZjJhXf0NBM0N6+cx2/G
 2lZ+kwxjU162oer0KA0Eg8ZsC+oKRn5G4AHDVsN1116m5EBgn/1kXFyrESmKF1gjzQ
 t0n7pYqWSpj1A==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1qtpBI-0067v1-UU;
 Fri, 20 Oct 2023 14:04:49 +0100
MIME-Version: 1.0
Date: Fri, 20 Oct 2023 14:04:48 +0100
From: Marc Zyngier <maz@kernel.org>
To: Chris Packham <judge.packham@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Stefan Roese
 <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm: mvebu: AC5/AC5X: use fixed page table size
In-Reply-To: <20231018205358.1557234-1-judge.packham@gmail.com>
References: <20231018205358.1557234-1-judge.packham@gmail.com>
User-Agent: Roundcube Webmail/1.4.14
Message-ID: <063a16d559dc9cb327c9459803005006@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: judge.packham@gmail.com, u-boot@lists.denx.de,
 sjg@chromium.org, sr@denx.de, trini@konsulko.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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

On 2023-10-18 21:53, Chris Packham wrote:
> Since commit 6cdf6b7a340d ("arm64: Use FEAT_HAFDBS to track dirty pages
> when available") the default get_page_table_size() sets some flags for
> more efficient handling of dirty page table entries. This causes
> problems on the AC5/AC5X SoC (specifically a lockup when calling
> __asm_switch_ttbr() via mmu_set_region_dcache_behaviour()).
> 
> The reason for the lockup isn't at all clear but it can be avoided if 
> we
> provide our own get_page_table_size() which stops gd->arch.has_hafdbs
> from being set to true effectively returning the AC5/AC5X to the older
> behaviour. This also opts for a simple fixed page table size rather 
> than
> trying to duplicate the more complicated logic to optimise the table
> size.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
> 
>  arch/arm/mach-mvebu/alleycat5/cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-mvebu/alleycat5/cpu.c
> b/arch/arm/mach-mvebu/alleycat5/cpu.c
> index 8204d9627515..7ba57ae75e76 100644
> --- a/arch/arm/mach-mvebu/alleycat5/cpu.c
> +++ b/arch/arm/mach-mvebu/alleycat5/cpu.c
> @@ -63,6 +63,11 @@ static struct mm_region ac5_mem_map[] = {
> 
>  struct mm_region *mem_map = ac5_mem_map;
> 
> +u64 get_page_table_size(void)
> +{
> +	return 0x80000;
> +}
> +
>  void reset_cpu(void)
>  {
>  }

This looks terribly wrong. In all honesty, if the original
patch creates problems and that people add this sort of stuff
to paper over it, I'd rather your *revert* my patch altogether.

         M.
-- 
Jazz is not dead. It just smells funny...
