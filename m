Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D32CCAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 22:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A572832F9;
	Tue, 23 Sep 2025 00:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="edvHUk31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BCBC83390; Tue, 23 Sep 2025 00:26:02 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57EC83211
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 00:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cVyPK6YqTz9sWQ;
 Tue, 23 Sep 2025 00:25:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758579957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDhUQ3nDrXp1quHuJU9zQLZylaGY3kLRgSgmtutuv9s=;
 b=edvHUk31Z7rwKcHQQY2K3f/X1dZgHcP0pM5CYloQgLi8tICVdiAmbAqNvNRMkSSsCHc5MV
 v2dtOlEEGtbKXk2VJSOOv4pOUW9AT2pAozt/PH35kYLbqmmfHhXLT+n0PAj6hLFJerOpF6
 pcntA5LunVW2Edgsi0W/Nn22Mno6c4HVoTM6OdirRt8NYT/2/WerOuegiZKpr79kRnRg3W
 s5mKz9YYtIPgt897dHE+WgWdcPD/+vzHqENp+tszRzVUhHXBfBnFNGiIsb3i/WfbIapybr
 hBJbpKSSM0U/wXPxUyD7NO0xzKUF5qRG686GtZDNGd8AIsuyhQqTyxUK7gCs1g==
Message-ID: <dec23078-9225-4faa-b364-74b590dfd667@mailbox.org>
Date: Mon, 22 Sep 2025 16:47:23 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: musb-new: fix typos
To: yegorslists@googlemail.com, u-boot@lists.denx.de
References: <20250922141229.5739-1-yegorslists@googlemail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250922141229.5739-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8e8129b74f3c0fcf80c
X-MBO-RS-META: t7r78e15f9z8w9tei6rwrro4do1jgfkg
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

On 9/22/25 4:12 PM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Typos found via codespell utility.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks !
