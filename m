Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9253C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 08:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D8988D0A;
	Thu, 25 Apr 2024 10:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KWrbsHL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98B6F88DE4; Thu, 25 Apr 2024 10:06:38 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F6ED87DCA
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 10:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1943F3FE51
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 08:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714032394;
 bh=ZKBlN41HoRp48iLz4Z6wqzIPAO+YtUEGVurOgmbXEes=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=KWrbsHL4f6mg6TpJ30jWBxDkc8Ib77JVgzjzrrN+tIeg5DVOa0cacPWE/czhXofof
 9ssc8Y4OsQ2lOs8T5d/0Ta0aVcYvX714SdPlO67T9eRHEGbDeprtxVzSXevcmjUqmE
 /zKdontm8F4e3gyxgYJ/7L+9ROXiwwmtSdMO3qloCb+CC8/4lVaZp6k2qMJsqp+KNL
 DrqidnZBdR91e1vOmet93HiDNm9lhqMQwFd6vsGLHYQ7nlr7gIND74c03JNSk/23h1
 733mT89NeNPNhVsuiSn4j6cpgoJQUWEUAZKpgK9rLK/KtNC9NO85dQydgDtcEUIGCL
 slQILTK5JrjDw==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-343d02b62ddso488361f8f.1
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 01:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714032393; x=1714637193;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZKBlN41HoRp48iLz4Z6wqzIPAO+YtUEGVurOgmbXEes=;
 b=Mb8PTunbMLpaCCIa6I+hnFPxND1UQHriVT6a0fLCqfGnJMRuBk68UenJv/w0gJE4Vk
 oHd4TsR4nUY6HIvpx+5l5EpYnxXKDo8hcfDhojkaLCpfizcszSf2DsmgElyXUlhLIg8j
 y+sUjgej5TxLzG8+e/deHKEpOzifr/O0YUC9eNMfzMAct+Ix6xn2OwhlPgJVia/121/A
 ZG8/puL4fp6/4AMT6qvYzeRQ4j7STyL5TTtus5xiGs88rcEslNYDmAWg9foOnmR23e3F
 qH2G2Vjm5fmVbAD/ilZ8jtx9/4PbbE0iq1JGAyO67GfwzajZ+yXAkH+RcRaj9h/lmho0
 yelw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZayihINShWa+WRceCIY+CT96hLI237mSGLtzPTYWluxS5xVEajcxNVWSE0o20mOozKu/HTOFU0oQJL5NCHJ1rpYOEqw==
X-Gm-Message-State: AOJu0YxJZHGAjFzrWC/z/ZgWb2PlAxhvVSHrlmdH7eb81B8ZGUY7z+U/
 kLTSPQwmOkwbJ4VXdO8YrKXAe/pAHCM2fpnGYVKKqXEOwD38prZIwKyI06pXQ5SGUuPeX7JvClj
 0zLYa7KC29lj88rWOO7XRa7/0sBgw8LCI6xhx6hhTaD4p/zZS4FWTeDuRP4+nBNqUapw=
X-Received: by 2002:a05:600c:4f8f:b0:418:58ac:7477 with SMTP id
 n15-20020a05600c4f8f00b0041858ac7477mr3443977wmq.30.1714032393712; 
 Thu, 25 Apr 2024 01:06:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf4krAW9cnJrGCcTyc7qHjTFoyJ8jk/gTOrl/dbAw6jkAfktGQ9pzxdZzDQpAskBbauRoX2Q==
X-Received: by 2002:a05:600c:4f8f:b0:418:58ac:7477 with SMTP id
 n15-20020a05600c4f8f00b0041858ac7477mr3443953wmq.30.1714032393188; 
 Thu, 25 Apr 2024 01:06:33 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a05600c4ed200b00417d624cffbsm30506237wmq.6.2024.04.25.01.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 01:06:32 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2] efi_loader: do not install dtb if bootmgr fails
Date: Thu, 25 Apr 2024 10:06:25 +0200
Message-ID: <20240425080625.26838-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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
v2:
	Unload image if device-tree cannot be installed.
---
 lib/efi_loader/efi_bootmgr.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index ca2ebdaa32f..aa2cc0eb52f 100644
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

