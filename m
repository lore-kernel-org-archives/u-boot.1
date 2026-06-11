Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF69CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 23:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F8BF838BB;
	Fri, 12 Jun 2026 01:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DsbHDZE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B063D839A8; Fri, 12 Jun 2026 01:55:53 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1664F8056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 01:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gc0056hZGz9v6M;
 Fri, 12 Jun 2026 01:55:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781222150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uA8dITHfyg8xtPPnX9+uHx3REqWcIyPmc1AECA4Uzjk=;
 b=DsbHDZE9qP/SRp3GVsYV1T7UyeiEDWL/qnpHKED59qC0cXNZ0hfrhhd4jQYBEXf7r4B5cb
 JAdqsM9LpCYXcHOGiQTOSWoJiLCCynMGWcdMqlhUvgAI8Wu7LmfoQGJA8as6sHq4pQzOM/
 zzBn8BZSmAhQvuim6PBjWe14PN7JkKc6LPMBYNW0B7OJmOf7pKIRcPzYyHU0QmzRtERMrk
 L4+2WObKx9fqpyTMwcLM+6wT8DakQe0J1ni9MYP3RKl65QxJA0TZuXA6VmNhLvfavC3FSo
 4FKcbEtFJwezS6bknfyq38WzIIoWb4xQnKO2zSRJEuqI3ezyN/h28eYPRWsY2g==
Message-ID: <9924cd04-b312-4196-b394-1aa8a44aead6@mailbox.org>
Date: Thu, 11 Jun 2026 16:50:30 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Makefile: let 'make clean' remove files created by
 DEVICE_TREE_DEBUG
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20260611140857.1522036-1-rv@rasmusvillemoes.dk>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260611140857.1522036-1-rv@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: euxmushdom9iy8bce37i4hgq6szdny5x
X-MBO-RS-ID: 1c80885a63c813879d0
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

On 6/11/26 4:08 PM, Rasmus Villemoes wrote:
> Originally, 'make DEVICE_TREE_DEBUG=1' only generated extra output on
> the console. But since 6cdd7597a2f ("kbuild: Produce diff between base
> DT and U-Boot augmented DT if DEVICE_TREE_DEBUG=1"), that has also
> left behind lots of files that clutter the repo and are hard to get
> rid of manually.
> 
> Make sure that a 'make clean' will remove those files, and add them to
> .gitignore.
> 
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> ---
>   .gitignore | 3 +++
>   Makefile   | 1 +
>   2 files changed, 4 insertions(+)

This is nice, thank you.

> diff --git a/.gitignore b/.gitignore
> index d57d3be0291..0e09715cc60 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -16,6 +16,9 @@
>   *.dtb
>   *.dtbo
>   *.dtb.S
> +*.dtb.clean.dts
> +*.dtb.diff
> +*.dtb.full.dts
Would it make sense to simply change this to *.dtb.* ? Or do you think 
that is too much ?
