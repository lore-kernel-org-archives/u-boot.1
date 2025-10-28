Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31305CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 20:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FEF838AB;
	Tue, 28 Oct 2025 21:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CLrfc1H6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E573838AB; Tue, 28 Oct 2025 21:26:35 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7DCB800B6
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 21:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-93e7e87c21bso672276539f.3
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 13:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761683191; x=1762287991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cDeqi/dQCKTbpaOhYxnoS43LYKFvkI1ZkngeuUrxnZg=;
 b=CLrfc1H6D55Py4UF6+P3We4ITslBm4sIAPsyLM5VPrWo82hFaj9otAAxSnxB0GX5m8
 lgJxRl6O0IhUBB2tkuY6y9r6US80X/efQ//qW9We2jibKPu0q5vSOodItURbopl4fHzu
 AkRhsq9Gdj8uKyNgcIIkpPvjcaSYXgiYNNLzbyejRFdGiMQ296W6P7YLH9rs5fdsBA3f
 BG4fecwippsAvBd2tuE/DZje/HdobprQ/IBzB9gfWiQUFfIh/XKCHSa25lDrr0q4i7ZS
 hFrvKB4y2dMwAMe7B6PyoNdAluRw4q/gk25mwM2EAUVYuFjVWNF4xqcRy3ubLEd9CIg/
 foRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761683191; x=1762287991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cDeqi/dQCKTbpaOhYxnoS43LYKFvkI1ZkngeuUrxnZg=;
 b=eTBtRy8z66SYiVBkD9idPv7faldT9wwPl+dODXcK0sR8aX8S+R2bGktJU+lzXU7h/u
 lmoCOnlUGWYxtoe6cPYwZ2w4WaQfAE7cclgbpry2mJDbDrRqw9ayTmWBiINu+wKqS46k
 UQIYixBXmhIt7ysoskXy0MTiVdKJD5KYynbLf0pH2pmHg92W+2nwDi3JtH/1C1/Wv0N7
 zZyoZcDb32qpcCPMBbi0WIZLOtjwgIvc/xyiVM4M5YmffTIezHW5VLruHpjrv8OMq0gH
 dHdiwstTkc9AsFVOOAlV7dyppJxA6ZTFR1qdAyUMEn8qsbykdhQv5+xIsSHArsAiE7bW
 XVug==
X-Gm-Message-State: AOJu0YwGLN7aFchglZK+hHVZYqcmMg3Sv+RQauy36DWmrvdZFJ8mrcec
 TdxlqOrR0JmGt75x8ANQyietszvdmJ9T2I87EY+58EQEGuDzbgA4XXDCJ4gfj5YTL9Q=
X-Gm-Gg: ASbGnct/HuTsgMhZj0g5qeX1vjPHiWWLNfbgcpH7NOxQ4I0+LqSXFjsIA+xMGknsy6H
 I6JsX1EuURG7z5SWT8yUoTRkNCG54KILF58l0JdrxkydF+Xqj/shASlBrl6boQT/ewHRlu7otzW
 gS3HqnFXoJbLNEUJAy/7H7fHcPDrEbUdv65/CVdZ9cDI+uLXsWmvKc7sZt3/XH9CeIgQ770FNSX
 NKn1H1cSFCwJjjRtVxMt+bTSCb+v+0iHEn0g6UlRlH4f8SmggnDu5RHUHaqryhkXRHPdvLyJQu/
 b1UjBdz/zGgJHxrwjmO0LRBvNYlDZ18JIzGFe5HWpZZAKtlIgUX0IgoSs/WSDKwWLqDJjwFwsLY
 3EIH4e3osSBt4NwJaJfg4k20AwDxrjw0dM01LiyLKGOsK8M8J/KAtNxy04Ct28xrwGjOh+B/59j
 mEHmI7lN6KpRpTTos2TgEU
X-Google-Smtp-Source: AGHT+IFVPgCrUEF0ASOUVBzhmF4PXK0AY1RaAnKhzXhBqqwdiXHfzIz/2PzA7wCBgpR3uqjew4VvDA==
X-Received: by 2002:a05:6602:6d01:b0:887:6bcd:7471 with SMTP id
 ca18e2360f4ac-945c984186cmr106388539f.11.1761683191379; 
 Tue, 28 Oct 2025 13:26:31 -0700 (PDT)
Received: from ubuntu.localdomain ([216.58.22.99])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-94359f11ba3sm391817439f.14.2025.10.28.13.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 13:26:30 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, Raymond Mao <raymondmaoca@gmail.com>,
 Tom Rini <trini@konsulko.com>, Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Yao Zi <ziyao@disroot.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH] MAINTAINERS: update my email address
Date: Tue, 28 Oct 2025 13:26:17 -0700
Message-Id: <20251028202618.7893-1-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 Oct 2025 21:31:29 +0100
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

Update my email address in the maintainers list.

Signed-off-by: Raymond Mao <raymondmaoca@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 671903605d1..6552095387c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1294,7 +1294,7 @@ F:	drivers/video/mali_dp.c
 F:	drivers/i2c/i2c-versatile.c
 
 MBEDTLS
-M:	Raymond Mao <raymond.mao@linaro.org>
+M:	Raymond Mao <raymondmaoca@gmail.com>
 S:	Maintained
 F:	lib/mbedtls/
 
-- 
2.25.1

