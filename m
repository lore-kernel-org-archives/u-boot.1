Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C82EC55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 15:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9E8660653;
	Wed,  5 Aug 2026 15:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Lmj0qjDf44i; Wed,  5 Aug 2026 15:51:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E45D8607B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785945066;
	bh=TmtQQwB0cEJN08HJUzMHmnny0WdBZ4mi7c6sOIh2/WQ=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=es+y0BxS5HgJzYEKY//byaP+0+5Jw5p70oJQof4mmf/AGnlKA4vQZI2RYFY0MPLMF
	 AkgAErtSrpZkz2cKjnVoCQ649jYVfnlaqqqmMBEDzmXTGn3tcS8XnkL6ktHZnYO181
	 dIBPtp3XphEib1zA9OuUWyeMW+UOj73r0po9fw9+hWE3VyxTtwXRLEU9fSJHur1vsQ
	 1qRCsxm9sUaIftmkixp/rYH9UfKLGekcRMwfXI7XqqlBEGVp5768eh0FB7UJSWTQsk
	 NRkUe288uQ7eUBnxbkg2KWauw9XhNYcEglb4NWRPHAi0prN7LO5IRcAcEniejEg2+L
	 z/wYRju12W0AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E45D8607B3;
	Wed,  5 Aug 2026 15:51:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 94A9F397
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 15:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A82B80A8C
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 15:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CrWBX8nHdSI9 for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 15:51:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 896EF80A79
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 896EF80A79
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 896EF80A79
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 15:51:03 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84f10e55beaso380173b3a.1
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 08:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785945063; x=1786549863;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TmtQQwB0cEJN08HJUzMHmnny0WdBZ4mi7c6sOIh2/WQ=;
 b=hBEVsr0V5nQcn9QXn3J3+4JzIW7+tISmNZhxiYbFbbV2TW6DMswm6am6UQHuAIlGHo
 jUakyAQHHOA6jrYwPV4R5K6rNE33bOImDF7P0hRLQl3OFl+anm9s4UVGRvS/ukahbLEM
 6p62oRoltMZ1xlyP8moKRIUuIsEiMgRtfKwvL+wdw4poO9edM61pncdUBSSIBsPWNDWt
 ilinGyS3CMPNJ80k1jzztXJgwL157xiluRJ2H8L3R7mm+EVCXofX+MMRBG64wxTIae9E
 xjVzm063GGmif61Thl9/9048+sOXIo1tXOW3fGfMjo/o7N+rAfmOvSOgYE6sDwYtADOI
 NcoA==
X-Gm-Message-State: AOJu0YwgqEQ0SkCKE2jdVlxnl58/pS87ejKQNut359d0bUi+NAm21AXV
 Cu2H+L81MwCIjz+qvkvCCB+BkLeux5twdzclht6jneNBG26XX6tLmQO3t+moonDXUZQ=
X-Gm-Gg: AR+sD103QRnCBINiLh84oxE029n2VaPP+2tFFyZURWJxxSQnnm47wpboWTJWHRuDKWa
 yNrk+iXyBLzpleCH5+GZPamsg48MNM/RTHA7G+7eAD54cGsYZC7LVQ9BF7jlzQ/Z+JVUjqebvPN
 p4h0R/+60Xr8MfcVUn12ypei8Mr3IMJux7+8ypD9bOdxmlpd7ymWfpqZd1YFkxKFK3QeR21kuG4
 V1oLAeIqmTLJTYlvBZMxmnBtIly0uReLajDoFRQVBcqW14d7Q9XUq3prBDKZJXyugRERhOkIYZA
 2k5/AMBgtBLiZoSm33e/KWyM0cs8jb7UgPH5PS6QMAHiIT8DOXfY9sHRuN//xYxqssAhveTLRqU
 3uqj9y2P8RZGfD/z85CMXWtVihkW1L34MFO9Rce2Cdhv9wtBb5GHF+uz7kWdp+tM/kRNRGZA/a4
 JckFY0yC58Z+TU/j168eXfGGbGyiI7tDG5jmnRK2F7gJbw36YMaRJHQoWWza2iWT6N/vAkZv3Jx
 u1lgJ6rfbbOkyM+
X-Received: by 2002:a05:6a00:22cc:b0:848:2c6c:dfc0 with SMTP id
 d2e1a72fcca58-84f2e04ea1amr8183861b3a.24.1785945062795; 
 Wed, 05 Aug 2026 08:51:02 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.202])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f2e2e06a6sm1107415b3a.15.2026.08.05.08.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:51:01 -0700 (PDT)
Date: Wed, 5 Aug 2026 23:50:53 +0800
To: Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Kongyang Liu <seashell11234455@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Yao Zi <me@ziyao.cc>, Andreas Schwab <schwab@suse.de>,
 Michal Simek <michal.simek@amd.com>,
 Martin Herren <sputnik@on-the-web.ch>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/2] board: sophgo: add support for Milk-V Duo 256M
Message-ID: <anNb3dknx6Qxlyaq@lliang-1876.localdomain>
References: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785945063; x=1786549863;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TmtQQwB0cEJN08HJUzMHmnny0WdBZ4mi7c6sOIh2/WQ=;
 b=B9KWQAiEW+EV5T4StwSSjVHajxDsHCvn1APXaqwVn9aK200uJl5c9dYt68UTQ8vqJC
 jwNxN+kX2qhNrsepAZpv0qfejDmEz/buKv6upvTRlErED/bBJ9UGsmRMJyrNaOdrN96Q
 Dhi02uaqXuBBXCl6IbaUF7Jkb56b42zq3lNw/Ua5+Lp0VKDmWnC85bLHKVKKHIa0cyTa
 rSRJu3vbrUP8wNBHyNQxHUV5rQ1oFbS69/w6AgDiqk1EibnMk/mY4tDkzWitVlRgD9VI
 7UWSSWe5snOOTaHi3PF3hzOk/xicOUayN1bdCNQqoe81QdAUiJ09mpB9v6JgCP77Vjfk
 J6nA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=B9KWQAiE
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Hiago,

On Thu, Jul 23, 2026 at 11:44:33AM -0300, Hiago De Franco wrote:
> Milk-V Duo 256M is a small development board based on the Sophgo SG2002
> SoC.
> 
> U-Boot runs as the S-mode payload on top of the vendor FSBL and OpenSBI,
> packaged together into a FIP image on the SD card.
> 
> The vendor FIP tool prepends a 32-byte loader header to u-boot.bin and
> loads the result at 0x80200000, so TEXT_BASE is set to 0x80200020 to
> match the address the U-Boot code actually runs.
> 
> The following peripherals are supported:
> - ns16550 serial console (UART0)
> - SD/MMC
> - Ethernet with the SoC internal PHY
> 
> This patch was tested on Milk-V Duo 256MB using an SD card and the Duo
> USB & Ethernet IOB (base board) [0].
> 
> This series uses the CV1800B SYS_CPU target since SG2002 shares common
> IPs with CV1800B. Other SG2002 as LicheeRV Nano does the same.
> 
> Note: Linux device tree is not yet merged [1], therefore I am adding a
> device tree here and it can be later changed to use the kernel upstream
> one.
> 
> [0] https://milkv.io/docs/duo/io-board/usb-ethernet-iob
> [1] https://lore.kernel.org/lkml/20260710075917.159969-1-chenyou910331@gmail.com/
> 
> Link: https://milkv.io/docs/duo/getting-started/duo256m
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
> Changes in v2:
> - Makefile: changed to use 'milkv_duo/board.c' instead of
>   'milkv_duo_256m/board.c', since they share the exact same code.
> - board.c: deleted, because of the above.
> - doc: updated to add Ethernet support.
> - Link to v1: https://lore.kernel.org/r/20260710-add-milkv-duo256m-v1-0-0f761100361d@baylibre.com
> 
> ---
> Hiago De Franco (2):
>       board: sophgo: move ethernet driver to common directory
>       board: sophgo: add support for Milk-V Duo 256M
> 
>  arch/riscv/Kconfig                             |  4 ++
>  arch/riscv/dts/Makefile                        |  1 +
>  arch/riscv/dts/sg2002-milkv-duo256m.dts        | 46 ++++++++++++++
>  board/sophgo/{milkv_duo => common}/ethernet.c  |  0
>  board/sophgo/{milkv_duo => common}/ethernet.h  |  0
>  board/sophgo/milkv_duo/MAINTAINERS             |  1 +
>  board/sophgo/milkv_duo/Makefile                |  2 +-
>  board/sophgo/milkv_duo/board.c                 |  2 +-
>  board/sophgo/milkv_duo_256m/Kconfig            | 30 +++++++++
>  board/sophgo/milkv_duo_256m/MAINTAINERS        |  5 ++
>  board/sophgo/milkv_duo_256m/Makefile           |  6 ++
>  board/sophgo/milkv_duo_256m/milkv_duo_256m.env |  8 +++
>  configs/milkv_duo_256m_defconfig               | 42 +++++++++++++
>  doc/board/sophgo/index.rst                     |  1 +
>  doc/board/sophgo/milkv_duo_256m.rst            | 84 ++++++++++++++++++++++++++
>  include/configs/milkv_duo_256m.h               | 12 ++++
>  16 files changed, 242 insertions(+), 2 deletions(-)
> ---
> base-commit: ece349ade2973e220f524ce59e59711cc919263f
> change-id: 20260710-add-milkv-duo256m-1662c5cafb35
> 
> Best regards,

Applied to u-boot-riscv/main, thanks.

Best regards,
Leo
