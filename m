Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D952BCD8C90
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 23:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55DB184154;
	Mon,  8 Jun 2026 01:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FNDZFGWu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9331484869; Mon,  8 Jun 2026 01:37:21 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B776846A7
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 01:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D25743CE4;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 275BDC2BCB9;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780875435;
 bh=EHYGQ3ejgdrZYUZZxb9tZWq+Ho7bVkFBH3TdF4q3Sqs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=FNDZFGWuK0uLjqNjT0/BSUFW7zYJvdBe1bYuWz9yMJcnQ+IDV6UJVWxdM6L2k42D8
 o2+X2qzk2mTt5aAMJDOkAJPgAIxblLUFWDIEfkyJJLkcKjOYqPikvesvJT68bgxzmG
 gCMXYl8LrmPyROy1m5NG/qIfuwwtZ3zDam2N0XPK57k1OkDHnBNmYy9HLEqc+k9KpL
 BCfwpxByUWAK4znvTkCI3g1DhLwDFyCFLnlfZkDVniJeozdjk21CL8TxJQOoXMa1wQ
 TYo3xQD4Fn0Uh6XrO3Te3sGd/aIBUwGCJ+7LpAf+S0UR/qvXEc+hpG9dldKdQyDy5V
 a4aakeTrBtOVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1B114CD8C8C;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 08 Jun 2026 09:37:11 +1000
Subject: [PATCH v2 2/8] .gitignore: ignore binman-generated blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-android-binman-v2-2-b8203682507f@samcday.com>
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
In-Reply-To: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
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
 Henrik Grimler <henrik@grimler.se>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780875433; l=582;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=IFAh0D17FHXmpT6fv1JXFTXI5i5r9qd6SAH9ZAkhrM8=;
 b=TG50B4iHDOib0uimkE4BR/x7GVy5kvIDF6gTBtYrmEHyQSKwL4N/ZTmVyqKrokDk5Tdl1eQpw
 CD3Wx3UxFolB/PxyeAxp7k1Sb8rZfwfWsyzjOj28MbynEmBCEOvwnLw
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

Signed-off-by: Sam Day <me@samcday.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index e5d22dbe8e9..6ecac327ec2 100644
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


