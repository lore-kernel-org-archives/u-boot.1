Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163F1CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3879838AE;
	Tue, 28 Oct 2025 15:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SVAZ6k9+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mp+51rAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD180838AE; Tue, 28 Oct 2025 15:23:59 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED3FA80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 15:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwt0Y4nVvz9tTM;
 Tue, 28 Oct 2025 15:23:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761661437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAvLOvntDt6tSx6iVIwR1oKlihzIo5msTBOlYIHxwtc=;
 b=SVAZ6k9+lf2yzu26r6paAWT9qpHsJLxhg7xOMu5+8360YblpiZWXUl9PojcmYJEX/sg2ev
 XLlMzyrfEWv0aCHJ9lLa93wWUICOrXwNxx/p1p64KCpFs+BW6Xl3hu9swVtPYSy/TDdWLQ
 4pU81ncfE3ykGRNMJEU/UTs8XdkiUwrQyzU0jwR1fMjqj5sZ8uyfozGzYrftPZ0+ofUjvs
 s3RmZbQRbe5x9Q6IjXy1RftCqz1UPGnBo/f+lT1It3Cl+DT25KsFxZ771lGunRreZXW5x4
 fIQu5tJwR85HnmJQWIARCoQzrd/kFtx7kPTq1I3SeYX/e/J5BQEWofg5yOizeQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761661435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAvLOvntDt6tSx6iVIwR1oKlihzIo5msTBOlYIHxwtc=;
 b=mp+51rAxfG/ZNMLDOmpDUJzpwsy4jliFVnQpckVvYSNSCZOI2ResRbO/yyrI9eVPO/kUMc
 Ot/W5rgwkVUpORF1Wuohgmp9AYERYMJ/GQnJJbHqEv52h0xLoT3U/iExzXqaHZZ6MADQhv
 6T2txTW8sQ3U79TOrscI73LIG5IaYPxb4AoJNZwZIy4r6XDyVWAqrSInBsUG28l8K02rJG
 TxOtN5Yh+ldcac3y307SXdK0p669j2CTfvLoykfIepzrQbG+Q5ENSNgC+9jgtcvzJzHUK5
 tBxpS8iYVfxDrezy8nY/ykPiLncN7/tqwMUIjqTF135kafeDqLMoTSGHx5ZOqw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH v2 6/7] ufs: renesas: Update Kconfig entry help text
Date: Tue, 28 Oct 2025 15:22:26 +0100
Message-ID: <20251028142335.18125-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251028142335.18125-1-marek.vasut+renesas@mailbox.org>
References: <20251028142335.18125-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 78cs9i6i6kpr7yt39oatd3kb4pmgnt4n
X-MBO-RS-ID: 35871f826509da8e0ca
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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
V2: Add RB from Neil
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

