Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01D5C8303F
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 15:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58277833C6;
	Thu, 28 Aug 2025 17:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="C599a8Uj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AC73833C6; Thu, 28 Aug 2025 17:47:26 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA4C833C8
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 17:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cCQky3mLpz9syv;
 Thu, 28 Aug 2025 17:47:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756396042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yuc6XqLvYRx1HAcCEJ4CoFUJXDcszC4HP7pIV5iQyFM=;
 b=C599a8UjieOYyqc09bvyOvnpPqad4iipAyhX6qpzZWoarF1X2RUQx/lKV5EYYXuQ5VXXNU
 yXLaB1Km2810SC8oD3zIEMTwCxURiEqD3ODRQn0hVd0fCH946iBr4TWPUEIjrTgxmXczJY
 CQfeNmL6McpKlo2uz5roMpLu07H2QLQywkiz+uAFdPe1ECYeM+zhoZY3o3Cy/ypvs3bsXx
 N5t6NgprFA1t3U07FkaHlUT91aQQ9YsElbJ7M9TyXeqEim7Kf5JywmiPkXAacG6gJWDMAs
 Po0ltjg49m7njMJbDASrOwTXxbHaDbSE9In742qnPtQRJXFnFHmIq3t6XjwRbw==
Message-ID: <1e597315-bc7b-49dc-968f-4e5ef1d5f43b@mailbox.org>
Date: Thu, 28 Aug 2025 17:20:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] mtd: spi: Add ISSI QSPI to lightweight SPI flash stack
To: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250828063638.30278-1-nareshkumar.ravulapalli@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250828063638.30278-1-nareshkumar.ravulapalli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1iu8c7ez61j37rab6kkqtq3yf39xhxg4
X-MBO-RS-ID: 519bfb4b3330ee6cc3f
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

On 8/28/25 8:36 AM, Naresh Kumar Ravulapalli wrote:
> Add support for reading data or images from ISSI QSPI flash.
Which part does this implement/fix/.. ? Details please.

Is there a matching kernel patch ?
