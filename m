Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41EAE77188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 07:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8071E806FB;
	Thu, 16 Jan 2025 08:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E5D180702; Thu, 16 Jan 2025 08:42:57 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AF7E80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 08:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 50G7gkZo034498
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 16 Jan 2025 15:42:46 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Jan
 2025 15:42:46 +0800
Date: Thu, 16 Jan 2025 15:42:43 +0800
From: Leo Liang <ycliang@andestech.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>
CC: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/5] riscv: cpu: k230: Add support for Canaan Kendryte
 K230 SoC
Message-ID: <Z4i4c_SJYOcnjmum@swlinux02>
References: <20250115-k230-dev-1-v1-0-f4b77259e34a@pigmoral.tech>
 <20250115-k230-dev-1-v1-3-f4b77259e34a@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250115-k230-dev-1-v1-3-f4b77259e34a@pigmoral.tech>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 50G7gkZo034498
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

On Wed, Jan 15, 2025 at 12:46:39AM +0800, Junhui Liu wrote:
> Add Canaan K230 SoC with sysreset support, running without cache
> enabled.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  arch/riscv/Kconfig           |  5 +++++
>  arch/riscv/cpu/k230/Kconfig  | 14 ++++++++++++++
>  arch/riscv/cpu/k230/Makefile |  6 ++++++
>  arch/riscv/cpu/k230/cpu.c    |  9 +++++++++
>  arch/riscv/cpu/k230/dram.c   | 21 +++++++++++++++++++++
>  5 files changed, 55 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
