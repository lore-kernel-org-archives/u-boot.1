Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7561ED3ABEF
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 09:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9B7A839DD;
	Mon,  8 Dec 2025 10:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tZ4bkTiT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 920B683AB0; Mon,  8 Dec 2025 10:06:24 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86BFC838CE
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 10:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2CC1D6013F;
 Mon,  8 Dec 2025 09:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DEDC4CEF1;
 Mon,  8 Dec 2025 09:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765184780;
 bh=O2SERhAlIS/j4xR+HaCGK6DOGGZm+94hrycQSDQjOTw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=tZ4bkTiTBPkfS3vi9ZqP5+q3pdMYmEgQilvjUQFYoXZ/8MYy5xVLQbMh/O8FZmgtm
 12NQBWgISnmU4u+K3DhWcMSuZEqyXJAOtoX78OziBxrAzFZyDwB9r86LDaYVrliW9H
 0P04sXUc6qKdTA/qzzvy/vMow2YTaRCSFDSCRS5N1EoJYXJrprM3gwQ5Y2w+uyeOQd
 Ego4fXx6O3mLAO15YBH5W5C9bSh6/4neTN2ewItgQc8XCHjn1M2OJnUkF9q0TeqbS/
 n+btuBKRvECz7YWXg06GsBdF6IdiOU1i1viJZ9CEgR2Ks3cCgjx8/2bmj1jrdWmxeN
 NZKBRKBRixaKg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Udit Kumar <u-kumar1@ti.com>, trini@konsulko.com
Cc: nm@ti.com, u-boot@lists.denx.de, mkorpershoek@kernel.org,
 n-francis@ti.com, anshuld@ti.com, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v3] doc: board: ti: Add J742S2 support
In-Reply-To: <20251207132230.868264-1-u-kumar1@ti.com>
References: <20251207132230.868264-1-u-kumar1@ti.com>
Date: Mon, 08 Dec 2025 10:06:18 +0100
Message-ID: <87o6o99wc5.fsf@kernel.org>
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

Hi Udit,

Thank you for the patch.

On Sun, Dec 07, 2025 at 18:52, Udit Kumar <u-kumar1@ti.com> wrote:

> J742S2 SOC is derivative of J784S4, most of build infra of j784s4 is used
> to build u-boot for J742S2 EVM board.
>
> Add guide users on how to build for that board.
>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
