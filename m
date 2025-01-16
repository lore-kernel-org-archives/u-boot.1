Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4F6C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA58B806D8;
	Thu, 16 Jan 2025 02:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FfH8A0iM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7421080214; Thu, 16 Jan 2025 02:27:49 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42CAC806FE
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-844cd85f5ebso34527239f.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990865; x=1737595665; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ux2WFEVOzxZks7v5PEWtGWN2RF8jUBJrt034yzxkiak=;
 b=FfH8A0iM0iaUcrRuhonQz/RPQXdjfnbBTJJ8JTf2jGkxg/7YNRQv5CMzKKnX0K+CTq
 ubPKMwqgWwEpqkfRoycPnXTZjvTpCwJDuzIW6i+lhB+H0O1h2u15AUU8gjU9rIkBe3uA
 LdmNnbTdThib/RtBo3dnHcXkFEfO0paMev920=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990865; x=1737595665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ux2WFEVOzxZks7v5PEWtGWN2RF8jUBJrt034yzxkiak=;
 b=ehuMwc9BKH54KENacCscpaFNFafH1WCZJt5hKX0htu1uXKFbjrxDjwJsUjF4Bfj6YU
 xFwE86YEBa3yaECu2+gvtfe2XMMO3vVxOQiLvpGVMBQdQ0Jc0pLOr/nrzkULTPlL2O8B
 N82nzlUX1SGUiyq19SfvBCdqedUN3UhKjDUlz+p3F09+mHV2falmLiZs9a3Pwzgbaoe3
 W/kcy7OX55RWhGzBiOaQiU3+0F2oIpLxEak5PRpbjNzjNNgZD7n1cgRuMrM3KL8NQQdp
 MJomrCOhsZGKs/PnTLXaUKnUwKRlU+hpcQu9qHgAsUgQDjgNpQhz1oVKyO5aNrtSTP2U
 0WiQ==
X-Gm-Message-State: AOJu0YzfKSLut7kPskGzsZwKYfaYC0/WtlPWUsN7+qEs/eOfKLu5p/Bn
 AF9RLZ2UV7a4UVB+0fDtqbppLgZMDkT+irUwsFC4kSQCuPv2bQy7dlUZYbGOlFVAiabCNdPUUmE
 =
X-Gm-Gg: ASbGnctL2UwDYzPSESEl/0l6HGI8NG58CPEp/Fbn5Wq9s3d5zi2YJEH25jJSkVqr1KM
 IpV+QaAqc6ZQtIHvfsHfnJfu4i/fuQ2sNqwxq2p+pTivHM/e8Op2hiuhWVUwsVJy4xcTK1M4xOE
 YdrrN/tJI9Y5gdX4phF0dpRAojxSPBfkp2uS7VRxNLcAMgaZCYGb1hWJEEnICK2G9PliiyP51xo
 OKkKAUpm6ZJwJkZpXgjQ+kuBl3tid2Wvvb6eS3QsQVlSP0BOYx3hj/PAegV1eAaphGYxXctN4Kq
 r+9SwYzAItdJtZTzPA==
X-Google-Smtp-Source: AGHT+IGvNlUQRWnOH/vjPAl9/GjF0QU6UcfFNVqzZ/vwOtgLpCPZQ9MVsMEOacruArjpDtbrltdB8g==
X-Received: by 2002:a92:c248:0:b0:3ce:9082:43db with SMTP id
 e9e14a558f8ab-3ce90824712mr27340565ab.7.1736990865485; 
 Wed, 15 Jan 2025 17:27:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:27:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 04/22] vbe: Pass simple_priv to internal functions
Date: Wed, 15 Jan 2025 18:27:05 -0700
Message-Id: <20250116012723.2820301-5-sjg@chromium.org>
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

Pass the private data instead of the device, to help the compiler
optimise better. This saves 16 bytes of code on pinecube (rk3288)

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/vbe_simple.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/boot/vbe_simple.c b/boot/vbe_simple.c
index fb971cc0632..b6f0a49c584 100644
--- a/boot/vbe_simple.c
+++ b/boot/vbe_simple.c
@@ -21,10 +21,10 @@
 #include <u-boot/crc.h>
 #include "vbe_simple.h"
 
-static int simple_read_version(struct udevice *dev, struct udevice *blk,
-			       u8 *buf, struct simple_state *state)
+static int simple_read_version(const struct simple_priv *priv,
+			       struct udevice *blk, u8 *buf,
+			       struct simple_state *state)
 {
-	struct simple_priv *priv = dev_get_priv(dev);
 	int start;
 
 	if (priv->version_size > MMC_MAX_BLOCK_LEN)
@@ -43,10 +43,10 @@ static int simple_read_version(struct udevice *dev, struct udevice *blk,
 	return 0;
 }
 
-static int simple_read_nvdata(struct udevice *dev, struct udevice *blk,
-			      u8 *buf, struct simple_state *state)
+static int simple_read_nvdata(const struct simple_priv *priv,
+			      struct udevice *blk, u8 *buf,
+			      struct simple_state *state)
 {
-	struct simple_priv *priv = dev_get_priv(dev);
 	uint hdr_ver, hdr_size, size, crc;
 	const struct vbe_nvdata *nvd;
 	int start;
@@ -106,11 +106,11 @@ int vbe_simple_read_state(struct udevice *dev, struct simple_state *state)
 		return log_msg_ret("get", -ENXIO);
 
 	blk = desc->bdev;
-	ret = simple_read_version(dev, blk, buf, state);
+	ret = simple_read_version(priv, blk, buf, state);
 	if (ret)
 		return log_msg_ret("ver", ret);
 
-	ret = simple_read_nvdata(dev, blk, buf, state);
+	ret = simple_read_nvdata(priv, blk, buf, state);
 	if (ret)
 		return log_msg_ret("nvd", ret);
 
-- 
2.34.1

