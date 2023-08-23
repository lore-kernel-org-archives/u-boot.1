Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84BEC27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3DDF864D9;
	Wed, 23 Aug 2023 20:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d6lgH2vS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D6A7864D7; Wed, 23 Aug 2023 20:48:12 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35C4886456
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34cb5c41777so9173475ab.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692816488; x=1693421288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSZ4S3SBGweqYoyX9KKS4ryytd+o46w0MKdKUaY3gZs=;
 b=d6lgH2vSe/ksyxYxsGaOKI4WJ7KdDS64YxGg1xyCDzC/nZFGkOrXm2j1eYVTQVm/cv
 q8z+phqz0DMFGPosE1qkD9EhicxqQ+ZimIvBkYhZAzC31HFVvYo54giSHIIo99IOyWJG
 02qli+zJxYqW66LJvmnSDt5Kdp+jkqKcVT0xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692816488; x=1693421288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSZ4S3SBGweqYoyX9KKS4ryytd+o46w0MKdKUaY3gZs=;
 b=UFS/x1qgJUWW/F5XciYqC0DA9k1k1tgoFRG2O0lG0bhelRhJm9ljHWLi4OHmWS2MdW
 mP1OP67E0KRNdWWejkB88fOVHdNPPR4p4TsAgPckz4kKxWMaw/NHL1n8h+wlLdDkGDQN
 8BANM9Ff1w/zOfzPhk3Y31vtrDeeo0V68eL9KQ6ZinltevYpaqqljDRBKza1b5728SgL
 ZZgOctDjpqIdyaOMAfIw93OCwl2Fh/MypLsNuDvAL7W3e8s8yimD+Qv9vg7e0KTViq5l
 apH44pO4tUlp8CPukbZRjIrnO3O79NfFfdD+XMJFK7VkKd09PukXlkByIlJ/tI5jB+Zj
 fwcA==
X-Gm-Message-State: AOJu0YyIbnRSMunfvWrQOkofv3SzdzTujc4S6CrSsWexOe1i1tBfYtQ5
 6/oUKv/ISLN/SXltrUjbIBAXsmw/GAZfrNIJORQ=
X-Google-Smtp-Source: AGHT+IFHrHuODE2/G5DxS8pcDyRwwBU1wf/bguR+E1O4nJfS8Q8rTTKFMl2112pYP+nvTA58n1dABA==
X-Received: by 2002:a05:6e02:1d85:b0:34c:ceaf:b627 with SMTP id
 h5-20020a056e021d8500b0034cceafb627mr1518128ila.29.1692816488803; 
 Wed, 23 Aug 2023 11:48:08 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a02c054000000b004182f88c368sm4070929jam.67.2023.08.23.11.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:48:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 8/8] x86: doc: Update the list of supported Chromebooks
Date: Wed, 23 Aug 2023 12:47:41 -0600
Message-ID: <20230823184746.842091-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823184746.842091-1-sjg@chromium.org>
References: <20230823184746.842091-1-sjg@chromium.org>
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

One is missing, so add it. Also mention the SoC used in each.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/arch/x86.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/arch/x86.rst b/doc/arch/x86.rst
index 725a1ae5863..89d3e7ba0e4 100644
--- a/doc/arch/x86.rst
+++ b/doc/arch/x86.rst
@@ -25,12 +25,13 @@ are supported:
    - Bayley Bay CRB
    - Cherry Hill CRB
    - Congatec QEVAL 2.0 & conga-QA3/E3845
+   - Coral (Apollo Lake - Chromebook 2017)
    - Cougar Canyon 2 CRB
    - Crown Bay CRB
    - Galileo
-   - Link (Chromebook Pixel)
+   - Link (Ivy Bridge - Chromebook Pixel)
    - Minnowboard MAX
-   - Samus (Chromebook Pixel 2015)
+   - Samus (Broadwell - Chromebook Pixel 2015)
    - QEMU x86 (32-bit & 64-bit)
 
 As for loading an OS, U-Boot supports directly booting a 32-bit or 64-bit
-- 
2.42.0.rc1.204.g551eb34607-goog

