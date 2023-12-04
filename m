Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87320C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6076F877E9;
	Mon,  4 Dec 2023 01:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DuNkKJzy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 353AF878D8; Mon,  4 Dec 2023 01:32:47 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BC3787717
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b843b61d8aso1772025b6e.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649963; x=1702254763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eugPm2xcYje6RHUXuMVct3Y36f2bKWTYcR3bsWu5rpg=;
 b=DuNkKJzymbbIV9hsJBhPJCQ2YXLHQMLoy2T7v8shEh9dYgSQzFepdfUUOuox5pD8Qb
 lRZ7ssaIjW/HcduvMb6QdwnEWyGKrbJu6Gjic3p7QarbFL1pLfapqYpRUNxQgDLx8XQR
 FRquJ3HEv0hBn7Vlgx/9Z7DPFvZByP+pSoBfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649963; x=1702254763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eugPm2xcYje6RHUXuMVct3Y36f2bKWTYcR3bsWu5rpg=;
 b=MwZ76BU5e6BPBXyyB19eO4eAG6WyQyFAiQ2F15ReVrUKWsXPpajcf4gyLGPsUv0Qno
 RD35GZOwjyzlqemtixmJ5JiR5I9AGACQmCepT311nU0KqgtYlP50mHpRO2BGpYw79e4S
 mFi4cOmMaBd1PYzhdP2nQqFFBlEL6dFcNQ88WdKZyP1ka3wMMWiLb1e1FEMwfq5v3qd/
 JjiPe5sj87oMTY2ggYeaFDJSpDgxCLUDMkVI0IQvUpGdcqTaLZYqxrGJr4UrzvhxLXRo
 h4IHnPtn5aBUnRqGQWvdjVhAJZKMUiiJoQ6eedHmr8gp5Y43/yBnNq4ehNI2/E1gqO6Z
 FAPA==
X-Gm-Message-State: AOJu0YxDv2RfM3GRIuNT1P7K4E6LaC9eOtqKNEASdXol9j8tTsevvPNO
 SZc+tAVYH6syr/8TRR2Dz1HDuxTRp3hy2udb/PMdEQ==
X-Google-Smtp-Source: AGHT+IGgWCUNX0BB8WCzxa9yRPPY4nnZ6DfN2vWN7voJCmwEaIrjpbWVvNvTXEKZQUbur0duHZvbuA==
X-Received: by 2002:a05:6808:3006:b0:3b8:b063:5d78 with SMTP id
 ay6-20020a056808300600b003b8b0635d78mr4059385oib.95.1701649963672; 
 Sun, 03 Dec 2023 16:32:43 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:32:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 05/14] boot: Update SYS_BOOTM_LEN to depend on BOOTM
Date: Sun,  3 Dec 2023 17:31:29 -0700
Message-ID: <20231204003144.899097-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204003144.899097-1-sjg@chromium.org>
References: <20231204003144.899097-1-sjg@chromium.org>
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

Use the new CONFIG_BOOTM symbol to determine whether SYS_BOOT_LEN is
visible or not, since we want to support decompression when CMDLINE is
disabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 9fa8789bc2b1..d83047acbd0d 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -800,7 +800,7 @@ endif # MEASURED_BOOT
 
 config SYS_BOOTM_LEN
 	hex "Maximum size of a decompresed OS image"
-	depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ || \
+	depends on BOOTM || CMD_BOOTI || CMD_BOOTZ || \
 		LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT
 	default 0x4000000 if PPC || ARM64
 	default 0x1000000 if X86 || ARCH_MX6 || ARCH_MX7
-- 
2.43.0.rc2.451.g8631bc7472-goog

