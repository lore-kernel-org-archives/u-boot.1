Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739D7D711B4
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0829089346;
	Wed, 20 Nov 2024 16:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hzx5s8cX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE34894F9; Wed, 20 Nov 2024 16:36:13 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6CA389346
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a761c7c4fbso15921645ab.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732116968; x=1732721768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H9uWqvN6tnFtBQKI1m6KGLcdSCXOfKBsqUFCwaj1bJE=;
 b=hzx5s8cXCMyAGsN0ToPIBrHvjtP/TAvnDYTMQgenuEqPbfiXX1web++dcIV2alGMDD
 +3ZtiZF3gmAjTwchBUybNxMTMlj15oAuLte7iFE43WNJHqQ8XkINMqdLeWIT/2bPMq0z
 V8a3Eepub2PAEVH23+dbgihvDCTA6mXYsnJUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732116968; x=1732721768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H9uWqvN6tnFtBQKI1m6KGLcdSCXOfKBsqUFCwaj1bJE=;
 b=lezk1PnvnstFVfjYzJzpsZxFO/TKtiAxi08fqraaNO1XUUDed7Wsq954zD+sWEWu0Y
 GYdjGUHdwCBZbHeeJ1uMaPwaOD0pMCZJvZJNO9DLB23iuJo2zVBELkQb/2jGEGhQlCau
 yQzTc+C8ILj8IV7H/VtuBBbC5T8YYxHqLnmtU/l0zAHr3l5W7GghDYnDpms6QZSfV0x0
 hA7BJD+9JLROFxp08AOXnNftDiMDLSYaKGUWxSYLN37yxLQ5UGkyoXx1JPaW7nSFEGMa
 tOQ+eh1UUsxptdN9ZDZT/WBuj9050hSKd6MWCZu/SYpeXZIqy2bKDLqhTDOsvP3x0J87
 VJ/w==
X-Gm-Message-State: AOJu0YxqFu/fll4faeZftDGKrqKd3VjCCsvfWsnNqV91EHh90QpoCV5Q
 bmplzOhoAv53Yv+y45WQ/SZv98LCNw5LJAmhepuPoweK3yQlfNLCUmtiUnamlycGMsOScaL1kkw
 =
X-Google-Smtp-Source: AGHT+IEziQ/75vY5Z4Nhqg635AdRyXwRvpV5xvh2iwRSy1UdxIDQG843gsFhfPjVxTLEP8gw3PS4fw==
X-Received: by 2002:a05:6602:2cc4:b0:83a:d3cc:779a with SMTP id
 ca18e2360f4ac-83eb60506e6mr378684939f.11.1732116968682; 
 Wed, 20 Nov 2024 07:36:08 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6dffd678sm274395139f.23.2024.11.20.07.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 07:36:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/3] serial: ns16550: Avoid probing hardware when disabled
Date: Wed, 20 Nov 2024 08:35:53 -0700
Message-Id: <20241120153554.860710-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120153554.860710-1-sjg@chromium.org>
References: <20241120153554.860710-1-sjg@chromium.org>
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

When a serial port is marked as disabled, don't try to probe it, since
it won't work and will probably hang.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/serial/ns16550.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 3f6860f3916..6576be4b58e 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -533,7 +533,8 @@ int ns16550_serial_probe(struct udevice *dev)
 		reset_deassert_bulk(&reset_bulk);
 
 	com_port->plat = dev_get_plat(dev);
-	ns16550_init(com_port, -1);
+	if (!serial_is_disabled(dev))
+		ns16550_init(com_port, -1);
 
 	return 0;
 }
-- 
2.34.1

