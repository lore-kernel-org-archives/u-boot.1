Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84415E9413F
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 03:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A638D86B35;
	Sat,  7 Oct 2023 05:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kP9rupEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF5686B89; Sat,  7 Oct 2023 05:34:49 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 119AF86AE6
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 05:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59f6e6b206fso34350457b3.3
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 20:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696649685; x=1697254485; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YxSvlTt8BaSlGvrFW3s3PsPsa+POYOURVmO4q5R+KBU=;
 b=kP9rupEfxUe25evBuf2MG47N0CcnoqVZ9bBQtYT7bt9perlNeHIa6fn0IV/oozEj2p
 qwREDFOg1CROE2SqgLrcv6tJj1XFHjYv6zkszYqn3tqzcDCl/aGeURp+hR+CZWmR3Plh
 5cEMZMmDG7882xfmEyMplXG0N12BU1H+92m7qqbA3JwV2yR2/hxDnc3w1e9w2gGma4CG
 3GYNiIu+G9Y6hi11AOsmQ1TcVp3ZqM+m9gOrfRqIDcnnfWinrhcE2KDkG2NEK7fWHnCD
 VJ48ZAdDADpwXxMJXMOWMb+4sWtW9S175SKguVx7raxMO2PJHBfxoVnDaMM39AavGBSv
 k0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696649685; x=1697254485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YxSvlTt8BaSlGvrFW3s3PsPsa+POYOURVmO4q5R+KBU=;
 b=UFaUXEDHNfKioXQcmMeA+HFHTRKPWfHlYL71j7B6bHF6KmSzoypXgY8ZtcaYPIDRZd
 EvSmjgKnJf1lLsu4CaQiSvBr9hxIBpwRe4JduZTjgcc4EO8dcOakinExW4++ne1LA067
 Zxp3HLCZ45K7mfnhrH9xWPTbsJJtNdq0cT2w23qACMBEGHY9YseMS8+tftGpSmk42j7W
 gdO7EqJIBDnJ4aTNVOyH8gMVyAeeQi0CXYArTF0ayUiKHz9MmTxL/DhB91Z0nRDojlc7
 j8kMbYDWFEAQ7N/raNtyvu5/dXEdkwqSknG0bAeyTAyYi+adYx4RrpdCcwB8tUefvCpO
 40bw==
X-Gm-Message-State: AOJu0YxKuwpIWW+CowDPmZbU2rBvHu4wbI8aEzKm4dyiFIS27JnrbKwE
 5f7VSCwlynCU5x3yMZs7UxM=
X-Google-Smtp-Source: AGHT+IFpVzGNPMe3S+6Ir27yGdo9IJ8EOm8LEQoRzaUBnkcEHMFJKRt7c2YwjGsvDbde7UHoWXV3aw==
X-Received: by 2002:a0d:eb8a:0:b0:583:2ce7:2e10 with SMTP id
 u132-20020a0deb8a000000b005832ce72e10mr11222126ywe.27.1696649685654; 
 Fri, 06 Oct 2023 20:34:45 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 i194-20020a8191cb000000b0058419c57c66sm1772470ywg.4.2023.10.06.20.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 20:34:45 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [RESEND PATCH] bootstd: sata: bootdev scanning for ahci sata with no
 drive attached
Date: Fri,  6 Oct 2023 20:34:28 -0700
Message-Id: <20231007033429.25109-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

It's normal to have no SATA drive attached to the controller, so return a
successful status when there is no block device found after probing.

Note: this patch depends on the previous patch
https://patchwork.ozlabs.org/project/uboot/patch/20230917230649.30357-1-mibodhi@gmail.com/

Resend the right patch.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 drivers/ata/sata.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
index f126b84e05..dcb5fcf476 100644
--- a/drivers/ata/sata.c
+++ b/drivers/ata/sata.c
@@ -79,6 +79,12 @@ int sata_rescan(bool verbose)
 
 	ret = uclass_probe_all(UCLASS_AHCI);
 
+	if (ret == -ENODEV) {
+		if (verbose)
+			printf("No SATA block device found\n");
+		return 0;
+	}
+
 	return ret;
 }
 
-- 
2.39.2

