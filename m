Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DED1C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 07:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D8D868FC;
	Mon,  4 Sep 2023 09:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA015868D9; Mon,  4 Sep 2023 09:04:45 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 092DD86415
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 09:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38474IZR023778;
 Mon, 4 Sep 2023 15:04:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 4 Sep 2023 15:04:14 +0800
Date: Mon, 4 Sep 2023 15:03:22 +0800
From: Leo Liang <ycliang@andestech.com>
To: Chanho Park <chanho61.park@samsung.com>
CC: Rick Chen <rick@andestech.com>, <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Lukas Auer
 <lukas.auer@aisec.fraunhofer.de>
Subject: Re: [PATCH] spl: add __noreturn attribute to spl_invoke_opensbi
 function
Message-ID: <ZPWBOjFZtpe98d__@swlinux02>
References: <CGME20230829012025epcas2p1a233126199d0ec5aa2e9ca892c963b9d@epcas2p1.samsung.com>
 <20230829012014.2516535-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829012014.2516535-1-chanho61.park@samsung.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38474IZR023778
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

On Tue, Aug 29, 2023 at 10:20:14AM +0900, Chanho Park wrote:
> spl_invoke_opensbi function is not returned to SPL. Thus, we need to
> set __noreturn function attribute.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  common/spl/spl_opensbi.c | 7 ++++---
>  include/spl.h            | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
