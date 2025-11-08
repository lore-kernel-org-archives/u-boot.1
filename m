Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F428CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 01:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2235D83E45;
	Sat,  8 Nov 2025 02:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kuunLWfS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0970083E48; Sat,  8 Nov 2025 02:09:09 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46C8583E23
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 02:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d3HrJ2J3Cz9tCC;
 Sat,  8 Nov 2025 02:09:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762564144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjftvN32D3EHgS7kDA2n6i6Z2nwLLnWy2m0/6k5NXXw=;
 b=kuunLWfSQlXp2VZMRewkQSRssaAUGSMedDolKeE7I/+hYC+QAXD6Dhfi2GOzRnJGNpKglS
 u2QKPcOyz3X54pIozR9uiDUI/3oveMVTc5JXdHvF2Xe9wyxWIowMIlVKX/jSerbkR3SE5K
 KP6RIC1GFFxbM14SYK2jUTacYpno3BHIbe2GrEpJnl7tPBig6Ay+L0Z+kGt427/4m3mN91
 eu5n/OXW7jVivhku7QehAfpCSTXpBsSMOLu2VjFJiTyfNlTr6q4R3z7cLTNxl9u73+hWXw
 L+Yfp4fWTtTkEQF10baS6mXCOfYiVWEGc1f00A6Dn5RNKvk1kS6DovnSHFFe3w==
Message-ID: <20ca3866-29e9-42c6-9224-a33c15034b9e@mailbox.org>
Date: Sat, 8 Nov 2025 02:09:02 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] board: nxp: Rename board directory from board/freescale
 to board/nxp
To: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>
References: <20251108-nxp-v1-1-6169a1692ff4@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251108-nxp-v1-1-6169a1692ff4@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c39ea49565351650cd5
X-MBO-RS-META: bx5m9to7hxogdqugo3zkqe73pyxijdew
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

On 11/8/25 1:59 AM, alice.guo@oss.nxp.com wrote:

Hello Alice,

> This patch renames the board directory from board/freescale to
> board/nxp because NXP now provides Board Support Packages (BSPs) and
> tools for the former Freescale i.MX and other i.MX products.
> 
> All relevant references have been updated accordingly. This change does
> not affect functionality.

I'd suggest sending an updated V2 of this IMMEDIATELY after v2026.01 is 
out, so it can be applied before any other changes.

-- 
Best regards,
Marek Vasut
