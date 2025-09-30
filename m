Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81F0CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 10:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 544BA832AD;
	Tue, 30 Sep 2025 12:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xo7zeuJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E35D0832AD; Tue, 30 Sep 2025 12:05:16 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8192183045
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 12:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cbYZp6zCfz9tCC;
 Tue, 30 Sep 2025 12:05:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759226707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tkSvG5NL7gBrrmxNN5mB4HdiW39XgMmA2sffXRCDkWo=;
 b=xo7zeuJ+QDt5GOGhFVixU+KeYZBZOEiyya+90ocq5q2S+ceVCLqtnUlt3KOxS1/eVr5mQT
 mxYD6UGquxg/BvGdU3dtVVrtYUO2JG0h4qpm/KZ2qnUHawFt/k7LcY/iWTAAtTM0RERjjl
 Wi16Ph+j1kqgH11PppLG+KAVqB6x//KYxqlQpwECIbrJK8h/ZW//OjimWzGkuZ1aEaGyMV
 oe3jcUirITIMDn+XK3LkhxW5B7dlW+UW0Iu2tuiNV0A6AsGylbP2PVciyVEBV/YXTVrmXW
 dMwpjFU7/0nYHt65yNbBsvlnTiGkg52GIuypTCazv7GW1kLTK65jNXvHhUWoLQ==
Message-ID: <46e03e10-3a48-4886-ae40-b1014e647861@mailbox.org>
Date: Tue, 30 Sep 2025 12:05:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: ohci-hcd: Null check lurb_priv before dereference
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
References: <20250930-usb_ohci-v1-1-9efa75e71885@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250930-usb_ohci-v1-1-9efa75e71885@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 5r38ugrx51it7xj15to4ry43kthws7gs
X-MBO-RS-ID: 1df6f669221e73e47f4
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

On 9/30/25 11:56 AM, Andrew Goodbody wrote:
> When a variable needs a null check before it is dreferenced ensure that
dreferenced typo

Can lurb_priv actually be NULL ? What are the preconditions for that ?
