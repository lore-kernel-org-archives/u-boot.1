Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BD2C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 20:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05986808A2;
	Sat,  8 Mar 2025 21:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741464978;
	bh=NKPWIIx3mmKgAQxL2kWCxViZkOb+nG8Mlo+qgt7IC54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yJjreqBBQL+zRTUX+gLNdFvL4D4oB8aWS0yoXP3ib0T8vxLlmhd3q79asOZurQjmW
	 Y1Pcbt8TRG7oejrIqicJmeWTqcPnIRUz5u+bN6CmSiC9OIcde8dCIpdHmz9fPQFQed
	 5QBggT5o635ykjKasVO2dRiIEorqexT1Osb+0Lp5KE8lFgupeH+FpiG497r7wrA9sg
	 cGvD5k0v2FDxFqbPdWA2M6gE9Fhkqkf0tQdlVLPLwCnu+8Ra2Mtg11RS7SxSfQuSZR
	 TPHV0snIIPPIxrBc0MsKCUTwUiXB1D2V5Imk3KEWAWJhymyRKgfUif1ctWJmaiFOcl
	 pECu2QIdZ9tMA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EBDA81298; Sat,  8 Mar 2025 21:16:16 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 194B480F4C
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 21:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="EIUZh7KJ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 87C98101E8802; Sat,  8 Mar 2025 21:16:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741464972; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=NKPWIIx3mmKgAQxL2kWCxViZkOb+nG8Mlo+qgt7IC54=;
 b=EIUZh7KJmwy3nLRUl25ROnTu+6MWse5wEHfWWWmq655uEYy6kg5nBT/oagn49+TlNsboaa
 gxwQZSRTUacImX5ERr+0SymEiG4YRm788fDZSzz4Ntv5+FkPh0XaSEC6xt5RUQvnNYbAMq
 4bazo7q5GxtWZLLr8gjgTlECL0JnmEv+QfdLGU4VvjQBa7rd+Ek23aLVv2gL31zqcEogvE
 mi+OMra+M0VnlGJP50F1lz+SzBacNda9W9mapiCgsxGlf37t91xoucTTv3UvJHSH5vmbER
 wzmO3MsmhklY4Ta57BcTh2vtPOJJAv9lqwp7LWeul+DCcJOFrvxBCCl1cuYsVQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/12] cmd: fs: Add generic rm implementation
Date: Sat,  8 Mar 2025 21:12:06 +0100
Message-ID: <20250308201533.1315951-3-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250308201533.1315951-1-marex@denx.de>
References: <20250308201533.1315951-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Add generic implementation of the 'rm' command to delete files
from filesystems using the generic filesystem API.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 cmd/fs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/cmd/fs.c b/cmd/fs.c
index df1f24207de..25c0005e8a3 100644
--- a/cmd/fs.c
+++ b/cmd/fs.c
@@ -99,6 +99,20 @@ U_BOOT_CMD(
 	"      device type 'interface' instance 'dev'."
 );
 
+static int do_rm_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	return do_rm(cmdtp, flag, argc, argv, FS_TYPE_ANY);
+}
+
+U_BOOT_CMD(
+	rm,	4,	1,	do_rm_wrapper,
+	"delete a file",
+	"<interface> [<dev[:part]>] <filename>\n"
+	"    - delete a file with the name 'filename' on\n"
+	"      device type 'interface' instance 'dev'."
+);
+
 static int do_fstype_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
 			     char *const argv[])
 {
-- 
2.47.2

