Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33083CA1005
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 01:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA41183AC5;
	Wed,  3 Sep 2025 03:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="o0OAvzzk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E67383420; Wed,  3 Sep 2025 03:50:59 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F3A283390
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 03:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cGlv33yxFz9tff;
 Wed,  3 Sep 2025 03:50:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756864255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1sgjFPf0vbFnkrny30ccEucylppZBNbOKpL4Y1Kq3a0=;
 b=o0OAvzzk0UkILMjDxZiv4buhOkWbouEh6gKtax9WgmlK1fgwJp8Z1rZcM4NMlhpqYMp29J
 1x0inGzFnvQJwG7YUFF6kwPskoHhFhD3S0m01uXIbe+Rz6ajzez8A2NIXrXT+X2or5MVhK
 A/8ZhUrQQm6DKOrSnP23seCJat+NGQhv5WMlPkHW5RVNj+iRc08jPw0Ttk41paUT+ZxXXR
 JOAzhxJhbPEyJ3IBtBwVtk44P10XNzPAX4p10ghBC6iDB5W5x7GH9xSONq4le1NRMgOnc5
 VxJ10EsbCdBua8FcdW/sLRbKZ+Q40RKnM3zbKuoQZjwvzfzk5fXn5Di4Vz3jFg==
Message-ID: <2e8a07c8-9b6f-4813-a7bc-ab35dd18eab1@mailbox.org>
Date: Wed, 3 Sep 2025 03:44:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] usb: gadget: Tighten requirements on
 USB_GADGET_ATMEL_USBA
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20250806145601.1664563-1-trini@konsulko.com>
 <20250806145601.1664563-2-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250806145601.1664563-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8ew7ebw4wsj9xqbmw9d9q9i86suj5z5z
X-MBO-RS-ID: 3de1d5bb6906ee4c43c
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

On 8/6/25 4:55 PM, Tom Rini wrote:
> This driver requires some mach-at91 specific header files in order to build.
> Express that requirement in Kconfig as well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
