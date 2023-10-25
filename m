Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34E9C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 23:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B2A887AEE;
	Thu, 26 Oct 2023 01:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MjJmxSzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0FBD86F9F; Thu, 26 Oct 2023 01:13:21 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D22FD87009
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 01:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cd4cc515fso2251921cf.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698275598; x=1698880398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YVOpyIggKx8lkCckbEXrE+4m0MK0sWcdizcYfNKXB54=;
 b=MjJmxSznPEgef2M/yi2uqFHhsrJiFlW8CnUKAG1Opq31E+W+RG9/Q5he6427LmCBU5
 jMD9xfhZ+aOC17K/gPqBgqs2H+Lv1OOOQ4QDuQK6whlY3YFlQYmr8/u5bKDjposzuLbN
 jAQCZZ8gdswM3tD/PUyn5PTWekHZvi1vW3ycuFAlpbeqZJjrLDtWU5GysjONDKhjYJXr
 nZf5g1z75g6bEPeGZLBgCZWuBvq7aINYZVqiOxoysS0MNlMPGJieRrjeuEGJ87YHLTrZ
 xCa5dtutegGMJBGEY0MNEDK+Pg8pSo0vVNyhjMvU7A1Ggh/mIAqRTvQ1VZNN/oDUL3iN
 ZD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698275598; x=1698880398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YVOpyIggKx8lkCckbEXrE+4m0MK0sWcdizcYfNKXB54=;
 b=uDBUi+LCEVP42r6jYCiygF+1C4y5BOqrJReWeGUf9O6gaOvIWsFcL2msiCqQHEZxiT
 YYgxaoZzFeKh8jVYUddA4/fF7Xqqy8WQXDm4P86KQLbeO4R82Wl3qrGrpZSEj/AVjVjd
 JtWQSQca7EBdAAg6xdJ0mE/wrksuD+WipKrirgmt/SVrcL1aNKO1l/XDnCY4rl4q51eQ
 Ps03p6n7vOzHajiX936097SBtyb2i84oO2L6vHMknYwwDqFHg8Zm9479TqvRPOgE4xxi
 GsMwzm+CGWOEjXTuZj5kxyNnKypxxGyd8DHMHK7LFg9kxd/OssynZx6RfPmwyN52VdRv
 DFdQ==
X-Gm-Message-State: AOJu0YwTiFwBKKgSH3Ol6dT5s+VcDRqm0NcBNnNMghu3m6eafxMqK8T7
 5OcJexd3ctpIJGzR4W1CY58naCzM6GI=
X-Google-Smtp-Source: AGHT+IHS9JvRYgD1tmPpLqGB10roqC6wDfn3tFOBrh1sH+k3N1rsI8F0aIBeSJGToKSmKRbXEHWpUQ==
X-Received: by 2002:ac8:5a85:0:b0:418:11ab:1c00 with SMTP id
 c5-20020ac85a85000000b0041811ab1c00mr17746951qtc.49.1698275598105; 
 Wed, 25 Oct 2023 16:13:18 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:449a:a220:d0aa:3d6a])
 by smtp.gmail.com with ESMTPSA id
 x10-20020ac8730a000000b004180fdcb482sm4576814qto.81.2023.10.25.16.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:13:17 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>
Subject: [PATCH 1/3] configs: rzg2_beacon: Disable the ability to remove
 devices
Date: Wed, 25 Oct 2023 18:13:09 -0500
Message-Id: <20231025231311.8701-1-aford173@gmail.com>
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

In order to save some space, disable the ability to dynamically
remove devices.  Without this, U-Boot is too large to load without
recompiling TF-A.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
index 73abe966b8..7b14d225b5 100644
--- a/configs/rzg2_beacon_defconfig
+++ b/configs/rzg2_beacon_defconfig
@@ -48,6 +48,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_VERSION_VARIABLE=y
+# CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
-- 
2.40.1

