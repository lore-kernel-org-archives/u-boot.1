Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF36CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 13:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3A8084701;
	Thu, 11 Jun 2026 15:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jsu6ZfNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F05F83FEC; Thu, 11 Jun 2026 15:53:55 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B918407D
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 15:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-43b7e186a0cso3267842fac.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781186032; x=1781790832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2b+c+3L1bJYdwICCNkXCBHANZDlHafQDF7IuQPA60Y=;
 b=Jsu6ZfNylR43j5LXRvvPmbwjUMDt8ILH96V81XFsIpC4kAy8TTiS87ujZmDimvn750
 QaUpLYq62LYuPuQ2x4OHD8srWDBiGdha1Lw/v6qDxwJU3wbdL+b8NLuM/Qb2Zgkphmeh
 hZYGh+Mvki7SDG/R8eBNKljALgMeb+vZ5s8C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781186032; x=1781790832;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P2b+c+3L1bJYdwICCNkXCBHANZDlHafQDF7IuQPA60Y=;
 b=e/6+Zt6rxVbX2cPuRTkct1dPReYckiEQx37yKJUfU8c4UeMz0qxwmpjfyPWHrUBDfT
 nNyviB+8s+GvJx7WI1hnPzbJA53VPetWvfm3bvcos/zCUZ//Iss6qTsaqOTq5/rWe0iY
 IiRk84ST1Z6lP5EUgdXQgJ3o+MhXBBFecG456My9du69zObSdjOFMEIsbQhGbpasbDnE
 jg/FsNXA88jnvzQk7z97UVToR81IRQj46kWlwGTivkDCSdUJMBP8N/yP1bcnqt0884hZ
 PqMezG+6z5IPfRoAavLVaqqkfnA+f90E/BE/m8a6i+UKQ8UudTWGQhhC7V7AdGhEa6Wa
 ROOg==
X-Gm-Message-State: AOJu0Yz2Ossrdy5TYjCtHSLrnGYFawAPe9vzYCJIXF7X04ua1giQ49l4
 2SxC3HmKhNbPIW4Y1yibnrca6Gqms0mZUtEKpXS5RYeHjVvDVQkw62QeIrxlnYdLLRBD0+ObzgJ
 8o/NzIc4=
X-Gm-Gg: Acq92OHoARra2jsAUMUR33Y7yWFJeYdWOGZXY1mmHbCVJxGOQOK6zs3DPQx40LdPPpH
 8+yx4Q5+4SM+KIYbxxKwXn1mVcBXHA4ux0W+2jhKqqK8VCk7cpY56aG6hs8w2NphIiWjL+Fhey2
 sCM3VNvxcVXnmrewj2JdNlt/F18vjhphulok3dZwTRDE0VpBrHAN3/3BiPJgRTaBbO1clmugvBa
 pczJPNXXaEvCfQxgWuhwHMJhZ0V5oyEBNwZuTAhKaxOhU8T35mJmPRzvWherDuIVrngXosPPVfz
 5gmb7QLDbM6iAM3qBqWBTRouDIF9y6Xz3C0oon+mM+CVmUwn58W9GgpiYHcM3Cs00UDtorK4gJF
 ZdFn/jBp8YUPzEScCssCIAPOsivcGxST07g4NU2tW927a++xtPQm+bxQMgkpjJph+hczczQMEpo
 lwYnw6foCG+MI8H82tUQoiaSkOsHsNtgf6qwK8GswETW9zSVamhvoffL0OIEWxTKvwtrrbuem05
 RzKiHZj4wxO+VHkwb/hkeiM+qBP4H9Y/x0NmyLFAk+qK7D8NaG0SAbSAQ==
X-Received: by 2002:a05:6870:1407:b0:442:3434:7dd6 with SMTP id
 586e51a60fabf-44241818bf7mr1664583fac.14.1781186031284; 
 Thu, 11 Jun 2026 06:53:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-442446babc9sm1157548fac.8.2026.06.11.06.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 06:53:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Siu Ming Tong <smtong@axiado.com>
Cc: Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>
In-Reply-To: <20260527-review-v2-0-10daefddf47d@axiado.com>
References: <20260527-review-v2-0-10daefddf47d@axiado.com>
Subject: Re: [PATCH v2 0/2] This series introduces initial U-Boot support
 for mach-axiado AX3005 SCM3005 board, a quad-core ARM Cortex-A53
 (ARMv8/ARM64) platform.
Message-Id: <178118603011.482984.504175864036936544.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 07:53:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 27 May 2026 19:38:35 -0700, Siu Ming Tong wrote:

> Patch 1 adds the device tree files: an SoC-level DTSI describing
> GIC-v3, Cadence/Zynq UART, a fixed reference clock, and spin-table
> secondary CPU boot, plus a board-level DTS setting the console to
> uart3 at 115200 baud with 2 GB DRAM at 0x80000000.
> 
> Patch 2 adds mach-axiado to support Axiado SoC-based boards, Kconfig
> plumbing (AXIADO_AX3005 and TARGET_SCM3005), defconfig, board source
> with ft_board_setup() and a MAINTAINERS entry.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] arm64: dts: axiado: Add AX3005 SCM3005 device tree
      commit: 7a06f03e575df25d34cf4085000e21ea97082ab6
[2/2] grm: axiado: Add AX3005 based SCM3005 board support
      commit: 3f1821162638acc34b47b6c68f3bc8bab365c08d
-- 
Tom


