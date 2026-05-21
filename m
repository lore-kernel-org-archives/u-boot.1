Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9F1CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 13:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03BCF844CF;
	Thu, 21 May 2026 15:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AMnm1k8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25AFF8469F; Thu, 21 May 2026 15:36:50 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9143805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48e82c23840so49877245e9.3
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 06:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779370604; x=1779975404; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z5wXl5Yp6fQDiaTQzGi/t+zSUXA3Bo8TeAMtjGJ+3wY=;
 b=AMnm1k8UgV94FDakFhtmjSBFgobzzmD7IWaSuqaMD0FFC68UHrOYdHcsZcMGbLefIp
 AUzODn1iTX1R6QrlCaEyEEl06PNJQ1wRlUlqo+F9qzw8Y1MZXEMlaoXnqWZOtNWWSI46
 HnGumx4n0efPNdhZWi+tyl/NuUcfsDY+ZpxOHUCrwE2J7roDzQC1ILwZmJ5zrUK5/I5x
 hRB3x29vZ/qPDetx7OJ0KHEQHCZXU8wkNtORsAzJeuKCZL5zn856dSefaeTFJ9M9VZ8h
 JKzcpdSnFTBe4TvoF62aljVSXhbn5FifzBlchU87pX8Pa64XIkYZReW8RiPslPQqMa4/
 cdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370604; x=1779975404;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5wXl5Yp6fQDiaTQzGi/t+zSUXA3Bo8TeAMtjGJ+3wY=;
 b=BrDFsNeutcUlXE/EQm+JQ2NsCgsQMscfXHiegxi6AJ6ZWOTPpmm4oOiWc2QvXkOz7z
 bheGEPQ5/ccKaNl1j7RCZHzJrO/JVgeojqirGBQX0aBZgVrL1iZCs7vVv4qec00Im9cP
 aCUcDvj0jSAnAfumZxQ/6eU0b5q4jqTaEErrH/+rAIcvbqe1c9Bw3pFeZvEfUmZ7F1pz
 dXVs9IiBM/sq/cUvSJ7tZQfbmKrDFCArBL0f7qUD9dlvh/U68YEYfDncjXbxgMfl+KkN
 g80wlMaYvZRCxR+qUakb7UWkBztOW8GV4sIxtXJO0Our75eqUzcK3zpAeOGxhKNwDu/e
 bxFQ==
X-Gm-Message-State: AOJu0Yz4WfFvypYoy0DUN7zBwIrYAcXF66rmdBfls0t9C0/a/XHtyvem
 6jLmxe++QgIRWBah30GYcn28itkwWYYDhTpja8IZcuSYuDUxtuTGwrvNd7jdg80wN0c=
X-Gm-Gg: Acq92OGyAUZ2isBkrLB4jmmjWRGu7g3sTJMRL3z76ByIyBPUrpQCGW2RIGp3zR0gxhr
 UKrnBkUyjNFlNG0QOpYv9zs5FvoDvr++yywP/6/xVcY1S762yrRCrpMVV30xaUEv9N4wUhPs7el
 yh1fdyb4zYxTxcP/C+5Z3H3x5FvW6Vd3c3wsHs4UHyBXfm4MeyzmK4/lLmgP+fbn5hmb7MkUGuo
 cbyXnSo39b3jD/j0bqe+g4fBo//Yy7gioJleK6wY7g5NSdedYDxwGZBgQGxjh0zHERvf9wp5LoY
 w8JuusT1SCxUxtotXNJ8l8vk6lIvrvhmQWvMOueOlNj3nJ3qlPHMzxozc5KG5Gb1LPG8X5ZfF5u
 xYHmHHWaJVgZ8Mo+4sKHKNOmZ1zBaDNK8uwDwlQMneM0aXO/0wL6jffevwRdcrKYiRNorTJahzl
 J9RGYct0oZigL7flCHsHDfyE1aldyn
X-Received: by 2002:a05:600c:450c:b0:490:263f:24f2 with SMTP id
 5b1f17b1804b1-490360e35a6mr43542145e9.28.1779370604077; 
 Thu, 21 May 2026 06:36:44 -0700 (PDT)
Received: from linaro.org ([77.64.147.221]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903c9445d0sm30379215e9.0.2026.05.21.06.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:36:43 -0700 (PDT)
Date: Thu, 21 May 2026 15:36:10 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2 13/15] mach-snapdragon: support parsing memory map
 from SMEM
Message-ID: <ag8KSnFZLK0Ca66H@linaro.org>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-13-c01ec2ff3886@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-b4-modernise-smem-v2-13-c01ec2ff3886@linaro.org>
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

On Mon, May 04, 2026 at 08:57:41PM +0200, Casey Connolly wrote:
> It is possible to derive the memory map for a Qualcomm platform from the
> SMEM shared memory region. The memory map is populated by the preloader.
> 
> Introduce support for parsing this data and using it to populate
> U-Boot's memory map. Since we aren't yet sure if this will work for
> every platform, it is not yet used in all cases, if U-Boot is booted
> with an internal FDT which has the memory map defined, this will
> be used instead.
> 
> If the FDT is internal FDT with no memory map defined, then U-Boot will
> try to use SMEM. This should remove the need to define the memory map
> statically in a U-Boot overlay for boards that don't chainload.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>

Thanks a lot for working on this!

On DragonBoard 410c with (qcom_)dragonboard410c_defconfig:

	$ make qcom_dragonboard410c_defconfig
	  HOSTCC  scripts/basic/fixdep
	  GEN     Makefile
	  HOSTCC  scripts/kconfig/conf.o
	  YACC    scripts/kconfig/zconf.tab.[ch]
	  LEX     scripts/kconfig/zconf.lex.c
	  HOSTCC  scripts/kconfig/zconf.tab.o
	  HOSTLD  scripts/kconfig/conf

	WARNING: unmet direct dependencies detected for QCOM_SMEM
	  Depends on [n]: SOC_QCOM [=n]
	  Selected by [y]:
	  - ARCH_SNAPDRAGON [=y] && <choice>

	WARNING: unmet direct dependencies detected for QCOM_SMEM
	  Depends on [n]: SOC_QCOM [=n]
	  Selected by [y]:
	  - ARCH_SNAPDRAGON [=y] && <choice>

I added CONFIG_SOC_QCOM=y in (qcom_)dragonboard410c_defconfig to
workaround this, but we probably should select SOC_QCOM for
ARCH_SNAPDRAGON to fix this properly.

Then:

	$ make
	aarch64-linux-gnu-ld: arch/arm/mach-snapdragon/dram.o: in function `qcom_configure_capsule_updates':
	arch/arm/mach-snapdragon/qcom-priv.h:38: multiple definition of `qcom_configure_capsule_updates';
	arch/arm/mach-snapdragon/board.o:arch/arm/mach-snapdragon/qcom-priv.h:38: first defined here

I added:

diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 39dc8fcc76a..27e5c54e512 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -35,7 +35,7 @@ extern enum qcom_memmap_source qcom_memmap_source;
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 void qcom_configure_capsule_updates(void);
 #else
-void qcom_configure_capsule_updates(void) {}
+static inline void qcom_configure_capsule_updates(void) {}
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */

With that fixed:

U-Boot 2026.07-rc2-...
Qualcomm-DragonBoard 410C

DRAM:  1 GiB
...
U-Boot loaded from XBL
Memory map loaded from INTERNAL_FDT

Then I removed the /memory map in the internal FDT (delete
arch/arm/dts/apq8016-sbc-u-boot.dtsi), and it detects the correct 2 GiB
RAM on this board!

U-Boot 2026.07-rc2-...
Qualcomm-DragonBoard 410C

DRAM:  2 GiB
...
U-Boot loaded from XBL
Memory map loaded from SMEM

So feel free to add my Tested-by: # db410c if you fix the errors
mentioned above (also feel free to include a patch to delete
arch/arm/dts/apq8016-sbc-u-boot.dtsi, or I can do this myself later once
your series lands).

Thanks!
Stephan
