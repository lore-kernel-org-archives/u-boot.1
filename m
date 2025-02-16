Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E23C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E4D80F5F;
	Sun, 16 Feb 2025 21:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k69d8Bej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05C6680F68; Sun, 16 Feb 2025 21:44:58 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2C5380104
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-8557b84dc10so38941639f.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738693; x=1740343493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=k69d8BejDXlTJMWRNLDm2SkWn3yQV6MOK/FoOZjrSSkSNMvI6uyQSj+3UIIY27+up/
 BbzoQlaxyhaN8/kRL52uvAoebce00W0ecj9z27KYpYlTTkkGJj9rn3ZBpdBeeQS+LIWI
 wZn2Ds3//C+TV1KHTNQI65bHI+qOj+Jpt1BIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738693; x=1740343493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=FFLtbBsJpuLPOug8QxTBGvYDXSEMfJPLf0lemhS/fANfPH0OYakNH4aPb70/G0twal
 gsak4sgFOUSfiWo5u8aP/+zzxlqqrqUdELw6mHv3rDjE3q2eiQnUiGjrlOr6SYzxvnVq
 VttnkgQzLw/BVSE9R7wNvlko1j5KmkPG37i/ZYhxD9qHqM9mtotGJErJiSvb1CxO5lxE
 7SPCZHiU8UoBPUdh03QS/c/8NrTCquiXPW8njNWQfIQ3CdfFG8gTTZ5vNQ0tU7AmhpXG
 tTVbTyWLqR0p5ERjVQGpBdk1EbcdVJ2KVXt4Gr5Ddbsq9ZcDpcGbEg/mQ+IZocNrEBwG
 kCWA==
X-Gm-Message-State: AOJu0Ywo6d8NG0N/qRsSY8sqcuZuGWzAEghaaO6O1tW6fjIOfnT1S0jx
 owCTHu8CzR5sfC9TPPw1mG2jxWDdUl6js8uxJ1mc/eLy47YUpyVXEK91xIXxJbryEJPNwTgvqbc
 =
X-Gm-Gg: ASbGncsPc7V2J5afApEGzJsrmFIyyZe/EvTr7b94lIcENc4Wb3Q2oDVCXWGrW2aeTNf
 cLb43DkkV3TcvNLyNCkqvpyv9U4ccb4NaxA+6cBDCm7qJofAzDBw3xSQFLRAJVycV0ZlKxZPW9F
 8xBVDxKNNUPkL7wEjE1RfeUqqVmbrlLvmR+La1ePAoM1R3vPNO/qMuWwhQR4G2bADJF7GrAhV8I
 uEqpWD3XbtOhZ7/UKoTvkmuclTji+RVPxtI+biES4ULg81wVzQc80PlNoELjqGK8q99Lr6TUv4X
 R4rxjYG5mvKv2aGqQb3N53eEqfGP/BovItTpfsBU5VgHinWsOC0g
X-Google-Smtp-Source: AGHT+IG1lIlV7TAI2qw+8rSe0qDw8P2CfBy6qkfganzRJzifaoZrwlkPUC7GKwykq9D/qATeTDz7hg==
X-Received: by 2002:a05:6e02:1446:b0:3d0:21aa:a752 with SMTP id
 e9e14a558f8ab-3d2807b0baemr60764185ab.2.1739738693288; 
 Sun, 16 Feb 2025 12:44:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:44:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 03/28] x86: qemu: Enable dhrystone
Date: Sun, 16 Feb 2025 13:43:48 -0700
Message-ID: <20250216204421.3560012-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

Provide the 'dhry' command, which helps to check that kvm is being used
properly with QEMU.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 1 +
 configs/qemu-x86_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index ff2a192ee7d..84b7dc8e99f 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -89,4 +89,5 @@ CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index ee5b150e062..d52afa42955 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -66,4 +66,5 @@ CONFIG_VIDEO_BOCHS=y
 # CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
-- 
2.43.0

