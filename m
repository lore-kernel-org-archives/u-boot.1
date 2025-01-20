Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832AAC02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 04:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D05C801CF;
	Mon, 20 Jan 2025 05:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A03805C5; Mon, 20 Jan 2025 05:32:27 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7ADC80085
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 05:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 50K4Vik1067802
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 20 Jan 2025 12:31:44 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 12:31:44 +0800
Date: Mon, 20 Jan 2025 12:31:40 +0800
From: Leo Liang <ycliang@andestech.com>
To: Huan Zhou <me@per1cycle.org>
CC: <u-boot@lists.denx.de>, Ben Dooks <ben.dooks@codethink.co.uk>, "Marcel
 Ziswiler" <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Yixun Lan <dlan@gentoo.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>, Kever Yang
 <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>, "Nishanth
 Menon" <nm@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, Randolph
 <randolph@andestech.com>, Rick Chen <rick@andestech.com>, Samuel Holland
 <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, Yu Chien Peter Lin
 <peterlin@andestech.com>, Huan Zhou <pericycle.cc@gmail.com>, Kongyang Liu
 <seashell11234455@gmail.com>, Padmarao Begari <padmarao.begari@amd.com>
Subject: Re: [PATCH v5] riscv: spacemit: k1: probe dram size during boot phase.
Message-ID: <Z43RrDFIf-4yCucF@swlinux02>
References: <20250120-get-dram-size-v5-1-2ad4f2e7a270@per1cycle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250120-get-dram-size-v5-1-2ad4f2e7a270@per1cycle.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 50K4Vik1067802
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

On Mon, Jan 20, 2025 at 12:29:20PM +0800, Huan Zhou wrote:
> [EXTERNAL MAIL]
> 
> Implement functionality to probe and calculate the DRAM size
> during the boot phase for the RISC-V spacemit K1 platform.
> 
> Tested-by: Marcel Ziswiler <marcel@ziswiler.com> # BPI-F3 16G
> Signed-off-by: Huan Zhou <me@per1cycle.org>
> ---
> This patch introduce improvement for get dram size on spacemit k1 platform,
> retrieving the dram size dynamically.
> Have tested on Licheepi LPI3A 8G[1].
> 
> Links:
> [1] https://gist.github.com/per1cycle/e4eab66ebb6f83fe5118e823367fce28 .
> 
> Changes in v5:
> - Fix the dummy typo.
> - Link to v4: https://lore.kernel.org/r/20250120-get-dram-size-v4-1-e74103e36d6b@per1cycle.org
> 
> Changes in v4:
> - shorten the commit message.
> - More proper way for `map_format_size` -> `ddr_map_size`
> - Link to v3: https://lore.kernel.org/r/20250114-get-dram-size-v3-1-83d5f88154d4@per1cycle.org
> 
> Changes in v3:
> - Remove the inline attr in arch/riscv/cpu/k1/dram.c map_format_size().
> - Add detailed commit message.
> - Link to v2: https://lore.kernel.org/r/20250114-get-dram-size-v2-1-aba5a281ea28@per1cycle.org
> 
> Changes in v2:
> - Fix bracker and return type in map_format_size() function.
> - Add test log in the cover letter..
> - Link to v1: https://lore.kernel.org/r/20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org
> ---
>  arch/riscv/cpu/k1/dram.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
