Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2A4C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 09:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C02F60A63;
	Fri, 21 Aug 2026 09:30:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ecVX_hjXCVpk; Fri, 21 Aug 2026 09:30:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787304616;
	bh=quwyhFU74ozSDMa5sFc2ngyAsKLDC/XcZi10ChpMBiw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HwFPxAb6B2H36onk7D77rUqPwSzP8UN/6febARXf1dA7e+oxYlPjoenYiO1SSQx5Z
	 EGGtox7EN4NTnxmVJCT6DwkCmvTTmJvvVI2VU2wUjHjMG31iJfbSFrKN3OmTNtrkOU
	 fWFXXSSdMSKVcGBBwtG8Da1QDyRUi6SfJqBvv/nkmjReMKRC/bi1YEkXOXa8gxmBHg
	 Zzcymv7hBYUDGgUQFrVzWfLQuQfchxxtf4VNEprUXNtGpaorvYp8z2qX7u4F7N+euJ
	 JnVyAP+wd9oxdkwDi+bBtB+M1V48dGTIF3Ys8HAQsEZGpC5bwP0DO0dhMgn7mU1sce
	 LL9GZwjf03XXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A6B960896;
	Fri, 21 Aug 2026 09:30:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 59589336
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B4DA4091E
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vlQIIeGhUMOm for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 09:30:11 +0000 (UTC)
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 21 Aug 2026 09:30:10 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=hXg0zvQe
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.226;
 helo=mta-64-226.siemens.flowmailer.net;
 envelope-from=fm-294854-202608210929026db9486a9500020796-x8_m9_@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 341344092B
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:10 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202608210929026db9486a9500020796
 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 11:29:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=quwyhFU74ozSDMa5sFc2ngyAsKLDC/XcZi10ChpMBiw=;
 b=hXg0zvQeATZzFslWu3aKgFitFwft7GOV9t0tNZQjlNmLVIJDmEuOwv0R4ytNcuBUUFN1n7
 EFGsmZ/SFD59ShQ4RkhmFsmE4iGyrDS9bjBVWxTE6WLKNrhiDQMiNzynmphDa2NE94d5usNZ
 AzXWwU+VJd/80WsROYr+1xkImDoQKMbLi65LyqPrt7/sTBtZkygrHgsSiUMyOLmQuPy+iPF4
 VkfVfqiqy6gOowoF9BPAAaJsP4lhGzs9cSL4PCVkvg6qWxR3cto+cp6n85odQb95bisn+OK+
 OXd5V/YpLmjLR13ESf/V7J3ojqIAK+Lar2QZFVL6/O3nMsPkmafiZiXA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [PATCH 0/4] optee: Add support for enumerating RPMB-dependent services
Date: Fri, 21 Aug 2026 11:28:57 +0200
Message-ID: <cover.1787304541.git.jan.kiszka@siemens.com>
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

Jan

Jan Kiszka (4):
  tee: optee: Add support for enumerating services that only need RPMB
  tee: optee: Do not warn about TEE_ERROR_STORAGE_NOT_AVAILABLE
  mmc: Call back to optee after a successful mmc_init
  mmc: Make "MMC Device not found" a debug output

 drivers/mmc/mmc-uclass.c          |  2 +-
 drivers/mmc/mmc.c                 |  4 ++++
 drivers/mmc/mmc_legacy.c          |  2 +-
 drivers/tee/optee/core.c          | 37 ++++++++++++++++++++++++++++++-
 drivers/tee/optee/optee_private.h |  2 ++
 drivers/tee/optee/rpmb.c          | 11 +++++++++
 include/tee/optee.h               |  2 ++
 7 files changed, 57 insertions(+), 3 deletions(-)

-- 
2.47.3

