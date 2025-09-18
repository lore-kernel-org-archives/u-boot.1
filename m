Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174F8CAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 14:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BB0181E13;
	Thu, 18 Sep 2025 16:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="Fh+iMHmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE0782ADA; Thu, 18 Sep 2025 16:39:37 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 717AA80B9B
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 16:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1uzFnF-00043u-CG; Thu, 18 Sep 2025 10:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=uJS24/rLDlSDYLVJnnSdNMQOUYEYQro605B15MDWPco=; b=Fh+iMHmzIrS4FzMaT0lG
 KF+h/aHG90WFFH7hSQX12dPbxjTdGjw5n5WLI9yoRPhqga9sOXP4P+1A6RSm2PySpFxX2rLNzZ0s9
 ILwztw4F5XtEAHaz8HjfhyhnEZY8MguiBnK6s9DKvXzJmje8lajYXcJxxPw6ZNZdTnHd9ZXzAfM0a
 ES9WerBWuJavzWK5qqVi16jvccGL8HcB6MqMfWjfE9d12L/zG1w9LltnR/XWG9MKTId+RvWjcstpe
 yzp0fw4R8xgM9lJyz+p1JEyxWwog15Kook+1K+h0r6wMebJnR/rS6CVwfIf/GFvTKI7VwyI+SDrAh
 Yy7rqntC5lqG2w==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: anton.reding@landisgyr.com,  Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tom Rini <trini@konsulko.com>,  Paul Barker <paul@pbarker.dev>,  Peng Fan
 <peng.fan@nxp.com>,  Sam Protsenko <semen.protsenko@linaro.org>,
 u-boot@lists.denx.de,  Biju Das <biju.das.jz@bp.renesas.com>,  Chris
 Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH] board: rzg2l: Do not expect a DTB blob from the TF-A.
In-Reply-To: <173f12da-c201-4272-83a1-f70f2d4ca47b@mailbox.org> (Marek Vasut's
 message of "Thu, 18 Sep 2025 15:17:19 +0200")
References: <20250918124827.5577-1-othacehe@gnu.org>
 <173f12da-c201-4272-83a1-f70f2d4ca47b@mailbox.org>
Date: Thu, 18 Sep 2025 16:39:26 +0200
Message-ID: <87cy7nhlk1.fsf@gnu.org>
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

> magic validity first. Is the magic actually valid in your fail case?

So to clarify the situation, the mainline TF-A does not have RZG2L
support. So the only one available out there is the forked Reneasas one
that I have mentioned up in the thread.

Now, the mainline U-Boot is doing:

--8<---------------cut here---------------start------------->8---
	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);

	if (fdt_magic(atf_fdt_blob) != FDT_MAGIC)
--8<---------------cut here---------------end--------------->8---

unconditionally, with rcar_atf_boot_args[1] being NULL as no arguments
are passed by the forked Reneasas TF-A fork to U-Boot.

I could test for NULL pointers as well, but I thought that getting rid
of that piece of code made more sense as there are no TF-As out there
passing such arguments.

If you think that it will be better to take the problem the other way
around and modify the forked TF-A to pass that argument that also makes
sense to me. Picking one of the two solutions would allow us to have
something working out of the box.

> Also, enable CONFIG_DEBUG_UART in your U-Boot config, then you will get very
> early UART output capabilities, it works even before DT is used.

Noted, thanks :)

Mathieu
