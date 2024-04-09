Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD13CD1284
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 12:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29B7E87D2F;
	Tue,  9 Apr 2024 14:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CvLv35oP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 918DC8785F; Tue,  9 Apr 2024 11:46:08 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1528788155
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 11:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pratyush@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B5F3A61689;
 Tue,  9 Apr 2024 09:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0CDC43390;
 Tue,  9 Apr 2024 09:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712655963;
 bh=8mmVrWSyW+OPvasYLUhCklXUhoIqH+UEGYXejP6knSM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=CvLv35oP2BttVdluvHUFgQHNDqjTJ5U5TIYFKe+HJUJPfJstXSG4w4Jhuy+1cWYEO
 blj7kaMimzx3IS1s+FmOnP98YvLDQvWwrExqd8t5PBAsyPoMV7OBxbsVk50qrnGOOG
 rt21PNFG4NzwwTqrrsznQZWafDdQ+8tFtlOswzRZUg7P0jR9ErMAw072rvWpMd/ZiD
 qEqaLuoLjIBA5dtNN6OXrXOqvvlA4Un/89r4F+QM+anM9rFisLv9O+YNjcsavpwZZX
 RcgX6OsVQDEKqq98RpI3xjWDMqW9prGiV0wWIWb2tlUEA9IY/2WosLn4M9VUc2TdPT
 begk2IbUVtOng==
From: Pratyush Yadav <pratyush@kernel.org>
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de,  jagan@amarulasolutions.com,  vigneshr@ti.com,
 tudor.ambarus@linaro.org,  pratyush@kernel.org,  d-gole@ti.com,
 Bacem.Daassi@infineon.com,  Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2 1/3] mtd: spi-nore-core: Fix 4KB erase opcode for
 s25fs-s
In-Reply-To: <f351754643dda5305f385ce23eb74ff2ee41e177.1712638210.git.Takahiro.Kuwano@infineon.com>
 (tkuw's message of "Tue, 9 Apr 2024 15:20:20 +0900")
References: <cover.1712638210.git.Takahiro.Kuwano@infineon.com>
 <f351754643dda5305f385ce23eb74ff2ee41e177.1712638210.git.Takahiro.Kuwano@infineon.com>
Date: Tue, 09 Apr 2024 11:46:00 +0200
Message-ID: <mafs0msq298dj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 09 Apr 2024 14:57:26 +0200
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

On Tue, Apr 09 2024, tkuw584924@gmail.com wrote:

> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>
> The correct 4KB erase opcode should be selected based on the address width
> currently used.
>
> Fixes: 562d166a13 ("mtd: spi-nor-core: Add fixups for s25fs512s")
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav
