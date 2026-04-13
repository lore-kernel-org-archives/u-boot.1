Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BD2EBFD22
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C224F8352B;
	Mon, 13 Apr 2026 11:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="l4CCnCGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84F448419E; Mon, 13 Apr 2026 11:23:05 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD3D840D8
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35fb0bb27e7so620312a91.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 02:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776072180; x=1776676980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMboHtuP3RpQNEBaDQiDt/x18qG4LDk3R7bkuXEHd3o=;
 b=l4CCnCGBVcwPS6P0R1B5lTVmn/89sxqB0ZjiHrUtOT/CiHGSjQaMO7Q3UnWBsxOkjo
 mXVmxaG/6qwwRAk+bM+9r7Wg+SPwJvWz46dgv88T4lVq/luEmbEZJjQHrzxfbpVZ0Lgp
 LwJy9fj2EGY96cPgslJpOxRQjD9SKDPzapKPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776072180; x=1776676980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EMboHtuP3RpQNEBaDQiDt/x18qG4LDk3R7bkuXEHd3o=;
 b=pbqyvyNhD2iqooJUiAfrXr1Z7XdUATQM71sVrIewomdXdIzE1VV1m5Ez0W6osNDCbK
 Ck2N7O0H/Mmru/05koBJtHaUJsbtTIWa3bifJEtxqYI1asiDSS3EHOKTnBnnU9og6WQj
 fDBvD4Mal2ZH6qi3akzRmhH+lrGHRPp1kxyrQqhsPjmaobym8mvQlkTKVVkLLmhwqrP5
 3iy3chqLlLqZqvfA6LiirdY7EcZDFQPDOI+0EVZ9RFAri05zErTxbClfbGsbDA8xt1y2
 cr79FGYEhJf4IAVdFUr6G9kNFUXbHm2hrtmdW+UC2y38e5kGxSYGReP104SHuoYCWedR
 ECig==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fhDZ8geK4wiaKUMoyip+SMBvWlRblMhwhKjR1gRmBLePxZYHu5d3Kqxet26qESAOrYKTbpaQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzainLfE15DgRbo+og5Azp+kHZOXAmg24/2xqhejJEq8dfRwpYT
 3nKtYzBmShmqBcP2AHBUr8CR12AkLfFZiklaeQhtIExAHzJrLKaizP6ETi+AKqoU3A8=
X-Gm-Gg: AeBDievt/szqoas54J/BQQ66QMc1HGvCFXC+RZ5sgV2bXiB0xmRdCXrIgfT90MU4/4C
 dSkUevo5zRCVN3v2FUAP5+XE+FjKFOr2hl9emE8L++vXRV/7ZlNm7qSyKC96FSVdZlkbjYoYORp
 slG7EiMZDUNoxb5jIbXFPRHJFCUPeJupKz0g1pXJam2k4dzgjIB4DR3QfYrppLfua4mtrCwECay
 O44WSaP8LgBDhJHjnqEzn3mF3Gd/VB+7Apgu/wtyQBgw6RWKh43rLVhlG3NCLaKE8tBMonYimeR
 G8SsEhL3OIQw/0T0v4T0HvbwVlL0wL8SX79HgYIT6lC19KgIAVjl+oGOXMmZcBZJ0GSZuDG+4Uc
 xt++ebWhAjj0Uj8Y2R8hcxHjiVcxN8zroWgEYJZTQK8Kfn7IqVvEvRqXc418EKlkQWA71xx/+YG
 SZzx6pYrq53tC2Pw==
X-Received: by 2002:a17:90a:d40b:b0:35b:cd3e:c4ab with SMTP id
 98e67ed59e1d1-35e42815adbmr13182520a91.14.1776072180057; 
 Mon, 13 Apr 2026 02:23:00 -0700 (PDT)
Received: from kinako ([2400:2200:776:9b18:a191:7a74:9fd8:591b])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35fb617725esm1055930a91.1.2026.04.13.02.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 02:22:59 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v4 1/6] sysreset: qemu virt: Use __raw_writel()
Date: Mon, 13 Apr 2026 18:22:35 +0900
Message-ID: <20260413092240.3719260-2-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413092240.3719260-1-daniel@thingy.jp>
References: <20260413092240.3719260-1-daniel@thingy.jp>
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

The virt ctrl register seems to be native endian, currently this driver
uses writel(), which works by luck because its currently broken on m68k.

Use __raw_writel() instead to avoid breaking this driver when the
endianness of writel() is fixed.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/sysreset/sysreset_qemu_virt_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
index e7cacc9b6e98..5ab16001922b 100644
--- a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
+++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
@@ -38,7 +38,7 @@ static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
 		return -EPROTONOSUPPORT;
 	}
 
-	writel(val, plat->reg + VIRT_CTRL_REG_CMD);
+	__raw_writel(val, plat->reg + VIRT_CTRL_REG_CMD);
 
 	return -EINPROGRESS;
 }
-- 
2.51.0

