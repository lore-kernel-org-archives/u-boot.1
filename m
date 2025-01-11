Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E73E7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA2F806B7;
	Sat, 11 Jan 2025 01:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tgc1s1xw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B328C8069D; Sat, 11 Jan 2025 01:01:01 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89C02805E9
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3ad272538e8so12610405ab.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553657; x=1737158457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3hSyd1PULWCTmgR6E9Rcx+Khr2hPT1z85vFUYlsF6Bg=;
 b=Tgc1s1xw25waNRfyEAhVdorWBrvh+scNSaPQ/Sjq6ImC5wLTOBdaV/4MHk4JpZdEc9
 UgPd/LmSemff6HJUbUEG1DfJXcZ0TbYD1XYq3JpcmS6Sl4clRVZy88SWXmbe2mYiPlmE
 Gj31Iarzn6ykk7yMudz7EXvtQexq/vG39wGI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553657; x=1737158457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hSyd1PULWCTmgR6E9Rcx+Khr2hPT1z85vFUYlsF6Bg=;
 b=thqsj++Uf1qjKqdN0IL7vTW4rv/tgm4EsFf0JLYjzs07jkF+sGrNfCKW1KdeY4aNZj
 DfJgcEUPCPFlzhbQkwEdaQuaSLtIxMUKCmnDzj3BLeGXI43zsXlcBbfBvtTwtT1fthHD
 QwrG7uWfBKWCp/OoNCcXxVzvRpRwuKNH2MVbxzRtnwBTGteDdDkmpx1wiJ7DcRErvd2V
 Nm0IXlJlFBMlqn0LRtRVQeNfNGQU8eripyT2O70H7s2+sl/kl9d7x+YFnTFmjIh0S7Tk
 fSdDR1N1PjQaNGOIfAKa13+vLJNVOiBakO6zWRJpNxASWLBPIoFpWS3i01oj+DWc2fJ2
 Gv6Q==
X-Gm-Message-State: AOJu0YzKuaRzjreC/gTVvYL0v7EnExtp5k6/Y+Afl2wUVZtv/65aEXo5
 ao0h9+YAs1JH8V7sY0KM5QBBMxBAAPYZ3zGppYmfwIAqsy6MgrRpqpivZY+yuk8nlAX03I8E9/I
 =
X-Gm-Gg: ASbGncsfXyshpNm3zC2Zx8kDaIgBFu8/TetrQdQz/JH5ASeLssYYEn240mjovhnEX1A
 6HwPxJmN6fKMU55rcOCQ+YJGpCq8T1MbSmzbagybj1SP8K90JmAqx34oBfBBoxJG32x04SJFG0H
 dLjoZJtw+E1Fd0SSQbtJAbeQFUFZuH29zAYi6i0Rr7mcvdfDz78aZJ2WsGyWQ+gr/3qvzt0YiyS
 tEThBCSopQ3cB8CI5iiXfnoZDBM7fFF3xpyeDvR6Yal8agWMyv0WIfcwCd6s9ZjXcXDZpzFT8R0
 KJbxhqTaf7dz/cnLgw==
X-Google-Smtp-Source: AGHT+IEnQxQA0lnGpHZaj7lp6Pc6fxKFCnaPu9BBHn57w8/9TkH56KtcJU6LjDzsaWJc/FziUGpLQg==
X-Received: by 2002:a92:d402:0:b0:3ce:3517:b831 with SMTP id
 e9e14a558f8ab-3ce475fbb61mr56515945ab.8.1736553657365; 
 Fri, 10 Jan 2025 16:00:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:00:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 06/30] serial: Support info() method in ns16550 xPL with UPL
Date: Fri, 10 Jan 2025 17:00:05 -0700
Message-Id: <20250111000029.245022-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

UPL needs to pass the serial details onto the next stage, so adjust the
condition to support this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/serial/ns16550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 3f6860f3916..5126cf8bc1a 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -473,7 +473,7 @@ static int ns16550_serial_getinfo(struct udevice *dev,
 	struct ns16550_plat *plat = com_port->plat;
 
 	/* save code size */
-	if (!not_xpl())
+	if (!not_xpl() && !CONFIG_IS_ENABLED(UPL_OUT))
 		return -ENOSYS;
 
 	info->type = SERIAL_CHIP_16550_COMPATIBLE;
-- 
2.34.1

