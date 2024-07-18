Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C1CC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 12:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC629886A0;
	Thu, 18 Jul 2024 14:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jq3uriNP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 282DC88766; Thu, 18 Jul 2024 14:05:28 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC1588387
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 14:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 90EBC451BD
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721304325;
 bh=UGUm1XfcMEPaLdkzR2525BGgjPEwBrO1qLMuwwywNTE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=jq3uriNPTnVXEvXvL4ZPFisHypZBfOVOivREw6wftmxl+2twIpPG2UX3Vc2JFjZX1
 rGVE1tZD/jjpm/SUJ5gJ4DXa+HRScijYt4XqE6Dflu+TvpGSaDft3E4kX8lhidAktX
 X/fj9Ud8Rx+MbMGMwFk/ORpFQl/14Ll1KrWXwexUEIeeCadllFV+o8lIea8p6tkgpp
 6OkvcsukLEahkyOk2Zx61co22FOlfqOgRmiTB6D0B2MyfVDviIqxTR/bv96+N/DbmB
 0NPS+sR7F1hHO6SGjXU7cLXW3XQYvIYt8qhBClziipd93+xWAiNqKVX2z34+HCvsQW
 Y3D/lvSbrohBg==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4264dc624a5so1853025e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 05:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721304325; x=1721909125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UGUm1XfcMEPaLdkzR2525BGgjPEwBrO1qLMuwwywNTE=;
 b=tWPz9w0bfi452qRAhYVVNVGIWeW2b+vLrlcAIX17rlPmTbliGRXhWfNBM23mJpGVAG
 LcFXE0PN/Qq7nWoM3cBIfNy7JoXt05pgqHCKEtpdGVVK9XZyRdjpd0y93pKPxwrMYcfi
 wssv5IfJyRVkfIYdZlG9T60ZWFBLN+uLr6k9n2vg1y/uIypSAQj5GWiMrfh+xurzCmp/
 pN/W90ssIoNtUnp8zD54/yi0FDQhxulFyoCaQ96PwFDR+n4DK5HkulO5wl/UsbFg3HLH
 n3IR9HXqqaD7lp5yxeyCyaCm8bV/YySVWMrKj0YVVFVPDNbYQr5aJaWT29EZSYOUZZI0
 yMyw==
X-Gm-Message-State: AOJu0YyHFMSFONOjEPdMaUa3Zaf+cfIjL6dF2qVT+Wbjs/24dyEIWZ3+
 YvFAlQz8A4telnd8O4CAwHW3MOEvrLza5B6n7mZMS1pp/OeSN9354pcEwCAnU0g6c5WJ6bwtS+f
 O6gHPF7jj8bfsruDM6WN5ZP0ZHsgUpcWy/ZAFaZtIcyTUSQcrHi7GMQmA0pNo3d4eM/A=
X-Received: by 2002:a05:600c:198c:b0:426:4978:65f0 with SMTP id
 5b1f17b1804b1-427c50f1f50mr29680355e9.18.1721304325095; 
 Thu, 18 Jul 2024 05:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnacfi/o3EW74dYWpMUbZn3MtR+0cob+y9f10er0Y+a8oKAteGaTDtyuAirQsEcEdMWQtxPQ==
X-Received: by 2002:a05:600c:198c:b0:426:4978:65f0 with SMTP id
 5b1f17b1804b1-427c50f1f50mr29680175e9.18.1721304324583; 
 Thu, 18 Jul 2024 05:05:24 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm10622085e9.35.2024.07.18.05.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 05:05:23 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: require EFI boot manager for EBBR compliance
Date: Thu, 18 Jul 2024 14:05:09 +0200
Message-ID: <20240718120509.105758-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

A system has to support booting via the boot manager to be EBBR compliant.
See the reference to variables Boot#### in the specification.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 2fb24d7af9a..3b703fea007 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -486,6 +486,7 @@ config EFI_ECPT
 
 config EFI_EBBR_2_1_CONFORMANCE
 	bool "Add the EBBRv2.1 conformance entry to the ECPT table"
+	depends on BOOTMETH_EFI_BOOTMGR
 	depends on EFI_ECPT
 	depends on EFI_LOADER_HII
 	depends on EFI_RISCV_BOOT_PROTOCOL || !RISCV
-- 
2.45.2

