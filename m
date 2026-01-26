Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110A0D13C0D
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 13:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3C783B27;
	Mon, 26 Jan 2026 14:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s2V4ULu0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B39083B97; Mon, 26 Jan 2026 14:18:24 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1773383B0B
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 14:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 385D641B4B;
 Mon, 26 Jan 2026 13:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2CBC16AAE;
 Mon, 26 Jan 2026 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769433500;
 bh=xdxJ6cLDvL3kx4SEy9pMp8NqcSiVi3QelRhyBlBKB90=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=s2V4ULu0lUron3fQ0e2SOQ7YS/esfEmTh8vbx3RPetNldbsAxYYw3RETWhQRu1gP8
 5VUcnHwT9q8m/8XrlrezQN9WB74XjKPS90159QunsNnB3BIYAwKb2abrBr5rJzCyWO
 QOiWKUCD+BTRY/tvZCgOrZ1tDpZtnget7Bsk5HWXvCPb0Tsl+D6sfHw38YqbTOpnbG
 n4y1erfhWD6YQtEgIR8AM5xy3bTuNMLk+EhamXqzVSb4zIdYSzmEBCdCo/qcr0Tnj0
 zIJCeScbnIFsGn5c/mKZ95636TGLBljCwK0pLq0npdDWu50VpjEVF60y5cQcjE97kk
 9yShlysRJAPZw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 5/5] doc: develop: process: Document using b4 and
 patchwork for custodians
In-Reply-To: <20260120223405.469050-6-trini@konsulko.com>
References: <20260120223405.469050-1-trini@konsulko.com>
 <20260120223405.469050-6-trini@konsulko.com>
Date: Mon, 26 Jan 2026 14:18:17 +0100
Message-ID: <87pl6wo6li.fsf@kernel.org>
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

Hi Tom,

Thank you for the patch.

On Tue, Jan 20, 2026 at 16:31, Tom Rini <trini@konsulko.com> wrote:

> - We already have good custodian documentation for patchwork, add a
>   reference and then link to it here.
> - Add a reference to the existing b4 documentation, and reference it
>   here.
> - Note and link to patchwork integration, am/shazam and ty features of
>   b4 as these are the most likely useful portions. Be specific about
>   keeping the default ${summary} as that includes important information.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  doc/develop/codingstyle.rst     |  2 ++
>  doc/develop/process.rst         | 29 +++++++++++++++++++++++++++++
>  doc/develop/sending_patches.rst |  2 ++
>  3 files changed, 33 insertions(+)
>
