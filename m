Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AC5C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 17:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A2082977;
	Fri, 25 Apr 2025 19:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nathaniel.land header.i=@nathaniel.land header.b="YfQhQr23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DAC6829D4; Fri, 25 Apr 2025 19:43:16 +0200 (CEST)
Received: from goldencat.email (host212.sub-63-47-114.myvzw.com
 [63.47.114.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49EE382958
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 19:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=i@nathaniel.land
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nathaniel.land;
 s=dkim; t=1745602989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+44g1DlLbmqMqzYgP1BEGj1ndUkdUe7WFI4L0K6T9fw=;
 b=YfQhQr23U2A+8iQhNI3TtIM2VFhAqmPGTSHj/LCUFSxF+B7Hg7IalXrsAfECT3NVjpe3wQ
 pV3vXg/pZ4N+9g4SCoxFUHyR81XREE4r1MiNsXwQmSw1YIpm38xffPV4c2lOinbaaRV5ZD
 mk2GF8Nzk+XVV6acPWJITdNXSxZOUNG1Vg/tOukWVN1JxNNWj+8NGhg6Lg7ERFGKxWbWuH
 C7KZ+Ar+G+1dnpvQsHHAG1pPZ6p8A1HbztvHgATOiC9HmTEvHcu2syugwju0CvByze+7dL
 5kjJ227t5OPwH/NW05cb7kYF60/yGvVmtgTItfwhzMkG90jXiQD/k5S+lgabbw==
Authentication-Results: goldencat.email;
 auth=pass smtp.mailfrom=i@nathaniel.land
Date: Fri, 25 Apr 2025 12:43:08 -0500
From: Nathaniel Hourt <i@nathaniel.land>
To: UBML <u-boot@lists.denx.de>
Subject: Build for RISC-V with LLVM
Message-ID: <932979cb47c4fded7ac19216ca172504@nathaniel.land>
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

Hi, all

I am trying to build u-boot and SPL for my Mars board (riscv, variant of 
the starfive visionfive2) following the board-specific docs [1], using 
LLVM/clang as my toolchain with the HOSTCC and CC make options mentioned 
in [2]. I'm building from a RISC-V native chroot using qemu-binfmt so I 
am not using the cross-compile options; thus my make invocation looks 
like `make HOSTCC=clang CC=clang` (for OpenSBI, I just pass 'LLVM=1'). 
Note that the chroot I'm building from does not contain gcc/binutils at 
all; LLVM is the only toolchain present.

The build usually succeeds, so I try to pass the SPL to the MaskROM over 
UART (using the u-boot-spl.bin.normal.out image) and it just hangs. No 
output, no response, and I have to reset the board. If I pass a working 
SPL I downloaded, it logs some output then accepts a main u-boot payload 
over UART, so if I send the main u-boot payload I built (u-boot.itb), I 
get a "Load address misaligned" error as in [3].

I attempted to configure my SPL to log to UART by turning on various 
logging options in `menuconfig`, including the options recently 
mentioned by Heinrich Schuchardt in [4], but I have been unsuccessful in 
getting any output from the SPL I built.

So I am looking for guidance. Is building with LLVM/clang (for riscv) 
supported? I don't know what to try next.

Thanks
—
Nathaniel


[1] 
https://docs.u-boot.org/en/latest/board/starfive/milk-v_mars.html#milk-v-mars
[2] https://docs.u-boot.org/en/latest/build/clang.html
[3] https://pastebin.com/xwEcqEpz
[4] https://lists.denx.de/pipermail/u-boot/2025-April/586264.html
