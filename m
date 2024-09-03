Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F623CD13CF
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB70888D0F;
	Tue,  3 Sep 2024 10:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ym9VxEoP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28DD388C55; Tue,  3 Sep 2024 10:39:01 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34EAF88CED
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42c5347b2f7so26760895e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352738; x=1725957538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Wa9HCrcfm7o0TjMrTTYfl4sO3SyOJxPMCBHWO3MOxY=;
 b=Ym9VxEoPpF1AZeJkrv6U3oPiFBMbog2BCZXo2QRhBlj3a+i8CDRC2vAzMw96u/+R50
 m2CK3gF8FU6zOqIGSOR1S8YuNKV9ky0bHVt8mxFZhcv+szCziPGf/eth4IzRLJLN8pbr
 7s6GQSx+x+Qs35rada/hNOWbfaSULYmh0LSWaE8dO6YGoba9hN9l/yABjVaxcRr8UShy
 Oli0hlrsYYmGVYG2vtf0HEdZweqbih9mmrxL7F5/B+02xZ+iCGmJla9ucHtPE+q69/7S
 5tQKG1UxUz1toSdtujNS/KkVTBFeGHuQFNTtQnCdS2pEruldWU2wB6pnuK8H5SCwQUyV
 +GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352738; x=1725957538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Wa9HCrcfm7o0TjMrTTYfl4sO3SyOJxPMCBHWO3MOxY=;
 b=qbuEqmYeg+bEqrqLGcPFAAwIFmcC/rsQDtjna4uydmzM4/SnyVbznXlC3KGu4yahZo
 CLQt1ofHyJ/Kw317gaXgTYEk7HY2HaHi4hXQcHIVeh/qvXb06Wh5K4H4if5xEC6VIDdN
 sR5a3ooHSG4L0HaqLTQjPILotNhpx43VgcfoGmiBPd4qG9FSBuvUG6Elb4LHMSqFzKp8
 12WJpbeORJ8ca2Xjq8OcBqPyaz67emVDWBHPAV2HBg6ZclgXF8SSN2G2qN1RU77Hm9Y5
 9lYkhWEWG7/rV57R0RXTLlqLATFatF3xxBptMjtaRm+ghLY+xgibFNagCTVO3LvntnbW
 Wy0Q==
X-Gm-Message-State: AOJu0YzAfYatYJj7Dh/iUJu5KPMzUFI9uGpdRfL2ccvKqI5Jmk3JpmZE
 cAmpnqBEM6geYCdXrm1DGTOYH3vnMta7q7lZ39ODrFLzBdM5cCOieG6JnmIorYjQr11YfhWlXd+
 r9o6PUg==
X-Google-Smtp-Source: AGHT+IGagDI6SJram8rPK0RVNkUOM7bsmeC2Q3kD+REOVPjIUqNVGdzctAWB3WJE85lXJQjoEa7bZw==
X-Received: by 2002:adf:f34b:0:b0:374:ca16:e09b with SMTP id
 ffacd0b85a97d-374ca16e226mr4047661f8f.9.1725352738349; 
 Tue, 03 Sep 2024 01:38:58 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:38:58 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 10/16] net: wget: allow EFI boot
Date: Tue,  3 Sep 2024 10:38:07 +0200
Message-Id: <31d36ea06f9d8cbcf125aa65f080461ee14ceaf6.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725351676.git.jerome.forissier@linaro.org>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
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

