Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891E1D5E379
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 17:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F94890DF;
	Sat,  9 Nov 2024 18:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KEKM4dxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2667D881E7; Sat,  9 Nov 2024 18:49:20 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F8B989145
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 18:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4315eeb2601so38959495e9.2
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 09:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731174556; x=1731779356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=z0gqgUvpG4TGIzyDkqRTbfHoh3hOSQ1kdapXAw04fzA=;
 b=KEKM4dxdGJz9nNvv6fVMY/jA5o9XBubn/c97PMqsjl3AeDD1jLq8TILvllPLuBwFe/
 p3Vc6VCe67kwsAe9Mftcxe8lFSZluPElh+1ek7YZoLePOx56OQ6VpNH2gz9Ecm7gunQQ
 iUZMmtuCy4vd30m7QBuwB2MkoUr1/S6VTNNDCh7G5I7ljD6D+YhRfTRAKkWXQ2ddPY8f
 lTn5tMfd4UbgPgF1RlSeIafpPYq23AFVyLmP/gDTwH2FN+X2UNQaAah1pZjGNZ5vRx8k
 QdxPsqKXONOkwN+c6Xg1WXl+oEAMJqV3FPstTwXXE4ZXpfmOTBj2RYxYiOoIt/S0uIuc
 l+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731174556; x=1731779356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z0gqgUvpG4TGIzyDkqRTbfHoh3hOSQ1kdapXAw04fzA=;
 b=PI6Qcwu3/rYdc9HSJxEaNJ77YOxPTHY9Vn4wnYu77XtVDSxgh7ctoNOwKyuhYAtwrd
 wEXUE4it5Z1AIFRxsg0wqNP/KHZSZ3FAvAXAChxA1n7L9sh4uLogDHE0NcU8EertG4R+
 l5f9hzAyD7jcxlFYlRglsP4v04KNKikR7usPXSwHgSpu/Y+kEkZ/Fc/nNlwFiaZRpHGI
 9BQYO1g8nJPF8KGQUxGuxsPsQeeZbxs23FyngM1IrurB2oXNbaaQslvc0NvsFPhKo914
 n7CjgRevIu0LwmH7W5j5CTOMWSDBEw5b/bAcsAgXiJEFvj8nVCtf7xTSf02huVLmQKUn
 TYbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCUpc2A2oAgQ71leDN3bz1jyMBG4lhVzutpgeFEsyNDLZxuXPaatWfrsNfEEnbJFWuME1pgYg=@lists.denx.de
X-Gm-Message-State: AOJu0YxqlHCS3KbmYb6/iZDGUz0YlGwNsc+9soFUiaOhDOLw46n7NXSZ
 XKbw0p8jJ9RfYl6vpnEK/I7JP97JzH1ictSB/WZzFYHxnkSlywqm
X-Google-Smtp-Source: AGHT+IG45dCPSSjadotIM4yFeiY4d78R+pdv+Oltib/f6uiuqYu2MRemIFO9rWYWNOeZZYgkPk8UIA==
X-Received: by 2002:a05:600c:19c8:b0:431:4847:47c0 with SMTP id
 5b1f17b1804b1-432b74fec2emr76041965e9.7.1731174556292; 
 Sat, 09 Nov 2024 09:49:16 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432b0562860sm114019635e9.22.2024.11.09.09.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 09:49:15 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Andrea Calabrese <andrea.calabrese@amarulasolutions.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] .gitignore: add test overlay .S and u_boot_logo files
Date: Sat,  9 Nov 2024 18:48:44 +0100
Message-ID: <20241109174845.9227-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
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

Add test overlay .S and u_boot_logo file to gitignore as these files are
generated and should not be committed but ignored.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .gitignore | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitignore b/.gitignore
index 502a7e6ec70..e93c33da1bd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,6 +75,9 @@ fit-dtb.blob*
 /keep-syms-lto.*
 /*imx8mimage*
 /*imx8mcst*
+/drivers/video/u_boot_logo.S
+/test/overlay/test-fdt-overlay.dtbo.S
+/test/overlay/test-fdt-overlay-stacked.dtbo.S
 
 #
 # Generated include files
@@ -83,6 +86,8 @@ fit-dtb.blob*
 /include/config.h
 /include/config/
 /include/generated/
+/include/bmp_logo.h
+/include/bmp_logo_data.h
 
 # stgit generated dirs
 patches-*
-- 
2.45.2

