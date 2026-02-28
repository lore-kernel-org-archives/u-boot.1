Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC32FEE4EE
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 18:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 203C583F2A;
	Sat, 28 Feb 2026 19:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cGzri2kC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 688A483F32; Sat, 28 Feb 2026 19:23:30 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECA083F20
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 19:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-506bad34f51so26581301cf.2
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 10:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772303006; x=1772907806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kn0/oOxOxPKcRQr4xGZ8nauvyqeAQseAxufDbTk6Tls=;
 b=cGzri2kC0u4FXlWs1/PKYpi6VXpizf9qlbgW982Fpv6rpD1Xqrv1oHTROUmjc9aD9O
 ekzWLzq3f36/KGA5TQ5KblLa14uBwJfn97pRMigjETZQfoo4ftZrY/ksTADoYBv2PBFK
 F8TaT7aqn+4VwkVS37GU90bAUhFu93/FEflaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772303006; x=1772907806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kn0/oOxOxPKcRQr4xGZ8nauvyqeAQseAxufDbTk6Tls=;
 b=eOFTw0GgRIKodWSAYdP95VFBz46Z2JQP/GUlK/O6uxD5bENZOuQAt627fVTGsJIQG5
 ekfjII89nzEFgTw8ruH1NY6zHjzQyGiTjWTbnD19F7txEcDt79GNTFyPMRgw5+/Pbq4R
 K1ZFpxYykLxDZbhVSR5kmqIV4ka4K/DKKLx7HkWQi2I61gZZtbhMJdyxD2iWurmoH6Fx
 eeyZW+ZQp/3jjNUH9GdjXHRbAoNf4l0l52EtiMdoqXwyaaMn5YeZd15dzelEKv4v5+kB
 wvs1iAiYe2Jj1HKaAJA+Cryhkzyqj1H/B9AIXBxjdFm9YZ3lBGjAD4unNDwmcUccwzek
 jZrQ==
X-Gm-Message-State: AOJu0YzYA+m5OH2c120SsdY68c8wsObDKCl2l+k9GrZ19IcqAK7sYdLe
 N6mlCtVMSPzRCdVm+RAYxmRHkFv9RJaN3qh9TVl20eiA/Wgo7dg4jm850+5qPttVDbZdfjNhXAH
 1zbU=
X-Gm-Gg: ATEYQzwnNNxueAEQ5T82kfLym6MjRSuE3ykaaS0jlGeswulEPZ6Aa0qSEUBoa7sX9OV
 fq0+a3OQPEJ+MmszRa1onL1ZXfqLgZ8mXgYnxFJX9AIayGPOQRpkE6MahpkALXWLb0c5Xo68VLd
 pVatzQt+MRocgit0Skj2VbzL+NEMsXRxWzDuElLCr6cfrr/j0YeGfszI2QW69z07+FYScIxCdl+
 U1+6D8x2kl/BLv55kJsFpgzYcKP0FV2k7pK25BduGdcPqoYM2BKxUoGVpi2N6QUdrMbpevjJE5y
 OuGh15PR3WHrwpWbRx5PHWFF6hHmlyEQrj+w/2PhR0Cw+7r+j7gEQL33q/nHwFkqRSA4DXkwbWf
 fwnTDwbDODZPhd9T96pBRiaR1D+ctdB73XMohrbjuGb5UveU+bCoxBSwu6iwjrpYWKtYHWSZX87
 2CGXceiedZgdw7tf05YSZLuDUlkK8o
X-Received: by 2002:a05:622a:1449:b0:506:bdd1:794 with SMTP id
 d75a77b69052e-50752a27d9fmr89621791cf.76.1772303006480; 
 Sat, 28 Feb 2026 10:23:26 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507449a66f1sm78508601cf.12.2026.02.28.10.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 10:23:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 3/7] test: Update comment for fs_helper.setup_image()
Date: Sat, 28 Feb 2026 11:22:43 -0700
Message-ID: <20260228182304.3728735-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228182304.3728735-1-sjg@chromium.org>
References: <20260228182304.3728735-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

This function actually allows creating two partitions now, so update its
comment to match that.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 test/py/tests/fs_helper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 4b123ab0afd..47340295fbb 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -85,7 +85,7 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
 
 def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
                 basename='mmc'):
-    """Create a disk image with a single partition
+    """Create a disk image with one or two partitions
 
     Args:
         ubman (ConsoleBase): Console to use
-- 
2.43.0

