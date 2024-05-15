Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CFDC25B79
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 15:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9CD788250;
	Wed, 15 May 2024 17:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MJ0rFqmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74FEF88176; Wed, 15 May 2024 17:04:48 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7234688013
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 17:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 00486614CE;
 Wed, 15 May 2024 15:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479B1C32786;
 Wed, 15 May 2024 15:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715785484;
 bh=kdv3zbpMlvYD6sO/O1R+YhrUOXzmgfyFy2AjMhh/pcQ=;
 h=From:To:Cc:Subject:Date:From;
 b=MJ0rFqmLJfY87FfdqmNdygrUjDBLhywn9AVjE0ZxiEBvhp7XG+EW2nOPqa1HgaszG
 CluseXAElaLf0E8Vds2vrmbQFK/oEcGb7NGhYruw8r89Fpbd0Cv8J4zDeS/a/0f/Qz
 4kpAULVqoC+xnGG9XHlskbhNSAl8iTpZ0w3FGu8+8iaLIju1/5C25SKIh49ij4H5to
 8k+Uo6276fx82sDdryF+RvwhYkQPkU57k9/CbeNrAlXuHN9gK/RCFGUUyCF+tfJTqu
 Ou997NjpXzgdE3NpN0qkbyTp0Q97Dj72tfOW+beE6efVO5/yEof6uLkU4HhW8CVkJI
 NIERnwtig2v0g==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/2] Two mpfs icicle init fixes
Date: Wed, 15 May 2024 16:04:29 +0100
Message-ID: <20240515150434.406916-1-conor@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Conor Dooley <conor.dooley@microchip.com>

Two fixes for issues that I spotted today while looking into passing a
minimal dtb to U-Boot from the first bootloader stage. This minimal dtb
had no ethernet nodes, and the code in this patches fell over :\

Cheers,
Conor.
---
CC: Padmarao Begari <padmarao.begari@microchip.com>
CC: Cyril Jean <cyril.jean@microchip.com>
CC: Tom Rini <trini@konsulko.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: u-boot@lists.denx.de

Conor Dooley (2):
  board: microchip: icicle: correct type for node offset
  board: microchip: icicle: make both ethernets optional

 board/microchip/mpfs_icicle/mpfs_icicle.c | 25 ++++++++---------------
 1 file changed, 8 insertions(+), 17 deletions(-)

-- 
2.43.0

