Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20249CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 09:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C118485A;
	Mon, 11 May 2026 11:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="q1g23Dh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1ECF8485D; Mon, 11 May 2026 11:08:05 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A98AA846AA
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A10FF6001A;
 Mon, 11 May 2026 09:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70E7C2BCB0;
 Mon, 11 May 2026 09:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778490480;
 bh=wwjRKBtqxd1RvDsUvWbVKUNzCKTdRddH2jCI+JGtwHI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=q1g23Dh9n2Gr93RxMyU2rblalZj0nqDwKdDU/mvpgvRXbcdwLKkL1KWERwZs8fvwN
 MKifx6gnxg9DUfIATjrbRDB/nk/VkuMm3JVmBsGfYWDZuIl5N4RbwuTsfsoo9ckHSt
 ZbwSP1VtXmpc9EkEMZHtHHUcGxNusqm5WgPMnLV9DWCVJ38vJGlyRlCcdzAruXrTLH
 VQesBLOQgVrGp7b6h9P9Lseu39cRfu9jp9nxdHRmfCZpmjXFmnA6r2eGeCrcADuEGE
 ITbSv4ntSwYPCMCfEwsONOsMc6rf13mQrtdOBxKH2X2WD4TtRWLz/o6r2iJxqYz0nO
 ergId4boQLEgA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 2/3] usb: dwc3: sti: Staticize and constify driver ops
In-Reply-To: <20260510171649.56837-2-marek.vasut+renesas@mailbox.org>
References: <20260510171649.56837-1-marek.vasut+renesas@mailbox.org>
 <20260510171649.56837-2-marek.vasut+renesas@mailbox.org>
Date: Mon, 11 May 2026 11:07:57 +0200
Message-ID: <87v7cuuxea.fsf@kernel.org>
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

