Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50206C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F00480702;
	Thu, 16 Jan 2025 02:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="If/UyYBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D71C80702; Thu, 16 Jan 2025 02:27:41 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CF7D80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a81324bbdcso2980315ab.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990857; x=1737595657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZO7Xw98GtEV/wUONErdTvUTU/o1F8QHjOB/Le6J/z8=;
 b=If/UyYBHu3wDN0gQJHfMmGE3OyC3laoyBfUjqi70o/q8fLOrOho1qn+H8IjXcOwXQO
 c346Jore6wIy9zG9RCi3YTFry0Jy1b9xcl+WFEsTzX/PMH75wvX9Lx01UmMUBVj+gYBw
 TPZfI/230WfOvxjivSvI0411BonMlH1AvIHe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990857; x=1737595657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZO7Xw98GtEV/wUONErdTvUTU/o1F8QHjOB/Le6J/z8=;
 b=JCMsel4nPYqeHPcrsi1kTOFNuJh2VLxKucoYvZ03Uz/NfTqEmvpRkZLpd5JEZH2Kki
 o7LVeT2nlw63CDA5V0PixeHy9HyWQtUb8hmujD4YkkWwE4iZSEWsywDNABm6mEyNKPCz
 gB0S+qmEcQjfw7E+QsDj7qXj+8d+tG4d56H4TxpPMo7iImvGhHHfqaeAL8u833fIhL/z
 1RADD1wPcvEb/rVu8G23db96TmVkDynrx9MKp1cQRL03kn5qd3JAa+q73MlE/XcOPEKy
 0P6FVKa51p8BITFU4yrvLPNqC2mfcvg7FZCnnXsHP6qanQqA3Y9Z+MD8O90ejYEdOS+o
 Zdcw==
X-Gm-Message-State: AOJu0YxRArdCfWbPRU3nfuf9ZVMwG/PtzwJXgIy+BUZCUE7cDJL3GqVT
 Pnj4ctDzhh6yOWbmbcaN4UFORpwSU/ZfU7CMsGbDWQ/Ri1bHFol3waKaXdLkHh93aDO3rQQLeqs
 =
X-Gm-Gg: ASbGnctIP40dHHGIhhek/1RbA9wWERpc4Zv2Itjk5xnMGGG2AchogZDJMyFoTHxsvfE
 kVUINnjypKfJhwdTwXMVp93CRPTIGDk8KieJrNfspE7jdXmvnl1JYjQfXbQwnyy20fB673kMYgi
 pFt9edA+NeR3haZZYbaVWXxjKDHM7Mp+n9klynbS0AMpcLXZ61Nd2gnP0n+/x84IKDm2+LW1E5/
 cRXLYLcH9JxG4Zb+BoOyEX4015IPd8owB41ZoXOiEIvYDZyDLEuzrHKE6tSl1jv3HuaaIZgnACz
 KTy1wYx20D+Icem0Xw==
X-Google-Smtp-Source: AGHT+IHTEVz12DHmjfxH5mtGQ01H+ULLiLH68cXEDaqOeFRZ0WPBqhZo7dFaHf4IdopPKPedFy9NpA==
X-Received: by 2002:a05:6e02:19c6:b0:3a7:81a4:a54d with SMTP id
 e9e14a558f8ab-3ce3aa7c305mr274870165ab.20.1736990856802; 
 Wed, 15 Jan 2025 17:27:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:27:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 01/22] vbe: Use blk_read() to read blocks
Date: Wed, 15 Jan 2025 18:27:02 -0700
Message-Id: <20250116012723.2820301-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
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

We should not be using the old blk_d...() interface, is only there to
aid migration to driver model.

Move to blk_read() instead.

Changes in v2:
- Split patch into several pieces

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/vbe_simple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/vbe_simple.c b/boot/vbe_simple.c
index ed7b9598e38..f260e9b731d 100644
--- a/boot/vbe_simple.c
+++ b/boot/vbe_simple.c
@@ -44,7 +44,7 @@ static int simple_read_version(struct udevice *dev, struct blk_desc *desc,
 		return log_msg_ret("get", -EBADF);
 	start /= MMC_MAX_BLOCK_LEN;
 
-	if (blk_dread(desc, start, 1, buf) != 1)
+	if (blk_read(desc->bdev, start, 1, buf) != 1)
 		return log_msg_ret("read", -EIO);
 	strlcpy(state->fw_version, buf, MAX_VERSION_LEN);
 	log_debug("version=%s\n", state->fw_version);
@@ -68,7 +68,7 @@ static int simple_read_nvdata(struct udevice *dev, struct blk_desc *desc,
 		return log_msg_ret("get", -EBADF);
 	start /= MMC_MAX_BLOCK_LEN;
 
-	if (blk_dread(desc, start, 1, buf) != 1)
+	if (blk_read(desc->bdev, start, 1, buf) != 1)
 		return log_msg_ret("read", -EIO);
 	nvd = (struct simple_nvdata *)buf;
 	hdr_ver = (nvd->hdr & NVD_HDR_VER_MASK) >> NVD_HDR_VER_SHIFT;
-- 
2.34.1

