Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFC5C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C3B885C4;
	Fri, 26 Apr 2024 16:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="niSrTb54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E0288698; Fri, 26 Apr 2024 16:14:02 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2271988634
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7FCC0424B4
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140836;
 bh=ZZq/oJhRI7OHwN1AjZLtLZySmnROmNHfiM8xyWbqqvc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=niSrTb547Enho0/M94j7IvMsDdOtd7lXNaX1emNKy1se1UlVogTRiVmFVXwkymGzW
 a+EdIJU5YYJK1WrC+jLvkmLIM1XxEst3X5tU8YJS5r7ZT/2tHdmeWdniyYkDVi6um6
 iT54gPVCTqDBc1SkgfQxOrJvYYYUfFuXe6MLyMboyHxkD+9w9M3dAevOVNARzIpZ7D
 W1zx/GT96f4l88v12b/yfxevB2eme2Fd60a5SXa2wSHcIDkZzTjflXi0W3QIAeHg3h
 b3cbyxh29sYU3TczhSV6UHAVpBrbF88/82EtlfOtv+nLUnq3T84lIsLMEbyQ5a+TNa
 oqpNS7dDGUcAA==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-34b0b409775so829011f8f.2
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140835; x=1714745635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZq/oJhRI7OHwN1AjZLtLZySmnROmNHfiM8xyWbqqvc=;
 b=h060CPOoUhy5rGPqa256MTdex3droPcupYxI4q1H3T7rWP8a/Go9PYpsHKi2DTpKA5
 HrpPfooQg4axrpgYdlEnwgo+sWZyA30j5gsFw57l7gJf16Mz1HHZZaBh5fQq3UjarKHy
 d8owsxmE5hagxtsq5DMv2Dn9tWihnWn3YNoajy1DpfJRjKd8wjyYYk4Gk9f8lAE3K8BL
 s4CyYjayKRr23RFhxezK46LAA3ZftGmrXvd8hLuoq0XEzfW7IdudSHpUTWTXp1mdDiQZ
 pTbS1F+C0fMR0NlAAB6Op1eHUMXT4G6vg++nuU5v12j0JOgKdLRtbU9ueY7+6tR/0XWj
 bpyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfymYAKvuVdpwyumUNRz8DbzfV5XPlMnqRJdoOxQb1MpXQrmY+h/SW4MAgsivealnk+NMIQVPAspvRPJVRjn305Z8+DA==
X-Gm-Message-State: AOJu0Yzu99jcu7jH6vz6PIaU9DOwB+bM8wbaLO897NGSdGPJzrIgot+p
 gedm1kS+aaHVHPMkYWcAfGhuu9Zn9iAbtBQoMsZsxwxIHItyu6FprqwhFM4DKwW81677gzOcBGp
 8olgZ9YdCzeDCIP9U48GcF8OugvWk/QSIyDMqQmcY3rTcecMMSFK+nqWUxpd+JS3V01M=
X-Received: by 2002:adf:e9cf:0:b0:33e:c0a9:79c with SMTP id
 l15-20020adfe9cf000000b0033ec0a9079cmr1582022wrn.23.1714140835225; 
 Fri, 26 Apr 2024 07:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLzXtho2KSAhuDrrXp4C6GV/EuIfOPqDF3S3nTM/GaC8r4zwlgymFIJPFfZCip0OHHHx7+8Q==
X-Received: by 2002:adf:e9cf:0:b0:33e:c0a9:79c with SMTP id
 l15-20020adfe9cf000000b0033ec0a9079cmr1581998wrn.23.1714140834802; 
 Fri, 26 Apr 2024 07:13:54 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:54 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 09/14] efi_loader: do not install dtb if bootmgr fails
Date: Fri, 26 Apr 2024 16:13:16 +0200
Message-ID: <20240426141321.232236-10-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
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

If the UEFI boot manager fails there is no point in installing the
device-tree as a configuration table.

Unload image if device-tree cannot be installed.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_bootmgr.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index c64cbe82402..d924810a94b 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1209,15 +1209,21 @@ efi_status_t efi_bootmgr_run(void *fdt)
 		return CMD_RET_FAILURE;
 	}
 
-	ret = efi_install_fdt(fdt);
-	if (ret != EFI_SUCCESS)
-		return ret;
-
 	ret = efi_bootmgr_load(&handle, &load_options);
 	if (ret != EFI_SUCCESS) {
 		log_notice("EFI boot manager: Cannot load any image\n");
 		return ret;
 	}
 
+	ret = efi_install_fdt(fdt);
+	if (ret != EFI_SUCCESS) {
+		if (EFI_CALL(efi_unload_image(*handle)) == EFI_SUCCESS)
+			free(load_options);
+		else
+			log_err("Unloading image failed\n");
+
+		return ret;
+	}
+
 	return do_bootefi_exec(handle, load_options);
 }
-- 
2.43.0

