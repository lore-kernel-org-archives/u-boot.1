Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392B0CD6E67
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 13:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0320886E5E;
	Wed, 11 Oct 2023 15:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1ED486E00; Wed, 11 Oct 2023 15:17:17 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6DB586DD9
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 15:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp83t1697030166tqh1jlu9
Received: from ubuntu.. ( [111.196.129.4]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Oct 2023 21:16:05 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: rZJGTgY0+YOBhz6GwooRdDQpWMFJjLlUc3c7N1X/jBsbhVFL1qyXHZKN/Qvv1
 yPpdHCHV2DActDuzc9Fwl9NuKAzjVrclC5L/igrZx127UB5RUpjyk9G45gl6+FCmdZKY27Z
 GLPZk4cjwfHEUiLDBeLao3Wigj75BKKqKbUMvxG3JSPXRvvxzePv0+/Q5esSwPMwqxuOD8r
 oWsLW7eGPxYbk1p88lt5h+urYYpBgYn44D//367LkjK6tAhn/k8WR55qIkD5UEUsIXa1ZQW
 9HGx12hdSXiGG0VJwQnL4it6MT7ei0gphz5Ai9/7J/rC19/bbDdWtO+po8bybzfawAPvflm
 8xYAvr/nFXrmwrPcz5M4Z4MDL65a9/HNS5zcbtK
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13930572496564102603
From: Bin Meng <bmeng@tinylab.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Subject: [PATCH v2 4/9] cmd: ufs: Correct the help text
Date: Wed, 11 Oct 2023 21:15:47 +0800
Message-Id: <20231011131552.14665-5-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011131552.14665-1-bmeng@tinylab.org>
References: <20231011131552.14665-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

Remove the additional space and use "sub-system" for consistency
with other commands like "scsi" and "usb".

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

(no changes since v1)

 cmd/ufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/ufs.c b/cmd/ufs.c
index 143e946370..2c8d88df18 100644
--- a/cmd/ufs.c
+++ b/cmd/ufs.c
@@ -32,6 +32,6 @@ static int do_ufs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 }
 
 U_BOOT_CMD(ufs, 3, 1, do_ufs,
-	   "UFS  sub system",
+	   "UFS sub-system",
 	   "init [dev] - init UFS subsystem\n"
 );
-- 
2.34.1

