Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356D9CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 23:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B53E186DBC;
	Mon, 16 Oct 2023 01:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CFIMQoZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D19D869D1; Mon, 16 Oct 2023 01:51:31 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62F5586C3E
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 01:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5a9bc2ec556so1526425a12.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697413849; x=1698018649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1yClAL1OyfbKc6TszWmib6hvyd044g2R3J1uiGAvAPE=;
 b=CFIMQoZPp4uiYg1GR+JJPzgLPaAFdc+iagiMmJ3Z5ho/xCr8wl3LihPruR0KaVuSrO
 SdPGK17ymCcZwQfWP8ClKZeQoClZa28haRj41ficNdKSY6xgmbc6Eq+3/vYHn/fdelfd
 N7J3AMi7t8UxOmne2MnFM6N96ihmpAPZgXZnUfSr652iE+s0izzVkfwpzT67+fe68TfQ
 WqZOZWXp14kjRoTbe93O31TJpT16AK2WXKam+UDO3O8h+QmeyECTFQnxem1QiJzGDA1p
 GrD5KTkG7AwRgm3EAmTgcxHOp00FpZLJ9/yAKL5XmQCZvd7Je33nSNX4AFvQvHSwMf5Y
 gA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697413849; x=1698018649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1yClAL1OyfbKc6TszWmib6hvyd044g2R3J1uiGAvAPE=;
 b=kONRyH/mbK/d3wUhREJSVGJVgMZVza4b7cv+DjuWxI7AntYC6I43SVwFJgu9t96KLD
 0xff0v7kJCYZjPZ3roiYPuYehbrrLi1pKlSyDnAQMRs1iVTP6defV+pjc7YXynZlzuM8
 3jtNTvxcxBxvt18SXTlm3liqxgPi2s453EQhIbgaj8zTv5RaoAr+UGNUiVDtem6TsmZs
 d4idgOv7GdM226aR1TeAsQkyrogy94QumSkco/zk7N18HUA68Yj1oDDFdms5YDSxqmhZ
 /2BoW1XHakthXvR50lgZ8WLBfwdGzbMQvke+Z7E58SwHWyD8keA24iDDx/rT5H5WqJ6X
 tu0w==
X-Gm-Message-State: AOJu0YyjGXWG9R8S5/E9C0VwVk7FspNmMU81VkX5OcwoH3Rz1Cifvwik
 Rub4GEyXM/y+GMgpoYv9ncyC1Hq9d5Ct9t0GzxU=
X-Google-Smtp-Source: AGHT+IHx4hEzGaXBf/3yXpskN18txYOE7cH8gHB3YOBuGSbnLo8yuATt5CDR4fp5LuzrUCkFNWiIGQ==
X-Received: by 2002:a17:902:db0e:b0:1ca:20a0:7b14 with SMTP id
 m14-20020a170902db0e00b001ca20a07b14mr4204117plx.55.1697413849538; 
 Sun, 15 Oct 2023 16:50:49 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 ix12-20020a170902f80c00b001bb9bc8d232sm7278363plb.61.2023.10.15.16.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 16:50:49 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v6 6/9] efi_loader: add CDROM short-form device path
Date: Mon, 16 Oct 2023 08:49:04 +0900
Message-Id: <20231015234907.2362717-7-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
References: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
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

UEFI specification does not mandate to support the short-form
of the CDROM media device path.
Fedora installation ISO image is identified as CDROM media
device path, supporting short-form CDROM media device path is
required to automatically add the boot option having default
file of Fedora installation image.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_device_path.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index ed7214f3a3..ac673ab117 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -110,7 +110,8 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
 	while (dp) {
 		if (EFI_DP_TYPE(dp, MESSAGING_DEVICE, MSG_USB_WWI) ||
 		    EFI_DP_TYPE(dp, MEDIA_DEVICE, HARD_DRIVE_PATH) ||
-		    EFI_DP_TYPE(dp, MEDIA_DEVICE, FILE_PATH))
+		    EFI_DP_TYPE(dp, MEDIA_DEVICE, FILE_PATH) ||
+		    EFI_DP_TYPE(dp, MEDIA_DEVICE, CDROM_PATH))
 			return dp;
 
 		dp = efi_dp_next(dp);
-- 
2.34.1

