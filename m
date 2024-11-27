Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078F8D6ACC3
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 11:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 923B58968A;
	Wed, 27 Nov 2024 12:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C7CC896F0; Wed, 27 Nov 2024 12:56:55 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4831089680
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 12:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 4ARBujhO002314
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 27 Nov 2024 19:56:45 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Nov
 2024 19:56:46 +0800
Date: Wed, 27 Nov 2024 19:56:43 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yuri Zaporozhets <yuriz@vodafonemail.de>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH] configs: enable CONFIG_PCI_REGION_MULTI_ENTRY=y in
 sifive_unmatched_defconfig
Message-ID: <Z0cI-9BJFj_y0ykI@swlinux02>
References: <20241119205959.13579-1-yuriz@vodafonemail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119205959.13579-1-yuriz@vodafonemail.de>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4ARBujhO002314
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

On Tue, Nov 19, 2024 at 09:59:59PM +0100, Yuri Zaporozhets wrote:
> Currently, the PCI subsystem selects the small "region 2" (which starts at 0x7000000)
> as bus_addr/phys_addr. As a consequence, the BAR0 on PCIe video card cannot be initialized,
> because it simply doesn't fit into 0x1000000 bytes size of "region 2".
> 
> U-Boot should use "region 1" instead (the one which starts at 0x60090000), because
> it has much bigger size (0xFF70000), and easily accomodates BAR0 of the video card.
> Linux kernel also uses 0x60090000 as bus_start/phys_start.
> 
> Signed-off-by: Yuri Zaporozhets <yuriz@vodafonemail.de>
> ---
>  configs/sifive_unmatched_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
