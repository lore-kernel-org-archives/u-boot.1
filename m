Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF67D73EB0
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 02:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DAD5841C2;
	Fri, 30 Jan 2026 03:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="t723dkZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1E26840DF; Fri, 30 Jan 2026 03:15:49 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA4E48419C
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 03:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f2KNx5gq0z9txv;
 Fri, 30 Jan 2026 03:15:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769739345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WzTe+FfEeJTHXlRQSczNi4h/CAiVE5xq2r2OgalZgL8=;
 b=t723dkZKuHnVeBhAhPm8YkmFUo0fonzwKohk2Mekj8eeztAMJ7dtV8+py405r2D0OKsAfe
 BhN957uxxAfnc5mykyl4N3J2msZV9/mo5I1vNOhfb0Y5pHEhF9Id5VMEKdtVzAFkRdKwg4
 BFW/WRuTgqWplvlKlwFqtxhDtaUCag/sO+o4HIg8xhw9KQ76EV+CGTdVW3ihQR5NOgTI5n
 0yRvTfp9gSa+rAdwteo1SBEDO+sSYqBL+vIQ4b1P6Y+A702e3FVxOORgA87FCZk3BIO+ZC
 NR19uu3FAQq3bL0RGKzafo0AN3aXGIje/FNVZg9X4aYgykSRdXwj/XZB3dFncQ==
Message-ID: <f6816278-8d10-4711-a297-c69f65097d67@mailbox.org>
Date: Fri, 30 Jan 2026 02:30:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 5/6] usb: eth: asix88179: Refactor ax88179_eth_recv() to
 closer match Linux
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de
References: <20260130002941.2336252-1-jonas@kwiboo.se>
 <20260130002941.2336252-6-jonas@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260130002941.2336252-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: dae7e4b13db74bbacc4
X-MBO-RS-META: 1mnf49kre4re6bzximp1hqiw7eetuo78
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

On 1/30/26 1:29 AM, Jonas Karlman wrote:
> Refactor ax88179_eth_recv() to closer match the Linux ASIX AX88xxx
> driver variant.
> 
> This change has a minor intended functional change, e.g. it enforces
> that packets flagged as DROP or CRC_ERR is fully skipped.
Can that functional change be a separate patch ? I think it can, since 
it is only a bit of new code at the end of the function. If it can, 
please split the refactoring from new functionality.
