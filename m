Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFB8C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 20:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D5F86940;
	Tue, 15 Aug 2023 22:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OQlPL8cM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p8pbTxoA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 547598697B; Tue, 15 Aug 2023 22:44:19 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7FBC86852
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 22:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RQNXv3dR7z9smM;
 Tue, 15 Aug 2023 22:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692132255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BV5NSYpPxEKskwPxZGuUZD2dAf5uagnCUxovkZdRUg4=;
 b=OQlPL8cMIKSthkqAser6JrokF0Qj+nFvBtzbODnC/HyugocQhckJz1dxBpQfduXRKzbh3P
 CuPm23u8Q0da8NzuEy39IJmG353683Y7aPMm/qlGTu9upTfFo0xLGLoUcPfNBOcQpN0TOx
 Rh+VmYrJRhTipUCq72N9DX86BV+JHCc1pj/AS7ahndBBL4yDrZr9ItTuS9I3ssaz7Nft5B
 KXyre85GoclauZyIWrQfNdfJoiPicilHc3+OIpl7hwRCTsB2xqahRe+CCQbZbld3n6quKm
 MFe4HLA7n2yKm1hW3H7o8DRvle/rqRJJnfZ5V1BtzMRkjcSldJXOkINehz8DYQ==
Message-ID: <badd451d-cef1-50c8-66e1-81f798a13eb1@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692132253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BV5NSYpPxEKskwPxZGuUZD2dAf5uagnCUxovkZdRUg4=;
 b=p8pbTxoAttDrUv5O+hjpZNWKfCR+c190/YDda79q8coDRLUUAX7+AUmz9ZLqAULCfXQqv2
 DxswPKn3Gd+l3VWzlBtiMUFAs9d1Zq2d4S1VZiz2QgN7zp8B7CTwLj4ACXokTWkDnpZG+E
 7tJmkPWsKTml3Q+If0kAxVM+HNf+lGBwQoPrSk6U2x8ofZG3vluZ530JZa9Q3A/ZRmsErq
 zO9VL7AAQR7FLPFWqqwLlIP/h9bFL3x0MAKd/3C+bUSHK1HM0ERYNmMWNqHHR3kqlkqBk6
 xk2mK5aFRxfletoIePPOvPz7xHraSpOwTyefu8EK4GupXc9vytPAFyrua2SDLQ==
Date: Tue, 15 Aug 2023 22:44:11 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] nvmxip: add sandbox support
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: marek.vasut+renesas@mailbox.org, sjg@chromium.org, u-boot@lists.denx.de,
 nd@arm.com, Tom Rini <trini@konsulko.com>
References: <85390ee0-acf3-8e39-1074-250e07bf5e5f@mailbox.org>
 <20230815164300.444701-1-abdellatif.elkhlifi@arm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230815164300.444701-1-abdellatif.elkhlifi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a536f5e4e69c75453ce
X-MBO-RS-META: yrgsdqw6rzgpm6cu13yesqwrrc1suwfn
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

On 8/15/23 18:43, Abdellatif El Khlifi wrote:
> enable the 32-bit version of sandbox
> 
> Initially NVMXIP came with sandbox64 support.
> Let's enable sandbox support as well.
> 
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>

Can you please split this into multiple patches and add proper commit 
message description to each one ? Thanks.
