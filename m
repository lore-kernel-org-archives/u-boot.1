Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF28C5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 09:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 011BE80FB3;
	Fri, 21 Aug 2026 09:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z2gA2Ae6DwEx; Fri, 21 Aug 2026 09:30:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787304615;
	bh=2ER57ajvPDcbB+0bTGny30AjAqDOoN0Qd/rOFf9IHGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H/RFKeztetp3wsCfO29q2/r+pIbiZ02CapHMYIN21/Eq+i7cMm5E8tVczhgMkhqEr
	 ph0J7IIgkI0M8WaQYGLfVCgNdUNzhrqvxuWoMD69iwMwGmruRgGuj3pjZ4/Pmzd/ub
	 1ZchRkUxTTbTVQpIEQEGUXC9XKqOpI9oPgvBBCq/E2Zo9FF59oEsLY2XkbqpuwBgrG
	 3v2rxsrEYnPxSHZXI8HjX1BMHDnpasPAwvVbz90UpeSXqV3kYa0GhuNztPG5W4Lbvg
	 BRI9qHHdcLoJViQNPhWIRGMy5D3jLWeqIbqZRtqWKjEjxrYpsV8snFUGNpgPwQOo64
	 w5fYUoxt9YJPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F186D80F14;
	Fri, 21 Aug 2026 09:30:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 23234336
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14BAA40931
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VRXIbZuld2Vt for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 09:30:11 +0000 (UTC)
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 21 Aug 2026 09:30:10 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=G6W6D7DV
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-294854-202608210929031541e5f58b0002079e-04jfyo@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2789C4091E
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:09 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202608210929031541e5f58b0002079e
 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 11:29:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2ER57ajvPDcbB+0bTGny30AjAqDOoN0Qd/rOFf9IHGk=;
 b=G6W6D7DVXAe+Q0ESFkCct6AWML2Jh1HhX9ckNuBKnoRM69gr4M+oEC5p+is1aZbrjrAct5
 uj6VJbqETuwrHxA4HWS6ZmAwDuxPUsiY87/lO+DCuLHBJEQ6FBt7hSuxJ7XXinESpkIL4KcJ
 2ZALERzPCbjjLWorTOoVH4DEdtdq94k+MMAX3KG8Im9FwDDU44ODvDCVCgsPJOg6aAar3tAL
 7i1eD9saQgVtE3C3jOMUrvcX7KnCTx1uOd5f0oVxJwS8wjqN+WJnso3h5u/9yuOEqcwHpQNw
 LN3kNzJMmOY7b10hGq6b2WplTUpleLetq8FEojZICyAz6zu6hcrWAf3Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 4/4] mmc: Make "MMC Device not found" a debug output
Date: Fri, 21 Aug 2026 11:29:01 +0200
Message-ID: <f0eb5e71d6a53ee22c622ecfef8849ace1c12ce2.1787304541.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787304541.git.jan.kiszka@siemens.com>
References: <cover.1787304541.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Callers of find_mmc_device are generally processing and informing about
errors already, e.g.

=> mmc dev 2
MMC Device 2 not found
no mmc device at slot 2

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
CC: Peng Fan <peng.fan@nxp.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/mmc-uclass.c | 2 +-
 drivers/mmc/mmc_legacy.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 698530088fe..cd930807802 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -319,7 +319,7 @@ struct mmc *find_mmc_device(int dev_num)
 
 	if (ret) {
 #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-		printf("MMC Device %d not found\n", dev_num);
+		debug("MMC Device %d not found\n", dev_num);
 #endif
 		return NULL;
 	}
diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
index 8f8ba34be71..2a4a8a83fb3 100644
--- a/drivers/mmc/mmc_legacy.c
+++ b/drivers/mmc/mmc_legacy.c
@@ -45,7 +45,7 @@ struct mmc *find_mmc_device(int dev_num)
 	}
 
 #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-	printf("MMC Device %d not found\n", dev_num);
+	debug("MMC Device %d not found\n", dev_num);
 #endif
 
 	return NULL;
-- 
2.47.3

