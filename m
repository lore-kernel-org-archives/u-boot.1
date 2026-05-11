Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4DBCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 09:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F2D846BD;
	Mon, 11 May 2026 11:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IerSTq6z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C238784865; Mon, 11 May 2026 11:08:21 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9795846AA
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 14CB96001A;
 Mon, 11 May 2026 09:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE55C2BCB0;
 Mon, 11 May 2026 09:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778490498;
 bh=wwjRKBtqxd1RvDsUvWbVKUNzCKTdRddH2jCI+JGtwHI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=IerSTq6zK0f07Ch6ZvMdXrPaE0CG7I8iaPjBH+YcNiPg4oPbab5fBYj24jVA//wop
 TSoUodGi6I62qztOViwo+pfkkY9ns99Wk1r4VwCucU2dCRuHuLWk42EHtUzHwixd1W
 NjbH4Xs2RzlRgsTW/qlRh1mbKKTyiNH2Afuw4TNek7pePqBjw3IBgH0iKdR6CXY+FR
 UKJIgaASttqAkk/AYv5DCDLL+x2f3n5/27Fjv9EzeXAjcyNVZqhvlssMEY8C9I5bq6
 AjDkn1Tz0/zRNGIVVOx2p0TVmx5tfnCbXtD13+RJtlN+Veu1MMtlbXHmg+rBVvfW3/
 9YG0+mY/7SXRQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Casey Connolly
 <casey.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Kaustabh
 Chakraborty <kauschluss@disroot.org>, Kever Yang
 <kever.yang@rock-chips.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH 3/3] usb: dwc3: generic: Staticize and constify driver ops
In-Reply-To: <20260510171649.56837-3-marek.vasut+renesas@mailbox.org>
References: <20260510171649.56837-1-marek.vasut+renesas@mailbox.org>
 <20260510171649.56837-3-marek.vasut+renesas@mailbox.org>
Date: Mon, 11 May 2026 11:08:16 +0200
Message-ID: <87se7yuxdr.fsf@kernel.org>
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

