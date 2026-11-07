Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C39606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nfZpZzwU;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=wZOnPvTK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CB91606C0;
	Sat,  7 Nov 2026 09:02:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R4nTrpcJoG0X; Sat,  7 Nov 2026 09:02:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A50C8606B3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042136;
	b=FbdmdZuePYD3Xk8BFXhkhZJue84R4rmy4SQ9FMJJ+at1bydqrVK2kdpLhSGU7ge7yKqm
	 rfY/CrsaQzcYI4i/PoRtKgFh6wrG8yNJKnUgbsXGBiAsNVIg34/u1FZ++OmYHVkoTEG5x
	 nKG/ZrigWX/CN7AozC2LsCOBT4W+LpDQbVS4aMgV2soSbspfyeKA9t2O4MqW9HDFRhrZ0
	 1G3Kd+LbiuocLksNssbJkXI6qG1/cq/6+WXmVG7bE+Zf7qge9fG2xuuTLadGRqtlo+8nK
	 y/OoY0xUrvYVwwwTCvtZx95JrH06mHZKOSvh/m48ZzjOh1IfgaScieHHPxQjBW5KNSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042136;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jQrmazHhtJ56f6o+Qpxg+z//z35oOoE6qX7c6RHsoA0=;
	b=dDxCWg7Pzg/0RKRxiE899A8hyZA6bpRyyRR+RCuBvEb33tTKGeWbVl+68HK+3U9iSCaE
	 j4Z0z6DcohchZ2+RWslj/YSiAhU1d+/swNoRo7RlvIcQEB8ApGmAbxtxdCK9wT9Jl5Mv/
	 Y0H2JMcw9kaRhNSvFknKSsvQfIymxJqmVuvrlGgjGg+R4KqbicVioEsBkcI26fX9Pb9em
	 0tVcVrCGbeZIYiaKBjQHtPoFrKvZy7Mvf550TfUr843cNNrfyqmohM6WyN7CSGRAMyCn6
	 HdpVkbPmvesUXtS20uI6EztO4vlpB7KkDGcdFZiLBwGf3WOauTDtw9oGlJ5hOLLWrxg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042136;
	bh=jQrmazHhtJ56f6o+Qpxg+z//z35oOoE6qX7c6RHsoA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nfZpZzwUlm/uPV/yQ/YZ1ZQZ1yg2kOFVxKwlDIccJVpeM7fGrEREUPe0AGCOiIdjE
	 va5LkJ91Wx5kFyktbzLtlfr/AsAftm17+f6eLn7Z1ubZuU9b48LqkmPdlYXnCJ0Qne
	 +mrrhYsRcLAU0fzoMTjB+AFNXbtlxKmQphpNNXQUzH1BmdlWCawzy3nXj6Khdr/6nt
	 iuGCbMEImXEnyWXfh/gSJgyI9mIIs45amaZ2LNoXAhNL30a6q2jhhLeG1UgQwf8CWN
	 huvwgSGFuc5qqE01PhxGYN9sywpZ6BdyHiP96DLZSyhADUBQyY2MuxwNOg62XeKeKQ
	 +lyWnjYgLAFGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A50C8606B3;
	Sat,  7 Nov 2026 09:02:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8250A2FE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73E5140634
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 63yubSZQGWmS for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:02:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4544C4062A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=wZOnPvTK
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4544C4062A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:12 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jM96821NzzKnBt;
 Sat, 07 Nov 2026 10:02:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794042128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQrmazHhtJ56f6o+Qpxg+z//z35oOoE6qX7c6RHsoA0=;
 b=wZOnPvTKwZWlLgzmzWQw8s5HZGbKPQ6pyICNiSY55fJmOaBXfCChimWt7FG+iY2naNNq9H
 9oUMOf56gMkcEIbRmDDv0oU/hREMELF31lIaSxtYw9crVHaGuvU2O3/3/itOphbJ6tusU1
 VsQPpDtveoXXb155wcRhUp4SZyVpj71Rmq+SpTkQ5WXvHmt0kA2R3c2/zUku0G0zgwnMZs
 FmVxREh3jQhYxjixbUdF8RYRjOX5cSCX0WCNf0ol+jSoLLaOIyImqMwpZWQeQX7KPgVbm2
 xClgZaT/OrthJP2vpliq0Tk2MljVRFneB7QIyxd30ATIio0rTYRlPiPgGZc5aA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 1/9] watchdog: wdt-uclass: add get_timeout operation
 and helper
Date: Sat,  7 Nov 2026 10:01:55 +0100
Message-ID: <20261107090206.2015512-1-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-1-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-1-07de25b6312a@nokia.com>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: grc818xgx75rrwacwycefxt4kude77xd
X-MBO-RS-ID: 9774db963d6f502af32
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

> Currently the wdt_start() function uses the plat data to
> check if a driver has reported a max_timeout_ms value and
> clamps the requested timeout to that value. This is not enough
> on devices where the effective value is not always static.
>
> Add a uclass get_timeout operation and helper so drivers can
> report the effective timeout. The helper returns -ENOSYS if the
> driver does not implement the operation. If wdt_get_timeout() is
> called while the watchdog is not running, drivers should return
> -ENODATA. wdt_start() uses the helper to report the effective
> timeout when the driver supports the operation.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/main

Thanks,
Stefan
