Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79650C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C462E88A27;
	Tue,  6 Aug 2024 06:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y+ANpOUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0137588A27; Tue,  6 Aug 2024 06:39:40 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D67528898E
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 06:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7104f939aa7so171181b3a.1
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 21:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722919175; x=1723523975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ap6TK4A44M8K8TqgEbPaiY6M6+j88P5fr+yCZ0hsozg=;
 b=Y+ANpOUvPTzgmvPwkllJ/ozeiB2B88XmJtxRvshnYNtbpcPS7VWXRCh169NopvTo4z
 lnPzcUiyo4LeazjBFpnjBJyDKFRDV9qHZLWvZ3h/xZ/mOWKmKAcJmWk8Hrsts7DtBXd8
 qIoi/H4EOPy+p+H3ymzpRegOHLQsB7zvIIiaUXKDcrxdLS0RKoCBm9nsY7DJ6QVdEHs1
 8nOqhDoni6JkXUuQYkuomCo1OV5vDZ1pXuLGtzzfmWgH0DV+uYGC6efYrcg0AFMqnM0v
 pIvjPAJpx8Ev4oLI+F6FHzoH9EVyxy5JE2EjfpsVpuDChWKD/kryKd1xvSq1bZ94g7Ld
 WMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722919175; x=1723523975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ap6TK4A44M8K8TqgEbPaiY6M6+j88P5fr+yCZ0hsozg=;
 b=fXhmByjZfc26MfxN92/Q6peUAYbACaybw524Srg7dfQmiaeKUncKCTTAVwVyH2BPE5
 U0YtZFuKy/BIu5h5aBYR1nZuwDxnGaZ/rWmxdlux2jm+5MWU+b8mYACa6u4ClqxtQJCT
 FvRba5nDkEDNUqFROdB8gz7uLPGMa7pcerF5oAdbek4E1ZyMhvoYGjFClHA+jxm5xgpm
 Pa7qAAN8Yozste2TfG/JUPnAxxRh5kZ9ekGs2SemXUglJwH4Dm69WRns6F/KjhG9aIbk
 lwmAFXJUpprlEnDKI5gJTaEI/ZUYjX3oTz+cQyx+1C09SMmPK0R3Kj+E2Sh78vcKNpCp
 k23A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYDhBrWRG3oHpfCnhSJLhH0stIs6PGs1DmKO2pHTHtMQYEXNCjco/rudKgFd2OMtImo8cBPkCp6DgsundUiFyvterAfA==
X-Gm-Message-State: AOJu0Yz18rLAJVABEY2eth+E4VbL3w/P7t1o9ub+UDBPDbPSNIBsozDY
 ah0xbiBK+DbMQ2Gev99e/RUKs59cbZjBL7lVM6KszcuaifMGLmjI
X-Google-Smtp-Source: AGHT+IEeXBvDlLFAsLbrlLYksbKxTCWxP0AH4iyqEtSV/YZqiJdDTxE9CIqfXFMtzLMgOdqzAdL+rQ==
X-Received: by 2002:a05:6a21:99a0:b0:1c0:e1ed:1e9 with SMTP id
 adf61e73a8af0-1c699554b50mr19959370637.6.1722919174863; 
 Mon, 05 Aug 2024 21:39:34 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20077164e0esm5823485ad.185.2024.08.05.21.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 21:39:34 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 11/12] arch: rockchip: rk3288: Update syscon driver binding
 method
Date: Tue,  6 Aug 2024 04:38:48 +0000
Message-ID: <20240806043849.3607-12-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240806043849.3607-1-linux.amoon@gmail.com>
References: <20240806043849.3607-1-linux.amoon@gmail.com>
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

Updated the binding method to use `dm_scan_fdt_dev` when
`OF_REAL` is enabled.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/mach-rockchip/rk3288/syscon_rk3288.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
index 6413d0a88a1..4030e919134 100644
--- a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
@@ -23,6 +23,9 @@ static const struct udevice_id rk3288_syscon_ids[] = {
 U_BOOT_DRIVER(syscon_rk3288) = {
 	.name = "rk3288_syscon",
 	.id = UCLASS_SYSCON,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
 	.of_match = rk3288_syscon_ids,
 };
 
-- 
2.46.0

