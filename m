Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35047C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 12:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 776B082B16;
	Tue, 15 Apr 2025 14:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LDlzTLe4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D7582B16; Tue, 15 Apr 2025 14:54:06 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 879A182AE2
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso3677791f8f.2
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 05:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744721643; x=1745326443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BoIA8ewlTWJjL42ayb0Fzatz+fZkd1DP/gDwQLNDBiU=;
 b=LDlzTLe4eb2nce8eTN5o8ONX/JL0eRu3+HQxbNM7uJZMFlnrvztadQklPghdX85Srk
 iLlaHb54AlsFZTp+PlWbVPt79AyQoPDCyE10hCROL7fcL2jOiWdmOJgGUIMWELZQ4pv/
 RZsbJ0vjMMMAJnYG5LEZTBN+cckSfqCWkPI2PQqrKTfzBpCY9p3SceuM6xa+7CNViJyA
 /ShpZwPxwS751735Bw8sDYguKjO4R/++kKHXohcQil0nn7LDCInjWe6volq9inE4bcBj
 0TRysfEl/xbricSIy+twRV3kkvfaEjUphZZCEpaMg0jpHWoekCrMTwCHU2XVWV8LI493
 +9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744721643; x=1745326443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BoIA8ewlTWJjL42ayb0Fzatz+fZkd1DP/gDwQLNDBiU=;
 b=Q8x69OXq03AyiawnMNMoQ62jiCBoaSyPYrX/yQFqrEBteuf9pdrGlo6p28O4HmA8S2
 3g7hmqT2BwBRj1XeyRnaRG2Nwifh9UVtEsw2nukpbiCp/Db0t4XBtwEAT+6T1Ne85kU3
 OKqWpXvprnYQY7+WMicVMGY+z4wSfcOFh4REeVXm1jy2n4hCM8m7nyTmHTsN4dPLPcrf
 FlVJYe5cx4jEnxM7q3wBPbzKOnH5Vw8TDR9wbdCfTzSFsHJHc2Yy4sBS6V5ffsTiEbEr
 Uebc1TPKnsubkKSfmBa6GL8BnsL1ygaiKP2XDpeI0yw60GJHUIyT6+TxS7MbaSzASbri
 aFVA==
X-Gm-Message-State: AOJu0YxTkUz2OMGElR6QXJodgcQBDGlzCcgllSGIYDQYvidyHlyiyqs4
 vfTrvGdEx4QZw0sM2tl3YTqsUE4+IxtngVQaLAf8YgYy42aQRsgmFBtRQtiAYNf6O/bMbVhM9Zk
 noE4=
X-Gm-Gg: ASbGncvkUT8hDlmktGu4SWdcLp6iD81nXs2792tXGI3KMRZngKr/ciHCIa4C3Ey8jdk
 4UKEVeh7ShI+js6COdt3uWvlXGQ9f0U+yaKNsiYhZF/E5a2lJKZ6QN4E7VahODTOjn/a8baIJm1
 Sdwpb8iZCGyz3ykHOlOln8TxifaFTeLEUvh59ZlL/lauhVrYHU0kuR6W0xspc3KMeiv6q4789WL
 aTNEdE+sq2kCYbeKu11fB8lA6nUHjGz9vmNg3km9QtYHmghP+XO55R970FiGnUpjrUBlJZzzm0O
 a19iW3txPN4Z3UhJRdDmH4kRxMTl1wa0uXnG0BwwHjFfSC2G
X-Google-Smtp-Source: AGHT+IHN/jpF4tmGOhUFQihWE+2V5NvSAGbSpnYYD9nw4GKVOjwLb2dEQ6P2I759Kl/uDzY/91kqlg==
X-Received: by 2002:a05:6000:40c9:b0:391:4bfd:6d5 with SMTP id
 ffacd0b85a97d-39eaaecaedemr13293831f8f.52.1744721642887; 
 Tue, 15 Apr 2025 05:54:02 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c8224sm205921315e9.22.2025.04.15.05.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 05:54:02 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v1 2/2] qemu-arm64: enable UNIT_TEST
Date: Tue, 15 Apr 2025 14:53:32 +0200
Message-ID: <20250415125345.427420-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415125345.427420-1-jerome.forissier@linaro.org>
References: <20250415125345.427420-1-jerome.forissier@linaro.org>
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

Enable CONFIG_UNIT_TEST in configs/qemu_arm64_defconfig so that the unit
tests are run in CI.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 configs/qemu_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 6c9d2505a69..cd9a4f2ae26 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -75,3 +75,4 @@ CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_TPM_PCR_ALLOCATE=y
 CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y
+CONFIG_UNIT_TEST=y
-- 
2.43.0

