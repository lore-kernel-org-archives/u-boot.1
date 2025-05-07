Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A60C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 10:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3593481F32;
	Wed,  7 May 2025 12:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="q2uVsprx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F81882153; Wed,  7 May 2025 12:06:29 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E1E8007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 12:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C58C644F34;
 Wed,  7 May 2025 10:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F391C4CEE7;
 Wed,  7 May 2025 10:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746612385;
 bh=nxzRgxzMEcqj+/yyfU4p/h6wm4bnaw76E3GOVkOkZDU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=q2uVsprxGsjU8/9Q4713d/La314d9ibuv5w06wutvGYy8wUhfAsXVOjhgySo5rnoj
 dYzaLv60hnmOQ6IbzYs7Ek6dXuO2UhWi5PEBfZy4nXMmqXCjcTRo4iZz1ba6p4GXZN
 zP8ywSTjCaUilBAkB8vFUsTpGvpvxL93kgPa3XsMkXoxt9r9fnmPYBA5LlM1R5aMeP
 peWOz+i8QV6aVMrs5XqqBhYM+Xk/O8qihD61Kn6sKshIiaFupv2fFhuE8TDNRzLrYG
 Z2QuJUoOJN6UbPD+mf6SW+H5xSoZ30KXUpNFjMJLWgig8JWYRQl1+VTqKtzOJQ39sb
 GOOyjTJhuGJmA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v3 2/3] fastboot: blk: switch emmc to use the block
 helpers
In-Reply-To: <20250506-topic-fastboot-blk-v3-2-d94be5829f46@linaro.org>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
 <20250506-topic-fastboot-blk-v3-2-d94be5829f46@linaro.org>
Date: Wed, 07 May 2025 12:06:23 +0200
Message-ID: <87ikmcag68.fsf@kernel.org>
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

Hi Neil,

Thank you for the patch.

On mar., mai 06, 2025 at 18:10, neil.armstrong@linaro.org wrote:

> From: Dmitrii Merkurev <dimorinny@google.com>
>
> Switch the mmc backend to this new shared block helpers,
> reducing block logic and only leaving MMC specific logic.
>
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/fastboot/Kconfig  |   4 +-
>  drivers/fastboot/Makefile |   3 +-
>  drivers/fastboot/fb_mmc.c | 210 +++-------------------------------------------
>  3 files changed, 16 insertions(+), 201 deletions(-)
>
