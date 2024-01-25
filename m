Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60992C47422
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 15:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E0D87B71;
	Thu, 25 Jan 2024 16:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="F73MqtyP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DDED87B58; Thu, 25 Jan 2024 16:54:58 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8110D87B58
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 16:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9573740590
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706198094;
 bh=SbEgx2jC8ACGiB8Ink1AMVwhfuqAOLdbxo75Sm/7DXw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=F73MqtyPtcAODokobIisijQrxCsYI3iIqmgU1aVlsEAVuYR8JPwrPD1zhllwR3R2V
 YdSvGxAqTqUli2De8Du2C3Zll5y643QZvLFpUFeXwfK5buOtrizQ9cJvh9w5s+hSvi
 +XCyIexneOxGT2B1p7GY5TqWQR9LU0iL2pL8/Dfa/CL6LWskZWHRX8kziMHNDdGgW9
 eoeCpTXisF8bhJByEQA5scUbjMcZYCYdxIpZLn/9k1sNh7HFaiZQkVMD+C22CfYDti
 VOE2WkeilbtHjyo8LUO3VY6r7Kr9mMaWzX/3sOkOi8xvj7XK/zCH7VcfJUJeDKQTd8
 z5zbw7AEWw8sw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e5317c7a5so51333695e9.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 07:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706198093; x=1706802893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SbEgx2jC8ACGiB8Ink1AMVwhfuqAOLdbxo75Sm/7DXw=;
 b=A01H9EdULKtM6Wzd0LsBNHiX/D9vW+jE95+h93mwxHi83MqvWDn8Gmqz/Btz7VF/aZ
 bkFraBSRtGhqHF/GqzJnztvPdi4Yu35+OmrLxRa5+VKgwlmJ9XHVwgU933YcCQgf+G9S
 XFW1SUoXxUeznVD25c2s7qCowxxaC1zs5Rc2CJGtP9abD/8+xSUegh0KtWGGt8bwzKQI
 5thXPcsBzneKDojKmB7q/A795o8wJIv3G4HZaXDIy/0Dxk3nTCYmhOcSFZttW7LY9Rz0
 ihh23Ba8Ogzf3hqUHdGOjUGyD1ODy90Jf1ap26eSAOg7lSzHB4cI3aztMLEyeINZciSG
 L8Fw==
X-Gm-Message-State: AOJu0YxzOjyzp6H223mfpNGUT6KCspbTnC4Dym2Z3pSIp/9lEadJYqde
 Yg4ey8Gvv0Ek1gplLjQxDGYNWld0Jwdirl/obJsS3okW4YTSJM14tKeIkJQ+a4XsCU8c/iL5FFy
 S+320Hjts/V3evkDJqZ0/N/n1pcE/ocaUs39xUaIGt1TIRTpmhydFCXKZdj+CkndTheY=
X-Received: by 2002:a5d:414a:0:b0:337:c031:7f94 with SMTP id
 c10-20020a5d414a000000b00337c0317f94mr934915wrq.78.1706198093028; 
 Thu, 25 Jan 2024 07:54:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG58rFjOjtxm3lHePfssoXVldU4UOW6aYezzgDgpjrbXH0tIPI4JmDRD5DKcVL3Nqq0Au65TQ==
X-Received: by 2002:a5d:414a:0:b0:337:c031:7f94 with SMTP id
 c10-20020a5d414a000000b00337c0317f94mr934905wrq.78.1706198092743; 
 Thu, 25 Jan 2024 07:54:52 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a5d4f10000000b003393592ef8dsm10557471wru.54.2024.01.25.07.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 07:54:52 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 5/6] configs: enable smbios command on sandbox
Date: Thu, 25 Jan 2024 16:54:37 +0100
Message-ID: <20240125155438.47617-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
References: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
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

To make use of the Python smbios test we need the smbios command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	new patch
---
 configs/sandbox_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index ea4e2c1ec39..a8df5e635b2 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -42,6 +42,7 @@ CONFIG_STACKPROTECTOR=y
 CONFIG_ANDROID_AB=y
 CONFIG_CMD_CPU=y
 CONFIG_CMD_LICENSE=y
+CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTM_PRE_LOAD=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_BOOTM_OPENRTOS=y
-- 
2.43.0

