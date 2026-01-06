Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85662CEFD0C
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 22:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 244778400F;
	Tue,  6 Jan 2026 23:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UCE7qvnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7127783935; Tue,  6 Jan 2026 23:06:01 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A3CC83936
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 23:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-459a6261428so179437b6e.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 14:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767737158; x=1768341958;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bp8yU+2GFvew1JKiMXntk/9uLwVDMhGhjN/Xj+VT22U=;
 b=UCE7qvnAB8rGHGhYl91lkeCSucTh2AOHB/ZFIaQuIKEgRKQBPxL8N70Y9rGzls3B2H
 Txu1Kjf/0rsYbisXjzhlYBcz6tCnXaG6vGir+yrghzzg2iIPqlagT9U66uhkoCDL6h+/
 eQDpurNQCQ1l3r6M9kQs9XZcz+vAt0vRJZdycZ4/nE40zAZNE31Co9NNbQBoBqRvtikv
 yeV0WuWHHrOk9lSyQv3KqGAzWx3y9KJZ+iZc85K8b/XNcI2RFEKSXq6yZbwTp4mmfNrq
 3G7SSK/0Cl1kV6+HlFPM7i90p3PxNfgd/j4J/7kIEG1BddT3hBAGkO+kIRBF4ODoJOrM
 raTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767737158; x=1768341958;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bp8yU+2GFvew1JKiMXntk/9uLwVDMhGhjN/Xj+VT22U=;
 b=bEegU/yDmL6+ptvds0xl1SYBCn9qKMvQY9XUpBopR7qJzEQBO03SinJ8ok4fCoey0B
 vyghBm9RlImnY3uHNGAfA564QT+DSD3lkLCUlvuapfLuB0ERoFbX30uVsZdHWptfp+x+
 DFE4imw4F17JX+kLrHuMOhdkg4r4DnJDJ1lXaAKLUEYQ2xkFsqa5lbCOg41LLwMOq7xQ
 6/i/fw0dKA5Ay/JA4gqvvK2NCXA38nwFj3Kb2/FfWLk5blrRxsAFIBmSVlHoELZH6zyw
 mpg4uRvqhBX7Pr0gnCKdVlGGiH21vZy/E7KxghFlqx+Gspz8oZJEvvCLdjOoIppVKVYC
 R8MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP8EyS4Yxm441Veje+eYgWjLC4DLNekNtAqBRN6uL3bIpyo9sUWpnQw8bQC83vpqy/UyktdB0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+ukj8g+oWaqHxrxTgbJFuRAwMMN5t1UGFwT6xBW1zNI6+W7jg
 nXYPpzZIOuwQMnfY8fkI+ZSjZ3/0AOoRLb7TOtzZ7Es9zoqWhQ7lsrmiQqqyvfJ+asY=
X-Gm-Gg: AY/fxX51N2I9x/SOxuuCqK/fTgkr616YTr/rZfGIXfacqcxzFOdb0nQf6pHNipdRNa0
 ajdNiHkq3RF9ZxaRnuZ9ckKQSEsE0nsST+iW4iuThWP+czNUmZNL9HRgsU8+rgieOL632M7qwu0
 nWuU49oOsb2+8xS/OhEkkuyjEwD8o5KtLV04CiWGfcu9+8X/N/jRMJNgxle8vTOHDcYnYoST7hE
 LX3HqmVNaLUBd/Rr3uBlWaYyxns6TToQqfWfuxA8CHR6oyMtTSlE7BVEFCv7MWFcFlSLSmxzU4J
 CJV+5KhPJ9mu4MSUReTuLq50frNQ109IOlNSwdgSMhTerjLhXADzD82BjsXawFhq58P8+IIaLUN
 06MhoMJR6B6y1ERrZqw1tej1ikEM8nOLdA3WdDHmtHnnXor2hjsYQQVHR2efJvTT9e2sfAV9DuE
 VfIKTbPr5TduweJ0g=
X-Google-Smtp-Source: AGHT+IH+XRXsquAft6k7ZlbFnCxZYqMaXmKQZZOvXkw3E0fSzp8eoUdFR5VcjACz6rCBWNUsEHrfKg==
X-Received: by 2002:a05:6808:6618:b0:459:f014:3cfe with SMTP id
 5614622812f47-45a5ca9f17dmr2183213b6e.23.1767737158030; 
 Tue, 06 Jan 2026 14:05:58 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f98:2205:4ba4:3e65])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e183916sm1575124b6e.5.2026.01.06.14.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 14:05:57 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Jan 2026 16:05:21 -0600
Subject: [PATCH 3/3] configs: mt8365_evk: enable pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-pinctl-mtk-mt8365-v1-3-0ca3eb382468@baylibre.com>
References: <20260106-pinctl-mtk-mt8365-v1-0-0ca3eb382468@baylibre.com>
In-Reply-To: <20260106-pinctl-mtk-mt8365-v1-0-0ca3eb382468@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=660; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=vRQkT1zUTe7+aLY4VnCBm5YJccz9+LXYtdo3tNHm1oE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXYc6UAMFEc9CuOKvWo5Zef1Rnwp6Qt3w7ceA3
 //ZD+iljlyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV2HOhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ApmYIAIrfkULlyqis6XE7dIke0oNwJ8HfyNSNmauunG0
 roDVknX9cjP2OkBF99tBDCpLLbg96zzPFax30790y01P+RMPlCxB6TrDSLgrH705UpN7Y+HnSYH
 GOgMV0kOxb61yEM8yC6A2wuuObc9RBq90/ktRwI+qeBoQELb0N21SypwB9t49gGqyYDc5FWjzOv
 bH9f6jJO+IbjmJCqqTMdJbRVS8YwKRsZY5zSAQ9V1w0i8/KF56Hve4PmV26hVCpdvfDDrhkJSox
 NFYhyoYdJONJNcsoWwisQdXcKR90avDs1CfLgmW1AxJ9PORBAoXwenDFG7rwPUoHlBn4J7efJVz
 ETIE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Tue, 06 Jan 2026 23:57:11 +0100
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

Enable PINCTRL, PINCONF and the SoC-specific driver for MediaTek MT8365
EVK.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8365_evk_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index 7b411453e00..c87fff669db 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -14,6 +14,9 @@ CONFIG_DEFAULT_FDT_FILE="mt8365-evk"
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT8365=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y

-- 
2.43.0

