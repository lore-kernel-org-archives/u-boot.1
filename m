Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCEBCDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 13:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E79F84A0B;
	Thu, 25 Jun 2026 14:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="qnkq3R7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FEFC84704; Thu, 25 Jun 2026 14:15:06 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 549F08460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.petazzoni@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D7A151A0979
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 12:15:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AC93B5FF03
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 12:15:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 90A99106F080D; 
 Thu, 25 Jun 2026 14:15:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782389700; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7k/stPQd5jvzp94kuQysaiC17sPfeyAwkAOejWRGZyo=;
 b=qnkq3R7vPeMNjNeK0KCSfxtU9e45znrXTj1ZST36iq7pe8o293TZ3wofW48zKs0UGgvKep
 gNsLFeCKJiWJe6ZDhgIaUtWdoi/7fAdqmL6NJnUMCjIxy9BvFjwWuUjBT1q4bXib0tF6eA
 SdtyGVWiu8VxTqoNb2JwfIpdISylf+D0OMDq5t9sGlQWVMl5dN4CV1rwH7qZcSUHaGZd8H
 IWxqRQTwG9EbUCFveeeXOyqI8STzSiNtXRxEV5h/8hZl07kdenA/3vvV9xfJokaddKXlzj
 haZb10KATYSaa6aY6Zo3hAkBUAq5WnZUT0E/unZn5k1ASd9Gkw84M4jJkq+dfg==
Date: Thu, 25 Jun 2026 14:14:59 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: =?utf-8?B?Sm/Do28=?= Marcos Costa <joaomarcos.costa@bootlin.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] .mailmap: map old addresses to their up-to-date
 counterparts
Message-ID: <aj0baC8ZaOIfqbAC@windsurf>
References: <20260625120344.274592-1-joaomarcos.costa@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625120344.274592-1-joaomarcos.costa@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

On Thu, Jun 25, 2026 at 02:03:44PM +0200, João Marcos Costa wrote:
> This essentially maps @free-electrons.com to @bootlin.com addresses.

Maybe this could have mentioned that this maps only e-mail addresses
of people who are still at Bootlin. There are other commits with
@free-electrons.com e-mail addresses, but from people who are no
longer in our team (and therefore don't have a @bootlin.com address).

> Signed-off-by: João Marcos Costa <joaomarcos.costa@bootlin.com>

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com
