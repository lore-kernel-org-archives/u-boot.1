Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D17C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D6288C01;
	Sun, 11 Aug 2024 16:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m9O3cezk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E006E88C30; Sun, 11 Aug 2024 16:52:57 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD32388AD7
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-81f8f0197abso176469339f.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387974; x=1723992774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcP6BtqafScc0NdTztSLCjfNhuuO7jN51LuoNSQ0VeE=;
 b=m9O3cezk6vmBRoSIoVa2Ouq/SI8F3VpfcvlkxqhJIMDsKPmKKbiYbM3pNZG5hMb/jN
 XDdeGi1QwUcF7rU5MfR9K+Lru5EMvqd+Rev42jkzey6VoDNuBm/Tp2jxDgw/sWJQK+03
 +KVzUsK0waYPeWkOHeKHmS3RtDxKpdNbmNBSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387974; x=1723992774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcP6BtqafScc0NdTztSLCjfNhuuO7jN51LuoNSQ0VeE=;
 b=KgIBQC1ZsGnTGQC0uX8Bq7KN8RTrYMDmBH86q5WgWF4kvcqwZ6tXTuAgyOkkW9lwW5
 AlNNpGw+TD701bN7kErl4NJpyfMflPjSFpAocAp/fbvFAW0wN80JmUZhusdFhFzT7MK1
 NZwJ8GcRo6fQ3y/3uVv3j7RF87D/qxpgA4UlXt+/rLF3p4VSH/xn2P9lbmFYGXVBXIRT
 nDpIixXmCkDHHCq4zTSQmvu7mqaO8t7gc4fOzYubw+mvGx9An6RkLsF57olDCYHimgPK
 j0WW9u3QGIQTFsk/TjgD0MxgcMJU1nEnpIJwl4S7vnKfpQ59u58vmD+Ug27x059P766a
 L59A==
X-Gm-Message-State: AOJu0YyohVCVvFyXlUiNl59McI9R1OfbZa5YQmZg8sVjhSS2+0Vnytr0
 BmZXkQ6m0Dcc/keTcImepPbnMcvPDwaLaCyuCdFr9JNJBsI5rQ/dB+XLTRl0tWO50mcJbdVewKE
 =
X-Google-Smtp-Source: AGHT+IE6C4tf/fDXZakM1hmi76V4nQxPohnyNNmxMG3RrByn/JvbdSzg06TtMx98/yxX6XAyW0mnpw==
X-Received: by 2002:a05:6e02:1fe1:b0:39a:14f7:1c1c with SMTP id
 e9e14a558f8ab-39b813286b9mr84260825ab.25.1723387974446; 
 Sun, 11 Aug 2024 07:52:54 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 31/40] efi: Show the vendor in helloworld
Date: Sun, 11 Aug 2024 08:52:00 -0600
Message-Id: <20240811145209.4191404-32-sjg@chromium.org>
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

Show the vendor name so it is clear which firmware is being used, e.g.
whether U-Boot is providing the boot services.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Reword commit message
- Use 'Firmware vendor' instead of just 'Vendor'

 lib/efi_loader/helloworld.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
index 586177de0c8..c4d2afcb40a 100644
--- a/lib/efi_loader/helloworld.c
+++ b/lib/efi_loader/helloworld.c
@@ -237,6 +237,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
 			(con_out, u"Missing device path for device handle\r\n");
 		goto out;
 	}
+	con_out->output_string(con_out, u"Firmware vendor: ");
+	con_out->output_string(con_out, systab->fw_vendor);
+	con_out->output_string(con_out, u"\n");
 	con_out->output_string(con_out, u"Boot device: ");
 	ret = print_device_path(device_path, device_path_to_text);
 	if (ret != EFI_SUCCESS)
-- 
2.34.1

