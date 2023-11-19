Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ECCC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 16:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CC7871B2;
	Sun, 19 Nov 2023 17:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="rxuQrskV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5A2B8718D; Sun, 19 Nov 2023 17:56:23 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17E7587005
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 17:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so12082395e9.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700412974; x=1701017774;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTzUkfI89507GAUgGeHflsj+tpYSbhEpywDdxK/orZE=;
 b=rxuQrskV5V1vojBiV5CK1CYL8/0r2I9G8AvbC89LLdT7Q792JCgNBLRh9QeBJSGLqg
 D+LYT8HxoVIRalhwhTSbeBcqLudbr66vtJ8Ga9HYYsLS+OyRV/Vc38Nxh7AbqbUZ0MEA
 yqXgqH1eZdyGeyXS3hRQCoScon8C52DU0gHV0DSIrNNrbFLUu1DY7FkPxQGqkVnJkXEB
 di2Bmo6LDBjvkfKDB9heZyoU3QrHrpr2sfdqUrgWfEmWevSf5FppPgye6blEACHTB/96
 wRXqKy4EmrIOAC9oTPEUO1M/sf9cbnAfoV4KZZO9+7TFL1uElL2tVLDdlNe+8n791ohi
 6FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700412974; x=1701017774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pTzUkfI89507GAUgGeHflsj+tpYSbhEpywDdxK/orZE=;
 b=mtRZGrbYF8LDxX4y2lOMMHtVpvfCEzij4tBUhKPADcPVXOzGBcU82I1NhYlgIoBhQn
 VNw9AcutIxNK1JwIP3Vy5x202DnFMSP9ESvC13tPLlLlqer98ATIlPiJQcWofmvGRUEo
 PVEVCgQpPab26EHxtTK1eMEeXGEFo3lrFyyM6iP3fHbBDHO8rgn50ulc1+eJjwDY2+sM
 iJICZt/jZjFad5+e8WBDY85E7WmlntJmVOxRwcz9lKG3jRrX3OGWSee0nOGePvs800yp
 sV4Rg2iSEKRf3sviGQwEnMCvDcSOQBYT1DaahHYB4VtEKmyridykpSiDFjvs3+4VdB63
 MEnw==
X-Gm-Message-State: AOJu0YyMdtGUnHbrlOe1vn83h0DjUIeZuuUatiJQ8nkRH7UgE8AXWU+h
 ZZJXfupGF4TByEejJDiTZsvuoFcCoShZROaC4hOU2Z6r
X-Google-Smtp-Source: AGHT+IFeKbnj3vFOYLaQVugrqTgage/Fs8jTWogw+ybYYu3j/55Qoe09vk7ixw3rNIVLCXjP9YVkdg==
X-Received: by 2002:a05:600c:1394:b0:409:5d7d:b26d with SMTP id
 u20-20020a05600c139400b004095d7db26dmr3663648wmf.15.1700412974332; 
 Sun, 19 Nov 2023 08:56:14 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 x7-20020a1c7c07000000b0040684abb623sm14483754wmc.24.2023.11.19.08.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 08:56:13 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Shantur Rathore <i@shantur.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 2/4] bootflow: bootmeth_efi: set bflow->fname from bootfile
 name
Date: Sun, 19 Nov 2023 16:54:59 +0000
Message-Id: <20231119165501.1305136-3-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231119165501.1305136-1-i@shantur.com>
References: <20231119165501.1305136-1-i@shantur.com>
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

We need to set boot->fname before calling efi_set_bootdev
otherwise this crashes as bflow->fname is null.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Shantur Rathore <i@shantur.com>
---

(no changes since v1)

 boot/bootmeth_efi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 682cf5b23b..fd224f7c91 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -323,7 +323,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	char file_addr[17], fname[256];
 	char *tftp_argv[] = {"tftp", file_addr, fname, NULL};
 	struct cmd_tbl cmdtp = {};	/* dummy */
-	const char *addr_str, *fdt_addr_str;
+	const char *addr_str, *fdt_addr_str, *bootfile_name;
 	int ret, arch, size;
 	ulong addr, fdt_addr;
 	char str[36];
@@ -360,6 +360,12 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		return log_msg_ret("sz", -EINVAL);
 	bflow->size = size;
 
+    /* bootfile should be setup by dhcp*/
+	bootfile_name = env_get("bootfile");
+	if (!bootfile_name)
+		return log_msg_ret("bootfile_name", ret);
+	bflow->fname = strdup(bootfile_name);
+
 	/* do the hideous EFI hack */
 	efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
 			bflow->size);
-- 
2.40.1

