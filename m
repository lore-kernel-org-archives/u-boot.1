Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10E3C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 11:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A386E87708;
	Mon,  4 Dec 2023 12:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEBF486E7E; Mon,  4 Dec 2023 12:23:20 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 111BB8773B
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 12:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3B4BN7J6081167;
 Mon, 4 Dec 2023 19:23:07 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 4 Dec 2023 19:23:04 +0800
Date: Mon, 4 Dec 2023 19:23:01 +0800
From: Leo Liang <ycliang@andestech.com>
To: Chanho Park <chanho61.park@samsung.com>
CC: Rick Chen <rick@andestech.com>, Stefan Roese <sr@denx.de>, Yanhong Wang
 <yanhong.wang@starfivetech.com>,
 Xingyu Wu <xingyu.wu@starfivetech.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/4] riscv: dts: jh7110: Add watchdog device tree node
Message-ID: <ZW22lQyLaMa9Gzrx@swlinux02>
References: <20231105231318.992857-1-chanho61.park@samsung.com>
 <CGME20231105231340epcas2p1a3aa6337906b651d5d3e1b279714df3f@epcas2p1.samsung.com>
 <20231105231318.992857-4-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231105231318.992857-4-chanho61.park@samsung.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3B4BN7J6081167
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

On Mon, Nov 06, 2023 at 08:13:17AM +0900, Chanho Park wrote:
> Adds jh7110 watchdog device tree node.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  arch/riscv/dts/jh7110.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
