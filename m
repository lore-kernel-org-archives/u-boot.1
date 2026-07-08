Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56374C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 04:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D332F84AC5;
	Thu,  9 Jul 2026 06:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hkjFa6uU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61C7C84AD3; Thu,  9 Jul 2026 06:14:18 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6613A84AB8
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 06:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gwhRq0H7xzKmT6;
 Thu, 09 Jul 2026 06:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783570455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1pQAtHulJciHao+JbMsgpbRVCq2wWBzcmsnys9d+0iw=;
 b=hkjFa6uUwOBQ9qVYe4jF6zZYTHaC+b5HnPjGSG1bUaxSSZL18WM0ghNWrLOn+b7J3HMbgJ
 tlXf8R2afEusaebJ6uuJN2cliKT/96KmJSE6kmjKIKHQlrQ1h6mNSv2hDIvr4N0Rhbj85O
 dvblWD7P0fQfA0bbng42caLUvykn2nYIha2h4J9RrO/pW7+Yw+mDKYhcDv04UoU0ul0PQ7
 38d9dTy23HSscI+d2M+q+mRO4MzvN7TVLOYONk732mx8F8Ho1tgRZ/8NuMfAy1EFBp/81a
 dYGgE7OLBvosqf1tcPfJKFIQG8N8OICbiagx8HUgWFmK3d0eH0WDXqP5/ua3SA==
Message-ID: <d73503d2-98f4-427b-9565-0b8bad7cc1b3@mailbox.org>
Date: Thu, 9 Jul 2026 01:48:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] usb: gadget: add SuperSpeed descriptor support
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 Dan Tran <Dan.Tran1@synopsys.com>, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <cover.1783551505.git.Thinh.Nguyen@synopsys.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <cover.1783551505.git.Thinh.Nguyen@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cdf22af278687114bba
X-MBO-RS-META: higpssz95uxxf59swbxh5h3qczk8tfjb
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

On 7/9/26 1:04 AM, Thinh Nguyen wrote:
> This series adds SuperSpeed descriptor support for the mass_storage and DFU
> gadget functions so they can operate correctly at SuperSpeed.
> 
> 
> Dan Tran (2):
>    usb: gadget: mass_storage: add SuperSpeed descriptor support
>    usb: gadget: dfu: add SuperSpeed descriptor support
> 
>   drivers/usb/gadget/f_dfu.c          |  6 ++++
>   drivers/usb/gadget/f_mass_storage.c | 25 ++++++++++++--
>   drivers/usb/gadget/storage_common.c | 52 ++++++++++++++++++++++++++++-
>   3 files changed, 80 insertions(+), 3 deletions(-)
I will let Mattijs comment on the patches themselves. But I would like 
to ask one thing of you -- please do not add internal Reviewed-by: tags 
to patches, it confuses upstream reviewers.

Thank you
