Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F877D3A694
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB4D89198;
	Tue, 29 Oct 2024 20:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NlchxzIy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D721885B3; Tue, 29 Oct 2024 19:58:27 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 808A7889EF
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 19:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso851154366b.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730228304; x=1730833104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sVTxecbf3teyNIRt5mvNPyOqnGLhD4yB6OdtWNuKc0w=;
 b=NlchxzIyqk0KSIMsre73TS9GVhRYrSMskStOMve52zAAiH3piQQ8OKQ8zfJOhuXq8m
 WCQfFMLTyIZOAms1UPM2hnVJOyYbcZ5bkJ13aDVbtttWF5RyNJfND0KJksdAQNDjwUeA
 tQ7oSsuosXl5OkdIK94kV0x1W2+aa+jhNiR4V9UF8a4/04Nbc1HoUamVcGnrd4Kgj59N
 HMrCUYioi7XPyCrz4/XBXswmneMdqF3pjCBQkZMRW0VFu1H3EI2N6NO8HUnd9uEP6r3A
 1ZcwxhvNrXru/qgFSL9f+K8aYC4/ZAsAgqkI2/O/mukmKddjjHHrs3Cj2zOM2XA2Ic9u
 jUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730228304; x=1730833104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sVTxecbf3teyNIRt5mvNPyOqnGLhD4yB6OdtWNuKc0w=;
 b=NI2ySqjqLw+fPWcAKpB7jO4g9/Cib/A78FkGhJBtnGKCXpP4sTS5XnjfF88t5ML6fK
 pVdX7tmRngMEUl+CexCTYd1MkJ4NfaI86PwNj/dmKA4Mqj74QLMh1SzC5iK1o1JKsfNl
 I4ZU+S97gMDAJW8Ut/KHmRA8egaPRbjiObV1CIMXX7y+svmCK0nbHAbn3+ON5GZt67Ay
 VVqBGsi1umGJ0IyBFMfjqljwneIhch9//IwyFGxkrsxNAOXYAuXG3rWFXjb90grV10Hu
 fltt6z8bf/BaW5lCrrTj4Vwn2bdUhvRlyjNDlPKZsUI1cYoe08ckDBHsyMR0YElMNGKO
 CiSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1vu4po2QyhTma4u6SvVfmIylxkIlM19PG8+uYJ1JkCQ2g24qZsNNDZLFU/BB2j5dJ4LTSG8c=@lists.denx.de
X-Gm-Message-State: AOJu0YwiU5zhHNZMfbzh59oGqYDqGial9RDN744r10oB8WabbiPpypzE
 n+zfcwFHwWjAjaZdcNvvyqsHM6acsuuCwh2ENXTPyVxTfHzZemvWqXjaFw==
X-Google-Smtp-Source: AGHT+IGhhyNirRGUTG/PU3oQ86yFRRGik357Or1h7ZkVhhVUQIOlWQQcA/84mt7exWOYsElT61hVXg==
X-Received: by 2002:a17:907:971f:b0:a9a:1585:dd3b with SMTP id
 a640c23a62f3a-a9de5ee1a7fmr1157703666b.21.1730228303758; 
 Tue, 29 Oct 2024 11:58:23 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:89e7:cc9d:3a72:92f3])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a9b1f2994e9sm494511866b.115.2024.10.29.11.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 11:58:23 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com, michal.simek@amd.com, hs@denx.de, pro@denx.de,
 sjg@chromium.org
Cc: vasileios.amoiridis@cern.ch,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/1] bootcount: zynqmp: Add bootcount API
Date: Tue, 29 Oct 2024 19:58:13 +0100
Message-ID: <20241029185814.7937-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Oct 2024 20:12:43 +0100
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

From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>

Add support for the bootcount API by utilizing the internal Persistent
Global General Registers of the PMU. These registers get reset whenever
there is a Power-On-Reset so it makes them suitable for the API.

Questions towards reviewers:

	1) Is the licensing of the file ok?
	2) How am I supposed to add a maintainer for this file?
	3) Is this the correct place for this macro? (Maybe this one
	   goes more towards Michal.)

Cheers,
Vasilis

Vasileios Amoiridis (1):
  drivers: bootcount: Add ZynqMP specific bootcount support

 drivers/bootcount/Kconfig            |  4 ++++
 drivers/bootcount/Makefile           |  1 +
 drivers/bootcount/bootcount_zynqmp.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 drivers/bootcount/bootcount_zynqmp.c


base-commit: 3df6145db0ed3430a2af089db5a82372bea3f4d5
-- 
2.34.1

