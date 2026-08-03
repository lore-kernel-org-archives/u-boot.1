Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5613C55179
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 12:27:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BAB640652;
	Mon,  3 Aug 2026 12:27:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qeZySqdR3l7F; Mon,  3 Aug 2026 12:27:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B312140645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785760035;
	bh=4xXGvFTBlD4z+LJdOYJpsoZCQxassUjvm5xch9Kg9xM=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qprlBv6shEgGHi+jkwExf8efr9QHprkulHFfFYVyYDId0Fs0EA9C6q3KVmYHA7UeA
	 NtH1s3AYJCNWN9X1SiPPXgI9bLsBl+Y30cvexnmW0KOhMYPxj/D23c2SFdX50MkVAL
	 /yV6kNR7mf6KG/LDQkNUUGPt0fyimajlcexWigf7x2CAWTh7yRfo9z2PKpQowQEeJT
	 mN2eGYWjyegGsmP3o/z+3ToOywGte6qeba+7i/xng3isddye6GTKaIIPU1abwx1BxN
	 bFcHYcog24RDnn6xGF0mvgewwWCjtNoKIgx9vTLcacqqModxlnCgGwxUrWkyvkgMZ4
	 8z63Mv26e7RkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B312140645;
	Mon,  3 Aug 2026 12:27:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E2CF4218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C8FD540645
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:27:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MPIMM-AdMTyg for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 12:27:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A7D8D4063A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7D8D4063A
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7D8D4063A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:27:13 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hDGC32mfczMlBD;
 Mon, 03 Aug 2026 14:27:11 +0200 (CEST)
Message-ID: <e1827120-2b25-47f1-bd33-603b9fd3a92d@mailbox.org>
Date: Mon, 3 Aug 2026 14:27:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: imx: initialize the system counter earlier on i.MX7
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 u-boot@lists.u-boot-project.org, Rasmus Villemoes <rv@rasmusvillemoes.dk>
References: <20260730093546.2432933-1-ghidoliemanuele@gmail.com>
Content-Language: en-US
In-Reply-To: <20260730093546.2432933-1-ghidoliemanuele@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8r351y9jytdibtkc7aj9ziby8pfg8t8h
X-MBO-RS-ID: f2a5dde55cd6b063262
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785760031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xXGvFTBlD4z+LJdOYJpsoZCQxassUjvm5xch9Kg9xM=;
 b=nQ0+XuQ+i371IeODNx23pjtUVY19AIdB5s0sTVmtmCRVW0JyFzwGXdTctxwy66xwIqRrjS
 jBphDt7BVMMSRNFlvIC1MdxmI3nt7zEoFQGc8vxvw9dt1j3Xpi+L+4VJuISS2Az9XbUUwm
 UFXJrXgjJasyHJaPvZvSHowMnQGoRDKZbG6QjiTy4d/4ky9KUcrxxua7sByN/NUxucOCnB
 HDmCp0CjF2VdNP02lgcnEvkHW57LGE5R/vf4Oy0u+nAVt64iLyPU5F29rzzkVNw6+aGnK8
 S5qwFXyG/9yuWzgHOeqqhbdqALU9sjEKejZA/4USnIXOztbfZiYN+8PxtiedDg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785760029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xXGvFTBlD4z+LJdOYJpsoZCQxassUjvm5xch9Kg9xM=;
 b=ODVIvbB773owGaxyaOyr/0RS7GQQffWw3SeIO00FZz82jKfqPxQUHmF6lVXZHivzO4hBF4
 2QJoSSa0cs/GjPENDc5PcuXQDXHFmfP89peETlq3NyxK7q2JwXdZKXi/lXeb154ODHwMTc
 w89DD0euJ0yCBysUytfuoqNqNebzgdp0/tIvoyZpqK8DopffT1Bmbt2wJhdsa1rSd2VtOl
 paNDkuCoZ5izOYLwz2qpTyvpDaqQ2HQYQA7tVnuhE0ngDk3L9RmwOYoRQ9LxYu4VzHEycq
 mKm8FKgrsqvTzBQDmYF6pv/XKzwALIBKr7jsWpJZ12JceKHO6kPbE7K3QIio4A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=nQ0+XuQ+; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=ODVIvbB7
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Stefan Roese via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Stefan Roese <stefan.roese@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/30/26 11:35, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> imx_gpcv2_init() calls udelay(), which through schedule() reaches
> cyclic_run(). Since commit 9c1b13b3fd27 ("cyclic: reduce get_timer_us()
> calls inside hlist_for_each_entry_safe()") get_timer_us() is called even
> when no cyclic function is registered, so tick_to_time_us() divides by a
> still zero CNTFRQ and __div0() hangs the board before the console is up.
> The requested delay was a no-op as well, since us_to_tick() reads a CNTFRQ
> of zero.
> 
> Initialize the system counter before imx_gpcv2_init(), and move the
> "already initialized" guard from timer_get_boot_us() into timer_init() so
> that the later timer_init() from the generic init sequence is a no-op.
> Where the system counter timer_init() is not compiled in, the weak
> definition is empty and the calling it is harmless.
> 
> Fixes: b059837850e4 ("imx: mx7: add gpc initialization for low power mode")
> Fixes: 9c1b13b3fd27 ("cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   arch/arm/mach-imx/mx7/soc.c    | 6 ++++++
>   arch/arm/mach-imx/syscounter.c | 6 ++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mx7/soc.c b/arch/arm/mach-imx/mx7/soc.c
> index e504c1fd52a0..8a858dea5187 100644
> --- a/arch/arm/mach-imx/mx7/soc.c
> +++ b/arch/arm/mach-imx/mx7/soc.c
> @@ -331,6 +331,12 @@ int arch_cpu_init(void)
>   
>   	init_snvs();
>   
> +	/*
> +	 * imx_gpcv2_init() needs to do a delay.
> +	 * Timer must be initialized before calling a delay function.
> +	 */
> +	timer_init();
> +
>   	imx_gpcv2_init();
>   
>   	enable_ca7_smp();
> diff --git a/arch/arm/mach-imx/syscounter.c b/arch/arm/mach-imx/syscounter.c
> index 96fe2c7c17bb..86311d0cc07d 100644
> --- a/arch/arm/mach-imx/syscounter.c
> +++ b/arch/arm/mach-imx/syscounter.c
> @@ -65,6 +65,9 @@ int timer_init(void)
>   	struct sctr_regs *sctr = (struct sctr_regs *)SCTR_BASE_ADDR;
>   	unsigned long val, freq;
>   
> +	if (gd->arch.timer_rate_hz)
> +		return 0;
> +
>   	freq = CFG_SC_TIMER_CLK;
>   	asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (freq));
>   
> @@ -103,8 +106,7 @@ ulong get_timer(ulong base)
>   
>   ulong timer_get_boot_us(void)
>   {
> -	if (!gd->arch.timer_rate_hz)
> -		timer_init();
> +	timer_init();
>   
>   	return tick_to_time(get_ticks());
>   }

