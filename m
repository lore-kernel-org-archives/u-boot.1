Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF90CCE7D07
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 09:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0048910B;
	Tue,  1 Oct 2024 11:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RzJCNjpx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0398189164; Tue,  1 Oct 2024 11:57:01 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF1A4890AE
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 11:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prabhakar.csengg@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5398cc2fcb7so3101265e87.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727776618; x=1728381418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M0/bS8f3wUBlugQ/sMayZIE3ac9FtfmTvyjaHN31gOI=;
 b=RzJCNjpxY/KQR2rs7fPb7ac4jORXtUe8k9v5Q5IKyL6II2Lp0wHdCaPb8sNw1iHqvm
 BYYYLteWUi0eVeriSWAOH4/OwfIHr8VH7rGLwtGtcIE5PGQCTv+a6QONRyhRPfi1lwc+
 6km0wqt9r8eSG8sQl5Fy4zv9R+CIpoXmrjBVf5K9Et89XIPItY8Bm5bWqjcoYBBhIaWL
 VETpzunSPQJAGC8cIoBwrLUIPuadUVz3J+0KO/eClpOAcZnmhnfq3lJWVjW4bTQtKB33
 NNS0hfPLEhhoZRSvPf4EqwnLj4fUFiA3z27LKuURemqrz5eTDpEv80uvLkuDCHns7siO
 phNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727776618; x=1728381418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M0/bS8f3wUBlugQ/sMayZIE3ac9FtfmTvyjaHN31gOI=;
 b=owLhntBrW+Ee9LWUQQY/gYE35vQ+ca6TgYdB32DpjetQ/KVoeZ3FolDBSHRsKcsRBO
 H4zRnOeRzc+Yfo4VRbsyCcsyZh2x9ISTsdJbR1quRfrBTtO4XbSSd637UtiTrVb+p7Ib
 1WNJQhomY/VAgmTFysTBISL40d66jQLYmk5bCR5Rd+yP1JWiZAJmwKMTjVRX25KvG8+C
 Cu1Pc/NVfV0hPEzBfd/OWUe/RYCc6rS6OemGK855WKPEzIGHqY9vbFQoMJ28oQQFfctO
 ttbYhLjrGwLdyXzh6H5JOGCz3l8+E/ZDcL0lS8LIXtkgc/507PSWIf8WOYLIA9a3dCVM
 ju+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8qRC3/LsUH6vMAvrnVt/lQGJDw0JZsfVONif8UHKWUfs2S7pPV7aUizqor3yZwkcynNkccE0=@lists.denx.de
X-Gm-Message-State: AOJu0YyO0f4oSjfkTFUq6ezTV8BdhFHRsloJe9r78hOIH1pezxc7rvnZ
 tTDnCJJnY6MgHfPNUoozX3XOGUpOuboS0N9GbiRocABIsd45T9u/
X-Google-Smtp-Source: AGHT+IFzUbvXjqNrW0kSbko6Q0P0Xpuk+3fgt2MB493hz87B5ViBKRwd6v5xkANxxC5sWsE94WDY3w==
X-Received: by 2002:ac2:4bc1:0:b0:533:4b07:a8dc with SMTP id
 2adb3069b0e04-5389fc4acfemr8421483e87.35.1727776617620; 
 Tue, 01 Oct 2024 02:56:57 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:2595:4364:d152:dff3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8adadc6b6sm408335a12.43.2024.10.01.02.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 02:56:56 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Prabhakar <prabhakar.csengg@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] lib: fdtdec: Parse the gzip/lzo headers only when
 dependencies have met
Date: Tue,  1 Oct 2024 10:56:47 +0100
Message-ID: <20241001095647.180840-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

It might happen that CONFIG_GZIP and CONFIG_LZO are enabled but we might
have CONFIG_MULTI_DTB_FIT_LZO enabled in this case in the code path of
uncompress_blob() we parse the gzip headers first which results in
`Error: Bad gzipped data` being printed. To avoid this parse the gzip/lzo
headers only when dependencies have met.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 lib/fdtdec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 6865f78c70..52f431c197 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1172,10 +1172,10 @@ static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
 	void *dst;
 	int rc;
 
-	if (CONFIG_IS_ENABLED(GZIP))
+	if (CONFIG_IS_ENABLED(GZIP) && CONFIG_IS_ENABLED(MULTI_DTB_FIT_GZIP))
 		if (gzip_parse_header(src, sz_in) >= 0)
 			gzip = 1;
-	if (CONFIG_IS_ENABLED(LZO))
+	if (CONFIG_IS_ENABLED(LZO) && CONFIG_IS_ENABLED(MULTI_DTB_FIT_LZO))
 		if (!gzip && lzop_is_valid_header(src))
 			lzo = 1;
 
-- 
2.43.0

