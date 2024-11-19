Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B948CD44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C9D895C1;
	Tue, 19 Nov 2024 14:22:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nwl.cc header.i=@nwl.cc header.b="Pl/hvIre";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C6EF89555; Tue, 19 Nov 2024 14:22:31 +0100 (CET)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A34D895B0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=phil@nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
 s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZHr/93F1owqgGIzfHpeN611splNbxFDDunY/ZD50Gis=; b=Pl/hvIre+yUmSwQZ5ZeFwjpMG3
 oMmA0wzauCCuz6DwrdCUZcg4eo36VFUjvFKzv6h3ihOSS0JUoqW79z5tQsk+MIt+u9G9XOdsFycqk
 0UU88/o/PY1PiJOhFrA1DT2/y626zhcbsbbL+2Hk15YwKIw+TvC4XtpVR34MM1d7BDgilQTvevTHh
 dXoWoATRlkFN5vDgW+dOWxGIJs9Xblar06OU9YS0FjSHGZgFPyrwmdTme6PftqcU94/tDsrDgdd7o
 A2/z1C0FHv5uoRNnrD6tFKcbwarCwF/m/vqE5xEqgcRRqL3IiHuetK11OFlZYStkmt8Q+WMaYpX5Z
 7W7BIe9g==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
 (envelope-from <phil@nwl.cc>) id 1tDOBU-000000001DX-3Kuu;
 Tue, 19 Nov 2024 14:22:24 +0100
Date: Tue, 19 Nov 2024 14:22:24 +0100
From: Phil Sutter <phil@nwl.cc>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Stefan Roese <sr@denx.de>, Dave Purdy <david.c.purdy@gmail.com>,
 Evgeni Dobrev <evgeni@studio-punkt.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Siddarth Gore <gores@marvell.com>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] arm: mvebu: Disable JFFS2 support for Kirkwood and
 Armada XP boards
Message-ID: <ZzyREGE8UDgAZgFf@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Tony Dinh <mibodhi@gmail.com>,
 Stefan Roese <sr@denx.de>, Dave Purdy <david.c.purdy@gmail.com>,
 Evgeni Dobrev <evgeni@studio-punkt.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Siddarth Gore <gores@marvell.com>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241118193459.10687-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118193459.10687-1-mibodhi@gmail.com>
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

On Mon, Nov 18, 2024 at 11:34:59AM -0800, Tony Dinh wrote:
> These boards don't use JFFS2 file system for booting so remove it.
> 
> Ref: https://lore.kernel.org/u-boot/20241114233005.GN3600562@bill-the-cat/T/#t
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

For DS414 at least:

Acked-by: Phil Sutter <phil@nwl.cc>

Thanks, Phil
