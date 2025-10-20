Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01CCCCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 14:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BCC6807B1;
	Mon, 20 Oct 2025 16:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="plIj/WmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1573882C84; Mon, 20 Oct 2025 16:55:38 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8866580422
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 16:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DDCC601EA;
 Mon, 20 Oct 2025 14:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3B3C4CEF9;
 Mon, 20 Oct 2025 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760972134;
 bh=D3xSBBXS02HL9nFCouhbwvSZ519y0dFEkxLudgP50E4=;
 h=From:To:Cc:Subject:Date:From;
 b=plIj/WmJNW87jAJIvltWLTPMOi9+1c/hO9T6to240V+jtR9WvlNPbN4Pp029or0AD
 YmOx1FNgFSFj2GFz24+woNofnmzZOhF6Hm9mUDaYlX7zjm50PLDL4lAm6WDFfZrekD
 75FXaPnFbUdO6LPBPu9T/D6Udx6D14jjXAbhDPeEpQcqUiO9TWgBw31q9y6IhF9UpQ
 JYHWSEwVL/9iQVzwlz+mb+KZNJcv2rqjHlOh181JoJmB1HFKqCDKvHdk2gHyI9a4B7
 6SR4LVKBxnGchMUY3UKrutqbm0LUcv1ajALZeEEZZUQye83XulounP/NOrnOr4AcFw
 9JztpBOrHQDZA==
Received: by wens.tw (Postfix, from userid 1000)
 id 888875FDC3; Mon, 20 Oct 2025 22:55:31 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 linux-sunxi@lists.linux.dev
Subject: [PATCH] .mailmap: update email address for Chen-Yu Tsai
Date: Mon, 20 Oct 2025 22:55:27 +0800
Message-ID: <20251020145527.2702250-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
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

The email forwarder I'm using has run into severe problems with Gmail
lately. Switch over to my kernel.org address.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index f1b93d168e90..e08dfd3a5263 100644
--- a/.mailmap
+++ b/.mailmap
@@ -36,6 +36,7 @@ Bin Meng <bmeng.cn@gmail.com> <bin.meng@windriver.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
+Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
 Christopher Obbard <christopher.obbard@linaro.org> <chris.obbard@collabora.com>
 Dirk Behme <dirk.behme@googlemail.com>
-- 
2.47.3

