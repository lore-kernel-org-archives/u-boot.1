Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA62D767F9
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 19:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8BF3892A2;
	Thu, 31 Oct 2024 20:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UFhbvJRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAB9E89245; Thu, 31 Oct 2024 20:13:08 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46BC588B9E
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 20:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XfYYB2xyqz9sbm;
 Thu, 31 Oct 2024 20:13:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730401982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbFur/L1YKxok34ZePA6gFsMqepk3xIxI/UCYoZizn0=;
 b=UFhbvJRCLV1Oqxlu8DEx6wts7kgOpAv18ojXZTCFGqy8RRht7pOdXWWKj1/RH3cqVQl7Ny
 dTQkNB8IkIwaj851njfEAlrlIkMaXa2aTCGlG/oUuOJi6ekY4C76hMnR/UJ/br+/6Y78Hx
 zM8wE6iuFwR+1JJC0zlaK61dIzYZ9ck0vNPD5Ef57dfAh4WONBU5XxFpLHxa+YgKPrCfUc
 rj+CQ+pejGCksHa5m6kiSR0SLNGB3pmfUvxz39PmoDFWbgmBGx+Mq3n46cnNRC83BUySv2
 bztnmQd5yu8ly0ZsHVGoP/I9Tt3JSkvyfGz6S2gn/ProeWf6ofG1FIeF6ol5zQ==
Message-ID: <1a939c3e-b3d2-4344-baf5-d8e4866c92c9@mailbox.org>
Date: Thu, 31 Oct 2024 20:13:00 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor: Guard SPI_STACKED_PARALLEL with DM_SPI check
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20241031183732.3602102-1-trini@konsulko.com>
 <20241031185158.GE3600562@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241031185158.GE3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: t5oko748g363bzumkxd1hos5s4aqyqcd
X-MBO-RS-ID: 6942895edd56a337cc6
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

On 10/31/24 7:51 PM, Tom Rini wrote:
> On Thu, Oct 31, 2024 at 12:37:32PM -0600, Tom Rini wrote:
>> While we want to compile the SPI_STACKED_PARALLEL code everywhere we
>> can, it must first be guarded with an #if for DM_SPI as not all cases
>> where we have this code built, such as in SPL, will have the relevant
>> DM_SPI option enabled.
>>
>> Fixes: 43423cdc5dc1 ("mtd: spi-nor: Always build SPI_STACKED_PARALLEL code")
>> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
