Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C7DCD1288
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 01:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A6B88331;
	Tue,  2 Apr 2024 03:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ausil.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="bMTdkjDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 523B488327; Tue,  2 Apr 2024 03:40:44 +0200 (CEST)
Received: from mail-qv1-xf61.google.com (mail-qv1-xf61.google.com
 [IPv6:2607:f8b0:4864:20::f61])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA0DC8834F
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 03:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ausil.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dennis@ausil.us
Received: by mail-qv1-xf61.google.com with SMTP id
 6a1803df08f44-6964b1c529cso38293946d6.0
 for <u-boot@lists.denx.de>; Mon, 01 Apr 2024 18:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1712022040; x=1712626840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3xV2IufD6InYv7DGD8yzf/Nw8K2mJFMvVSmOtXygtz0=;
 b=bMTdkjDPZ48X++M0Ly+HS6gLg64+NtosjB50SzUqk5wQ0RTswJUHnTl4U1ZPRB4ha5
 0UMPJMv+xeldmChhLJhAHTUrCYbC3yo4GHcWZznFMCwZp9IHKtr3sgtA0QdWKPTc9VUv
 LZ2kez2FEHUWi+0IkzsdC8F+GOuXMmBJmifkJNWpcZCFDNHyaIPrHC6VYF7zxtoxwguD
 bv83y2QPGvKbZj33p5r8Fnp/APClGtb5ifE1UYNgQnuGhqS4reGlRDJU7/C+egJXOxVr
 Q46cuV8mr/FrHwxinH4G1tBR/ygXKj3ljHHcUbKjYXbWLyFfg/8NOFBzdWEGz1lsVdvA
 iSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712022040; x=1712626840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3xV2IufD6InYv7DGD8yzf/Nw8K2mJFMvVSmOtXygtz0=;
 b=wft8YHVI2gNGUOIGsrRTlJYgy6MR68T6/n/zOYB3SIF6R/oz1bS6fSsTryL+WMinV4
 9H7R3eu6nlqegxyElJSUr8ooJbjg+N3gLSshdJyLEFaCisrtyyt8SS1GI/+TzHZeiDhm
 iHvglo8FKPjg5ZrIfCQjJA+3HIvOqEsPohNa38iXJGwjhKwWhOAgo5lpRtVyfsCXkyuj
 ivQV5ZeROwDWx/PgogrIwxJP9ePQp7xqglpjv6dgbPjKUf2k7SgQcNY28kGJ2gLyAY3G
 /cfdHqnQ1/bMUwxIZXbTeDa5wS+KjCPZsC/X3RmihuUFXvGFMkItgKq5OVv11eNr/0nl
 8/rw==
X-Gm-Message-State: AOJu0YzvnSjM0jj4g20cp5crCkukhx6lkrNYKqF/0rGLhnLeSX44Tgo8
 qPlcLf1ZYPGNl9h8F/siowEijzqS8XuJkarAvAvytMpOkrCKXSfAJldr5dF7zOQTqEuv95pcuR5
 PbVNRskGcJ3zRElrPj3iA+s0h3h5tjl0d5K/J9nk6
X-Google-Smtp-Source: AGHT+IGw4+Wdr9CjCVj7HmNfOJLgXJkYI0/A/L36A8qgtrUlVex8ETVTiJ6DQpxvX3gc/6y/TVZzYzlTtSaF
X-Received: by 2002:a05:6214:16c8:b0:699:d1f:ded1 with SMTP id
 d8-20020a05621416c800b006990d1fded1mr3801526qvz.31.1712022040559; 
 Mon, 01 Apr 2024 18:40:40 -0700 (PDT)
Received: from tomin.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 ey15-20020a0562140b6f00b0069689e5f953sm817443qvb.69.2024.04.01.18.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 18:40:40 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: u-boot@lists.denx.de
Cc: Konstantin Porotchkin <kostap@marvell.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Dennis Gilmore <dennis@ausil.us>
Subject: [PATCH] mvebu: Enable preboot start for pci/usb/scsi/nvme
Date: Mon,  1 Apr 2024 20:40:35 -0500
Message-ID: <20240402014035.8169-1-dennis@ausil.us>
X-Mailer: git-send-email 2.44.0
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

While preboot was enabled, it did not work as commands are needed to be
run to enable some of the subsystems. This patch starts pci, USB, Sata,
and nvme and makes sure that the system will boot no mater what storage
is in use.

Applogies for resending, I accidently left the u-boot list off

Signed-off-by: Dennis Gilmore <dennis@ausil.us>
---
 configs/mvebu_espressobin-88f3720_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mvebu_espressobin-88f3720_defconfig b/configs/mvebu_espressobin-88f3720_defconfig
index 7ecf5ab0d64..f4f7a809609 100644
--- a/configs/mvebu_espressobin-88f3720_defconfig
+++ b/configs/mvebu_espressobin-88f3720_defconfig
@@ -21,6 +21,7 @@ CONFIG_AHCI=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="pci enum; usb start; nvme scan; scsi scan;"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
-- 
2.44.0

