Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA880FC5904
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 07:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF01783C54;
	Thu, 26 Feb 2026 08:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="PB2+H3h9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B3683D1A; Thu, 26 Feb 2026 08:05:10 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8421483AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 08:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 507321FAF8;
 Thu, 26 Feb 2026 08:05:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1772089506;
 bh=gJ5jDBnwRZUqtfYb44Sq7zpwiLuzQ48QNl5gHXB0Vrg=; h=From:To:Subject;
 b=PB2+H3h96K1pIFN0wtkiQGleGJpDZVOkT4hFxCX0N8xFL9ioHV7EFvrf22rGvH+1V
 HxbBNxz/JqD23i+Q6iVmxeFa8AQ3B2mSGs84eL7xKDuROLoAMkx6/JszP1KEphPBqj
 jGd3F6ATpGK2N0QAPTHNjcxLF+y4HYpOoOyIqzYvLO4+NtO0UDjvcqtDEnug0BV/H7
 SScJXdmHA/UgmO8kVItzd1KFHFyjUcu9Xn30oH7jqdx0BPi6KdWYPe0+g538ui3DAx
 u807C7ym6NtJRKn++sIZBX8VI6cRvOctV9Daek8ffd2ML5bOp6movqbfPKVh8jSgAo
 rtbeDmy60679Q==
Date: Thu, 26 Feb 2026 08:05:02 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: trini@konsulko.com, Stefan Eichenberger <eichest@gmail.com>
Cc: stefan.eichenberger@toradex.com, s-k6@ti.com, w.egorov@phytec.de,
 n-francis@ti.com, emanuele.ghidoli@toradex.com,
 francesco.dolcini@toradex.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
Message-ID: <20260226070502.GA6701@francesco-nb>
References: <20250314100734.23777-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314100734.23777-1-eichest@gmail.com>
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

Hello Tom,

On Fri, Mar 14, 2025 at 11:06:49AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The get_ram_size() function fails to restore the original RAM data when
> the data cache is enabled. This issue was observed on an AM625 R5 SPL
> with 512MB of RAM and is a regression that became visible with
> commit bc07851897bd ("board: ti: Pull redundant DDR functions to a common
> location and Fixup DDR size when ECC is enabled").
> 
> Observed boot failure messages:
>   Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
>   Authentication passed
>   Starting ATF on ARM64 core...
> 
> The system then hangs. This indicates that without a data cache flush,
> data in the cache is not coherent with RAM, preventing the system from
> booting. This was verified by printing the content of this address when
> the issue occurs.
> 
> Add a data cache flush after each restore operation to resolve this
> issue.
> 
> Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common location and Fixup DDR size when ECC is enabled")
> Fixes: 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size() when cache is enabled")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Tom, can we merge this?
This is the last bit to solve the regression reported here,
https://lore.kernel.org/all/20260224152405.GD340942@francesco-nb/

Thanks,
Francesco

