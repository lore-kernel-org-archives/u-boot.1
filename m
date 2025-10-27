Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEBDCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64FA5839D5;
	Mon, 27 Oct 2025 18:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="quKJGK/w";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B6YbkskM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C2868384E; Mon, 27 Oct 2025 18:07:34 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EFA839C7
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwKgl38G0z9tQg;
 Mon, 27 Oct 2025 18:07:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P5k4VYav8X1fqGV/Mo22aQKBXmVCMLbnz2abnACwe4g=;
 b=quKJGK/wzuCeFF+GIZUjhFqeRdCktQeDymdrsPQSAlf39pL7EC8lGabc5gCbLjEQoF+vPC
 69ryvroXcxEkEbxEseukp5r3jTK/kJI4Ifdfbsh7qet5AsWD6i6dPPGYzYu3dEV+bFd1+q
 OGlf9J4/OTqoR05soISGfiJ2KkpHJt5OMF50EGXYJ6en9pWLOXnyK6dFkL15Rr28fv8MOj
 gSWIvXCeNDNZMV6WK5WxisUVPWdRs9RNn8OUTBE3s+CFao33oZ+urC6OMe90uiMUWy1oVi
 31m8yT5u+vc3EN1Ll3hCXujsRUUPI8i3wEG0wn83yV++bmAuRoRgX39QfooI9A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=B6YbkskM;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P5k4VYav8X1fqGV/Mo22aQKBXmVCMLbnz2abnACwe4g=;
 b=B6YbkskM1MTCJqX1vP11n98AJZYcsV/XtB7PuWcl3mBxDpAv7oIOqljn3vOzbMJr8kez5r
 UG+iir93SRgyo8cV4r+ZHXmKHAAhFg2gu/tKbdBBuJDUiAMMYBLBPyaFpiX13X/bQ99TZy
 fDbkbpRk0cczQUNtSeKV4oLbApJTWPb0tZtFwSFH4OYUacXcYf1Y02yoVKbWJKuj7xVBvT
 fIriiBPK/zRa7vdX33SuetUWolQ3VwlMVbbalqey5SLCK9YJmW9TC7JflIq6rUbzU9FJBR
 fapDbd6KgrFtPTqs8FEeaudZSrxeElhcFPIzHwcVbVrhv8ivmHHeMZozfjXXeg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH 5/6] ufs: renesas: Update Kconfig entry help text
Date: Mon, 27 Oct 2025 18:06:26 +0100
Message-ID: <20251027170706.29302-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
References: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ffwuxfgdzxs1ooz8wrf3dp1upqyuzxib
X-MBO-RS-ID: 7d2caa697140f4feaf8
X-Rspamd-Queue-Id: 4cwKgl38G0z9tQg
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

The current Renesas UFS driver contains initialization code
that is specific to R-Car S4 R8A779F0. The upcoming R-Car X5H
initialization code is different and contained in a separate
driver. Update the Kconfig entry help text for the current
driver to help discern it from the X5H driver. No functional
change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/ufs/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index b466374fe40..4c6b08ad31c 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -48,12 +48,12 @@ config UFS_PCI
 	  If unsure, say N.
 
 config UFS_RENESAS
-	bool "Renesas specific hooks to UFS controller platform driver"
+	bool "Renesas R-Car S4 UFS Controller support"
 	depends on UFS
 	select BOUNCE_BUFFER
 	help
-	  This selects the Renesas specific additions to UFSHCD platform driver.
-	  UFS host on Renesas needs some vendor specific configuration before
-	  accessing the hardware.
+	  This selects the Renesas S4 specific additions to UFSHCD
+	  platform driver. UFS host on Renesas needs some vendor
+	  specific configuration before accessing the hardware.
 
 endmenu
-- 
2.51.0

