Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF440C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 09:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 394DF81DD6;
	Mon, 12 May 2025 11:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6592D81F66; Mon, 12 May 2025 11:57:28 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9718091A
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 11:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 54C9uiQ5091511
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 12 May 2025 17:56:44 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 17:56:44 +0800
Date: Mon, 12 May 2025 17:56:41 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yao Zi <ziyao@disroot.org>
CC: Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>, Wei Fu
 <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>, Maksim Kiselev
 <bigunclemax@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Neha Malcom Francis
 <n-francis@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis
 <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, <u-boot@lists.denx.de>,
 Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 01/10] riscv: lib: Split out support for T-Head cache
 management operations
Message-ID: <aCHF2VU1NC-X5g4E@swlinux02>
References: <20250426165704.35523-1-ziyao@disroot.org>
 <20250426165704.35523-2-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250426165704.35523-2-ziyao@disroot.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 54C9uiQ5091511
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

On Sat, Apr 26, 2025 at 04:56:55PM +0000, Yao Zi wrote:
> [EXTERNAL MAIL]
> 
> Designed before a standard set of cache management operations defined in
> RISC-V, earlier T-Head cores like C906 and C910 provide CMO through the
> customized extension XTheadCMO, which has been used in the CV1800B port
> of U-Boot.
> 
> This patch splits XTheadCMO-related code into a generic module, allowing
> SoCs shipping T-Head cores to share the code.
> 
> Link: https://github.com/XUANTIE-RV/thead-extension-spec
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/riscv/Kconfig                                  | 8 ++++++++
>  arch/riscv/cpu/cv1800b/Kconfig                      | 1 +
>  arch/riscv/cpu/cv1800b/Makefile                     | 1 -
>  arch/riscv/lib/Makefile                             | 1 +
>  arch/riscv/{cpu/cv1800b/cache.c => lib/thead_cmo.c} | 0
>  5 files changed, 10 insertions(+), 1 deletion(-)
>  rename arch/riscv/{cpu/cv1800b/cache.c => lib/thead_cmo.c} (100%)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
