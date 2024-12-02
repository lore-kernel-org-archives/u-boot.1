Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFC8D4978F
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 00:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2320A89275;
	Mon,  2 Dec 2024 01:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U7cnrHkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 783C0891A5; Mon,  2 Dec 2024 01:12:57 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 362C2890DA
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 01:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-296c237a121so2325044fac.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 16:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733098373; x=1733703173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jfq0IHW9IfzvXCvBnRY6AwKzIMAqEPCQFpINekNg2R8=;
 b=U7cnrHkx1d+S0I5YfSJ7+ut0m8AhIufG97Ch1WQSKBYD0lAal6yqiJcZYlOeBeIkiz
 3tKzWX3ZcoNAInhsePv4QABIPYLiuKtEMvTu3yccVXHLtziVQFKCYiCFwOWDpVqUwpbv
 c+7AzGdbgZCj7+n39MWy/RYyNPmmV2+Hktv6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733098373; x=1733703173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jfq0IHW9IfzvXCvBnRY6AwKzIMAqEPCQFpINekNg2R8=;
 b=w/feDRbSYpsseOlENDFxfS0cTicLhe8/r3uY7rS6lBt75OaUNjhl5RftTM/bUyJxBv
 BJpZCw6BjhpDGuSh/ULtOZMI2/WPdThNaccDXmHKuNkVEJ/vrViZssSaqds9D/Hsvto6
 CBGkfJVLdS5aBcgd739C7rFRTNOl1UHS0pGOrY1W2TVjfiJqR6BtLq5Po/qo6lEvdpYb
 tri4DTpnqp+JLUdsPNN01HlaBCTHKmFZQc8kO4NlCyi3niFdGqY2RJ57qOKxfpulNp8a
 kUX733IOcfaqdo6ukik65SilzG6cNmUH0ZdJvEpKxUCzZyXKL4nK3T4rsK7v9EYHzDm5
 KQ0A==
X-Gm-Message-State: AOJu0YyVWhJRT4V8u+q1ikB5/LHrbXFfSoopCa8YIPPBnZYVy2mErfvt
 dpZz5QGYIZU2oYWL/qdKf/ST8skknYMTPWGsH7krkqs5wqVKiMUCD7u3hxnoxuN7DBNyP+r+rYA
 =
X-Gm-Gg: ASbGnctujHcqy4l0wEQfESUq/ZgfEBWMYcFXDf4mJTd7HeaDHgX45znKJxSFB3VNfNq
 6eSmR7Muw7R2nETbU5zRxNBg7mEqxoWrs8WMiuaXxSXlvD2bmPJ4bcS60ceRM5Jik/KFhB0vIdf
 5U+VxL1FnWrLkP4gLD9JSQDNnnHUFugR1QPkaNxf33eS09zkisBXDsY2jxs+CaJNY+CawpU2IU/
 4RsvBGGoo8ojj20E0Qhpz1N+hUPqxf2AzDYc6/4nultyw==
X-Google-Smtp-Source: AGHT+IGbKYqto1hJ+unlhgMPOk4UmcFKb9nGpSXwv2J9aviP7RpuYGS8czz/0c0iYRqpB3dc6XMPfQ==
X-Received: by 2002:a05:6870:b4ab:b0:29e:6211:1262 with SMTP id
 586e51a60fabf-29e62111d57mr1541492fac.0.1733098373483; 
 Sun, 01 Dec 2024 16:12:53 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e6ef90f5dsm14615fac.51.2024.12.01.16.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 16:12:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/7] efi_loader: Fix free in ..._media_device_boot_option()
Date: Sun,  1 Dec 2024 17:12:37 -0700
Message-Id: <20241202001243.1283274-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202001243.1283274-1-sjg@chromium.org>
References: <20241202001243.1283274-1-sjg@chromium.org>
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

Freeing a NULL pointer is an error in EFI, so check the pointer first,
before freeing it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_bootmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index e3b8dfb6013..cb5ea0e4040 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1186,7 +1186,8 @@ out:
 			free(opt[i].lo);
 	}
 	free(opt);
-	efi_free_pool(handles);
+	if (handles)
+		efi_free_pool(handles);
 
 	if (ret == EFI_NOT_FOUND)
 		return EFI_SUCCESS;
-- 
2.34.1

