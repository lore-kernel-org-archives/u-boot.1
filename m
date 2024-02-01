Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC64C48291
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 15:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD5D87CDE;
	Thu,  1 Feb 2024 16:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gycr+Unb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB71087CF6; Thu,  1 Feb 2024 16:00:10 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D0287CDE
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 16:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-42a99f34cc8so5475321cf.2
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 07:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706799606; x=1707404406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iMZZhH3vHqfDacFyzdF8JS1UhMZ3e7wUbOOb9XdKAmY=;
 b=Gycr+UnbZme5Zg8iRB2JGaVUq5dC0QwRNiMWULlZTSqok0KxKxUiu14mif3c1y03+a
 SnvEc2iBjBkG8OqzUYr941zldFyCZqf7jQO1mWj0ak+g6xkdVqucPSP7yVj5gLVlDe2v
 H4dXlqGr5srOSehJDoR6SXzj+IUiIc1INUop9s5vtjOQxQT2yk+QUJNjEQVHPLt0/GR1
 6Yd9G09fvwXy1nWaUYJ8aNPz6J88jKAaKNKd61ZVAZ4LrGnOkP6BrUI4/n4uvFkv1I1v
 NzmfcPgLwWfgcgcgfouaPTfxDDMlKC8OuvuwoUny/v/mkMd69IKqvrimFgv5qp1KRBy9
 h+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706799606; x=1707404406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iMZZhH3vHqfDacFyzdF8JS1UhMZ3e7wUbOOb9XdKAmY=;
 b=AA6f6x/+s0/FRtQzCwAMZti70l4G9yB4w1uazsL9U2TqLsjXJJQ0AXrLuYtSLYM1TY
 v2SvQtn65b/fNVVNsue9UAQxN4ww9pQwWce4GwfLV+C5qUVgVBAddXFaPSFDL4zjfWbO
 L6+H2F6OsMfSIiFjw6KQ61gZBj9s6LjJr8S0sKl+ZKl/M7k9eoPxPiEb0v21JnI4ECZ/
 c8qdYbS5qv91AQjbOOg/43h25EQqsde7o5YaSCRnAOe1h1+cXOVlGxzhsSkQK6n4Xy4t
 egyqOGRBj/1FRJ/cAUCCBMAvih9+1gq/i/FWm7HR4U34lLlRIjRbvs6yJJnh+ZMO4tJ2
 W+aA==
X-Gm-Message-State: AOJu0YymIazanZzKpDMFCrrjzdWnTrpHHgwFvpUEl8ABo82o974LYmWM
 TWZQYoJYIkZFP9HkMj29cLIhg+27YvPTYTZ7M9BkDWL53r0pfCfNfOcy0W7F7pc=
X-Google-Smtp-Source: AGHT+IFt4hlBjRVf9AI+88lTBsJxlzZa65OLzXZ6dR9GfoqPUIO0mLHLuq2P9BEaFK7umPwfNFmEQg==
X-Received: by 2002:a05:622a:295:b0:42a:509c:aa7c with SMTP id
 z21-20020a05622a029500b0042a509caa7cmr2939713qtw.46.1706799605874; 
 Thu, 01 Feb 2024 07:00:05 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVp4/5tNhPS7JX50xBA70OYKlZXkaZ4HV4VB23fT7oBzuwdozcStEfSGW1gGdl7wlCsDs5iLlYR2kf2c3MxYPrF38szv4axRUOlVU3eAk9pUK2syFjf5bVcFdKxNK5KZthmvI1G+PlTj4vSx1aRKthIGh4YDZHB3Twxm9/e9dLy7LMuIzWSwneY88gcQYP1CublckKHqmPVLJ8hn7xLgQc5V9/yFJFG6A==
Received: from jesse-desktop.jtp-bos.lab
 (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
 by smtp.gmail.com with ESMTPSA id
 cr8-20020a05622a428800b0042bf0b37b5csm1029789qtb.28.2024.02.01.07.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 07:00:05 -0800 (PST)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Jesse Taube <Mr.Bossman075@gmail.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH v1] doc: imx: imxrt1170: Document imxrt1170-evk board
Date: Thu,  1 Feb 2024 10:00:04 -0500
Message-ID: <20240201150004.1343366-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Add documentation for imxrt1170-evk.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 doc/board/nxp/imxrt1170-evk.rst | 42 +++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 doc/board/nxp/imxrt1170-evk.rst

diff --git a/doc/board/nxp/imxrt1170-evk.rst b/doc/board/nxp/imxrt1170-evk.rst
new file mode 100644
index 0000000000..4acccdcc93
--- /dev/null
+++ b/doc/board/nxp/imxrt1170-evk.rst
@@ -0,0 +1,42 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imxrt1170-evk
+=============
+
+How to use U-Boot on NXP i.MXRT1170 EVK
+---------------------------------------
+
+- Build U-Boot for i.MXRT1170 EVK:
+
+.. code-block:: bash
+
+   $ make mrproper
+   $ make imxrt1170-evk_defconfig
+   $ make
+
+This will generate the SPL image called SPL and the u-boot.img.
+
+- Flash the SPL image into the micro SD card:
+
+.. code-block:: bash
+
+   $sudo dd if=SPL of=/dev/sdX bs=1k seek=1 conv=notrunc; sync
+
+- Flash the u-boot.img image into the micro SD card:
+
+.. code-block:: bash
+
+   $sudo dd if=u-boot.img of=/dev/sdX bs=1k seek=128 conv=notrunc; sync
+
+- Jumper settings::
+
+   SW1: 1 0 1 0
+   SW2: 0 0 0 0  0 0 0 0  1 0 0 0
+
+where 0 means bottom position and 1 means top position (from the
+switch label numbers reference).
+
+- Connect the USB cable between the EVK and the PC for the console.
+  The USB console connector is the one close the ethernet connector
+
+- Insert the micro SD card in the board, power it up and U-Boot messages should come up.
-- 
2.43.0

