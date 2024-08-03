Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8765CC3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 12:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA6E488753;
	Sat,  3 Aug 2024 14:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XyabK2uw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1DF88C56; Sat,  3 Aug 2024 14:42:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2AE188702
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 14:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c82d=PD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722688919;
 bh=cvJFYyvvnWrypR+HIy2R/9ocGvViAmudKS7NVk5XDoQ=;
 b=XyabK2uw+PVZJwq2dP5QizgAyBYEG1BjShbi09VIBTQnIP9Cjqcnsib4cmcDI5PPdjWn/x+AX
 7teyZ8Ws94EzUAr/Hf0xt0k2nzGynf6GA3Qysb9UCnIKcMsLMKSK4n/ePI9ZqvVfX6ibyc1CFIv
 k6UO89I+ZbW1YXkDqqOdFkqtM4cw7ivKIuCdrjm0yOleh/rP+1g1u9y6fvLDvFPTZ+3qByURUXb
 ZpwEOIO/Gxpmfl7wyWXOUcfyoAkzLV0Byhf9wTfuNkCdPhbay04aAczfV6WjbwEngANckmMjA44
 NNrt7F8soFRsirFjDVTgMx9P/5l9cUKba2sxvpKS1F4w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] bootstage: Fix unstash and sorting of records
Date: Sat,  3 Aug 2024 12:41:43 +0000
Message-ID: <20240803124149.2916030-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ae2592c2f14e5c6aed0255
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

This series fixes two issues with bootstage observed trying to measure
boot times on my Rockchip aarch64 boards.

First patch fixes a regression in v2024.10-rc1 where bootstage records
from SPL no longer is unstashed.

Second patch change to not sort bootstage records in order to show
correct elapsed time when TF-A reset the timer counter.

Tested on a few Rockchip boards with:

  CONFIG_BOOTSTAGE=y
  CONFIG_CMD_BOOTSTAGE=y
  CONFIG_BOOTSTAGE_RECORD_COUNT=20
  CONFIG_SPL_BOOTSTAGE=y
  CONFIG_SPL_BOOTSTAGE_RECORD_COUNT=20
  CONFIG_BOOTSTAGE_STASH_ADDR=0x3800000
  CONFIG_BOOTSTAGE_STASH_SIZE=0x10000
  CONFIG_BOOTSTAGE_STASH=y
  CONFIG_BOOTSTAGE_REPORT=y
  CONFIG_BOOTDELAY=-1

Jonas Karlman (2):
  bootstage: Fix unstash of records from SPL
  bootstage: Do not sort records

 common/board_f.c   |  2 +-
 common/bootstage.c | 12 ++----------
 2 files changed, 3 insertions(+), 11 deletions(-)

-- 
2.45.2

