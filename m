Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9677FC8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 03:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE5B82ADA;
	Tue,  1 Jul 2025 05:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CyHKhqzV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9680782F35; Tue,  1 Jul 2025 05:49:47 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AE6F82F03
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 05:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a528243636so3172802f8f.3
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751341783; x=1751946583; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bo/MJyul9h5zVmJiQjMIZB+O8dHyV1TlT6TuB+w7dnE=;
 b=CyHKhqzV+N9oHGU000wAp/o2qaFeghZpRYY0bXyzMCElwqe3lJ75XTV4qzZ6esE/RH
 IMo33XFEl0hNZ36PUyM/nYTQ0ZLbvCHqGcrPUreB6WoDAbt2nGXhv4DuNuPaJ7kUbF98
 2x1GmKs514fv4aqpOG4ygm+HfVtdq9z9ghgieMEg+t8gDT9SN1JLBWowmZFPSWvmtjz7
 mvJpDvPvK7NdtUJ3Kz5leEOsDkh5yvKu7/77NeHRU1umftqWoCoL500g+G5IPpJSI4V1
 tmHd1uzgj1xd/mi+Al0QViAs4LYc7ftd8XKXyQeLKVnNE87ru0Rg6aMAHT7TRzrizO/w
 7WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751341783; x=1751946583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bo/MJyul9h5zVmJiQjMIZB+O8dHyV1TlT6TuB+w7dnE=;
 b=LAFxJmG09qVjlsWmH4i6KPtN/YoHznYJHJKsWuV/KbzElULi6vE0XMLrObinPjhMmE
 JQwpcwqQQDa+u7HWiT1nISOGaOJu7VOLN8vjzkC2dmH6lcF162ZcUy+chJVDFNaoXnKB
 w+KeIsSpbxcynuU+T/mCP4SdCKlf6j+W/ipsjZHncsgX0NtMXYY7P1mno230sPXDAEB3
 6bNpAd8T8vb92Pl4z2x/cnLmuDF0ICncHZJBIJCuD5uusOmX77SiaE20hEKCBeYEu5sf
 D7jAZ0LOx/7LIPRIpd4A37p/rOyMlTHCM75ISGzR8ngNsQxWCXwNeoh5HstHhYLohHAo
 IX6g==
X-Gm-Message-State: AOJu0YxUMdmz4lR9OEuEbjj8WK014tZBJHic9hElbGVuXu0hry+/2Bvl
 cVep1mC89OyGAsOOJHsOsJrl/amocFBw4Oq4vwksBbE6ziitwcfGlQ22ijRUIzIrnUU=
X-Gm-Gg: ASbGncufMtm7oB0aOctU0F0/E1ntkxj0N5z8KhT/Ne+TVUjvuSgRL8lC82RK+/SnN05
 bfpAUUroM4f2m/+i7IkB/Gbt++XjtATkPUq7Fo5X7eXHpGFrFELydStX5jA7KAbuOlzO3RXEpOU
 lRTrq0tlrAgsPpVpFdask61STO1xqeHU8RTF97aaN+CV7MKDCWGnP0dDjGf9q9Iu5QKY2lCt47R
 vpZmm9x7ni3OtvjEF7ufowuupz1UnFEjWgbkfaXBShmBnuWJ7xBKloGCJ4y9ecY7KsuMwaHPVrl
 nIaV7t8uPNdmnzctvhOztmDtb6GvyDI0DGVXFnwBfdnwZw5bPBypWdpc8icQZw==
X-Google-Smtp-Source: AGHT+IEs8ikuhk7l4x5iMMmji8jO87w/2+YUyp07D+0851/ztWYmGaQfxYu37Mpe+oG/22zcdesZzA==
X-Received: by 2002:adf:e648:0:b0:3a5:2208:41d9 with SMTP id
 ffacd0b85a97d-3a9001a192dmr10374235f8f.40.1751341782627; 
 Mon, 30 Jun 2025 20:49:42 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52af3sm12173392f8f.50.2025.06.30.20.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 20:49:42 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v7 6/6] configs: sandbox_defconfig: enable
 CONFIG_EFI_DEBUG_SUPPORT
Date: Tue,  1 Jul 2025 04:49:26 +0100
Message-Id: <20250701034926.83536-7-paulliu@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701034926.83536-1-paulliu@debian.org>
References: <20250701034926.83536-1-paulliu@debian.org>
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

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

Enable CONFIG_EFI_DEBUG_SUPPORT so that we can run a build test for
this config.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
V7: enable CONFIG_EFI_DEBUG_SUPPORT for sandbox_defconfig
---
 configs/sandbox_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 4f6943d1a4b..c50746d3dbc 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -10,6 +10,7 @@ CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_SYS_MEMTEST_START=0x00100000
 CONFIG_SYS_MEMTEST_END=0x00101000
+CONFIG_EFI_DEBUG_SUPPORT=y
 CONFIG_EFI_SECURE_BOOT=y
 CONFIG_EFI_RT_VOLATILE_STORE=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
-- 
2.39.5

