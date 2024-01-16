Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AECC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 16:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C736386F80;
	Tue, 16 Jan 2024 17:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="IqppP8tD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C2F86FB8; Tue, 16 Jan 2024 17:12:57 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6254686564
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 17:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1745c6cb32=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40GAsV6d019271; Tue, 16 Jan 2024 17:12:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=tloMFgA
 HPyYfitINC+LYlVu+a88XsqAMtS2i0WaKVbA=; b=IqppP8tD7WbUtlzh7RR39Q6
 sAhT1mBMy2cud8EbTx8p9pYbsISoPN2yXQZeugiaHKTn/y3O8k4I5T6AwEHrJxtw
 gpGepvua4DnezZgF1BEfSfxk6wtonlcEOHA+srdDYNu8Hc86ih/vGJekSHqpUdqB
 5THRJ66pquJy7j0uq63jngg12Mifzyauo1S/PEAHDW8DHUOoCesZLnulmjXrlN7k
 r8TcY5qarazKVVxJXC4ovVQ1Khqtz4VBtRzkbq39GcHXmfCWytSAJMcdDvi/amAU
 DPgkmJhnXMRs05ox2kRY94abu/BKmOsr2rW5PbXAleSAQePc4g0gqxqbDsXsGMQ=
 =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmfyfewf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 17:12:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E9AF10002A;
 Tue, 16 Jan 2024 17:12:36 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 21EB52896ED;
 Tue, 16 Jan 2024 17:12:36 +0100 (CET)
Received: from localhost (10.201.20.205) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 16 Jan
 2024 17:12:35 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>,
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH] common: console: Fix print complete stdio device list
Date: Tue, 16 Jan 2024 17:12:31 +0100
Message-ID: <20240116161231.741794-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.205]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
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

In case CONSOLE_MUX and SYS_CONSOLE_IS_IN_ENV are on and
stdin or stdout or stderr are missing in environment, as fallback, get
these either from stdio_devices[std] or stdio_devices[std]->name.

Fixes: 6b343ab38d ("console: Print out complete stdio device list")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 common/console.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/common/console.c b/common/console.c
index cad65891fc9..8bfcfce5643 100644
--- a/common/console.c
+++ b/common/console.c
@@ -1049,6 +1049,11 @@ int console_clear(void)
 	return 0;
 }
 
+static char *get_stdio(const u8 std)
+{
+	return stdio_devices[std] ? stdio_devices[std]->name : "No devices available!";
+}
+
 static void stdio_print_current_devices(void)
 {
 	char *stdinname, *stdoutname, *stderrname;
@@ -1060,19 +1065,13 @@ static void stdio_print_current_devices(void)
 		stdoutname = env_get("stdout");
 		stderrname = env_get("stderr");
 
-		stdinname = stdinname ? : "No input devices available!";
-		stdoutname = stdoutname ? : "No output devices available!";
-		stderrname = stderrname ? : "No error devices available!";
+		stdinname = stdinname ? : get_stdio(stdin);
+		stdoutname = stdoutname ? : get_stdio(stdout);
+		stderrname = stderrname ? : get_stdio(stderr);
 	} else {
-		stdinname = stdio_devices[stdin] ?
-			stdio_devices[stdin]->name :
-			"No input devices available!";
-		stdoutname = stdio_devices[stdout] ?
-			stdio_devices[stdout]->name :
-			"No output devices available!";
-		stderrname = stdio_devices[stderr] ?
-			stdio_devices[stderr]->name :
-			"No error devices available!";
+		stdinname = get_stdio(stdin);
+		stdoutname = get_stdio(stdout);
+		stderrname = get_stdio(stderr);
 	}
 
 	/* Print information */
-- 
2.25.1

