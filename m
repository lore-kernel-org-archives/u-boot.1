Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8265F4198B
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 11:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 401BA83B99;
	Wed, 15 Apr 2026 13:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="HXkGjWdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C0F683B99; Wed, 15 Apr 2026 13:34:07 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B8680086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 13:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3E3DA111FDE; Wed, 15 Apr 2026 13:34:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1776252844;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=x2BTvdBOuTpr0uDA/RLPClTi+DJctDAWkCXmFJ7+R84=;
 b=HXkGjWdDLuvvR82iYwM/Cs8hfaLgJDJs1v/WIdnGqVCQoJM8QTOegqiy0G5RLn+82z47ZM
 Y9b1H3jLlWXnCWg7oMm7NcQyG9FBu4fq80DBlRHfUwHXloUHDsYZyYFKuoqlSD3Lk3ujFN
 cwXvUFVM8/w4txMwEH3SJK+21+D83sx5okCbNLRJDZSz7+6w+8AYWwA1FidTv+HS+uum9R
 CQMNap3cuejnxFGiUm6JfLt4p61YxIHJ2FPoSnrg7yTT3TxgtaXTIksRnDp9QL12HkfMKf
 NVtRXWEmfmSlfrFTBCtzGQOlZd43ZWq2LcprbueUVpLbKcSpmu3I2dksgWHIgA==
Message-ID: <7e1e9138-38f9-4e66-8569-3c24129869c8@nabladev.com>
Date: Wed, 15 Apr 2026 13:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] board: dhelectronics: imx: Use second Ethernet MAC
 also from fuse
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20260415101257.23154-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260415101257.23154-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/15/26 12:12 PM, Christoph Niedermaier wrote:
> Currently, the board specific code evaluates only the first Ethernet
> MAC address fuse, regardless of whether the first or second MAC
> address is requested. When the function for determine the second
> Ethernet MAC address is looking for the fused MAC address, it only
> reads the first MAC address fuse and increment it by one to set
> the second Ethernet MAC address. That is not the expected behavior
> when two MAC addresses are fused, because this causes the second
> fused MAC address to be ignored. Change this so that the second
> fused MAC address will be used.
Reviewed-by: Marek Vasut <marex@nabladev.com>

Thanks
