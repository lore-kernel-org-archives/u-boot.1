Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3449606A330
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q7gQoPKW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MYGyZTa/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09ADA405CE;
	Sun,  1 Nov 2026 23:28:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eaCWDkBQYYh4; Sun,  1 Nov 2026 23:28:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 04E76405C8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793575690;
	b=s8j30qd4eTBtRVFuQkzL2T9Zf+O4erGXENswl2E+lsHVu2H9vOqBIaeqthBi/XSFo3V9
	 0fgWhpRjvR6HD/oGxja2wNclM4+R7anp/0RYdw6gvpDz7h6Jgmm6rrGFeKK68J8rThlB+
	 ZvJ4LWSr2PQvbY+Ib+4AkMwJgUdrrLplq1YD5ZpOycY43TAFy3XdEcde37JJ+pTO8OWcp
	 D+zrj3BKrmA2uVq6a5UtGkOSXj+f1osbzXxlfoXs9kehS7w17E4ncME9tFLl148Un9DoD
	 vieColkVgc9eY9xxMuo5qPczUKH5a2tIAMgdWwwjCUreoWkCB9MtEMRECKMdtlAQ0Qw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793575690;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=48KTX7AOk3CwsQ9KAtrOhGtQw23p2+Fmh0gxH55n1D8=;
	b=aeRY5VcBIBZ4i1VK9OTBtykgS7kMymuWIrGo7lUVzBwT5MRTLXrvYHO+7vNB6RyCx3Lx
	 q+B+tnxLJNAs1ryXGChDSTERoE8QA/nNad4LaC4e8A7hc5LrRKkqvQmzgsoNbSlimk+C1
	 vsR7Qig/pe9TPZdDCCRoEn82T7X0G17dFnaCDKOBTl11VFMddwhVuLhMP16W1Ej1EufVD
	 WiyYG/fo0mQPZ5pGpKvUR4nfszcvG+nAzq7r5o1JcIQQ+2jGk/wiDw/yg7PEYvVdeeJBM
	 FHrxD0fm6blcNyJDfPl4vDkfG2VwE+79Y5byNyARI/eV+Jx7E2Z2em247eYQdP8SioQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793575690;
	bh=48KTX7AOk3CwsQ9KAtrOhGtQw23p2+Fmh0gxH55n1D8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q7gQoPKW+j6NcxS220mE/NJUSJm9dxmDRClaCrtnEmdSPs8ATnN6qVQbBuYAWA4fm
	 WA6gtwrqY724kzQZCOZDB6Y0y6Gqp9xH1tMORXGhZ0o0V3sZcc/bv4LUpz9wns21yn
	 2U5+AULeHH64fvBgwKePfV8MH+FT4OG3FhU2pQZhXy2BKUXrd7xv2D4kFA8g3w7Tsj
	 uAICAqcWVq3rvIgdETC1KcAsT7VmuEmWOiqsGOnzEcWCru9JtJWwxgKVVsZwPVOpuQ
	 lxFHbcUEouymS+O+RyKXU2kHXysxHFEmj/r4gima88ODDaXmlm7jW9oqWBelG+vxb4
	 xzW9Zg5y9GcWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04E76405C8;
	Sun,  1 Nov 2026 23:28:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B0D754BC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 23:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A28916061B
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 23:28:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xiOfl-pn06ce for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 23:28:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0472060619
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793575687;
 b=qF0PEBd1NhYuP602du+lvyGNFFFVeKplU7WWSpzln2LF3GlThQw6Z26YLS0KqSKBvYHD
 woqFubWgxdh3mmDdyFDzfCTI4YXAcOTGBfY3lfGa28vXR1asgHViPcn4FN8JkRoPb2nu9
 IH7858hMpE4RnrKNUpxpNbCWJzQ9g1EAvFCiZSSFuEOoFUY7UBtDw4CUGySLoIfdXa0eL
 g8pJfMk1OkfYRbcOs0lRt1IV8pBirte/JKf2y8EevmxCOvoYfioLxWKpyNGR+U38NKLAB
 xmSlmi7jjDu2DeL1qSnqlRznTJqMMd/Er17gIgJkDkC97y1KHgp/I298tjMmb8ihUxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793575687;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=48KTX7AOk3CwsQ9KAtrOhGtQw23p2+Fmh0gxH55n1D8=;
 b=tZf8tdfSI/zu6EY5HxFQC6dL5r6uZiO0wBaoo3oWLEoVDJ0Yzm/VFks0hqlFQXMzyZjt
 LcefhagO8+mSN4rr5BrbC0LbokmeTECdUlvG84ZxdekJHYNkx/yFKhxPg7Vs+sFWkcHUK
 cFZLI/xcFvAcrAPNu8/RMRCYzZARHJt01ZFBn0kFu09JsjsJ91rzrFeB/7PtAo3kGiabf
 JBK+/lIjji9ABrooURzRfRH0I/mISqGVqbHkunbCtOw5lvEF6117BR8CItH2kZ7xEfZyS
 amF79eo1OhASPSlItyJeRgo/gNaX7nE48yXOrlmrKt2TKVNNXnjFTi/aQJQZcaO5e3g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="MYGyZTa/"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=MYGyZTa/
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0472060619
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 23:28:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D75FD27DC;
 Sun,  1 Nov 2026 15:28:01 -0800 (PST)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7C6F3F673;
 Sun,  1 Nov 2026 15:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793575685; bh=D556Mg6DU91sCjI4OWrht3raBRx6hYTUVI7DCziiSsg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MYGyZTa/ghHRuWyaJ/bQ5O1mw7QLq1QeHoqW+TtUxq3ms0NLREi01IfuXgSRAT6M5
 A05Qrwen4ygSaWMQ542mAvAndN+pJGCLfqWkf9DSfgeHeONIuPOVR/l+TpCiksQTkQ
 cYhge2kGeWJzEeGIvp7lFr+T+EUrfGWfYC4EerJU=
Date: Mon, 2 Nov 2026 00:27:55 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org,
 u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] sunxi: dram: only probe DRAM inside the addressable range
Message-ID: <20261102002755.59df587e@ryzen.lan>
In-Reply-To: <20261026173235.95831-1-jernej.skrabec@gmail.com>
References: <20261026173235.95831-1-jernej.skrabec@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 18:32:35 +0100
Jernej Skrabec <jernej.skrabec@gmail.com> wrote:

Hi Jernej,

> The non-power-of-2 size check probes the memory cell at 3/4 of the
> detected size. On SoCs whose DRAM window is smaller than the detected
> size, like H6 with 4 GiB chips and a 3 GiB window, that address lies
> outside the window and the access hangs the SPL. Such boards cannot be
> odd-sized anyway, since the usable size is capped to the window later,
> so only run the check when the probed address is addressable.

Many thanks for the heads up, and the fix!
I can confirm that it's indeed a problem, and that the change fixes it:
tested on a 3GB Eachlink H6 Mini box.
I added one line to the comment above, to give some clue about the
reason for that added line (beyond just the commit message).

> Fixes: c47b63673736 ("sunxi: dram: detect non-power-of-2 sized DRAM chips")

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Queued for 2027.01.

Cheers,
Andre

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  arch/arm/mach-sunxi/dram_dw_helpers.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sunxi/dram_dw_helpers.c b/arch/arm/mach-sunxi/dram_dw_helpers.c
> index d2af2d57fded..ae13dd154536 100644
> --- a/arch/arm/mach-sunxi/dram_dw_helpers.c
> +++ b/arch/arm/mach-sunxi/dram_dw_helpers.c
> @@ -155,7 +155,8 @@ unsigned long mctl_calc_size(const struct dram_config *config)
>  	 * or 3GB. They are detected as the larger power-of-2 (2GB and 4GB),
>  	 * so test the last quarter for being able to store values.
>  	 */
> -	if (!mctl_check_memory(CFG_SYS_SDRAM_BASE + size / 4 * 3)) {
> +	if (size / 4 * 3 < CONFIG_SUNXI_DRAM_MAX_SIZE &&
> +	    !mctl_check_memory(CFG_SYS_SDRAM_BASE + size / 4 * 3)) {
>  		if (mctl_check_memory(CFG_SYS_SDRAM_BASE + size / 4 * 3 - 64)) {
>  			size = (size / 4) * 3;
>  			debug("capping memory at %ld MB\n", size >> 20);

