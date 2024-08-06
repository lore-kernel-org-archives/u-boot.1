Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7394C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4853F88B07;
	Tue,  6 Aug 2024 14:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HuGkEAmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9174D88ADE; Tue,  6 Aug 2024 14:59:50 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69DDB88A54
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-397052a7b63so1846365ab.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949185; x=1723553985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tIgb8i1fKziFqIQ+As++ICDDPPCgarHunCDCvW1zMok=;
 b=HuGkEAmT3LDpbjyxfK9bysUhBFknVABYx5UnUyvmkcJrq3LUnDYJUpVHwI2NuLjEyj
 r2LfK6y//OBrqYOP85IvJcBqJWxaF+KIDqpJ2bQPNK9pvv7HTn2dFCCnaIlnhM53Fh5h
 2pjsoxjWqEjdR8DGKLaEia79oCx6zJqVV7/hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949185; x=1723553985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tIgb8i1fKziFqIQ+As++ICDDPPCgarHunCDCvW1zMok=;
 b=BkqyP6NAZdggpcZddE5Ylg2mGVIHbnO+9Wb5N3R9TRRW+cbnwkr2ehos4kmj+725wq
 KP2yG6z118O9WrZ27Ag5u7X5fQdUsam8UoR+GgS8o1YQu08EzIUqe6NNIhHRjWFSIrBP
 T6k85ma4it5OC+79wIDE6N9C8ykoV+umcfEUt81uOd9inc6V4R3QexhqGRtdoKiNu64I
 X/Qv+4lL2L1VANpUpUCHaJ5ZS4qv8ltQTznaZd3IwGmQNQzvyeL0bdIZUp/yPOmZIQZF
 QfflB4rJeEbtX73oIAfWLCJKgC91LvkOpu8J/3g6mjeZXDYyECZNRlLFPHrqshcjqqK+
 TL+g==
X-Gm-Message-State: AOJu0Yz9Pmv1qu7+VEzFTzb0epxDidHtbTmaaUnduYqBfQYAZERPG05a
 NBwVT5dt8ZyPkfxG9EVSkWcz1Fk1BTdLKanphpT7GpAP+eggO4weA92BaOPXXtTLDq/h0HO/1UQ
 =
X-Google-Smtp-Source: AGHT+IEcJFvgRMMzcjprZeq9OwGtwPjyx4vTja//UOd9GIend15b67ojZk6RO+KUDuSYhMv17DiYPw==
X-Received: by 2002:a05:6e02:1d81:b0:37a:7662:7591 with SMTP id
 e9e14a558f8ab-39b1fb6c01emr210384135ab.6.1722949184932; 
 Tue, 06 Aug 2024 05:59:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 30/39] efi: Show the vendor in helloworld
Date: Tue,  6 Aug 2024 06:58:41 -0600
Message-Id: <20240806125850.2316956-31-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

Show the vendor name so it is clear that this app has been built by
U-Boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/helloworld.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
index 586177de0c8..f120249126d 100644
--- a/lib/efi_loader/helloworld.c
+++ b/lib/efi_loader/helloworld.c
@@ -237,6 +237,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
 			(con_out, u"Missing device path for device handle\r\n");
 		goto out;
 	}
+	con_out->output_string(con_out, u"Vendor: ");
+	con_out->output_string(con_out, systab->fw_vendor);
+	con_out->output_string(con_out, u"\n");
 	con_out->output_string(con_out, u"Boot device: ");
 	ret = print_device_path(device_path, device_path_to_text);
 	if (ret != EFI_SUCCESS)
-- 
2.34.1

