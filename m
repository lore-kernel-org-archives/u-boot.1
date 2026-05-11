Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49217CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 09:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA701846BD;
	Mon, 11 May 2026 11:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c2rVRixZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADDDD8484C; Mon, 11 May 2026 11:07:48 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFBB3846AA
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 363C040964;
 Mon, 11 May 2026 09:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3E9C2BCB0;
 Mon, 11 May 2026 09:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778490465;
 bh=wwjRKBtqxd1RvDsUvWbVKUNzCKTdRddH2jCI+JGtwHI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=c2rVRixZWSTdyTJCIfrvwY09XA2n3hL1bccVs3Ogvi238LYZpr9OUOVEekfMnsUU+
 z56Unq5W1A9b/s6Ti9rk5RriE5DhNxnwK5eURT4BLQhHzLDti7sMSfOD2bib/ZQFdE
 3WiWTjLNh8tYYtIOyPa9hgVdsiZc+OA0EiiK7vYoyRhxv0L9LfQn8dI7/qpce5dmg6
 9vSct8CrnMEbJP5qzBWnSWPhVxrFDzb2szJG3R/ymJKgZ72DS++ED/rHqUgcXg4Pjb
 E/GPJeQyIUPd2JH8W55Gbos/tSbeNmuqpMkDrt9aGp6ScMcGMLoAktQ2i8/8+FNal2
 dQMlknmv5JKGw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 1/3] usb: dwc3: am62: Staticize and constify driver ops
In-Reply-To: <20260510171649.56837-1-marek.vasut+renesas@mailbox.org>
References: <20260510171649.56837-1-marek.vasut+renesas@mailbox.org>
Date: Mon, 11 May 2026 11:07:42 +0200
Message-ID: <87y0hquxep.fsf@kernel.org>
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

Hi Marek,

Thank you for the patch.

On Sun, May 10, 2026 at 19:16, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

