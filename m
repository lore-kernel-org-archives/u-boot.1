Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D12EFF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 08:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A93803C6;
	Fri,  1 May 2026 10:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="A0GUfwBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4916180F0E; Fri,  1 May 2026 10:55:16 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A39BA80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 10:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1777625709; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kZJBoGTuqowq7106HuuMDCRdBynspEZSaOZYl2KlXsrsp05P/XA7U/tpvmhiecIzIgr2QNJJEaFeaPzS41/FETy+woeglxV2GvbkUVCJTfGnga5uOdgTIpEXKXor1b0ksKacKVOVn72UcBGRzWvS3AQ1Fj2moxIEm0UA5z4lMjY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777625709;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=C7YryMeVOBl8rhadukVb1UfDIBYkLpVZHDabG6wCgJ0=; 
 b=Kq1VjHy7IP1u3JFuGkb4MD1MBtpY7tG49YfzzNui8IOibhYO0jFly125mh3IfnCK9IgzUyrSejroAKI41a/c08aiB4NHjV53GdHb5XoQc7wbzYw8z67hJohEt043czCnOenZuquBVKqoW7FF8WefYu6zPjsYN0Uw7k4WSCx1Vmg=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777625709; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=C7YryMeVOBl8rhadukVb1UfDIBYkLpVZHDabG6wCgJ0=;
 b=A0GUfwBzjooYLV+G++OL01xXXU7LuckS525bc5J5FazMFSOS+lm0jwatF0nh+HGl
 EvzyCcXbJ0QKPa9PjJcC+JSFCZtTfOhTM85l0Cse1C41pauxbJXVxT1bXjpZGPgz3mw
 kV+umwF0CZmFZrMAsCmrz5VyFhgJV0pohGH6v4Y4=
Received: by mx.zohomail.com with SMTPS id 1777625707408602.2850318701126;
 Fri, 1 May 2026 01:55:07 -0700 (PDT)
Date: Fri, 1 May 2026 08:54:40 +0000
From: Yao Zi <me@ziyao.cc>
To: Michal Simek <michal.simek@amd.com>, <u-boot@lists.denx.de>, <git@amd.com>
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] riscv: Skip riscv_cpu_setup() when CPU driver is disabled
Message-ID: <afRqUJZF81_y5K_O@pie>
References: <0d875f98e9d81b68265ea26c379dae8ce5b1f5a9.1777550269.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d875f98e9d81b68265ea26c379dae8ce5b1f5a9.1777550269.git.michal.simek@amd.com>
X-ZohoMailClient: External
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

On Thu, Apr 30, 2026 at 01:57:51PM +0200, Michal Simek wrote:
> Building on commit c64fc632a86a ("riscv: cpu: Use CONFIG_IS_ENABLED(CPU)
> instead of plain ifdef"), add an early return in riscv_cpu_setup() when
> CONFIG_CPU is not enabled. This allows platforms to save code space in
> SPL by disabling CONFIG_SPL_CPU.
> 
> The compiler's dead-code elimination combined with --gc-sections
> removes the unreachable code and all associated static data,
> achieving significant size reduction without preprocessor guards:
> 
>   spl/u-boot-spl:all -4332 spl/u-boot-spl:rodata -2872
>   spl/u-boot-spl:text -1460
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/riscv/cpu/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index bbadd0c9a469..3bec7c7cb6d0 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -638,6 +638,9 @@ int riscv_cpu_setup(void)
>  	const char *isa, **exts;
>  	struct udevice *dev;
>  
> +	if (!CONFIG_IS_ENABLED(CPU))
> +		return 0;

Should we return zero here, or -ENOENT like the original behavior when
no UCLASS_CPU device is found?

Otherwise the patch looks good to me.

Reviewed-by: Yao Zi <me@ziyao.cc>

> +
>  	uclass_find_first_device(UCLASS_CPU, &dev);
>  	if (!dev) {
>  		debug("unable to find the RISC-V cpu device\n");
> -- 
> 2.43.0
> 
> base-commit: ab9f3cb4de54c65bde394e31469c75ec89b18d5b
