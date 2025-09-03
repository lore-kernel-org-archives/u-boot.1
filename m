Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B086ECA1007
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 01:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E126C83AB5;
	Wed,  3 Sep 2025 03:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="roTmZ3yF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED55983AC7; Wed,  3 Sep 2025 03:51:00 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE88283285
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 03:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cGlv46x0gz9sxP;
 Wed,  3 Sep 2025 03:50:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756864257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7ULRSMw0ZhoeTXaUgt88OfzV8DoyTT8rnnFNj/vQnQ=;
 b=roTmZ3yFhBFrMN9kPbsRaXupr4ubaR4wAWDZIcCDO5tZri5ofRfHPxpt9ylIgVOSt7qYXX
 iiF3Cr0mqmg8IGgmj6/BxCOnbPwPFRwHB7ujU8yOnM01mYIP0HoPQIlIz43c2q9M3KZz7T
 yaaAMcndj2SWo5E6kLLYwFMkpviV3X4jC0Xot+2W2JsjulzpQT4lLTsg46UD4XsbLDffKj
 VUa8ZvP5AHa43F5Bq/ynmaEhmKrD5z6hrk1u/ZbNoKDzKu0tk+DtfnuvqqZHMvUgsKIITw
 eHAo3bzm5qXtlG/CsFXoRNBqMLxzrX1ihB4x1uakxIiw2iSgRPIGcyN/cvf6ng==
Message-ID: <cdc74a93-c12a-4ead-b2f8-13fa32c2fcab@mailbox.org>
Date: Wed, 3 Sep 2025 03:47:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 4/7] usb: gadget: max3420_udc: Remove unused driver
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20250806145601.1664563-1-trini@konsulko.com>
 <20250806145601.1664563-4-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250806145601.1664563-4-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: d1r7q696isqqzc36yhcdy1tc3jsxeynh
X-MBO-RS-ID: c0b3a91c66ea1a23986
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
> This driver is unused. Remove it.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Please update the commit message to at least indicate who was the last 
user of this driver .
