Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70DF60B506B
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mjcsu7kj;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=CbvPQRHN;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=MXrZ3uIg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 732AA80D9E;
	Mon, 19 Oct 2026 15:27:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3NDgk-gcZKcL; Mon, 19 Oct 2026 15:27:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B130380DA9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792423661;
	b=QLyxjPBuWhMcpjK6bpwjnlC1IOma+AlwKU/EmpR/QbVQVKKO6wLuZlDeWC/FPid654YW
	 lxEYnmDrTk7aFmosUBP6OeemuvHCrCXybIwOXhDxVGtMRb8CHbNw4dq+lscHRLmpJSs0F
	 epnLKr8O+pe2hozWDv+lsfOhNRS0TUr/29Sus4JG2xlT2oJbo6ClIrTzyAQ14URcwpz8Q
	 YilxLHMZR4bfpvVrDt4lMQUu7xWqJV3FXJQdLv4BLaieIvyqraw1/4Jd/T81dYl3igMQS
	 Zq0Jv5YcwltguEcJIvYzto5IHf03Quk1Vt3H0xZv6yVhhGRFFK+sV8D4jl956UwwfXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792423661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rApx12qkj4ujmEOu2KRrPkK4ouveVO+cA7iHtD9pprA=;
	b=jaahKVDUno0/bGBxm7xrwsK/UZRo2P1WYtUuW9FmfUYg18nsKJMzZGv8oZvR7IyjZOnt
	 vYvOMbHZsmQZQquKI9CRkk8J7I7JdFIm1RMIaJHZMR+Yj6mVQcaaLKSq0+ZVm1kCEjv1V
	 1hK5C0t3GTOwqz894WdRGAvqYp0VA82R8xOSpdDWO/4dLTOMO3t6nMy8vx0/UyfOy7TT4
	 a19HMAxZ9fryN4YWx0QUsv80LgCK2BHzNMDpFSEXHdAxqQmxAdCzkM8oruN2efSmnxcPF
	 VunWOWluU67w9H8C6hnW6PSF+lTtRQtVJVIfRDxV46M1L3WbJ4ySM9sZnL5qcQTZMPw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792423661;
	bh=rApx12qkj4ujmEOu2KRrPkK4ouveVO+cA7iHtD9pprA=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=mjcsu7kjLczySINYCPgLKEr2Idt40Oj4IH1tP63EGRTvY5Ejboxga7bE4ZkdFT3FT
	 PFTnpbJuRVdBqR22qBJFhocSzqakGenYMrTmtZWFWWxyu/NEer7chnOSyWLeqnwIPy
	 5pGnXbUk9M2sMfL6+8O0FaQU2WmHFk6U/rw8d+3erhPcCj06VJHI8Ls+PrnaJUYEM0
	 BGhVUway+SRzd8Bgbgzt8JYkm35OsZ5/Rvh+s5RFqXzPs7Shopnj+kgz0glhX2kJzF
	 s89Ujf9rKcezeShK8O3mnJw5Mw0k6v5vaUKrsu+RWZV8HBZqtAAtCLBsF/56mUGEh7
	 wWmweTbLg7lJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B130380DA9;
	Mon, 19 Oct 2026 15:27:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 53C7523F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80D7B4010C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SjAZZ-p0zBQm for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 15:19:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 69083400B4
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792423140;
 b=H0QieitACxToyAS4M5vrcPHfBe7Ta704FTjJdHLWGWt7IXF9PL67rzI9nfLpozgJ9cfe
 aPAxbgG42RpxEzU/k7XSnyxe4ZKwMD52iKutHBZDADPDASpey22UN4DZDtcJtPPLlKW1z
 L3smE1eLi4zeou1VfCNmIem39FaclywTEzyiDua4ePjHD5ursp115OiSJzlk1X7DkLqtC
 a5yoE4HvqRsREsMSAC6vVrYiZINcDGVMEZqkL0fmEm6BggpDPdLhpV2gyS3Lh2VYjknab
 7kdCPP0MHPQgYFh/bqZ4P69xGT5QIvwygsSJeRWlofC547IHP6U4VhknG50WNDyQDdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792423140;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=rApx12qkj4ujmEOu2KRrPkK4ouveVO+cA7iHtD9pprA=;
 b=lPcvtA95otcA67jqZXs9xZLMyDcksiSrsvEdkL32+jjpdNSN61E8h/b19tYG02nheWiR
 DVldlTh0LBKCPxB3bNHy0QLMn/+CO/4NApN+LiOZL7IEYCbRp8jef9xA7/pbCE3pjw+WE
 KegHroHhelcmXBiD1D2XfoNtn/0M4nL6rwQglzUpt/TIpg1jLMWPQ80IlPjJmv5XVOFiu
 Oj0+/iBCC5OYcA1tBMUcDpOKexgCBFCGDVjIh2ABp/HbPOyqQ01ZWLivPEJ3hNkDFE15x
 XoUoQl1vw4NbG58GTXtBIbFIm/LJcYhBhdHoSSBMXPh3JgJdmqcxs4z1T9Kw0GI43hw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=CbvPQRHN; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=MXrZ3uIg; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=CbvPQRHN; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=MXrZ3uIg
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69083400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423124; bh=rApx12qkj4ujmEOu2KRrPkK
 4ouveVO+cA7iHtD9pprA=; b=CbvPQRHN4WZxuqX83ETnKBgeKRYhP9dx10+ikOE9gqHhwfI5UX
 6p7dy8krGXN20iDEUQdqtSupGaQvz3e7eDoQGNX6PcmmHf2FZBGgEaeDjvQKflOozGC8pH/2Scr
 cHGs+wmIZwnhVGQN36divt8ciy52if4NgpqTEQv2nwG36sg+vHzAMRXimJHH2gW5lcLUcgXrXLK
 zDNr7NyEpngN0zjFW2NZq/bgUDwuMHB2u/aEdwKXmMKOY3xG3J/NWB/+2WUYa8AKFQl4VvqcpCI
 9L8tjoHvWjhxmsZ5DgB+i9kCU2k/a1azOMmcO0V4FjfSVMxH8LcxRygTCr4LUXL4g2g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423124; bh=rApx12qkj4ujmEOu2KRrPkK
 4ouveVO+cA7iHtD9pprA=; b=MXrZ3uIgbu0heeS/4mgw6OajwBshHYZLRMuTFsEThQGqvc83f/
 Np1DY6rwfq3LPtJu5mueRTlPjqusxmjroHAQ==;
Date: Mon, 19 Oct 2026 16:18:44 +0100
From: Bradley Morgan <brads@mainlining.org>
To: pepe.schlehofer@gmail.com
CC: Shengzhou.Liu@nxp.com, chleroy@kernel.org, christophe.leroy@csgroup.eu,
 dario.binacchi@amarulasolutions.com, holger.brunck@hitachienergy.com,
 hs@nabladev.com, kabel@kernel.org, marek.mojik@nic.cz, mario.six@gdsys.cc,
 michael@amarulasolutions.com, peng.fan@nxp.com, priyanka.jain@nxp.com,
 qiang.zhao@nxp.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 06/14] powerpc: mpc85xx: Discard LTO keep-syms sections
In-Reply-To: <20261018083516.49229-7-pepe.schlehofer@gmail.com>
Message-ID: <F9593886-023E-4FFB-8D63-5E31813706CE@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 15:27:37 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18 October 2026 09:35:08 BST, Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>With LTO, keep-syms-lto.o puts pointers to linker list entries in
>.discard.addressable to prevent the entries from being removed. On
>mpc85xx, -mrelocatable creates .fixup entries for these pointers, and
>the linker scripts keep all .fixup input sections, leaving
>.discard.addressable in the image.
>
>Discard .discard* sections and the .fixup entries of keep-syms-lto.o,
>which point into them. Otherwise, ld leaves zero words in the fixup
>table, which start.S treats as addresses to relocate. With them, the
>Turris NOR build with LTO hung after the DRAM message.
>

I don't see any wrong with this ;)

Reviewed-by: Bradley Morgan <brads@mainlining.org>

>Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>Cc: Marek Behún <kabel@kernel.org>
>---
>Changes in v2:
>- shorter commit message
>---
> arch/powerpc/cpu/mpc85xx/u-boot-spl.lds | 11 ++++++++++-
> arch/powerpc/cpu/mpc85xx/u-boot.lds     | 11 ++++++++++-
> 2 files changed, 20 insertions(+), 2 deletions(-)
>
>diff --git a/arch/powerpc/cpu/mpc85xx/u-boot-spl.lds b/arch/powerpc/cpu/mpc85xx/u-boot-spl.lds
>index d918b4395bf..dd4d18bc24b 100644
>--- a/arch/powerpc/cpu/mpc85xx/u-boot-spl.lds
>+++ b/arch/powerpc/cpu/mpc85xx/u-boot-spl.lds
>@@ -35,7 +35,7 @@ SECTIONS
> 		KEEP(*(.got2))
> 		KEEP(*(.got))
> 		_FIXUP_TABLE_ = .;
>-		KEEP(*(.fixup))
>+		KEEP(*(EXCLUDE_FILE(*keep-syms-lto.o) .fixup))
> 	}
> 	__got2_entries = ((_GLOBAL_OFFSET_TABLE_ - _GOT2_TABLE_) >> 2) - 1;
> 	__fixup_entries = (. - _FIXUP_TABLE_) >> 2;
>@@ -63,6 +63,15 @@ SECTIONS
> 	__init_end = .;
> 	_end = .;
> 
>+	/*
>+	 * .discard.addressable of keep-syms-lto.o only keeps the linker lists
>+	 * alive during an LTO link. Drop it, and its fixups with it.
>+	 */
>+	/DISCARD/ : {
>+		*(.discard*)
>+		*keep-syms-lto.o(.fixup)
>+	}
>+
> #if CONFIG_IS_ENABLED(SYS_MPC85XX_NO_RESETVEC)
> #if defined(CONFIG_SDCARD) && !defined(CFG_SYS_MMC_U_BOOT_OFFS)
> 	mmc_u_boot_offs = .;
>diff --git a/arch/powerpc/cpu/mpc85xx/u-boot.lds b/arch/powerpc/cpu/mpc85xx/u-boot.lds
>index bedd2d47472..4bb9b4ecfb2 100644
>--- a/arch/powerpc/cpu/mpc85xx/u-boot.lds
>+++ b/arch/powerpc/cpu/mpc85xx/u-boot.lds
>@@ -49,7 +49,7 @@ SECTIONS
>     KEEP(*(.got2))
>     KEEP(*(.got))
>     _FIXUP_TABLE_ = .;
>-    KEEP(*(.fixup))
>+    KEEP(*(EXCLUDE_FILE(*keep-syms-lto.o) .fixup))
>   }
>   __got2_entries = ((_GLOBAL_OFFSET_TABLE_ - _GOT2_TABLE_) >> 2) - 1;
>   __fixup_entries = (. - _FIXUP_TABLE_) >> 2;
>@@ -107,6 +107,15 @@ SECTIONS
> #endif
> #endif
> 
>+  /*
>+   * .discard.addressable of keep-syms-lto.o only keeps the linker lists
>+   * alive during an LTO link. Drop it, and its fixups with it.
>+   */
>+  /DISCARD/ : {
>+    *(.discard*)
>+    *keep-syms-lto.o(.fixup)
>+  }
>+
>   __bss_start = .;
>   .bss (NOLOAD)       :
>   {
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
