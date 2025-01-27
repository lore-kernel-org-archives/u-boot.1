Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ADAC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 552B3814BD;
	Mon, 27 Jan 2025 15:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jCBdg6Ys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B398B81276; Mon, 27 Jan 2025 15:59:36 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76F44814BD
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4678cd314b6so45268711cf.3
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 06:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737989973; x=1738594773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bCLzryqQrR4h4cHjRdsIMnMfE7NUz+j3EKKlysZc/Q=;
 b=jCBdg6Yskeu1TnbXlA/ciXuZpJtOO670BRy5ZzmJcrPBCs3M2WRgOYq0jIssP9+MoJ
 u4xJ8fhkhTaa0Rq8SB8OIWLtrqu1O5FSdIZv84FeDlR5K3t2LmYHxfx4Hu0un5JWhPE6
 txBdZ2Le0Hse6H2Z1BoiFki1xkhS5xR7x/U4UWx2q3STC9bJOwqPa1Xyj2wS08Oh7p6d
 mBQYyjzHJU64sPYLP163QgYQNC1CZFXzX1h3Qscr+v9xlKC8h+egxnQovOQOf55OS8s7
 1cgxmUzWsFHYwcTk5T2HW3KHqOGf2q0vdR//oQUai67CfbF0PC1+9ERu5RwNJYwqEbQk
 wljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737989973; x=1738594773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3bCLzryqQrR4h4cHjRdsIMnMfE7NUz+j3EKKlysZc/Q=;
 b=b9YcYIQuI8163Bnxkeme8KQ0I35HclBw64x8ztLwF9zBRLBE6zDncE29ASm8jy6FoP
 tlsG9gOjxsorJpglY6/1V0yw4V86c/faSd9Vq20ykIkgr1Rq2fv8SK8cpQuCOmZslxQp
 70JSnXeXLnqgGo2ZRoiYrUScPiZdK6sNa1RWIGhH8q8OLeNXLTRNbJbJkOe0grJdPqBR
 tgs2zqm5HKv8+Bs3T8/J1G+wvSEbRQQRlFTG0sKmUOMpL0sPzm4IYeQGPwBRVgZ/j/US
 1AoaSl+LKZsVgC3oUGpHAhIiWULwq9dENR/cxLiVOls3Uh6AJZtY0hpLJ9JccgdMPDmm
 zJtQ==
X-Gm-Message-State: AOJu0YzjspRSrokPed/NzKhcf6LSh7arog6N42ufqCeJJxYV3BdWvjz0
 ovh9whO29f4YIOWIqJMJ7F9vyEqHpnsvt6/uUZVT4i6o2CwntlRjI6UUvE11tE9IG3dQf6LOjzr
 uo0w=
X-Gm-Gg: ASbGncu4AV9cxg6hcIYai+/PRBGOVSVCjYyO54jKe04LacwG+9xLIvbTe+vuL0qO0js
 rgJNd8zirEV0iqSWVLouU+TCNhk0Oe0IxA8ZI5z/S8pcNiy72IL/ANk1q7N6nfMisGpSVFUBZ48
 qwDhgJweYt0kN6ZCFBtsy2vO7HgBTLjVaAdoIZc6Xi56KyRBE13gnJi7k42QOBtwUS/N/MvlKlG
 r4s4eA54eioYBm3zHsYXg4dMb+qhyyvdbq/OshCqsXdQcSFSq/VGpK94drE75mMUmfpaQ4jP2eh
 1WcXyuy2rcgd+0RTmPejIxYVtC4mi9rTlk1EU6LjbiSt4LfxDdFSqbbIyW29v5NsacDDzi4QdZ/
 W99s=
X-Google-Smtp-Source: AGHT+IFywjixo+JVTEFaLecmE2CVIXLdppaYnRZSfthbmW/7/QLSAYRelQ8P6TSw4aj+xvGSW5nBDg==
X-Received: by 2002:a05:622a:180c:b0:467:67db:ef72 with SMTP id
 d75a77b69052e-46e12b7197cmr641271991cf.27.1737989972963; 
 Mon, 27 Jan 2025 06:59:32 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6689d9cbsm40945951cf.41.2025.01.27.06.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 06:59:32 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v3 5/6] tpm: PCR allocate during PCR extend to disable the
 unsupported algorithms
Date: Mon, 27 Jan 2025 06:58:50 -0800
Message-Id: <20250127145855.645845-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127145855.645845-1-raymond.mao@linaro.org>
References: <20250127145855.645845-1-raymond.mao@linaro.org>
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

During PCR extend process, if any unsupported algorithms are active,
try to use PCR allocate to inactivate them.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
changes in v2
- None.
changes in v3
- None.

 lib/tpm-v2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index aa02a9e961..9ca7933c09 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -344,7 +344,10 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
 
 	if (!tpm2_check_active_banks(dev)) {
 		log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
-		return -EINVAL;
+
+		ret = tpm2_pcr_allocate(dev, 0);
+		if (ret)
+			return -EINVAL;
 	}
 	/*
 	 * Fill the command structure starting from the first buffer:
-- 
2.25.1

