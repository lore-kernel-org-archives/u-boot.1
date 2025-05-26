Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F113EC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93AF882E25;
	Mon, 26 May 2025 12:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NeaUXpHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6850882E20; Mon, 26 May 2025 12:16:08 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EF3E82B19
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3dca2473129so11878205ab.2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254564; x=1748859364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QonyBt0vEYvZ1NTIo3Wzxqk27RkHoEb3U/Brwd5gho4=;
 b=NeaUXpHihbWKzwhFxYh8jFt7m4vazMDPfqLLmWkGO7qT+th9fdKIgRDEwGxwTBtQm2
 G0cNmKMaEVco4deS5QJgkiR+gon9Z2hwHc77JN64+Vy31CbY6rcBP6KRGD3Hnsz/5gkO
 7qJQbEF/eNKL9UCToW7HB5dUtcvEiuz5i7t88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254564; x=1748859364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QonyBt0vEYvZ1NTIo3Wzxqk27RkHoEb3U/Brwd5gho4=;
 b=n6LyQ11buz+fgJtyPPYAvzNv+g0efpLm0YT4eZQyx72z2GhNRmSmKA3Oq4Z3+H21cc
 rJK2XNre02iBw3RmI2RSrDnmCFMLDr3hb+MXZIumtlA8E5yLHi1zQ9ip/Oqj1WkyG6hQ
 quW0XYwwPmnofeK5ANrR0EanUFFLUP16N38wbYA4pUW4bqhE8fKKTpaJfF0ZA4p4RmBC
 bcsv+/jjDgBD/0zevB5QbWfZhul77SDG7K6ut45BNwUWNZIZ4Avc49vuiYuY4jbHlqNX
 2cVVOfp+N6qtK4DaWr7LPm4++NhCtnBu9MQt029+lJcw+F6ZT38k7xJKP4NK9Mn2yOdn
 W2TA==
X-Gm-Message-State: AOJu0Yy9PJ2E957KEfzQUxT+TjZ7Up3a/mvgenNRifK085hl5YqlRxJv
 WGyszo6bNCBIrGgahQ9bpWHWnoFT+v8IknepVOUEsmdRaMs4Q6ZseVeVNiJgHpb+wMRQxr1XuR1
 UGjG4Um8u
X-Gm-Gg: ASbGnctQby0wcSPlOmB/CmXm9qGZvWkQCzlMbanboSFGNy7pILPMWDFy+wIJBvXdqPh
 gtcSMtrRRvi6pS39ClcqOePase/O45Mjxo+Q/7fnj/d2p6epZEYmL8anQbyFsfbTDHfw+gvPc7P
 mnNDqW0l8CVtD9K5OX6TPjTbVHDjT9Jr2JeUly6MWOxRAZ5MsOLuCgFvLSu/sSszOY4ENytr/e1
 NHdIWkWsZrDYgqDFNCV5FTh8sk/dcD9OmPv461OBtxLPCNM8818DaWmPgmuVuGTsJtdhdhhqgoe
 f+2jDGgzksi1usIYxJrIQXIzjoFJwI0AwO5zNRKH4bMbgQlQ6++aMX9HAnGA5xtc8YY/HR4oBMY
 x01Jlctmq12yL
X-Google-Smtp-Source: AGHT+IEgKfeAvRbmZZBZ67WHhMrQN3wXTnv3gUcIG5pSPop2QwBqtIk7nZAhsY5bmrdha73Sl9WHQQ==
X-Received: by 2002:a05:6e02:214c:b0:3dc:8075:ccd3 with SMTP id
 e9e14a558f8ab-3dc9b6d3c0fmr74406365ab.9.1748254563360; 
 Mon, 26 May 2025 03:16:03 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 02/25] spl: Allow VBE to handle xPL size
Date: Mon, 26 May 2025 04:14:48 -0600
Message-ID: <20250526101541.3254628-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

When VBE is in use, the size of each phase is obtained by reading it
from a FIT. Avoid using binman symbols unless necessary, i.e. in TPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 76fd56dfe4b..42053b4afa0 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -200,6 +200,8 @@ ulong spl_get_image_size(void)
 #ifdef CONFIG_VPL
 	if (xpl_next_phase() == PHASE_VPL)
 		return binman_sym(ulong, u_boot_vpl_any, size);
+
+	return 0;	/* VBE handles this */
 #endif
 	return xpl_next_phase() == PHASE_SPL ?
 		binman_sym(ulong, u_boot_spl_any, size) :
-- 
2.43.0

