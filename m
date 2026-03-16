Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8EEF4643B
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 09:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D82583FDE;
	Mon, 16 Mar 2026 10:39:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ai14Rjs+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21B283FEC; Mon, 16 Mar 2026 10:39:45 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF7D383FDC
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 10:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C5B04084D;
 Mon, 16 Mar 2026 09:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AFDC2BCAF;
 Mon, 16 Mar 2026 09:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773653980;
 bh=eBFeZoZD7eGyvRZCs4LJLEXEOQhO2qe/+G18VpJ6k+A=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ai14Rjs+MCvnsALojXpkbD742BA2XiDwHwQIJjFXpjfJuB6gfP1sJfCvuqfP3Oe/A
 2ZdVKR+3B/f33MXMFsqp+LKekoUPWzkv8197aqHfc8OH3sE8BAWJDiCdFdHNlQtEGh
 7cjY6fYVJUTgWUp6h+4amsj4YcVlzJi0Qt7H4s8b0rmp78NmwVqZvXGxFt5HUL9iJ9
 +E7t8vh/fI6927DAog+eE7ValLlt65vzEIiRj6Z0cBE6FA6PAzh8O4pgMWUR6evIhX
 vJHUzsrCK2x3+PbEfDhkyGWXMoH5LCRxTwbjCv2Vldiyc7EAn5RVWU0MYg0Fgztkrm
 pE6nXaLP+lMzw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20260310162621.1163932-1-trini@konsulko.com>
References: <20260310162621.1163932-1-trini@konsulko.com>
Subject: Re: [PATCH] dfu: Make the DFU_WRITE_ALT symbol available outside
 of DFU
Message-Id: <177365397761.1042202.2813832200651004957.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 10:39:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

Hi,

On Tue, 10 Mar 2026 10:26:21 -0600, Tom Rini wrote:
> The DFU_WRITE_ALT symbol is used both directly and indirectly (via
> UPDATE_COMMON) for EFI capsule updates (FIT or raw), but does not depend
> on DFU itself. Move this symbol outside of "if DFU" to remove a Kconfig
> dependency problem.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] dfu: Make the DFU_WRITE_ALT symbol available outside of DFU
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4b77b07811c2fb48b4a65ae14c387540ae6b8998

--
Mattijs
