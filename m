Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7C1CDD0E6
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 20:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E098188FF1;
	Tue, 22 Oct 2024 22:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729628512;
	bh=Rn3weA+VxjMIYdPDgkdOPntzb8miN/Mw6jg19Lf8xKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M2NvFex7/z8LmifndeWabnxG+BGAtM7qcZYXmyTf/BZouMHD4OrqNGl9Lfvzg7uvd
	 Y7MUdAhwN2AzclS1TN9eqftSz/QBveDgPcpkauugYQ7I8SSkzxua/4IEkSDTTilG6C
	 0SLOusH/SPgLivVXGErDvBnLwF+01ATzUzBgIG8DoWrLiwCWfo3jVmJUpVdTQ4y9jv
	 kKiU6pQnkLSiS3Kq7c9iIoBpPT/3kjEe8SGgDSr0t4ss0S4GkLbFZkRrhcrZrvu5rl
	 nPTK8NUFuXMjhU0qyEOWbJlKRkZIfHkv/7K6EmA/OwhSy1HpWqhubkmzBq8jE7CBIr
	 69xK3UhzgfI7A==
Received: from crub (p5483347b.dip0.t-ipconnect.de [84.131.52.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A785188FCC;
 Tue, 22 Oct 2024 22:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729628510;
 bh=Rn3weA+VxjMIYdPDgkdOPntzb8miN/Mw6jg19Lf8xKU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=z5la8EQ808zXpfpdvyRJbjT6GicAOyD3tKCVmZizXA8EpiEQDuGmbNOTutC8HyiQc
 DZrIIfW4qkYWTLBF5Aa4ZI5DqeKIHz6iXySmx927GCmd7/PouImvG63nHRtm8xh8UW
 4FUDwwrAWW6OcdMKrDw2nayGTQYW5e+8VVtYwnSPYY/kIuIEIYpRrYUCdM/dpLdOqs
 ryP2BhWPrbch6mhiRa2t/UUc/k/Y8HllzeEXlGdK84UEajL7GIDhVRPXoBaAR/daoJ
 F2e6aoqOxUCu+Rx/n0Pq00OEfBZmCj7PVPhDnY8V575rTpAzLcru05pXuH9+hV0SQF
 QcUWWOX+Y3nJQ==
Date: Tue, 22 Oct 2024 22:21:49 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 <u-boot@lists.denx.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>
Subject: Re: [PATCH] video: Fix VNBYTES() macro comment
Message-ID: <20241022222149.07f849f7@crub>
In-Reply-To: <20240910091200.101886-1-miquel.raynal@bootlin.com>
References: <20240910091200.101886-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 10 Sep 2024 11:11:59 +0200
Miquel Raynal miquel.raynal@bootlin.com wrote:

> The VNBYTES() macro has been updated to silence possible warnings
> regarding authorized (but unusual) uses of this macro, but the comment
> was kept unchanged. A year has passed so let's fix the comment now to
> avoid confusions.
> 
> Fixes: cc05d352fbc ("video: Add parentheses around VNBYTES() macro")
> Suggested-by: Tom Rini <trini@konsulko.com>
> Link: https://lore.kernel.org/u-boot/20240906183432.GG3879073@bill-the-cat/
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/video.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

applied to u-boot-video/master, thanks!

--
Anatolij
