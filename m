Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E83C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27E4A87DFF;
	Tue, 12 Mar 2024 10:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C11C187F04; Tue, 12 Mar 2024 10:51:06 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9132F87D82
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42C9oegl070922;
 Tue, 12 Mar 2024 17:50:40 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 12 Mar 2024 17:50:39 +0800
Date: Tue, 12 Mar 2024 17:50:36 +0800
From: Leo Liang <ycliang@andestech.com>
To: Kongyang Liu <seashell11234455@gmail.com>
CC: <u-boot@lists.denx.de>, Baruch Siach <baruch@tkos.co.il>, Joe Hershberger
 <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Nils Le Roux <gilbsgilbert@gmail.com>, "Ramon
 Fried" <rfried.dev@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/3] board: milkv_duo: Add init code for Milk-V Duo
 ethernet
Message-ID: <ZfAlbKQhdUiT0VgB@swlinux02>
References: <20240310055816.11575-1-seashell11234455@gmail.com>
 <20240310055816.11575-2-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240310055816.11575-2-seashell11234455@gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42C9oegl070922
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

On Sun, Mar 10, 2024 at 01:56:44PM +0800, Kongyang Liu wrote:
> Initialize register in cv1800b ethernet phy to make it compatible with
> generic phy driver
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
> 
>  board/sophgo/milkv_duo/Makefile   |  3 +-
>  board/sophgo/milkv_duo/board.c    |  4 ++
>  board/sophgo/milkv_duo/ethernet.c | 79 +++++++++++++++++++++++++++++++
>  board/sophgo/milkv_duo/ethernet.h | 11 +++++
>  drivers/net/designware.c          |  1 +
>  5 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 board/sophgo/milkv_duo/ethernet.c
>  create mode 100644 board/sophgo/milkv_duo/ethernet.h

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
