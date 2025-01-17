Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9631DC02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 16:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA0A480756;
	Fri, 17 Jan 2025 17:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h2UuKBbA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4602A80756; Fri, 17 Jan 2025 17:41:18 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BEBF806D8
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 17:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-46c8474d8f6so20174931cf.3
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737132075; x=1737736875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJuRiUVW1EdpRTR/3E1u6rQuLToWRkhwGLuWsq5CX34=;
 b=h2UuKBbAujAjKc+NXCkpY4qZGUfa7CJiUh+eqDG4Xyzu45FvjNCSRtfc12vLWw6Int
 nc+cO9+t5IksHbef+KisW8+vCQAXfnQjsF+/RvYI5lD1tCKX848+fH2QUviJVl9ohyt1
 /AdYkeXAQ+HkeYn49zCm/W767IQhLb7TkYDAOnWzLg97O8PgsIVGKM0SPiwZjm9rX5/s
 2+rhXzCRjtPdnYJm6C5n7LdhmY6YdF7XPI4E5La35xRir0Y80r9rGUKEFVE0CvxuFVz6
 4bP0mZSYoMhw34CDCjWWLLanCUuMeyq2bVano9jIfJxNHxz6/YwTN4NoX4JjBWmqPTB0
 +Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737132075; x=1737736875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJuRiUVW1EdpRTR/3E1u6rQuLToWRkhwGLuWsq5CX34=;
 b=FqBXGJ0cgkQk1srixzjG1urhaQ5/xwtogjph6TBuMZZTR+UpA2ab+/WRws/ntf0u3h
 WAKLB4PSapM+PTZXh30pdHeCRGJ7XkDhJM4jY/nTldlDUQ20KVCLEPB+zswj/k4nK5yN
 l7sQSSQ4j43aXPU+m/gSau60djEjcV2p50zPaKhF/6sCCScJq95bqKwNMkOzN1GmdYbf
 y30LjGsto/F2CJsKSYZ1bFe660+uybdPBBUjXvubp8GFPZkgQkLvxYX16+PrGdjr90Ib
 T8jrRNKl2VGMZNAoX4y6RF8HEQp6svCtiqIgAVhOyIcnNsvEKkD4ZuDefBxBSqx7AnjQ
 zczQ==
X-Gm-Message-State: AOJu0YyVlgKHpDtVJkvSv3WxmfBRWd7toZZZ1JbpGRDUMPGqZ/pHgclC
 KPOZpU11krIGjTPeaHOLKa2YYUKBAejHrBhvvL3XJXwXhpvbk258Fnpnka8LJXOTZ1IMPyMCEGJ
 SEc0=
X-Gm-Gg: ASbGncvptCbx4GztaevKhiCcUnYeSWUo2o3/Rsc9Q1avyAJ170wkOdoi0bF4N+tkAbu
 yeuHkafFHEleuTHxELd1b0NXxNKyQhgHFHh9jkUfQUvEkd5o09TnKwq1fW+fkZyy1QnHdBfh499
 XJnBmW9yI2OmUrKoJ1VIW0NNUIEbC+gszb8SSVujpndF0iL0EUCB+0SlUkaCgQGXKG4uIGJa5EA
 hBdw9gI77xFxFM9gs2q4lRdJPs266dh/t+kPcEF+l8k5AspDff75pdoAcTZw4z/sGqQY2Q7IWYy
 JnQW1SXP3ygeVKI2+3Idbs3/DkMaw2B7GS33IHPLZ/Mh6kCE5r56bAA=
X-Google-Smtp-Source: AGHT+IEDIZEOtKBklQFEQINMmS7zKkiQCP5gvHEEoqKq9PpZYJjqkanOi9pw8IYzmkKu/B+94TchoQ==
X-Received: by 2002:a05:622a:1446:b0:46d:d2b7:4bb5 with SMTP id
 d75a77b69052e-46e12a96f34mr49519861cf.28.1737132074743; 
 Fri, 17 Jan 2025 08:41:14 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf3887sm12867746d6.9.2025.01.17.08.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 08:41:14 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 6/6] board: qemu-arm: select TPM_PCR_ALLOCATE
Date: Fri, 17 Jan 2025 08:40:29 -0800
Message-Id: <20250117164032.88942-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117164032.88942-1-raymond.mao@linaro.org>
References: <20250117164032.88942-1-raymond.mao@linaro.org>
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

Enable PCR allocate and system reboot when algorithms don't match
among the values from TPM device, U-Boot support and evenlog.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
changes in v2
- None.

 configs/qemu_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 0c7107c1f4..6ba3cb1bbd 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -73,3 +73,4 @@ CONFIG_SEMIHOSTING=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y
+CONFIG_TPM_PCR_ALLOCATE=y
-- 
2.25.1

