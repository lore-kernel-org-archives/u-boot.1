Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA363CD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A56283FEC;
	Tue,  9 Jun 2026 12:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="h8EZACc4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3D584704; Tue,  9 Jun 2026 12:52:26 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 864E28405A
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gZQj26FJXz9ttb;
 Tue,  9 Jun 2026 12:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781002342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moaO0g8iOdVlZ5ghmDqGIc5rCMFdDgGAVHgKsIGx8yc=;
 b=h8EZACc4tZUCfYI9d/S9LP4Co+nf50rw9uFd7efTF8RRfsnaabrJJ89NY8dQ6sbJNL+/cD
 YxL6JHK2Gn9oBkSAiVMZnqqw49MUbz0c/j35ETpBTGCqndeoZQYWRd0rWdgv/V1nTraxYn
 JTD4PDizF7LzVpyNulnQBdgAbWuCeoibC5sCfzhPniTY7FKvt0pGsqUQQGUHxGiTsvH1YE
 O0shvyozRTma8Fg2IsGYcBHMHccLyMDd+aAMRX0c2wgCNkboYPasGd+BJRugzSgC24Vp87
 KtHXbtCKijlO8EQM3dCrmovVBUMpnkkQyEJKaWrZsheujF/0HkTFzb/LHiC3Nw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH RESEND] watchdog: sbsa_gwdt: clamp WOR value to hw max
Date: Tue,  9 Jun 2026 12:52:13 +0200
Message-ID: <20260609105219.1172564-4-stefan.roese@mailbox.org>
In-Reply-To: <20260504-fix-sbsa-timeout-overflow-v1-1-87de9b44112f@nokia.com>
References: <20260504-fix-sbsa-timeout-overflow-v1-1-87de9b44112f@nokia.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: msac4p4rjjcuxwi93z3xhrpij355717f
X-MBO-RS-ID: a3a0e0d1dde06c39bd8
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

On 5/4/26 12:34, Juuso Rinta wrote:

> The WOR register is 32 bits, so any tick count exceeding U32_MAX is
> truncated by writel(). A large requested timeout can wrap to a small
> value causing the watchdog to fire sooner than requested.
>
> Clamp the calculated value to U32_MAX prior to writing the register so
> over-large requests will be set to the maximum timeout value.
>
> Found by code review.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/next

Thanks,
Stefan
