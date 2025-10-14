Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993D3CCD18E
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 08:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7D91807C0;
	Tue, 14 Oct 2025 10:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="F+DicICm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C66D8206E; Tue, 14 Oct 2025 10:54:02 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 650B980422
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 10:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cm7LG3K03z9tNq;
 Tue, 14 Oct 2025 10:53:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760432038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCS6O2b3Rys7WDLQQKvEF4z8bmMPCrINOBo3K3QA4J0=;
 b=F+DicICmjfh9hoC8lzvdjdeKvNKvt1LYX+TG7vy5K8Gpr/I+do8+Zg5JhtFEgR4OKf2VA+
 0CwgHW3v+YSgkhU07x16ofN7aJiB6FeInX00Njgy4CKbGaWqFXzBvsa3r9Ec415IBvBiHb
 bot0XHp6pXfG4yeoaB+n9g7ZP2xcJvCKRJb/wVBUVaHCuys3rcyhi0vxTxsNoDfyHODck6
 7nZ61FzobLASCuH1DByH35oE4sIXu7vIrXd0ODYlrctaWoRk/alYhGP/1JTO8sF8CAicaW
 phne4EpmAb1h5Pr47uLcE9hCVbpoInEbEYO9zkaZ3SNS4Mvowpq2A3nh3NmPhg==
Message-ID: <33e71c50-9532-4582-aa46-458e5c52e84f@mailbox.org>
Date: Tue, 14 Oct 2025 10:53:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] mmc: octeontx_hsmmc: Fix two Smatch issues
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250731-octeontx_hsmmc-v1-0-440c5f963e09@linaro.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250731-octeontx_hsmmc-v1-0-440c5f963e09@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5e27fca4700c6396ea6
X-MBO-RS-META: c3okpuqdmtbefjnsnuegp5ihbr1x6qrr
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

On 7/31/25 12:51, Andrew Goodbody wrote:
> Smatch reported two issues. Firstly that an expression probably needed
> parenthesis to be correctly interpreted. Secondly that two unsigned
> fields in a struct were both being tested for being less than 0.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Andrew Goodbody (2):
>        mmc: octeontx_hsmmc: Need parens in expression
>        mmc: octeontx_hsmmc: Remove impossible test
> 
>   drivers/mmc/octeontx_hsmmc.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Applied to u-boot-marvell/master

Thanks,
Stefan

