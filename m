Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A688C25B10
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 14:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7D7588AEB;
	Wed,  1 May 2024 16:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C12B88B04; Wed,  1 May 2024 16:28:41 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1630488690
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 16:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 441ES5kE006115;
 Wed, 1 May 2024 22:28:05 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 1 May 2024 22:28:03 +0800
Date: Wed, 1 May 2024 22:28:00 +0800
From: Leo Liang <ycliang@andestech.com>
To: Kongyang Liu <seashell11234455@gmail.com>
CC: <u-boot@lists.denx.de>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Hai Pham <hai.pham.ud@renesas.com>, Igor Prusov <IVPrusov@sberdevices.ru>,
 Jagan Teki <jagan@amarulasolutions.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Martin Kurbanov
 <mmkurbanov@sberdevices.ru>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, William Zhang <william.zhang@broadcom.com>
Subject: Re: [PATCH 1/3] spi: cv1800b: Add spi nor flash controller driver
 for cv1800b SoC
Message-ID: <ZjJRcAo7eEM197Nm@swlinux02>
References: <20240420070923.9154-1-seashell11234455@gmail.com>
 <20240420070923.9154-2-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240420070923.9154-2-seashell11234455@gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 441ES5kE006115
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

On Sat, Apr 20, 2024 at 03:08:23PM +0800, Kongyang Liu wrote:
> Add spi nor flash controller driver for cv1800b SoC
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
> 
>  drivers/spi/Kconfig        |   8 +
>  drivers/spi/Makefile       |   1 +
>  drivers/spi/cv1800b_spif.c | 321 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 330 insertions(+)
>  create mode 100644 drivers/spi/cv1800b_spif.c

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
