Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF8BC07CB1
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2393087774;
	Mon, 27 Nov 2023 14:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WCdx7oi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B8D8773A; Mon, 27 Nov 2023 14:01:24 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 215E187762
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507e85ebf50so5618650e87.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090081; x=1701694881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tgd9XSl1RgBYi1BvtIQ5IaQT26RUcbOejhnA8d5hUVI=;
 b=WCdx7oi5EYJ03I1iFaVRH7VNBAkJrmFpYkgWBRO1rQOtyWkA2HMSHP1YvwFShLlifb
 Y97Mv0ThRB6zcQK2qQ/rK68EhEsPzl5QTCz2sCFsJslPNBU9dd8njNUddiYolXw79jmh
 oWeB62xNrR1DIoPe8rsU47A/kVEpytvvpZfKpKEOgPjyRR6kNFnsrsHwhXDV77Cs1NN7
 UCLcdJ/X46kZDsgwLG3XHUZhKKVTBMUqovVkRN/8DgIv/qd4zUSOjx5tpmkRsvIoclFK
 1F2AiKkEBAeGE9KI+TxOc8yWTxJhXhn848BlMdlaJKZrQ3tz/PvjXga19N9qV7Wf04dN
 nLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090081; x=1701694881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tgd9XSl1RgBYi1BvtIQ5IaQT26RUcbOejhnA8d5hUVI=;
 b=lJpjX3YL9wu9Do4cD/4wGpE9LAbqTSaPnbNzXJA5sHw+A5Y5QSn8NzRMhBufQFeSFd
 AhqaGMqAzDnNsk7DJKMb3GjF2B03iDXsp6oMWU0lHAoB33FeYGMVRGOfuGQOBYK0UQmU
 xttqMf/hTFywH1y8Tz1MR0mPYg0rGwRx6pS9vHJJ/yWzrQzBMtKWsq8ioL9JC/RMmk3Y
 aOvRJnhXuRt7Jl5QbxSfzzAvIFtZpxxgq/gTdMlQ9pjmxhLsfhrvFpB8XYaaAN0+0OlR
 a3T2bUmdOT7fa6cGmlhJyJT+/Y8frNY2Ks4fmTbdz1eysMOhLs8nvCwSyUJ1LJWQKvVF
 DXXg==
X-Gm-Message-State: AOJu0Yy3aOaoByVRUCGvIPAlIZycB4XjJkJsf1Mlw2JyCdqkeD7pDd32
 vEuFh2+MoCoFuzarNw2wzIIuOPrOjqS2/pBh2g8cTQ==
X-Google-Smtp-Source: AGHT+IFZ9JYe0OH3v/505aRW+SFxG0zjvVHqOQE0tp5hEZVRqqvQv70ekmIoc5NOpWzuM2B+lzUh8w==
X-Received: by 2002:a19:a408:0:b0:509:4bd1:6b63 with SMTP id
 q8-20020a19a408000000b005094bd16b63mr6966161lfc.16.1701090081107; 
 Mon, 27 Nov 2023 05:01:21 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:20 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 31/43] configs/lschlv2_defconfig: enable LTO and inc size
Date: Mon, 27 Nov 2023 18:57:14 +0600
Message-Id: <20231127125726.3735-32-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Increase allowed binary size to fit lwip code.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/lschlv2_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/lschlv2_defconfig b/configs/lschlv2_defconfig
index d7c77f8a88..7e0c70c6ea 100644
--- a/configs/lschlv2_defconfig
+++ b/configs/lschlv2_defconfig
@@ -19,7 +19,7 @@ CONFIG_DEFAULT_DEVICE_TREE="kirkwood-lschlv2"
 CONFIG_IDENT_STRING=" LS-CHLv2"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
-CONFIG_BOARD_SIZE_LIMIT=393216
+CONFIG_BOARD_SIZE_LIMIT=409600
 # CONFIG_BOOTSTD is not set
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SHOW_BOOT_PROGRESS=y
@@ -67,3 +67,4 @@ CONFIG_DM_SPI=y
 CONFIG_KIRKWOOD_SPI=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_LTO=y
-- 
2.30.2

