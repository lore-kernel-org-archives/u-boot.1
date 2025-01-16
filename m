Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2E7C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 340D68074B;
	Thu, 16 Jan 2025 02:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QrKhh14s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B31E980762; Thu, 16 Jan 2025 02:27:52 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB1380214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844e06e5d11so13598239f.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990868; x=1737595668; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8K8AHM0DrNcd4vG043RfLe7hQvm96jQYKNV4G3MPVnk=;
 b=QrKhh14sFEjaXZtd553HzG5+GtnOa8qwaAQ4MetkKW8mnyQ09IK90S6vI6fKx6Tmdb
 8TuPnwGPxo4FiNBhRWorLqP3aQRQeubxWXd59V+TcKS/OMs8Yz1gsvdnqU3MkKi/4NVl
 /DTR9Ww6ZmcjfmUZ4X2N0MWs/h2O0S7mELB7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990868; x=1737595668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8K8AHM0DrNcd4vG043RfLe7hQvm96jQYKNV4G3MPVnk=;
 b=MpCj2c0wkzikqYYc7hh//2UuK00NZ9Q13dPfrMPDDELvZC6203ALaqnqBOCl2cW96p
 GbjalB/xbQNRBgkyJ0acVxCM6UYavSbJNQmOezsFt5a5vfBCPWjohdZZKjG1ErQUvEq/
 AappvZDMrLrJlj3H/Ac+B+/dglqLPsOr/WyiCEOtp1QVNNOliv99wYQKrqMaIJKd7jUu
 kZG2/QP7ohFFKD1Yh6rLWlDLWGLCgexbcgG5BxJl2jBCsg30nRR5dgZhp1sRRZNGEPsy
 +SQaDGIv580wXdkDUR11q7XSSwePF0/LFDmUjnLEhmkuEX4X5DGjbVs8Y/D8PdsTdB4z
 9Ueg==
X-Gm-Message-State: AOJu0YwjqUyRzHPjqMZPXagj4H8n9LBpukmZ/BpFKLoCJJMsgQUNgyeW
 cdo+ZELCcMtH5Yg5ltdI9UxyIhrm447r4o+OyE8Z3pdm8YbZVfGj1SlVdNheKNLc61+JxeRubUw
 =
X-Gm-Gg: ASbGncszJntl5dx5hO3JRuXMri9J7AB6RrVjQBr4fIdw/ozTjt6SrrJQZcO1MySjqKs
 8oLOqOfjA9GN0L1uYgwc6/lurPuKpVDM/WMa5RpnGAc22dUVGAbkpYOPLTZM51Y3PL97OHP6I/O
 g7envsJ61pLK6Hx3rj0UrJR7vXdqvaLV8qiHZsF8WlvxjvIMhgZCQAaHlQP1qJ5djnuEsXgclw3
 vhj+xCoIpuH3x5FNqfPiHIvWYOKCJkbmlTpCDsoFhz7GvLWrB5zdHwSTqxUUBrcqWjeiEpzeXfw
 TTrIgj3N2Ed+tkqcEg==
X-Google-Smtp-Source: AGHT+IEFdM6x2WhdDyV44Pa5hvjLsoGgTbshk32JJMgOMd+0cseiBcuSI7QrPGqvtEmHn0xHmvYrUg==
X-Received: by 2002:a05:6e02:1687:b0:3a7:85ee:fa78 with SMTP id
 e9e14a558f8ab-3ce3a9c190dmr260583405ab.18.1736990868303; 
 Wed, 15 Jan 2025 17:27:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:27:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 05/22] vbe: Convert some checks to assertions
Date: Wed, 15 Jan 2025 18:27:06 -0700
Message-Id: <20250116012723.2820301-6-sjg@chromium.org>
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

VBE is currently quite careful with function arguments because it is
used in VPL which cannot be updated after manufacture. Bugs can cause
security holes.

Unfortunately this adds to code size.

In several cases we are reading values from a devicetree which is part
of U-Boot (or at least VPL) and so known to be good. Also, in several
places, getting bad values does not matter.

So change a few checks to assert() to reduce code size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to convert some checks to assertions

 boot/vbe_simple.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/boot/vbe_simple.c b/boot/vbe_simple.c
index b6f0a49c584..af16bdd34a3 100644
--- a/boot/vbe_simple.c
+++ b/boot/vbe_simple.c
@@ -27,12 +27,17 @@ static int simple_read_version(const struct simple_priv *priv,
 {
 	int start;
 
-	if (priv->version_size > MMC_MAX_BLOCK_LEN)
-		return log_msg_ret("ver", -E2BIG);
+	/* we can use an assert() here since we already read only one block */
+	assert(priv->version_size <= MMC_MAX_BLOCK_LEN);
 
 	start = priv->area_start + priv->version_offset;
-	if (start & (MMC_MAX_BLOCK_LEN - 1))
-		return log_msg_ret("get", -EBADF);
+
+	/*
+	 * we can use an assert() here since reading the wrong block will just
+	 * cause an invalid version-string to be (safely) read
+	 */
+	assert(!(start & (MMC_MAX_BLOCK_LEN - 1)));
+
 	start /= MMC_MAX_BLOCK_LEN;
 
 	if (blk_read(blk, start, 1, buf) != 1)
@@ -51,12 +56,21 @@ static int simple_read_nvdata(const struct simple_priv *priv,
 	const struct vbe_nvdata *nvd;
 	int start;
 
-	if (priv->state_size > MMC_MAX_BLOCK_LEN)
-		return log_msg_ret("state", -E2BIG);
+	/* we can use an assert() here since we already read only one block */
+	assert(priv->state_size <= MMC_MAX_BLOCK_LEN);
 
 	start = priv->area_start + priv->state_offset;
-	if (start & (MMC_MAX_BLOCK_LEN - 1))
-		return log_msg_ret("get", -EBADF);
+
+	/*
+	 * We can use an assert() here since reading the wrong block will just
+	 * cause invalid state to be (safely) read. If the crc passes, then we
+	 * obtain invalid state and it will likely cause booting to fail.
+	 *
+	 * VBE relies on valid values being in U-Boot's devicetree, so this
+	 * should not every be wrong on a production device.
+	 */
+	assert(!(start & (MMC_MAX_BLOCK_LEN - 1)));
+
 	start /= MMC_MAX_BLOCK_LEN;
 
 	if (blk_read(blk, start, 1, buf) != 1)
@@ -67,7 +81,7 @@ static int simple_read_nvdata(const struct simple_priv *priv,
 	if (hdr_ver != NVD_HDR_VER_CUR)
 		return log_msg_ret("hdr", -EPERM);
 	size = 1 << hdr_size;
-	if (size > sizeof(*nvd))
+	if (!size || size > sizeof(*nvd))
 		return log_msg_ret("sz", -ENOEXEC);
 
 	crc = crc8(0, buf + 1, size - 1);
-- 
2.34.1

