Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849A8D2AB24
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 11:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E891488D3A;
	Tue, 29 Oct 2024 12:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D20D88EF5; Tue, 29 Oct 2024 12:57:20 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFFEE88B64
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:57:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 49TBur8j020096
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 29 Oct 2024 19:56:53 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 19:56:53 +0800
Date: Tue, 29 Oct 2024 19:56:49 +0800
From: Leo Liang <ycliang@andestech.com>
To: Conor Dooley <conor@kernel.org>
CC: <u-boot@lists.denx.de>, Conor Dooley <conor.dooley@microchip.com>, "Rick
 Chen" <rick@andestech.com>, Tom Rini <trini@konsulko.com>, Cyril Jean
 <cyril.jean@microchip.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 1/3] clk: microchip: mpfs: support new syscon based
 devicetree configuration
Message-ID: <ZyDNdHueVzHvcm3K@swlinux02>
References: <20241023101754.4021948-1-conor@kernel.org>
 <20241023101754.4021948-2-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241023101754.4021948-2-conor@kernel.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 49TBur8j020096
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

On Wed, Oct 23, 2024 at 11:17:52AM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Why get a devicetree description wrong once when you can get it wrong
> twice? The original mistake, which the driver supports was failing to
> describe the main PLL that the "cfg" and "periph" clocks parented by.
> The second mistake was describing the "cfg" and "periph" clocks a
> reg region within the clock controller, rather as two registers within
> a syscon region that also contains pinctrl, interrupt muxing controls
> and other functions.
> 
> Make up for lost time and describe these regions as they should have
> been originally, preserving support for the existing two configurations
> for the sake of existing systems with firmware-provided devicetrees.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/clk/microchip/Kconfig           |  2 +
>  drivers/clk/microchip/mpfs_clk.c        | 63 ++++++++++++++++++++-----
>  drivers/clk/microchip/mpfs_clk.h        |  5 +-
>  drivers/clk/microchip/mpfs_clk_cfg.c    | 16 +++----
>  drivers/clk/microchip/mpfs_clk_periph.c | 37 +++++++--------
>  5 files changed, 81 insertions(+), 42 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
