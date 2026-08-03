Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B93C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 16:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0ABC160681;
	Mon,  3 Aug 2026 16:26:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1DzcAar0l4IY; Mon,  3 Aug 2026 16:26:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E2AF60648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785774371;
	bh=YkuLvjEPKlBYxAPF1tyMA3gwFtSlTRT9In3f2WKeg2A=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=D6XKTGrdhRAFNHEY+IQ14EBi0PAULz3iDNx/FhuxIv7NL8HQ60KvM5k91A1sE2EaV
	 bHjPpQ9g6PcpF8UyiPZjCw8mUqTN6zqZe7OC4KJi+yKSfpWQTb66uTgjrSq1cElkK9
	 0hbUZknoLolipXeM8+Co0r7UGJVVRSMMbgHfZgXL8QxJHSwShf39xsA34ytzc6VP21
	 MeSgvFmIWRBA0wFkN5u4KVdyspgoenh+CyHrf+sAik/lVfb6HySXNkcYtooWVJLMeP
	 8GQNPtx98N2gJg5/YP3Ok3teGX2KHBj1u6Ajvrxejvw/z9o7DrFnvLrvgDjAJQD1mK
	 O1Qm3A2C1yDOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E2AF60648;
	Mon,  3 Aug 2026 16:26:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D4F43A6
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 16:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F65E6061E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 16:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xUYUD4NW9_rS for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 16:26:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F39B0605D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F39B0605D4
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F39B0605D4
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 16:26:07 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hDMVj343fzMlG7;
 Mon, 03 Aug 2026 18:26:05 +0200 (CEST)
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>, u-boot@lists.u-boot-project.org
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/2] cyclic: return early from cyclic_run() if the list is
 empty
Date: Mon,  3 Aug 2026 18:25:57 +0200
Message-ID: <20260803162559.3212020-2-stefan.roese@mailbox.org>
In-Reply-To: <20260730105515.421677-2-rv@rasmusvillemoes.dk>
References: <20260730105515.421677-1-rv@rasmusvillemoes.dk>
 <20260730105515.421677-2-rv@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tc7o1jb8uxot686bk4cqi8j5u9zm6g6w
X-MBO-RS-ID: efed5942558d5de1ecd
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785774365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YkuLvjEPKlBYxAPF1tyMA3gwFtSlTRT9In3f2WKeg2A=;
 b=crVkZxOn9mXTAXKeDqOJlE2oljxddobKSDKSGr+PJWpEAMVO5Sf0QrD6ajXI96R8Fi5hH4
 iQAJEg5wiHW19KgqhG8xuHhU+gCW/lAH+tR6wyUMtPKuk/tvYDN1UXdHeM/4EEO6TIaVeA
 AmX2UlK9xrv1NZtdiDGVRZe2J76wcBJA7kXy+vH8DJST8ZtAu2EExgn008vXfd7bPXXGoe
 Xjfh3Ledk0KtruWPATGv4p/CEfz+z9h8CZ84cO/AmcyCMotM2cfQ8QOC2BK5CkZ5qA189L
 hFunDS6vxbDN8a/WIZh51kpfaxPaEMJbZ0gVlHja44K5ojOeMPsyf9W4t0hufg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785774363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YkuLvjEPKlBYxAPF1tyMA3gwFtSlTRT9In3f2WKeg2A=;
 b=oQjYt8PCu/e/voDDWI96BZPndRNvfKki/+/qw8gxUEOontK1Ts1Nm+EtIzrrxJcgiLYt2+
 Ng1K1KXTrfcFRUEEnf6zc5LsSHqu23PJlAX/GEoKOH7gfUIi3mC8uFYaDRmrVrjVUh3Crf
 gDMSUTz6tiApsdchfZDlTr/i5XNv58+M8takXSplMjGrOqYs4DBoqHAfE5Ns3OJHtV1XLQ
 bSnhur1D0kcjHMefRZAyaTQodAzEtf5wBcM6yHv/irXhWTL1MY64ZEloWDdnJVFFjcWnfE
 DKhfVjELvvr4xMKhDKhr3eK+uGLUEdBmxZZZN5+ddEnsyJ63jRdWfuWilluK7A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=crVkZxOn; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=oQjYt8PC
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Stefan Roese via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Stefan Roese <stefan.roese@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/30/26 12:55, Rasmus Villemoes wrote:

> It is possible that schedule(), and hence cyclic_run(), gets called
> very early, perhaps even from assembly code. With commit
> 9c1b13b3fd2 ("cyclic: reduce get_timer_us() calls inside
> hlist_for_each_entry_safe()"), there is now an unconditional
> get_timer_us(0) done outside the loop, and depending on the platform,
> the timer infrastructure may not be set up yet. In at least one case,
> that has caused a divide-by-0 and hence a failure to boot.
>
> Platforms should really ensure their timers are ready ASAP, and in the
> concrete case reported, that was indeed possible to fix that
> way. However, it doesn't hurt to also insert an early return here, and
> that could prevent other such hard-to-debug boot failures.
>
> Reported-by: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
> Link: https://marc.info/?l=u-boot&m=178481834846283&w=2
> Fixes: 9c1b13b3fd2 ("cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>

Applied to u-boot-watchdog/main, with a fixup while applying:

  [sr: fix Fixes: tag SHA length and return statement indentation]

Thanks,
Stefan
