Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D33CD13DA
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 20:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B61480F0E;
	Thu, 30 Apr 2026 22:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yYs7c8Lf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D239E83693; Thu, 30 Apr 2026 22:08:50 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97DE580433
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 22:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g64xS11w0z9ts2;
 Thu, 30 Apr 2026 22:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777579724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nhfv9aT80/KYeLg3l67oFtL9BNMVobQ4ElzT6GoN1VY=;
 b=yYs7c8LfTgAhPSdKueeVPRK8Tquo7ltERhcv/bqJggZZizmrouAkSUvjdLsDtlR3P+/3HW
 C9r9MaO1PIaz17S9cd+XX95LTg9PxRfSD76HydXnazoF6jpr7V7hAgNeZyENFa7Me6lU5e
 /e4msIxxHP4DqRXD25sEC2oZz2b74r0/kPBxUH2oDUuee9c9CCW6lUGUEol+VvgFXPBvUO
 c6w+T64BE26XsDUwNobuBUkxY9ypTgvdWdqqnYVVZxqRV9BU5Rn2/LjvXz+QhGLe7UX58G
 6ZoaC5A12Oi0p66C8mfn4+82sv1LYbfeSufwGhkBMKwAjwK3UuNKViSejm2rNw==
Message-ID: <afcfe31d-f928-4739-be80-7d501c1b7f5d@mailbox.org>
Date: Thu, 30 Apr 2026 22:08:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] scripts/dtc: drop yaml in DT validation
To: Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Greg Malysa <malysagreg@gmail.com>, David Lechner <dlechner@baylibre.com>
Cc: thomas.petazzoni@bootlin.com
References: <20260429144615.142350-1-joaomarcos.costa@bootlin.com>
 <01c1fa30-6dcc-443d-a217-b032a0a8b53b@cherry.de>
 <e037306a-86f6-4df8-8486-73902792a914@mailbox.org>
 <e2621e78-428d-4a59-add3-a57658a1151d@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <e2621e78-428d-4a59-add3-a57658a1151d@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: tkt7eydxd8gmykw1swmnc1diwg4mp6cf
X-MBO-RS-ID: 5e0ef83e63a3929b512
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

On 4/30/26 10:10 AM, Joao Marcos Costa wrote:

Hello everyone,

>> I agree, and it would be very helpful to check for any other missing 
>> patches.
> 
> So, this is the list of changes in the original patch (i.e., git show -- 
> stat):

Are there any other patches that might have been missed too ?
