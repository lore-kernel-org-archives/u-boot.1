Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1F7CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 11:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C18B841A2;
	Thu,  9 Oct 2025 13:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="GpPtkbSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17408841A5; Thu,  9 Oct 2025 13:44:10 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E958419D
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 13:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 3ACF425D78;
 Thu,  9 Oct 2025 13:44:07 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2VSjElX_Fp74; Thu,  9 Oct 2025 13:44:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760010246; bh=IFUjfZFwIujnAUYC5qLfC7geKrgI990Dw5EpJdw4DJU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GpPtkbSGG42Ss5GVaQ8Fu+g2Awgg9dX5kt4A0/QxH7ofwx97t3y647j8yuyyoLgxz
 nuVcy5JhXkDn6Ayyt1q6+VIB6+Br4vNWM99pQF3zyrfzYA5AmLVIvCMlRZyllZRIrO
 /i3Zdb3nNMuqAcfJ5NmHNMrStOIXZxVtoge95Y/NqnyJxoQWl+864TH5ZiASlnfIea
 uLTLLhMVUfJ1f142UZCRBr+CkRb5k3EXbO4oS0/sR69qpR8SF47DZ9BKQfT/Bz+Lbu
 R+4x01srE1n7V8FU7N4CJSmd/op+HLJ2LdX9/vHLzg1QZF1lfLpDiMqu2jUVFCY+h6
 l4beOb4QJogiQ==
Date: Thu, 9 Oct 2025 11:43:55 +0000
From: Yao Zi <ziyao@disroot.org>
To: Uros Stajic <uros.stajic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v4 10/10] cmd: riscv: Add 'startharts' command to start
 multiple harts
Message-ID: <aOef-6YZKbyk9RsD@pie>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
 <20250819103021.1518687-11-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819103021.1518687-11-uros.stajic@htecgroup.com>
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

On Tue, Aug 19, 2025 at 10:34:39AM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Introduce the 'startharts' command for RISC-V targets, which prints
> or executes commands to power up and reset all harts and jump to
> 0x80000000. The command supports optional cluster/core count and
> immediate execution via the 'g' argument.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>

I noticed in OpenSBI, P8700 already implements HSM extension[1], which
means it's usually unnecessary to take care of SMP stuff in U-Boot. Do
you still want the new startharts command?

In summary, there are two possible solutions to support SMP for RISC-V
systems with U-Boot and OpenSBI with minimal effort, where SPL runs in M
mode and proper U-Boot runs in S mode,

1. Release all the HARTs in SPL stage. With SMP enabled in U-Boot SPL, a
   core is randomly picked to run the main part of U-Boot SPL, and the
   others simply spin and wait.

   When all the initialization and load are finished, an IPI message is
   sent to each spinning HART, releasing them to the next-level
   firmware's entry (OpenSBI here), see smp_call_function called in
   spl_opensbi.c.

   This is usually more appropriate when your platform releases all
   HARTs when powered up, in which case you could omit the code of
   releasing all HARTs to U-Boot SPL. This requires a proper
   implementation of IPI, and proper description of all HARTs in
   devicetree.

2. Implement SMP bring-up code totally in OpenSBI. U-Boot itself is
   expected to run in single thread, so it's unnecessary to bring up any
   cores in U-Boot.

   RISC-V SBI defines a HART-State-Management extension (HSM). You could
   implement HART bring-up code in OpenSBI, and expecting kernel (maybe
   Linux) brings up the rest HARTs through the extension.

Looking through the startharts command, P8700 does require manual steps
to release non-boot cores, which makes option 1 less appropriate since
it introduces more platform-specific code to U-Boot, while it has been
already implemented in OpenSBI, becoming some duplicated code.

I suggest moving to HSM extension entirely and avoiding introducing any
SMP code in U-Boot for your port. Or, if you still prefer to implement
it in U-Boot, please re-use the existing framework of bring up HARTs
(smp_call_function, proper IPI, etc.). This could definitely helps
code review and future maintenance.

Best regards,
Yao Zi

[1]: https://github.com/riscv-software-src/opensbi/commit/66ab965e54017292d530033ffaae127389c45458
