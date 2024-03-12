Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D026FC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C9B287DE6;
	Tue, 12 Mar 2024 10:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52A2A87E63; Tue, 12 Mar 2024 10:42:59 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F76487D9D
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42C9gcs9038895;
 Tue, 12 Mar 2024 17:42:38 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 12 Mar 2024 17:42:37 +0800
Date: Tue, 12 Mar 2024 17:42:34 +0800
From: Leo Liang <ycliang@andestech.com>
To: Kongyang Liu <seashell11234455@gmail.com>
CC: <u-boot@lists.denx.de>, Anup Patel <anup@brainfault.org>, Bin Meng
 <bmeng@tinylab.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek
 <michal.simek@amd.com>, Randolph <randolph@andestech.com>, Rick Chen
 <rick@andestech.com>, Samuel Holland <samuel@sholland.org>, Shengyu Qu
 <wiagn233@outlook.com>, Tom Rini <trini@konsulko.com>, Yu Chien Peter Lin
 <peterlin@andestech.com>
Subject: Re: [PATCH v2 1/2] riscv: cpu: cv1800b: Add support for cv1800b SoC
Message-ID: <ZfAjinoWTrQ6bt2j@swlinux02>
References: <20240309165533.48795-1-seashell11234455@gmail.com>
 <20240309165533.48795-2-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240309165533.48795-2-seashell11234455@gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42C9gcs9038895
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

On Sun, Mar 10, 2024 at 12:54:56AM +0800, Kongyang Liu wrote:
> Add Sophgo cv1800b SoC to support RISC-V arch.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
> 
> Changes in v2:
> - Remove duplicate code in function cleanup_before_linux
> 
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/cpu/cv1800b/Kconfig  | 12 ++++++++++++
>  arch/riscv/cpu/cv1800b/Makefile |  6 ++++++
>  arch/riscv/cpu/cv1800b/cpu.c    |  9 +++++++++
>  arch/riscv/cpu/cv1800b/dram.c   | 21 +++++++++++++++++++++
>  board/sophgo/milkv_duo/Kconfig  |  4 ++--
>  6 files changed, 51 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/cpu/cv1800b/Kconfig
>  create mode 100644 arch/riscv/cpu/cv1800b/Makefile
>  create mode 100644 arch/riscv/cpu/cv1800b/cpu.c
>  create mode 100644 arch/riscv/cpu/cv1800b/dram.c

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
