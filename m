Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1BFC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 10:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B91E283EF1;
	Mon,  4 Aug 2025 12:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754301637;
	bh=7ED09X9HWJsb2jTaOqXZK3Duwh2OY+aioeDKX9h6dZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZUhhT2DNOYUqfjaT+fJpvR9BTJ66FhVOZNPLPwRmNaHEjt5+8fMErcdvMpDsq5hC2
	 UM6zst1wlSEzhr5twk7mtXjDgLb4+Po67L17B0QiE3u1JQUY5SxGcf6Pkqb4Qwp0TM
	 5Kk+bfHG/22MHxLdjtNabv2D6waKGT/Cl/aiZDtMDRVolJhYgfTayfKzlgpTLscVFU
	 mgMc3mK46reyL+b9NuyZhQz4OVH9S9nuC+unKSOj4CMHQ0A1joXy6ccMwNUZFInLPp
	 Pb9CR+XtdKG9fcI67dv7CaUGotb+bkINUt1pEQbXfsyTpOCU2iLpzo8WVMqUET1A0C
	 BrP+jCPYF/9Fg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D02C183F36; Mon,  4 Aug 2025 12:00:36 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0FE083E18
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 12:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Q/kGEEm6"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2FBE61038C127; 
 Mon,  4 Aug 2025 12:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754301633; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=7ED09X9HWJsb2jTaOqXZK3Duwh2OY+aioeDKX9h6dZQ=;
 b=Q/kGEEm6sowyAU52VoYRr1j+5Ju+nGCg/0JhKSgJILZVZl2kJB3ZJVYGTXxpOat+ccJJhX
 Ixpjyzs07eNkBN87cju51Or2W6v69+GMfmHexnnuGLSfP4CAdIR7ALQf9GyhYChokwhMZq
 iDuJofdcctbdVwi0rhLTJ7TbNbR16hI9eQ9cUZ8n3qzxJLwd82Hqe0wd4Z3CmPRHLxOMCz
 T6lzdhsjhjflTfrqZ6IuTnPZyU9gbhCcZ+BZ4mMUBGzrAdl2MpTiMDOse3eace7efxhx/+
 HMMQnmpQ5WQJ9GkWwmVHIHifTwRV2YPWQp6kQ17igNOiTb5zvmoaC1GN2A8JOA==
Date: Mon, 4 Aug 2025 12:00:27 +0200
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH v5 0/4] Add Onion Omega2/2+ board support
Message-ID: <aJCEu9pG0ZixhWG1@antares>
References: <20250730123833.249923-1-pro@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730123833.249923-1-pro@denx.de>
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

Hi Daniel,

Gentle Ping on this patch series. Do you think we can still get it
merged for the October release? Is there anything I can do to facilitate
the process?

Best regards,
Philip


On Wed, Jul 30, 2025 at 02:38:29PM +0200, Philip Oberfichtner wrote:
> Add support for the MediaTek based boards by Onion. Commit one to three are
> rather generic, whereas the last commit adds the actual board support.
> 
> Changes in v5:
> 	- Reimplement the Makefile size check
> 
> Changes in v4:
> 	- Rebase board support to v2025.07
> 	- Add new commit to silence warning in arch/mips/
> 
> Changes in v3:
> 	- Simplify image size check
> 
> Changes in v2:
> 	- I forgot to run checkpatch in v1. Fix some style issues in v2.
> 
> Philip Oberfichtner (4):
>   Makefile: Simplify size check
>   Makefile: Add size check for u-boot-with-spl.bin
>   mips: serial: Silence "unused variable" warning
>   mips: mt7628: Add Onion Omega2/2+ board support
> 
>  Makefile                                  |  45 ++------
>  arch/mips/dts/Makefile                    |   1 +
>  arch/mips/dts/onion-omega2p.dts           |  58 ++++++++++
>  arch/mips/mach-mtmips/mt7620/serial.c     |   2 +-
>  arch/mips/mach-mtmips/mt7621/spl/serial.c |   2 +-
>  arch/mips/mach-mtmips/mt7628/Kconfig      |   7 ++
>  arch/mips/mach-mtmips/mt7628/serial.c     |   2 +-
>  board/onion/omega2p/Kconfig               |  12 ++
>  board/onion/omega2p/MAINTAINERS           |  10 ++
>  board/onion/omega2p/Makefile              |   3 +
>  board/onion/omega2p/board.c               | 134 ++++++++++++++++++++++
>  board/onion/omega2p/omega2p.env           |  32 ++++++
>  common/spl/Kconfig                        |   7 ++
>  configs/onion-omega2p_defconfig           |  82 +++++++++++++
>  include/configs/onion-omega2p.h           |  15 +++
>  tools/spl_size_limit.c                    |   2 +-
>  16 files changed, 376 insertions(+), 38 deletions(-)
>  create mode 100644 arch/mips/dts/onion-omega2p.dts
>  create mode 100644 board/onion/omega2p/Kconfig
>  create mode 100644 board/onion/omega2p/MAINTAINERS
>  create mode 100644 board/onion/omega2p/Makefile
>  create mode 100644 board/onion/omega2p/board.c
>  create mode 100644 board/onion/omega2p/omega2p.env
>  create mode 100644 configs/onion-omega2p_defconfig
>  create mode 100644 include/configs/onion-omega2p.h
> 
> -- 
> 2.39.5
> 

-- 
=====================================================================
DENX Software Engineering GmbH,
Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
=====================================================================
