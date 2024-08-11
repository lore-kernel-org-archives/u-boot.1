Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D43C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D778788617;
	Sun, 11 Aug 2024 16:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NbVCXOm9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4283889DF; Sun, 11 Aug 2024 16:52:35 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C75E588875
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39b0826298cso13071605ab.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387952; x=1723992752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fn6taKCgx/ZA4Wh9YCprniYz6cyu/bRt9qJKUSb8eus=;
 b=NbVCXOm9/OLUkoKhXHApjuUDOndKsSaYeKIIiOW9IAWL6ITukxTB/ZO863O8NKzA5s
 ek2fcSisjuvsSU24lTw/ncpo7mp25E3B5lGF1xmXHV6rD+wr0W/x3L95FFkZn0lYAr1V
 BS0W53ZJlBYy9/fU9ZJ8DhHVT2EnmJkvhDV3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387952; x=1723992752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fn6taKCgx/ZA4Wh9YCprniYz6cyu/bRt9qJKUSb8eus=;
 b=DhPwt6DKBEE/TVErL8I+VF7tPyIhAXTDQxjtdIT6s54dZcN/gkZOTSKEYb3IZ0ysxQ
 CkqduCIFGsf+iVv/n0Uwa4hhxLzmnmQnnFJh5fvHRQS5VCSLsHXOb1q1AnSohv17fF99
 2dVPGR9NEBgd3EzKmWPnafGIHKGAmpsE+UrZkWCAyWXBqwyy2UwJUcYihcuulmNbUTzi
 y01tSq01hp2/9bwyk8ybJ0sD2Hgr1Z/eYkxRAPIYA4gJfJFsxiyimc4fwGUZCD+oAbpt
 QaqqX8Y2Hl4FOjbYH1x8kvKa1M4wS26q6d4zsOfK20D5mG9RKsvPUUi81zMXT8mx/hEf
 Ebgw==
X-Gm-Message-State: AOJu0YyNy1X2W6QBdX3gaF64fvqiUysRlF5bQ5tXm5//enL+hkClZWD2
 o82gpM25I7nhGxNcPW0iKxB/+dc/VkWRugpZFyunCqj/V+ELJpYxQYfx/FGqkkNxsRt/PoWTSHQ
 =
X-Google-Smtp-Source: AGHT+IHwndeETcazFOmKZeDpjGeyTgXflFlfPastx+VLKviFB1hreHc/XvKktWj3oyF6r4JCapzjTQ==
X-Received: by 2002:a05:6e02:148b:b0:397:3a28:94d7 with SMTP id
 e9e14a558f8ab-39b7a463157mr90264805ab.25.1723387952415; 
 Sun, 11 Aug 2024 07:52:32 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 01/40] nvmxip: Drop the message on probe
Date: Sun, 11 Aug 2024 08:51:30 -0600
Message-Id: <20240811145209.4191404-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

We should not need to announce this device. Drop the message.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/mtd/nvmxip/nvmxip-uclass.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmxip-uclass.c
index 254f04e0b99..58e8c3fb74b 100644
--- a/drivers/mtd/nvmxip/nvmxip-uclass.c
+++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
@@ -47,7 +47,8 @@ int nvmxip_probe(struct udevice *udev)
 		return ret;
 	}
 
-	log_info("[%s]: the block device %s ready for use\n", udev->name, bdev_name);
+	log_debug("[%s]: the block device %s ready for use\n", udev->name,
+		  bdev_name);
 
 	return 0;
 }
-- 
2.34.1

