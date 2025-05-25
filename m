Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B54CC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99BB582BDA;
	Sun, 25 May 2025 12:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WEUrBjmG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F58F82B70; Sun, 25 May 2025 12:48:12 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5092482AA7
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso9637615e9.3
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170088; x=1748774888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dncvs/lM+raOHaLdi7Ic8qFOvpgvEjdXyrGWkg5VbVc=;
 b=WEUrBjmG8/6Nxk4JJ+V1OPUwjdqMQvf5pnphurYvlXQcwIfgSUP15l6YenonRQmm/T
 emcYXRDAyTmOqz90GQuqSRFf53NXP94vGtIcNPVtd/DEXBgKhPBaSKxw968k95/cUKtl
 BEjBU5OBy+auzZZsF9RMI+GiT13OKPlH8kv0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170088; x=1748774888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dncvs/lM+raOHaLdi7Ic8qFOvpgvEjdXyrGWkg5VbVc=;
 b=r93yq/cW1T5U8d/1Ui2/8adQrYI9TGaB/8/Zj74eIcPTs2Lya2wMGcMMNi9BMLnVpJ
 QSnZGE5Pwkj+UYmX5a7qDtnfTFUcvp9iTJwUNvCmBG4kbeEB8M+uKSYAGqK14eBk50su
 xvf5mTISFfB4Ut3KCQkgU3TKOfeMXFxhva6vMFE4EPEcE6JS0nuK9va+rtNPVS+VIFK1
 uqYVaXPfeQnCHtsQ0jc8jkwgxARY0RJAFpw0985NGzccbvG8+5zBXHng4kmQjhbylvUB
 FKHwNyHEJ3C3YGZE+Ytu3C4uLazNU4MDWukYtqLGptOSc87/3X9sGqQ2Nhg/snA5eUcT
 5D6A==
X-Gm-Message-State: AOJu0YzNDdvmIEbINneiDq5coEwJV07COK7df/eWkoAimPm2F+GENrRO
 d3+KX2L9I/QE87CxKMBgKenqiqr4jdhWcWCItKvQW93bYtamwiQAHHwvTca8Ie8XvD/BzqTlaL9
 hDrmcTWGJ
X-Gm-Gg: ASbGncsXGdftT7Q99aLNQmKMKyr4kg7MMotXW6CV+2IajL99ebuc903+4frfjdgF0zf
 rey1Ij2cvtQDeU5FGFKmYlm7TeOw3cG4kmqu63Bo4DqmGhbxSx1/d+YNhKoZNO9c7XkFBXCGhSC
 jBvJ6LNvQmAj4onKvdMPwfFySiIwB1lCCcnwy9dTeSaRgeQWHATA7eEvuiVa4i/ctD9atirbyn7
 Qk2yAYCLmhvCyfLbx9c0s/OUxi4pT4VwObeCA5PWy92iqaI+aQSZMjVuuV1z94IMKEasXtOIupX
 yjz/WxsJspJ+Wj2MHaRTgRxAVib2b4eF0JavbQYyHTv8m6zSJ7yIXbPpg85HWUmx6R8A0x4=
X-Google-Smtp-Source: AGHT+IHYlVkcjQxcUbSwUA4VSfNR8nv6ECJB50x00LjR7WH9MonHI9qlWcNnINUSn07CUAAnw1Mfog==
X-Received: by 2002:a05:600c:4e0e:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-44c91dcc114mr43466895e9.19.1748170088489; 
 Sun, 25 May 2025 03:48:08 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 01/25] spl: Adjust xPL symbols
Date: Sun, 25 May 2025 11:47:37 +0100
Message-Id: <20250525104801.1440260-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

Update for the new xPL naming, which was missed in a previous patch
which purported to do this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 common/spl/spl_reloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_reloc.c b/common/spl/spl_reloc.c
index 324b98eaf98..216c0f36623 100644
--- a/common/spl/spl_reloc.c
+++ b/common/spl/spl_reloc.c
@@ -59,7 +59,7 @@ static int setup_layout(struct spl_image_info *image, ulong *addrp)
 	uint need_size = image->size + image->fdt_size;
 	margin = buf_size - need_size;
 	log_debug("spl_reloc %s->%s: margin%s%lx limit %lx fdt_size %lx base %lx avail %x image %x fdt %lx need %x\n",
-		  spl_phase_name(spl_phase()), spl_phase_name(spl_phase() + 1),
+		  xpl_name(xpl_phase()), xpl_name(xpl_phase() + 1),
 		  margin >= 0 ? " " : " -", abs(margin), limit, fdt_size, base,
 		  buf_size, image->size, image->fdt_size, need_size);
 	if (margin < 0) {
-- 
2.34.1

