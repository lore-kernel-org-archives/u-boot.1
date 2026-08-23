Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA82C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B832680B1B;
	Sun, 23 Aug 2026 19:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UemeXiTt0_Az; Sun, 23 Aug 2026 19:48:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787514518;
	bh=rQY3YjXi3UZBFtZlILW/l17NG27nqmdz7PxuJI6OYm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UJ6Fa/M0jzkaKqfjc59t3caYuNMTMNCA9Pi+lXKwBSyGwNOIBzq2uhqR246N3Pbtd
	 4KswpxPC2cPPZSpVg1kXhi06cyF5M9acBbrZSdQnKv/Qj+URiU1XUhqV6lGNp6wToa
	 kNA9qzgI6BcpWKDU2oHwGV6j8pxnVa+3Q5ylu+VDXgK9zHT9yDSazMGsnqKrEOB5Sd
	 HKpwk+WG7D88HB1uwAmku5jl7SPFj9UywxCAlk9jN25Zd12H6mhuCLVQL5IzDAR7YW
	 TRzAIInNzZc8oKM6XhQhzJa/+mAM0ivmQqPNCVuhfPe7PCN8w1WnAi7HgihZuvMfvK
	 D3adGqkleSpow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3480480B2E;
	Sun, 23 Aug 2026 19:48:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC204435
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEAE64055B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KBQ68B56fJ_w for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:48:35 +0000 (UTC)
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 23 Aug 2026 19:48:34 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=Gl+FLOD3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-294854-2026082319472828096396b70002072b-cd2l3h@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45C294052A
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:34 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2026082319472828096396b70002072b
 for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 21:47:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rQY3YjXi3UZBFtZlILW/l17NG27nqmdz7PxuJI6OYm0=;
 b=Gl+FLOD38CTyi6EI4jiLR6w6DDt6hL5G0Hn3CBYabTahyzC+cOPW5svjnz3dTGu9az7P+Q
 rmXda8wHtFJJlSCuX39AopOvK/i7iQ4LCEIu2N1eFYdu54lEmXmmUyNw9zWTBCno6JhlCL0J
 E+VZuBDS+PPcPBQbFhw2TNEvVz+vLKGUbyYPEzSHZjU/bzXVDjdJXgal5Ti6VxxY/1koO+kT
 2O4eGo8MLbNDJ62+mWQIkHeFASkCIBJYuQzLVNzr0KTQ8cv4NyJ52nhP1ktkkRaz2J8CZu43
 Tz52Cu5auJta+aTcXiXRCeP5uo301uuIPkVVPT+F0mk2e9DXbPgWYdtw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v2 3/5] tee: optee: Do not warn about
 TEE_ERROR_STORAGE_NOT_AVAILABLE
Date: Sun, 23 Aug 2026 21:47:24 +0200
Message-ID: <13fc430cf440cdbc490bce630031ca49e81e1e13.1787514446.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787514446.git.jan.kiszka@siemens.com>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
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
index ed8f2b6ec74..d3b5811afb8 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -106,7 +106,10 @@ static int __enum_services(struct udevice *dev, struct tee_shm *shm, size_t *shm
 
 	ret = tee_invoke_func(dev, &arg, 1, &param);
 	if (ret || (arg.ret && arg.ret != TEE_ERROR_SHORT_BUFFER)) {
-		dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
+		if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE)
+			dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
+		else
+			dev_dbg(dev, "Enumeration command 0x%x failed due to unavailable storage\n", pta_cmd);
 		return -EINVAL;
 	}
 
-- 
2.47.3

