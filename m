Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2A7CD8C89
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 19:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F8B18466E;
	Sun,  7 Jun 2026 21:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KABW6/Ym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F2B838BB; Sun,  7 Jun 2026 17:39:04 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5BE0801A9
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 17:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36b9d265355so1887722a91.2
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780846741; x=1781451541; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MITrG9OHJnSbEBKME393YGWPUvFQ8Ame/VUdomMGMFE=;
 b=KABW6/YmdvXE/6rH8FqL718jelvV+Owt95T+fBDw5sFnYFnQ+1RBXUt1On72+uFtyU
 ZlrHyZ7vLEoITAkR8YtE1QzFEubVkd+dF6We7PMbVnnsENSjcn3tiLqoXBJpGkOE+sp5
 +bgT1ZfrQwFARYu9whLWhsv1FuSvS5LR2N4UbwSBZ0QGqunT1+SZPn9zv6yHcgSgP0EA
 PpJ90zkZmzG1nLcB1T9vcs7A/ldQYS2/cdJ7JoTR6cy5FecAOx9pc3joOVWI8hOcWuO5
 M/UXUmkPDvxbmHj+rs7F+LHBraUC0OGTvJvhj0EQfMUoIeED4sITXd1Lov1L25NCWwqY
 5wgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780846741; x=1781451541;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MITrG9OHJnSbEBKME393YGWPUvFQ8Ame/VUdomMGMFE=;
 b=AiMQl4iJ5kTrjRvX0/e7dc7AsRwuZ9B6GLkjWGR9OwO6DjX6x3gySdLjGOb4VjfNTw
 FMjuvgnLBIm0CpyUM+ySb6a1Defx2ge/KTAkQlljG3bWHs2Qtpe55Ta35nsKd/IqNWu8
 tL+sMCFZnwwPL8Y1x0R2rkh4XoTcDJfbwjXjGpbvubNT37rFb/gW7zSW8JJgQOb2KhsI
 lXosVEM9eijytIZSTK+zcuMcuHf6OeELlsGJgXBH9dtJ9BJ6yXuMhf4852V9Y/htTxnv
 PzlF2x4g++POAEQzHjOd6ZmWnAO0pTRgyWZNZmKFXqTRYB6ebB4pwQO2pqpTWWV/NLxT
 LgvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ymc4FltMngJJhVvSIwfHJXS0rUlU5qpqZ7EpKrWJlRV1u63nY+tvSclPQvbtL8FvMqxhZZPk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf4j0jahh+E/W5/YN6ziFhGphvuh276Dv7UDS9HDcylj+J9OZP
 vbYQUYEvcaSpqRyPQnxuh8788p8EDABf4EG8r7kKASNS8p5rQQ5/moLr
X-Gm-Gg: Acq92OEphW3HIoYNzDbD1G9x8xWTXLWjXNlcY5PmPnDQ0bwP/mFcgOexpEuEkXpcVqa
 mPzv9pFZazifRH/88uJTD2gosok7jb3f1bWab47C/3hsmG2xDwB0RXNB2dffbFf1sTbsaogvs5K
 QfAaIAICIrOM1cY8836ZOD1JZkIImu58mQC0YWwsEBYn0ggmPjf1irT804EZsBbEfQvCaXnm79n
 B1hP5SEiQqxqTQ14eLxraGZ8BZB5I8e8OKgpd4xLQREJcTAEuhiiGUvxx1ItJZK7f0o9rSVE0+T
 cbE7Xr7IcIA/TI0iQLpbmdrKBc36naxMRiZ66bTjx9iML0tbD+ysBny2TVR4CwIHl71vR5wKG0U
 ffgN8QK/yF/lYAdH+rDZSEyT2R+YnVZ/0GY8zRa5rWhJ+F3VOKdADHVE9WGYsVgSjXpvkRmTTsd
 FmzEN87x5S45bbFt+qZFa/rmqYiwWPKP8v+I0=
X-Received: by 2002:a17:90b:1ccf:b0:36d:9ea4:d0b with SMTP id
 98e67ed59e1d1-370f0e49762mr12749356a91.24.1780846741038; 
 Sun, 07 Jun 2026 08:39:01 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6c668f90sm15940366a91.6.2026.06.07.08.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 08:39:00 -0700 (PDT)
Date: Sun, 7 Jun 2026 21:08:58 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH] serial: msm_geni: remove unreachable dead code in pending()
Message-ID: <wv5b3tzroqen7ub4pellbt6ve5yr32abstibji3nhrmhwcqujr@67vo2lnty22y>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 07 Jun 2026 21:34:32 +0200
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

msm_serial_pending() has an unreachable 'return 0' after a complete
if/else where both branches already return. Remove the else keyword
and the dead return statement, simplifying the control flow.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 drivers/serial/serial_msm_geni.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 3dca581f68f..ece2a722068 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -428,11 +428,9 @@ static int msm_serial_pending(struct udevice *dev, bool input)
 	if (input)
 		return readl(priv->base + SE_GENI_RX_FIFO_STATUS) &
 			   RX_FIFO_WC_MSK;
-	else
-		return readl(priv->base + SE_GENI_TX_FIFO_STATUS) &
-			   TX_FIFO_WC_MSK;
 
-	return 0;
+	return readl(priv->base + SE_GENI_TX_FIFO_STATUS) &
+			   TX_FIFO_WC_MSK;
 }
 
 static const struct dm_serial_ops msm_serial_ops = {
-- 
2.43.0

