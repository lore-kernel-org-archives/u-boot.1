Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2E2C00A8F
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 15:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C2D86F97;
	Mon, 23 Oct 2023 17:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N+yEtMHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B84F86F91; Mon, 23 Oct 2023 17:28:58 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD9A88791D
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 17:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7c08b7744so34045307b3.3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698074934; x=1698679734; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gJEhYRiroTpba3BJsBPrG7v5CypUrcS+fFEzeJ+zwX4=;
 b=N+yEtMHH3kC1+RzcfB8+UNOy9pXENRq+MrGsZ8BHdj7s/Y4XZOkeRD2fvr5RPp50Fj
 dUC6F1ea0iEyu664y8z7osYZwT+1UtOK+r9DQWq+Qjm3qv4f5hB2VFPwHT+h4m68/d3u
 IRgsoMUwKQpnumMftFxoSe+nCZdrEUi91Vhjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698074934; x=1698679734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gJEhYRiroTpba3BJsBPrG7v5CypUrcS+fFEzeJ+zwX4=;
 b=SM0Hvy4vg/YrMQPomJNtDXD2OcFIKI34SwzZT3rJBbMT8XthLKwgV3IXZiulbTQgAu
 Mrf8ZYziLlG3ECrJCZcSXyNhaDWA+MM0Gf017aLKwMIIS9zdKvEuW/Q8EM5bAlizyni/
 jPhW16PxgFW3DczdPGcPPvd48gZDnzuiKd+J+ab3ogJVuHMLBoLnBtJTCL0Tz2dxLowm
 1Z6UvQPzy3XFnfzdFgqS09qTnBrAYdCL6QwD2UmTR5tK9HfubhFQjdXyjxPwNifH5roJ
 RWsRWOMNuGXnWtQvq/3F7vPU7J4tij2Z1ScZdrh1g3bewvsKHbxxUholKCQObk9ncnjY
 SCwg==
X-Gm-Message-State: AOJu0YxIyzHUcniT8DIfL27SRZTtqG1zfW1W7jWMTJeb8Ktzxt0o5E5B
 x4Og4viJQokbC/+VE+W0dBE92ZIgmm0UE+2GTCT/qQ==
X-Google-Smtp-Source: AGHT+IE4f1LzYClX5Qta9mTHExrsmOg4jvyES3EvMe+5xdDRvRMUPpRVpvgna/aw7Oat0cVxrg6YsA==
X-Received: by 2002:a81:7356:0:b0:585:ef4e:6d93 with SMTP id
 o83-20020a817356000000b00585ef4e6d93mr9416178ywc.47.1698074934368; 
 Mon, 23 Oct 2023 08:28:54 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 l67-20020a0dfb46000000b00598d67585d7sm3199665ywf.117.2023.10.23.08.28.53
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 08:28:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] ae350: Update defconfig list
Date: Mon, 23 Oct 2023 11:28:53 -0400
Message-Id: <20231023152853.1599056-1-trini@konsulko.com>
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

Update the list of defconfigs, this was missed with the last pull
request of the u-boot-riscv tree.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/AndesTech/ae350/MAINTAINERS | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/board/AndesTech/ae350/MAINTAINERS b/board/AndesTech/ae350/MAINTAINERS
index ead8e0e2afb6..a6bc90baf883 100644
--- a/board/AndesTech/ae350/MAINTAINERS
+++ b/board/AndesTech/ae350/MAINTAINERS
@@ -4,10 +4,14 @@ S:	Maintained
 F:	board/AndesTech/ae350/
 F:	include/configs/ae350.h
 F:	configs/ae350_rv32_defconfig
-F:	configs/ae350_rv64_defconfig
-F:	configs/ae350_rv32_xip_defconfig
-F:	configs/ae350_rv64_xip_defconfig
+F:	configs/ae350_rv32_falcon_defconfig
+F:	configs/ae350_rv32_falcon_xip_defconfig
 F:	configs/ae350_rv32_spl_defconfig
-F:	configs/ae350_rv64_spl_defconfig
 F:	configs/ae350_rv32_spl_xip_defconfig
+F:	configs/ae350_rv32_xip_defconfig
+F:	configs/ae350_rv64_defconfig
+F:	configs/ae350_rv64_falcon_defconfig
+F:	configs/ae350_rv64_falcon_xip_defconfig
+F:	configs/ae350_rv64_spl_defconfig
 F:	configs/ae350_rv64_spl_xip_defconfig
+F:	configs/ae350_rv64_xip_defconfig
-- 
2.34.1

