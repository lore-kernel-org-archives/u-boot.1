Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374FDC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 17:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0FB9848BF;
	Mon,  6 Jul 2026 19:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aPC8UVjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF78846FD; Mon,  6 Jul 2026 19:28:11 +0200 (CEST)
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FE5846FD
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 19:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783358888; x=1783618088;
 bh=UUFbMrZfGE4/eEQHDs1e8v9ohI923PrDkY4xUwK9zro=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=aPC8UVjvn2mGoATVczMXXV54gLtdRfkhWEZDD/Ur4SBox7AqU6zChROwHDNEn2n7q
 kYSq2FasMGKKxv6jQOTo6cFkS/PaJ90MUufRPVij+NoZhmnT0XT5lbg1AWbdvLU9RF
 6ZOrWeJVLT1IwgMsPIsQ12gR6QAG3ZnBAVAayDOIL/BJb/ttdFUvu7zAcrYOwbb/2Y
 6ThtrekGxbfF5G9IqTWbpyK9XFmD0MvBynDKrDPwfKygFlRFJSfwAkxDQH51ZhjvYw
 hEng7DolY2c6z4w8hBP1u9F+0V0oBIouUgXC2MZzgvs8zlHOYzn11hWrmLMu6OgAls
 x9SLBAqAChmFA==
X-Pm-Submission-Id: 4gvBCB5Nmrz2Scsg
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Patrice Chotard" <patrice.chotard@foss.st.com>
Cc: <u-boot@lists.denx.de>,  "Stefan Roese" <stefan.roese@mailbox.org>,
 "Tom Rini" <trini@konsulko.com>,  "Marek Vasut" <marek.vasut@mailbox.org>
Subject: Re: [PATCH v3 0/2] cyclic: update and optimization
In-Reply-To: <20260706-optimize_cyclic_run-v3-0-06ecbd74ef7c@foss.st.com>
 (Patrice Chotard's message of "Mon, 06 Jul 2026 18:06:07 +0200")
References: <06AYLlZJayftY3ITyG07ouD_oc-X0pMFXqzrLEm_rtDW1xG8060KvmGZPZ_IQJ1g5Bz2KXoMLI4N3lrK61fDjg==@protonmail.internalid>
 <20260706-optimize_cyclic_run-v3-0-06ecbd74ef7c@foss.st.com>
Date: Mon, 06 Jul 2026 19:28:05 +0200
Message-ID: <87jyr8vxi2.fsf@rasmusvillemoes.dk>
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

On Mon, Jul 06 2026, "Patrice Chotard" <patrice.chotard@foss.st.com> wrote:

> First patch is replacing uint64_t by u64 as suggested by b4
> Second patch optimizes cyclic_run() to parse cyclic list only
> if a cyclic function's timestamp is elapsed.

In case the cover letter is used as a merge commit message, note that the
latter description is no longer accurate.

Rasmus
