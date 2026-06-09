Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63F9CD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74FC48493A;
	Tue,  9 Jun 2026 12:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="T+7RUn7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C60FD84928; Tue,  9 Jun 2026 12:53:20 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5538A848D8
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gZQk60Yzfz9smD;
 Tue,  9 Jun 2026 12:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781002398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rg4iYGIIe3P51TPQkGOXsLQxB2BtsvJEcrkLUjXD0oo=;
 b=T+7RUn7YOil0o/XdQGxtHc7YKHOJl/HC4Qz+FiEfn84luWLsrMv91DHOD8Lo2zraMOcpet
 pXasbxzCS+1ni44ZKkJx52CvfA3Ey0u9ycdRpbBsBxfMYdG3qqe0jfcix25q59HfH8Push
 tWwWhHxyDSVVUCdghMo/DG+W0fpxdjRhkNzqEUc98wBLdDLOghqTZc58/xtJbrO9FOjO36
 EfhaFogPq2y9wVAzXhlLN9EnwU9RHRlvlgeKihZKuP4TYe+CANEw7x3WRRV/+ihpJz7dIt
 ZXSYZQJpwJ9CMOEn733+LuKoCHMM1Eme04/hHqCOhieN8/XEIiVjLB5bKQyLUw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH] watchdog: Correct dependencies for WDT_MAX6370
Date: Tue,  9 Jun 2026 12:53:08 +0200
Message-ID: <20260609105316.1172918-2-stefan.roese@mailbox.org>
In-Reply-To: <20260317012448.4162644-1-trini@konsulko.com>
References: <20260317012448.4162644-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: njbod6bgidoco96budcpge5jfgxp61ma
X-MBO-RS-ID: 02f36730fdc87d4576a
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

On 3/16/26 19:24, Tom Rini wrote:

> As exposed by "make randconfig", we have an issue with the dependencies
> for WDT_MAX6370. It needs to select both GPIO and DM_GPIO not just
> DM_GPIO.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot-watchdog/next

Thanks,
Stefan
