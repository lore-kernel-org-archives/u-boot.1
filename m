Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C419D61015
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 13:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C755883F59;
	Thu, 29 Jan 2026 14:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CNm28L7l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D01183F32; Thu, 29 Jan 2026 14:07:26 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7AD83E9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 14:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f1zvF6J5mz9tyQ;
 Thu, 29 Jan 2026 14:07:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769692041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tNbRVOaLFa7TlV5rkQnoF7E/IeUClzO3OUm17ByRT54=;
 b=CNm28L7laCFfDbPf2YSPnhMZoCMso3huiW0gZovYErEkJMplvu+WnNAnJnvuxzKqWwBoaC
 JIusP3zwV2iiCav7hACuZtpg+8OagItikNiLBp9gmOsdHcbTp09T9C+nYPQC+kCzZTpA/z
 /Q0NpC/aSpnqAjA1qc4xX0Sp17sh4yOkPuPVqRO8iejQ5KTd1QIJfTjNQQ1VTkQu/nDfhb
 utJx/M5m44jb5eR5yIJHS6CHYESEE+v+/49+FMgYoTRk/DwOUKIJR0g3hzStVjx1llu+XN
 4JjsLmG44xKjbAdAYi/cYc/EXs+ocnwBA9uQUowyVLv476PpJj+tCJq9lZBt9Q==
Message-ID: <c50be24d-1a15-42c8-937f-11f477cb45f3@mailbox.org>
Date: Thu, 29 Jan 2026 14:04:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] spi-nor: add support for XM25QH01D
To: Ssunk <ssunkkan@gmail.com>, tudor.ambarus@linaro.org,
 Miquel Raynal <miquel.raynal@bootlin.com>, trini@konsulko.com
Cc: Takahiro.Kuwano@infineon.com, jagan@amarulasolutions.com,
 pratyush@kernel.org, u-boot@lists.denx.de, vigneshr@ti.com
References: <20251110203000.9999-1-ssunkkan@gmail.com>
 <20260129121240.4052-1-ssunkkan@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260129121240.4052-1-ssunkkan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: x8itx75iwec3wmepgjbbd7hegbyijuax
X-MBO-RS-ID: 9eb22714f24e97ad9d7
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

On 1/29/26 1:12 PM, Ssunk wrote:
> Hi Marek,
> 
> Just a gentle ping on this patch below.
> Please let me know if any further changes are needed.

Adjusting the CC list slightly, this is really up to the SPI NOR 
maintainers.
