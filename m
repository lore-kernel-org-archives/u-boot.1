Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DFEC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 08:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43DFA874CC;
	Wed, 31 Jan 2024 09:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 792B7876F4; Wed, 31 Jan 2024 09:39:26 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7989587061
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 09:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 40V8dBsP047413;
 Wed, 31 Jan 2024 16:39:11 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 31 Jan 2024 16:39:10 +0800
Date: Wed, 31 Jan 2024 16:39:07 +0800
From: Leo Liang <ycliang@andestech.com>
To: Lukasz Tekieli <tekieli.lukasz@gmail.com>
CC: <yanhong.wang@starfivetech.com>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <sjg@chromium.org>,
 <chanho61.park@samsung.com>, <frattaroli.nicolas@gmail.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] net: phy: motorcomm: configure pad drive strength
 register
Message-ID: <ZboHK5jZADscsjfY@swlinux02>
References: <20240128192248.64407-1-tekieli.lukasz@gmail.com>
 <20240128192248.64407-2-tekieli.lukasz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240128192248.64407-2-tekieli.lukasz@gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 40V8dBsP047413
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

On Sun, Jan 28, 2024 at 08:22:47PM +0100, Lukasz Tekieli wrote:
> This ports the pad drive strength register configuration which can be
> already found in the Linux driver for this PHY.
> 
> Signed-off-by: Lukasz Tekieli <tekieli.lukasz@gmail.com>
> ---
>  drivers/net/phy/motorcomm.c | 130 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
