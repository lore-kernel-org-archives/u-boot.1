Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1828FD2F326
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 16:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A453D80433;
	Tue, 13 Jan 2026 17:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="sox4/H00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B267E808AF; Tue, 13 Jan 2026 17:15:37 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB2C80325
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 17:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 1D2471FAE9;
 Tue, 13 Jan 2026 17:15:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1768320934;
 bh=nv5b29Wyo/QLd4Byv71W0j5xZZf3kdcP6WHW9j90K64=; h=From:To:Subject;
 b=sox4/H00Q9OqMsTVEvIwF8gT/1LaQegqBZ1OQiubtK7E2jdZtNu6qGyT8UojAZ/HU
 u62OUNlELs2TiT3hj0VYaot3RtbN/8XmzCuCifWrlYpVGimQSdQzqC+S04dCvwg2GZ
 rsX+DKlgUhx3CYAVots3ePRl8eQR7ILqrPbBcmgi1bz6GIz/8/sm3mZzSc/CEYLwrt
 P6sdiCyGQ1IjrO8xAYJYSv8zE6USB2Frlwc6ZG58e0QlRV91Q507sHB1DGsjYtjsOX
 qDD/FqV23PRV1obLk1SqnVGxXqFM4P0uCFfySYidylU5L2XPzQdntf+fng35vA42Be
 YcRDUc/xy3VvQ==
Date: Tue, 13 Jan 2026 17:15:30 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: max.oss.09@gmail.com
Cc: u-boot@lists.denx.de, Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] toradex: common: handle third MAC address for SMARC i.MX95
Message-ID: <20260113161530.GA90860@francesco-nb>
References: <20260113125853.3970525-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113125853.3970525-1-max.oss.09@gmail.com>
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

On Tue, Jan 13, 2026 at 01:58:23PM +0100, max.oss.09@gmail.com wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> The toradex_smarc_imx95 board exposes three Ethernet ports.
> Set the third MAC address equal to the second MAC address.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

