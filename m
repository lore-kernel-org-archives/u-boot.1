Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C6FCAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31836832DA;
	Fri, 19 Sep 2025 12:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB5BC8331F; Fri, 19 Sep 2025 12:59:08 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BBF58319C
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 58JAwpC6075358
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Fri, 19 Sep 2025 18:58:51 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 19 Sep
 2025 18:58:51 +0800
Date: Fri, 19 Sep 2025 18:58:49 +0800
From: Leo Liang <ycliang@andestech.com>
To: E Shattow <e@freeshell.de>
CC: Rick Chen <rick@andestech.com>, Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v3 3/4] riscv: dts: starfive: visionfive2 depend on
 SYS_CPU automatic dtsi inclusion
Message-ID: <aM03aZQwjPy0WIOK@swlinux02>
References: <20250917000254.1134031-1-e@freeshell.de>
 <20250917000254.1134031-4-e@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250917000254.1134031-4-e@freeshell.de>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 58JAwpC6075358
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

On Tue, Sep 16, 2025 at 05:02:24PM -0700, E Shattow wrote:
> Drop visionfive2 per-board -u-boot.dtsi stubs and instead rely on
> automatic inclusion of jh7110-u-boot.dtsi
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi   | 7 -------
>  arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi               | 7 -------
>  arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi            | 7 -------
>  .../dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi     | 7 -------
>  .../dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi     | 7 -------
>  arch/riscv/dts/jh7110-u-boot.dtsi                          | 1 +
>  6 files changed, 1 insertion(+), 35 deletions(-)
>  delete mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
>  delete mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>  delete mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>  delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
>  delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
