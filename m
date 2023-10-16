Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3E9CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 04:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3259A86DD5;
	Mon, 16 Oct 2023 06:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jhk2V98s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A39EA86DE8; Mon, 16 Oct 2023 06:25:25 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D83586BD6
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 06:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-694ed847889so3104395b3a.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 21:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697430284; x=1698035084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1yClAL1OyfbKc6TszWmib6hvyd044g2R3J1uiGAvAPE=;
 b=Jhk2V98sM2eNWoPg0CN88JQ8QEr8HCN1jxRdEIOetvvhsc1GhUzIqT4qPT6DoaHjYf
 2R1lhg3WnaxO3G1oO5vTrZLA+k/DUX3/6Z13kBuB+ofRy2EumpqEj2hX151imvC57ujK
 doRuhV+Qk6xOhU0b5mqI0VGZ7FiAYmpMCK9HRcvFGNkjw9BvYuxvirh7MHTZpQw2+15p
 ZEy8MUHEIRIAGTmsnswe7KrF/sOKhdo9ydpWh9YbI+Q20LgOC5T18MlN0qmtpOhVcLi5
 vYC5k6wbNJQqn5iw+muOaNE+blrTLgXDN3iqEbX0SlpbGrM+o4fMCBCDka0Ve0yxCGCA
 GhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697430284; x=1698035084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1yClAL1OyfbKc6TszWmib6hvyd044g2R3J1uiGAvAPE=;
 b=Clk9LRx16KMTdyoi8zoRiF+P2J4nS6WoALBf3xH/U4Lw2mknGKbt/jxIlHIILwM0GG
 wWbCiQYllsR3PLX8gDWdM6IV/TzTHP5FujqnOAG/JiZMpvroFMTfXArXNk1Bny1cDhl7
 IQXCT/jkq465eeMy2EMzmC2V5NuKff6I69rCOa8VPyQW5h8McK5mVttwfsJ+n2WILq0P
 3JE8C6K/AthzuGYjKcrm6E+jJ1CVAetHQqQWjIDwyxzr8inwpoQh5oFwP23ezmEUnJ2R
 F/uVAErmK6O/kqEh6J/UD2MtTCRzFztWFnNYyhCkLJN5l6pZ+kdyZL2ptHHNRY31wAdL
 wr9A==
X-Gm-Message-State: AOJu0YzoCS5AZsfihtBROctP6JqPMEn0cNikr2K+y3x+rYcGalNMlP3n
 q0iisBkPFCjAHrFeEJw93/HuVVHx0DGK1Dh6dSo=
X-Google-Smtp-Source: AGHT+IE951qXaTvHVR5HTAE1e7+VQ/RMIhJiY4YvZ9QDu+iIXkCr6cMVLb6puIfsGjtV6693E6yMmQ==
X-Received: by 2002:a62:f211:0:b0:6bd:ca1d:c51e with SMTP id
 m17-20020a62f211000000b006bdca1dc51emr1288353pfh.16.1697430284248; 
 Sun, 15 Oct 2023 21:24:44 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 x20-20020a62fb14000000b006889081281bsm17014568pfm.138.2023.10.15.21.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 21:24:43 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [RESEND PATCH v6 6/9] efi_loader: add CDROM short-form device path
Date: Mon, 16 Oct 2023 13:23:05 +0900
Message-Id: <20231016042309.2386387-7-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016042309.2386387-1-masahisa.kojima@linaro.org>
References: <20231016042309.2386387-1-masahisa.kojima@linaro.org>
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

