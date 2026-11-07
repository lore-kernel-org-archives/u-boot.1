Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB97606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BSwFV8Ij;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=oGdHm77/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 782136073F;
	Sat,  7 Nov 2026 09:02:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oT-y4gXkOjr4; Sat,  7 Nov 2026 09:02:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6843D60743
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042138;
	b=ANkYf98zu7wqSu4hTtZanXWu1kdl4b/YrrroB+8nsVOhMiQIvYTTpsKRnNDxgup9324/
	 QVbzuM4KhYGp0rrFk5h++A3UM2q1i6FEIaUhf2EqkooW+RCPa7WtPigpgyGN6aqe+AyaU
	 Mr1TMA+LccWU2jj47roZmK8ABlmmAu8IIPC0ggXviuLLf/9oasiK0+t6kCX5mpNVd+bXC
	 H3zAUpycwoYYq35++uuE77cvSv/gJF5GulMhUQFLHswgUnygqmBBZJY+QkJ8o/vDwBCgT
	 aIw/fxcARammI/T+v0ChF1wyLBlGAlHSy+qZXNZqLLV3gdLyWH6LUlauwlxGfBUmxSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042138;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zY4l7qCugU9co0/1RJXMcWYSIBe8E8Es02/K1BMbrBk=;
	b=S0Kyuuov7WYCab6Xc5vBFjvYAVNrhJmB+H8Jx2dQP6LuFS64n5HLwsouTU94a+W4OUZM
	 nBgyyvjv37TLGRb9eJfHK+lqcZNaUYhhDLHeDJwmj5ZeUaPBjGaB8t6S+v6lc/6bsEfAf
	 Rd/XrI020Yu7YKioM9nv4Wxpd2H7cEaCumPSkiRXFPyfzrLfBg4GH3jCEv6hbuPz1Qhi6
	 uKzkGgNMesiKNSgfXw43mE0/NZBs6Nm2CtoKFaxmUPYNeAcSKiF7W57K/ukJBZAIMAWY1
	 rcDUDITjiQVAQTVDzE2ALg7VH3Vtvhebb/YxCEGuVHqGLUZGxhS4bX3D99sjSIEyAww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042138;
	bh=zY4l7qCugU9co0/1RJXMcWYSIBe8E8Es02/K1BMbrBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BSwFV8IjKU3rVp2I1oRnDrUNyF+BITdR/45lLTjt24BVdDvBHH/6bBOncjlOBNLK4
	 7WonGfq5qjcQU1OqL49halEXgdYwOiQt2QwLO3k4OJtJwtbeYp8sjPnF/n3em2KPrV
	 t4I+XxM0yqZLyr+eiQWK//sAMnxDFsod9nMv8PHeFbsYxP8xrvxgSFLs9sZJ1M4nUa
	 tluxNfTiBnndVu9u2IPb4mgVjaXL4nCbGTAXSedjJfdHewSiugp2/uVYi6t3wLXsBy
	 JjYKqi64gKTBr4T/ROA9e+a9XC4wPVeMaAR8TI4m/c6Qg3Iu5zEQbv9Fv/c4IqGOuz
	 zCrfeA6wva5PA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6843D60743;
	Sat,  7 Nov 2026 09:02:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BFB12E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 39B5E80BDD
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zUqiEkTKvAns for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:02:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 26AEF80AC5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=oGdHm77/
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 26AEF80AC5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:13 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jM96968nFzMldY;
 Sat, 07 Nov 2026 10:02:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794042129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zY4l7qCugU9co0/1RJXMcWYSIBe8E8Es02/K1BMbrBk=;
 b=oGdHm77/FY9TqWCqYXBdStKW4+nEMrJjI0WStCJKEJH+4ieUKg0KUuA8kvUijS9n1kaeyb
 tW9fSce6X/yPqHcnnyaG1pDvKU3TSLvBCBhNIL9rKi6VnWVJ1GhJJsnKtgnsPUxFJKzNlJ
 QI/LNgT4mK5jvGpct53E846trNb+BzBgJO55ykwHgqFOG/PNdsvRY6zDVlSuHa2BqKjz/m
 XO5S7H8I08dg92iylxdRPeTVH73pvPP/1TSJZxYcewcmrqQYIMqWeSv5GMP0hcfsVlbSfZ
 gnxCjiIP5He36SfjodvqKTk/uAIp0iR59YlmxZARCt8xaQqhbHLacBKF2cQyEw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 2/9] watchdog: warn if timeout not longer than
 servicing interval
Date: Sat,  7 Nov 2026 10:01:56 +0100
Message-ID: <20261107090206.2015512-2-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-2-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-2-07de25b6312a@nokia.com>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dc8896c69d510e0ac2a
X-MBO-RS-META: o8bny3ynxm6t65s99ey6ih1xo387h4e5
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

On 11/6/26 11:34, Juuso Rinta wrote:

> If watchdog timeout is not longer than servicing interval, the board resets
> unexpectedly because the watchdog expires before schedule() services it.
>
> Print a warning in wdt_start() when the timeout is not longer than the
> servicing interval. If the driver implements get_timeout, the effective value
> is used, otherwise the requested value or the clamped value via max_timeout_ms.
>
> Suggested on the series "watchdog: report effective timeout"
> [https://lore.kernel.org/u-boot/20260823071511.687900-1-stefan.roese@mailbox.org/]
>
> Suggested-by: Stefan Roese <stefan.roese@mailbox.org>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/main

Thanks,
Stefan
