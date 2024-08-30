Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCDCCA0EC5
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A111F88B0A;
	Fri, 30 Aug 2024 12:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IliDs+O/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24DFC88960; Fri, 30 Aug 2024 12:17:37 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF399886E5
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42bbe809b06so2024025e9.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013054; x=1725617854; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jSik1AXRrqolpr9wSVtwBcXL9ay5XVHmBbR5UW35Zw=;
 b=IliDs+O/hwY3jCg3dsDng1B00y+1mnaxe/eZ8RgAWrvdw5uwrS0z68LbckYj0OHBY/
 OBYF7ymHcNfZzTre7Vr74kEVRQAcO/aNSb09v4uOdVKr5IBF943xcOfNyYOqzDBTfnhV
 hJ8OHAZp7coCqvUha0w6zwrsjhk4i+6X5hMTjsMZ/haTmiIlERyoSw9tff612lfOpRz5
 sYkLqinJfC4kFBTbdTXghzU0OBOlSYzS0wjkLoowBj9djlBNn2Wv0tidVzo/AB3c8crT
 6SDaOyZ+AvOd7IGiCWR+oZjT66COriZfpWUxd+j7XAm+By2dLYQQ2Q86jU/pPBKqKBWQ
 4/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013054; x=1725617854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7jSik1AXRrqolpr9wSVtwBcXL9ay5XVHmBbR5UW35Zw=;
 b=vCCz2NlmG4w6nbJo5vsmDGA7sPfsx7fOqa4ZEbCZkSq0YMaSWhEfcXtLpgf9U5cZOM
 6gBSpP3nwomSAVtZERc9BVcMj5457LLSYMHWyUyn19OKrvnfrYCgS99JlqyY0h4b4KB0
 0lv1IVtE3nV53kjeH0rB+qvRvVa90xUDgyJMiTxPjcvJeaX5ivNQI8+kwOb5w6BqAuvv
 IXms3EDtJy+fCopNxuQI0iRv8neEuZy6m6jRd+Nh4HhSwgHjbR63H0yGFPO8Fewm/+El
 dNFeSnHMuAR1g0OkZp3tsNTZ7c/o0Ex1YUDSwOcqnuedWaNHonUAiMgGBq2SEsDWNyq/
 /dUA==
X-Gm-Message-State: AOJu0Yxsazgv2kieFyNaKS4PAWl5mt0G/VuAiRyio2x9DVtZwyTUM9+s
 w+pn8N/+csYny+SGvrag5r2U72wTbkCw2ewQEa/7IKfMTfFwxuGCtKTw08RUKJpJiY0LP+ffBJK
 0gBXSNsgd
X-Google-Smtp-Source: AGHT+IEtQHxGbF0nYLgo9jmaiAB9pc+riL602ePUL5jKITR9MXd3sMsZ+kybbgsZKefGNvgBBhEG0w==
X-Received: by 2002:a05:600c:1991:b0:426:5fbe:bf75 with SMTP id
 5b1f17b1804b1-42bb27a9f2fmr46339875e9.23.1725013054177; 
 Fri, 30 Aug 2024 03:17:34 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:33 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 10/16] net: wget: allow EFI boot
Date: Fri, 30 Aug 2024 12:16:53 +0200
Message-Id: <4d43119310d24df623ecc1d2466f03e69f0684f7.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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
index 0e4dc5159d..cf7681a4e7 100644
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

