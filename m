Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C39DC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 19:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E79F886AC;
	Thu, 18 Apr 2024 21:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZkuZpxmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D37886A7; Thu, 18 Apr 2024 21:00:37 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F5238869A
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 21:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 93B60CE17C1;
 Thu, 18 Apr 2024 19:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC038C3277B;
 Thu, 18 Apr 2024 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713466829;
 bh=FBJF8TwEarYMbU18f17+c423zfMKKM3xK1+QDqFe5Po=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ZkuZpxmg9B05LAIJ3MxoYfk4QaeC6rGemy+jBgLfd+tOqTEvkHxYQfLI3Us4ZGLBj
 7srfLwlMYdtZpoU8+vRvoWiGAavXA4T6r1Sy3wU2nhDXR3v2EWQwn8V/RLrihcRwHh
 Kjowpon51hSEanXY6g6E1M9+f20gaguKbIlUvK1IWYYHRCCHyaJL8rvLYktgiAdcGu
 xfovTLEI+rcnCZqSI9UOdZiBV4883XxJ+Ps/QdW4noNn81JJhWTav8NiRdgkk6qQyX
 7JzQj8T6N4308/3grvV4REvnhtBut/M6+M2gslLQZrfFe/++WJv0rRom1r4s8vKJCH
 YbdD7LYums4zw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B4D96C04FFE;
 Thu, 18 Apr 2024 19:00:29 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Thu, 18 Apr 2024 21:00:25 +0200
Subject: [PATCH v2 1/5] apple_m1_defconfig: Turn on CONFIG_SYS_64BIT_LBA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-apple_config-v2-1-7e5c6b9a9db3@jannau.net>
References: <20240418-apple_config-v2-0-7e5c6b9a9db3@jannau.net>
In-Reply-To: <20240418-apple_config-v2-0-7e5c6b9a9db3@jannau.net>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 asahi@lists.linux.dev, Janne Grunau <j@jannau.net>, 
 Hector Martin <marcan@marcan.st>, Neal Gompa <neal@gompa.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=j@jannau.net;
 h=from:subject:message-id;
 bh=iW3npaSaVV3BNoLkHi1Fz7M4xWDJIwJ9UUkZXz6uLiw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhjTF3NNXd722eRf0L+uN9dHzE+wWdz+KZXmQutVUfNnEO
 7aGS4/Zd5SwMIhxMciKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZhI2FNGhguXF709x/5k8b/Q
 C+lrmLetrv/l5P60t+n24oo59jnv9rcx/JhhO7uyYq7ElGPc7sZ9KRW6r529Xh35OoUto/wvx4Z
 YdgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Hector Martin <marcan@marcan.st>

This makes USB HDDs >2TiB work. The only reason this hasn't bitten us
for the internal NVMe yet is the 4K sector size, because the largest SSD
Apple sells is 8TB and we can handle up to 16TiB with that sector size.
Close call.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 configs/apple_m1_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
index e00d72e8be..31d966f0ab 100644
--- a/configs/apple_m1_defconfig
+++ b/configs/apple_m1_defconfig
@@ -10,6 +10,7 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_LATE_INIT=y
 # CONFIG_NET is not set
+CONFIG_SYS_64BIT_LBA=y
 CONFIG_APPLE_SPI_KEYB=y
 # CONFIG_MMC is not set
 CONFIG_NVME_APPLE=y

-- 
2.44.0


