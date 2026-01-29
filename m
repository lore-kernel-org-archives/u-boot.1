Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCFBD6B07A
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBDFA8402F;
	Thu, 29 Jan 2026 17:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mTGXLiN6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0711C84033; Thu, 29 Jan 2026 17:17:54 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0062A8402E
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C6357441C3;
 Thu, 29 Jan 2026 16:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489E6C19425;
 Thu, 29 Jan 2026 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769703470;
 bh=H+yGvQt81g6ojQzmyHMramXYetqyOdYLSStk7EYa6vM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=mTGXLiN6HHAD+u1udhl/dE+ji8QkzhGj3W72qL7ZgYM+Hb8rqa0YTvLrMUriPOSAU
 1XA3i1HKD6Jqlk1ifJNDSnsgHPLRz5CEWkDBnpmES/cCf/e5ITJ9WcPYQ5eQWImjB6
 05ZpyhCVrs0JSVVP1o8u/IzwnIUU5D2QPcNs80TaHoEoXXAt+KvRJDm/GnUilMG/i9
 LDw+z4GNJL+jECOgpsCi9KGifu0Ri1eiUWgELYXxpnry49PU/FmbB6MVDuuR7efyuu
 x2nzqmMkaWqOxFBqP0fVpU7a6RO+KVrxuk9OBaveTXwcF4EHl6gPX8NPKpGJEb6k4M
 H9Lqj52e4p2dw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Graf
 <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome@forissier.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yuya Hamamachi
 <yuya.hamamachi.sx@renesas.com>
Subject: Re: [PATCH 2/3] configs: sandbox: Enable zip command
In-Reply-To: <20260127235914.1503663-2-marek.vasut+renesas@mailbox.org>
References: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
 <20260127235914.1503663-2-marek.vasut+renesas@mailbox.org>
Date: Thu, 29 Jan 2026 17:17:48 +0100
Message-ID: <87tsw4mlzn.fsf@kernel.org>
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

On Wed, Jan 28, 2026 at 00:57, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> What is not being built and tested in CI, breaks. Enable the 'zip'
> command in sandbox to get it build tested in preparation for an
> actual unit test.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Cc: Alexander Graf <agraf@csgraf.de>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome@forissier.org>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> Cc: u-boot@lists.denx.de
> ---
>  configs/sandbox64_defconfig | 1 +
>  configs/sandbox_defconfig   | 1 +
>  2 files changed, 2 insertions(+)
>
