Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00E7D73EB2
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 02:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C9DD84101;
	Fri, 30 Jan 2026 03:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pQ8y9y5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A8D1841BC; Fri, 30 Jan 2026 03:15:49 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB6F8418C
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 03:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f2KNw0d3Vz9t4B;
 Fri, 30 Jan 2026 03:15:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769739344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Pu4dv0SE72IuYbbOV0k8JHSrdTIS/WC16bIMmlltCc=;
 b=pQ8y9y5yw+OZpl/FyCmeDnJUaoUylIkCrYJ3alV0tXKys/1iGqni2AwSP9M/umWLMauJiU
 4/DmA+FyEbou1sRjT41a3/N9vvmTWLJJ0/RXoZWx89Kx+9G/M8VP5gJJF6jhAva7Dq82hS
 txWcEHgbYfuAsD55QskvsyWnpTpLHV6jRedEwCrO0dnYh/TlQcR/PNZsvALT3lj2yFec/d
 EfnPK9lgaEeU04r/XHaIw6xz9rkHQBBarF2JvvkwA5xdt5wWs0L2x7ooKWoFrWBFFSBtnr
 7O6l/prc+vs/9PQkleYsXZ/ppoikmE8Xy7z9s9hh6ccrdK6kboYgD1uUtGSJ/A==
Message-ID: <51deeb8f-b680-4140-add3-e7c98a29ff6b@mailbox.org>
Date: Fri, 30 Jan 2026 02:26:53 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/6] usb: eth: asix88179: Make functions static and align
 params
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de
References: <20260130002941.2336252-1-jonas@kwiboo.se>
 <20260130002941.2336252-4-jonas@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260130002941.2336252-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f5a78868843e94e9e58
X-MBO-RS-META: ibgze7cmg58nmgdy6yecanrzctycmfy6
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
> Make internal functions static, align function parameters and drop
> unnecessary != 0 checks to cleanup code.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
