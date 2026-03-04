Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49600EF9014
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 16:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73BEA838BB;
	Wed,  4 Mar 2026 17:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sX+2KR7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C7E839A8; Wed,  4 Mar 2026 17:58:24 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 821E883642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 17:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-798527f822cso71631327b3.3
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 08:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772643500; cv=none;
 d=google.com; s=arc-20240605;
 b=Om2E8vNJlL1J9ZtAJbJa7/wYekYjZWO/DfWjM/Dyga+QSxPs6TBWUOUE1HLcZGJIbj
 ZBxQAQqDEnqP8MIQCSMv9qB0HXLFGLeE5pqAVSnOR3X+66bvZKD01uV/0PD6JNf9lpA+
 rlfy2ZkTFposg2y/nGjAsVbBotEGPg1iysM85Xlr3L838LPahkqERvSy54448rcqUA2/
 Fk9SoFU33j3Wvzp+etvgH/9QRTQC2Zf08ELPWyqn0YXfUKCrvIMFPNpxPfuoCERtsvCh
 xlhYlEvphtQQONWBx8QQlJ6Ps3ZTptjrosgLI6mGlP3NV1I9Eqg9ta7+WWfzDFOc+8/4
 YvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xt18cPvoWKrLT01kwXx3ulDN5ehJI7qee/sQ0YZLSa4=;
 fh=XCHfK9cvwT5KXND9XJ6v0xpO/957vqY6/yM96lKMONA=;
 b=XfsKRpm1A9rHXcSpR0XsjPqtb8RZfiIyq39i5eXtUKaZ93kPtIrsgIvn1MBmpFNxwO
 nLMkPJ95kxs80THa2iqI8636bTsCKe90m6JupsA8+4CNUyLIU0SFhR8sWz0q16+pvEfD
 I20gwYRVP2Jbv2VNClxj1nEEYGvlZPHJLLUzavMHEtaOpO1KBfuM4V5mB4gJAMc+GEAO
 y4XQHyJs0HcDEXCpLItsr+Haahs8AXdcH7nfHPe+GE0JfUSjmvfgXj7wcoy+G4wiGi73
 F/U0QGjAnI1vk3HFLAUN1bk2Q2CWlkKnOYkI1DJXl1MY2sR11h+Y1Dbxe8ZFQgej4UYP
 rQlg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643500; x=1773248300; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xt18cPvoWKrLT01kwXx3ulDN5ehJI7qee/sQ0YZLSa4=;
 b=sX+2KR7hXzKeCKp7jMs1kL2wjGgUYjuakG+EgrvoxVBEZx/oDstfXbgKkVKZGjoCSv
 08lv7kmUsWamre71FPpmmixsHcpIIer8jMhaFER/x3LiDIyrSIv8Nf4MRHSQVFddVhjR
 xE6oC6krxuxgqB/Ulueev8d9WGs7u9Swiqsk8yzQlJO+JnH97lrRz/jPv7GNGJ2vSucX
 fT2vcKnzTYC7QDmzcaIGXfWAP74G7iFCF+l5kCVlEbqvT2GASmaFAx17JysUmqo5Mtcx
 BOhM0MBWNFbXrDw7ntLj5mD7VcU3stO297q64M7GLJafaCIYDqu4sQcgAqIId6VWAWgu
 DvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643500; x=1773248300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xt18cPvoWKrLT01kwXx3ulDN5ehJI7qee/sQ0YZLSa4=;
 b=vPTWJe2hXioqZfsqFz9nGS2XDNQsphkmEFYHpOMuynklC2ephMkHfzm8iX/fCTddv+
 sS9AfFRKkmzu97IZruqdFtFAz3XPGsrW8uCtmIMnoK9SlMrsPW5aZp1hgAme6pjH+X2t
 RvMsuEjBzLDCl38mUDPuhfHCLU1s6kBcEoj0RbdPTNq5h6uiCZFZPrvcIfTb1Q7pz5/s
 3NAUYwgM9E4x+XGJlJNR9B9BzuGFot80ooSls5NTGGM5Hy1HJ8xiwsGbdtbMou3rqZ3D
 nrKO/Pnv7wVXRh+te+R2xcZ+qanOCJg14iV0hopUXNwwJGHDHITeC+GzFL3QT3TeZoCB
 U7dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEeZjx2PubPONnc8/unybLWkUtTnu77Lmrz5t3xDtJ+IbwOfn9JwpTBENKmWgpOhzNXU3+ilM=@lists.denx.de
X-Gm-Message-State: AOJu0YwPds64BnvneE3g1Y7JPO4TqF9FnlOyXERgJNaufR6CVz8Y5zuc
 3MzhSPE1wU3Wf1WuQzktX/2QJ5UAd0LwKZdoBTaKzJQwe90eOU+1W2Q8xeb58htL8CAqWhTGx3j
 ue9nVMkNRwjA33D3s3rIwPGi88BWXzJKLWvxZvNMUhA==
X-Gm-Gg: ATEYQzxKCEr20X9r+bvPG7UYg63JxbF97U7Ia9fZkeyrxrS2Ab9AwUxkUAoiGrNebds
 Hjvrl7bmG1mhVAR1nTLbYeDH0SqFpOiwloavYDNwtuLe00ifRzE9k1VD6qlEE+r4DLCsBnrFRcv
 SxMcWbqsoJz2d13ZO36DZXSQcxZud0Vo1+sY5nJMtspiWILlq2vhdnrG4UX75lOALi2FqlVPqUv
 05Y4/qn8gR22IeDK+Yly392RGXaoWAVJkpGnDbEk/rnk3F0OOjk1934e1vXnxKxr6ahl4LJ8dJa
 t0YbNnmYaaSpVZDa5bYPUmv5cfMxkWdjzosdgyOT1qScHEN7C3RNXyZ2r6SaCYdnNjQX+RH17Y2
 P9Vkkni1rLJQXN7XEYMm6L1r1PEu2EqLdomBUlGEyD50+YA5V+RogYEXw+zAyKHNAACUpnrAHVc
 LNJvf3IXnLy+ALCVs7bxljosRyIP+2Pf/BLVXCjYPZfPXca96Yz63p/Ck+s8wrB6KmRbmq3tPw2
 a2I9b6n6r2U9J5ERlvY3Cj/+/jcWVMCzIXI/RiYhv2M81J66iZhuR3XBym5L2HBUGjgLxTqreky
 /zNqEdqNKOogSdx1P6NJAZ5praRh91s9tGUfCjsbf1DZ
X-Received: by 2002:a05:690e:d5b:b0:649:d33f:2273 with SMTP id
 956f58d0204a3-64cf9b5aeddmr2139775d50.28.1772643500189; Wed, 04 Mar 2026
 08:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20260214024736.3726811-1-simon.glass@canonical.com>
 <177256385549.3975993.592734328770415000.b4-ty@konsulko.com>
 <20260304-robe-praising-5509e3a984cd@spud>
 <20260304150145.GX1388590@bill-the-cat>
 <20260304-acquaint-wager-688fd7fbae6a@spud>
 <20260304151154.GY1388590@bill-the-cat>
 <20260304-germproof-gawk-d26040529131@spud>
 <20260304154549.GZ1388590@bill-the-cat>
In-Reply-To: <20260304154549.GZ1388590@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 4 Mar 2026 18:57:42 +0200
X-Gm-Features: AaiRm50O50hB2cBnTxUp6RyJoMrRZy05J_yoAV2tOjcIef9Xx698ptCmbJ4ATJg
Message-ID: <CAC_iWjKehyCeLfmPWGUHAHF5YXaynWMzyYnuc-wqZmDmjQQnZg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: unexport sub_make_done to fix child make
 invocations
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor@kernel.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, 
 Simon Glass <simon.glass@canonical.com>, Sughosh Ganu <sughosh.ganu@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom



On Wed, 4 Mar 2026 at 17:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 04, 2026 at 03:24:45PM +0000, Conor Dooley wrote:
> > On Wed, Mar 04, 2026 at 09:11:54AM -0600, Tom Rini wrote:
> > > On Wed, Mar 04, 2026 at 03:09:40PM +0000, Conor Dooley wrote:
> > > > On Wed, Mar 04, 2026 at 09:01:45AM -0600, Tom Rini wrote:
> > > > > On Wed, Mar 04, 2026 at 09:54:22AM +0000, Conor Dooley wrote:
> > > > > > On Tue, Mar 03, 2026 at 12:50:55PM -0600, Tom Rini wrote:
> > > > > > > On Fri, 13 Feb 2026 19:47:34 -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > The exported sub_make_done variable leaks into the environment of all
> > > > > > > > child processes. When make targets like tcheck spawn independent make
> > > > > > > > invocations with O=, those child makes inherit sub_make_done=1, skip
> > > > > > > > the KBUILD_OUTPUT setup and try to build in the source tree.
> > > > > > > >
> > > > > > > > There is a workaround that resets sub_make_done to 0 for specific test
> > > > > > > > targets, but this isn't great since it has tolist every target that
> > > > > > > > spawns independent make invocations.
> > > > > > > >
> > > > > > > > [...]
> > > > > > >
> > > > > > > Applied to u-boot/master, thanks!
> > > > > > >
> > > > > > > [1/1] kbuild: unexport sub_make_done to fix child make invocations
> > > > > > >       commit: 4284306d22c5b6d64ecd62b462551d9d313c8104
> > > > > >
> > > > > >
> > > > > > This breaks the build for me:
> > > > > > make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- O=build microchip_mpfs_generic_defconfig
> > > > > >   GEN     Makefile
> > > > > > #
> > > > > > # configuration written to .config
> > > > > > #
> > > > > > make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- O=build
> > > > > >   HOSTCC  scripts/basic/fixdep
> > > > > >   GEN     Makefile
> > > > > >   HOSTCC  scripts/kconfig/conf.o
> > > > > >   YACC    scripts/kconfig/zconf.tab.[ch]
> > > > > >   LEX     scripts/kconfig/zconf.lex.c
> > > > > >   HOSTCC  scripts/kconfig/zconf.tab.o
> > > > > >   HOSTLD  scripts/kconfig/conf
> > > > > > scripts/kconfig/conf  --syncconfig Kconfig
> > > > > > ***
> > > > > > *** Configuration file ".config" not found!
> > > > > > ***
> > > > > > *** Please run some configurator (e.g. "make oldconfig" or
> > > > > > *** "make menuconfig" or "make xconfig").
> > > > > > ***
> > > > > > make[4]: *** [/stuff/u-boot/scripts/kconfig/Makefile:75: syncconfig] Error 1
> > > > > > make[3]: *** [/stuff/u-boot/Makefile:702: syncconfig] Error 2
> > > > > > make[2]: *** [../Makefile:189: __sub-make] Error 2
> > > > > > make[1]: *** No rule to make target 'include/config/auto.conf', needed by 'include/config/uboot.release'.  Stop.
> > > > > > make: *** [Makefile:189: __sub-make] Error 2
> > > > >
> > > > > That's odd. What host distro and make? I don't see that on Ubuntu 24.04.
> > > >
> > > > Originally my CI found it in a docker container with "from: ubuntu:noble",
> > > > so 24.04. I reproduced it locally on debian unstable with make 4.4.1
> > >
> > > That's even more puzzling (noble is 24.04) since that sounds very close
> > > to our CI too. Can you please look more in to what's going on?
> >
> > Can I assume your CI also sets O=<something> then? Is the CI config
> > stuff in tree, or somewhere else?
>
> We use buildman, which in turn does separate output directories. We
> also, in Azure, have one job that uses O= specifically. Things are
> defiend in .gitlab-ci.yml and .azure-pipelines.yml

I get the same error with
make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- qemu_arm64_lwip_defconfig O=build
make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- O=build
  HOSTCC  scripts/basic/fixdep
  GEN     Makefile
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.[ch]
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --syncconfig Kconfig
***
*** Configuration file ".config" not found!
***
*** Please run some configurator (e.g. "make oldconfig" or
*** "make menuconfig" or "make xconfig").
***
make[4]: *** [/home/apalos/work/u-boot-tpm/scripts/kconfig/Makefile:75:
syncconfig] Error 1
make[3]: *** [/home/apalos/work/u-boot-tpm/Makefile:702: syncconfig] Error 2
make[2]: *** [../Makefile:189: __sub-make] Error 2
make[1]: *** No rule to make target 'include/config/auto.conf', needed
by 'include/config/uboot.release'.  Stop.
make: *** [Makefile:189: __sub-make] Error 2

Also the patch has a Fixes tag, but it doesn't actually fix anything.
It just tries to improve something. Can we revert it on master at
least? Do you want me to send a patch?

Cheers
/Ilias
>
> --
> Tom
