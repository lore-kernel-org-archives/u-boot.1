Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EF1CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A53839CC;
	Fri, 17 Oct 2025 17:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="T8TxzVw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B72D8383F; Fri, 17 Oct 2025 17:29:34 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3FD783826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7674D26361;
 Fri, 17 Oct 2025 17:29:32 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifU47d1lFjdx; Fri, 17 Oct 2025 17:29:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714971; bh=EzVzDjbElglAqzJ1YzfwS+g/C+rPOLNb5gVd4CFIXbI=;
 h=From:Date:Subject:To:Cc;
 b=T8TxzVw+xaUY2B13LBfzLZtG0kKlnro28jS0Ksgkuijs85/6ES/wfC00ROV8CQcNo
 3JcRg+D9nerlv9doJnebdbtku0VuvMMiQ6a1nZ1wRJ2SQKnN8fjUjVNjjmo5KeBz2M
 BYEgY4lRsGnoEOXGr5SZ6fNL0/dF+91U0rgWOzkm4ferZzXnLpkenHo10jVbGgpcrN
 hdOKL7jjf0zjZM5weVq+Fc1TZCME5SVy//7+zDnpE0jwrl64LgMTDbqRZ9pem+d18z
 1TL2jTUzgO1E2RmxOvaFIXjCChjLHj0p9HqCfMTVlXcTbl/8SuuALLd9/DeHQVccGV
 N8li3IKjK0YFg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:59:22 +0530
Subject: [PATCH] serial: s5p: add compatible for exynos8895
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-serial-s5p-exynos8895-v1-1-b412dd112cfd@disroot.org>
X-B4-Tracking: v=1; b=H4sIANFg8mgC/x2MQQqAIBAAvxJ7bkEzIftKdLDaaiEsXAgj+nvWc
 WBmbhCKTAJtcUOkk4X3kEGXBYyrDwshT5mhUpXVStf4+X5DsQdSusIuTeMsGqPMNJPxzg2Q2yP
 SzOn/dv3zvMSbnkdnAAAA
X-Change-ID: 20251014-serial-s5p-exynos8895-3303dfe3a99b
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714968; l=1179;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=EzVzDjbElglAqzJ1YzfwS+g/C+rPOLNb5gVd4CFIXbI=;
 b=qrOMMf6vaPKf2SfNtQfs2CHc1ippZO62uR1iA0Pla+ivQa3YrfPNar2+iax/uwq7avfHTXinu
 m1/a+j8AYYrAoruWbRUpVTNjcARHOu6ApVX+1JKVK+8sn0RGtnbi5ai
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

Add the compatible for Exynos8895 UART as described in upstream
devicetree bindings. This enables support for Exynos8895 and other
similar UART devices, such as Exynos7870. Other than that, the driver
works as-is.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/serial/serial_s5p.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index 734780a124ad47ed97811784edfdb45a75d37bf7..d46a88610ab88a227aa07b10c62576a13168bfbc 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -258,6 +258,7 @@ static const struct dm_serial_ops s5p_serial_ops = {
 static const struct udevice_id s5p_serial_ids[] = {
 	{ .compatible = "samsung,exynos4210-uart",	.data = PORT_S5P },
 	{ .compatible = "samsung,exynos850-uart",	.data = PORT_S5P },
+	{ .compatible = "samsung,exynos8895-uart",	.data = PORT_S5P },
 	{ .compatible = "apple,s5l-uart",		.data = PORT_S5L },
 	{ }
 };

---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251014-serial-s5p-exynos8895-3303dfe3a99b

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

