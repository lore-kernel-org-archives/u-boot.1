Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C91C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 670478141D;
	Thu,  6 Mar 2025 17:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G+OadNDD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD52C805D7; Thu,  6 Mar 2025 17:04:59 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FAAD816AB
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85ae9566c52so23724339f.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277094; x=1741881894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scYAFHQt+yZLnJPuXsDZJw8jiztjZtxUpNqeXfeVN2s=;
 b=G+OadNDD0+5OoMEmvKho8JLk2gWuXRcAe3ZfDKAYYsTwgD9nKsRkRXHPHYYdKOuVFq
 lJdXnm8FPkpwS8U11yvu4ReF4Y2w/lIbEnq9NdwhqVjb51Bbu/tPs808MIHr3XwvIqcL
 hghgASyzii/6V9ORJElOnqbhmfvZAcBNRgst8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277094; x=1741881894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scYAFHQt+yZLnJPuXsDZJw8jiztjZtxUpNqeXfeVN2s=;
 b=EfVvE1jQanJvWIFOYza6SkXLs6O9UcQZq6aOrZW++LCHZ0gFiLIYX+CDVuwjVuek7x
 FPV0GounXgNy5kOZ1zGPoAxFzX80DF9scCumRRAQVEPIFwuhf26Ur8O5igFTr4Zs9Vlo
 i38IDcOGKtMgoJBBJzg+5IVdK1ZOLmUaD8lY9jj3KYv//egtvgngplVzu+ufgKEVXmyN
 jVny8Pbl4M2u5WsQkHm6wLr61MAc+QDOLRnvbL+scmd5peIwp/9a1ZVQ8InucRg06rH+
 qI2h62gCOp0OLqRu/Hmrt0zP6zz67ZLoqsyBANDkJLBtUcubJBHMpUOArxU+SqxCWsT/
 OEmQ==
X-Gm-Message-State: AOJu0Yx2SYrR5bkKmuDvnTuIGHN7VHjSddQlyakvaQCa3z/f7hM2EDcI
 NdJkWGi32nhK/v9iGe0NDW3QsWNHPLFNqYOs5sRCS0teDiLJrfN8pKoIKTJJCjeaw47L5wPjjK0
 =
X-Gm-Gg: ASbGnctWIzylRpnqraSq7R2wqABsjwaLyO43REkXJJXoTo9SxxmubqIdkEDS5miQL11
 EyO/g5Sad0bP/5ZKLCT8zG04DQu3srn5gwtNnIowEJr9sL5kMJkHr1ZmNekEXpknsEbIvyi2AC7
 yfHivRv2CpxZBpGt4xh1rF9nRe6D97YkL2I/0Pf9olngMT7ZbOaoCsxDSFRm6w1xDYS7wyfDnIx
 EcorT6B+SURTxyu5ddAAgK37Vt9S9XGIJWjvXFozNq1oPMfXhE4H/yZhZOXP4gtfeXxlqqyqCYP
 3lqL+i716c+Iwz8H3SeLopsZ31D/va7hrB8KAKuaYCUoRwSFC3ebeDaSvvAEtYtozrPZNywDNvY
 d/YfTCQ==
X-Google-Smtp-Source: AGHT+IGrDhWIuTeARQoX0n52NIjXDCU4PV3dfKlAoDGi0UFWbweufFaR2W6GRjviMc5psIKMzaJb6w==
X-Received: by 2002:a05:6602:474d:b0:855:b345:4893 with SMTP id
 ca18e2360f4ac-85affbb4dc7mr888719739f.13.1741277093043; 
 Thu, 06 Mar 2025 08:04:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:04:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 04/47] x86: qemu: Switch to bochs display
Date: Thu,  6 Mar 2025 09:03:31 -0700
Message-ID: <20250306160428.3041057-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

The vesa display is widely used on hardware, but it is a bit of a pain
with QEMU. It requires executing option ROMs, which either doesn't work
with kvm, or is difficult to do in a kvm/QEMU-friendly way.

THe bochs display is probably better anyway, so switch to that. It works
fine with kvm as it doesn't need an option ROM.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/31
---

(no changes since v2)

Changes in v2:
- Redo commit message

 configs/qemu-x86_64_defconfig | 5 ++---
 configs/qemu-x86_defconfig    | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index af275e8ce8f..ff2a192ee7d 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -83,9 +83,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_CONSOLE_TRUETYPE=y
-CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
-CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
-CONFIG_FRAMEBUFFER_VESA_MODE=0x144
+CONFIG_VIDEO_BOCHS=y
+# CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 0b0e10c795f..ee5b150e062 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -62,9 +62,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_CONSOLE_TRUETYPE=y
-CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
-CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
-CONFIG_FRAMEBUFFER_VESA_MODE=0x144
+CONFIG_VIDEO_BOCHS=y
+# CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_GENERATE_ACPI_TABLE=y
 # CONFIG_GZIP is not set
-- 
2.43.0

