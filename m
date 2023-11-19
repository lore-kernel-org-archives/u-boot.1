Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7414AC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 20:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD68B87483;
	Sun, 19 Nov 2023 21:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CLMZy5pn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qzHoXeoJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EF8E874BD; Sun, 19 Nov 2023 21:11:13 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94EDF86F80
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 21:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SYMGL25ZLz9sPx;
 Sun, 19 Nov 2023 21:11:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700424666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RyXfSYJ6SfVr9hoTQDS0Z57hdqW5YSHfTJnx6imwlcE=;
 b=CLMZy5pnXJEA5CnRKV9AkbKptjzLLJHQIG/ZgBo16kZeTqO55gYCmaxwpvQYfngSpVIeEp
 29OTG7H+tSz8GOQQr/ZWc9MhAWH33GBRkrZj5BpRF6P/VpfKdD0EkXri3ronRiIgY4nftp
 qDbP97J4M7cZSnoxKDpGNuPTXnXRod8S2AWABPmKBvQvoCOBHF1xa1r7WQH6CIqvEIgFif
 FjM6Xo148mGbqinzFeRaCOaLKC30LneqGhsFHwS32L3BU63NQ3EObP9Qli8ATzi04WlZmC
 L91DFvMj0oMV/yQIXTfMBSLcA2XwPZx6hYaFsJn/yv0DR3GJVOQ/qlkl/2Yiwg==
Message-ID: <9216b738-cf8a-49a6-afd7-16c7f7efdca1@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700424664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RyXfSYJ6SfVr9hoTQDS0Z57hdqW5YSHfTJnx6imwlcE=;
 b=qzHoXeoJhcWYWjtMMZnwnzTPDuMTpUSmvfrTLdEVDeJNG5S94TD9s3ewds1Kvo43Lg3674
 24oh0Pdvtjjshea0qq6qgrUGI1cH4gHRt7wDHLHhhvDcUXAmHxbvBt45epxt0HD3tn942p
 z2Z1QJLp4bZaS3fNml0l4YBR8S8qRnpXUeNHnxgCpFkiLU7jJ8RFe/Y+097TPtdOr1vwWm
 QI8IAtTxmTkbEqwWyQ5Okdr/xNQGzwcVmgziLvNlWD6817oA3eoCzxCMYF6JQRzLSSch3w
 ysePqJtDBrq0l3uejEGvnsiWHYheW00px3Lf0hCehsSI7lRVvGOIPyouOZa7qw==
Date: Sun, 19 Nov 2023 21:11:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] arm: dts: rzg2l: Sync with Linux v6.6
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
References: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
 <20231115174025.12974-3-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231115174025.12974-3-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4inow7t71e39pepfogftp1m7fx5tqd7i
X-MBO-RS-ID: 6b53edf98d5aa852752
X-Rspamd-Queue-Id: 4SYMGL25ZLz9sPx
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

On 11/15/23 18:40, Paul Barker wrote:
> Pull in the recent changes to the RZ/G2L device tree and related dtsi
> files so that we're aligned with Linux v6.6 (commit ffc253263a13).
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
