Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60BBC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 846778699B;
	Mon, 14 Aug 2023 23:55:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gqw8sfE8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 549B284788; Mon, 14 Aug 2023 23:55:35 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B81A8699F
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-26b399c6a4aso1052180a91.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050130; x=1692654930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzLowpycA/+ZmlfP26WcA0Ge4QICMhc1eySSjc+9ge0=;
 b=Gqw8sfE8Tc30YXpbLWcU8E+FmfBcEeZy9teR4nU5wf8I0N1U0sofpWGlK8QOItGZQ5
 3caKSmlUB6Q0QrWw3qYDSQhxRuxuioZxgQLkSq5V0yUnaCawl8NfLUbUgB3I44U6Ihg3
 yqTxSaao3yyL2KGRAtqRfmjwvvXpt8L9zatvhcvuTKJoeYZXO4YMd2Gc3XwspETFwr9B
 AOuaZU9jKk3KtB0e0OHGO1ci22RE+pCQ+/8lIwXiI4n0KGiXdiaOFcjaer1wjuJ/2TFs
 pc0SLHk/GuG5FAcgj8ZFR/vy6bdEkoQBU70dCWrbmHpbomYq3doBElE3eacy9P3iQoDW
 RdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050130; x=1692654930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DzLowpycA/+ZmlfP26WcA0Ge4QICMhc1eySSjc+9ge0=;
 b=NUhCxuLt5T1yLaISHdKdg5iYRQx0ZTCp+FLNmfWvPkvO0SSWqXh/pLSSePzgOXpFuS
 Itwd/4IpPATfxbm2yFxHMlVHRuUfGW6+tAZqoMM2G5ihN8hhquRm73T8uy48Y8GxLIIb
 gUaNvGMozKUVt0sg5KITVJyZtgff83lGM8m0LSmAKpntYkSkr8PkD5grI/AlPDvlLRdz
 GTjBzlmhJ2GBhymCiSln2Qj6HFJj9Fg09YqWWeRa8Oog4Ma0CJhMMo4gs7bfi8fORfJZ
 2maKrYtbfMqKWMpbXq1pJRML4Y3EgvFMLoOaKi7vo2KOFUu4L11nf3IL2b+H+SOU4GGE
 x9bw==
X-Gm-Message-State: AOJu0YxSEksXrNE0sO/jHplPiad68uck+saBK/k/8p6T3Squs7FzJQ+Z
 R0+cZnqYxGqh1ljZVang8+0tjw0uagHcyLpgp0A=
X-Google-Smtp-Source: AGHT+IEKm4cIhlQtFzira1D9DrNn0S9bUq8HbxMfOulB6+37D9Qk9emaEzs/67hMtx9bQKM0zA+giw==
X-Received: by 2002:a17:90a:2f86:b0:263:129e:80ac with SMTP id
 t6-20020a17090a2f8600b00263129e80acmr7193663pjd.38.1692050130298; 
 Mon, 14 Aug 2023 14:55:30 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:55:29 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 05/17] ufs/ufs.h: Add definition of 'ufshcd_rmwl()'
Date: Tue, 15 Aug 2023 03:24:45 +0530
Message-Id: <20230814215457.4075025-6-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
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

Add definition of 'ufshcd_rmwl()' helper function
which would be later used by Qualcomm UFS driver
to read-modify-write registers.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/ufs/ufs.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 8a38832b05..c9320a905e 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -2,6 +2,7 @@
 #ifndef __UFS_H
 #define __UFS_H
 
+#include <asm/io.h>
 #include "unipro.h"
 
 struct udevice;
@@ -906,6 +907,23 @@ enum {
 #define ufshcd_readl(hba, reg) \
 	readl((hba)->mmio_base + (reg))
 
+/**
+ * ufshcd_rmwl - perform read/modify/write for a controller register
+ * @hba: per adapter instance
+ * @mask: mask to apply on read value
+ * @val: actual value to write
+ * @reg: register address
+ */
+static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
+{
+	u32 tmp;
+
+	tmp = ufshcd_readl(hba, reg);
+	tmp &= ~mask;
+	tmp |= (val & mask);
+	ufshcd_writel(hba, tmp, reg);
+}
+
 /* UTRLRSR - UTP Transfer Request Run-Stop Register 60h */
 #define UTP_TRANSFER_REQ_LIST_RUN_STOP_BIT	0x1
 
-- 
2.38.1

