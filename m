Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1167C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 17:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0C181335;
	Tue, 11 Mar 2025 18:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AvqpWQQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A4881951; Tue, 11 Mar 2025 18:55:54 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA8A811C1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 18:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30761be8fa8so64696441fa.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741715751; x=1742320551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wkJJ46kral3nnyOubWGbbznlJ4/O+pGucMTFh48fJ8c=;
 b=AvqpWQQ2CsQCDQbZlXfgYs7T0djF3GM70BicdPGTtn0yYfZM28gQLSCnPhkOEdsXRY
 DohTF5XZhmuNU2+sSgSQn4HDEc9xbJEUVwlCRijePSO+h5QUX2sziRM0VdzQr2R9AJYm
 bGD/fRQHfziS7wR5VAqFeqPvHvz3pZ4AIUOReQHsIYCFpM9q5ZipqjQdxbXTpXRwUKDm
 Slu8O/hRWpg4EeY5uV0UL6K/cH5G8REUyCMqr10Gw+ZWcEnv2VwWCB5DNZwuu7AUfRgf
 RntMp1hyJk+IvZZITL2SweXAPj/IKVKvFpgUOsMkdapSOnfJD5Fa59i9h4kzlXHpbkg9
 AgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741715751; x=1742320551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wkJJ46kral3nnyOubWGbbznlJ4/O+pGucMTFh48fJ8c=;
 b=qjPQ+aMuZwSwXaLDYoGnlGLkdCVgEeddzkjMwCkDVQSEhRmLs5MdjlXejCboOqp3BA
 ZtogNfZyGltSPF6suiGmzVWvM/Hnp0RY1nj89AJzf+U5tnRELyZ5slmmDJpLDJ58KpoS
 azB6q9cfrSq/cMmLq3kwsXyWTVxPw+njSbs/aQd5iNwHmx3wr/MU2c2mnYGZyyeg3spL
 H84Hla9B9xRngm+Aci3D2kIf0ejw2ARW+9bjQcQHVM0blG7rY2rODHe28MHGEWpcQ7mR
 KDurFWh3acSSg9cFcADVbgykCsiQS3WnqJSEltzrXYL3jATOWSXDO/lllGpiNfgiUoU6
 5vSQ==
X-Gm-Message-State: AOJu0YwG6gBXZLTvyixyCZV8QKY7GfydF1YCeP+HM3yZm2CiHtVfCnxs
 kVWZc1kFBacZSrTB2WiBePQbO4VGjALzsbv+FYwvfg6KFwZeWjTB
X-Gm-Gg: ASbGncv8YW9UZOAtf3vxb8kmsHklnbcH2mAWQiNYBl0bBh6JeuEyVDJtwTK5SQewrGp
 tCWUQawmGvsa1mWAhN2ZncaAWy0uozoo0buThJLaUyB1ITwYEM+q+RjSHcNbaPsoDzZLUmnM//L
 KlxO7CwRXZuVlgdp6I+9oUg+fMfwIQWhhhBGVMuykz79OYvLLjlfqSshpRDfRbjWXQhsYR+UzHQ
 pUsn5PFpivcYC0TO4QoQj0WT3ZqYXrsq3dr37rmHVgUhQ3CRaQXFbL6E5zz29CfFiej2jqkhZ1O
 bFt0Et8wf5fS9bicz/7hGO5C0a/w4R2nOG6E
X-Google-Smtp-Source: AGHT+IFojPmlJM4eljBK0C4S6ZHgYOkf174GK2UTN5WrPUOgqrnPosIVXnR6oXq3ii57Vk44HyFzvw==
X-Received: by 2002:a05:651c:b0e:b0:30c:1079:7538 with SMTP id
 38308e7fff4ca-30c10797f6dmr41612641fa.21.1741715751324; 
 Tue, 11 Mar 2025 10:55:51 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30bfceebd49sm15542811fa.60.2025.03.11.10.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 10:55:50 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 6/6] configs: qc750: add 3 second delay before power off
Date: Tue, 11 Mar 2025 19:55:22 +0200
Message-ID: <20250311175522.120018-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311175522.120018-1-clamor95@gmail.com>
References: <20250311175522.120018-1-clamor95@gmail.com>
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

Introduce a 3-second delay and an informational message during boot to
enhance user experience.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/qc750_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/qc750_defconfig b/configs/qc750_defconfig
index 2485e64a2f0..e958e0d53ca 100644
--- a/configs/qc750_defconfig
+++ b/configs/qc750_defconfig
@@ -22,7 +22,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan; poweroff"
+CONFIG_BOOTCOMMAND="bootflow scan; echo 'Boot configuration not found... Power off in 3 sec'; sleep 3; poweroff"
 CONFIG_SYS_PBSIZE=2084
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
-- 
2.43.0

