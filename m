Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B350AC28B2F
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 00:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B5038186D;
	Wed, 12 Mar 2025 01:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kH1xVSaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D7BE81898; Wed, 12 Mar 2025 01:32:12 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8050C81970
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 01:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6e86b92d3b0so47864316d6.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741739528; x=1742344328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oc9Um/RvHPRMAO0dp4f7x0ocMtxF2CW9/LHB5Ar9Sfg=;
 b=kH1xVSaNF24rYUO70IuJVl7+QCwbSvCg5yUjcV/zOXMpO3bg+Ec+v8hqU6m0W6rcLH
 8f8ZwST5ObARjxciwbPxZmJeM59iaVW8ZuSAo0ckviu68nXHGadGYL8tgKIHtfKoPv7y
 K/b2hC7qUSHyFGthNln7rWrZxgpcN1fhqKknPjNNgK62i5RYHegZaHibuq5gqzpslhrQ
 q6f4xtZ7lOYTbjmIp0/QYAYzaEQ7U0W3cr3/H6ltG0uWc7kbZZO8bHEM89JUgrBo+76O
 aOx8EA1YUty6etMmaM24ugm290y1qzficpnxXKlS1cUwVhVJofX0TWex+RX6W6F+rMwQ
 W0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741739528; x=1742344328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oc9Um/RvHPRMAO0dp4f7x0ocMtxF2CW9/LHB5Ar9Sfg=;
 b=Pjw2oWErQMU7Zqu1ODW2tUN4ZzmJjRCYb+pXGszpFtkl9JP1DFPmpRsPlFvdFm4vJs
 3CrhVo8t2kzMF0bNNPij92txoHemA285xj7wA/o8CYgkW5PHXOxpb0l9w47pIOETF1uN
 5WSITd1flo2m4U96Xzl7OFzxfZ6XxwaI419W1kD2l1Kvb0Kmm2L5+1lpprTzrDRaRt7k
 5dc+HJagFZG9rSeiX9unce1/4nLTr4iInuDqNP9RsORi7Oc7R4FAeI5riLxZaMTIcY5t
 jfO9OrZqvv8Ix/fJs+5YW2AVNR9IY36J7QVq5hrUEVSN8YWFnMUTgIksKmaaGdW6jNlJ
 xV4g==
X-Gm-Message-State: AOJu0YxJJZEtvtDLV7Z8/xO5TKScxn7oEnJU/I2GvB7UFJpLMsG7YSFY
 YXsU/J2saGBWUdVj4V0hCae4Ktuacyh/8YzAR39aL1peSGVYUla7FE14Hw==
X-Gm-Gg: ASbGnctb+M7UquXvjGPmyz2dTB2JuWwSyIzQ6wg/B1b9lYOP6MChxyhINbQubWiKIrl
 jCecUTFLq+lOIZZH2l0Aahu5Yu6klcT9F+lGHoGW8Ihy1l/UIFjQ4oRT67vmQC3ARASAOk5qMBe
 3RLWCZ41wA3Qty4sA9og93oAUmqkIdGnljI4TB8wxNCOUEDeEd0KZ/nb39kK1hYIG3xty1137XL
 0UH3Qa780r3uu3WX+J2vL2xHo7TC2Ht5+cMoAD2OpkHBowch6VjlEUtiMyLOKI3nHeQ3eEHLGox
 Br8BYaldlaXTSAqSCjET3r6uZEIQFQGz1R5tVlcq8XMQED87A+R4BqJEumKaNVIa3D7jpMcXtl9
 HbDtDP856f+Ex0D1tcT4=
X-Google-Smtp-Source: AGHT+IGf4sJZWdS+zNkMBIG40RjDvBbGDLzdu9ObCYoOwJsbMhlfjaAbj1DbQWcN9quLpbQpeakq5w==
X-Received: by 2002:a05:6214:1c48:b0:6dd:d3b:de38 with SMTP id
 6a1803df08f44-6e900636d6bmr309865036d6.16.1741739527759; 
 Tue, 11 Mar 2025 17:32:07 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b798sm78025286d6.80.2025.03.11.17.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 17:32:07 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V2 10/10] board: beacon: imx8mp: Let clock system enable UART
 clock
Date: Tue, 11 Mar 2025 19:30:30 -0500
Message-ID: <20250312003041.110023-11-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250312003041.110023-1-aford173@gmail.com>
References: <20250312003041.110023-1-aford173@gmail.com>
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

Now that the UART driver can enable the required clocks, remove
the hard-coded clock enable.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 board/beacon/imx8mp/spl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/board/beacon/imx8mp/spl.c b/board/beacon/imx8mp/spl.c
index 30d577f7e0e..6b357d90a3f 100644
--- a/board/beacon/imx8mp/spl.c
+++ b/board/beacon/imx8mp/spl.c
@@ -112,8 +112,6 @@ void board_init_f(ulong dummy)
 
 	arch_cpu_init();
 
-	init_uart_clk(1);
-
 	ret = spl_early_init();
 	if (ret) {
 		debug("spl_init() failed: %d\n", ret);
-- 
2.45.2

