Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF513D37E3F
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 735D48352B;
	Wed, 14 Jan 2026 16:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bj0V0skR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D08DB80325; Wed, 14 Jan 2026 16:12:19 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF67D82C7F
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43246af170aso627354f8f.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 07:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768403537; x=1769008337; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ApFncLtJWsiaoiuu2Ck3TYxZADO8Hrv7IoGQ710cdRE=;
 b=bj0V0skR3uD4dxlh8nRNGbuuvlURZk/ao69z87UvcN0g9nbEFQOr11F8a/zEfx03rP
 mHPxoLiUCzCDanVTYSMFUKIee6sJBVTOadTw4LyUGBqp2DpWUeyhUdkNc+znS0Pm3WZS
 7+D+mAXi/UcD5n2SWlryciAGdDIiHfAF0tfH/ev6oNfwmUkLWC8HQVcrkwXo0/zCbcEU
 +VRT0kdB9NU7NuI8/RlxnwhvVr8J6+4W9pwYmHb0xrPzyZoPaXmNm7/wCnnysbb69IeF
 knyTcFJ7BuXra9XV6qE0+gzzp3ZElF2xwBulb8pCS2Xa0eslFX+2NndPDEqH+ZXhTgjg
 b3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768403537; x=1769008337;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ApFncLtJWsiaoiuu2Ck3TYxZADO8Hrv7IoGQ710cdRE=;
 b=PXxPR+UE0q6siEm9k0ACW5Mem/7Xdb9UyYuW2ypQNR0nlXBbX1bFBdxeMfUE/nOsWN
 FnTfOlOVNpseAaMxXcxBabnZ7n/5P9IdIlAtFi7AqwvOKvdSm8FHEoz3fOBNfKjDOGxE
 yxzSWavulHNX97qTK/JNiQS3FXeqxLU6+TSGoquk+2R7tbblFfsMVxQvsdUuf8ns8FOj
 ChTEgnBtvNLlg1MIrojdHbeAUe/taAvZkMcxfnYnKEgokd0+4R7XJf2YydxFLi4Lv8xt
 Oudz3Z8418R3OTg7WUvahMwZ+1YrmYKs4smvGKjiXQ0VSERWPfU3CGqVTYK0RE4Fd9py
 hgJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFSbqEvTK9BjdDm1AKwkPqOLigtLJZmsrjCESfN4RTzzmUVMO74qIvZ+c72ciMCHyKuKtfV2w=@lists.denx.de
X-Gm-Message-State: AOJu0Ywvc+RwbtThVn/CeGWjMtvifRi/oxEF7GoYakjMeuEe1gP5Tbqm
 Q5GKVDSru89g0dk6C+R0/bke69jtBNxHCbv2ALlHnQxarHk+pdSY7A61u/wg6g/DgKs=
X-Gm-Gg: AY/fxX5Oo59dyWYyxB/jFw6uCCq73N/M/99PIbtqJpims96U5GF2wObMesKfKfyfxL1
 u24sTeZgrTD7qHh5MVBmyNxGmRJ5hOzzX1PL8tGUnxbu3RwfKdcZY2wf/AEkym2HCCRTvxEsjxR
 HQ7zgSOTUHHjr+TpNvffPQe+ZWEXYnDGp+Lqt9t+Gl3Ew1wpYzQZhV253Je9m/lIDkLP2n+tql+
 AGxXqgfB4QrougQSNAv8u4I2K8C8UN1tDpvs5NGa/2XkxIUYgZwxhyB6uNGHsOQBaLwPMLgHp3o
 vvdhEXcNRxlFvMsliDE38mil/fh405/CORKCULezU1WhB1OrmJ6s1Bgyqbumk5HKDt7XRIomUpJ
 /MY+SfcOehzICvl3cHg9LS7CIzmP8df/9ThWGwwosohisOAkKb/P7fB3B/6mZJPR7WMkRE22GXl
 KRlCH1dtr9hUfQ1zEdsodwDRkTxK7Xn6ZRkIjOWwXWsFQScOkSRw==
X-Received: by 2002:a05:6000:2dc9:b0:431:f5:c36f with SMTP id
 ffacd0b85a97d-43423ee5857mr8973950f8f.31.1768403537107; 
 Wed, 14 Jan 2026 07:12:17 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:3801:2d90:e4f1:d19d:4c32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacc5sm50455212f8f.5.2026.01.14.07.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 07:12:16 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 14 Jan 2026 15:12:09 +0000
Subject: [PATCH v2 1/2] net: lwip: tftp: Do not write past buffer end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-tftp_fix-v2-1-8de8e6ecf4e8@linaro.org>
References: <20260114-tftp_fix-v2-0-8de8e6ecf4e8@linaro.org>
In-Reply-To: <20260114-tftp_fix-v2-0-8de8e6ecf4e8@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome@forissier.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

sprintf will add a trailing \0 so manually adding a trailing \0 will
result in an extra unaccounted for character being written. This
overwrote the first byte of the following allocation block resulting in
unexpected behavior.

This was found by Running 'pxe get' with no available file resulting in
multiple attempts, using the default algorithm, to attempt to find a file.
Eventually there would be a failed assert when free() was called.
Failing the assert would result in a system reset.

Fixes: 27d7ccda94fa ("net: lwip: tftp: add support of blksize option to client")
Reported-by: Michal Simek <michal.simek@amd.com>
Tested-by: Michal Simek <michal.simek@amd.com>

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 lib/lwip/lwip/src/apps/tftp/tftp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index ecb6c55ae1100779187e7b138d098a0ef1e48ca1..25da952e92566cbca1c64bc89c89102e74d0a42c 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -191,7 +191,7 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
   MEMCPY(payload+2,              fname, fname_length);
   MEMCPY(payload+2+fname_length, mode,  mode_length);
   if (tftp_state.blksize)
-    sprintf(payload+2+fname_length+mode_length, "blksize%c%d%c", 0, tftp_state.blksize, 0);
+    sprintf(payload+2+fname_length+mode_length, "blksize%c%d", 0, tftp_state.blksize);
 
   tftp_state.wait_oack = true;
   ret = udp_sendto(tftp_state.upcb, p, addr, port);

-- 
2.47.3

