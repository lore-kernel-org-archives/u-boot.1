Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0586C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22CCF869C0;
	Tue, 15 Aug 2023 18:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DW0e/GYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB3B869C6; Tue, 15 Aug 2023 18:27:38 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD1E8699A
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6b9cf1997c4so4697957a34.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692116854; x=1692721654;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x8qFXsreGEsVXUfP/erCnKYL2SpM4JAhM18jyPZXa60=;
 b=DW0e/GYo7gp2nb/vgEQloPw3SizAeW+7WRsrqZesBVbstAy+AJUwSj1DiRN83FIa5X
 kJo8V0OSvMLp4O1guTzREDxob/PJnqc42PnvCQaBudVGjkvG/JcxcFytS3FV44WBEtsQ
 yKkZb8MriEKugxgcuNUhy3e1lIRYoEk8b1eckx9yv4wMJ5+QQN0NRVTzaXpoyO9YLTHg
 6/s6zfstaqAoz+lYQzT1liKp+JLkTy8MCD44L3lt0Rhu70SEZL0WrLVMFT2BCG/6LF+a
 AluX1bRx91xegOk+a8u8wenvx92CWQNOgzXOBXmHeHMOuL3QwRaQIEldTGQ0oAK4Uf3w
 7Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692116854; x=1692721654;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x8qFXsreGEsVXUfP/erCnKYL2SpM4JAhM18jyPZXa60=;
 b=ikpJUn1D0UL3xJ+O+aMuP74LLOojwv80v+Cpl2aFWOOcCZrzg+HihqNITn568kSPhB
 eWlrqctm0+OYklwSZBcCBjItdkwRDT+0kjympWaD0ZSh4nw/t1XT12aDgHLJOeNIM+g6
 1LETcdBN4sf+Pr3Op56dNUzbdhb6xgWWZNU78P9NYBPsew9TuwGe2mW5S5u1oX54NuTe
 eLCt9CEKSiJUtPEFezAwIrpDO2RhFbhcN7z7c86Fpc88mJdaZgumyC3eKIrPQYHjVRPo
 HayCiuS+H4SKXARC2/5SSxDy2UiBzCaKV4ymDMMSlou7fMTZmAT8LCUHt64Y24X9zyyk
 mk/w==
X-Gm-Message-State: AOJu0Yy0Z9W+4JW79S/os9Txz8MsHB6HN8MZYK7ab9es325ucIfLYr7l
 9z+UqaC2IdcGDmZ6q6Q8nbwEfjnmfmY=
X-Google-Smtp-Source: AGHT+IEv29d6g0Pe8WcQpNXq5cCkQGcQLjQKaNoeXCk2pwbxphzYw5rgCuk1433MkFwMEVZO7KJD9Q==
X-Received: by 2002:a05:6870:e415:b0:1be:dbd2:2bfe with SMTP id
 n21-20020a056870e41500b001bedbd22bfemr13666363oag.57.1692116854428; 
 Tue, 15 Aug 2023 09:27:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6897])
 by smtp.gmail.com with ESMTPSA id
 zf26-20020a0568716a9a00b001c4f840e7bbsm2474441oab.47.2023.08.15.09.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 09:27:33 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH 0/6] cmd: gpt: GPT manipulation improvements
Date: Tue, 15 Aug 2023 10:26:54 -0600
Message-Id: <20230815162726.1524958-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
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

Adds several improvements and additions to the gpt command processing,
specifically (although not exclusively) for the purpose of supporting
"ping-pong" booting when doing A/B boot partitions with u-boot itself.

In this mechanism, u-boot must boot up, and then check if the correct
boot partition is active, and if not switch the GPT partition table to
the other boot partition and reboot to activate the other u-boot.

In order to facilitate this, the gpt command needs to be better at
preserving entry attributes when manipulating the partition table. It
also learns two new commands, one which can swap the order of partitions
in the table, and another that lets it change which partitions have the
bootable flag.

Joshua Watt (6):
  cmd: gpt: Remove confusing help text
  cmd: gpt: Add command to set bootable flags
  cmd: gpt: Add gpt_partition_bootable variable
  cmd: gpt: Preserve type GUID if enabled
  cmd: gpt: Preserve bootable flag
  cmd: gpt: Add command to swap partition order

 cmd/gpt.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 154 insertions(+), 6 deletions(-)

-- 
2.33.0

