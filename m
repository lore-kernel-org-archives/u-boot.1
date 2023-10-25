Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB930C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 06:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B61F387A39;
	Wed, 25 Oct 2023 08:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xtFfmuLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D074C871BB; Wed, 25 Oct 2023 08:52:17 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C274287A39
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 08:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso44829855ad.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 23:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698216733; x=1698821533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jtqqCeHDNnuxpOMDijUNKlbgv7aWmfLTNysTInwKBCM=;
 b=xtFfmuLKMDEo6epWo5rrLYHZohxo9ITYcqsCxkmUnkuQn1toGEJJeSE1H+8w+PdwzF
 ee3R5jzVRzgGCDcBas5DjsHaSdFzo7oJI8Vv8i+Rhq1LUYRFSnYFLYAiyi4R90nRvBtn
 eCoooavjG9KgL5Uo22ARbleZBhdUxbm2EiM1voHueZTN98cF2kzeBj/hA53xWRTk17em
 ouzbq35prVp8mg/3rCHeivwMJrCDkOZqrhXBqoAGZ+L+O6TxBHjvL59Hf/PIuxKaxnhk
 o6DnNQhIQXDJ5SloQn23qsh4DRfTc648vvonTyPK1PKzyZnvjhSBR5hRcc+SNqquJtx6
 IPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698216733; x=1698821533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtqqCeHDNnuxpOMDijUNKlbgv7aWmfLTNysTInwKBCM=;
 b=tYYsq2OC0azyEC38huGPelMtRJ+7Q1Uf6qjCPO+KzMGsvFMBLnCshgz0LWnucKY4/+
 I69MFiBtYAxPpOT8dQdcpeS7epBUP+Ogl3a0r0BAJxR6XbKhEqTu7FP0kLqmf06ctrUt
 o1Z/yqqdCNtc9EZok58ID8/e16ALi2eWOylgbgROIdN+OY5iHqTo0nPAdDOs4R+fhjwb
 +vPjv3Kufo93QCm+MPvst3jKmaZPPSOEjsTS3SzhmZFugexlUaVqE9oNP9+ZYfF5RfWG
 8qjcsMhyXhojU2cEL8Sp1pRD901oesLnJuoKNZWALQ3pjjHo83LL08hrdPQlIu5obg38
 PmDg==
X-Gm-Message-State: AOJu0Ywf3We7T2c4lYlfEGNcSms9FdiRhKHDRaDQA+8qGuRMHAH1DHM+
 WBvjCsvqGBdsnIO211jgpRqobkC+RMBpDQTeJko=
X-Google-Smtp-Source: AGHT+IHRkTdisYWdmVO5e6Dfc3OuBYhUZ3uCAodezHcKL7eszuOZEpcOBSyYfkZ9tXwzqUgtegsBhA==
X-Received: by 2002:a17:902:eb51:b0:1c7:37e2:13fb with SMTP id
 i17-20020a170902eb5100b001c737e213fbmr14596986pli.55.1698216732898; 
 Tue, 24 Oct 2023 23:52:12 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm8706906plb.72.2023.10.24.23.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 23:52:12 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: jaswinder.singh@linaro.org, ryosuke.saito@linaro.org,
 sugimoto.yoshio@socionext.com, ilias.apalodimas@linaro.org,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 0/3] Developerbox: Cleanup and document update
Date: Wed, 25 Oct 2023 15:51:00 +0900
Message-Id: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This series removes the obsolete UEFI capsule update definition
and updates the build instruction.
Another patch[1] is required to complete the cleanup.

From U-Boot v2023.10 release, A/B update and new NOR Flash layout
is enabled by default. We would like to pin the U-Boot version
to v2023.07 when the user want to use U-Boot as a replacement
of factory default EDK2.

[1] https://lore.kernel.org/u-boot/20231019135419.162726-1-ilias.apalodimas@linaro.org/

Masahisa Kojima (3):
  board: developerbox: remove obsolete NOR flash layout definition
  board: developerbox: update old NOR flash layout build instruction
  board: developerbox: update flash rawwrite binary size

 doc/board/socionext/developerbox.rst |  7 ++++---
 include/configs/synquacer.h          | 19 -------------------
 2 files changed, 4 insertions(+), 22 deletions(-)

-- 
2.34.1

