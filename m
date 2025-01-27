Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF06C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 15:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C01D68168B;
	Mon, 27 Jan 2025 15:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MdlRNx7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BAE981671; Mon, 27 Jan 2025 15:59:43 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 162A081276
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-46c8474d8f6so35196881cf.3
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 06:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737989979; x=1738594779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Dmg+mNZuvbeydGWgWctwh9WUtURYjymLtkyf9KwJjw=;
 b=MdlRNx7KMyf5+XsiN3tKbjnWs8wSgUrMYafTBc6yjNiHVXqJZblXICJrAMFgvY+wQj
 NhFFqPO80d9sEit/mWVKEEFWkxVRx6xq0RnrraO4bVFgXiMLWNdvulngFArIz2H+G5bp
 vfhwNABxwGUivIMXNiS7R5b3vignXiBjAZWkySSkWjG3mpeXIeMAPeF/3rYiRqXY9WoW
 m8WPQece+OCLdaLnOU7b5x3LT8v+aYffBK9qHALPbmNpwNpNgr4BEaPYVVFHezBFio54
 7tFEz8u5eg3ZoQEz4gBT1uWuLOD+b01JfiHPhs+/BxgMo1QAVlll6FMmQ2uf2Ecfcg/3
 8ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737989979; x=1738594779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Dmg+mNZuvbeydGWgWctwh9WUtURYjymLtkyf9KwJjw=;
 b=X7jaxvpjXCMgAO5x4fhimIeqz0FP0RFLRaPZ5izUwUWrNBdRHrlvGy3tiknuYFfRBp
 MqnoxNEdKqKmyIJT6jrXMoL0FNDCx+4oMKipcXNxi9iy7yQmqLpNc2KJsF11IZRrAWOh
 e8wui6McSYrKgJr2uS2eeeb09vR/neVJTZMQdJYxA8pVb7Eh3OYQdphz1xlY2hsDyi+Y
 14xvpfyc5KO9J8bQx6msi9fTjsacsZ6AbjS6K2G7onKXy21ewb//efpeaUES4Rtf5UUS
 fprk9xwUbTgMDClYt70FLxy6qY4ozg+Epb39FjU6RrJ+kQZCI0b10j6wQ1K/eGN3pXOx
 bL/Q==
X-Gm-Message-State: AOJu0YwZLigQjJGJ124WUObQWulxn59Jl+TCh3VBHps36AEYF7D46mhA
 gM9jcgLiROTPxWn6EqvVSHr8cy/04qnlr4LQJ+++tnf/jMqzF4LeLq+Q3NY8I9IIiMfqeNNCFB4
 LXsw=
X-Gm-Gg: ASbGncsDHbiRQDUnMA7jfBMiwmPTkJMj8ap1y4BzKrxkfAmkYUmRvu9TV1LJSY4lTgK
 Ie+l2bLwfMuq7/v6H+XM4LQTO0/RfvPfE49Hjx8gOCiNap4pM6K4bBoh8lP8qa7UddjP7iG0UzF
 OroYhEOOThldtUNnb8em//8opOpL7BtsPOuFUIJQMHafwkPrpLbbCxK96AkKoA/Jz3jrn1Ia6/w
 mddKyyY693qDml173oj/Vrlywya8IMTE4OqALv5iK9UrSN0KqNeCx6evaOTjLLljEy50CNGPmP4
 KuS4NT9oldsIig74dgUg3TJr2hVbcog/BTcqfq7dNl20eA0wtSgO3hQrEILozLSMVk/8Z9W/nVz
 OC15uHubrpDx9SQ==
X-Google-Smtp-Source: AGHT+IEV3vbnO6aVx92BLv1eBnLWMgXAw0lxQ5o4ucUYtBvYeqRiCHz+anWwBSAhU/8mB3AbGGuKZA==
X-Received: by 2002:ac8:719a:0:b0:46e:37b7:950d with SMTP id
 d75a77b69052e-46e37b79859mr406218131cf.50.1737989979561; 
 Mon, 27 Jan 2025 06:59:39 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6689d9cbsm40945951cf.41.2025.01.27.06.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 06:59:39 -0800 (PST)
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
Subject: [PATCH v3 6/6] board: qemu-arm: select TPM_PCR_ALLOCATE
Date: Mon, 27 Jan 2025 06:58:51 -0800
Message-Id: <20250127145855.645845-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127145855.645845-1-raymond.mao@linaro.org>
References: <20250127145855.645845-1-raymond.mao@linaro.org>
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
changes in v3
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

