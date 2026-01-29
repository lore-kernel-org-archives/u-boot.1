Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50868D61015
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 13:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1273183EF9;
	Thu, 29 Jan 2026 14:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="U9Fwwltf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93ACA83FAD; Thu, 29 Jan 2026 14:07:28 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C581A83E9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 14:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f1zvJ4LY2z9tg2;
 Thu, 29 Jan 2026 14:07:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769692044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XHWO8EufuAlIzLGaRNx06yjwC2aS51FvrlplRoY1Y2s=;
 b=U9Fwwltf0lRv2O6tFnrRd6NRSRlKBRhZeA7guQG4jycZDIGR5oHEdNy8ehMrK9A/2CV5U9
 0cXOmKaoXGCkp9QLsFvyUXe+p66X7oL9smKNI94ohKYw9E+R9NU2X5/4XPGmpX31cu2LO0
 ecuWuyDyQmG7oGXzil2D7m2eYdPN0lIhYRW9QkAf/mwcoVqlezFTxlSlxtXwxzQK5A5Ym9
 sQTgyIchU/A4wBxVXFlgL4H7fsqCgwBJql+aCcER9+XoX4kBkjFnRwNYE7CC4kgabUyGp9
 78yrd3e4t2xOffUkWeoMrzLzXFysO7BqfYEyQu1/54lM3zJYTHvSV9UEbVZz9Q==
Message-ID: <ffa73731-69eb-4b15-b017-49e49b2f9cfd@mailbox.org>
Date: Thu, 29 Jan 2026 14:05:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] spi-nor: add support for XM25QH01D
To: Ssunk <ssunkkan@gmail.com>, trini@konsulko.com, tudor.ambarus@linaro.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Takahiro.Kuwano@infineon.com, jagan@amarulasolutions.com,
 pratyush@kernel.org, u-boot@lists.denx.de, vigneshr@ti.com
References: <20251102112018.5334-1-ssunkkan@gmail.com>
 <20260129122606.4183-1-ssunkkan@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260129122606.4183-1-ssunkkan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 431ff638538ac5a0e0c
X-MBO-RS-META: jpfdw8ipjwxr4q8efdnqff76s41a1bkd
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

On 1/29/26 1:26 PM, Ssunk wrote:
> Hi all,
> 
> Just a gentle ping on this patch below.
> Please let me know if any further changes are needed.
Adjusting the CC list slightly, this is really up to the SPI NOR 
maintainers.
