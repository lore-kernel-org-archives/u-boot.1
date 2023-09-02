Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE7ACA0FF6
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 07:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6FD857BF;
	Sat,  2 Sep 2023 09:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UNmp/7gk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0344866DC; Sat,  2 Sep 2023 09:34:31 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 644EA847D9
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 09:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9339B425DB; 
 Sat,  2 Sep 2023 07:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693640068;
 bh=ePWbCZOtpOuA3Iveic2fV5hq7Vzm7TJCsC8wBBurorA=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=UNmp/7gkgJN+rjj3lFUcRd+mWNjpu5bIX77OmtwLBMQan/1RLFfsPtDHYG3AVV7J3
 d0/VEcBY8tEeR0GmNbpnMBH2iZaVWFnFuCbBeenOthKW35WrGzb/GoiMd4WO3EK+iR
 8vbR+cK3JV/HkO0oDq9o9+4KvwW4CGSn7SgRAdFQLYqf14mLAH1Aafb6N69/qDmuyd
 D+rAZkq86MusE6POyZ+s7MxRxZp43WUKaxYqyrdaUvPkpAmg1jGEK+PLX1NdficxtN
 zOi91QsEzgsFFM6OpuOlewRLgS3Fwb/kxcHq7pjKMpv7lrIWoNfoGCtp+d7/6lYaYm
 uhs5qjZuWS0gg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Joshua Watt <jpewhacker@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/4] cmd: gpt: fix gpt read
Date: Sat,  2 Sep 2023 09:35:20 +0200
Message-Id: <20230902073524.87451-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

To partition a block device the partition type GUIDs are needed but
'gpt read' does not provide these. Add the missing parts.

v2:
	Rename disk_partition_type_uuid() to disk_partition_type_guid().
	Use setter for type_guid in allocate_disk_part().
	Fix calculation of the size of the partition table descriptor.
	Use accessor for type_guid field.

*** BLURB HERE ***

Heinrich Schuchardt (4):
  part: rename disk_partition_type_uuid()
  cmd: gpt: use UUID accessor more consistently
  cmd: gpt: fix calc_parts_list_len()
  cmd: gpt: fix gpt read

 cmd/gpt.c       | 70 ++++++++++++++++++++++++++++++++-----------------
 disk/part_efi.c |  2 +-
 include/part.h  | 26 +++++++++++++++---
 3 files changed, 70 insertions(+), 28 deletions(-)

-- 
2.40.1

