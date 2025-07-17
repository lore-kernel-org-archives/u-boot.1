Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12630C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 08:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398518334C;
	Thu, 17 Jul 2025 10:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1752739463;
	bh=35idbUpbKkV82MpocvNuQa6EDnFT4udTAoLMuuBo3w0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qpyGeBvWsbYJNA19oVsxS3UxRbr4nQ7pq6643eEm5xfQy8ReqMt0jcRku1ILAJKFs
	 WAf7B+CVSYUAj1dGx7zDK4k5bKEUWxn65LlNdw1DdxoL/tWqBiOsT38hiRyiF5ayRH
	 IJ/eOzCSOD0XJRcbsPdghMBpY6Lew+KuxivMAlhjlaMeiP9pUosUNKoMTQRkFmwFCM
	 rOPVhVl7+Q8J8HWrHtYy9Q5ndR5nO0h/hJNroCOVi9t3bz+oCDFOW/FdvyCcXqda6B
	 BXtuwAEneWCsIR+g0oiwgjBDC2j5pAzEMVBQ34NOYPeUG6wKDsOoj9uQqTGoN/h0zU
	 BAWMnW0/EvztQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F12D8334D; Thu, 17 Jul 2025 10:04:21 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C4683330
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 10:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="FJoat8JO"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EBC7C10397286; 
 Thu, 17 Jul 2025 10:04:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1752739458; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=35idbUpbKkV82MpocvNuQa6EDnFT4udTAoLMuuBo3w0=;
 b=FJoat8JO0UZY2IQamYqSQ8Gq8AnfPfPOZxSNVBkTxsrvPVx4KDndOoB4QZwGLtMNPP4uXd
 lNhrkJQ1Hti5IvyUvElpIqszOrOyL5ovlqh5P5AdlA1l4pr+48b8V5b5qbnHzYevfxdMeo
 pp2GumCo+rJMi1hDiAfPrhndpAQkwyBdFhTe6XlnbvxkbDm0KBm3yP/TDzV5YkbFqOMN52
 7h1nm03wR8SAFb4qFr21MPSRb5TLbHTjPGFEhAo61Il6PLZZXEgrZHt9p5KIcXZgc8mRk0
 H4MfRAWhdTYtvsWWfZOmXvsYtplrNPgaWJNy7vmhrXjskXvI5xlNfU3QF1dQqg==
Date: Thu, 17 Jul 2025 10:04:09 +0200
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
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
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH v4 0/3] Add Onion Omega2/2+ board support
Message-ID: <aHiued6ia50bT1-b@antares>
References: <20250708103959.26129-1-pro@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708103959.26129-1-pro@denx.de>
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

Hi all,

It's been a while since my first submission of this patch set (end of
May).  I'd hope we could still get it in within the current merge
window?

Best regards,
Philip

On Tue, Jul 08, 2025 at 12:39:56PM +0200, Philip Oberfichtner wrote:
> Add support for the MediaTek based boards by Onion. Commit one and two are
> rather generic, whereas the third commit adds the actual board support.
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
> Philip Oberfichtner (3):
>   Makefile: Add size check for u-boot-with-spl.bin
>   mips: serial: Silence "unused variable" warning
>   mips: mt7628: Add Onion Omega2/2+ board support
> 
>  Makefile                                  |   1 +
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
>  common/spl/Kconfig                        |   2 +-
>  configs/onion-omega2p_defconfig           |  82 +++++++++++++
>  include/configs/onion-omega2p.h           |  15 +++
>  15 files changed, 359 insertions(+), 4 deletions(-)
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
