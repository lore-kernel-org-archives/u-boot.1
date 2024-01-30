Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87466C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 13:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D86BC87B05;
	Tue, 30 Jan 2024 14:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="W8VlrxA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C77B587D7E; Tue, 30 Jan 2024 14:42:11 +0100 (CET)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EC08798B
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 14:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0AMbWbXj3DtgXScfjEH27EYSNrlk9hdEJkDVe+bS3UU=; b=W8VlrxA043fLppS1Ib2qtq50D8
 bGxYFQezL/ogztl4w3mxYCZBl8xeKG+9L/RU9mSK4nxMkBZP8p8w2rmCRc6DivVEUpRvC3qim5W3n
 m7LZ8M7bDFxV31aUXmJeFiyy8on0vJhBa7mjdCnpvo1rlVE2H8uwnFf6+AtqvucLB9MtFr1JnrTvG
 E112uoS/9VpnrptijX7aGt5OHNIv3b1XVwE5z0nmkHmPLdF3WtuMZhT/1Gt8Cafeu5DYXRPNAlBCS
 O31iVWAWllyCq+rxk2wKAPvQY1rrI3IQcWABLhYemO/zDOH/DFh8pCCNpd6FfQ6lOpMAn0dUUAOlb
 VNV+bL7A==;
Received: from [89.212.21.243] (port=60014 helo=[192.168.69.116])
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1rUoNK-00AIGN-2P;
 Tue, 30 Jan 2024 14:42:06 +0100
Message-ID: <b0dfa219-7946-4328-9518-591f87f1dc3c@norik.com>
Date: Tue, 30 Jan 2024 14:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] board: phytec: phycore-imx93: Add
 phyBOARD-Segin-i.MX93 support
Content-Language: en-US
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>, Yannic Moog <Y.Moog@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <20240125164503.32097-1-othacehe@gnu.org>
 <9f20708a-eefb-4a27-a413-8a9f5a472788@norik.com> <878r472m2n.fsf@gmail.com>
 <99d704dc-8133-45e1-a346-ab1d05d5fb7b@norik.com> <874jev2dgp.fsf@gmail.com>
 <21b0d615-e5fd-4f44-aea3-ee4236ff9a0c@norik.com> <87h6iv3pta.fsf@gmail.com>
From: Primoz Fiser <primoz.fiser@norik.com>
Organization: Norik systems d.o.o.
In-Reply-To: <87h6iv3pta.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Hi Mathieu,

On 30. 01. 24 14:37, Mathieu Othacehe wrote:
> 
>> I am based on latest master 6faba41927bd (tag: v2024.04-rc1)
> 
> That was it. I rebased from 043ca8c8a9b to 6faba41927bd and I now have
> the same behaviour as you. I cannot find which commit fixed the
> situation in that interval though.
> 
> Preparing the v4,

OK, great.

Can you maybe test my patch:

https://patchwork.ozlabs.org/project/uboot/patch/20240130124337.497748-1-primoz.fiser@norik.com/

And see if it fixes Ethernet on the board?

BR,
Primoz

