Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3879BF433C8
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 21:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 883D5840AB;
	Wed, 15 Apr 2026 23:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="paEPfRFo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A50AF84105; Wed, 15 Apr 2026 23:21:45 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6525783B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 23:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E8CD13F7D9
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 21:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776288102;
 bh=Xw5mhYPrimQh/LGUkvcKTME9zaL2+LOQ5mIeLggtQHk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=paEPfRFoeDxqXngjvP+C0i+/DCOzuA50djrfBQg8rxjq9lxVBN4WbXauCuc/a+dNO
 JR52H9HMIb45pLdJUDId3J11/wIu+H5pWgvVW0tnZl6fcu69cq6KX1PEgJkEgqSit/
 LDfPq7BuWYmGIrlk6SoIcYvWfakfXRVAQt+p4fszGfPKcHcZNXrKl8DKVk3xa4DZNN
 T2Ez7RTWrQF0v95YKaHSzhc0dC/SlMg33nRJZST2Nc7Oh2iTvtQtguG34/9MsrBP9T
 qTGJTcNEp7Qko0FCWRpd3sK5fZTPRc8yRfLaRlb4fYFy+HdlcNZdkVjZy/3biUD5IS
 YoFyKOOgPWSqAsEmXUmKqQ0URKqyx1PDqhXN8cOO+QkZ34tpdmfTR9gckHglav/tPc
 HzkcnfkhTymi6afWbfANxt0kGLO4EwHbOTfF0ORmn7wG4BbNsyUQTxw2Uh3HqSxr8e
 MWm/H1K60T/QgS9Nb9XEC2zNtLt5uH4cuQ3Qb+j7Yl3oksbSRESUEc6GH4HzFmXhXJ
 V1equbllnEkPi/m3KMi6/ZxU6qynSbpGu+ycJ17ZhZA9BJ0UZOM6KZP34R3ajg7gUe
 3pr76WiwcXceAToJ951bOUp+Wn07+sYSsHoWQGdEblwbuR//QhaT+d35NPfBlZWZhS
 /lFoISBZy4w4Kt7kEfuql+/s=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d177fb157so7050010f8f.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 14:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776288102; x=1776892902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xw5mhYPrimQh/LGUkvcKTME9zaL2+LOQ5mIeLggtQHk=;
 b=rSr1mRwJfWiAznHuW9yl/rnmaYqA+dkRdKXaj1m48r4HyU9uF+sPT4JXc4/BXC9G3f
 LLX5I5FBsVBWRX4rfRkOfVo6M7O5D52OEjVlcB9JHLeMFiv/e/hm2YzvponljIuQQO2g
 dZQ0pGMlEVv4QnLhayqO/Mp7HbFJq9L7mzDsDCx5fcJeWMzKnkYEiV6b1YVzM8DhcXY6
 BizlxxjvpP0h4cvGsww4QsPdikhu2DST/ASgIUp+Hk3VWf9O8QgHJCagqmegyXlCMafI
 /nw51Hls0CQrU5RaSvu8GmZ/4H85zHn1aF1kNfexsRDOIUYJhgJsEoAaQ3bvN7yNElZl
 h77w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/d3qML5zeyIEs8CiFD3895QMVTHvanQvBceFA8GcJLgw0mbdaKaIxxadVrQG6dlsonWiNZedA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzzoixa5EF3g/T8XIVVaCkeUUuOQj7EdS2DqXpvkSY3w+NQ3+xN
 cggTCHeX9A999JqSwQIgksNO1ND6DL0rtC6ClXz1ikenNTfOyLmagL88oA/IuIyLmhavz6kaBhP
 LNJpsr0bCP0ONaVdWBsmewjbRMguvwX7uFGQBvoIaJ8J+pwGy7VyR2f4jZmFFfsSig827KZw=
X-Gm-Gg: AeBDietHZHUUrc6HshF4pEABJO49VXjA/VbVSFygHZwHQ9V7VBaGTXFot2GwSBNLV7D
 AUjfVpA+oyFCdBAr+oVyKpWb0auJmYM6IxJ/LLAKfViitk8ADgVaCqd7X22++YuwJWl/EF80gqf
 gkRxbMi8u+w8gwTDALk4LQTzg1yJke7Xk+oC17EWPkydgj0E2pFu9n3lJR82pJvq7GYAZSumVx9
 7b7OFkeaBZvUdimOQ+Losuymb1aTt5aINjxQLtPHlNmqowiIWk/MegmtG2tv4Octqlr8ky5N7Mc
 kpfPMQIL7oO5CGWTXvNnTOxlwgs5KL6+1BZRDJUNGK4QS8PGm2d/hiNKLtWjVPdSAdbiKH3atH4
 wH21D0mFxQkAHFkYDGhaSI8jllN3JtAxIoyBLBkBOgAfJ0OtHoVpRtRdKajccFepZYivQCCZczs
 VYgYG2vcce4vNjvsvKrGU1FK2ICetnQPw2MpKtaaY3ia6BNxkOtJaaxNkE7bHE
X-Received: by 2002:a05:600c:19d1:b0:488:c282:e77e with SMTP id
 5b1f17b1804b1-488d688608emr300761765e9.28.1776288102422; 
 Wed, 15 Apr 2026 14:21:42 -0700 (PDT)
X-Received: by 2002:a05:600c:19d1:b0:488:c282:e77e with SMTP id
 5b1f17b1804b1-488d688608emr300761455e9.28.1776288101990; 
 Wed, 15 Apr 2026 14:21:41 -0700 (PDT)
Received: from workstation5 (ip-176-199-115-125.um44.pools.vodafone-ip.de.
 [176.199.115.125]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f1e87e93sm90744115e9.11.2026.04.15.14.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 14:21:41 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sunxi: use vendor prefix for $fdtfile on RISC-V too
Date: Wed, 15 Apr 2026 23:21:36 +0200
Message-ID: <20260415212136.320419-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

Once we complete the support for RISC-V Allwinner D1 (sun20i), we will need
to prefix $fdtfile with the vendor prefix to match the Linux device-tree
directory structure.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
Some work on sun20i in https://github.com/smaeul/u-boot/tree/d1-wip still
needs to be ported to upstream.
---
 include/configs/sunxi-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-common.h
index b29a25d5617..49d5617f028 100644
--- a/include/configs/sunxi-common.h
+++ b/include/configs/sunxi-common.h
@@ -280,7 +280,7 @@
 	CONSOLE_STDIN_SETTINGS \
 	CONSOLE_STDOUT_SETTINGS
 
-#ifdef CONFIG_ARM64
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 #define FDTFILE "allwinner/" CONFIG_DEFAULT_DEVICE_TREE ".dtb"
 #else
 #define FDTFILE CONFIG_DEFAULT_DEVICE_TREE ".dtb"
-- 
2.53.0

