Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84771CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 19:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBD4C848B4;
	Fri, 22 May 2026 21:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jeCORZVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D35848B7; Fri, 22 May 2026 21:10:42 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0EAA846D0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 21:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gMZcG0YV7z9smK;
 Fri, 22 May 2026 21:10:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779477038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AD1toVHfndUoYanXfDMpNOCakc5vds3EtgeKD6qAAG0=;
 b=jeCORZVV19h/f9bOrYvPmRJ/Y8HWIULUbkpC51bS45WZ2FljmPDlBiPW2aJm1BJd24ugAq
 3ahPWC+62M/fegFORRyX9GPaIvf9h6RV2B7Rc17mtOVVTySAFJtkxobBVFsiSPi7Sl8lu6
 gbGk6nYuR2mLA5Sky1xAuYsEgQAMT1D2efpXVwR9le+l9e1JeLavdlFkxUOxxYevcOp4m/
 dNM6nffFriLTASgMIOHMz0bjtyRJCEIrDO6aAtsKLxhMhxFlbrrJglVEWVlmjxQMYH0k40
 bJ/tTkyX46QwT2dh6ogwGEkV+9+jXSj1eL3WkUtaGnYTwdKMaDPXkJbeuGMtAw==
Message-ID: <de6a4064-c17e-4b8f-96db-50013f694936@mailbox.org>
Date: Fri, 22 May 2026 21:10:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: Replace Apple with N:
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Janne Grunau <j@jannau.net>, Mark Kettenis <kettenis@openbsd.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260521201712.43955-1-marek.vasut+renesas@mailbox.org>
 <c1fa8d82-8ca7-41bb-b90c-8bed4cebb967@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c1fa8d82-8ca7-41bb-b90c-8bed4cebb967@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5ubst3atq3f3t7umktqr7w1nm3pbg4pa
X-MBO-RS-ID: c18efebbfb933608325
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

On 5/22/26 11:37 AM, Quentin Schulz wrote:

Hello Quentin,

> Note:
> 
> """
>          N: Files and directories with regex patterns.
> [...]
>             scripts/get_maintainer.pl has different behavior for files that
>             match F: pattern and matches of N: patterns.  By default,
>             get_maintainer will not look at git log history when an F: 
> pattern
>             match occurs.  When an N: match occurs, git log history is used
>             to also notify the people that have git commit signatures.
> """
> 
> So more people may be added in Cc by get_maintainer.pl? I'm not sure 
> it's a bad thing, but it may surprise people.

TIL, I did not know that either.

I think it is up to Janne/Mark to decide whether they want this patch or 
not.

[...]
