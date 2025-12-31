Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8379EE645A
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 21:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DFB4841D2;
	Wed, 31 Dec 2025 22:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="O+MxR3TG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5D9841CC; Wed, 31 Dec 2025 22:29:05 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D84A384097
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 22:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dhNPT649Yz9tX0;
 Wed, 31 Dec 2025 22:29:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767216541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQ/8fmAd7XL7QQx/pGvrILhS1ZGkJn78TQdC+EcfWuI=;
 b=O+MxR3TGSoNIYBICDWSm1R89jYyofp8stlIc5mvQXVexKbjXri+/3Sqc6VJdlI8keC5aoc
 uabFiXT+x9YSMwB4FerVRGE9cRuJ4OlVBaZjXFOErUzvfhI6VI+E9prLmV3WWMU3iHd+p9
 FzkqShm/zU4oA+GL1UU+YA+ZU+F9gullZ/gWJe0MiZzLfqztTjMBYp9c91avdGtOds/haw
 3m3/tlUMbs2evwcn/pWKXzZUx8VgqPc7hzota3iCpiXnbKeVbUq93hK3PK2SwznRWxsfV/
 V1rs/1LuYSX9qhPlQcexYzYHR5110TvzPRI+tcpqDmv7vENB9Q5a1p1n3b1nJQ==
Message-ID: <4f35fb8a-51dc-4fd3-afbe-8f7e7f51150e@mailbox.org>
Date: Wed, 31 Dec 2025 22:20:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/3] Image size checks: Clarify help texts
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
References: <20251110091256.2422534-1-pro@denx.de>
 <20251110091256.2422534-3-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251110091256.2422534-3-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: yx6u93jpty6846rou7w3xerckapdjeu9
X-MBO-RS-ID: 2f915cca6ed64174400
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

On 11/10/25 10:12 AM, Philip Oberfichtner wrote:
> Adapt help texts for CONFIG_XXX_SIZE_LIMITs to their new logic.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
