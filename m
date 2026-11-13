Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14786606A32D
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wu/1ZoDg;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=ht1HW+3X
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9AB560629;
	Fri, 13 Nov 2026 15:54:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FEltABtMR0vU; Fri, 13 Nov 2026 15:54:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 70E916064F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794585269;
	b=tNA4aYnCZ0pS95uHDhCmKjPq08ECkZeV/BF3p9sauHzO3mhZV0FoVqBMJcdEsprJGfeM
	 M2Vz3/sHRxO0XoCQ39D62dEdK3AG4US9MOFOnHUirspA9YNSFrBzOGp6eyYTfGLkqiV3f
	 h5q2I0mph1I9Bjr+HORfORQTWfVHSfcJX9f31XyOlHsYKjPxKHwC+wfIISojH9DrAeWTP
	 8Mxb1ykiZwHBy1994NmPyUPEVBqq8fkOZYFmYM8xXIiJ1CSXHdxlCpH3pmp5Feqxd3OH5
	 R+hQN/gq8vrZKFrgRyJnkMtB/ZfJOM0AHRBI7SnFXQcruVqVQabwjfwRkdwPsAjR2nA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794585269;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6nU0lvrHQ03hch86UEbzbezrqXcvAqeSa3kyw0160ho=;
	b=HPw5Vjp6qlPWK8GIMLSS8HTLBae00/eyDh85CZXikJ4oDvJkdWSm6RNiqgxAGRNCCzux
	 yfk1eQZCd+LKCPwUC+FArEwoni9EgVoaUyyb2zc5m/1Lw2Gdwyr0lXMsavL38+cPG7DbX
	 dZWJy4W/hIqQOV31ZJT7wh3HH9d4T7WeIIUiJqODVUo05Zn9lGgvuZcwigttHavT/oCzv
	 OHQOJJ3xQusjuCpEVcd67fqftF5P4h5bx4sLjnmYdDYTiuiMi4oU3Hs7ZEf2VTqmijepe
	 ONWThZznsugyMDAbOxur1gVvwKBApNWg+apf+9RBe0o36M1wh6FrA5oTqTH2j5IefhA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794585269;
	bh=6nU0lvrHQ03hch86UEbzbezrqXcvAqeSa3kyw0160ho=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wu/1ZoDgid/7c2VS2cKdmGnZqkxFmKMM7yM020fz+JXZYicI5mimO+UPBzgzVy2H1
	 XbdOIAkF+0eZy810+F75mA9NI8B4vzu/kIan1ild45S4sGp0nvlh6FyVMIGAcdqUbd
	 /k9NZoo/8O/55MjuPZTdjy6rM/LBXr1kf4Y2yRt/FEH8iSS0AzSJdlhm4ozfUGG3SA
	 mDLvOjxeTRJdlBlRE+51IPQ77ZYGEVgNhpHVuRxsQ1EbtQUxnUn6I76fxQb+T+cRaz
	 bF1VMHuUR61LF4twkRHBBzgtG35IASyGWN7RmhrqEoNUIm6ftT5zPe3juKCI7ixsVQ
	 0EBAXRAopAIeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70E916064F;
	Fri, 13 Nov 2026 15:54:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F6A928C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5530440987
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:54:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Jex8p7npg-1 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:54:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 91FCB40979
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=ht1HW+3X
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91FCB40979
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:54:24 +0000 (UTC)
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net
 [178.82.167.143])
 by mail11.truemail.it (Postfix) with ESMTPA id 1D60820770;
 Fri, 13 Nov 2026 16:54:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794585260;
 bh=6nU0lvrHQ03hch86UEbzbezrqXcvAqeSa3kyw0160ho=; h=From:To:Subject;
 b=ht1HW+3XewFE/iw/Xo+WVNk0TTBuxQ2z1fJWAuqexoriGhe0fc7paZCB5louFBXz7
 BD6oaKwx84MGzXJH2iRWdiP61xgsmhsxMtDK7wjZbqLuV1AaBx4D6qRALc4SNprXVe
 0nW5xl899PBpZUJv4IGpNvDC0BRsUchkJ3hsHFp1/o7HWb8L6bN1LEoN+Q+JArKEvN
 UMOlixZVUw+XwdRmQJs0wfKeYwzWUncwYChy1W1MikgSQh4t1pGxtRDHPRs/ynSS6d
 rnIDSTbVE+XGM87j/RVnUo8ko/4GyNQQ/76Wq+Quf1j+gcI/QxNQGH6rptJurUVbqe
 aEqau649i4UDg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH] board: toradex: aquila-imx95: remove CFG_SYS_UBOOT_BASE
Date: Fri, 13 Nov 2026 16:54:11 +0100
Message-ID: <20261113155413.156269-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

CFG_SYS_UBOOT_BASE is only used by the SPL NOR/XIP boot code, which is
not enabled on Aquila iMX95, and the module has no NOR flash. The
definition also relies on QSPI0_AMBA_BASE, which does not exist on
i.MX9.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 include/configs/aquila-imx95.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/configs/aquila-imx95.h b/include/configs/aquila-imx95.h
index 9c48d2b2736d..5f30fd2b7523 100644
--- a/include/configs/aquila-imx95.h
+++ b/include/configs/aquila-imx95.h
@@ -7,9 +7,6 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
-#define CFG_SYS_UBOOT_BASE	\
-	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
-
 /* module has 8GB, 2GB from 0x80000000..0xffffffff, 6GB above.
  * Actual size is determined at runtime.
  */
-- 
2.47.3

