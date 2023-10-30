Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B92EC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 08:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6AA8725E;
	Mon, 30 Oct 2023 09:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6915A879A2; Mon, 30 Oct 2023 09:29:09 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C885A87096
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 09:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39U8So26095121;
 Mon, 30 Oct 2023 16:28:50 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 30 Oct 2023 16:28:47 +0800
Date: Mon, 30 Oct 2023 16:25:11 +0800
From: Leo Liang <ycliang@andestech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Rick Chen <rick@andestech.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Anup Patel <apatel@ventanamicro.com>, Kautuk Consul
 <kconsul@ventanamicro.com>,
 Chanho Park <chanho61.park@samsung.com>, <u-boot@lists.denx.de>
Subject: Re: [RFC v2 2/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <ZT9oZ7rf1GiWeP9j@swlinux02>
References: <20231029084533.44607-1-heinrich.schuchardt@canonical.com>
 <20231029084533.44607-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231029084533.44607-3-heinrich.schuchardt@canonical.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 39U8So26095121
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

On Sun, Oct 29, 2023 at 09:45:33AM +0100, Heinrich Schuchardt wrote:
> The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
> provides an interface to a physical entropy source.
> 
> A RNG driver based on the seed CSR is provided. It depends on
> mseccfg.sseed being set in the SBI firmware.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	Resume after exception if seed CSR cannot be read.
> ---
>  drivers/rng/Kconfig         |   8 +++
>  drivers/rng/Makefile        |   1 +
>  drivers/rng/riscv_zkr_rng.c | 116 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 125 insertions(+)
>  create mode 100644 drivers/rng/riscv_zkr_rng.c

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
