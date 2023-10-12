Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42DCCDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3318C86ED0;
	Thu, 12 Oct 2023 03:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ISicfNYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0AC786E7D; Thu, 12 Oct 2023 03:59:38 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8BC286E60
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-41819a68143so3038631cf.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075803; x=1697680603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZvt6rHVxnKQNPgjKM0jsFwi1qs/5NWKk+ME4MnDPvI=;
 b=ISicfNYOAJ9Qf96OaqiA3FlNxgCBFN/VfAk6+rGbcuk8slQPO5JhlAM9XW1ssD8rFz
 w2cubFFgJZ+wWPN5oi0aRUpBJf0/Ip4XxO1hT2bDe0iaPQCBhLGbhNTzbiDC7lLzlBqA
 FN8YIAv2xXIGymN15THVP1ig8lMmC6uS8Xg2Ep+EUpDjxydQtqvoYcewUMBNCx9S9t2P
 K/7BUGvAVzqDhZB9fnRZjANvdv7ARr6pUOIhsqxcvsAmCzpvXLBlRWfr0REiDoR1ifbX
 EdIAz+Gg463so5syDiBTuUv4soVNUyXX7TLhffm8/UEp1I/YjfwICVIOVeyo7O6eftAM
 xBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075803; x=1697680603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZvt6rHVxnKQNPgjKM0jsFwi1qs/5NWKk+ME4MnDPvI=;
 b=GPD7amF53L9gw2fJ5KaumrdZ/1asLWDh2pVGjks0A681IHCf3FVq0tH4ue7gYgkzEA
 auB6IRmC66me86cuCn9HWbg6lVMk/7VCGcYherM7vUTrYgHaD9pU17pWe8x/ofjtM/qH
 ajz4pdLDx2lUTbiFk+XOGCX+xpmOiiPrHAeHIQU2WozoMF+UTsMVapwP8Bqk4rvxcs2p
 V+iv5CHcWRMuWF/gLv4NZ5hyx13eSNE6dzLKSpuIBUr6KCDaxvBdtEFugY2C5vuX2NVR
 buG1w8aPvE6e2GhNHSinC2AP9TqzZuyihKJvviP2joNREUlntF3ZmcNYIHlufCrBGHmM
 egXQ==
X-Gm-Message-State: AOJu0YwaGH8APIsCHL8G6Q/0wuqT+N206UjlZsNJNLVc/0UK++UfYt3v
 9aitqan9MkyzEp1NCDCv3H7vDtxhU15m3g==
X-Google-Smtp-Source: AGHT+IGuRt3/p9wmUt9Dyib8+eZneZyeqPBAEbCROn9v/vjMlWVSJmpTFY/Uoq7c8kCKvZH0qmINVw==
X-Received: by 2002:a05:622a:282:b0:418:fb5:c6be with SMTP id
 z2-20020a05622a028200b004180fb5c6bemr25814844qtw.30.1697075803144; 
 Wed, 11 Oct 2023 18:56:43 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 fk26-20020a05622a559a00b0041b12d5fd91sm2077607qtb.55.2023.10.11.18.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:42 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 12/26] fs: Compile in sandbox filesystem in SPL if it is
 enabled
Date: Wed, 11 Oct 2023 21:56:12 -0400
Message-Id: <20231012015626.3487451-13-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

fs.c thinks that the sandbox filesystem is available if SANDBOX is enabled,
but it is not in SPL. Compile it in SPL to avoid linker errors.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 fs/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/Makefile b/fs/Makefile
index 4bed2ff2d99..592c7542bde 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_FS_LOADER) += fs.o
 obj-$(CONFIG_SPL_FS_FAT) += fat/
 obj-$(CONFIG_SPL_FS_EXT4) += ext4/
 obj-$(CONFIG_SPL_FS_CBFS) += cbfs/
+obj-$(CONFIG_SANDBOX) += sandbox/
 obj-$(CONFIG_SPL_FS_SQUASHFS) += squashfs/
 else
 obj-y				+= fs.o
-- 
2.37.1

