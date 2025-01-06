Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4018CE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3EA4805EA;
	Mon,  6 Jan 2025 15:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lspmIf3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0B5801DE; Mon,  6 Jan 2025 15:48:08 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6D0801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844e6d1283aso540464339f.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174884; x=1736779684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0Is/nvzOl+svd/+HHqkKR+8UQXts/7MmRrI4zMmy2I=;
 b=lspmIf3CM+PsmiHupPhX/Dfu+DPZ1JBy5cI4/iQglVxVd3ZuFTpVKOOjRVsI7iCt4J
 3vW4sIqts67oeKyyRzvMAre1v/nRZM6gdvq/C6fIjdyQkPaGs+Wo+K1c8XNXtE51oYlv
 ic1AP3UyXE95yYbKcuM5FJEMtjYHElveCCg2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174884; x=1736779684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b0Is/nvzOl+svd/+HHqkKR+8UQXts/7MmRrI4zMmy2I=;
 b=L2mehguyza80ohHQpWbdGncMt8ahMdzr6hZrizznkFsCfEoURCXXoNgIIQnqPnvclA
 jYc72ZzTUKtZu93Qah6qi4i/RuhGF3LSXeVUlB2Brn5HGKRhN0KYeFf8ZuIGK2gJQEXJ
 wpZGSdANs5iA4id6dvrKnPoxRiXvghboijo0tFbEbJeNqOyTV4bzV1U2yCGI71sVeAeC
 GpH0pmytgFbC4UsZh73K5u6ZvvRvHSRW505P8ECcODTWVhp1MlIDCRmcAlha/sQfFn7c
 Ea60dtaVTSScvRwdAYx6S5wKfSDpkIWJI/hsHbhnO/zTUr7RivBdiHEfWRMFgH04jxi8
 +PMQ==
X-Gm-Message-State: AOJu0Yw50Hl6nPfqJJgLTfMhLXrkokKTyiaHBqOu2WotoHouPAR/P539
 NKX8aKaef9a6e4rZnAxoMufoVg9aNlvJgzvsTPKNvHz9q8uJcHac+tXIbJR7RDAj1HW5EXZHfyQ
 =
X-Gm-Gg: ASbGncvmEFr2jNkGL3uFeFxlU8AHN0x5kLhOvc5v5VEnYw0qi7JGaWB0xEGWN1P75rh
 svz8Qb0wtdZxJbYZl5gMXkXt4c9dVH5oggbsofwTyFT+aGImY8i38lV0nf0OR1a/GcAhalYDvXm
 oT++UmUtH4zXKJTjKfvnVNNBH9Td4vy/phiwgqMozFxS3tQbuFQ9aYjqOox/rr84xHCfDa+O+2f
 kLQ4HKXFKGZNQ9t2Eoz01IYqfHP5DcmNJQrLixUPAuBtzyHnknPHHER4wIRtBzvcFBqhabPy3oi
 PEQzpzQagCVNvpdGKg==
X-Google-Smtp-Source: AGHT+IE4DODY7XwLB5/o42w7ugN4fX6DalN8Nd9KOG3d++kbrlgcD8Yfyu9eTMhkKt36wsAeDfBwaQ==
X-Received: by 2002:a05:6e02:4:b0:3a7:ca83:3f9 with SMTP id
 e9e14a558f8ab-3c2fed1d658mr529042155ab.4.1736174884603; 
 Mon, 06 Jan 2025 06:48:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c37bb139a0sm94081185ab.70.2025.01.06.06.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:48:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/8] sandbox: Make USB controller as having active DMA
Date: Mon,  6 Jan 2025 07:47:48 -0700
Message-Id: <20250106144755.3054780-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106144755.3054780-1-sjg@chromium.org>
References: <20250106144755.3054780-1-sjg@chromium.org>
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

Set the DM_FLAG_ACTIVE_DMA flag on this device so that it is removed
before booting.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/usb/host/usb-sandbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/usb-sandbox.c b/drivers/usb/host/usb-sandbox.c
index f687fe2c430..6d75ce80dcd 100644
--- a/drivers/usb/host/usb-sandbox.c
+++ b/drivers/usb/host/usb-sandbox.c
@@ -180,4 +180,5 @@ U_BOOT_DRIVER(usb_sandbox) = {
 	.probe = sandbox_usb_probe,
 	.ops	= &sandbox_usb_ops,
 	.priv_auto	= sizeof(struct sandbox_usb_ctrl),
+	.flags	= DM_FLAG_ACTIVE_DMA,
 };
-- 
2.34.1

