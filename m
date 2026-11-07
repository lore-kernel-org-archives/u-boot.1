Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A91606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SMwLDuX1;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=VetFGRpN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C592C607A5;
	Sat,  7 Nov 2026 09:02:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xDxDaRTHeXPe; Sat,  7 Nov 2026 09:02:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1706C606BA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042142;
	b=Zf3swIIpveD0hx7L9TgORJfJOG7hrCdFA8jUaMKJS7cpTYRtd0Vlg0Ra6ShwK6tX8uQS
	 3AcxG53KuPdCAL2aZMzgxvayo2/Gby4zky1SLqlhvH6a9i3Toeo3SVLaZpy5/9EJiO5Fa
	 SDvrU6fAizWzcy8XkTGIJwYIvB5B2+3dX3DTMXldZ2rPOXeucIimzcjKkjnW+mEwKG5hS
	 WXg0U18gH6NrEwyJ8NEe3wTFPQH/c2V/ME6MSvy2J86GxkQP+37ka0fgEgxDKLY0DTgqW
	 l+GcDbsUu9QPtZpWEa2tMb0Ju2O4BsoNPL3H6EIR2oh9ya7zq9HeouBrK/4cOucXesw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042142;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hjLWbs0qaJw4ANE0ysyzBtDUEWznmSo/ygD4Wl9UbIc=;
	b=Xz4S6WoRsgRI6ahNLIqyss4ytmlHPBX6AqpWv4FTt3+s57blyVg9Cf9YnYhT33RBgFR2
	 Vk29kjZJlUH7/6AKxPphsWwmDl2/8iRhvPa6Foo+sacx15ZSpl3kiHPguEvOHc6ZTgDSt
	 URRhWN3IxSVBmSd84zyF6mWSlOToyqMSkK0gz6cYatvf7n0fpQ6qk8glhT4+i9mlA4Y7E
	 khLTLzUVcMFmtxOwXZVm8selnY4A8Jx9p6i2Qm7v7hCOsKzjMAqTqdG98PRs4Y+d4lw4i
	 ioKOccjedYnLRnC87qEmeBj47oAz4MBFd/6MESR1QY2cDtLMKTf0OCMnAZWXOdcoFsA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042142;
	bh=hjLWbs0qaJw4ANE0ysyzBtDUEWznmSo/ygD4Wl9UbIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SMwLDuX17KICJ8l0CS6Bi90Aw6HYkD4QrbqgfUQFKaYq9M/wgZ+114vAOUexMVXfp
	 1FqM2pG1cz4p9n7YQ7PSRzJLKTE0WjTlEpmuMwVTNbSCvp+dcDwLrA2DU4LqOr1f0C
	 PBeRz3LzjENDb7iaU+5eSDq/sDzVzYiv0SSB+ffFAYooe2lly1n/ODy1ezjWN+ENsf
	 Lot+mN97slSzGWGFUmO6RJ6fJ7Zi7RCiiye7f7YE9FoEz3y9izQMxs4xqozX1i4uj+
	 4iW2DSab935XgnzO5lRQ+oE6fNSZYzTkjHxfho6Uhxp/Q8ioJ2E3z5xOzHbmfcbcRc
	 TOuAEXMfKigag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1706C606BA;
	Sat,  7 Nov 2026 09:02:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C7BA32FE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE02140634
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EulxOXeAEBI5 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:02:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AAE854062A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=VetFGRpN
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AAE854062A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:16 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jM96F1660zKnV3;
 Sat, 07 Nov 2026 10:02:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794042133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjLWbs0qaJw4ANE0ysyzBtDUEWznmSo/ygD4Wl9UbIc=;
 b=VetFGRpN7R2wMkFgkJW0XUhy/n26r5VG5s+bapKWeadKRvObi3WNIYPxMrA/c2GWFPjuzM
 MJlpdISzYfwnewwOQQhpdn2bclD6KgZ5KKoUdPCj58Bt9wZWCn649VwqpGL1u9YIjHmgeF
 slqjxTSH+r4KH39W8obSFicNZYN//kiNIV3zKQKdxsd3fzyGlBHqfI9EuTTIgxB82kdrEr
 QPowX6hrdr+YLj30vHMO4wOeJ36Vs8JWA927wl3HBUfCTZym9r7F5vZj++ZBEQF/oTrx67
 ERcCIwQGvAncZYPcrTBxCIlOlyx/tC9c1I7PXuMYBHO4MdEBpod5VaJR3li2aA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 5/9] watchdog: designware_wdt: add get_timeout operation
Date: Sat,  7 Nov 2026 10:01:59 +0100
Message-ID: <20261107090206.2015512-5-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-5-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-5-07de25b6312a@nokia.com>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4xb7qfqzb53btu3hqx9xjpz697dqf5su
X-MBO-RS-ID: 8fdc79e7706f78bb2e2
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

On 11/6/26 11:34, Juuso Rinta wrote:

> Implement the get_timeout operation for the designware watchdog driver.
>
> Add defines for the timeout shift (16) and for the mask (15) used by both
> the getter and the setter.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/main, with a fixup while applying:

  [sr: fix DM_WDT_TORR_TOP_MASK typo, s/DM_/DW_/]

Thanks,
Stefan
