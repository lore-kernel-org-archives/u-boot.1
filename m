Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A16D3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A64B89352;
	Sat, 19 Oct 2024 17:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RXDQLJcw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B08CA8935F; Sat, 19 Oct 2024 17:25:10 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED1888F8E
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-83ab694ebe5so84366739f.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351506; x=1729956306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/VjW6XJLiWWZh8Wssv9O65tOOdpsNsLSpdILY/aWO4=;
 b=RXDQLJcwM+xtdgQxKn2X079kUAehuXY3CPDUVv1SOuJb9GAuBaw3zWTipiFlgiOd8e
 +SAx4Pcfp/DzDsC+3k7/0+FwMQd5XPShjoVFe+8lEGpt/XDFZdcvzlxVAp0suMJByAEz
 8dMCS+oVWZIDmnIPq6K5Oy3qqBZqONJXRgbvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351506; x=1729956306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/VjW6XJLiWWZh8Wssv9O65tOOdpsNsLSpdILY/aWO4=;
 b=H1FOc79EXtBxlOKMe1Y/L/pQY9hOIhfs2s2/PZQfmQ/yGiYatC9URBhbmPSdQgkXuT
 12OeBDUE5VFzm0YGmOVcVKH6X8XmYfzN6IrLdmBDt3c5LHRjF4KsTgqSGU5wvbzP7LKH
 6Q8OVVhGDDztk7JR0EGwD4SjX359CIs4jxP7ALqJJcfTcUFAKEH9QAP/Iyrph9SzQogp
 oaz/IhHBG31MiMn7b5R6xSqiUh15QJVUgEHzHgYA9RuzPjiA/Fl7okekGRRIR+uNcUP6
 n9NA+oc0pW6nO6bMxaHRXEsDTQ4pN6RGVoG7QaynNJEJqT56S6GQj93Uwcm2G3efpYo7
 haVw==
X-Gm-Message-State: AOJu0YwREBmncHCN0CkVfaR1U81WxlQ1zjZQruXdr6++Icq+0q8oXKjH
 ghOCPYrtx2YD30lmO1XTvIhcLZ/+SnB9+v03CK8NVTYf1dIsaiXX7l58lhCQeVuVO6u3VHjno84
 =
X-Google-Smtp-Source: AGHT+IE86KnX9Yu3xpQDkufsWLcroHc0tWNGVuM3aoB4ZSHclPc6h0oqIUFLD7Sq7UQYfOq4SJ1AFw==
X-Received: by 2002:a92:c541:0:b0:39f:5abe:ec25 with SMTP id
 e9e14a558f8ab-3a3f40a84e5mr60248705ab.19.1729351506665; 
 Sat, 19 Oct 2024 08:25:06 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ada8sm1036833173.23.2024.10.19.08.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:25:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v7 5/7] sandbox: virtio: Disable the sandbox virtio blk device
Date: Sat, 19 Oct 2024 09:24:32 -0600
Message-Id: <20241019152434.1017394-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152434.1017394-1-sjg@chromium.org>
References: <20241019152434.1017394-1-sjg@chromium.org>
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

This is not implemented so cannot actually be used to read blocks.
Disable it until it is implemented, to avoid causing a hang with EFI,
which probes every available BLK device.

Signed-off-by: Simon Glass <sjg@chromium.org>
Issue: https://source.denx.de/u-boot/u-boot/-/issues/37
---

(no changes since v6)

Changes in v6:
- Drop the patch to disable sandbox virtio blk with EFI
- Add new patch to disable the sandbox virtio blk device

 arch/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8f1f4667012..c39efb4d0a2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -212,7 +212,8 @@ config SANDBOX
 	imply VIRTIO_MMIO
 	imply VIRTIO_PCI
 	imply VIRTIO_SANDBOX
-	imply VIRTIO_BLK
+	# Re-enable this when fully implemented
+	# imply VIRTIO_BLK
 	imply VIRTIO_NET
 	imply DM_SOUND
 	imply PCI_SANDBOX_EP
-- 
2.34.1

