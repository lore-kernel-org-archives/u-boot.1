Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DBAC5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 09:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC89F810CD;
	Fri, 21 Aug 2026 09:30:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WigcL1ziDruu; Fri, 21 Aug 2026 09:30:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787304619;
	bh=Yv5kkpdvk0WbtPNiA3r9l3idT3vlojiKvRVklstsS74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MZPHjERZHzpB9SyNTzwzgienisFJPGugPBPfNzraxz8YSuSDsiaS6wCfEY2EBHFAw
	 UR1Euq1FQ9bxMoN/M/qCB7fVw/GvZat+PK+FXFoCT20EY/h1H9/mB/wCUisVhbl7p8
	 SwBCnZ5zmqrwBxmH4XemRo3lT2FqAsMaAfh1dzrRJc0nodxh41sOVIRNqrFIqyqcCi
	 OYMyogI4bgs0hFi1NC4VkaNwiuH1bjmR2NrFHl2Ub8g3O5+dWncARSroh6w7jidYzs
	 d0CDqKVL+CK+5xeoSJEzuT5RTgdTDmv2IIC9gvj7YUJwHrkCGNKMndXCNdLJVGIkDX
	 7RTT+iLJ6NPAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAB3680F85;
	Fri, 21 Aug 2026 09:30:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 814AD336
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 734DC40912
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cSaF-617jq-y for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 09:30:11 +0000 (UTC)
X-Greylist: delayed 65 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 21 Aug 2026 09:30:11 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=WmDUYTnl
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.225;
 helo=mta-64-225.siemens.flowmailer.net;
 envelope-from=fm-294854-202608210929030896a15bd7000207f2-ibmwag@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4062440899
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:10 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202608210929030896a15bd7000207f2
 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 11:29:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Yv5kkpdvk0WbtPNiA3r9l3idT3vlojiKvRVklstsS74=;
 b=WmDUYTnl71ZwlhJ6443ouwcr5YOapuDAaOy7WSi/a9GFLh5tEAM8XyDeoN6qhqnO7ZrTgE
 hf4VDWFmDpKwraFX6gZzF3Xq0BxLFA3dVcF73fSsGV6tjddsnF0ACoLXOZmYEKZR6GBupXh0
 YxazwkfYZSVv6oJZ6ErH1Iea2n8p0R7tsmXMuJJgPKUlOv+yb/adL2MvHhyonKPlBGrMy+6Y
 KSmqoOfP1b+BuoXJ7OyXddmUkVcYusxBrT5QWZL3uXmoQDR/rBhZ7XtAtvdncsGQ6pTBpZhY
 JYYZemwlJi5dnO09BeJpuUfBuWzaL0OFvXSOgeNM58rU4nrwwQYeZkZA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [PATCH 2/4] tee: optee: Do not warn about
 TEE_ERROR_STORAGE_NOT_AVAILABLE
Date: Fri, 21 Aug 2026 11:28:59 +0200
Message-ID: <d85ab654b884cd830512b9807a7c1734316a0d0a.1787304541.git.jan.kiszka@siemens.com>
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

This is a transitional error that is resolved once an RPMB becomes
available. Keep it as debug output only.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tee/optee/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 5600d5a4c7d..4b1396b8652 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -126,7 +126,10 @@ static int __enum_services(struct udevice *dev, struct tee_shm *shm, size_t *shm
 
 	ret = tee_invoke_func(dev, &arg, 1, &param);
 	if (ret || (arg.ret && arg.ret != TEE_ERROR_SHORT_BUFFER)) {
-		dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
+		if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE)
+			dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
+		else
+			debug("Enumeration command 0x%x failed due to unavailable storage\n", pta_cmd);
 		return -EINVAL;
 	}
 
-- 
2.47.3

