Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1595D7236B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 10:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5717083B32;
	Fri, 23 Jan 2026 11:29:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wPUhEJcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 882D383B03; Fri, 23 Jan 2026 11:29:54 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2D3F83B63
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 11:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dyDhG5byBz9t1H;
 Fri, 23 Jan 2026 11:29:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769164190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PhfP4MCdWGLi86ax5szPUkODAQBvcQ1QBOvMi55BFEQ=;
 b=wPUhEJcW9HH9IGg2c56ePdMZLbnvNjKkyKm7V+8KADuGKPyJAhdBzRivTwKQC4qno8L1UI
 wDYpmwS6+8Ht5Qi37jPBWqI9xA6hD6kXYfP7VMhk4J2cAA5EP8tvc8GuyCGFhSnCz7KNFL
 6AEttZA3OrjbYhoM4MknLWfGvysfbSKN6X+ZqEZcHJtxNAs78MhSMKOmeLRTrssPA/rzdw
 9EY2wKPXqg0XANv1H2BeDl1sywA1NOr/rTTFOARpXGc0mqLerbbld9pujcVy2Ph46qrAxH
 kJFIDakPFtzfOkhOxvu+5dAoQYhk1qHLo3bW2dCy30Y8KOlpHMZpviNjN+dpxA==
Message-ID: <aab556e9-9789-41f0-a4c8-01d48c191940@mailbox.org>
Date: Fri, 23 Jan 2026 11:29:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH RESEND] board: nxp: Rename board directory from
 board/freescale to board/nxp
To: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
References: <20260123-nxp-v1-1-91feb4312639@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260123-nxp-v1-1-91feb4312639@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6h9k7etu83jipr8348ujhf7rdi4pemxt
X-MBO-RS-ID: e3c48d675eba7bbe636
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

On 1/23/26 8:54 AM, alice.guo@oss.nxp.com wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> This patch renames the board directory from board/freescale to
> board/nxp because NXP now provides Board Support Packages (BSPs) and
> tools for the former Freescale i.MX and other i.MX products.
> 
> All relevant references have been updated accordingly. This change does
> not affect functionality.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
This should be applied for master branch ASAP, so it won't conflict with 
other patches.

Thanks !
