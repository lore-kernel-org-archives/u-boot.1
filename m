Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EFCCAC5A0
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 12:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0DE083287;
	Thu, 18 Sep 2025 14:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0A0D83287; Thu, 18 Sep 2025 14:07:34 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A75083285
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 14:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 58IC77Th088722
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 18 Sep 2025 20:07:07 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Sep
 2025 20:07:07 +0800
Date: Thu, 18 Sep 2025 20:07:05 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yao Zi <ziyao@disroot.org>
CC: Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>, "Chia-Wei,
 Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/3] riscv: Add Kconfig options to distinguish Zaamo
 and Zalrsc
Message-ID: <aMv16YIAJm1T51GR@swlinux02>
References: <20250902081932.21103-1-ziyao@disroot.org>
 <20250902081932.21103-2-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902081932.21103-2-ziyao@disroot.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 58IC77Th088722
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

On Tue, Sep 02, 2025 at 08:19:30AM +0000, Yao Zi wrote:
> Ratified on Apr. 2024, the original RISC-V "A" extension is now split
> into two separate extensions, "Zaamo" for atomic operations and "Zalrsc"
> for load-reserved/store-conditional instructions.
> 
> For now, we've already seen real-world designs implement the Zalrsc
> extension only[2]. As U-Boot mainly runs with only one HART, we could
> easily support these designs by not using AMO instructions in the
> hard-written assembly if necessary, for which this patch introduces two
> new Kconfig options to indicate the availability of "Zaamo" and "Zalrsc".
> 
> Note that even with this patch, "A" extension is specified in the ISA
> string passed to the compiler as long as one of "Zaamo" or "Zalrsc" is
> available, since they're only recognized with a quite recent version of
> GCC/Clang. The compiler usually doesn't automatically generate atomic
> instructions unless the source explicitly instructs it to do so, thus
> this should be safe.
> 
> Link: https://github.com/riscv/riscv-zaamo-zalrsc/commit/d94c64c63e9120d56bdeb540caf2e5dae60a8126 # [1]
> Link: https://lore.kernel.org/u-boot/20250729162035.209849-9-uros.stajic@htecgroup.com/ # [2]
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/riscv/Kconfig  | 17 +++++++++++++++++
>  arch/riscv/Makefile |  7 ++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
