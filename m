Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C129CD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 14:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E8CC8485F;
	Tue,  2 Jun 2026 16:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="J5DC9pCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5BE84855; Tue,  2 Jun 2026 16:17:21 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D418684855
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 16:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gVCZk0nx3z9vS5;
 Tue,  2 Jun 2026 16:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780409838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+nkOMdb1sI+PdW3/qE2BzYc5XppWCG1LaztO3T+Lbg=;
 b=J5DC9pCd2/Aj4J6VOa1/qIGXNhpit82Z7O6/AssrxnVsj/sfGBVIJjZSbkgdZTIN6rugX3
 aTE5h3u2k7RvY35ZCXJkCOO/p4qkpjHoAPBXZkyKE7GD/PuWmI/dg2rKXkvgw+OEVqkd4t
 u6aQ/YfSbmhc3P1wXbbGeSBXCZlHaq30/Or4kqh9yfH6vgQb8MNMSy1536jZpA3yKUoDG7
 JuwfzcuZs8ebKW3EaAwdCINnJpO/ryhg8wmvdV8LTGFVRwbgSIf49tqT/2RV50KFXr9/QF
 iwef9YjpOvvRq0fQix8mfpbHODZccHU6d7nGRp35aFoxX99HqL2txzUvAJpsKA==
Message-ID: <1d168901-eeb0-48d6-a5af-5f7538230214@mailbox.org>
Date: Tue, 2 Jun 2026 16:17:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/5] NBX10G: Marvell Armada 8040 Nodebox 10G board
 support
To: Vincent Jardin <vjardin@free.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <cover.1776762022.git.vjardin@free.fr>
 <cover.1778247592.git.vjardin@free.fr> <ahmrSI5Hf7r1moV-@L30177.local>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <ahmrSI5Hf7r1moV-@L30177.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ab12d081a4e076ae377
X-MBO-RS-META: nfdkk3srmutmc6yxgagqqm5huxya3z3c
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

Hi Vincent,
Hi Tom,

On 5/29/26 17:05, Vincent Jardin wrote:
> Hi Tom, Stefan,
> 
> It is a gentle ping on this v3 NBX10G serie. All 5 have Reviewed-by: from Stefan.
> 
> However the Marvell custodian tree (u-boot-marvell.git) hasn't moved since
> October 2025, and I see no recent (git pull) from Stefan in the archive.
> Could you apply the series directly to denx/master with Stefan's R-b ?
> 
> Or, Stefan, if you'd prefer to handle this through your tree, let me know
> what timing works for you. What else would you need from me for this serie ?

I was pretty busy with other stuff lately, sorry. But will catch up on
the U-Boot custodian work soon.

Tom, question to you: Since we're at rc3 already in the release cycle,
is a pull request with marvell & watchdog related patches still okay? Or
should I wait for the -next branch to open?

Thanks,
Stefan

