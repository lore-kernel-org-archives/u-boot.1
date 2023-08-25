Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF687C6FA8F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 01:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B50886993;
	Fri, 25 Aug 2023 03:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fYMnB328";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35C99869AC; Fri, 25 Aug 2023 03:39:48 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74D6686699
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 03:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-792717ef3c9so13118039f.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692927584; x=1693532384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=77E9Q6asDcvUfoIsTSXtnBk1k+GnmZYLq5SwJ7g5gLk=;
 b=fYMnB328f5+T26+R33MTSqgwe2gWJ4GtsNISw/1PcMPFNwUYlaYAAWd37quIo7TvlW
 SLi6IVxxFCTkzsA5uu8hgQH9ceiV3Kj5/gbdFR2W03tNl4VyuJl5XjFMa6IO5eIW97TE
 gdDWdGwzDgaWObVgDvWQmX9y1M4corJOkUevk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692927584; x=1693532384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77E9Q6asDcvUfoIsTSXtnBk1k+GnmZYLq5SwJ7g5gLk=;
 b=Zeow2atrPGjRg83G9dktwqb1L8+Jx8ee7AVQPMrxPjL7LX6JxoUnIoKUx528UmAerF
 bUe3h91YD+wqSHVF/1WG1As3FcuBPv7HNKkBXOP/8VAJyeTnFi0kuztQkk7wpwormdbn
 Nl8Z2YaoNvnMNfR5zxHsD6VQWvCufMs5+k04Grw0DXObdOyxrzKLFH83NL8SwVsFuX99
 GMYVrMbDHNRpPeoAjn9mcluZa+kY0Uzw7ckAA/4a6rLsnq8vtOSp5dty6xexvKiR0gWd
 vTn9leCgT7QNMsz0ZZ03pTSI/ZL4WbYRUMarmBaD21Aq3dt8XIB86XOokdvwJIQWqNhS
 Klvg==
X-Gm-Message-State: AOJu0YyvdzDMwgVwgbb+eDk3r4omjLpiyFB3aORfgYyURkDh92R1vyLx
 woG6udJ/iDnEZrkMMnOa0u9LJHs7t6wHOfs5EL4=
X-Google-Smtp-Source: AGHT+IFRzda8edhgB2m3/Z17/LhyTvF0+dxu+OcLEwyatCt5lWsLv8GDOxLBpmBx2ZHsp4t6wryabw==
X-Received: by 2002:a6b:7114:0:b0:77e:3598:e516 with SMTP id
 q20-20020a6b7114000000b0077e3598e516mr8598247iog.2.1692927583810; 
 Thu, 24 Aug 2023 18:39:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 eq18-20020a0566384e3200b0042b62a31349sm217068jab.146.2023.08.24.18.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 18:39:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH] bootstd: Drop some TODOs
Date: Thu, 24 Aug 2023 19:39:24 -0600
Message-ID: <20230825013930.1753078-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

The existing TODOs are done, so remove them. Add another that came up
today.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/bootstd.rst | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd.rst
index ec3136535783..3e566e994d6c 100644
--- a/doc/develop/bootstd.rst
+++ b/doc/develop/bootstd.rst
@@ -752,9 +752,7 @@ To do
 
 Some things that need to be done to completely replace the distro-boot scripts:
 
-- add bootdev drivers for dhcp, sata, scsi, ide, virtio
-- PXE boot for EFI
-- support for loading U-Boot scripts
+- implement extensions (devicetree overlays with add-on boards)
 
 Other ideas:
 
-- 
2.42.0.rc1.204.g551eb34607-goog

