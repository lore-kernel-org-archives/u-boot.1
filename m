Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED922C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 09:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3311683DC9;
	Mon,  4 Aug 2025 11:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="VvFS3/5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 476B583EB9; Mon,  4 Aug 2025 11:11:57 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11EC983DBF
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 11:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AE2521482EE2; Mon,  4 Aug 2025 11:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1754298714; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=d3UDG9yUuS8JOI5hO1XUFBGpSiPAvwdBQND4QeFOuLU=;
 b=VvFS3/5A5AY6VTGQX+kVnaEBC9LUY68rPgl6y91IaCl50x5HJJBogjPlmpRr4GrAQisox8
 jaD1sqiXpDFHiuBn1PpgN8dgsUjkiZYPhypPgpGxbBtcQ2ZKN5V1B3HF5ceDLUkBfyZwoF
 aSYifbMx97EA4b3T6JGiail/VFar3AcSrU174XqyaDFB1DYoqVTOz8+/9e+sX0bFF4mYR/
 rJrNK5fErrlohCNAlPyPEJ8IUvmXZ3KBDRvGYlTT/k6IBRRIQJYW76iJCaHm1CWFqKI5yw
 GnDdflGoq1ZUx3+dukwnX/sLIZbWJqAyfGocXBP6Y2YjC7+CH91TCrQAfRDzkQ==
Date: Mon, 4 Aug 2025 11:11:48 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250804-thus-attitude-eeee187e9cab@thorsis.com>
Mail-Followup-To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>
References: <20250725132645.GA1807455@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725132645.GA1807455@bill-the-cat>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello,

Am Fri, Jul 25, 2025 at 07:26:45AM -0600 schrieb Tom Rini:
> Here's the latest report. These aren't new issues as much as they are
> Coverity now looking at FPGA code issues.
> 
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Thu, Jul 24, 2025 at 8:03 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
> 
> 
> Hi,
> 
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
> 
>    - *New Defects Found:* 8
>    - 3 defect(s), reported by Coverity Scan earlier, were marked fixed in
>    the recent build analyzed by Coverity Scan.
>    - *Defects Shown:* Showing 8 of 8 defect(s)
> 
> Defect Details
> 

[…]

> ** CID 583148:       Control flow issues  (DEADCODE)
> /drivers/fpga/cyclon2.c: 180           in CYC2_ps_load()
> 
> 
> _____________________________________________________________________________________________
> *** CID 583148:         Control flow issues  (DEADCODE)
> /drivers/fpga/cyclon2.c: 180             in CYC2_ps_load()
> 174     		ret_val = FPGA_SUCCESS;
> 175
> 176     #ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
> 177     		if (ret_val == FPGA_SUCCESS)
> 178     			puts("Done.\n");
> 179     		else
> >>>     CID 583148:         Control flow issues  (DEADCODE)
> >>>     Execution cannot reach this statement: "puts("Fail.\n");".
> 180     			puts("Fail.\n");
> 181     #endif
> 182
> 183     		/*
> 184     		 * Run the post configuration function if there is one.
> 185     		 */

See
https://lore.kernel.org/u-boot/20250804090816.42603-1-ada@thorsis.com/T/#u
for a fix of the cyclon2 driver.

Greets
Alex

