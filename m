Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DB4D49201
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 11:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65DEB83A2B;
	Fri, 12 Dec 2025 12:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TJtkZCu3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29D18837F2; Fri, 12 Dec 2025 12:32:36 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89A6C839DD
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 12:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso10655405e9.0
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 03:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765539153; x=1766143953; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bcJzBvEwBb3ESoHqtwqOeFN0qB0F9FknO4Y9bP1z7Oc=;
 b=TJtkZCu3JX0OdIRXPQbn77ft6vSUlW1AJvfffzzazm4AypGhN77amqwBbeGyVWCWDL
 VtlAyfqdeijVZ9c18mzVMLxXzTMaEVo1nnOB607M3xpoVyd6EdpfgBTcXnLTu5iEbQEr
 PkDdmV4IJ6Eqdjwmvofy27RJr+UqxWZwS2SdmlCyg0Cy0Pz6tGoUaoQJHSgz3kMBGF10
 hEA6HQgRk+MplDa1pAWUSOyeO4Ib1gLVCcIM6x3tA047j0OJy/0CYA5kutY0njqKd57d
 AIIOIMuGMobuK05Ker4f/Ea4gLTp25dmJcpA3YDdt1DTVqZse+QJsMggwONckqSPriOl
 eelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765539153; x=1766143953;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bcJzBvEwBb3ESoHqtwqOeFN0qB0F9FknO4Y9bP1z7Oc=;
 b=H8uPnXnDmodhbPIsWLo/+Pnpy26ZjKFDay4CbH9c/ftRRN6cgMmLCpR+6WRoCWkf3w
 TMWzQQ377dVeUpZAo+crjif7Bn2qJd3TdvocTwTAzPFdoenistOmGTQeqdMMDlwBiZ4x
 XdKe8iMxHyK96+OmNzHUKR2sgbQk3Iqulp+c6QSqfjiq+XWAl12AXAdNRwQ/DjBgjg6N
 gDHiaO4sMJB+TWLP/HCDnUkitHSIQP4kbdgI5QAfnrS5hQGrE3d4fZleWXIP8nkFhj4d
 9uq4cFujP5wxmQ3mPZjfG34oJ4EmHQrMxGbOYh4xzRk+Ia64kTIqicKMLPRR8UaNrIo1
 yHAQ==
X-Gm-Message-State: AOJu0YyufTSIluuv7Cm6mmPEUtOULvFj1HHo67DUsiUOiyn71qebMX/8
 SIOCvEfoS+RerQh29RhIx3a+3L9Bl0KE9JUYNzyQwjB3/AFyTI+XDLvgAuZTeXbBKJA=
X-Gm-Gg: AY/fxX4N1g7Q2dfoyBgXkRTEbgwKU/xy0jOI3oXHvwTZXtoK7uTa53B+JGCIYMQJ+0B
 FkDxuJWop+/Mb46zicNQAFyBCsTDMDlC8zmmj8Caaj5xkq3lOSBHcSCGTWNgSXoM66beOzoOQdR
 TPinYaeLJQenSNdRelo7h7A/v5zAiMwzQ1PulzEBCafXOzY4gxdevGSFEraKE2MijZO1qMQJXca
 1PAeqollz2yEcAKLvkvcq2aN25T36SMaZI9N8tc7JUw/QaiQK5/QAK5sw5NJhXQFe4XrOiDWc1N
 jnAigqzbB830S+afMhkEaHFN7UOnTROBqP34Bd8sLibbwg04H+s8GDgDh6P95w2+t+8W2UVuyyP
 ZM6PLrB2O1ZZD6mq7Y4R5nmMXZSHr3t31/vLzMnnzlr6eoJPxh63WqhtWLyMhgT6eagjEdKyVfb
 GVOEPXRKMrxZGjMfUQ2R6REO+Sl43BKWzAQwJdJxI=
X-Google-Smtp-Source: AGHT+IHjxiItNMVcuQpEDI0kw6mUctqLbh6HcEpZS7Xrz4NDY5svui7AuugNtgEz+knh+AyS+6M53A==
X-Received: by 2002:a05:600c:6808:b0:479:2a78:4a2e with SMTP id
 5b1f17b1804b1-47a8f0a5336mr17978655e9.7.1765539152963; 
 Fri, 12 Dec 2025 03:32:32 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:3801:9287:1e8a:f239:8d00])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f8f39c6sm26277235e9.14.2025.12.12.03.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 03:32:32 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 12 Dec 2025 11:32:29 +0000
Subject: [PATCH v2 6/6] configs: qemu_arm64_lwip_defconfig: enable CMD_NFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-lwip_nfs-v2-6-9cb5a60520d8@linaro.org>
References: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
In-Reply-To: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Enable NFS command so that it gets built by CI and can be tested more
easily.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 configs/qemu_arm64_lwip_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
index e8f976efaf7a1b2e3804a012a235f42f1c05d40c..a974970c3d32bc34eadead34976392349bbf9e33 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -5,6 +5,7 @@ CONFIG_ARCH_QEMU=y
 
 CONFIG_NET_LWIP=y
 CONFIG_CMD_DNS=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_WGET=y
 CONFIG_EFI_HTTP_BOOT=y

-- 
2.47.3

