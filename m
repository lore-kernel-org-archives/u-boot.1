Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC306CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E69E848D8;
	Wed, 10 Jun 2026 14:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BzUqEc8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC354848BC; Wed, 10 Jun 2026 14:21:39 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F328C8489F
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gb4dV2Jg2z9v0n;
 Wed, 10 Jun 2026 14:21:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oChDWePIs4rHXib469xZMIUi6nS9zWrjRK+GZf16m9Y=;
 b=BzUqEc8s073rXuheumLLVG1D5EDmH/I4HoUSBZLDqvYABfOfkuEEwXTGWnJRiokv2WhLb2
 4K1XNKA51uGn9LXsFZZSs44D/MFXH/bJiVmEa2LQRTMamLS1RHhgcHzYg1hNC+rt6VD5zX
 tst0Vrgs3fj4Bnjt0EbnfP6f/oWRoZHl/910XFkPJ26S5yKa8/3DyHibrAhQ8zJSAR0qa8
 MbRmNdocZx4fbJbAQOWoIPL0CXU6eBpOcVrsvyIN2jthXQpkn9S+Fwxf5g31PNLLiS8nOO
 vk6coroAjFiN6Jd5MwUHBDnWA3YM92JSt2eK07RdxbS2woXVKQuZvObMNemspw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm: kirkwood: Remove unnecessary watchdog GPIO for ZyXEL
 NSA325 board
Date: Wed, 10 Jun 2026 14:21:17 +0200
Message-ID: <20260610122132.2674311-1-stefan.roese@mailbox.org>
In-Reply-To: <20251210222754.23535-1-mibodhi@gmail.com>
References: <20251210222754.23535-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: s7z4taqhjisc6getx5occ4657mfueun3
X-MBO-RS-ID: 477d4807540fab68ebc
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

On 12/10/25 14:27, Tony Dinh wrote:

> Watchdog was already disabled in board/zyxel/nsa325/kwbimage.cfg.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Applied to u-boot-marvell/next

Thanks,
Stefan
