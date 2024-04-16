Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D07EC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 12:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D2188437;
	Tue, 16 Apr 2024 14:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dMZgaM7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03FC688302; Tue, 16 Apr 2024 09:53:24 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C18881CE
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 09:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5f415fd71f8so3167347a12.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 00:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713254000; x=1713858800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJujbw6Wa65Ty3rF13uHN35ZvD5r880M+W+wVV9yM6E=;
 b=dMZgaM7Xo6NpffEnGRs8XnLHZ4YN4ZMNnaKgaVa8j8ALBBWpkxiZfNDDIfxS3dZeSo
 d/QRSws61JAEv1PMgFikGbq0mIMmKpBWiWFv3FE7BrvsmImJ+exTwnh98ivTHHb8Eox3
 IKmuL2MOyDLdmI0pDVmlxZcGhPDvXEMGU8/aS3kAGqawa9ZTB8GaiioxVRAQIeA8xSOu
 ToKtZ9HShaUz6/TEf8O4zzgvoP39/6zNdjZIjsaX6t2q4oqDEmQzLeGtKT/b+eQAOTIW
 8oKhE1Oo4mIppuCB6VUqLNe02NfOLrMSHlTADtN0fHJONb/r9Dr9jH0Yw1mcInQTyV0I
 98qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713254000; x=1713858800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJujbw6Wa65Ty3rF13uHN35ZvD5r880M+W+wVV9yM6E=;
 b=q7AniwAM7nSsNCOO/1qzAllx2y7/wZlSkKVS6WXNkEujAm1tKKsLwFXvFfkXhlhaEb
 LnLjzm6W80TDhj83i4Qwjr8zm7ARGRFOIkN/bIwCJ7SOB4EP+pwTfDWRXJE4UM2vgvVj
 8YaJmekqqVenP/n0wlZWyp4Dh3SgU8/h16ZdVgIBkhd62mk8b/ygPvj2pAT2qJcjLVTn
 aBWH7il5lul7HTGy5Pe1eWEPtG4GhNLprlEA/cKzktr94u7yEaBt2CgvsyK6DbL7ueRu
 1/cYwdtB19cpgNDpVeu6Gf8aNI7GyhqNwybWR5Vv3KFcgpUiYuRJO44O/KqGLZbMKhv0
 pnjA==
X-Gm-Message-State: AOJu0YzlBsjzZMzcBysqUYP7YtcYwjwJ8FsdfIwOj6Sh7/p04MWqaKZn
 VGOGlBqYb5U9yljhiS9VkRSesrmKEl9iFMrWs36Te6rH9BE2XPgp3Qa4zevuYBCC4Q==
X-Google-Smtp-Source: AGHT+IGRLuV1S3C9dCrNzhCcpxVltkOF0fhL7xuxwsnC4w6RIrF2OvwMznxq9/osTFWJBtd402CVsQ==
X-Received: by 2002:a05:6a21:1690:b0:1a9:d6e2:66e9 with SMTP id
 np16-20020a056a21169000b001a9d6e266e9mr5796760pzb.28.1713253999395; 
 Tue, 16 Apr 2024 00:53:19 -0700 (PDT)
Received: from localhost.localdomain ([120.204.189.229])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a056a0000cc00b006ed2709ada6sm8391681pfj.65.2024.04.16.00.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 00:53:18 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] configs: milkv_duo: Add sysreset configs
Date: Tue, 16 Apr 2024 15:52:40 +0800
Message-ID: <20240416075254.13729-4-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416075254.13729-1-seashell11234455@gmail.com>
References: <20240416075254.13729-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Apr 2024 14:51:12 +0200
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

Add sysreset configs as well as poweroff and reset commands for Sophgo
Milk-V Duo board.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 configs/milkv_duo_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index e8413d7aa9..28bd4b53d3 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -19,6 +19,7 @@ CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="milkv_duo# "
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
@@ -30,3 +31,5 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CV1800B=y
-- 
2.41.0

