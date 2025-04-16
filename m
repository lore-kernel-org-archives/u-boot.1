Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496B3C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C78C482CAC;
	Wed, 16 Apr 2025 09:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="H4TOmoYQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE1A482CBC; Wed, 16 Apr 2025 09:39:13 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFFB782CA2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2D2B114838BB; Wed, 16 Apr 2025 09:39:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1744789150; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=YVH34jft60rMO66ohTJSfjD+ExtJn0fd9R9HMzKiRSw=;
 b=H4TOmoYQGfo+95SuA0ZvJlrLtgty8EUgzn0wNJsMph9vgtRaI2kyst5XqMZdtjxUh9Hcp/
 sZCstVPHJWaDroCvfdizIC6PysrRXoqgq5F84pi/L4ZrLa+obovphnhYtBgOEAilsDHbj9
 upgKF7S1TZQJ23sFINFc+PO8MCPO44RXR7wT9cQ8W4oXP5gkkaPTOT8MxacOXWEZcNUdf+
 c3jjOATmiXpqJBtq7zQSbN96xd+YGJTXia6bIyLqwpWnAfV/gvv5p/37rTrJ9SXNfw9SR3
 b5NZZYAAUrhKV6n4kuRZ8zUmTsTgRKaunRXuutzEaByBzOUUbs6TDYYZ8Qi7Ig==
Date: Wed, 16 Apr 2025 09:39:07 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, Neha Malcom Francis <n-francis@ti.com>,
 u-kumar1@ti.com, afd@ti.com, vigneshr@ti.com, devarsht@ti.com,
 quentin.schulz@cherry.de, j-choudhary@ti.com, jonas@kwiboo.se,
 richard@nod.at, raymond.mao@linaro.org, m-chawdhry@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/2] Change DRAM message and add RAM doc
Message-ID: <20250416-unlocked-economist-6b0607b00fae@thorsis.com>
Mail-Followup-To: Tom Rini <trini@konsulko.com>, sjg@chromium.org,
 Neha Malcom Francis <n-francis@ti.com>, u-kumar1@ti.com, afd@ti.com,
 vigneshr@ti.com, devarsht@ti.com, quentin.schulz@cherry.de,
 j-choudhary@ti.com, jonas@kwiboo.se, richard@nod.at,
 raymond.mao@linaro.org, m-chawdhry@ti.com, u-boot@lists.denx.de
References: <20250319140327.301266-1-n-francis@ti.com>
 <174424957616.1824423.4212381391788741775.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174424957616.1824423.4212381391788741775.b4-ty@konsulko.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Tom,

Am Wed, Apr 09, 2025 at 07:46:16PM -0600 schrieb Tom Rini:
> On Wed, 19 Mar 2025 19:33:25 +0530, Neha Malcom Francis wrote:
> 
> > This short series is an ongoing effort to make RAM utilization clearer for
> > easier debugging and understanding of code. Intention is for users to quickly
> > be able to identify the CONFIGs needed to modify for their RAM usecase.
> > 
> > Neha Malcom Francis (2):
> >   board_f: Modify DRAM message
> >   doc: memory: Add documentation for system RAM
> > 
> > [...]
> 
> Applied to u-boot/master, thanks!
> 
> [1/2] board_f: Modify DRAM message
>       commit: 7dfe3cdc6c58f428803b0f1698bbd4b283103adf
> [2/2] doc: memory: Add documentation for system RAM
>       commit: 284ef1bbcefcf3180592ed48f522c79618099bd6

Something went wrong here.  We have a file 'spl_before_reloc.svg' with
size zero now in patch doc/develop/pics …

Greets
Alex
