Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D650BC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B7A83AA7;
	Wed, 28 May 2025 14:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PviBBAJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96AA083A9F; Wed, 28 May 2025 14:33:51 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F2898397A
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85e15dc8035so95347739f.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435627; x=1749040427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycd4JPbv19WE9yBkfx2ciZIM/lKWeqZcLdL9nc3fuWI=;
 b=PviBBAJncTEpdk+zOYW76tt8pQxZIiEVyVZVUenHQYaLO7qgGT7mUzv9bzwR9FsuUW
 AZ1piMwmQ9tpgdmViCjqWZ6DzDfhUQlxe9oC8ftt8SS+7C6pLkQZ7fjefR7UC8duLyS6
 zMo+G9g5nddd/0qo/2P+pMTqdO67LQB0lZtGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435627; x=1749040427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycd4JPbv19WE9yBkfx2ciZIM/lKWeqZcLdL9nc3fuWI=;
 b=E4N/wS1yeCKv9D5dTkabkBc74qUzAER2d7iiV/hTnXUYncgT8gJNUGnJsn89LKMQHZ
 EQIUmVd8+B7DtR71vPYDxfSG3LSJo9KFu69gJcGMWYmWn8ptqpnRgVfC0g6V0pzwv5ou
 zl0ojwpb8jmHihctmCSFCbjCDon3FeicVZFFUtdY/hxiY7zWdTdIENGrk4y3meAbXqcK
 v+rC4Y47wUG2HqCzhkAhXXBBw4eOQXVroLB6+xJoc9WRGVDUcSqUOFIGlevGZJeeHhz3
 4nFlFSckenJktJzozvhj1LYTs1H3h4gTRtV04y7NrcJd0GIpBmKA8mOEg+OoorwyUPCD
 kzRQ==
X-Gm-Message-State: AOJu0YzRQzEeFhO6nuhqIXDklAI3XEjydHetZK3j44JF5o+ZTkL8DSf1
 +bUY0b5VFWShW8F6DRkCFVkeRAD9Iacs3ohePf8wmzmIupRm1Jbf8XEcWPPJAjSSZrEFcp6d2Hs
 w6vfdUTTI
X-Gm-Gg: ASbGncsur3w+pqpI2de2/ezN8U7NV6Ykp6f7zDlFxlrE+pKfvd9OwahIAcEU4HSRbD1
 MT6hYSKdIzvfCRkMQ6FQcyiN7+kxDim5nWwMDXPY9KY1FLrQs3jVkI9f6f1yp0gYbYmz/O8v6Xi
 TQ8IOk/jkZgX9a93KqgaJHn2mSAjXKM7eLLjm1BhgevT+yVV6VbPvh+SQP7b7zfEu/G1zNNj6bN
 Fb4TU0uJZvxqjVrtwqBGD5rEq1As2+CX2xQEV7Bqnu2OxNnIK37uPEoc8O6VTnUWCaXaBt4b/nq
 T0grkqtWmIjDagPvOcdZq5tEYsnPcF7lnOrC8Tlf5AFylLKMWENKuM9psjJyawVcdhfuss5Hc59
 4islp1Kg64mKn
X-Google-Smtp-Source: AGHT+IEXojzEWmcIguaMY1XRs/soRM3+mIwvfCoXLOW2/ts204kzReFvK22CST+2FU/iG+P23NfkYg==
X-Received: by 2002:a05:6602:6a48:b0:85b:45c4:571e with SMTP id
 ca18e2360f4ac-86cbb88d402mr2296016639f.9.1748435627306; 
 Wed, 28 May 2025 05:33:47 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Harrison Mutai <harrison.mutai@arm.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>
Subject: [PATCH v5 16/25] vexpress_fvp: Update to use the new Kconfig options
Date: Wed, 28 May 2025 06:32:18 -0600
Message-ID: <20250528123236.1138632-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

We need to enable CONFIG_BLOBLIST_PASSAGE sand CONFIG_PASSAGE_IN so that
U-Boot is built with support for accepting an incoming standard passage.

Update the defconfig accordingly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Add new patch to update vexpress_fvp to use the new Kconfig options

 configs/vexpress_fvp_bloblist_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/vexpress_fvp_bloblist_defconfig b/configs/vexpress_fvp_bloblist_defconfig
index 4d52b96202b..fd5f91bc039 100644
--- a/configs/vexpress_fvp_bloblist_defconfig
+++ b/configs/vexpress_fvp_bloblist_defconfig
@@ -3,3 +3,5 @@
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_PASSAGE_MANDATORY=y
 CONFIG_BLOBLIST_SIZE_RELOC=0x10000
+CONFIG_BLOBLIST_PASSAGE=y
+CONFIG_PASSAGE_IN=y
-- 
2.43.0

