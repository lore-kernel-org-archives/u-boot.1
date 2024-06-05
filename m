Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0223C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 14:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438BB882E6;
	Wed,  5 Jun 2024 16:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dARAqmP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D6A88361; Wed,  5 Jun 2024 16:06:00 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C4E88354
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 16:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jnhuang95@gmail.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-627f46fbe14so64770097b3.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717596357; x=1718201157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LNb4Eq0aj+Fb5y0tHoNWhdaAVXL77vi/3nFgdVxWYLw=;
 b=dARAqmP1rNDOxiEE2j/TEv6Moy8dzxYb028xgRN6TWHMD7JxGf+Mr+RhCr25Rvgr2f
 8+F/03OD1VuOXP3ohgVmgdu86nrk8BjCLsJVvgs1a/Oq5zAdHlICuCUJLWmcGHkPkjnn
 mrXLncqUPwD6tUY3dfmocbTQ01HQ63QkQnzh6vr5YNnybvANx9wTJQcAVovvIWBwu8h2
 m/2OJUnpsf4o/6BvP67lltacBLeAAdxiiLtEgWDE2X+s/UsbNG1evwkOTxbhGlOvMJRZ
 jCqquQlonZn/vSHlxZ6tYMG5ovhjIEvNLKVA6oly5Z+EIClK+uiRIF/0CSNCLmoX/kWv
 IYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717596357; x=1718201157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LNb4Eq0aj+Fb5y0tHoNWhdaAVXL77vi/3nFgdVxWYLw=;
 b=IxMDPQEqD3XDN6p+2/QjLcLrLbB8lxH+nc6kaLjfNFK9BGNKQiengSjqes4Yofjd2H
 q86xlHGsT8hN8pcrtnwxNH55stQ8hvI4u7oXy66NrNxMu1FEGWIo+zE2MY97ywK26fko
 uZNGK6epjNGe+aXN29uObf8dkoAw5+Qp7Hex737nuCVyfUkj7KC+/9IepS205yf6kkQ3
 azg4U0/W7XbRvucIxZQUQ1l5GASvDQYj69KqwFmrXjetUUhGTlSfm3XUoJLF/jCT3AcV
 ddXfDd0XEODfTwHBi/ViTXry+s+sFVO+7nR1VNzTVjWapYc5OynsxxlxUIbg+tvus+vo
 1WLw==
X-Gm-Message-State: AOJu0YxoKVeRC4pRxjzOOXPwidaJqmCE8LlPdtjLD+ntDqXMveN6Z450
 xYAnSRwrW2USZIER8fx3g1sI7OYKbWp6dHlVohUMMdmAJWBljT/18BN0Jcj8UB8P8w==
X-Google-Smtp-Source: AGHT+IHGIBKTjSky3iE0f5oIrBg0+lS+HOsqYKY7qnaUpo4nAElWK4/XrS/wglhSmrC1N3jlTPAlWA==
X-Received: by 2002:a81:9282:0:b0:61a:d86d:fad with SMTP id
 00721157ae682-62cbb5c4be1mr25110497b3.51.1717596356955; 
 Wed, 05 Jun 2024 07:05:56 -0700 (PDT)
Received: from localhost.members.linode.com ([2600:3c02::f03c:94ff:fefe:15fc])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-62c76603491sm22195157b3.62.2024.06.05.07.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:05:56 -0700 (PDT)
From: Jianan Huang <jnhuang95@gmail.com>
To: u-boot@lists.denx.de
Cc: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com,
 wjq.sec@gmail.com, Jianan Huang <jnhuang95@gmail.com>
Subject: [PATCH] fs/erofs: fix an overflow issue of unmapped extents
Date: Wed,  5 Jun 2024 14:05:54 +0000
Message-ID: <20240605140554.1883-1-jnhuang95@gmail.com>
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

Here the size should be `length - skip`, otherwise it could cause
the destination buffer overflow.

Reported-by: jianqiang wang <wjq.sec@gmail.com>
Fixes: 65cb73057b65 ("fs/erofs: add lz4 decompression support")
Signed-off-by: Jianan Huang <jnhuang95@gmail.com>
---
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index f4b21d7917..95b609d8ea 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -313,7 +313,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		}
 
 		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-			memset(buffer + end - offset, 0, length);
+			memset(buffer + end - offset, 0, length - skip);
 			end = map.m_la;
 			continue;
 		}
-- 
2.34.1

