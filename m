Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59ECCD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 10:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E608D83FEC;
	Wed, 10 Jun 2026 12:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Oq4ZvAe4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E7F4841C2; Wed, 10 Jun 2026 12:08:41 +0200 (CEST)
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch
 [109.224.244.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1146A807C4
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1781086118; x=1781345318;
 bh=GO3HzfiWeRcnI7q2zxjhEejmdr/NcYNx4yru8NuxpmE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Oq4ZvAe4Rqxqy57ynMiiOTlti6BDWDjqcNL50rFvv5dtELb41pVEzI7F4BLYdQvIF
 oy73sD/olvKpuUIchfLuD+Hi1rk4hJW5i6660pAvJHPZeLhVxwexJWJAJBNIekiaAW
 7TRwsu53uff9e5giHm7Kdp1B1EgTCIcQjM3DoIkG6g7kR9EIfVtTAwueqWbvOpRtZl
 9KYC2J5EKSixbF075an8cr8TK8OHmwukPGglLF1kKhfJtXMXyieQGeqoSnOwoonUKy
 /70HnMwcvyI0d/NdGbv8dmgIbH430aM5/mgj5SREOsCMhj/4laag4yGBde2fD7jOgb
 OS5Z6lovSDFAg==
X-Pm-Submission-Id: 4gb1h51lKyz1DDKy
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: <u-boot@lists.denx.de>
Cc: "Tom Rini" <trini@konsulko.com>,  "Simon Glass" <sjg@chromium.org>,
 "Quentin Schulz" <quentin.schulz@cherry.de>
Subject: Re: [PATCH v4 0/3] allow control DTB to double as "FIT image"
In-Reply-To: <20260602213013.558064-1-rv@rasmusvillemoes.dk> (Rasmus
 Villemoes's message of "Tue, 02 Jun 2026 23:30:10 +0200")
References: <aCmpHnZEXcpacr17WR2tm6Q0j2ueBUlvPHGCKvwwR9vxbxa_MS7Z_sw8J_URvO7dCZ_he6LLPMS7cYo6aiEwfw==@protonmail.internalid>
 <20260602213013.558064-1-rv@rasmusvillemoes.dk>
Date: Wed, 10 Jun 2026 12:08:36 +0200
Message-ID: <87zf12pv17.fsf@rasmusvillemoes.dk>
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

Hi Tom

I know it's only been a little over a week, but can I ask you if you
plan to apply these to -next, or if there's more for me to do?

I have tested them on some real hardware and they do seem to work as
advertised, but I'd like to backport them to our 2026.04 branch and test
across all our boards in CI, to give the feature as much testing time as
possible before 2026.10. Which I can of course do as-is, it's just that
I really prefer to only cherry-pick stuff which has a stable sha1 and is
in or heading into master.

Thanks,
Rasmus
