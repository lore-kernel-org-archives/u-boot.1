Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06219EE4987
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 10:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7290C8923F;
	Wed, 11 Sep 2024 11:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Usk4aQxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4861389245; Wed, 11 Sep 2024 11:59:03 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20DD28924F
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cbface8d6so22598965e9.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048736; x=1726653536; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4/4WGx73cmlmZfMgS5sVRgZbEW91Vkq9ibkAqHcF6o=;
 b=Usk4aQxLJTOj3oVGuc2lf5HWNWimhMd3sg6FySjV2Vq3G4jXOL4H1ViQxZZrT6QHI1
 ygeWRUiay6f/oU2OybEBs8uCrYjObElyM388HNHcsTKP+jsJuUSLqxf28xh3D0mX+1qb
 e22tjLi49LL7O0a5e6JiADHhkxqbueV07HQOMLNy2F7fMhE9Hpf/Xovv4oaO9OWFOuko
 cqY9Pbl1qMis04gtev/vDjuH6ujUGn+DVP+qplkA50HPmiWqdz9QefZxAgiLN423eIFy
 g2fGgRWTbfDYcR0REgRTSDJdR/P/ncjgUISDn8z/4mDbUIutf68WsIoHvp9NE8YTP5rb
 200g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048736; x=1726653536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W4/4WGx73cmlmZfMgS5sVRgZbEW91Vkq9ibkAqHcF6o=;
 b=KvFYIWc9fL4s37yBoJzawfj+SuPpQ06wwARr9dEPUwuwj8PTFbQaqFVhKy1Pa0/3Xr
 Kgq4uEaiyka9DtbJTH4WQdNVYDaFQ5vkNtwpzwUtho7rUgfBbkWelvWRTgWYOvXG1ZyB
 s8QUGltwj4a7BEN9E2v2R1Ql+KezMC6h1ioXXe2nSpnxDESUfzYZ9zGObXRi9NgCEEn2
 +0wYh7SHuzMTWLm4TpEE+iaUz31nguny2BVrXn9wR1KWfCxAYaGL48Hgyjv8zXtYcqvL
 ky5h27RpfBdPGelZcTSI/s53F2oJJ76ch8zpzuYn6ecrjcjlfD+rB6pnnlig7J+qlx0a
 ZsgQ==
X-Gm-Message-State: AOJu0YweiEgalbNVwzrVsjUQs7N+SldfIwp29YnWIiSmmVldsUSdF8OE
 rBdSo6z9KmQApOQk90bztCYZ8rpXPZ0/2TGpPMsmPFv7QC67SpVJg91wiOzEGjKp92iXSawK5rk
 tDRgX/nQc
X-Google-Smtp-Source: AGHT+IGwiP1C30u8xAPc0drpKH5Iv2z1dhbW+t4MS723SNU+vX/KSZJP47DLQgU4lPoZf0VN/UrlnA==
X-Received: by 2002:a05:600c:3c88:b0:426:59fe:ac27 with SMTP id
 5b1f17b1804b1-42c9f9e087amr169796675e9.26.1726048736335; 
 Wed, 11 Sep 2024 02:58:56 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:58:56 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v4 09/15] net: wget: allow EFI boot
Date: Wed, 11 Sep 2024 11:58:22 +0200
Message-Id: <365cd25d2326037ec8000d865b4389e8a373b632.1726048404.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1726048404.git.jerome.forissier@linaro.org>
References: <cover.1726048404.git.jerome.forissier@linaro.org>
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
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/wget.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wget.c b/net/wget.c
index 6ebf9bca0d8..c8cce554c5e 100644
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
@@ -425,6 +426,9 @@ static void wget_handler(uchar *pkt, u16 dport,
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

