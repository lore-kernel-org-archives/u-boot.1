Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802A0E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 21:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5168022B;
	Wed, 18 Dec 2024 22:02:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vd4qUyyq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IryKRNHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1F380241; Wed, 18 Dec 2024 22:02:44 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 139178021D
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 22:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YD5jY4JRpz9sn9;
 Wed, 18 Dec 2024 22:02:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734555761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2/xPq12p1UpM0I50Owqe4Lgt91lJYZl/SYVVEfrXIc=;
 b=vd4qUyyqp+gzVOo8c7jSQtv6olECAitGPm8DVnPCta+qYXZ2TlXp0yQQegpZYraxV8Oz5L
 5BNjEZrXSEUYfquTPDGI7VWkrQOtIEJu4ECdQN7Vo62KdYAITcU/5muIZSQAnWpldOY0He
 YVfhkHEuhO9k+AFm9u+ARvxSAim0xnpbHqKurWW1XuLAxCG+f/9cfG4h0ZaGyxOcDvFJay
 PsoXzM7/FpcNV2856kGrVmWgGG18QmUwftegHxAsdwg2wZeTK0nfloIsJYzx7SJ4ZAwLmn
 J+ZhKkm2zfJCRpsPC+0A3G7Ex7vZ6WKd6bYSylDrsDJ/RqVJalRV6FUsW0Axzw==
Message-ID: <c0733d18-e778-422c-af06-7fd33479e92d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734555759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2/xPq12p1UpM0I50Owqe4Lgt91lJYZl/SYVVEfrXIc=;
 b=IryKRNHH28cdgMCALRX1RuvJJcsIMwo2qlMmyal90h9RSqgf93nHSzVW64lwTOHQRO92Tv
 OQOih9d87z6xumjmnSdufdnGDq3x8Xty15q1Jf8pLMJx35xpMIW5pwpy+D2WYOYLbZ1YkQ
 FtmqyUbuNiO7pFPfyYNyft+fCPHswntw2pQVvtpcPfokNfieoRBqFI11N6/rl46IJvj9nI
 e3lC6Vh9IY5U7srZpER5QF67zgvDVlkADjlqUYntCYvGNZPCdCfw6oEH1T4e9TixkVPfpW
 YUsJ3Ofs5/esg/7db8UPfa6erpKJCyk4A88Q646H8Ce8W5yolaKYXD728KsZrA==
Date: Wed, 18 Dec 2024 22:02:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: renesas: Enable TFTP_TSIZE on all Renesas hardware
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
References: <20241218194143.79136-1-marek.vasut+renesas@mailbox.org>
 <20241218194327.GO1505244@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241218194327.GO1505244@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 267a12f00dd607cb907
X-MBO-RS-META: ms6zxb4t8f7tt8fch4t1tsiy4kofiwdm
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

On 12/18/24 8:43 PM, Tom Rini wrote:
> On Wed, Dec 18, 2024 at 08:41:28PM +0100, Marek Vasut wrote:
>> TFTP transfer size can be used to re-size the TFTP progress bar on
>> single line based on the server reported file size. Enable it by
>> default for Renesas hardware to avoid long scrolling walls of '#'
>> character during long TFTP transfers.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Adriano Cordova <adrianox@gmail.com>
>> Cc: Anand Moon <linux.amoon@gmail.com>
>> Cc: Baruch Siach <baruch@tkos.co.il>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>> Cc: Ramon Fried <rfried.dev@gmail.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>> NOTE: I wonder, shall we simply enable this by default ?
> 
> Any chance you did a size comparison before/after this patch? That'd be
> handy to know for making this default for everyone.
r8a779f0_spider_defconfig

without: 744640
with:    752824

So maybe this is not for everyone.
