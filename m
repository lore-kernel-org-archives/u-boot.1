Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2C6FF5104
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 15:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19E068404A;
	Tue,  7 Apr 2026 17:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UujLKxm+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 602C68405F; Tue,  7 Apr 2026 17:09:35 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7365C83F75
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 17:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fqqNr127Lz9vCb;
 Tue,  7 Apr 2026 17:09:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775574572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1UCTazkD6PSoAaw/qjxEWbz6265afiF4XLZS2DSvDc=;
 b=UujLKxm+QC7m/cs9bVHL72MyBLYjbc3vThY+wef3H0fRHcA3lomAS+TG083xM6evpdWZWl
 Wjqmv/Uoyzg4uvXIZ2glqKItMbKOZksJzahLuXc1OgIv38pv86DjZ57dgOcHEJQlKeaOZq
 KANqeFZq13ikNJUJoPZ/1yAD7je5GiUgkMQ/GahoZAtNGQSBIuPBdjtiElpjmmV0zl5qcm
 yhLvYQlwBn7pxVY00ZZR035QHNya3XYZh4VoEjbI6pfyV1mK2yLABVnG6Xw5mzu36cSjXU
 vj9uhoCOyWaQMeobSOsI6Z7uWrHkeQKTlDGkMX9vUq7SoS5WDImdnNhGBeIGWg==
Message-ID: <c9fc91c4-5af2-4242-986c-cd2bdddd83a7@mailbox.org>
Date: Tue, 7 Apr 2026 12:57:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drivers: ddr: imx: Fix Kconfig for SAVED_DRAM_TIMING_BASE
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, u-boot@lists.denx.de
Cc: simona.toaca@nxp.com, viorel.suman@nxp.com, ye.li@nxp.com
References: <20260407074717.2288035-1-simona.toaca@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260407074717.2288035-1-simona.toaca@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 576feb6fcb7087e2445
X-MBO-RS-META: q3ejbsb3345mcowhu8nbr6bwusbpnjuh
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

On 4/7/26 9:47 AM, Simona Toaca (OSS) wrote:
> From: Simona Toaca <simona.toaca@nxp.com>
> 
> The 'default' directive should be before 'help'.
> 
> Signed-off-by: Simona Toaca <simona.toaca@nxp.com>

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
