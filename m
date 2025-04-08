Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E6EC369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 20:21:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4379D82991;
	Tue,  8 Apr 2025 22:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CietJYF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F03820B0; Tue,  8 Apr 2025 22:21:48 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB0882161
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 22:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2c81fffd523so1935508fac.0
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744143704; x=1744748504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3clR/jZ/5cRPXViuuKLFHYl9iBRpnql3VireViKjELI=;
 b=CietJYF3pWyelBxOqGo4A+4TR6O4t6Z/FdfGPxU6/GsonvJIld1w34yLU7RJBiPd2W
 Vi1gstoWEd/dutd6MSnLrXtbVzqr4G7F8VWS7MXnuKhSzq2sDqda9D5MkWO2v53ZpRci
 7/mPWtDRFGLwzRKctYtpNytI9ES1IF9e4xaiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744143704; x=1744748504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3clR/jZ/5cRPXViuuKLFHYl9iBRpnql3VireViKjELI=;
 b=wd+HDcTgmxzTDtGqzz/YT/fYam6t4OyDfTfpOF3Cdj8JRfbMQD9Ll2Ve0zwThkwP2W
 oULFCzSgULn5a8UUDoBrENUFPme3u/dXkkgMhHS6h2N3HgU1+vDgPVh7p+AmQfZcyv7t
 Bt3KhzJQ3hECJWAjY9gxAdsHxb6CV6JhWhG5rDOFRWFTk/5JtZrUSPfHNQtKnj508dg+
 lTY8MQoaplBILr8m3SeD7dV3kbNqxdm76o9WO2EoHkhfDdLcKqf3iqTPaENKeLgn5M4g
 HlvJ5DV3DKE6uxmJfg6xJ9WtnYr/ywQzfM0h9N8HBpgGRhbz5Z7jJLQmPSX6Ujz8VBwQ
 zTyg==
X-Gm-Message-State: AOJu0YwXsGoFiAEH225CIL+bg4RVnQPK9r8Q/7ihU/Pk467FoRFfNs1f
 ykp8HCPiKtK8Np1TtcCrmIWN/N4cREScAjq7T4MFjoXwTdvE32IzmzUqHCSDtkrksZHcxvRHBu0
 s
X-Gm-Gg: ASbGnctCbCtge5+e2KDs+NLVl5VuWDFQCAA8n1NSoschrFWjhn2fwI8idJjP2q46UDI
 gvQcTwafFqGbQwymn5sR25W0YPuww9gFgnwyOvJ3Kn/319iaAZWnJDSQTwgCTRuqPqEzAnf9wFl
 JPmzBDu6RutQ4cYic7puU69U33IzXEcuh7TblCUMl4el1W+aKdfEqMJpBGvlHbOf9p0lDmhc4eN
 X+l3lELntRrbnuEupzHmG6MQ1Qku9pUR5O1G5v4IISaq3BYjcTja85XX0y4br/3RCnStGBD8aya
 NfKKzW9DYJ9AR3+M+IbW/3R4pzNHGD3UyZmGT4TDV43yoUt8wq2f+uOAr32DXPzYRw+yyCkY4Oi
 WhZ+PH9p6
X-Google-Smtp-Source: AGHT+IF/CTbdjM5KLAV48h5MqWyTfgVjdwyJvSaJThc7JpaTvAfFIu7vg9x+/JWZXZ6Ha+k5l1PAWA==
X-Received: by 2002:a05:6870:fe81:b0:2c2:542b:bce4 with SMTP id
 586e51a60fabf-2d08dcdd60amr255632fac.8.1744143704448; 
 Tue, 08 Apr 2025 13:21:44 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e6517724fsm582391a34.19.2025.04.08.13.21.43
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 13:21:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] Dockerfile: Download the Arm FVP and extract it
Date: Tue,  8 Apr 2025 14:21:41 -0600
Message-ID: <20250408202141.1434754-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408202141.1434754-1-trini@konsulko.com>
References: <20250408202141.1434754-1-trini@konsulko.com>
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

There are some reference platforms from Arm which are not found in QEMU
but instead in the FVP tool. As we can make use of this in CI later on,
download and extract it in our Dockerfile today.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 3b0c403618a8..260af61bd3db 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -237,6 +237,9 @@ RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/t
 	cp fiptool /usr/local/bin && \
 	rm -rf /tmp/tf-a
 
+# Download the Arm Architecture FVP platform. This file is double compressed.
+RUN wget -O - https://developer.arm.com/-/cdn-downloads/permalink/FVPs-Architecture/FM-11.28/FVP_Base_RevC-2xAEMvA_11.28_23_Linux64.tgz | gunzip -dc | tar -C /opt -x
+
 # Build genimage (required by some targets to generate disk images)
 RUN wget -O - https://github.com/pengutronix/genimage/releases/download/v14/genimage-14.tar.xz | tar -C /tmp -xJ && \
 	cd /tmp/genimage-14 && \
-- 
2.43.0

