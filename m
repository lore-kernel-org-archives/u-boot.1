Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542C6E8FDBA
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 21:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E9E86E79;
	Tue,  3 Oct 2023 23:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hPdsXqAA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87A3987224; Tue,  3 Oct 2023 23:27:48 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F89686DC1
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 23:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c6219307b2so10292905ad.1
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696368464; x=1696973264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5MZ8EAoadAmTNw+JD542Bxo3Z6IQbOETTuCfJr8WEZg=;
 b=hPdsXqAAgbhBE8TmhB+s6OXg7R0qH9Od8GVxOxzgoI6EBQmmyhU0ILQ6tEpsAhz2ak
 eEUwrDSS8a7ejq/YAt0dLLjz7BRm1aoXcrWA05ihJ9/ySKoNh72vlHb04azC0jN7NfR+
 J9lVz4KpN7jCtveWatlO6ahAnv16Rczw/F+RclXoOGWzUu4e/SBjgT/k+CNZVvLTU1S5
 CB/3sd4AH5G06iSVGZfsy498+lNX3YmKvZWtgZ9oylyJfObi03uRhClWhkleiuUFSuso
 5SOkfKgT4pvADdOU89hALyyF4m4bycZOg9cuK2UTOPl5Eca4XsWwsDyK5JdN2BXIayzB
 wazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696368464; x=1696973264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5MZ8EAoadAmTNw+JD542Bxo3Z6IQbOETTuCfJr8WEZg=;
 b=Z9QcVbShdHuKKRpuTmxZcfIHaeRl+IE1MTLCxi0/s8BvkW0l+UkXJo5eYaOddeJPjM
 bByp0UixUOyeyteIU6v0PBJ2lLqi6aE0Y1f94EB4f8kFxjywqiNkqYchhVnHd/UmxMpt
 gbYuEH0d3NYEiBHTQdhnGG7llV9n0hLydnt6luU7PLDVYqIlc3JwJOg6tH9cQBTJG3/y
 JzAO7+UpgFEQ9cXJGy5JqVTSenjmHnJRAO42yQ2ipUL0XpdsmLlfdKSG7NFiVTGA07Iq
 XPZeX4aCBQdIl0v0NLPwWIdEJ4/54OYpR7v7Aqq7oYEwSCZqA/I/Kay8lFLhra2B5zUn
 cdWg==
X-Gm-Message-State: AOJu0YypnijOzz6a4k1sxAqEYT3xcPeq9CJBzhW2u0Q/brqwUXisd3i0
 VudV9KXBbAUg1MFCNpAmZps=
X-Google-Smtp-Source: AGHT+IFaVbiBZCULI3hjL03At7fdTNehhqGsOpLjywxJDQiJn+dHaNEcUooRqgau5w4f4sRI6Pi6Xw==
X-Received: by 2002:a17:902:e549:b0:1c5:70d3:f193 with SMTP id
 n9-20020a170902e54900b001c570d3f193mr935817plf.10.1696368464263; 
 Tue, 03 Oct 2023 14:27:44 -0700 (PDT)
Received: from debianfranco.corp.toradex.com ([201.82.41.210])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a170902d4c500b001c322a41188sm2077690plg.117.2023.10.03.14.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 14:27:43 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Hiago De Franco <hiago.franco@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH] arm: mach-imx: Makefile: Extend u-boot-nand.imx padding
Date: Tue,  3 Oct 2023 18:26:54 -0300
Message-Id: <20231003212654.53139-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.40.1
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

From: Hiago De Franco <hiago.franco@toradex.com>

Extend the padding process of u-boot-nand.imx target by adding 10k bytes
of zeros to the end of the binary using the 'dd' command.

The existing padding method did not generate a functional binary,
as discussed in more detail in this thread [1]. Instead, we adopt the
end-padding calculation method documented in 'board/doc/colibri_imx7.rst'
as a reference, which is relevant for iMX7 with NAND storage.

Adding 10k bytes of zeros provides an approximate value that makes the
proper padding for these NAND devices.

[1] https://lore.kernel.org/all/CAC4tdFUqffQzRQFv5AGe_xtbFy1agr2SEpn_FzEdexhwjdryyw@mail.gmail.com/

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 arch/arm/mach-imx/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index aebfa6517b..6904cf3880 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -142,7 +142,9 @@ u-boot.imx: u-boot.bin u-boot.cfgout $(PLUGIN).bin FORCE
 	$(call if_changed,mkimage)
 
 quiet_cmd_u-boot-nand_imx = GEN     $@
-cmd_u-boot-nand_imx = (dd bs=1024 count=1 if=/dev/zero 2>/dev/null) | cat - $< > $@
+cmd_u-boot-nand_imx = (dd bs=1024 count=1 if=/dev/zero 2>/dev/null) | cat - $< > $@.zero-padded ; \
+		      (dd bs=10k count=1 if=/dev/zero 2>/dev/null) | cat $@.zero-padded - > $@ ; \
+		      rm -f $@.zero-padded
 
 u-boot-nand.imx: u-boot.imx FORCE
 	$(call if_changed,u-boot-nand_imx)
-- 
2.40.1

