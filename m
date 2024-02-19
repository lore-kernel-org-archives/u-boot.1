Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E152AC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 12:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ABE687F58;
	Mon, 19 Feb 2024 13:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="yDrI27i6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72DE187F53; Mon, 19 Feb 2024 13:00:21 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 351FD87F31
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 12:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.wojtaszczyk@timesys.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a3e8c1e4aa7so83635766b.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 03:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1708343977; x=1708948777;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EUXlQ7h5OmSjgd8bigjv3LZZ2DhMnPUbLnTAAw+eTYU=;
 b=yDrI27i6UKpx/YP1wCkT4HaHPsiWWqBeRFg/duLrbaHU54LPBEgKgKXbvu7Izxs5Sl
 Ya4Aq1/r44VeSjh5X9Vwp8zZX6WkG3K6yQ5pFE17hzynJKL0YM0tWy5ShQ07Hx5jhZbv
 xc4F9dQucyWPbqnz2rNP58FmI5Z6uOllxpAFDDXh9Jl8BPMPEm96epabjPjfLkAouaTV
 pwGLDiYz6Oz/6KKlmvS84nX+Zl/JQp505IuSobuntieaZglcuVoonr1AiN/zg+oLRqGF
 CtOpYW9HkQxeRaC04iPcg7Ngy0D6jSe4Tk4qU2jOfqDJtz/ehEXrbKWodlKRnW43fXFo
 zIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708343977; x=1708948777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EUXlQ7h5OmSjgd8bigjv3LZZ2DhMnPUbLnTAAw+eTYU=;
 b=sEuIxi+G5OMRqoTp/Ix6TRl0jqfcMmzy7GJTAxCQrKGgwaNAUsCC0cPGfo+GIq9dQf
 l4aeugEuSYLaCb+rtrif3Ke/mfPHFSuwTrbUZdx8RWaon3EQxDgbjcqSkCE6LMPc15Vc
 vpbwwLvUv81yRBCyza+dDaNS9z4l55AO/PU4liBMDXIcyVzgXqGvoXTmr3VAIve/5gYM
 yXmK/q+rjjJ5XEK9dTR0fuNVV+A+9CIlt98k7G6ZPClvodwk4+OrygA2ExcUVh4rlGy9
 ijk7wT8Qna5//jfrN55HKdrlvXbJa27a1rxxLB0iLc6nFKBpAj8pB7NxRz8oi0tVnzBj
 sFyQ==
X-Gm-Message-State: AOJu0YyRyM1VUdhT2VPV6iVBALto3BdmEAy4yP847h09oAWfeC1TVcdn
 attdaw6rhzJdZAIxW/GiK9EXA1P7CZh9/4xXQkeU912NIaf1BgMIH8hvkZfQXusSqFkMHD46n8M
 4
X-Google-Smtp-Source: AGHT+IH4+ipHxh/0Zm9J0xu61unWuYqeJjx67dCjUBhVAgpuDrRf2IL16EV4U8h17cO6g3uEzaQtRg==
X-Received: by 2002:a17:906:fa09:b0:a3e:8710:4f2b with SMTP id
 lo9-20020a170906fa0900b00a3e87104f2bmr2160026ejb.15.1708343977325; 
 Mon, 19 Feb 2024 03:59:37 -0800 (PST)
Received: from localhost.localdomain ([91.216.213.152])
 by smtp.gmail.com with ESMTPSA id
 af1-20020a170906998100b00a3ecfef7f1esm248629ejc.189.2024.02.19.03.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 03:59:36 -0800 (PST)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: u-boot@lists.denx.de
Cc: marex@denx.de,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Subject: [PATCH v2 1/5] usb: ohci-generic: ignore ENOSYS and ENOTSUPP errors
 from clk and reset
Date: Mon, 19 Feb 2024 12:59:25 +0100
Message-Id: <20240219115925.12675-1-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Feb 2024 13:07:56 +0100
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

If a machine doesn't have CONFIG_CLK set the call to clk_get_bulk()
returns '-ENOSYS' error which should be handled the same way as
'-ENOENT' error. The same applies to reset_get_bulk() and 'ENOTSUPP'.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
Changes for v2:
- Changed logic style from !(== || ==) to (!= && !=)

 drivers/usb/host/ohci-generic.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
index ceed1911a9..8740094afc 100644
--- a/drivers/usb/host/ohci-generic.c
+++ b/drivers/usb/host/ohci-generic.c
@@ -28,7 +28,7 @@ static int ohci_usb_probe(struct udevice *dev)
 	int err, ret;
 
 	ret = clk_get_bulk(dev, &priv->clocks);
-	if (ret && ret != -ENOENT) {
+	if (ret && ret != -ENOENT && ret != -ENOSYS) {
 		dev_err(dev, "Failed to get clocks (ret=%d)\n", ret);
 		return ret;
 	}
@@ -40,7 +40,7 @@ static int ohci_usb_probe(struct udevice *dev)
 	}
 
 	err = reset_get_bulk(dev, &priv->resets);
-	if (err && err != -ENOENT) {
+	if (err && err != -ENOENT && err != -ENOTSUPP) {
 		dev_err(dev, "failed to get resets (err=%d)\n", err);
 		goto clk_err;
 	}
@@ -72,7 +72,7 @@ reset_err:
 		dev_err(dev, "failed to release resets (ret=%d)\n", ret);
 clk_err:
 	ret = clk_release_bulk(&priv->clocks);
-	if (ret)
+	if (ret && (ret != -ENOSYS))
 		dev_err(dev, "failed to release clocks (ret=%d)\n", ret);
 
 	return err;
@@ -95,7 +95,11 @@ static int ohci_usb_remove(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	return clk_release_bulk(&priv->clocks);
+	ret = clk_release_bulk(&priv->clocks);
+	if (ret && (ret != -ENOSYS))
+		return ret;
+
+	return 0;
 }
 
 static const struct udevice_id ohci_usb_ids[] = {
-- 
2.25.1

