Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A767C54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 21:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70540874FB;
	Fri, 17 Nov 2023 22:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="CpdtvX70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B247687500; Fri, 17 Nov 2023 22:22:01 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8989874EB
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 22:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32f7abbb8b4so1568317f8f.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 13:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700256119; x=1700860919;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ynuH2028f8KnFWflJGE0N65LAnse1efDqjBRSAzKZ8w=;
 b=CpdtvX704JZNeVjHqQDse8sP6NUZZCfsZf++DybgyP6y5lyqUUTj6EAL4GoOu7ZJGu
 zVaq0y9pVcJqM/fzDy1BP0ryRBkKmSHy24nAZr7fbnSxP/vajM0KmEYaT94Kd1p44fhR
 qsh/lb72Xc+5BMr/wWxICXLfrnlChETCQOIByc++svoN8mDbe0oSp8fMgjLjJHcP6TgI
 UKfid/UnAGi7ku+o6ksPBIKzg/nZbm3pBAV4QpIN6aGLuSD6pi6RjW/QIE3N1ksaNR/Y
 5uuG8Ndi0bc6HF6RD6st9ZH6mIwu5qQlMMc1lmamOcyinMRaooLzzwsk7rxFX1nWH9CK
 oGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700256119; x=1700860919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ynuH2028f8KnFWflJGE0N65LAnse1efDqjBRSAzKZ8w=;
 b=PXtF0cy8Vg6+DefZX+qdN1zF/YAyM/2iPNQEcmxmeOBnh03zRMb48LE8SfZ1BU5gqP
 wwT0/vU1vwJuWBsykmJCNDykQxVwQnFsCZ8cveM8gyUpTK/ZWCmG8WO2caxu3vIZ4eC/
 ZfGH+DONCYUMbo2rDFtWYcc1anXkYHLUAcAWoQ37V17uqGg/XzTvZBFaiervqjFSUWPE
 A/5cmFpdgcO25hRsQLZcg39cEtAbQgCXRb1042bNOH267ODL7uav/XxODsJFr9IJQ10v
 8vVN7d2egNEx3gWh6Xm3j2jBoZpWrfnxsoK8WwpmNBRR/GLi8+H1F3dPLfoQ6yKLCACW
 gnSg==
X-Gm-Message-State: AOJu0YzD+BQTtvBnqBy4851cFa47GDm9PSD6jIxTwkxtK9TbZuWP2AQC
 q28Swvgq1SpHY4Zry634FLIPYjest8E/PAzP7jWxd9v8Y9g=
X-Google-Smtp-Source: AGHT+IGeiayU3i/PulQqb0DRmTuUzaHFvoWeHJWaLM4jejTThBlns+aQ3oHYRlFDQuWvUXwyI8xKWw==
X-Received: by 2002:a5d:4088:0:b0:32d:a98c:aa20 with SMTP id
 o8-20020a5d4088000000b0032da98caa20mr169142wrp.59.1700256119000; 
 Fri, 17 Nov 2023 13:21:59 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 t6-20020adff046000000b0032d9a1f2ec3sm3393540wro.27.2023.11.17.13.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 13:21:58 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, xypron.glpk@gmx.de,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v2 3/4] bootflow: bootmeth_efi: Handle fdt not available.
Date: Fri, 17 Nov 2023 21:20:38 +0000
Message-Id: <20231117212039.1210784-4-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231117212039.1210784-1-i@shantur.com>
References: <20231117212039.1210784-1-i@shantur.com>
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

While booting with efi, if fdt isn't available externally,
just use the built-in one.

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 boot/bootmeth_efi.c | 10 +++++++++-
 include/bootflow.h  |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 5917458dc5..5e67afed88 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -313,6 +313,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 		 */
 	} else {
 		log_debug("No device tree available\n");
+		bflow->flags |= BOOTFLOWF_USE_BUILTIN_FDT;
 	}
 
 	return 0;
@@ -382,6 +383,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		bflow->fdt_addr = fdt_addr;
 	} else {
 		log_debug("No device tree available\n");
+		bflow->flags |= BOOTFLOWF_USE_BUILTIN_FDT;
 	}
 
 	bflow->state = BOOTFLOWST_READY;
@@ -443,7 +445,13 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 	 * At some point we can add a real interface to bootefi so we can call
 	 * this directly. For now, go through the CLI, like distro boot.
 	 */
-	snprintf(cmd, sizeof(cmd), "bootefi %lx %lx", kernel, fdt);
+	if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
+		log_debug("Booting with built-in fdt\n");
+		snprintf(cmd, sizeof(cmd), "bootefi %lx", kernel);
+	} else {
+		snprintf(cmd, sizeof(cmd), "bootefi %lx %lx", kernel, fdt);
+	}
+
 	if (run_command(cmd, 0))
 		return log_msg_ret("run", -EINVAL);
 
diff --git a/include/bootflow.h b/include/bootflow.h
index fede8f22a2..3890cd4bc2 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -49,6 +49,7 @@ enum bootflow_state_t {
 enum bootflow_flags_t {
 	BOOTFLOWF_USE_PRIOR_FDT	= 1 << 0,
 	BOOTFLOWF_STATIC_BUF	= 1 << 1,
+	BOOTFLOWF_USE_BUILTIN_FDT	= 1 << 2,
 };
 
 /**
-- 
2.40.1

