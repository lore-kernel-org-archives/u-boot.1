Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631F7CD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B22D0848BC;
	Tue,  9 Jun 2026 12:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="W+u8ipg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C1D284928; Tue,  9 Jun 2026 12:53:21 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE81B84878
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gZQk74Srvz9smD;
 Tue,  9 Jun 2026 12:53:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781002399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moaO0g8iOdVlZ5ghmDqGIc5rCMFdDgGAVHgKsIGx8yc=;
 b=W+u8ipg3NvLwQUpLK3MTrUbMI8I2ms83JrakVVEuRBnJvge23xrR6SKGu4iGcQBi5ia+oJ
 RM4Dg5Zo5OsAW2OZLHoKEMcp1fndTd58wMJ5XZByZVETTFfGvFh5HCrt1usNXcFTTVjUMz
 LDVmTPy8gFkSbVX6vIrj5t8FP1v9Lq0F1He7C3khG5sFNqyKH6qb2g7Jh0uHO6Pg6NRTES
 RgflAIj3Q49+xkxkGfHA0WJnWFaOn4w8aBEgB1Vizcuqi+kZEUPmUl+ksyMKR9E6EEc9ol
 WB/7scib4M89HG80vRPr9hsEu8am7awEImfwkqA5ftaPDD5mLSG3Uuy4G7pLMw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH RESEND] watchdog: sbsa_gwdt: clamp WOR value to hw max
Date: Tue,  9 Jun 2026 12:53:10 +0200
Message-ID: <20260609105316.1172918-4-stefan.roese@mailbox.org>
In-Reply-To: <20260504-fix-sbsa-timeout-overflow-v1-1-87de9b44112f@nokia.com>
References: <20260504-fix-sbsa-timeout-overflow-v1-1-87de9b44112f@nokia.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 492f240041243e29e46
X-MBO-RS-META: cjphz8ajxik5z5pjsxib9qyauxcsazy6
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
