Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151E4C5DF66
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 02:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25CE980F78;
	Fri, 14 Aug 2026 02:39:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NacIFrBxwf1s; Fri, 14 Aug 2026 02:39:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D57BD80E5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786675191;
	bh=lGnEnbgYVcieBMVxCBvatX9xbgdE6Wyv235d7V9tDrU=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Q6/O64LLcXgppBv+p5UOw1qIkajmO8L/XwGx6rUQL5J8j5uqszyE2hS9Lnonm3Lvv
	 toe51grcOeZyd9WUJm80i3m2xPnKI+CGALlcvsZTXzkVTeITmFagebYjdQr6SD0LS3
	 wnSUkeTk76n0qMuc6xbeaLNCzoKXRaDdo2QgzDlm9LCODWgClUF7IrUZtM6XAOoVkt
	 GgIkqvAhZbX62BYfqmrdof9LJ49UQQjrAIRgTL9fSulvOQsHS7l4MKXyfvD+/0TN1L
	 g2Z3y0GRC25Pa4FitQ1gXlDNvqccNOBtCnX3r/Fbk2C0Sft+D8u2xbiegbJ3zmcz8u
	 GJsbaytJc18SQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D57BD80E5C;
	Fri, 14 Aug 2026 02:39:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D383139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 02:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72B2760648
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 02:39:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e0VxQLJCw04E for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 02:39:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 74A82605D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74A82605D6
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74A82605D6
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 02:39:48 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hLmf86YzVzKvt1;
 Fri, 14 Aug 2026 04:39:44 +0200 (CEST)
Message-ID: <fcc57f50-4de3-4d64-8ee9-8de9c4e4941c@mailbox.org>
Date: Fri, 14 Aug 2026 04:39:43 +0200
MIME-Version: 1.0
Subject: Re: [ANN] Further mailman updates
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org,
 u-boot-custodians@lists.u-boot-project.org
References: <20260813201711.GH3297518@bill-the-cat>
Content-Language: en-US
In-Reply-To: <20260813201711.GH3297518@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: pfrwuomewx6hur3ze5m1dkiakyuy4x8t
X-MBO-RS-ID: b7c9fc1d0a1a60c62ea
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/13/26 10:17 PM, Tom Rini wrote:
> Hey all,
> 
> As some people have noticed, with the move to lists.u-boot-project.org
> (and OSU OSL hosting), there's been some behavior changes for how people
> who use an email provider with a DMARC policy set to reject (for when
> certain actions happen). This in turn lead to some rewrites, and then
> things like patchwork (now updated I think) or lore (is append-only) not
> seeing posts as expected (but seeing them as the email policy wanted
> them to be seen). The good news here is that we can get the lists
> changed to the same behavior we used to have (which also means that
> gmail might see us as spam more often, but... who knows). For the two
> low traffic list (board-maintainers, custodians) this change has been
> done now. For the main list itself, this should happen sometime Monday
> morning pacific, and monitored for problems.
Test reply (requested by Tom)
