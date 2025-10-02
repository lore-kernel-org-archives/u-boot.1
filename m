Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A3BCAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 11:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD501835B0;
	Thu,  2 Oct 2025 13:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TIa/u4xh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C78681D6A; Thu,  2 Oct 2025 13:43:21 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5C858328F
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 13:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ccqg85Lfdz9tMQ;
 Thu,  2 Oct 2025 13:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759405396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59lnql0vNVI7Be+ABL1k9DY41jm38gXAfm5OGWiTsBk=;
 b=TIa/u4xhJ0jOmOfxReGNmrOzoGFKWFhcRKn8EGf/BEo+fqHaJV44v1H02O/bOGrgyXduGY
 ZMMw1ec9/LGykXitdZvR7EQFw9QUkV0vXisVP5f+OSafNOhooKg2uY+ld3hMkxydgyqqx9
 z0B9V+gCPMvaI9a8F56gBGA01wM5OJDAmchwfa6NwUMJxmW0O4XqoZuTGs7AYkQGTru0Kk
 t4uR8y5yryRT1sFw88xWHLPpN2R0EgYrBP+gYu+/bQDABKQGF/PLNtIWdZn5+OqdAiOghL
 8/XO/6X8h7R+FmoyrTwvgN+DNjrmnFqXT81fP4ZByiILCoYJ+7H4xqxmtGuaJA==
Message-ID: <930f951c-d2ae-48e8-b8c1-680e2b5b3985@mailbox.org>
Date: Thu, 2 Oct 2025 13:42:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4] env: spi: Fix gd->env_valid for the first write
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com,
 Tom Rini <trini@konsulko.com>, e@freeshell.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>
References: <803db0f01d568fcf702368a64eed007bde1d8bf8.1759397673.git.michal.simek@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <803db0f01d568fcf702368a64eed007bde1d8bf8.1759397673.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1e98e9208f906a1219c
X-MBO-RS-META: ih6q6u8cs4384zhc7swahotyxjcje66z
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

On 10/2/25 11:34 AM, Michal Simek wrote:
> Update the environment location selection logic to perform round-robin

We only have two copies of the environment, why round-robin ? That makes 
no sense to me. The actual technical information about the bugfix is now 
lost in this churn too.

The V3 commit message was perfectly fine.
