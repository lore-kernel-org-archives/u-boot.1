Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F6AC5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1CFB60730;
	Sun, 23 Aug 2026 19:48:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xqyc-BL0hxL9; Sun, 23 Aug 2026 19:48:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787514520;
	bh=n+1nq5EYNwde/mq26xxjyhU9S+w3/31+op5eW+QSKBI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wiysUhqeOVUaDV+A4w1ksKeTBy67j5Rcvn9xSO01wb3/WUSEnwvlDDbDu2pL1FX9i
	 UvBm7ghff3lzRXf6G8Om/DYQpz23bl8UuAnRtj/qHaWmnqMyT2xyPhcYaHRwFIUENL
	 mDuAnEIU5So6hMpGhwwBO4yZ2dazTMziqPIS3t4zE9vcpOkLElfmaSBRlwwpqQv57u
	 xbCmeNVHAhaNHS8zk5E+kOyITJP0pwDEaTxiaWSPEfPbpiXlj98xvRT/vOcXoBotGr
	 NWRaYLv7KJAWiuWoxa+1eiX77j7qw/EQjjJqM49Sg7fkdZaVKoXt+vOhinLH0279O4
	 Dybb/s97TZXkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CB6660639;
	Sun, 23 Aug 2026 19:48:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 24390279
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1693540528
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QSHw75c9nzj4 for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:48:35 +0000 (UTC)
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 23 Aug 2026 19:48:34 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=ZiQ1nPG4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.228;
 helo=mta-64-228.siemens.flowmailer.net;
 envelope-from=fm-294854-2026082319472748c2c5ce9f000207c5-uymz6i@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 426D14052E
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:33 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2026082319472748c2c5ce9f000207c5
 for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 21:47:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=n+1nq5EYNwde/mq26xxjyhU9S+w3/31+op5eW+QSKBI=;
 b=ZiQ1nPG40sDjyrlj851MEiZv6UMLUaO4sivh9JuR9RMD5v5H7xlGZXxo6bcJxFIM/OJC/I
 LZAKY/jkSkE2eSA2LcHoBfUBaQiLlBMMoPDDS9srd/jY6fQCtXNo/R/RMITOJchPgCDFlGv+
 K7/jOp4/BaBY7kwQp7o0Dy502fkbq3HgaDmtcyeCKtvPKMDc8DNvj9yqChp7Z0aqYTREPAU7
 8JF+aJAmFm2JDavSqVYh9Ymzif4doMUKWygZ+1GhDScqadYzT77StKpuBwvL0o6FFUY1Ao+M
 Ph06gELErW9kd5PpsuqN0RCOsltzXT/erBtUnlYk5GRUPeofGJIdtwbQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v2 0/5] optee: Add support for enumerating RPMB-dependent
 services
Date: Sun, 23 Aug 2026 21:47:21 +0200
Message-ID: <cover.1787514446.git.jan.kiszka@siemens.com>
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

This allows to find firmware TPM again with recent OP-TEE versions,
possibly also other services. The StMM service was not affected because
it is directly invoked by efi_variable_tee when needed, and that is late
enough so that all dependencies are available by then.

See patches for further details.

Changes in v2:
 - fix build breakages with disabled CONFIGs
 - structure code differently between optee core and rpmb
 - debug() -> dev_dbg()

Jan

Jan Kiszka (5):
  tee: optee: Factor out service enumeration and binding functions
  tee: optee: Add support for enumerating services that only need RPMB
  tee: optee: Do not warn about TEE_ERROR_STORAGE_NOT_AVAILABLE
  mmc: Call back to optee after a successful mmc_init
  mmc: Make "MMC Device not found" a debug output

 drivers/mmc/mmc-uclass.c          |  2 +-
 drivers/mmc/mmc.c                 |  4 +++
 drivers/mmc/mmc_legacy.c          |  2 +-
 drivers/tee/optee/core.c          | 58 +++++++++++++++----------------
 drivers/tee/optee/optee_private.h | 24 +++++++++++++
 drivers/tee/optee/rpmb.c          | 19 ++++++++++
 include/tee/optee.h               |  6 ++++
 7 files changed, 83 insertions(+), 32 deletions(-)

-- 
2.47.3

