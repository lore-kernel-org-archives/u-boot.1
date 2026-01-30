Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9682CD49C66
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 07:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E69F884206;
	Fri, 30 Jan 2026 08:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PuRDqUpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 333F08421A; Fri, 30 Jan 2026 08:49:14 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C38E84205
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 08:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F1C5E41AA1;
 Fri, 30 Jan 2026 07:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73690C4CEF7;
 Fri, 30 Jan 2026 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769759349;
 bh=s9dpjtAfikWSBPhoY9LC/T9OMmAKM3EubUE91gPu8oE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=PuRDqUpkItNMHeYI1qaXqOoHgeKfRwbjTvk6L7kI2unHBtut8pQz3xvI7xFWcWXyY
 BGOlULg3H94+/Rx1B5ehBS2n1LLRn9ClRvlLhFF9XzYKLykDPZZX/nv9HbI2W3uwKT
 arYnA+XPjSNaTLlemk9ZnZHIX5vnjCo4cLtSjSfvxWWcsrgJ8HxXG34ARY9woNzvY5
 D+PBnqSElXs750QecV2Gq2lzfq83JvylKaiSPis2ndIHPC2btM4B/5/4NpxwX/6Bnb
 zos5DA0Oj0JSlonMTexDRaSATLW4bRungsqNAny1HJqgYaGRHhjohM87YE0Eh+iyth
 wBxIyMZsrvzFw==
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
Subject: Re: [PATCH v2 1/2] configs: sandbox: Enable zip command
In-Reply-To: <20260129235647.660906-2-marek.vasut+renesas@mailbox.org>
References: <20260129235647.660906-1-marek.vasut+renesas@mailbox.org>
 <20260129235647.660906-2-marek.vasut+renesas@mailbox.org>
Date: Fri, 30 Jan 2026 08:49:07 +0100
Message-ID: <87cy2rmtfw.fsf@kernel.org>
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

On Fri, Jan 30, 2026 at 00:55, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> What is not being built and tested in CI, breaks. Enable the 'zip'
> command in sandbox to get it build tested in preparation for an
> actual unit test.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

I already reviewed v1 at:
https://lore.kernel.org/all/87tsw4mlzn.fsf@kernel.org/

But it seems the RB tag was not picked up :(

Adding it again:

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
> V2: No change
> ---
