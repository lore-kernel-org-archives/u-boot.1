Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF89606A32F
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ux3XSHbm;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=MOZCTEng
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7980605D0;
	Fri,  6 Nov 2026 16:02:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 24ahbdCoRSD5; Fri,  6 Nov 2026 16:02:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F3816085F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793980969;
	b=ouW3Htu5oBTs3GGhUwwMy0wUVehcKVkcFOrM8MDoImQEndh1HPJSSUrNYnt5yDhdUaZz
	 JfvshnqdC0VlzOK9KZktIH0xcXDBl068JIfPSNh0DKVfiMlajIewvIldX5HZoEcxskiNN
	 n/QS+5dfi4P9tRDCNNQsW9jvaGkoionlI2QX0663+m5erGgx72kzOrtwpFRpaKdaOIwop
	 Nq0WzlYFq4RLQdLuh9sm8NUXGoXDGoRNlw3TPA6gktr4GdcQTucIZVVzf5zrMNMwylDsv
	 zEq1ncLbXTJJoR9lnZ+9Vk83aMeGK7LA/ZW/FF3BTNhPHVWE691Z+YHY+g1WdUYqw2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793980969;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B1T50PjRLpjB1ARZv0vOgPQt0LV4y9qz5vXx+0cBFmc=;
	b=nw4blZlxQJ6UDHhXXdeXbaSfIbcN0CJ6zMw+kExOKGF0yhYqnXagNbIpqkRgbFBDja8t
	 JfW0UtvCHr/qY//ucPYxuaSZSpr3ik/idSXtzrvLYqncxsU30WohCGWt3zfJwEOLrtiaA
	 C5IctsMlV/wCZxbkexdfoY/1TukFkHDw7U3kU0dhcGhDmEGvq4jX1smRtrhSn7ms97V1N
	 KG6FXrANb6OnCeHPjGbyxNuwBVuOfkXO9uVG9JNMZnforxNR7fwFYqglssPrSSRCzZeUi
	 3vvZ9luIWk9lsQnH2pYqEtYotdI81uQYg1Agc0IKLCAc8PafqXmshe94L+coHM3HqpA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=MOZCTEng;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793980969;
	bh=B1T50PjRLpjB1ARZv0vOgPQt0LV4y9qz5vXx+0cBFmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ux3XSHbmVMlpULHQMlfT5j3rgaPOuj35ewRv5YFV0wLLabG9nm1220EcG4M2N8tp+
	 faTCqU1OdvKXWVKkqi1xhcHLSeUxxgdiSbH4VfkxDHU3U2IBrZL4bCOcQOLrCGbIhs
	 FwH1lUz/C+A9aVsgiWyrNnGdfcl67bzkMMKq2gtWp9H0nfhrnuGyro/sopYKqd5Jnb
	 LO4ajYZ2odjkq2BMCoOMj1gLohQ426EhKqgr+nkE3xIUTyeClwCgi0YmdsVuKwXDh9
	 7wPx6b2xo7dBpW7Las1k22iEkEO1n6dhcIB1tbmw0RYDDsEp+XSOxmCrAqZVqyA266
	 1u1XDoxfWIs9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F3816085F;
	Fri,  6 Nov 2026 16:02:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C27C4B8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E8B5605D0
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QfnuIABFFpxL for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:02:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A4AFB608AD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=MOZCTEng
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4AFB608AD
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:44 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jLkTr6q7dz8tVh;
 Fri, 06 Nov 2026 17:02:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793980960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B1T50PjRLpjB1ARZv0vOgPQt0LV4y9qz5vXx+0cBFmc=;
 b=MOZCTEngNw+Mz5VBT8fBs96NO2eAs22vu4/u1RmVk/BhC4vtBEHudK9C35jasoWq93JYvl
 ANEZ5GEY/Y43uB1+yaJZVBQ/rWoaLo5ojDqzJzjXn2od030l3X35Ofi0F4jAy7zrQlixy/
 uS7TbsHisVdyn1tZiqHexLymGzxJmo6YjWvIaqHyD0Q7dEbAWIy6oy/1w0yPuugHXKiSHI
 SpdAzMhaQKkrPL19U17aRfkghuH//XpJz60T6LHAeJo7PM3Hb5/RnHT5mlCdrYk65uj+0S
 gkvL5f6B1eP4mpgjIC2oi9/PPNNt+J6OLVX9him7lThwzeqmkAh3yyJY+qYgXg==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 3/9] cmd: wdt: store the device sequence number instead
 of a pointer
Date: Fri,  6 Nov 2026 17:02:29 +0100
Message-ID: <20261106160236.749429-3-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-3-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-3-07de25b6312a@nokia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6qby6opi5h3b16r9io84x4xea5ztqccr
X-MBO-RS-ID: a2369f4d48da1048a83
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06.11.26 10:34, Juuso Rinta wrote:
> The wdt command keeps the selected device in a static struct udevice
> pointer. If the driver model is torn down and rebuilt, for example
> after running 'ut dm', the pointer refers to  freed device and any
> later 'wdt' subcommand that is run without 'wdt dev' uses freed memory.
>
> Store the device sequence number instead and look the device up with
> uclass_get_device_by_seq() each time a subcommand runs. If the device
> has gone away the lookup fails and the existing "use 'wdt dev' first"
> message is printed, with the selection reset, so no stale state is
> kept.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
