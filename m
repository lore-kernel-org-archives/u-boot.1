Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB596C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 05:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB5CF833D0;
	Thu, 24 Jul 2025 07:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A3MqhUmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D769F8353A; Thu, 24 Jul 2025 02:25:23 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA8E98317B
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=davidzangcs@gmail.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-41b309ce7d5so166707b6e.0
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 17:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753316720; x=1753921520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8F6xR/q+0rDvZYvLr3XGrBy28A6m3uuwnDwhbvIVLFw=;
 b=A3MqhUmiUpliRQJfFPFnGpHR0kkAREWaHcuHCuZo/EFjQ3sS/sea9GweZBclXFKx0i
 pEChH6rZsHOdX9iCRPOJbwlDO3eN/4pDChEDtS/veqK+VunldJD/PnXvo5DyUz9jVIQ4
 gZNfYuRZ8VNOn1rm4/wphYU4ceymr+uIbcTcV6F4KHnhrLPjT1x7C0Cv6C0T2Sx+RPB2
 KNWKmYSiph0A65D8n6llq97GcA5jHLSCUrSGpq5Yuru/G6vn0O7cTOIGjSWisOIjkHtQ
 I76VbnyMUEoLnrtUrFNfe9xmLUJKyPdPlc8ulIg7VQmQBvnNVk/XP72qWEYdYp8bI3Cf
 gigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753316720; x=1753921520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8F6xR/q+0rDvZYvLr3XGrBy28A6m3uuwnDwhbvIVLFw=;
 b=bwX88wMUaRRKE1522t2r25jObzfanmLJPXEaIOwW0oCM6EN4s3DUauaVl4Yw2/q1/t
 JkHK7RAdLNG+otpzY3GTwhZKT8ZXIjdMPQw6WWur8PyfLP97e3maD6e6pRWIALPGVKkB
 X1FutcPQ6oXLiTnWep+yNUo/92o112zZD7wXCJzG+NwueOWeYFriI+bqgEvw19eXM1YU
 jCS6QanXMXKbY0DdtYUKZcT7JepwUOtVs//R2MMLGJMncYUeutZ/7RvlYE+NDk9qbdeW
 Ul48d8bLHgatGLODeDrJ43G/LLAy+nfE1F+w63ewSLpL2yeHPLtJdQaK4lPtiu8m8olQ
 Ufrg==
X-Gm-Message-State: AOJu0YxinqGhqXxh9pYPk3qJSUshBbg7m64pBpw7FCr2kyC/Bm1sHXW0
 R8Y0kUaFVbjfHZIh9oSvJU7xVSOhfB7QbNtAHlvRqT/fKICcx76/E3aOeMNOTg==
X-Gm-Gg: ASbGnctN5Kq4hOAcmzSkbGO48G2o8TgAmba+oPN9tLnMRDWELMcg1woM93RFkafdlR4
 HNCP2bthJ2BdRwOhtV45UQC3jjBe1JFCHQ1VjioTeCiIRkSPgWbGABO/FqC8bKQqzetbkjyM7d8
 IqjcoOKVKxy31Sapg1Kvk+AuzXKj3U/swdHZP9zfoSFgvtu4PFsRQq0/SuJuAA+4EyoQD3z+6O3
 ucOTBq+dxmWnIhvdIcXoyR91HiNtfDkAuA2CX33twKjC7/APtgAi5/hSAjMfGrM3cvxxnQXCQIs
 FMWQH56PfZKkYXidcj9ip36TNcdPmLHPXLlyd0O8P3P8FrwfehNCPR2SEnGnn4pCYyadrgJugxd
 x5fpg6kY4Ww8gTNDlBwxUmMwC3ufz8ZVXblBXmsx5ofrNBrMOCAIraciP5zYE/5LYVZSj+V5xXa
 o=
X-Google-Smtp-Source: AGHT+IE6WtC0z06jfv9XLIRIgjLmElegIxSQBvNig5c3JSLQ4t8sLEcHpuDigcUQksT+2H2fsk15Sw==
X-Received: by 2002:a05:6808:190a:b0:403:3e86:ab4c with SMTP id
 5614622812f47-426cd7cb128mr3882316b6e.39.1753316720233; 
 Wed, 23 Jul 2025 17:25:20 -0700 (PDT)
Received: from dva-Latitude-E6440.lan (syn-024-027-011-011.res.spectrum.com.
 [24.27.11.11]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-42a30b7aa18sm54583b6e.12.2025.07.23.17.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 17:25:19 -0700 (PDT)
From: David Zang <davidzangcs@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com,
	David Zang <davidzangcs@gmail.com>
Subject: [PATCH] configs:imx8ulp: Enable temperature command
Date: Wed, 23 Jul 2025 19:25:17 -0500
Message-Id: <20250724002517.948571-1-davidzangcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Jul 2025 07:49:54 +0200
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

User can display temperature in the console runtime on i.MX8ULP board.

Signed-off-by: David Zang <davidzangcs@gmail.com>
---
 configs/imx8ulp_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index e750b3d9ae0..f52434923c2 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -57,6 +57,7 @@ CONFIG_CMD_READ=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_TEMPERATURE=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-- 
2.34.1

