Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74198C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 13:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D76F88453;
	Thu,  6 Jun 2024 15:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UaNMO/eX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1094888464; Thu,  6 Jun 2024 15:37:18 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 798A98846E
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 15:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52b88335dd7so1214595e87.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717681034; x=1718285834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbMRm/KnE79A7lsy/7kwhP2w6DrKnyYEC4cqafPFDpM=;
 b=UaNMO/eXed8yITIWh91wYbEAgcUKvZrRl6NSbBpt/9+5alul4aMXh7ocZO50EHWV7Z
 EO9MoEWKShkfyUAo15vbgeeZ1CYCyHCLHaKEp9fY/XP8DR5lYZls/APynj9Kin+IdsiZ
 w4vfS3VHGGMPe2N4Nou9BTj3vRlNIA/HbnmgjPFnuVYe4TH+TvtJbws6vcXh+8n0Kehk
 keHv8IkMWC2sn2Owj21mHvr+B3wfifWvrP2kPS7eqAT/fLpKjTu5MvOuZZ6Kp/rrG+LB
 2A1Nbs/NFiJ5CdLg9OtdB4zz0/7EGPyqGfWvxsvLQPbCd8L46R78Dh9FjPMb/pIq/W0E
 v6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681034; x=1718285834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbMRm/KnE79A7lsy/7kwhP2w6DrKnyYEC4cqafPFDpM=;
 b=eFKwUY6vcXDN2vxejXj8N7Y4MinpvGy9vzH73MOX/3MPi+UYniyV+igjqYZOjnyU/P
 zWMahdzkAjmqnTx8LrViUBCaeHPMIFSfaudDxecM1+57DFgJ4RpbYcl2yetRj1YJaFkn
 ofNfQnM8fa7GflRdVEgsuIcifgISP4WLDFo8lebfhnvMLHjWNIUGNQB86syEg0sbH+nh
 FGjSL38qOBHFGV5AL5B9GXjdD64Yj9LqZRjqL5kUva8Er/3lIdCUx/nnB2ZQesciBHpm
 t5IKOrvTf7Rt+46kZzU9MPdvITIdbC72DxTtHWR5B0XEg0JyvoyqCjEDmwBiTV3bOxdp
 QcWA==
X-Gm-Message-State: AOJu0YyZQLFlY7+LS0g+D5YmRAzYhbFONgDPkVM6vNYy2X4JZRqOys5y
 vV9MlwsBq6vXlzOhu4yHCbobU0NU1qryZ5xuKdCi+V3h7MsL9t6szcv26N8KzvZ7rU10AlHcQ2J
 Tvs6JKG85
X-Google-Smtp-Source: AGHT+IHfH+tRoWDXC4MCxI3UdOAJy/q+Ha1sGbmPdiFCDtLNyzgGrGDGvzVQLR3Iyg7Hz8oHAFFgpA==
X-Received: by 2002:a05:6512:3254:b0:526:92d7:52d4 with SMTP id
 2adb3069b0e04-52bab4fb447mr2873511e87.61.1717681033975; 
 Thu, 06 Jun 2024 06:37:13 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d52dsm23111955e9.8.2024.06.06.06.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:37:13 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 10/12] configs: add qemu_arm64_lwip_defconfig
Date: Thu,  6 Jun 2024 15:36:05 +0200
Message-Id: <908e69080417054ebe50ec67c803d0697e8b53c0.1717680809.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1717680809.git.jerome.forissier@linaro.org>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
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

Add qemu_arm64_lwip_defconfig based on qemu_arm64_defconfig but
with NET_LWIP instead of NET.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 configs/qemu_arm64_lwip_defconfig | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 configs/qemu_arm64_lwip_defconfig

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
new file mode 100644
index 00000000000..050c93ff97b
--- /dev/null
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -0,0 +1,3 @@
+#include <configs/qemu_arm64_defconfig>
+CONFIG_NET_LWIP=y
+# CONFIG_DFU_TFTP is not set
-- 
2.40.1

