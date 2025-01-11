Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D95E7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7BDC8036B;
	Sat, 11 Jan 2025 01:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SlShJuAt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC7380050; Sat, 11 Jan 2025 01:01:30 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 750F980657
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844d5444b3dso88929939f.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553687; x=1737158487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uz1c4jtmHbi+h1cFofboMYvpArtFhRwLFbTXKj64Qh0=;
 b=SlShJuAt2+QX3sTaCB86HwZvTawN6FcXWFBWY3dOHAKAwxr2keUSlyq1PTV/94wLZe
 gl4ChQ+SD5r7tcsMJIQ3IrIgpVXSJqgF1xpcMcXypSus3Mvh+9OdmViBnWT89eg6ny5l
 YKyFnkFVbjfIKzzDV9TCqKCBfDaK0aI9CYeOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553687; x=1737158487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uz1c4jtmHbi+h1cFofboMYvpArtFhRwLFbTXKj64Qh0=;
 b=s1bsWAniV1lxcYFoW5xbLLJqmeA5ZrfkBDCBm7G73XazQvA3XSsauPYLgVW2yQrqRj
 3kN9oPKX6jMoWSWoLZoJJdpz1kzBz9iKd6bsKfjXAbdKykiFArCQWwKWxo6Ltnng5ITt
 TJVshgMjnqRpRXclDi34btjSChTpyEQbDy+NYgWh7GBMC+Qc3sT2dk1LhPvZMSpKS16I
 tdPHDrx1rwvyWx5Te3zw6hR8m7im9Ce3rgCG1HP3ybykr5k1pUgjGcYTydIdtAPkCXD8
 0Aws9fvNvBIPSWA3HlnFGMs1SXzPmQHIizB7FzkMYFRAo9pvAeRJ0rUY6MBsD8VYUDPb
 +1sg==
X-Gm-Message-State: AOJu0YyjY7Vamoz71r/RPPVhokLAfWiUjQ1LgeQ72AkkPyL4rk3kZUDN
 tQ7qxgrbL+75sW6YbEHdB/qvveTnF2q9NYG8KFRazlnG6JLHtZJKFW0ZHDTUc8nXZWiZCYc0xkg
 =
X-Gm-Gg: ASbGncurSdWnek39mSEk8L5dLTNt3IVNCZoI7H13aqNZ8HMzwmAvxqfDJjIF+JJJLsk
 AWVqPQNffpg4VzqT+pq+hCpN5kXr5L0LfzNxxS3aTKO5ZAjrmYlB8WwfrFnBrI5VrsulAcO3eOF
 +MGbrFLuAvzCkCQ15DL70Hrq4bHB+Z/QFUSBoBxZfhZ5bT3ZXu0lp0avvy5bwA1IHvmJ6kOGaQK
 eZDHgtwWhhVaTLAHR2pCif3HnwNp7/spMFYiqk7IhQ0a3o9d/5Rvt8ys7YHj+QQ8fQzLyUQt0bG
 AqwPP794G5KJ/uZ/fA==
X-Google-Smtp-Source: AGHT+IHi/G95GhUpOBNVH6onogAMP8bVFZRiFysz0DR4G4rx2k0LxMVnZdmAPxxduEHCB43FDBSz9g==
X-Received: by 2002:a05:6602:4297:b0:841:ab27:acac with SMTP id
 ca18e2360f4ac-84cebeb9909mr665851239f.2.1736553686717; 
 Fri, 10 Jan 2025 16:01:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 17/30] emulation: fdt: Relax condition for
 OF_HAS_PRIOR_STAGE
Date: Fri, 10 Jan 2025 17:00:16 -0700
Message-Id: <20250111000029.245022-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

QEMU always gets its devicetree from the OF_BOARD mechanism so we should
not depend on !BLOBLIST here.

It's not clear why we need to have any relationship with BLOBLIST so
let's remove the entire condition.

The logic of PRIOR_STAGE is quite a mess, unfortuantely. We should rely
only standard passage to receive things from the prior stage. QEMU
should implement standard passage to provide its devicetree to U-Boot
However Linaro has blocked my patch to provide devicetree additions[1],
so little breath should be held in respect of either change.

[1] https://lore.kernel.org/qemu-devel/20210926183410.256484-1-sjg@chromium.org/

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 2b71470628c dts: OF_HAS_PRIOR_STAGE should depend on !BLOBLIST
---

Changes in v3:
- Drop entire condition

 dts/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index 41a758e83a6..2e88d210bb8 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -191,7 +191,6 @@ config OF_BOARD
 
 config OF_HAS_PRIOR_STAGE
 	bool
-	depends on !BLOBLIST
 	help
 	  Indicates that a prior stage of the firmware (before U-Boot proper)
 	  makes use of device tree and this board normally boots with that prior
-- 
2.34.1

