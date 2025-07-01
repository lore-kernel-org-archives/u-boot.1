Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBFFC7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 16:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B3B982F6A;
	Tue,  1 Jul 2025 18:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zT/n/vd5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE1382F83; Tue,  1 Jul 2025 18:12:47 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D55C582F49
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 18:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so3408529f8f.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751386365; x=1751991165; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3d7WhQq16il6UvnkeIcFEv6HI2HCR6JENhe0C+krSjE=;
 b=zT/n/vd5UExxmxKdmipZLiSwTDPsRQkV3aKYdb7qFR26/vdnja6kfmXJyKyRhIvOJL
 AK+toWzsQ8Vx2zwbnB++Rb9V7XC37puMtOMi1OHu3+mh3MCVnbFYVHOOSCnREwRhhJ9w
 oiSkfw7pi0aZ6qm+OOu96CwwS8Mv9LSlb5rd/faVdwUdVmyDM9FBk6/Tdpksd9OtYEHQ
 McxqzKABPn4z5y30fwdEgOcwPxGVOAGrHfLDvasqIuoC0Zan4gffntOI6MVRcYLXx5v1
 86JdJA6eHGrmlAYqC/x8XK8JMx4Zw3fWJCJw9Xt+W1+uvfIcS/KOnIyvJGLdgVwYXyMl
 001A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751386365; x=1751991165;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3d7WhQq16il6UvnkeIcFEv6HI2HCR6JENhe0C+krSjE=;
 b=Yt5b0P3GMnQu7meVKDnO6wO4OOo7A812l6LmXilt5OyybDr/3sh3JYiSvVyu/hz49Q
 IWbHT5/2oCbL91kNMzh+T9axDpCyLTM6680/seSAqVaoRu7CBwQBTKGQrNJmBVV3Ju0v
 ewV1E8gfnUrk42IJWgbtvz5ltPsYwr5ZCzVlcJuRiQbFfIDEe2h8PkHsfJ4G1U2cV/Me
 PsTsmv82JKg51KXyxA96t3My9tuHU7JvO52vqso2ZHW//MBWibR2y1rr6BOKmIAtcjBT
 sSrHy7D08zX2xfuaa+ITSqEdZhAz9RuTilHHOREgYDJOyNM5SeeWOf4HiRMrS17Ko1ek
 6oOg==
X-Gm-Message-State: AOJu0YyZWv1TovRgn0aaXXHi8AfcDoTbuI1gltqvmsaDUjKUUpBoqAic
 RqkPVYpKZUIIbbGnc2WbRz+CQUNuSwP5k5WU/dqPIvaGNo2UEdKRgM1IVTFi7V+7oEo=
X-Gm-Gg: ASbGnct2dD9S6dsGBWsGJmVmbCr7jmLj4Mo5HeFItQ3q4KayNuDs1V6sJvfYO93if4s
 5JowLtBP6m2P8sVMgOcuMLInQVUweWL0EhJe7aWPNUs3OUBsQd01Ml6Jy60U+wd7x/Fc5uAZvMI
 jpUgf68qg1iq9fe2o1kP43UqRXTx5bwereepOLqfTvKyJyxKJpZkKH0uZ3LfRaTQuD/DMJ1K5u9
 TkPVltdEbi+aIUUbWUrkR/ofef4LDZtWCqZRm8B63duYExMpXYnjMk/czVjtL3BsaEUqR0Mbn57
 AoLuBsoLX1xFfxB9fuiQQDrIyUrTUvY+ffvdu9H6b/z2gQtOmaTnzpYi6ll2iDfcdisz5nS3XfD
 FbCcSmwfJvjRlXPw=
X-Google-Smtp-Source: AGHT+IFmUMeBCids32QIUzfdFEQ5qCU8xGMCPK5N8rJZQuryvXftjdj9LcER9l3S4SHWQfMET2agqg==
X-Received: by 2002:a05:6000:280b:b0:3a5:3b15:ef52 with SMTP id
 ffacd0b85a97d-3a8fdb2ae8bmr9799635f8f.8.1751386365093; 
 Tue, 01 Jul 2025 09:12:45 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:fddb:f4a6:27d9:d8d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3aba76e40c0sm9508541f8f.59.2025.07.01.09.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 09:12:44 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 01 Jul 2025 17:12:44 +0100
Subject: [PATCH] mtd: nand: Prevent dereference of NULL pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-mtd_nand_fixes-v1-1-f31517bdce2e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPsIZGgC/x3L0QrCMAyF4VcZubbQVIbUVxEZ2Zq5XCxKMkQYf
 Xe7Xf7n8O3gbMIO924H46+4vLUFXjqYFtIXBymtIcXUx1vEsG5lUNIyzPJjD5iRe8Kcr6lAQyM
 5h9FIp+VgK/nGdhwf41O09fGs9Q9lNEvHeQAAAA==
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In nand_wait_ready there is a loop that includes a NULL check for
chip->dev_ready before it is dereferenced. Use a NULL check once the
loop is exited as well to cover the case where it exits due to a timeout
and it is therefore not known if chip->dev_ready is NULL or not.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mtd/nand/raw/nand_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d3d1b93947b..48e3685d995 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -566,7 +566,7 @@ void nand_wait_ready(struct mtd_info *mtd)
 				break;
 	}
 
-	if (!chip->dev_ready(mtd))
+	if (!chip->dev_ready || !chip->dev_ready(mtd))
 		pr_warn("timeout while waiting for chip to become ready\n");
 }
 EXPORT_SYMBOL_GPL(nand_wait_ready);

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250701-mtd_nand_fixes-191e5a19932d

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

