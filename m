Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BBDCF9C6F
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 08:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6350488C91;
	Mon, 23 Sep 2024 10:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="H16j9ZL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E7E688CE5; Mon, 23 Sep 2024 10:21:15 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 357EC88CBF
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 10:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so39300125e9.0
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1727079672; x=1727684472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npKVm6Cpb6AebMhtkw7aDE3QX6u4AgqVhULd3crDr84=;
 b=H16j9ZL2kVX9z10EsZqlCJhRfAftbc4olObybl4j8rL0XMIfEGdbk72jGI7yeFXDtI
 bGjIx2lps6Zla4yjFU7N03WkGJJqUWCs528rvFDPvVsQWhsQDVFIxERO7we2W2DNPWXN
 42kOrR5glk4PJQ0Gt6LZpKnjNT1xr3KjX8q4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727079672; x=1727684472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npKVm6Cpb6AebMhtkw7aDE3QX6u4AgqVhULd3crDr84=;
 b=au8dxtYoVSVr7ZC1R6GRruXmp0DFAX9nrjUJ7hE1pmSG+xw7gHl9ZjquwfsEPzSQgN
 EAzvBfd8B7R8owXe0t1AaUwJR/lAOM1ZOo2/xWbgD852R4aazPeal82+Oso4RmHOxEz7
 IHFijv6mwEVTvxKOwmeA5NVmIUrHObJDH2hER8ZYLyP7V0On0GO3WqAkQSUBZG9MWvZf
 pBGWsdESC58F4BH3B4hkWl4+TLgxX3HP3mMVU/8yk1dA1gv58i5mp0TfwXr37Hi95UpN
 FepdgxGsVfAmNkOQ+VfolpxOCowGFdwydG4bjKDeKDrTLy6tinCorR3g95N1Q0aRZz1M
 njyg==
X-Gm-Message-State: AOJu0YxGueZAxd4xKX80lGzzZKHN0XZ3PwCkKjHgfQwiq4SxqdeMdATh
 JPxhsmI+QKQpkB90TgMhpIfSNbCGkQAs1CwjWUZVKUvfng/bjo5OT2KQhKjZ5jPoU/f7QzDl+rI
 x
X-Google-Smtp-Source: AGHT+IGnS0i4d6hXUZoa08hfwx7+Kwu3GFnlZz7iPvy8DdmDsmuFVaGM6ecOQpyhYAPBBjZkmJsNMg==
X-Received: by 2002:adf:f987:0:b0:374:c69c:2273 with SMTP id
 ffacd0b85a97d-37a4318a3bcmr5251684f8f.37.1727079672585; 
 Mon, 23 Sep 2024 01:21:12 -0700 (PDT)
Received: from P-NTS-Evian.home
 (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr.
 [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e78052e4sm23674922f8f.102.2024.09.23.01.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 01:21:12 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: Alexey.Brodkin@synopsys.com,
	Romain Naour <romain.naour@smile.fr>
Subject: [PATCH 1/1] net: ksz9477: add KSZ9896 switch support
Date: Mon, 23 Sep 2024 10:21:07 +0200
Message-ID: <20240923082107.16797-2-romain.naour@smile.fr>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240923082107.16797-1-romain.naour@smile.fr>
References: <20240923082107.16797-1-romain.naour@smile.fr>
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

Add support for the KSZ9896 6-port Gigabit Ethernet Switch to the
ksz9477 driver.

The KSZ9896 is similar to KSZ9897 but has only one configurable
MII/RMII/RGMII/GMII cpu port.

Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 drivers/net/ksz9477.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ksz9477.c b/drivers/net/ksz9477.c
index 43baa699619..42befb1af07 100644
--- a/drivers/net/ksz9477.c
+++ b/drivers/net/ksz9477.c
@@ -543,6 +543,9 @@ static int ksz_i2c_probe(struct udevice *dev)
 	case 0x00956700:
 		puts("KSZ9567R: ");
 		break;
+	case 0x00989600:
+		puts("KSZ9896C: ");
+		break;
 	case 0x00989700:
 		puts("KSZ9897S: ");
 		break;
-- 
2.45.0

