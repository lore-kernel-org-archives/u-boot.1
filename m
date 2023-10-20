Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98283CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 13:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF35871F6;
	Fri, 20 Oct 2023 15:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C0286FD9; Fri, 20 Oct 2023 15:15:52 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 22D9C871F6
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 15:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 871922F4;
 Fri, 20 Oct 2023 06:16:26 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.95.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 771F13F5A1;
 Fri, 20 Oct 2023 06:15:43 -0700 (PDT)
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: abdellatif.elkhlifi@arm.com
Cc: nd@arm.com, trini@konsulko.com, u-boot@lists.denx.de,
 xueliang.zhong@arm.com
Subject: [PATCH] arm_ffa: fix: remove deadcode in ffa_print_error_log()
Date: Fri, 20 Oct 2023 14:15:33 +0100
Message-Id: <20231020131533.239591-1-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020115747.GA141285@e130802.arm.com>
References: <20231020115747.GA141285@e130802.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

address the CID 464361 Control flow issues [1]

[1]: https://lore.kernel.org/all/20230821210927.GL3953269@bill-the-cat/

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/firmware/arm-ffa/arm-ffa-uclass.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index 8c17b19eaf..f1e91d151e 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -144,8 +144,6 @@ static int ffa_print_error_log(u32 ffa_id, int ffa_errno)
 		return -EINVAL;
 
 	abi_idx = FFA_ID_TO_ERRMAP_ID(ffa_id);
-	if (abi_idx < 0 || abi_idx >= FFA_ERRMAP_COUNT)
-		return -EINVAL;
 
 	if (!err_msg_map[abi_idx].err_str[err_idx])
 		return -EINVAL;
-- 
2.25.1

