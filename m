Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8287606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FD1oAugP;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=TGGbX5Ra
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A72D60743;
	Sat,  7 Nov 2026 09:02:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jzRMJE-Ar1YE; Sat,  7 Nov 2026 09:02:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C93E9608A5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042151;
	b=G25jEoVFsb9LOqJ1Q8LxhrM5rWa1vdSAxrTZ4lyJhsrzr3+9AU1h8fRFJNITO9Et01PC
	 OcG0STtYzI6GZ5DxnVvljHic75tFM1H72uUHj7kBPyM6+pkYo4WH9TMnLQmaBmetommxC
	 9Boov2uwDWzn09o9HizYbnofaPNVsBsOMychEQgd7vsjnMwP84HyB3JRTnMfsCS+BA1Ia
	 1XNgb4GbL+gdordVS9stQBiWpnPqjFhG0GiGrJjzQgAkDlj40fBcHbUVRJeqMv9H7trs5
	 KyYKvyhnSYi/ZjR4ZNAZvWAoQBLzpe7ls2T+lG3sDGcAvM6WjN/hqTM7AKoDMlNkZXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042151;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HrANGA58pkJ0YE2VVCQp3ttyJZGMFKl9NE/PVHDlH5w=;
	b=PuWaV8Rdf9jJ5RWn9kM9n6Lp6SpFCPOtBbaMzdTxcxvlTw02zYwKQcPFuBE4q2GhFnvk
	 MnIxrk/sm+up25RCnfgnGDZlAZhuiENjYM+Qzh0nYhfQqNPdOOUCcz/iAZ6IPsYlyCcdt
	 M3QPZN9a2fHVt6urQgTvOlQEMY50hPrTu53fwvR9YIHVFhXQLRIBDQJnZslsIa0nItDRO
	 xZPlE+TM6TWq84foQKRbGtuK+Flswnct5Z4KMwCHFvljTeO7lKbcuUVq57lIfsSD6pAWo
	 mJi6EAo8lLsedLMdI1IVJuAj5KIqMuoxWhUMDSR5QcablQs+vh/qRgvWWlVX+K3Ta7g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042151;
	bh=HrANGA58pkJ0YE2VVCQp3ttyJZGMFKl9NE/PVHDlH5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FD1oAugPu+3Sxe1x8w1IGo1LoHUVjCK4ZRKue4kyJuHOG0K2Mfvdq4QZOJfvhDEgM
	 3E6yJOim38eWD/hEs8R5/mPrh3vG/r3TG+by+YrszT+HbGU4v8CpSGFHnvqd0vxa9S
	 F4Iip6XCjeQ2kAv5AapbpsNQvDwhjkR0YoPcO47KpaRUesZPtv9h9NFh4DBRNeHfLg
	 1ZWywyFUvW8Yva69xxz8xzmgiuvYLuRDq+3mBwvvThnuAnWfgRi9Ad/W3CuWTOzY+6
	 BXwVL+qDX2QHI4uWgyYiWAgMXb7c4N2LAeh4UB2SzRgo2hPud1D4Mi8q0EfdYYLOsW
	 Xtlbh4NoiThvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C93E9608A5;
	Sat,  7 Nov 2026 09:02:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D79DF1C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C996D80E1E
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C6it_1LdNtDc for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:02:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25C3080DEB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=TGGbX5Ra
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 25C3080DEB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:20 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jM96K2cX9zKnDf;
 Sat, 07 Nov 2026 10:02:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794042137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrANGA58pkJ0YE2VVCQp3ttyJZGMFKl9NE/PVHDlH5w=;
 b=TGGbX5RaKT4BrLqJ7T7Y1YVa83TvHLU6IzavZAmCQpqpGxJK6VjwMkqv1zvq0qwHT0GHQK
 HhWAu89669RSeZ8B/S+bYeD5bpS4w1IAVcq51us1AbhygpIpmYLWrQrbNoR+I5thY5Pbou
 OqNFjyTvnA1wvFyN2VxxX6kMAWzXgAsgoLALTuGwAd106mCJOuDg64G94Dfovcmh278Pk6
 I9yxlW28/73dqd6IreDQkikbD6O9XjkPvV8HPTHZ3EkLd1F51Gc47r7D6Ui+PO2g2/YPLz
 IPDddt+uTJ14AM9AjuFj3JptVIbqGX+XI4/SSSzoOjBUCVozeGkH1hLuUao1bQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 9/9] test: wdt: add tests for get_timeout support
Date: Sat,  7 Nov 2026 10:02:03 +0100
Message-ID: <20261107090206.2015512-9-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-9-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-9-07de25b6312a@nokia.com>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 44rxqexnwuwbg3akp9nrsb3o44t5krp4
X-MBO-RS-ID: 6eb731c6a3bdd2c63aa
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

Applied to u-boot-watchdog/main

Thanks,
Stefan
