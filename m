Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D2BCD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB728495C;
	Tue,  9 Jun 2026 12:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MStkvC/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2896384949; Tue,  9 Jun 2026 12:53:25 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F1CF84911
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gZQkC1B5jz9v9V;
 Tue,  9 Jun 2026 12:53:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781002403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jjU+6TIIkONzlPH7XznG8ep/kFd/hsN/v/Z8wxZTlL8=;
 b=MStkvC/hfWKdxQ5j5DXx3mYg9z9ADK9X/Tftj6hFCrL5VPn46xP7V79ODUm70ml3a+7Vkn
 /hZUsY3lBNqKC1yPngIrHYauN3polvR193oJFSL1wyGgNX5f5YZNsRGqEnIA751jqQ2iLN
 rBsRg7yyRuWD0R6oVVHX49hdDAiM5z2P+z7lJMU7BvrAgWx1zEiwZZgBP1y1r9Iqt1H/sw
 oCg7UZMdEc/TjUXVTRwvYDAOyJC81cYYrnv1KY6Gq3YCWBtWgnYUGUiU5O6yIYhEdzNatP
 u7wMRFbTvXPfKb8iEuWiopWDWF2dXqOW8NGw/ffr8sdzyWF9TGs5+XXYgc4RWA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] watchdog: mpc8xxx_wdt: Use dev_remap_addr()
Date: Tue,  9 Jun 2026 12:53:15 +0200
Message-ID: <20260609105316.1172918-9-stefan.roese@mailbox.org>
In-Reply-To: <20260525-devfdt-wdog-v1-3-d8142b674ba0@nxp.com>
References: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
 <20260525-devfdt-wdog-v1-3-d8142b674ba0@nxp.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f5953463cbe47d5b226
X-MBO-RS-META: 3s1784gkhcxu1s8g9f7syid4nfso5hjb
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

On 5/25/26 11:51, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> Use dev_remap_addr() to replace devfdt_remap_addr which supports both live
> device tree and flat DT backends, avoiding direct dependency on
> devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied to u-boot-watchdog/next

Thanks,
Stefan
