Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78055CCD18E
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 08:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1409C82AC4;
	Tue, 14 Oct 2025 10:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SeF3z/tj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 202A7830E4; Tue, 14 Oct 2025 10:56:05 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E012C82E34
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 10:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cm7Nd0cbnz9tHQ;
 Tue, 14 Oct 2025 10:56:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760432161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKywJWFuzYtijrGJOL7MSZ+1es6dAEeDGdRuwdo5LNY=;
 b=SeF3z/tje6WkEoC9ORR6zl7uWDlZFwMsRMnwvhyfUXbwOMmq6yhWqzq0ekQuMmQ38ZbQQ6
 L0i+uR1i2DnzVF3kfmw0LR1F8E9Jnvp/pfRQcIRFmAQmmuwma5EaPfJZMLB7Rhb/DY0U32
 YpVlJwbkkJhtI7DU6mSHccgEvHTvYOMGsoFJ+NkwCjRII+7UDGs9CgNaihcVQIrkk7FQ3s
 ThkYnR27xj8yfAtSDW+J1cWf4IL2Lh2JFKYbhBV81eUINoXkpVJ4N2Xb2fWOd9LxojWG+o
 zubtSWNrEhevKPWcJ43voUBn8h+eKZwW0+TvtTbS9ykWMWwcBjp92Zx1hgF4qw==
Message-ID: <c5896dea-08f0-40d5-9eca-af42cb5c4448@mailbox.org>
Date: Tue, 14 Oct 2025 10:56:00 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] phy: marvell: Tighten MVEBU_COMPHY_SUPPORT dependencies
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250925205614.3562540-1-trini@konsulko.com>
 <4d5bc549-a033-4baa-80a8-21ae2496007d@mailbox.org>
Content-Language: en-US
In-Reply-To: <4d5bc549-a033-4baa-80a8-21ae2496007d@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 76e74a040059d96bfaa
X-MBO-RS-META: dcxnjzuus1rd3saesf5w4136ryhzhfwe
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

On 9/26/25 08:41, Stefan Roese wrote:
> On 9/25/25 22:56, Tom Rini wrote:
>> This driver cannot link without access to functions that are defined in
>> files that are only build on some platforms.  Express those requirements
>> in Kconfig as well.
>>
>> Signed-off-by: Tom Rini <trini@konsulko.com>
>> ---
>> Cc: Stefan Roese <stefan.roese@mailbox.org>
> 
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Applied to u-boot-marvell/master

Thanks,
Stefan

