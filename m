Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AEEE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8334680516;
	Wed,  1 Jan 2025 23:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KNbdmBRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C5FB804BA; Wed,  1 Jan 2025 23:11:14 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC9D80317
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so154406145ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769470; x=1736374270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xD8uXxnEqWGQaEJ7Eb6irL28wQ0t2D5rlK6bvqWzA6g=;
 b=KNbdmBRFsPmknXH6kpkJJjtGaRDhpEhb9m52on1bZzciIm5mxGlDma67ZmPqbUjc4E
 6djLdvF0mEi3iL7XJ/FbYkZQcEzv76KSVSWHDG7WZfxM/HJ/pkC1UzqtT/lMXYqoEdxJ
 SeHpcyj07b7X+A7qDujZ6oi6wPxzeiF64b2QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769470; x=1736374270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xD8uXxnEqWGQaEJ7Eb6irL28wQ0t2D5rlK6bvqWzA6g=;
 b=gst1fDejP5Lgj4FkCx3TLkiOrclCpQETcQGy6vjbUyCWXLiInXVzqmY7ZKcU4SRdqs
 hhk3rQ44CWAeOo/fuA+LFnppwlQNgs1t9xvvno25C9XgYTjJ9galTp/iwFPXcHiSkdn4
 qK8LR13JXDUx4dBwqGiJ5vuJ0X4N9sw7vMqmbJkY9250efiw6sSfi8csGWSTIT7w9qkc
 ZLNUtPR8JU5c/T6toqSqYxJgum1hyB6rHx4bvzUa1PyWogtgDlIvIj2acHSsQh8lEJe7
 XAOkz0E1XEh6uPrd8fiWCDs8Q0Bdtt34I8aDJYYOFhtmiaJG6L2QbEVOit10nOTkWQJA
 GTOw==
X-Gm-Message-State: AOJu0YxZRu31YB2IfZ2TN7HC1heOtye0gabAsI6zloRfYFFh7N/BytdN
 93+Rc7SuFgffcVY2DqnpJ31IEkEkn9f8oyfM4mRlBASP7WYpWUU0vC43ptCZSHfwkp6iw3f61w0
 =
X-Gm-Gg: ASbGncufFQemYLI4BHWmyg88Ny7QCds1QD2oLw4UQQoln4sO54LrtubVHa46eCRVkHn
 6Kho9/wnHCY8hkkPlxvNVcqm2kpkgDk3EzGx/Z5ZuWtAjNPmeedQgFGAiOnPuTSqtl7M3c7370n
 TbujSmXT201UZfbQFu9LGRpXVZ5vEoy6y2/HzU5j0WrVTMg3Te76Bs0LtqA1bjIM6AdRvA1DZRu
 VYgn+g+JgUIeADtWqAFfSIf22Fnx+i9uxC8MM0Ho/wwCLojbmxpQB0=
X-Google-Smtp-Source: AGHT+IGhPxMHAl7RiJbdJNB5adppUTvsdyXpNaRmF1gCZQ+d+tn7StuLEXpBSQ3XEXlYVGRZmTVt7w==
X-Received: by 2002:a05:6a20:6a0d:b0:1e1:a920:225d with SMTP id
 adf61e73a8af0-1e5e1fa207dmr67779817637.19.1735769469863; 
 Wed, 01 Jan 2025 14:11:09 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:11:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/67] x86: Emable meminfo command
Date: Thu,  2 Jan 2025 11:08:54 +1300
Message-ID: <20250101221003.1944600-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Enable this command for x86 boards as it is quite useful for seeing
where memory is.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6258788f53f..2fb247d04b3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -310,6 +310,8 @@ config X86
 	imply SYSINFO if GENERATE_SMBIOS_TABLE
 	imply SYSINFO_SMBIOS if GENERATE_SMBIOS_TABLE
 	imply TIMESTAMP
+	imply CMD_MEMINFO
+	imply CMD_MEMINFO_MAP
 
 	# Thing to enable for when SPL/TPL are enabled: SPL
 	imply SPL_DM
-- 
2.43.0

