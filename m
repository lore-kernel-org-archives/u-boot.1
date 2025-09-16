Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B2FCAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 10:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D49803CC;
	Tue, 16 Sep 2025 12:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KtVSMNgx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE54831C2; Tue, 16 Sep 2025 12:35:53 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C16280325
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 12:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GAZjAi1255970;
 Tue, 16 Sep 2025 05:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758018945;
 bh=T2hC+DQEO2hP7jJmqjlCiuc47dq9UuWvncWmiM7kJfg=;
 h=From:To:CC:Subject:Date;
 b=KtVSMNgxf3jUEVdyUPweKkdbUB//v677kldhaKUa+JJlvlFRpqaGNqo3jY3ZelUf9
 Jf+HTxpFHAG/IBOzJpLQNijkGkN6QezJ5tlYPXeD0al8d6nqflrrqa7/r73btmbQYo
 oVW4ueaD9SydBhf/DiiKjywUVY7F8uNXmUEGW2ak=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GAZik3462271
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 05:35:45 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 05:35:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 05:35:44 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GAZhUo1180573;
 Tue, 16 Sep 2025 05:35:43 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 0/4] Add support for secure falcon mode: load kernel image
 before args
Date: Tue, 16 Sep 2025 16:05:37 +0530
Message-ID: <20250916103542.104773-1-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi all,

During the implementation of falcon mode for TI's K3 devices [1], I encountered
several limitations in regards to the current falcon mode support in U-Boot
especially in ensuring a secure boot flow.

Although the current implementation allows for loading of a signed fitImage as
the SPL payload, there are still a few edge cases that might allow bypassing the
verified boot path.

The following issues with current falcon mode need to be resolved:

1) No fallback:
    We currently fallback to regular boot flow if falcon mode fails,
    this might not be secure.

2) No arguments file:
    We currently load a kernel file (which could be a raw image or FIT)
    alongside an args file (usually the DT). The args file here doesn't have
    any verification mechanism, so should be skipped altogether as the FIT can
    contain the DT.

3) No access to env:
    In ext and fat fs boot, currently we also reads the environment to get the
    names of the kernel and the arg file. This should be disabled in secure
    falcon flow as the env might not be secure.

4) No raw image boot:
    Boot should fail when the kernel file is a raw kernel image, only FIT should
    be allowed.

As per the recommendation of maintainers[2], I have decided to split the above
set of tasks into multiple patch series. This is the first one which fixes the
load order of kernel image and the args file in falcon mode. Along with some
minor cleanup.

Regards,
Anshul

[1]: https://lore.kernel.org/u-boot/20250603142452.2707171-1-anshuld@ti.com/
[2]: https://lore.kernel.org/u-boot/20250911172313.GT124814@bill-the-cat/

---
Changes in v2:
 - Split series into multiple:
   1. Fix load order of kernel image and args file in MMC/FS boot (this series)
   2. Prevent fallback to U-Boot proper in falcon mode
   3. Remove the need for args file in falcon mode
   4. Disable env in falcon mode
   5. Fixes such as disabling booting raw images
 - Add call to ext4fs_set_blk_dev and ext4fs_mount for args file
 - Add maintainers of platforms with SPL_OPTEE_IMAGE in CC
 - Pick up R-by tags

v1: https://lore.kernel.org/u-boot/20250911131414.3296697-1-anshuld@ti.com/
---
Anshul Dalal (4):
  spl: fat: load kernel image before args in falcon
  spl: ext: load kernel image before args in falcon
  spl: mmc: load kernel image before args in falcon
  spl: ext,fat: cleanup use of CONFIG_SPL_LIBCOMMON_SUPPORT

 common/spl/spl_ext.c | 66 +++++++++++++++++++++++++-------------------
 common/spl/spl_fat.c | 55 +++++++++++++++++++-----------------
 common/spl/spl_mmc.c | 20 +++++++-------
 3 files changed, 78 insertions(+), 63 deletions(-)

-- 
2.51.0

