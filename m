Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F406F9B5FE
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 09:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49EE8423E;
	Wed, 22 Apr 2026 11:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="I3qDvumY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C3183936; Wed, 22 Apr 2026 11:38:02 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFDD583936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1wFU1u-0001Xd-Rm; Wed, 22 Apr 2026 05:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=24a+TwvTxdv1mFyCM2szNW3XvpXQSsE1ajALLsNOrbc=; b=I3qDvumYUpr+I5r30bV8
 tqlrrsbO0XFFGV1ad47hb4X4kMCJCOQGehkxxG6WSriSEUKivfdE74mZIfCmzM51SMAi3D2K+sSFm
 MHp9hlASz1FkmaeCR78FgA5K2GGQ/2XMCI8ScKz8LEGAKdPgviGButdwybkWw9fKqEYvYrt2Mz4KE
 U1Ew+uWDwET48R2sqowRwMmVNbuYvzPytdI02gVrijJu7o/t9IiI12C5uCAfzSP8T5buQeQSQQjMZ
 yLHMqsewYIOQPaDylp3lUgcXNU0n3UnZx31pc+XZksB6pnZGr6pEHeP8yyW/2PoyqmVacmk/CWwg1
 /D+D+L/GAmPjXA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,  Tom Rini
 <trini@konsulko.com>,  Paul Barker <paul@pbarker.dev>,  Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>,  u-boot@lists.denx.de
Subject: Re: [PATCH] misc: Add RZG2L OTP support
In-Reply-To: <1f4fb105-9f77-4dec-871f-00d90fa0d169@mailbox.org>
References: <20260414091422.16952-1-othacehe@gnu.org>
 <a0bb44a6-1805-4c0c-b7a5-0d9d31f9d6b7@mailbox.org>
 <87wly6rp7f.fsf@gnu.org>
 <1f4fb105-9f77-4dec-871f-00d90fa0d169@mailbox.org>
Date: Wed, 22 Apr 2026 11:37:56 +0200
Message-ID: <87o6jb1gjv.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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


Hello Marek,

> How about adding a new node into the DT which represents the fuse controller ?

I did that in the v3 :)

Thanks,

Mathieu
