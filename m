Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D27D59D71
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 21:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D732388B4B;
	Mon, 25 Nov 2024 22:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ySfE6eIN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RQJgYUtf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BCFF88E87; Mon, 25 Nov 2024 22:09:16 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D58688001
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 22:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Xxyxk0JPMz9slv;
 Mon, 25 Nov 2024 22:09:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1732568954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ICjKSjDpYG+KY3ETNh6MVw42CP3AvzAvwfzqjWVUDf8=;
 b=ySfE6eINYR5Hqzh0HeS5Kw80Y2YPpbGkuveE+LtHPVzJqUg0Ay1v4l/D/9O/PofkTfpO9q
 Y+SPKrHAKVuruE6U7MCeua0BfFiqAtff3gwb6TA46K7EdSnJ4Q1LSMVJN3vvAjHT+V9fGP
 jLSPxOC88xBbSvp55V4fA7TMiOYlR5l1Hu0ajxWK9g++kR7iw1UzE7gvP2W7RO6/XJ3baR
 3vqtTMq2JecZiaWCyYml+bCHsZfNTmpEsS2fIYim6MGu0yQZtSqVtU7qrm4Z698v61nWcW
 YBkbV1YwUYybiyUHqDBZ8YhPDhB4pBaJIvTHQ2AGLbCM9cVSQd3ll69G2CRssA==
Message-ID: <1a4c2b8e-6a9d-428c-a44b-6ed4335af8ee@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1732568952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ICjKSjDpYG+KY3ETNh6MVw42CP3AvzAvwfzqjWVUDf8=;
 b=RQJgYUtfhUAQ8+fc0tE7pP9XKxSpocY0f7xleRI4vBs6gfN/5Xbrg70CKmorGLrKWUyGAH
 M2A7H6GfpLSoPb+HpjK+i19EiofxBrz2HJHSFB3gqsjE2myk09uhehvpirIWp0iq/Zml2k
 itSh3xQexQi42buHaTlnVIAhLB5a6aY7HRr1PDU1g3OyXb/TXSwjTv2uOoP4s98fvKec8N
 WDp+du+QgfKHpIfDd9D+W2OJewONkiDq4qtnLdsRdoesSGBL0e8+hCl2iP86RHYqjFbyRK
 StCoKfdSVJihN2Ok3Wq74rzPo8zuToTwx/veyklLjT0GAbzmKRyKySYQi0mjbQ==
Date: Mon, 25 Nov 2024 22:09:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] spi: Fix missed rename from SPI_ADVANCE to
 SPI_STACKED_PARALLEL
To: Dominik Wernberger <dominik.wernberger@gmx.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: marek.vasut+renesas@mailbox.org, jagan@amarulasolutions.com,
 michal.simek@amd.com, tudor.ambarus@linaro.org, venkatesh.abbarapu@amd.com
References: <20241125205322.15894-1-dominik.wernberger@gmx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241125205322.15894-1-dominik.wernberger@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1mma7tqy99wb9fxeggrk876nprbfazch
X-MBO-RS-ID: 9095acdb01dc4b0f29b
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

On 11/25/24 9:53 PM, Dominik Wernberger wrote:

The commit message goes here (now it is empty).

Use 'git commit --amend' and fill something in here, something simple 
similar to the subject is fine, like:

"
Fix missed rename from SPI_ADVANCE to SPI_STACKED_PARALLEL. This fixes 
an issue encountered while testing the Zynq-7000 QSPI parallel Flash 
implementation.
"

> Signed-off-by: Dominik Wernberger <dominik.wernberger@gmx.de>
> ---
And then it would be perfect.

Thanks for the fix.

(
Tom, if you want to fix up the commit message while applying and it is 
fine with Dominik, please add my:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

This is obviously a valid fix for RC3
)
