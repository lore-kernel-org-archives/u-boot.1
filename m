Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBD1CD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59527846D3;
	Tue,  9 Jun 2026 12:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TXnRyatD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F0318466E; Tue,  9 Jun 2026 12:52:25 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3676A839A8
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gZQj13d4Zz9tZs;
 Tue,  9 Jun 2026 12:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781002341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rg4iYGIIe3P51TPQkGOXsLQxB2BtsvJEcrkLUjXD0oo=;
 b=TXnRyatDKfSHeax+Tq+FekKB31w1NEmqz39Sk8YLTPEWoGS45TjSktRuZHxANT0EUMhAIZ
 SdStadmlxKs+jjdo8tldVoBBjMWiJBuf8UjyG7VTXRLpAXJCn/0MUv+0MPazfCZwolKucl
 ajyfK8xuqqbG3qWQjjsb6Gm7QpYR+V1v+wu7c9xZuY4ydF6EJaoCOeu9svEIUc+aBn9YEs
 AgWOoyhxlVVQM/Ht62g/vfgtRf1KtZ//NjkYbHY4SYD45RKpOICFLK5r4JPs8smKB7dVG5
 b+2Q/ThWvwA109y0WVQAD8KzvgMgSWxUVJKgCyMND6y2Mr5ATlwQGd4Z8Q67og==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH] watchdog: Correct dependencies for WDT_MAX6370
Date: Tue,  9 Jun 2026 12:52:11 +0200
Message-ID: <20260609105219.1172564-2-stefan.roese@mailbox.org>
In-Reply-To: <20260317012448.4162644-1-trini@konsulko.com>
References: <20260317012448.4162644-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: bd43zdnbwdix91eg83se5z6qxe1e5e74
X-MBO-RS-ID: 03e776abc6700394ed9
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
