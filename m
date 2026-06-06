Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785A2CD6E55
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0D348405A;
	Sat,  6 Jun 2026 06:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f81wTWo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B657484946; Sat,  6 Jun 2026 02:52:44 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DD4884671
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 02:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D9B8F601E0;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56676C2BCC9;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780707160;
 bh=90+sTq80Oxhlg741DtvzJ72o1XKIDECZ91M0r8ytwAk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=f81wTWo8oBRoCSu/ZrM1fvRJNXWNcdybDuZYnp7Jbi1C+atWSbI2aodw1VPcT60JM
 aoJxCXkcwgk2fZH4nEM7lbybtcvFiIiTrYfYIiMV09fOGqGILuI3LP8OcGXDnDojXU
 T67q05GC/hzl2aHCLbcaNavyY6Pe5bKRXoJ33hvEn8dGpBjyWe1wP5eDnBUdA2FEcM
 VRmaDZfPBw52mzYJ0BXK4QmFIQPzDQ50pDud9SEYVtWpKYKAPNEsQ66LVAp0ychLsD
 AejZKAwQH3FTzPNKj2Z3SzUJFZKokEOEgXcIYtSk/7rPGr8NKNzYVj9YngDiWI90Ju
 iUr7ZcaB7xVQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 42207CD8C89;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 10:52:36 +1000
Subject: [PATCH 02/13] .gitignore: ignore binman-generated blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-android-binman-v1-2-c7a3c14b8a3d@samcday.com>
References: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
In-Reply-To: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Denis Mukhin <dmukhin@ford.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Javier Tia <floss@jetm.me>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780707158; l=582;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=TzHdIuZSBdfrWluFEN98hVm+DjviMXnGBxDHr9+MyHA=;
 b=Q/kgHw/4TYH90JcubDq3GOye6Swpp5HC3ZfINxAdg6hPnWaa5RMCIBab/TTftDAzx3ZIJxe9L
 arcPOSEi+AwAeSO0aDxGEqKO0O+sS8TfN/vRxIbSPXRhwCP+EzPcpaH
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-Mailman-Approved-At: Sat, 06 Jun 2026 06:27:39 +0200
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


