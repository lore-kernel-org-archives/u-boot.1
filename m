Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93180CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 13:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1304E84AC0;
	Fri,  8 May 2026 15:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="XAHI6u6+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F04384ACF; Fri,  8 May 2026 15:28:34 +0200 (CEST)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F015D84AB9
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 15:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:2af:22b0:148a:d6e3:763d:892f])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 80FE95FFAF;
 Fri,  8 May 2026 15:28:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1778246911;
 bh=XYL/5AyGOZU3upkk7Y6ryzdHlnr26exqhbkbbeRj4mI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XAHI6u6+s1BeAgOQ8NUaZaFdrSEQcJfP50PVyNo5Gj6oBkVHcovZBwehPY+PQ1e2H
 peMwjNl8QuM9hBAcsO2fQ5AVbDadizKN8oy40fNPv7II97FYfBe32QYqeKyZeK6d+S
 C2isjb/u5diYlnz73ErdA7qsLOMuqHrz+G03DuHT0fNtvGfRaJNoYYzFT+sRW8g90m
 AHB+5CEjxUCqAVL8USXuS1i76adv5eq9cTFJGtKITqq1vNoJ3LZrhXbOA84kp6xihC
 M7kKLW/3cVj2H4cDUio2H5Do9+obTBskNIBsX9nuj5II2gXwNmydlnHCC+QMmzb7y+
 K8+V8MamEQ8+A==
Date: Fri, 8 May 2026 15:28:28 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 0/5] NBX10G: Marvell Armada 8040 Nodebox 10G board
 support
Message-ID: <af3k_MTkMUDbbsbe@L30177.local>
References: <cover.1773151972.git.vjardin@free.fr>
 <cover.1776762022.git.vjardin@free.fr>
 <a63855c7-f2b3-4b99-a5d5-6a2cd25a2a30@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63855c7-f2b3-4b99-a5d5-6a2cd25a2a30@mailbox.org>
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

> 
> Thanks. Next time, please include this revision history into the
> patches. This makes the review a bit easier. Please see here:
> 
> https://docs.u-boot.org/en/stable/develop/sending_patches.html#sending-updated-patch-versions

OK, thanks Stefan, I did miss it. I'll post a v3 later today, just in case it
is needed.

Best regards,
  Vincent
