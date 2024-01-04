Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FB3C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C7A879BD;
	Thu,  4 Jan 2024 16:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E3xNF+Lw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E226879B5; Thu,  4 Jan 2024 16:11:09 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D8A87994
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7bb982d0f12so43107539f.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381052; x=1704985852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAQCA2+L8S+5OKFmSgZPF3WL7XCVJOyD3jGB9qjlr1Q=;
 b=E3xNF+LwqEdJL0/wuthMyQqg98dJlycBfgQIQx3RdMGXloDMlIGaeNHp9dj031I3EY
 eauiPkK1PmczWAwNKkFAKqCgj4N4zJ+vFEXx/QFEh0pzdhH8EBlquIwKCLh5/7+0v5CO
 YmezRDovoSdEosvr4QY8xX3yQUllZ9BGXrKu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381052; x=1704985852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAQCA2+L8S+5OKFmSgZPF3WL7XCVJOyD3jGB9qjlr1Q=;
 b=o2EjVeeSi2A2qTc105utF99BBqDu6qLw04N76VGmojhfVnRqnNAjRNoWoVEGA4dCQV
 rsSpfkEAo19d0ZoWW/MBE077eqe8Gj3ObyEVE0hhNp1t3JgzjABzXRxJv4JngBFBYtg7
 Baz2McsL1B1wLt228oDr79iiP1G7TIBLLr7q+Z6+sRWHgWgxbvnS/gRlFeqvDAcBp46l
 P8Sw1K73LD/MFxPPt++D5Rs9JTo1YL7T6jdA0LZQMCJgNV7/Dqg81m4eodBtTADYfUGR
 9v1mMa2vGSSo5rsTTFevCtrkfEwoZ3ioCtGdyzeBc3st8cvULMnVt/Bqf6Xn59P6kXI6
 r0Tw==
X-Gm-Message-State: AOJu0Yz6GVnKNGNmgLaRpV30OlQAzuE91go8U13t1gdPsBjLyVVGBXqj
 XqQTE3kCelj8kcIb99I5rQpphjew24zK8YJqYMZgOb4i2wNz
X-Google-Smtp-Source: AGHT+IHKGtjhho94H8XlnF5DxIDBQI5UgRF5OICVleGRtK1i58J6OfSiw9pqYrEh0W7htYlJzoE8Dw==
X-Received: by 2002:a05:6e02:20eb:b0:360:142:3fec with SMTP id
 q11-20020a056e0220eb00b0036001423fecmr359057ilv.6.1704381052163; 
 Thu, 04 Jan 2024 07:10:52 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 z14-20020a02938e000000b0046d710cef38sm4937310jah.159.2024.01.04.07.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:10:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 7/7] x86: qemu: Enable truetype fonts
Date: Thu,  4 Jan 2024 08:10:42 -0700
Message-Id: <20240104151042.695717-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151042.695717-1-sjg@chromium.org>
References: <20240104151042.695717-1-sjg@chromium.org>
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

Enable this feature to provide a larger font choice and more attractive
menus. Expand the ROM for x86_64 to 2MB to make space for the font.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v6:
- Move 'Avoid unbinding devices in use by bootflows' to another series

Changes in v3:
- Add new patch to enable truetype fonts in qemu-x86 and qemu-x86_64

 configs/qemu-x86_64_defconfig | 1 +
 configs/qemu-x86_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 79cdb0bddb2..f084f8e2989 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -81,6 +81,7 @@ CONFIG_SPL_DM_RTC=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
 CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
 CONFIG_FRAMEBUFFER_VESA_MODE=0x144
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 9bcf06c137f..b0d397bae08 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -58,6 +58,7 @@ CONFIG_NVME_PCI=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
 CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
 CONFIG_FRAMEBUFFER_VESA_MODE=0x144
-- 
2.34.1

