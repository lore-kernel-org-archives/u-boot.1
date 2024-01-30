Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA107C48285
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39CAE87E51;
	Tue, 30 Jan 2024 15:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K5+eCOtE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABCD187E1A; Tue, 30 Jan 2024 15:05:29 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A25687E25
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33ae3be1c37so1613286f8f.0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623522; x=1707228322; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+2856vw80urfFUKQ6qJcTLah3Zzf6OcDXEWMyxXCAxc=;
 b=K5+eCOtELVJtLtIG5fR6AhWe3yGQcxEj1WE/e23fuudgFM5WAOAy7DYve3mBUSgk1H
 4PSAwvJpltzNYA7E5X4tRasSBudXXRdznvPUKgsZ8CCvaneZcrBBTTc2YjdHECVi1OFp
 lF8LFtgLwD5/izM2X3LyF2d5iW/y0ztGy/uJ+Tn0IhVXaBoNTm4B1OWGMxkycTmjLcZU
 k10D7lnJB7Wz7Io0x7IcmkwAaaw+woKo11NcCEbMvYdQuWhIZtce2CrKRAqMdlGUEZOh
 TQRB4Tq7EpnNxP3IjAZurtzJTpMqLjiakaHZoZrQerHMC5p4DmiET+igqcyg9FAV8caN
 y4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623522; x=1707228322;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2856vw80urfFUKQ6qJcTLah3Zzf6OcDXEWMyxXCAxc=;
 b=B/d3o7HUynoKP0FvghTm3YNJpuF74S9OAL+M3ee6F9wW6LBSYretlO23rGzd5X+Q2j
 oW9swQR2PY0Ot9FcC+bc75qIpuIfktDflPHSfaXrqWFBMEwrU3OcaA9BQ0rdciO/+5sv
 u95ivAHtrhxkyorfRMb9d/T9Y4u393P1WsRoysbGA3u8A7lwxIq9xQ3iClxmVhZKWZuS
 cbLw7ZSAvrRYxV9H95fvVp/8fCI0sMtqYuiLgXDilMYH371JMQGs9ATsbvhcdwpKzjS8
 h1J6gPkYe8Ydj46BTB463VcaciphVFhDqJFYtgrAhbaGcoK4Ue5fZIVFItPIvmxYhRwn
 xlUA==
X-Gm-Message-State: AOJu0YzDqanc2BfiSK30bb0xciomffWc7w0DIxEa3diBKGZpBwx0Egps
 /TzltJDKfAZLDRa15LCW603OmTvqL67/0Yjs7HXI/QVxPAJXKAEp7buZAnRi5HM=
X-Google-Smtp-Source: AGHT+IGq66Dz2JejETkpcT/qvJke7O3wQP6s8jH/2fyarY/lfXK/73ru+h/6PuhhbWdjCpfn7lhQIw==
X-Received: by 2002:a05:6000:136d:b0:33a:e912:ce93 with SMTP id
 q13-20020a056000136d00b0033ae912ce93mr1301494wrz.31.1706623522072; 
 Tue, 30 Jan 2024 06:05:22 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:21 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:05:01 +0000
Subject: [PATCH v3 13/36] board: dragonboard410c: add chainloaded config
 fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-13-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=932;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=q5iT10pkx4AZVhF7WHgj9W1eiKI5SeJwStuj2jJovU0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTALNzTe+zDkY+vLSew9J1WlJHqXCr8Sz2WMr3rQu4
 Nvymft2RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIgg/Db/YjR7KPpKRm6GR4
 JngbnduZ2uW0uLpQnfl6xA6XFbr8RxgZZnes/hqy9JH5lFdcKiuK/VewpP4rdAqqnsb5qE+r+uM
 rdwA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add a config fragment for building U-Boot such that it can be
chainloaded by aboot/LK rather than being flashed directly to the aboot
partition.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/qualcomm/dragonboard410c/configs/chainloaded.config | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/qualcomm/dragonboard410c/configs/chainloaded.config b/board/qualcomm/dragonboard410c/configs/chainloaded.config
new file mode 100644
index 000000000000..3fd064924a1f
--- /dev/null
+++ b/board/qualcomm/dragonboard410c/configs/chainloaded.config
@@ -0,0 +1,7 @@
+# CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK is not set
+CONFIG_TEXT_BASE=0x0
+# CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR is not set
+# CONFIG_REMAKE_ELF is not set
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_INIT_SP_RELATIVE=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=524288

-- 
2.43.0

