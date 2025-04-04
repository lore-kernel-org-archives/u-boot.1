Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6674C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 15:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC36382A76;
	Sat,  5 Apr 2025 17:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC98E82A7B; Sat,  5 Apr 2025 17:27:43 +0200 (CEST)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF6EB8215B
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 17:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bernhard.messerklinger@br-automation.com
Received: from brsmtp01.br-automation.co.at ([10.43.60.20])
 by inet11.abb.com (8.15.2/8.14.7) with ESMTPS id 5347SN74674035
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 4 Apr 2025 09:28:23 +0200
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025040409282382-93034 ;
 Fri, 4 Apr 2025 09:28:23 +0200 
Received: from ATEGGE3725.br-automation.co.at ([10.43.64.28])
 by extmail.br-automation.com (HCL Domino Build V1202_05192022)
 with ESMTP id 2025040409282411-31367 ;
 Fri, 4 Apr 2025 09:28:24 +0200 
From: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Simon Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
Subject: [PATCH v4 1/4] board/BuR/common: use strlcpy instead of strncpy
Date: Fri, 4 Apr 2025 09:27:57 +0200
Message-ID: <20250404072819.69642-2-bernhard.messerklinger@br-automation.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404072819.69642-1-bernhard.messerklinger@br-automation.com>
References: <20250404072819.69642-1-bernhard.messerklinger@br-automation.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Build
 V1202_05192022|May 19, 2022) at 04/04/2025 09:28:24 AM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Build V1202_05192022|May 19,
 2022) at 04/04/2025 09:28:24 AM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP3
 HF8|December 13, 2024) at 04/04/2025 09:28:23 AM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP3 HF8|December
 13, 2024) at 04/04/2025 09:28:24 AM,
 Serialize complete at 04/04/2025 09:28:24 AM
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

Now strlcpy is used to copy the defip string to the corresponding
environment variable. This preserves memory for the NULL termination.

Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automation=
.com>
---

(no changes since v1)

 board/BuR/common/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/BuR/common/common.c b/board/BuR/common/common.c
index 7fb61736710..3513f43a9f5 100644
--- a/board/BuR/common/common.c
+++ b/board/BuR/common/common.c
@@ -68,7 +68,7 @@ int brdefaultip=5Fsetup(int bus, int chip)
 			 "if test -r ${ipaddr}; then; else setenv ipaddr 192.168.60.%d; setenv =
serverip 192.168.60.254; setenv gatewayip 192.168.60.254; setenv netmask 25=
5.255.255.0; fi;",
 			 u8buf);
 	else
-		strncpy(defip,
+		strlcpy(defip,
 			"if test -r ${ipaddr}; then; else setenv ipaddr 192.168.60.1; setenv se=
rverip 192.168.60.254; setenv gatewayip 192.168.60.254; setenv netmask 255.=
255.255.0; fi;",
 			sizeof(defip));
=20
--=20
2.49.0

