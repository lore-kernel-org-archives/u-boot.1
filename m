Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECAEC83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 10:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B58BF8382E;
	Thu, 31 Jul 2025 12:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XmIVmMLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA338382E; Thu, 31 Jul 2025 12:51:26 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF888380E
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 12:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4563bc166a5so3898125e9.1
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753959083; x=1754563883; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R0G/tEzxaHrIeH3EWxanyPTVLHczof0vxAcSXnQjyjY=;
 b=XmIVmMLL64QMMxZqiUepJ5hVPFgYc3h81E4ZMLpeZKPnw9O58DJKQDyH/DnaqTrre/
 xJ4TBNjGeEldGcYY74pmwUC6/VYodDdkKj28sBE4eNVDSZy2iptoh8I6gD5/aLMKCDgQ
 qJPhnFKQ+AnbAPAGQhHX1kXRBVJ724ZCXhV1RT1RB3Tod0rTi5BblvNskkaL6wjE2K45
 Spy4loAekZucqYxnMVcFdBExH8k9XOLCJfmxyMaXVT+85OrtKG7gpfUfqEi61HBvHRWq
 Pz+otXmLmTG2VScTxBGxbS9Q8g5v6+RrXhE4cMCnRPwHpjJPm0eujlrl6Fqr5ayjkBsx
 41+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753959083; x=1754563883;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R0G/tEzxaHrIeH3EWxanyPTVLHczof0vxAcSXnQjyjY=;
 b=eNoUuemE8wE+Am8MnXUFc2oy7k5d8GDx/pCgA2A1ZaB8I1i4G1alfX67XNrMt66qMC
 djrccYH9HNMRt5l54kpedxwlfcGR8MY9nEw/bdH8g8dkMBbl2wSnrXfh2k7HpgR8DtDX
 PHhqETUKb3Vtw0RMFaFVHAE+efbymgepncw0F0zvcNHMECdA386wJVpgHEhCCEoZHGyz
 f277hH4L7eI+K3qxnQSR53rc/Sf4kvmkvWkVTTlv5E8kMQ2YYtKvNMwIcqAMK3zMrw5Z
 WflfSqId+rqVxT8/TGa0bKapWuaHblV2dyDP2+5ZASmHsRldFRmr0L3RBVKvWnI2FwzA
 1KjA==
X-Gm-Message-State: AOJu0Yx0qYUp5xg3b58vfSaTiei4n8y2w/g9oTclW9MhFzPiA6n8iiaD
 phgTuuSI8OgclThJv3mkYlUphYllsV0VHnyi2lA43XtWCHTiYXW9UvwzAu/119T5MUM=
X-Gm-Gg: ASbGncs6alnbKssnje5ormT8v5Y6jiFiFY9hBAm1mA6YZ5aDgF4rwdXI9pAGCjujxTo
 SCL9Wvp8d9GWsB8m2EY5nMeNmEiDCxnTTT5JdKVOu7gaf3Fp1QfemEUUPGgW8H8CHzpwqMhplDf
 TjMrSqj5XtXz/bhMahXdLh4zdHitt3S3ixaqke1PnSdIQSuG49d0F2cpnzI3PcUdgVUgxqzY8io
 3ZVDAxMzaGMjRq+T71ox1rTSJ5phu3tlDN3axdx5j38W7msA74hAfOqlcljM7+xoiLmnxpt0RBO
 wymeK/coHmgX3ZW6buSXVoakA53iU+hIPAPkADBT7UFRwyuK1XVBnpuohSV9jdQIUjCxLOKnQGA
 0WoqmoTExIkm19FBqVbDIOci/M0oFc3Pk/ZEFsUQMKkZUYd7Leg==
X-Google-Smtp-Source: AGHT+IGPYCpcjm3HfZcmtNBySzMcrw7rpLK2C1OPqtgrb8fEfVRaYmh0NigXhFmNycHoKptxUsnj3A==
X-Received: by 2002:a05:600c:3acf:b0:455:f7d5:1224 with SMTP id
 5b1f17b1804b1-458a2220fa2mr15025685e9.9.1753959083202; 
 Thu, 31 Jul 2025 03:51:23 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:14a5:dbc6:afe:7138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45895377708sm58900755e9.8.2025.07.31.03.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 03:51:22 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 31 Jul 2025 11:51:22 +0100
Subject: [PATCH 2/2] mmc: octeontx_hsmmc: Remove impossible test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-octeontx_hsmmc-v1-2-440c5f963e09@linaro.org>
References: <20250731-octeontx_hsmmc-v1-0-440c5f963e09@linaro.org>
In-Reply-To: <20250731-octeontx_hsmmc-v1-0-440c5f963e09@linaro.org>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In octeontx_mmc_io_drive_setup drive and slew are tested for being less
than 0 but they are declared as uint fields so this test must always
fail. Just remove the test.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mmc/octeontx_hsmmc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/octeontx_hsmmc.c b/drivers/mmc/octeontx_hsmmc.c
index ffc8d4c7874..bb4fb29424b 100644
--- a/drivers/mmc/octeontx_hsmmc.c
+++ b/drivers/mmc/octeontx_hsmmc.c
@@ -2828,9 +2828,6 @@ static void octeontx_mmc_io_drive_setup(struct mmc *mmc)
 		struct octeontx_mmc_slot *slot = mmc_to_slot(mmc);
 		union mio_emm_io_ctl io_ctl;
 
-		if (slot->drive < 0 || slot->slew < 0)
-			return;
-
 		io_ctl.u = 0;
 		io_ctl.s.drive = slot->drive;
 		io_ctl.s.slew = slot->slew;

-- 
2.39.5

