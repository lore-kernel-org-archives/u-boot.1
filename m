Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7076C71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E91782A0A;
	Mon, 16 Jun 2025 18:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZZCIE2FR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1786D82B18; Mon, 16 Jun 2025 18:26:33 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E90781E18
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-452f9735424so15224725e9.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750091190; x=1750695990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HnotkYOgcu1PKotOxGZNJR026LTG2x5kna6peL0o4ZI=;
 b=ZZCIE2FRAKoWqNaUOPEf+BidiZjD03wWMuDdY2PxNpisrlbzSf4gXsORFrzOlaOllx
 ydxZUmyaSvThRe+8FSrGN2eD02JOqHBPuUSpwXGIkMSppFeHOQ1IP8P8vU74I5RCkf+e
 TMnySZmCNChRy2eNra587RyHi2lCxG0f3+WOi8GhMXeyZbEoTOMnV9aGGSjrg0aqgQ1Q
 zGut3i6TO5s3sMoC/7kYw0s03pyIk7GhWy4bk4Tukxf2Cc5Hfpn1CoCOWXG9Dfzx7Cas
 5PekXbP3h/9HIPmCmhKAfT9Y9ydZEVLx7SISGwCPMWpPd3xQ0z1fGPkqiyHN9t837Bid
 agYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750091190; x=1750695990;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HnotkYOgcu1PKotOxGZNJR026LTG2x5kna6peL0o4ZI=;
 b=Si4hz+6y07LLPT4mWFQoKwlt7Gs2hd+QLq0vGrpstyboNDPMy7okpqX2Vz19zhxq7k
 tiM2xMH6xT9OurLQndacxgeQ/YKcenSV4cWB0xOvkGepn+y6LziZ+hbKgqr3hbL0K1md
 u63rNXpMrXOVJMCL6pPJcTiXmKQal40ovgviZMjvAs+zT/O+DMP6Lj1Blh9K5SJa9RS1
 4Zb6opNUNJFFJnVjutNYPFxjFwpRXDTMaxSAgAPEHIbdajADW9c8uuNQyljVAJ1OLy2D
 EAOYYPb1aHQg3oe0U4EOWO8YYmf6DkcgGGn8qWtzGNeAVucZrRpIEQwivorxt62XJuvy
 v22g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeEXnQ/nzK/RvlRbFDNmfeIN6BVYYg0JVzK1ekPhJHisxiPijg9eiQy1wdyulM3Iijdqpil6k=@lists.denx.de
X-Gm-Message-State: AOJu0YxqR9f/RZ8YqMUZEiw2jwMhyRjYv4kEev5ssluhymJHs0lpD/uD
 0vlizA9T2NerxmDb5w1z6DcLQE7nCMjBo/l52Kp7Vk9LRx66f/jmG+eD2z9RhwAebmY=
X-Gm-Gg: ASbGncskY65BRCYCmBY/8em/TK+EG0QI/B2pb0/95aBJ0+L/P8hGGSKvq75C2xl79o9
 wmKFaipHMMcGwCcvyp4/HqZxV000cduDmS1e5lUbOzBvd4UuXl+aF4ECVRpSeg60ew0t2F2OnHr
 Uk7SwsQU7E+U+whYWyT3W3EpY+2bf4qyJQjr6ueiGPLpBIRDZ1lCgNiS7lFPEdqXJhUPTGFUJdD
 1NZ7ti500iBwBjv5aaGkNcorFTF03hFo9Mc9ERHjVMq9MpqW6xUzgL2U/Bk9lYUXgde5U1qmNf7
 F6cTw9WdDiTJcGAwRFKq1I/ijk92kInafahDZumJCO8lConw3xYkOEyRUQgrlvHcqtl221t0D5z
 C2/xkh62fTZjddxM=
X-Google-Smtp-Source: AGHT+IG/uC5SK2NkraR08NucezBK//ADZVRs+Foyk0eeUR751zoBqridPBKkDnoRt7HZiFZdFW9Raw==
X-Received: by 2002:a05:600c:858b:b0:453:1058:f8c1 with SMTP id
 5b1f17b1804b1-4533d574d17mr67615065e9.3.1750091190487; 
 Mon, 16 Jun 2025 09:26:30 -0700 (PDT)
Received: from toyger.localdomain ([213.240.182.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e13c19esm149339415e9.25.2025.06.16.09.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 09:26:29 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] doc: board/qualcomm: remove signing references from
 dragonwing.rst
Date: Mon, 16 Jun 2025 18:26:17 +0200
Message-ID: <20250616162626.247802-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.49.0
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

The mkmbn tool isn't available yet, so it's still necessary to use
qtestsign for signing.

Update the docs to describe it, this can be reverted once mkmbn and the
associated tooling is merged.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 doc/board/qualcomm/dragonwing.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
index 12a0bfb3544b..d48994153095 100644
--- a/doc/board/qualcomm/dragonwing.rst
+++ b/doc/board/qualcomm/dragonwing.rst
@@ -21,13 +21,16 @@ First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``QCS615``, `
   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
   $ make qcom_qcs8300_defconfig
   $ make -j8 u-boot.mbn
 
-This will build the signed ``u-boot.mbn`` in the configured output directory.
-The firmware expects firmware ELF images to be "signed". The signature
-does not provide any security in this case, but it provides the firmware
-with some required metadata. More information
-about image signing can be found in :doc:`signing`.
+Although the board does not have secure boot set up by default,
+the firmware still expects firmware ELF images to be "signed". The signature
+does not provide any security in this case, but it provides the firmware with
+some required metadata.
+
+To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
+
+  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
 
 Then flash the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
 on your device with ``fastboot flash uefi_a u-boot.mbn``.
 
-- 
2.49.0

