Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456A4C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73AFE8205A;
	Tue,  1 Apr 2025 14:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743509150;
	bh=QgssjDNnB2Lncy+IwhZFhAuIhZs0DTyb+N75CuSVvLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mRIWgjyEMAPX71OzHNqyQKVF4FMn4HfFfl+pVXZOlxrwrInyBGy+pK09w4ptTp0ja
	 O4mmBJCvOaTafxJB1tyO1t94GparyjeknUDbJfAA9VCB91IyHQWICwgeqcptKivj+q
	 OiUwVoaxeGbWBKd5k1X7lQolbOxqjZ3Ssjbk7B72/yrfyWqqEkKDEhn0RzmSgLaYQu
	 c1osfqoWTSul94QosEL8+R8EOV0e2hH2PdFYc7gIW8f3LpjAco2PA39W26bq75nJUw
	 NueuISz7NfuMWoebA0soYuwf/EtV8pY6axbF87GGjWRWgGlNj/QmfdERyxY1dC4lOZ
	 wwyK3235Co2tw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3503C8209D; Tue,  1 Apr 2025 14:05:49 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F2B381FC8
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 14:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SOz0MJam"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C4D051024CEBC; 
 Tue,  1 Apr 2025 14:05:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743509145; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=QgssjDNnB2Lncy+IwhZFhAuIhZs0DTyb+N75CuSVvLA=;
 b=SOz0MJam08IyJYOLgRYHSMVz8WaEQfCDf51RLUIwo/WzpPaTE60yfKKT3u1r9harLhmB0h
 GnI1ESrsDzFdZUk0gxdB+kB11WLLCJYaryjYvaaXSJ6yFVrly4v4eGCTzJxEQQOZvnmObY
 3YeYzvfOgl0iagvwvphN95ukGfjfzguhg0umG1XBTJ0ez/Zn6sllyxAQWU3gFus4OLppUd
 iTwRIfvDr7GMWJpJUpjm/eVLIZE0k/kAsc+zMGQQaiDRYs1/u0Qxy7y1cKL/DJ3wBV2ClJ
 Eh7VpRdCy1P6OZSpKrSMBSbhTdx9wCk9xybAzCfocheU6ePHclQek++ouTS7vQ==
Message-ID: <9719ba2e-9bd6-4bd7-94a9-e5b64bb58a9b@denx.de>
Date: Tue, 1 Apr 2025 14:05:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: scmi: smt: Interrupt communication enable
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, trini@konsulko.com,
 festevam@gmail.com, sbabic@denx.de, sjg@chromium.org, seanga2@gmail.com,
 lukma@denx.de, alpernebiyasak@gmail.com
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, viorel.suman@nxp.com, ye.li@nxp.com
References: <20250401075635.3802640-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250401075635.3802640-1-alice.guo@oss.nxp.com>
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

On 4/1/25 9:56 AM, Alice Guo (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> i.MX95 System Manager uses interrupt driven communication which requires
> the caller to set Bit[0] of channel flags to 1. When transmission
> completes and the previous general purpose interrupt has been processed
> by the other core, i.MX95 System Manager will set General Purpose
> Interrupt Control Register (GCR). U-Boot polls General-purpose Status
> (GSR) to check if the operation is finished.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Marek Vasut <marex@denx.de>

Thank you !
