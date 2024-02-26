Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA08C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D7B187F58;
	Mon, 26 Feb 2024 18:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="aFwtbeoJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8114987F05; Mon, 26 Feb 2024 18:37:46 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12CF987F29
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1reev6-00071K-Sz; Mon, 26 Feb 2024 12:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=Zv6Z1wB4Fw/FDoZFv/wHmJLNVKPocyw0bEadKgA9tCY=; b=aFwtbeoJJgbgk89/31L6
 sat8Hw2W5eXX4qg7DetPRsveAaqflCXoNdp+k5AytVflrx51igFDfXzYtOnjqA5LwG//kXWxaB/Mo
 G4RvZZ5e4ssnR7E7gFB4ryRoC23jV8sIzWy6hzsd9M343q0WQwKSTIV6Gn6WlXA7aJQbK9x5TBacw
 KOcEuNoxGFo99j762xOe9NYXeOp6AWGHwE1nZ/6gSEpRnAi6ZBouFdq6YH/1M9DgoK/Pl/y/LUCMN
 OkNLV8XJT+o2ocJX7+smTDxrFQ70S8ewLwwKsSNkDaOzdQD2SBTG+U0doEWP2pXCxItwwhTPl1LrT
 3+CELrxgopwPHQ==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 2/2] tools: imx9_image: Reword warning message.
Date: Mon, 26 Feb 2024 18:37:19 +0100
Message-ID: <20240226173719.25629-3-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226173719.25629-1-othacehe@gnu.org>
References: <20240226173719.25629-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Feb 2024 18:45:46 +0100
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

If the optional `tee.bin` OP-TEE binary is missing, the image will still be
functional. Adapt the warning message accordingly.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 tools/imx9_image.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/imx9_image.sh b/tools/imx9_image.sh
index 88dfcfe606c..ca78a57a19a 100755
--- a/tools/imx9_image.sh
+++ b/tools/imx9_image.sh
@@ -19,7 +19,7 @@ for f in $blobs; do
 	fi
 
 	if [ ! -f $tmp ]; then
-		echo "WARNING '$tmp' not found, resulting binary is not-functional" >&2
+		echo "WARNING '$tmp' not found, resulting binary may be not-functional" >&2
 
                 # Comment-out the lines for un-existing files. This way,
                 # mkimage can keep working. This allows CI tests to pass even
-- 
2.41.0

