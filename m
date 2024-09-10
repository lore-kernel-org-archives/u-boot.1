Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9F1ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5051A88F95;
	Tue, 10 Sep 2024 11:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kn2qII41";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9073D88F75; Tue, 10 Sep 2024 11:20:39 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D11D88F86
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53660856a21so2922168e87.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960032; x=1726564832; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q2LW5MkEO5pymB6e7w7IUQGE027uBvWv7Inx1yFDrmg=;
 b=Kn2qII41EIXdN64MFO9dVeDVSLmc9J/LZl+BcGeDfcbaC5XrfQty8yPD9cohnhYGxU
 /tv2p3gt3ut3yMdeLZ10cXC/RNGqnVwKmuXzXagLK5brwIbyr1mh1PgFxFwG4M98mEFI
 dHvyHByypzNYOq00Cy3coRb9gR2GsNIvw8KTzTyR07KL4J62XiGT1ySFFl2cZk2rsHq+
 DWWGoPvZHfD2zHR4a/DHQwZjAE8a//UnNJl6cJy2ulP7Pd3zfvENkQji6oCF+2iDRhgr
 3CogXsV2CLBJohYhwy158uhxS7OjsK6NOZq/1nYZs+ofBSySZRecMIV3PHHruv9EKarO
 PPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960032; x=1726564832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q2LW5MkEO5pymB6e7w7IUQGE027uBvWv7Inx1yFDrmg=;
 b=TCIKVacnmyN1E3kDT8ztBtPaSTCnO7tBN3mGyUhSaAku69VLHPJukVS85okH5/jOFE
 bKRD0Qoj+bFn1RsJIRC3fRQe82vjK3RyT2v9dvjuAtsl87LyCDLq1jspKELXMTvlesk8
 O6zulDp43+CqJT1a+va8kPTnp/vu2GFdvHDw17TshWd0eb9WbGd3sgE6B9Hqvbq05QIa
 SrzPHMmFMpkAE+6NIKs1irygvFECUNekbRmHBkvv/4c1apyKdvQsS9eAtHUGhX7xCdka
 UDaH5RJPkvtYHSLH3p6h5qfHCP89vl6qrhQ9/cPRfEEvT0iwlX/sXmz67VfV3Taiyi3V
 FjyQ==
X-Gm-Message-State: AOJu0Yz3FJIfKcerEqekAUVzIDMnPCn5Tluk0YsgcJyNcdW2/MMMGsbj
 wWt+ufOuBmITweq/aXPnWpXXiL9Rcero9zR3jqQh/Zo1S8EnFtxFxLh/yqK/Mm0=
X-Google-Smtp-Source: AGHT+IH/rUdCZ+jTEbxt0Bw2M+x86cDqqSn5amG6wgmCaTrBUt1BNEohy5zb1MQGqcYPzfQjgYGepA==
X-Received: by 2002:a05:6512:1103:b0:52e:9ac6:a20f with SMTP id
 2adb3069b0e04-536587fc91amr9316054e87.37.1725960032097; 
 Tue, 10 Sep 2024 02:20:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:31 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 10 Sep 2024 11:20:22 +0200
Subject: [PATCH 05/13] ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-enhancements-v1-5-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=972;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gzfDJdXexZqNaG9T3+YZbLI3JscEH/uXNYFxEdmKPMo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9XyVAVvreJ4D+GnA405GxJCE9BF0WdMQsuyVDk
 W1lEtRmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPVwAKCRB33NvayMhJ0d6jEA
 CYMbqBrzHe3bK+BqJJHP28AzuzF8RhGsWeB1c3edNEeQVSV6OVrghBT5obv+3oKVc6dSXwiJX6Z/Hg
 pqwqq9D9cMVz+UBmWbfW72GpscDFVGey4uuK//OderZzYFj/QdcreZnZPbwDVjSnvdyUreE6biGrz5
 yenfe73mAutXumFB//7r0OKlypvMgAum/CTdorxwlk9fN2eVuUNZw9yqWCBIamJiF8LhYvOmarNoji
 yJLyQD53BH2mG+jrF5x6rpowtop8ziF+S6lL61oMjcRqAW8yu1AFCZeoO3/fsFR5g4ztc4Kk/oc59y
 s8WE8dJC0YNWxSpBWuuOCyNNPyXfVzSP2I/th8zMBhY8cYubPHmkHDl/L8Icl974QD4nau+vnALO0G
 uUhicUWg83N10UrrI/JI7CZakSsZwLpNau7MMJSdS/q12VuQb6OdjDLY97IAXliGYZC4LPd1z6XuqX
 p58F73AL4dc+RhBJSq0LaqTnq0vGUausuuQxbE1lqOJHVlwDEaO0S9H2S3U63sMuSojeNPuMiq7+rw
 im2vmBtguJI59Bq13yhLlimUUURf3Ip4TKfRUiM+Cq44oR3vja//jtPEuoKPIxcSgXXUz6WA5jsSdC
 H85IOsrtbpkRfRovucomtZf6thjJdpZ6LXVGRHmxcXn4G2mjWEe8OWEh1tXQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS for host controllers which do not
support 64-bit addressing.

Ported from Linux kernel commit
6554400d6f66 ("scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS")
with ufs_scsi_buffer_aligned() based on U-Boot generic bounce buffer.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/ufs/ufs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 43042c294bb..c92f47d82b5 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -732,6 +732,12 @@ struct ufs_hba {
  */
 #define UFSHCD_QUIRK_HIBERN_FASTAUTO			BIT(2)
 
+/*
+ * This quirk needs to be enabled if the host controller has
+ * 64-bit addressing supported capability but it doesn't work.
+ */
+#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		0x2
+
 	/* Virtual memory reference */
 	struct utp_transfer_cmd_desc *ucdl;
 	struct utp_transfer_req_desc *utrdl;

-- 
2.34.1

