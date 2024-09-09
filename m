Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACA6CE7AB0
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 07:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2780C88D64;
	Mon,  9 Sep 2024 09:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401E188D69; Mon,  9 Sep 2024 09:49:44 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1372988D0F
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 09:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 4897nKkp034445
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 9 Sep 2024 15:49:20 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:49:21 +0800
Date: Mon, 9 Sep 2024 15:49:19 +0800
From: Leo Liang <ycliang@andestech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
CC: <ryan_chen@aspeedtech.com>, <chiawei_wang@aspeedtech.com>,
 <BMC-SW@aspeedtech.com>, <joel@jms.id.au>, <joe.hershberger@ni.com>,
 <rfried.dev@gmail.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <kobedylan@gmail.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] net: ftgmac100: Fixed NC-SI PHY device cannot get
Message-ID: <Zt6of6BJRTLN8crv@swlinux02>
References: <20240628071445.1059016-1-jacky_chou@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240628071445.1059016-1-jacky_chou@aspeedtech.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4897nKkp034445
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

On Fri, Jun 28, 2024 at 03:14:45PM +0800, Jacky Chou wrote:
> The NC-SI interface does not need the MDIO bus and the
> NC-SI PHY device cannot get from dm_eth_phy_connect.
> Therefore, use phy_connect directly here.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/ftgmac100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Leo Yu-Chi Liang <ycliang@andestech.com>
