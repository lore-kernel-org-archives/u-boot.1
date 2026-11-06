Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6D6606A33B
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YmcmiabR;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=LIPQYEBo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDCFA608F1;
	Fri,  6 Nov 2026 16:03:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KqBr9_Iq1pwl; Fri,  6 Nov 2026 16:03:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 29063608E8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793980981;
	b=LTZ9FFD9qqhzdVCriSIIAH57HBUh750U8Zd8T824Sc+MtQgrdN8mGog2aPl/3FdxZmNw
	 pAMZa+j+1dJOZQhHIqu4Sg+UqXDqUg6WnMEqFwBrUZKNuqYWfspzWc7VmSrWkgoXYIwRn
	 i+jS8Aav4qVGep4hhQXouWuBG5wFajzXzXjl4jIDZkC+ly6P4F7tbqAJ1n4xPkbUacyZF
	 nUr9bwBNAdPU4pKEtBla8+XTaIXtHJrdjL9zQF0SuwV1YEv21yWhvHpJ/DkVXJBvR7YZ9
	 KWLVfXcT1tMTPwgXhsODKRrqJz2Zfo9TTb04vEZ+2/YFkQEEEkAZaczG7gqTxzUg28g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793980981;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cvBD5gAHbSSxCtnrWnzwRRZKs9RzeIHOmQdCl9aZYWU=;
	b=NaGXlt0uUIH1v2Ehx+SLJ3zDLRvmMHAlXCCtPV35SghtpPYBehE5xEpAl4MiR+xmN57N
	 ecPp04akakPnCa9Hc6H37fxgvETIbqS3vBxiNXJvMg83uxGC+nQQcgM+sCj51oXIXrdJB
	 by3SIGzIp8vPC/+uaMN1BsKhDNucp1psvEpUxGI2WQMNpR8F1lpRlr3sjnk0jQRzXZnAN
	 n/LSTdsaiTz9hy3kreuouoz8in/cuMzMQnvA79EINIas7DP9zVk09JsZ7MBewVdhj1jV4
	 yLt3x/GxM9NQvkuZKLHloRvkjJXfWaqQ1xaXruUTTcQXrGHhWPci5NT51maRIEaKwHg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793980981;
	bh=cvBD5gAHbSSxCtnrWnzwRRZKs9RzeIHOmQdCl9aZYWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YmcmiabRChub6dTBD024z97QXRfvzYjCgeqM+1Zo7vPFO85gtOd1VsdZJnF8S5nyZ
	 vHJ9hhllYYazBRLDoZQiMXKHOAStvDBZ0gGswTwJlUoffjG4BDVo3bTi5EtoD66aBa
	 fRCm9RJrmz3U+EhDIsqNpsd17tNt5C2LaH4fJemYWC0+MVRkP0qr5S3j0IZoWYYpK8
	 85+vW/VWBOdM27u1/5ErB26egVy4HHndMQUi9jfQ7+qZFXHMHXBQggUw9p3cchYUtP
	 4CYrD9R04hd+zSih2nqTniaN/jJ6185tSizPkvlXjp0uXoIdgRpTLtxNafBPpynCTo
	 oUUE576jAWUrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29063608E8;
	Fri,  6 Nov 2026 16:03:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 699D2362
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A4A6812C7
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6zhI9MjIiOWs for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:02:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B7C8B812D9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=LIPQYEBo
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7C8B812D9
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:51 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jLkTz6pJsz8v1T;
 Fri, 06 Nov 2026 17:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793980967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cvBD5gAHbSSxCtnrWnzwRRZKs9RzeIHOmQdCl9aZYWU=;
 b=LIPQYEBogGcMaoa4q3Z+sxBx07fZwYoj5x4YZg2956CpkrYTgQxT/dXZgdNBOf3dZoAZlp
 Zpjz27MBAWKolVwYPkg6uiWgHfuwKba+FKMZWNpBW6pNHM8VXdVvwftruFSrmvHt+/TLU1
 QkiV9hKwtHMsXfOGfenACEZYOuPHI73R+nPjBjOGSesSlElUQBvZEjTbteelJbRJmQVXOe
 snzifm0mO1YpzJMp4ex5ztqa14ujxebaelK6F28iqkdz7vo1TkMztZ0ly5qt9FtCV2jztT
 cKfBYprzsm3jHR4QLN7a73lIMXhSYL6fi9Xee8eTUMaXvphFdCNBIiowZXNffw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 9/9] test: wdt: add tests for get_timeout support
Date: Fri,  6 Nov 2026 17:02:35 +0100
Message-ID: <20261106160236.749429-9-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-9-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-9-07de25b6312a@nokia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: i4aqi8xgh1orzyocnwbksg1sbi3m3p75
X-MBO-RS-ID: 7105129d6a1fcb416c9
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06.11.26 10:34, Juuso Rinta wrote:
> Add tests for (1) get_timeout operation, (2) warning print when
> the timeout is not longer than the servicing interval, and (3)
> the wdt gettimeout command
>
> The get_timeout success-path and not-running case is tested with
> the sandbox driver, and the not-supported path through the GPIO
> driver.
>
> Warning print is tested via the gpio driver. The sandbox driver
> rounds the requested timeout up to a whole second so the timeout
> is never set lower than or equal to the 50ms servicing interval.
>
> For the 'wdt gettimeout' command tests, a new test/cmd/wdt.c file
> is added and the file is included to test/cmd/Makefile.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
