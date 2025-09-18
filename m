Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A78ACAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 10:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F40A83285;
	Thu, 18 Sep 2025 12:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4D2583287; Thu, 18 Sep 2025 12:04:31 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5858380107
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 12:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 58IA42Qv022831
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 18 Sep 2025 18:04:02 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Sep
 2025 18:04:01 +0800
Date: Thu, 18 Sep 2025 18:03:58 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yao Zi <ziyao@disroot.org>
CC: Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>, Wei Fu
 <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Marek Vasut
 <marex@denx.de>, Michal Simek <michal.simek@amd.com>, Maksim Kiselev
 <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/4] dts: th1520: Switch to upstream devicetree
Message-ID: <aMvZDiyodtFuPACV@swlinux02>
References: <20250813100926.51725-2-ziyao@disroot.org>
 <20250813100926.51725-6-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250813100926.51725-6-ziyao@disroot.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 58IA42Qv022831
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

On Wed, Aug 13, 2025 at 10:09:27AM +0000, Yao Zi wrote:
> Imply OF_UPSTREAM in platform Kconfig option and adapt existing boards
> to use the correct upstream devicetree paths.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/riscv/cpu/th1520/Kconfig                 |   1 +
>  arch/riscv/dts/Makefile                       |   1 -
>  .../dts/th1520-lichee-module-4a-u-boot.dtsi   |  10 +
>  arch/riscv/dts/th1520-lichee-module-4a.dtsi   | 164 ------
>  .../riscv/dts/th1520-lichee-pi-4a-u-boot.dtsi |  27 +
>  arch/riscv/dts/th1520-lichee-pi-4a.dts        |  33 --
>  arch/riscv/dts/th1520-u-boot.dtsi             |  44 ++
>  arch/riscv/dts/th1520.dtsi                    | 530 ------------------
>  configs/th1520_lpi4a_defconfig                |   2 +-
>  9 files changed, 83 insertions(+), 729 deletions(-)
>  create mode 100644 arch/riscv/dts/th1520-lichee-module-4a-u-boot.dtsi
>  delete mode 100644 arch/riscv/dts/th1520-lichee-module-4a.dtsi
>  create mode 100644 arch/riscv/dts/th1520-lichee-pi-4a-u-boot.dtsi
>  delete mode 100644 arch/riscv/dts/th1520-lichee-pi-4a.dts
>  create mode 100644 arch/riscv/dts/th1520-u-boot.dtsi
>  delete mode 100644 arch/riscv/dts/th1520.dtsi

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
