Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6ADC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF9A88D1D;
	Wed,  7 Aug 2024 19:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lGjc3Q9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E7088B63; Wed,  7 Aug 2024 19:12:43 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E1CB88A84
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so46771f8f.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723050760; x=1723655560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALJZhM9QCzxl8KYaUtyIpLCZizsdfn1cqW7h7h5CSXA=;
 b=lGjc3Q9JH5Ec6MaokoavDHbbQeLj1RNZJjoxy64G66BGuZuF/0TeRDSsLYU318QdWH
 V/88eCvKO+ZX7K+Sg96z+Kkcs/q3yM4vLUH7vrm1wnbCdw2PahGxQh88vlmp8NEFnI4k
 qTlUMFohZOWBL6Nhd6dBMshL/8Hz5tu2KoEK5xqtFupN53wgcW6Thi2IWR5LfA6JZtKE
 XD5HyO38AgddmxDMcqqtnlcCwyF6nd+4ry62RoTBhRwv2Nl9W9Wvh8LAgMk2hKY5PmBB
 CYK5Nsl5tRbIrP09r9tuGJ8QhiJjI6KHtMu8eSJ6PVrjKN/mFxbIiPVTHk827O3c3O9L
 YiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723050760; x=1723655560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALJZhM9QCzxl8KYaUtyIpLCZizsdfn1cqW7h7h5CSXA=;
 b=eVEo+Zg8z2nfwFxL8MYIRnKZR1Zcnm7noA2BUDudzcSmU0gWgA1GbQjLbevnJuo5eX
 1Q1ayOZYBeIwkTwY67nbNgkdEOVQW4zHgaaJOstPiRBArOUS8IPNIxowbbKkQ0Wz5j5s
 ljF2iOq7p2/sGfkYWciJWS9fQMr/Ah9Em9tOrL+xh92yqW6EcPY715r09C6mMECwWWQR
 aW9DQm44Uu2e4CUvejcJWq+Vg3IuKxfTgvwW+SAM3fwETngG1iiZMGqt/xyiVfr0C8I6
 jFnSIcSYoM1Fi7z93ho7eRoylfByBWeWFIalXyiil7PXNehcS0oaYHnw6a6xOrO73Iil
 xWSQ==
X-Gm-Message-State: AOJu0YzqgmFn3tjfwcpx6+0yKajKzqaAOerBZeEGURI+sEBCRWCu2ueE
 YEeXHChxCtZ+lM1NLQ32KEI3M1xQ8Y9Lk7IOGv+0JHuC63/3H4dt28GIxrG+IrlH/PT8uwh/B0j
 UJH64JqQN
X-Google-Smtp-Source: AGHT+IEyF2STScy38C1hYpug3D55wAD+ko3B/QH6Jv85ODxhEBYNBfaZdxOyPJzoeI6TeoAosItHbQ==
X-Received: by 2002:a05:6000:11c1:b0:368:7f8f:ca72 with SMTP id
 ffacd0b85a97d-36bbc0fdac1mr13797169f8f.29.1723050760359; 
 Wed, 07 Aug 2024 10:12:40 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bb3d:43b8:4780:757c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597b2sm16623781f8f.81.2024.08.07.10.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:12:40 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v8 03/23] net: wget: allow EFI boot
Date: Wed,  7 Aug 2024 19:11:47 +0200
Message-Id: <b02ec5e623fd4c80201c92630780ed7e4f557191.1723050310.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
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

wget followed by bootefi currently fails as follows:

 U-Boot> wget 200000 192.168.0.30:helloworld.efi
 Waiting for Ethernet connection... done.
 HTTP/1.0 200 OK
 Packets received 13, Transfer Successful
 Bytes transferred = 12720 (31b0 hex)
 U-Boot> bootefi 200000
 No UEFI binary known at 200000
 U-Boot>

Fix the problem by adding the missing efi_set_bootdev() call.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/wget.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wget.c b/net/wget.c
index 0e4dc5159d0..cf7681a4e79 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <display_options.h>
 #include <env.h>
+#include <efi_loader.h>
 #include <image.h>
 #include <lmb.h>
 #include <mapmem.h>
@@ -429,6 +430,9 @@ static void wget_handler(uchar *pkt, u16 dport,
 	case WGET_TRANSFERRED:
 		printf("Packets received %d, Transfer Successful\n", packets);
 		net_set_state(wget_loop_state);
+		efi_set_bootdev("Net", "", image_url,
+				map_sysmem(image_load_addr, 0),
+				net_boot_file_size);
 		break;
 	}
 }
-- 
2.40.1

