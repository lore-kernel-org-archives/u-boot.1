Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C792606A32D
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kKo85Qs1;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=mkNyIORM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 035F381190;
	Fri,  6 Nov 2026 16:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3KZmIhKGny-x; Fri,  6 Nov 2026 16:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9A48E81203
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793980967;
	b=ahYeHRPHEmQvxG/ooonH7dKfK21yh12nPv6cBOOvx9xqB38fysxRTDSztuA5DrTcLkOC
	 mlYOLvy2cYRf/viWTnkuS3rk1+kqrXYAoyAlMI23sdG1wNL6IahITFsWurNoBlP/bKIXP
	 5GzaNc/Y2qb1ZGBdBn86iAsB5b7U5qDFDB0m1MwteREnSFojo7WEfH0LPlAb8CFo1ZE/t
	 r/Mg52Elud0+58w1ckE0WMbyUsyJ8LnQtm8xmr+z2xgnxUP9i7T9GMLmVfM9orrmPTKBJ
	 B8RRodSP6Yxva7zLZp6F9H04jzM2e5a45brYph1Vp6wFL2DQQIsrrUm9Z2ZXwAoL2ZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793980967;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R8K7TgByJFt9S72V08ARe4+0y44Jwg4/Vs8qDypptJw=;
	b=Ku4ALyLPTX2YOdSAe5NvjCNlaF4pypFg0Royz7IGvMg+AsN1NqUTUPoqzOSZ4eKoBdpm
	 fuuSP2UwbRH1xQlMt0tTQtIIJ1PMOCqDZzuWUcRKxOENmtCXwCOteHzftBFHF8AX0VEgF
	 i0pcL6mnYVWZsh6tko7aF6qeRDOo0FNtfCh4vhX2IGIbsjITk9u+tn0lNyBmG1Te3f7Wb
	 2T+22A+ro3QModq16nmSVQmCC5/LexSS78aFhdqks4IZwRi1wY06z5CBj4+e2UZqU4Joy
	 l9CMS+PreF3geXkUXA0tDVXVwhulZrebFLvVaFVArLXB4Yedz2lLjXIbPo/CgcIrppA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793980967;
	bh=R8K7TgByJFt9S72V08ARe4+0y44Jwg4/Vs8qDypptJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kKo85Qs1LqRStDY1GfQc53kttP8W+7WJuenVDoz8HVm0ISjOENguRz/rGJXrniCGW
	 CpDyEKpm10kZMsALRBGP6snpXerkkCse4xPYpleFqCQFO+7OHiypj5Z/4qW2rdKUHW
	 dcurNAkU6XKHSxTbDVlNtcM43Gtu0Fubx/JsDfaDTGz5aQU9JYxo2lLK3Cg2Obe9PL
	 5Vh+uNK6sNQ7uoI2if/P1Ru6y/wDYusnj1wjJ1Y1YHcCT/C87brOwK3rlTtb1kVtnB
	 n4Hmx/7rOuspQmaMjpHKKp3aiLaGKHCZ2hz8CioemHlwKEmxiUEbhgPQ7CeIMLMS+Z
	 5E6Uad5WqnoMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A48E81203;
	Fri,  6 Nov 2026 16:02:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5ADAA2E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40BCC6085F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZx4ejDMZcak for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 64675605D0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=mkNyIORM
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64675605D0
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:43 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jLkTq4xfBzKnC3;
 Fri, 06 Nov 2026 17:02:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793980959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8K7TgByJFt9S72V08ARe4+0y44Jwg4/Vs8qDypptJw=;
 b=mkNyIORMuvAooSvGnYB386AqvxtCM6Jk5fQBblsyTNnf4fp3uJAygfgU44t3IVHJI1IsoW
 usfMlgmQuN5i/L5kHDbfgAaAFGPat9VprMKIbjKRCmFq2nsB92QtTCNvjVeyCMmKBvVnP8
 Y07DBSIPbk+cEcr4ew0ZrpwlIyBSnNC9L+WC7baoxzzIu+i+7b7xoQC9X1W4aGQdzmu74p
 8K0lg0UxKRrycUrY0BYg5dN3YijXDmhutji0ugOOPDqWwjUfhGjkenfdYiaLRSOyfh9c4f
 BfW/Cof7NnLfQZso693l9+Hivfvbv+OA2w91EI8MX/0FxeHPUc7ICztKXSlOGQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 2/9] watchdog: warn if timeout not longer than
 servicing interval
Date: Fri,  6 Nov 2026 17:02:28 +0100
Message-ID: <20261106160236.749429-2-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-2-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-2-07de25b6312a@nokia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y1f4eorr88z511y4qzmsomb5ecdhena3
X-MBO-RS-ID: 1545ccb83e3e0ffc071
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

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
