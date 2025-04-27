Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EA5C369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 15:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F5E80FDE;
	Sun, 27 Apr 2025 17:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="IwNDIEAg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45A281F45; Sun, 27 Apr 2025 17:47:10 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EC6480FDA
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 17:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 467EB25D31;
 Sun, 27 Apr 2025 17:47:08 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 54KCdtQbkEaD; Sun, 27 Apr 2025 17:47:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745768827; bh=ciUiXzpvcLCigR/uL9nhXpjMTwU5NdCYDPgVVjphkEE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IwNDIEAg4R2XxqR3TkXhi17/uADFgFFDf0CFkzEmEh4Ppzi2hd5KE5UZNwFDpLOst
 XxB0ofx7EPIwnVvdfa5LOTTaP+KH1rpF8rJ7g4DK0W8GJ92r/m8TrFdcliZiivfuG5
 1bC84Dcizw0BN05byX/Au9H2qNgEcNBSBVJFA+MJWO4lIxFlyPKtsxzN4Mt9T+PZJF
 My8jq4hQbdRoD9rFvq0KC4Z6EQkilPZAayIBHfq/kroSg0DHuVbkxhHQ0e+mnMOjiz
 8xV7Qu1KmBzQ9hfURv4tyv5LMdIjGdhObjNhDR1CH0ELcjlnWpMRhG6q0qu2w/haEz
 FpPptpxkPzvPA==
Date: Sun, 27 Apr 2025 15:46:56 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Anton Blanchard <antonb@tenstorrent.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Nathaniel Hourt <I@nathaniel.land>
Subject: Re: [PATCH 1/2] Makefile: Strip leading spaces when preprocessing
 generated_defconfig
Message-ID: <aA5RcIbI7uhsGmu8@pie.lan>
References: <20250427145011.17331-1-ziyao@disroot.org>
 <20250427145011.17331-2-ziyao@disroot.org>
 <1526A781-5592-43DE-94F2-221DAA484192@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526A781-5592-43DE-94F2-221DAA484192@gmx.de>
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

On Sun, Apr 27, 2025 at 05:19:04PM +0200, Heinrich Schuchardt wrote:
> Am 27. April 2025 16:50:10 MESZ schrieb Yao Zi <ziyao@disroot.org>:
> >Clang's preprocessor may emit extra spaces for lines starting with '#'.
> >Lines with these extra characters cannot be handled by Kconfig and will
> >be ignored with warnings like,
> >
> 
> 
> Do you have an example for reprocing the issue?

Sure,

	clang-19 -E -nostdinc -P -I . -undef -x assembler-with-cpp \
		configs/starfive_visionfive2_defconfig

or a smaller example for demonstrating the behaviour,

	cat << EOF | clang -E -P -x assembler-with-cpp -
	# comment line
	normal line
	EOF

and you could see the strange indentation. For reproducing the exact
Kconfig warnings,

	make ARCH=riscv \
		CC='clang-19 --target=riscv64-unknown-linux-musl' \
		starfive_visionfive2_defconfig

(Clang is called clang-19 on my machine)

> Is there an understanding why Clang behaves in this way?

Sadly I have no idea. I guess it may serve for improving
human-readability of the preprocessed output.

This piece of Makefile (processing defconfigs with C preprocessor) is
U-Boot specific and doesn't exist in Linux kernel, thus it's unlikely
to have someone noted the bahaviour difference of preprocessors before.

Honestly saying sedding the output isn't a clean solution, but I cannot
come up with a better way. It'll be nice to have a flag to control the
format of output, but I didn't find one.

Am looking forward to further suggestions and documentation on this.

> Best regards 
> 
> Heinrich 

Thanks,
Yao Zi

> >        unexpected data:  # CONFIG_OF_BOARD_FIXUP is not set
> >
> >Those options that is expected to be assigned explicitly with N will be
> >set to the default value, messing up board configurations.
> >
> >Let's sed these spaces away to ensure board configurations could be
> >correctly generated with Clang.
> >
> >Fixes: 2027e99e61a ("Makefile: Run defconfig files through the C preprocessor")
> >Reported-by: Nathaniel Hourt <I@nathaniel.land>
> >Signed-off-by: Yao Zi <ziyao@disroot.org>
> >---
> > scripts/kconfig/Makefile | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> >index 079add4d5da..ba30652f01a 100644
> >--- a/scripts/kconfig/Makefile
> >+++ b/scripts/kconfig/Makefile
> >@@ -94,6 +94,7 @@ endif
> > 
> > %_defconfig: $(obj)/conf
> > 	$(Q)$(CPP) -nostdinc -P -I $(srctree) -undef -x assembler-with-cpp $(srctree)/arch/$(SRCARCH)/configs/$@ -o generated_defconfig
> >+	$(Q)sed -i -e 's/^[[:space:]]//' generated_defconfig
> > 	$(Q)$< $(silent) --defconfig=generated_defconfig $(Kconfig)
> > 
> > # Added for U-Boot (backward compatibility)
> 
