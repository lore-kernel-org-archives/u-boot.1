Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E736CE7B5E0
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FFFB87234;
	Wed,  4 Oct 2023 11:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBBD87235; Wed,  4 Oct 2023 11:27:11 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8827387229
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3949Qv75018078;
 Wed, 4 Oct 2023 17:26:57 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 4 Oct 2023 17:26:56 +0800
Date: Wed, 4 Oct 2023 17:24:59 +0800
From: Leo Liang <ycliang@andestech.com>
To: Chanho Park <chanho61.park@samsung.com>
CC: Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 2/3] riscv: timer: add timer_get_boot_us for BOOTSTAGE
Message-ID: <ZR0va8xS0rcSru3B@swlinux02>
References: <20230906051814.1393464-1-chanho61.park@samsung.com>
 <CGME20230906051831epcas2p4b7b6569a55abbab22621658b88bac9d6@epcas2p4.samsung.com>
 <20230906051814.1393464-3-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230906051814.1393464-3-chanho61.park@samsung.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3949Qv75018078
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

On Wed, Sep 06, 2023 at 02:18:13PM +0900, Chanho Park wrote:
> timer_get_boot_us function is required to record the boot stages as
> us-based timestamp.
> To get a micro-second time from a timer tick, this converts the
> formula like below to avoid zero result of (tick / rate) part.
> 
> From: time(us) = (tick / rate) * 10000000
> To  : time(us) = (tick * 1000) / (rate / 1000)
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/timer/riscv_timer.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
