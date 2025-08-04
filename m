Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71837C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 16:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9446783F9D;
	Mon,  4 Aug 2025 18:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qb9yZpt4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7133B83FB0; Mon,  4 Aug 2025 18:04:04 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B611383FA5
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 18:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-458b49c98a7so18432505e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 09:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754323440; x=1754928240; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4qGV1ZSTuQgR3+GHiJIy4FQrdLh0X3hvp+ApzsuMSwI=;
 b=Qb9yZpt4ZJ0aJn1B/pZUTOkS+5/B7vBAp1hssN02CwvC8sTO5HlJAFd7kaiL8ZAMWG
 PcbMFTIUnDokOqXmGbrEvKS9+eF3Ilney6jcRVGN0eWsQ0H7AePnxecRFl5RAtiZfflp
 OwFP6hx90GDPBv4rL+r8j0QDzaVyMRaR1paSU53rYKcQPu/zC5z/joXGnxi+vKc4f1zu
 QS+XT9zgk8LAFL8YGw/oEt0azvyrApy0TAuJpl+1w3D9JKGCYGT37h1z49lWTT1IwN7b
 LqaV7gHJlL9vLoUZ679k6OwQtiOIEazhS9DIBpk9g+Y/xhkrAdzGxnDk545hzFD9Nsd8
 +i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754323440; x=1754928240;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4qGV1ZSTuQgR3+GHiJIy4FQrdLh0X3hvp+ApzsuMSwI=;
 b=DcWKWVIk2ftAwe8WQIppwS+xHDXcu9CORKCQ7wMKZ2LNS2QZVzR2iJuRSQLOcdhFz6
 tvdyikX3A4rBNXMbo7klVxII4FtG9zLjIxmDt3jaOv/ngbhPtjpu4azzzm/6hnjMANIP
 2L2Ph0lGWqOa5IiO6538h7LJjYZeu5uX+GdUACBjo+4TpM5frBhJ9peacF1vFUI/CXgr
 pJOTpxlkodwUdpOVidNh/AXLlIVjmsPVUJLxnKCUKS9OxCJYJ8LCQqUzkEeyANLv4OOg
 ggm0iz5XsxpzlcSuOuEikNNDefQZLZTwjiMBICfEw82XTU4IJN/lEcZeMpgHQa5qFN+V
 RIEQ==
X-Gm-Message-State: AOJu0Yz/k/wd5QHc0/Ga9bEYtzd4bsqmk7PQjzGgSxpLowuiW3GZ6Tzg
 QwFLUbTcmYIgydkEIgSnqz5X5/1IwDyUNp0OaX2GuRXwg3jdSiXzDosoW8zQqVltAdk=
X-Gm-Gg: ASbGnctJ78v8u6fBOBKTVhTBwj5qvQz+H9t6QZfLLqSSAh4S8NYHj7KOLN3S1fQ226B
 y5KmSXyiR0n1pMjC5YmHdJsJzH20Wdszsimm2+D6oxfhgYYs5U3ys+x3C4zrty0sKxWwhRkzqHR
 W4XECFxLaiDYROC3Qlx0AyvPf0MBo8Isg99V4ZfGLa6AQavblev5mDMEhuEqR/GinhD7zr3/oTJ
 Qa2MnLzxmTbpzt2f//HN8i8GsmKtgddQco2hnPIaAKXxHpcJXBlgRQ49SwgpzM9dlyb8fUctoxk
 nsPI8C6v/s7cfX01q0/7twNsUq7N2DpXQGsyKgM5/yaRor09Gp7lw3rnbQjWT/hWosmo7kI+PAi
 EVnHzh8+5sZdpCIYIj5BhqeCe16PISJ54tUU3du4fahe4L1R/GZdRYA5Ueunw6w==
X-Google-Smtp-Source: AGHT+IFNKUX0SfE4QV9nnWo2qi9doqVeP5hDyQLdI8lqFmVCfJiuxHNGH1X4mlGAQo1tlTWAAkf7EA==
X-Received: by 2002:a05:600c:3556:b0:456:201a:99f with SMTP id
 5b1f17b1804b1-458b71aa392mr83569925e9.18.1754323440084; 
 Mon, 04 Aug 2025 09:04:00 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac036sm15901598f8f.15.2025.08.04.09.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:03:59 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 04 Aug 2025 17:03:58 +0100
Subject: [PATCH 2/3] net: fm: NULL check dev before dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-net_fm_eth-v1-2-994a4652fe17@linaro.org>
References: <20250804-net_fm_eth-v1-0-994a4652fe17@linaro.org>
In-Reply-To: <20250804-net_fm_eth-v1-0-994a4652fe17@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

In fm_eth_bind there is a dereference of dev before it is NULL checked.
Add a NULL check before the first dereference and remove a later NULL
check that is now redundant.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/fm/eth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
index c83b789693a..f0e7c0eca42 100644
--- a/drivers/net/fm/eth.c
+++ b/drivers/net/fm/eth.c
@@ -727,12 +727,15 @@ static int fm_eth_bind(struct udevice *dev)
 	char mac_name[11];
 	u32 fm, num;
 
+	if (!dev)
+		return -EINVAL;
+
 	if (ofnode_read_u32(ofnode_get_parent(dev_ofnode(dev)), "cell-index", &fm)) {
 		printf("FMan node property cell-index missing\n");
 		return -EINVAL;
 	}
 
-	if (dev && dev_read_u32(dev, "cell-index", &num)) {
+	if (dev_read_u32(dev, "cell-index", &num)) {
 		printf("FMan MAC node property cell-index missing\n");
 		return -EINVAL;
 	}

-- 
2.39.5

