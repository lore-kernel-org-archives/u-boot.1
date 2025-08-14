Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F5FCA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 17:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24CFA839E8;
	Thu, 14 Aug 2025 19:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XRfh+ACM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2980A83A07; Thu, 14 Aug 2025 19:00:57 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ACCF839C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 19:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-323266cb393so1307568a91.0
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755190853; x=1755795653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnhHNYpQpBFAA+Uahc6s3QHiZPxo527/OhR52H47oRU=;
 b=XRfh+ACMPSqostbS+BemcjOQ3TlrC/Y2C40TySMRPrJ2a9uPhj2ChC0ZVHbOffdg+3
 ZBl6VKesO91N/+zdZGrzs9HhFL1iF5kuivJsC06chHcN3hM3KUrs9IYjpqai5u6kd4RC
 YMw4Sgr97UA/83nH2Y0GMq0qSZ+ZomRGKFKEmqmJYIon+WuDy9jJhvd11po9uwu+IeEQ
 WErfZkepebI97ar5vc0wkdT5OdNmdbFIAdIo7Oro9tplNMEyOqaQYJU1N/yF9UMyxh86
 JZQrxA45PyYK5aA8DdAHAzoVO1paSAwwGBVAlgDl49e4o7w5P+FF5JBjf0SS1kgrrldl
 8fkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755190853; x=1755795653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnhHNYpQpBFAA+Uahc6s3QHiZPxo527/OhR52H47oRU=;
 b=SN54umwHKLPdnS1USaYd/Ah9OsO4GJOPiZt+BQv2U+8BMNiDUP+ZFLCtS3fNv+Fp6T
 QLLHDX+DFStr71Z8EsNJRP+Nm2/mYa4jGUWZDsLud2j4x4zwjjLUTt7Hwbo+azJjjKIw
 57jS0RljGpwzumsoTSltY/4wKvKgvMn2vrx5GuDrGTwipdMKbczR07qDAe7uL4tsxw7N
 6rwnsfR4noMrEy2cLKbpAIi1dsF7uZxbk6cZa4eMdx3ftH0JsvkHMbbY8lAZPk5iIGig
 xZvuxCpCvucEwioVX0yzCRYxf0V8oLkO0omEla/13uzxi0jfVLYsWwGzrHCEWCnX1uuH
 Nr4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVer4pqq7VP0Dggdk5H+dXzz6V1NIF3dLFB25fUu5ztOjhz0NbvQRXjo5cb1kgVI/Sa8m1qrb4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw77yR4FdklipWpxnL9/zHEaY9wYMCLhcdqzig6NMaW49XOCeO3
 8vltLXj04+Vw4zA1Uwg9UPipMZkAAd3IjBHuL6w9815wQb6jgyDMKkD2
X-Gm-Gg: ASbGncvITRFgs4Rcz46afaLdt5k5VCO+zWLdhkzEJe//mwmlEDGprC6wgG4gAAVr9MA
 VlaTI3VqohPuUW5QOK3R2ONr6k3O7WLFooAHoMdkseeZial2Z5M1pyVRXrVALuwOXAhQeOCtY+r
 UHE31wMdFovWeGgG447qLQ+DDP+/uccFxaIlPBB9VH4jjiuDXwbMf7l/1TvR/DBJFC+ksa8O77/
 bdK6dK/oJ7tE0aDomaDdmk4U+I/Ri1xU3gp+lOgwS7jPaBzmedTpMOSaIdf8e+wz2ViCtVBj5BY
 RLMqkIMmeBjzTeq2pM6NSdACpZQZKw2bvyiVoQuNtGDS4U1tyHA7pfrN7txP853MBniOuEZ8VQB
 q398RVVkesekbJEx3z01/mGcvQeXJeSxIBB25hb3UKOTmig==
X-Google-Smtp-Source: AGHT+IFwdy7p4qi1ukS6CRgwPfNXDEnDly/Lr0dL7dP1LyACVC4VvygXkKjpDfR0HzmdsK9blEGTPg==
X-Received: by 2002:a17:90b:518c:b0:321:d5e7:901 with SMTP id
 98e67ed59e1d1-32327a51f3cmr6421420a91.21.1755190853299; 
 Thu, 14 Aug 2025 10:00:53 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f50d:900e:961:a245])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32330fc986asm2374382a91.14.2025.08.14.10.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 10:00:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: tuomas.tynkkynen@iki.fi, jan.kiszka@siemens.com, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] qemu_arm: Select CONFIG_SYS_EARLY_PCI_INIT
Date: Thu, 14 Aug 2025 13:59:32 -0300
Message-Id: <20250814165932.1584854-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814165932.1584854-1-festevam@gmail.com>
References: <20250814165932.1584854-1-festevam@gmail.com>
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

Select CONFIG_SYS_EARLY_PCI_INIT so that eMMC emulation can
work.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 configs/qemu_arm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
index d5890bf87fb3..db60f7de6da9 100644
--- a/configs/qemu_arm_defconfig
+++ b/configs/qemu_arm_defconfig
@@ -28,6 +28,7 @@ CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 # CONFIG_BOARD_INIT is not set
+CONFIG_SYS_EARLY_PCI_INIT=y
 CONFIG_PCI_INIT_R=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
-- 
2.34.1

