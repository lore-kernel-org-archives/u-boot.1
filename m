Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A91C79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 15:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A84A405B1;
	Tue,  8 Sep 2026 15:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4m1c8t-5zKeq; Tue,  8 Sep 2026 15:04:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 12B8B40547
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788879896;
	b=J8efGPCqsYSAqVnlmL0Moy3Hq9y5SeReMtfTveV2wdqgp/M2bacNgtfVmyZdFOyEE3ow
	 dCCv0ok91pmJM3PC0FTY3R/1Ao3ldFXZmTd1Wnom1svuRcf8+gJLQ1UF0gO8+5cXwLYoi
	 ME1XHfs8efqWbRg0FFWBo+7qgy56/YvLPTH1k/DEp0NecIkKCcz9FSifiZB3aYKiVVroO
	 wk02NQM7K3EQoqJa9aw4fhmCAtAQgyf5ObdGlU3hq3i3l24Qg9/SKCEgbl2uL8fLDdtxT
	 GQK0+0CNaAppYCBRurOdytM7OGXtJfOTtLRwUrHnYDUUcgzs6KaY7jLqv27hXv5jQZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788879896;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-Flowmailer-Platform:
	 Feedback-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=E/UXpfaUy2skYtnBxEn46u/1ZANeHANItzBv1cBvE7M=;
	b=JypxYTI2Wn69lDWngvW5oVvM/cyqqIg0Ex2QCJMeLDhozssca9n4x5be9KUZtR5NP1mE
	 XckqDFvMNekS7tS/xmDJDC6dSYWa7NLI+lUnr4lxOGJzMca7Ly7TrKgbJTXiCFYHp2fOB
	 zJMeZSaP/vbIXLIkuu4v3a19FQmsZocDjnXEfO/HfKFJnUlAetGZUxPcOQMk9QZU8nfCM
	 /12av+uBJZxK/y/BAWp7L0eNb5cvFux1QGhnqGTYs2LeywlkRwdMdCBfpG7uzZn6uNSth
	 vrOiRkba+cX7tM1oK+JHAPAOvENbZMxPZprQglH11Y6gIb0ewLSsiL8h7oj5vZrG2KQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788879896;
	bh=E/UXpfaUy2skYtnBxEn46u/1ZANeHANItzBv1cBvE7M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zJMU2T1YfQ/wsAZSrCvxLcqGkyhkvEZTxAn2jdZj/WZUXuHcCneucLoE4iu1zm1i0
	 rsusjzi2d66CtEyx7FsElUGSq7bfchdhRM39EwLO1WIRT45Q70nnpp53+JBOy9iPz9
	 Mx7x4V/6w6S3Icjmh+KPHBf4BNZzUwunYSK6e5DTdOyKqVRPlvpCIXsn1BJVCK02+u
	 d6Uo1ZVVlocA1jlFt4br6blJR9jsJWO309C8ucOWljkdvAmcRQ6GY8zPARtwLSSbYJ
	 4FnCTd6LtEMOSfYSHLr2tDPSKw2K9Sa/Z2Ja/wGBrKBohwq4MIZ8VYl2DS0WMsoUEA
	 qtYzPO3zAkUtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12B8B40547;
	Tue,  8 Sep 2026 15:04:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B8C2D90
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2873960718
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2_ev2Kc678cH for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 15:04:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E6E6260712
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788879886;
 b=n4k3/7pGBE00e7Sc0jvtos8j7fedeIC2MoQ41GIT4hSFVfjWaAlE8VGT6JeZ7RYU5m8K
 Zug0DRvlIO4bdeFICrzOgcZO4pfEcaV6AGK9f0AtlzDOC9OGEnczj3sqGO8cB8NBoxQEK
 T/lE6Bvez4gG5xpX+DV0U3KVyTr7elW2cBf67Nvt/tFGD4iTZOS1D8GyFQdhV2ibreNxK
 P9dYUD7QdWd3oCYdZvQTTCrhxhmY///qtMzRtvef0i2bV2t8vb7Q/QFkZJXqhZr8h8dqj
 e5IjcT+3phzyXrBHy2as8M8w0oHwHjwmnwalNBbL6t1OMPMSr4wz1VKi8LFkfMBEgWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788879886;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID;
 bh=E/UXpfaUy2skYtnBxEn46u/1ZANeHANItzBv1cBvE7M=;
 b=kZIiA7fxqmcEiEAbPbjOAHM+fo8INwCJLbPJhSzfKzS7G42thIPiea9dbvBxNA4rqYOn
 IVtFo5obbV96BV0s+dsh762T/M8TXEslnAkr49dfOBIwOq3xe4IvbLqrNdds9nWJ+4e7m
 NwJe3KdiWcQZ0c7wbd70qBbF15hElPTFs4KIRZTnU9Gj65yTzbiMFk8VQ/7ae2d3Y619d
 a0qAxm0vb7lPuFHm/uSeq2usMRl3l+TEyiW3xUhFx0xkbOah/H3PXuwlLwYJDH3+Rd1Sx
 yVmapY4iAQXYKeuBcnBEXRCeE1i+c+UqelQEBOEmm5W+KRC+OHDfiS8dYFcOMbxpBXQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b="IF//xMLp"; 
 arc=none smtp.remote-ip=185.136.65.226
X-Greylist: delayed 62 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 08 Sep 2026 15:04:45 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=IF//xMLp
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.226;
 helo=mta-65-226.siemens.flowmailer.net;
 envelope-from=fm-294854-2026090815033835177d00b9000207a1-dngnk9@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E6E6260712
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:45 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 2026090815033835177d00b9000207a1
 for <u-boot@lists.u-boot-project.org>;
 Tue, 08 Sep 2026 17:03:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=E/UXpfaUy2skYtnBxEn46u/1ZANeHANItzBv1cBvE7M=;
 b=IF//xMLpyvOlTSFAJet7u0vocpIxSi4MyU026j4vm3p4RVT5Pu8SfcNwzxpORBCVE8xgSJ
 CpaK8LmrcOqMpiHatTijncJCydudvGy2TbZiaLWVpbqF+jFpuBX2gbhuSgkOpRNA9+DTEmoe
 xInI1jjQxgn1iynILXNnhJzs8Ag9QYM2ITQVgIls/vNrbfhl14kCWODdhSmHZ3f34xci+TqD
 9Vr3TMEPERxLmEo7S8bwm9rTafr9HuhPr0taZd5DrFiYQ9jGbqmfFAAUZQ2XDhm5VtOQ61KW
 T/2YXnMijk/Jmtq1kTOjY6gYvUur2ixqgv4HXdOIJlsh7oPQEViqFkrw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v3 0/5] optee: Add support for enumerating RPMB-dependent
 services
Date: Tue,  8 Sep 2026 17:03:33 +0200
Message-ID: <cover.1788879818.git.jan.kiszka@siemens.com>
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

Changes in v3:
 - don't use dev_dev if there is no valid dev
 - add device_active check to optee_rpmb_available

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
 drivers/tee/optee/rpmb.c          | 20 +++++++++++
 include/tee/optee.h               |  6 ++++
 7 files changed, 84 insertions(+), 32 deletions(-)

-- 
2.47.3

