Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8898C02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA428083E;
	Sun,  9 Feb 2025 03:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OHIlPHiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D0580050; Sun,  9 Feb 2025 03:01:57 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 203FA8083E
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844d555491eso87959439f.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066512; x=1739671312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmK/YGmKBpdScDjno0kUy4Uy34Xqd6upCerSI+Oj1oU=;
 b=OHIlPHiXlHI/rI3xdxhHm4lJ29NMPijI1VeeuXPMetzsnEEo34O/ZTqt9OhaObzdFn
 K5Plc0/h2NiEFk9bqvb4+wRvJR441w8D5nebZFtmfWS2gO1suSmwZfkEuqPa8jY+LLuX
 f+IVLm1y9ID+h6ula/KsxqpLTORVNGNn3IKC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066512; x=1739671312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmK/YGmKBpdScDjno0kUy4Uy34Xqd6upCerSI+Oj1oU=;
 b=Pp+o7Os2RmKk0lqnlGkiauMgZS965irfGPbjZt576eMh46mlqQv8NwjDlXUCcTv0Hl
 m5hiVHSI6/xR1kBp5bplYn3XUXp7RDfQJ/3jVDLMy6Ah41OG/FmHFuX9dT0AeFeTlthh
 NLYRKqr64kte9RwdXsjhm96+7N0NKTsICy6w33aOPPmk4I/Q2KiMBMxVqn+NmNzZeG/B
 CRThakUzIUYZfHUhlW8LdYxwLI6qzAW8wV/cipKDnahbiI3NXFBbdRCYdvwPkNHBFPIB
 +5m/9JaMRELCIuutRCIlMQoD1X0qopbn+f7Rjm/pyezRbxvIg1RnKx/JGDmCsGMPMQtw
 5Fcg==
X-Gm-Message-State: AOJu0Yx4JWEWh6T9fv0vMCWBKrL1HJyUWj/A3gmBgsWFjQt3XP/TL7HS
 /GEuQUsLwW/fHrYGvk5LuFlgWOWLiGPN5X/kx6/rakeNWMeKKHHawL3PaLTRdSEEMxsI8ZXUch0
 =
X-Gm-Gg: ASbGncs58z6KtTfNhbS4NjF0LDZD+vvtvdhPrKktSQ70WD0ZX1ry9Ut6BB+ysoXRIi5
 rA/kPWaWTajvuiV+Lsp9FZEuJkt1ipeICfU5LcFz5/ZimrYH2yGHqcWiLWSCbZ8D61U4h7dLZyt
 oaACNYiX3yznxpH/eh1+Pzvv21hChwR4hQ1WZW5Y/LhZnxJY/NrC8dAnFbsZGs2vBPp4r3UgR81
 KNiatgq2Qv0RN41CHT66KjHOrLZlruJLjdoJ+NSyHWFd7WL/J6JtyS1bKPkTMffbYz6ijtjbxTs
 pn/FA6ZiCya+cpD2nKaHDd9c9870uGIHqfEW7wzGTfLM7Qp9QXwi
X-Google-Smtp-Source: AGHT+IGI6ufaygr4+lpAm8g5F8JWbvVYP9DILJDm/auwAy+q3fbNF87jp2bKjkEJUxYNbmL8CqRmyA==
X-Received: by 2002:a05:6602:3a01:b0:84f:2929:5ec0 with SMTP id
 ca18e2360f4ac-854fd897901mr950980139f.4.1739066512436; 
 Sat, 08 Feb 2025 18:01:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:01:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 03/29] video: Use a local mode_info struct in the EFI driver
Date: Sat,  8 Feb 2025 19:01:02 -0700
Message-ID: <20250209020136.4108987-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

There is no need to use the global struct provided by PCI. Declare a
local structure instead, so this can be used on ARM without including
support for PCI ROMs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/efi.c b/drivers/video/efi.c
index a7b6d47f9a1..94d4c93dac3 100644
--- a/drivers/video/efi.c
+++ b/drivers/video/efi.c
@@ -183,6 +183,7 @@ static int efi_video_probe(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct vesa_state mode_info;
 	struct vesa_mode_info *vesa = &mode_info.vesa;
 	u64 fb;
 	int ret;
-- 
2.43.0

