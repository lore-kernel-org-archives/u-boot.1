Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A847C54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 10:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA62787ED8;
	Wed, 13 Mar 2024 11:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cw7FbmrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4960E8644E; Wed, 13 Mar 2024 10:27:33 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC77587DF9
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 10:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ppighouse@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ddcfe064faso2523955ad.3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710322048; x=1710926848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R6I+qAvjriIhZpqTRPosft+26w34QnmoHMX0+mS+KQ4=;
 b=cw7FbmrY6JBb50BQBvVxyOmeFF7JdKuj4kRv2ugzLYn+kvJ6jjioVgBTohd1WwCQua
 2mhnPal5pPZ7c+9MJUdm6Q9OYsDA6bq+YHxeRfd6+Kqup5JOdeCLMNUDxJJvmZWIB7U/
 +VhRAlRadoIBHX4pET8vbeCJHHNWewY7zZkfohRFvuFLREt49uoux5J65e8e7xOD/AEn
 WbCdKlZUq6yXExhBDbDBRzlrIu5s+tr2oq/OiyKOvOnRHmAA6vnx/UgrwEfezEYzz/Fw
 8df2PffRlvKn6ytgsJ9LQ5dVClCghwr1tvcw31LGoKRynZOnJopjcjU74pnERWJzrZiC
 ubxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710322048; x=1710926848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R6I+qAvjriIhZpqTRPosft+26w34QnmoHMX0+mS+KQ4=;
 b=nfvjABJa5MPD2oKa6k2IkkSIPYet8n5r/833UDIVax174Q8FKvkw0XlJZqyMDLVKe7
 XKjnjMIJhtZ2PdPCodr6pMHD5TsKezyNylGTLsvpw7kHzxv+iOjKDxLyCj2OPxbTDECU
 /21T96kKG8qQBGyiT8rfP95cvTNBuPGsCGpDMazz33kKNLTRRYT1cdh7A6+PqDpwu3LT
 EU/cuYmQaCpsZggQa5oDGSGvQk7KEzdetMKSEtW9FPXcXIhzU9OCWUhXNLchTpyjhw2S
 IgYypWsXHi6lX3O6/xRzW/1J3PPSzKwWgd4rKMhfTHapieu/60wpE8E6q/07Z7Y78F/q
 WZBQ==
X-Gm-Message-State: AOJu0YzUsLcauhhq5t4EagMCGCa4J5bdP/jOArpPhqTF9JkeOBzJk64t
 Axe5x1AAyonTJbs1H5nXPzhTcZXc84R4H96CyOtZ3zAJYjnxDUmZuDdRWlq/9fM=
X-Google-Smtp-Source: AGHT+IE932tcagm1tnHHC6YnAOWTFoNUhjkmzwsc/lTvEK7ohdvBlFZTQ7hxvw+ml3S89JPW5zHnKw==
X-Received: by 2002:a17:902:b102:b0:1db:f910:98a9 with SMTP id
 q2-20020a170902b10200b001dbf91098a9mr2354973plr.56.1710322048316; 
 Wed, 13 Mar 2024 02:27:28 -0700 (PDT)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net.
 [125.229.150.10]) by smtp.gmail.com with ESMTPSA id
 12-20020a170902c10c00b001dc3916853csm8177461pli.73.2024.03.13.02.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 02:27:27 -0700 (PDT)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, kever.yang@rock-chips.com, michal.simek@amd.com,
 marex@denx.de, neil.armstrong@linaro.org, jonas@kwiboo.se,
 cnsztl@gmail.com, clamor95@gmail.com, hai.pham.ud@renesas.com,
 naoki@radxa.com, patrick.delaunay@foss.st.com, christianshewitt@gmail.com,
 kelly_hung@asus.com, Allenyy_Hsu@asus.com, Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH v1 0/1] Add new bmc dts for ASUS X4TF server
Date: Wed, 13 Mar 2024 17:27:20 +0800
Message-Id: <20240313092721.2066531-1-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 Mar 2024 11:56:10 +0100
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

Add bmc dts to ASUS X4TF server, we also submitted dts to linux place.
Please refer to here, https://lore.kernel.org/lkml/?q=x4tf.

Kelly Hung (1):
  arm: dts: ast2600-x4tf: Add new dts for ASUS X4TF

 arch/arm/dts/Makefile         |   4 +-
 arch/arm/dts/ast2600-x4tf.dts | 161 ++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/ast2600-x4tf.dts

-- 
2.25.1

