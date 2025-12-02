Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9AECFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 09:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A35283E21;
	Tue,  2 Dec 2025 10:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9702183E28; Tue,  2 Dec 2025 10:35:25 +0100 (CET)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4DD783CAA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 10:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms02z.xe.abb.com (Postfix) with ESMTPS id 5720E72A1;
 Tue,  2 Dec 2025 10:35:23 +0100 (CET)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025120210352252-69475 ;
 Tue, 2 Dec 2025 10:35:22 +0100 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.96])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025120210352306-18566 ;
 Tue, 2 Dec 2025 10:35:23 +0100 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automtation.com>,
 "Tom Rini" <trini@konsulko.com>
Subject: [PATCH] board: BuR: Update MAINTAINERS files
Date: Tue, 2 Dec 2025 10:35:18 +0100
Message-ID: <20251202093521.73250-1-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 12/02/2025 10:35:23 AM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 12/02/2025 10:35:23 AM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 12/02/2025 10:35:22 AM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 12/02/2025 10:35:22 AM,
 Serialize complete at 12/02/2025 10:35:22 AM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
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

The MAINTAINERS files for B&R boards are not in sync
with the current file names. Update the files so
that they are correct again.

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automtation.com>

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
---

 board/BuR/brppt1/MAINTAINERS   | 3 +--
 board/BuR/brppt2/MAINTAINERS   | 1 +
 board/BuR/brsmarc1/MAINTAINERS | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/BuR/brppt1/MAINTAINERS b/board/BuR/brppt1/MAINTAINERS
index a974a97c157..dd971957854 100644
--- a/board/BuR/brppt1/MAINTAINERS
+++ b/board/BuR/brppt1/MAINTAINERS
@@ -5,5 +5,4 @@ F:	board/BuR/brppt1/
 F:	board/BuR/common/
 F:	include/configs/brppt1.h
 F:	configs/brppt1=5Fmmc=5Fdefconfig
-F:	configs/brppt1=5Fnand=5Fdefconfig
-F:	configs/brppt1=5Fspi=5Fdefconfig
+F:	arch/arm/dts/am335x-brppt1-mmc*
diff --git a/board/BuR/brppt2/MAINTAINERS b/board/BuR/brppt2/MAINTAINERS
index bfeaa571a82..e026a6a16da 100644
--- a/board/BuR/brppt2/MAINTAINERS
+++ b/board/BuR/brppt2/MAINTAINERS
@@ -5,3 +5,4 @@ F:	board/BuR/brppt2/
 F:	board/BuR/common/
 F:	include/configs/brppt2.h
 F:	configs/brppt2=5Fdefconfig
+F:	arch/arm/dts/imx6dl-brppt2.dts
diff --git a/board/BuR/brsmarc1/MAINTAINERS b/board/BuR/brsmarc1/MAINTAINERS
index 7421f61fc43..c313fcbff0e 100644
--- a/board/BuR/brsmarc1/MAINTAINERS
+++ b/board/BuR/brsmarc1/MAINTAINERS
@@ -5,3 +5,4 @@ F:	board/BuR/brsmarc1/
 F:	board/BuR/common/
 F:	include/configs/brsmarc1.h
 F:	configs/brsmarc1=5Fdefconfig
+F:	arch/arm/dts/am335x-brsmarc1.dts
--=20
2.52.0

base-commit: c2b25f8f66a31e3fe435c93c4339f95ab4c24b9b
branch: us/maintainers
