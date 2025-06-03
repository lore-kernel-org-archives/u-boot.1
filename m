Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD01C5B549
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 03:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1432281F0D;
	Tue,  3 Jun 2025 05:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C840D82045; Tue,  3 Jun 2025 05:23:29 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B692981E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 05:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5533N6Kw004267
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 3 Jun 2025 11:23:06 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 11:23:06 +0800
Date: Tue, 3 Jun 2025 11:23:06 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yao Zi <ziyao@disroot.org>
CC: Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>, Wei Fu
 <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jerome Forissier
 <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>,
 Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 3/5] riscv: dts: th1520: Prepare binman configuration for
 loading OpenSBI
Message-ID: <aD5qmiV_wFK0Abrl@swlinux02>
References: <20250530094851.57198-1-ziyao@disroot.org>
 <20250530094851.57198-4-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530094851.57198-4-ziyao@disroot.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5533N6Kw004267
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

On Fri, May 30, 2025 at 09:48:49AM +0000, Yao Zi wrote:
> [EXTERNAL MAIL]
> 
> Add an OpenSBI entry to the FIT image. As it expects an FDT to be
> passed, corresponding FDT entry is generated with of-list as well.
> 
> As SPL now passes a full FDT for following stages, proper U-Boot image
> is packed into u-boot-with-spl.bin without a devicetree copy included.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/riscv/dts/thead-th1520-binman.dtsi | 32 +++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
