Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFBDCCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 14:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10FCB83B85;
	Thu,  6 Nov 2025 15:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nathaniel.land header.i=@nathaniel.land header.b="UjNWdhw7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2460883B8C; Thu,  6 Nov 2025 15:39:16 +0100 (CET)
Received: from goldencat.email (goldencat.email [45.45.221.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD1E6839A1
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 15:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=i@nathaniel.land
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nathaniel.land;
 s=dkim; t=1762439951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=InofBFDGogAqA5na4XItyS7BIsz7PSLQfmAKdB6JvU0=;
 b=UjNWdhw7JEKNPRKQ7cuB4oLSFDvZRwYvON8k/VC5PnegJk4dKxWWTskb99GP2NzIIAIS5U
 qITBdhgiOABdF6kqGFrpHvh+qI/t1LyOTIDz5zkMgQUn9/9WyvQMTo8Ii3GM9ARCVCFAiz
 x2NLAk0aVa0T3b6i8GsaldjvvSlL44bMAYlYMmk4RC3AhOS0uTFm2ad1ayWQelv1XhW0nW
 qcecbMztNmz/SnPbHBfUTzeYZisKAN8g6wwiACbe5IWvRvrZQB0bzfojZcULcxtBUf7SjP
 Pk0wOHyamPlKmJOmZFBWo/1R9t5t7Ja7zfJCpRsGeMxH2BU8RJ4bUdJau+GyFQ==
Authentication-Results: goldencat.email;
 auth=pass smtp.mailfrom=i@nathaniel.land
Date: Thu, 06 Nov 2025 08:39:10 -0600
From: Nathaniel Hourt <i@nathaniel.land>
To: Yao Zi <ziyao@disroot.org>
Cc: UBML <u-boot@lists.denx.de>
Subject: Re: Build for RISC-V with LLVM
In-Reply-To: <aQx4Xk-qsaHXOQ1p@pie>
References: <aAx9bjXivAAuth-y@pie>
 <EF1C62F4-2780-4DD4-B0FE-355AA66A10C4@getmailspring.com>
 <aA2z6ImdniJZm7fq@pie.lan> <cd30d0ef07796710523ac5d55bb67d0e@nathaniel.land>
 <aBQkbNrT-u6FPm_D@pie.lan> <534beda9eb77a786945ce647aebf7fa7@nathaniel.land>
 <9c0038ed1494e9f293bf4faaf5e66ed8@nathaniel.land> <aQx4Xk-qsaHXOQ1p@pie>
Message-ID: <6b200492ccfce92137b43b7d790d42d4@nathaniel.land>
X-Sender: i@nathaniel.land
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
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

On 2025-11-06 04:29, Yao Zi wrote:
> [...]
> But for other ports, it's necessary to correctly pad the binary
> to the alignment enforced for __image_binary_end/__bss_end. What ports
> did you observe issues on without padding?
> [...]

Only on a Milk-V Megrez board, which is an ESWIN EIC7700X SoC and as 
such, I believe it is not actually supported by upstream u-boot. The 
downstream repo [1] that supports it forked off quite some time ago, and 
thus may not be relevant here... Nevertheless, it also breaks when using 
LLD, because the u-boot-nodtb.bin is not 8-byte-aligned. If I pad it 
with null bytes to the 8-byte position that _end points to and then 
manually concatenate the DTB, it boots up and runs great.

I note that on that board, U-Boot does not have an SPL and is instead 
deployed as a payload of OpenSBI.

[1] https://github.com/milkv-megrez/rockos-u-boot

I suppose I also should've mentioned in my earlier email, I am now 
successfully building and running U-Boot built with Clang and LLD using 
Clang's integrated assembler instead of GNU as and using LLVM's binutils 
for, i.e., objcopy:

> Hit any key to stop autoboot: 0
> StarFive # version
> U-Boot 2025.10-pylon-00761-gc2104da88367-dirty (Nov 06 2025 - 02:03:37 
> +0000)
> 
> clang version 20.1.7+libcxx
> LLD 20.1.7 (compatible with GNU linkers)
> StarFive #

This is what I set out to do, so I am quite excited. =)

Is there anything else I can do to help get this issue properly resolved 
in the code so builds Just Work?

—
Nathaniel
