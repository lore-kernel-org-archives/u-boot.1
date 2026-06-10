Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B335CCD8CA8
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 01:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15F0E848D7;
	Wed, 10 Jun 2026 03:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VYxVUNYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F660849E4; Wed, 10 Jun 2026 03:27:47 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7DA6849B4
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 03:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D9C15602CA;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E0A6C4AF0E;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781054861;
 bh=rkVPCoQA4Eg4tG/aIibfKkPmxvCjdfoX06CGyGGicgw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=VYxVUNYNXW8sUfUdpeMDZwM/2zo5CFLMieGUp6uPVNy9b1DAI1gZHB6lT5VIfNYRu
 RgjJMt7XkILYn98rF+q97jYYUSzf3XBFkMoDHifrx8O9GM6WZg97bAmyFi0uGqk+yI
 rSC/OatTfxkeH4v96mrXd/NZDny/ynpRf5fPeUOYZ1BOwqwin167WoYRSvv9QMRyTE
 5EByAvpfsZWeldoI1Gi2BhoH6CDzCBUGGAXlXHvcprXKr3wehNYC4KxVJR7U3w/DIR
 o+O/Wg7QNrtoLv99ZOH6YG5h8obK/fjE9kG1ZRfn0WM5dQQv4DxYP98cBPSc94zzZy
 iyxMLK+SsArTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 85147CD8CB2;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Wed, 10 Jun 2026 11:27:43 +1000
Subject: [PATCH v3 05/10] .gitignore: ignore binman-generated blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-android-binman-v3-5-710298a38fcc@samcday.com>
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, yan wang <yan.wang@softathome.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781054859; l=719;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=cgBylfyhDbVtoVDWN8K78nuoTKnvpxWGKVN4Rf/rL74=;
 b=XUZW3Vw7rsJTYiwdkByQISOjiWV+hZ4YYQfnN8wQevJC/x+U3yJhmFq9CYkjRqgr4DKVk3HhH
 G7OjXumQcmUCsgrbPAm1Z1MR211dRlD/KKXn/wGgqzZFr1h8jbP/yTm
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

The new android_boot etype is causing these /comp*u-boot-nodtb artifacts
to be generated, which aren't currently picked up by any ignore rules.
This issue only occurs when doing in-tree builds, but it's still worth
fixing regardless.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Sam Day <me@samcday.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index d57d3be0291..6e274de77ab 100644
--- a/.gitignore
+++ b/.gitignore
@@ -84,6 +84,7 @@ fit-dtb.blob*
 /test/fdt_overlay/test-fdt-overlay-stacked.dtbo.S
 /test/fdt_overlay/test-fdt-overlay.dtbo.S
 capsule_esl_file
+/comp.*.u-boot-nodtb
 
 #
 # Generated include files

-- 
2.54.0


