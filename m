Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E93C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 422CB80944;
	Sat,  8 Feb 2025 18:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="URCormhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51F89808AF; Sat,  8 Feb 2025 18:12:15 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BE888083C
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3ce915a8a25so10371675ab.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034731; x=1739639531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmK/YGmKBpdScDjno0kUy4Uy34Xqd6upCerSI+Oj1oU=;
 b=URCormhXwWwpJMvHZmks5qnCwoUz0JrWOxmjTtCx7JTqD+ELM1RqgwZlBxcBVQarpA
 78WYRoZnoSgZr7KWNek9jxXwehxZobCOgrEJDkvdTZtMmeHv7QMF8bCUXWhfhKW3WVMz
 uENZho4L8AhhkkcP0vLKzQ41bePW43WjeUy70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034731; x=1739639531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmK/YGmKBpdScDjno0kUy4Uy34Xqd6upCerSI+Oj1oU=;
 b=bGIZLM5jEY310rFhaVYHkMVgkZ1yTR6dZ8B5qNGPDg57O+lWONwc/tMA7y7xYS9NQJ
 NG06ooX/GY426PHUaWTJXm3Eqy3Qnwcr52qUmQbZOnNlkkq2lm13oB6ZDX89Vs0oK5jB
 eKRg9pmumcFSUdannr2qIJf3GUYyBhNkMyWsB22eOUauISx4Osd5u3R64lgETmFFBrgG
 gtQIGi9bZQmOAIDO438QdSiED51zeyOg01xT1RWdF7m60Z1hA9lHrixGBOaLkQx+BGpl
 329zUHrLP6VcTz2pfJw+thiOru4TUr+KgiVG+ywHWJSE05JJu0SIa+EwdhFy/ztTOf/9
 sk2w==
X-Gm-Message-State: AOJu0Yw+vj/EvO+jHp2ijmQa61yPt7YPsQ2/SyWxHNLyt35aqtLb5AXS
 ao+ayC0E0asUquq8FeZPXeMMobiB+OBq+ERcl88eD6vv1Wn90PXhjZKPdWGLOpcFtiVwo8b9H8c
 =
X-Gm-Gg: ASbGncs7IUpVCyG6bcaL5rPjzg4Gnjs1sxIb3nXlUb39BLp/HMMmsczrVbFG6F8VidG
 1bnTQBWALOaLUBoTT9m58eq6OWXV7Az+ysM07WTKoGpr9mi7qVb2S3iMX5Mxl0qdntiCRqzp1Nh
 sY/pqDoTtxsGQhCO7arwYQhrQj2lUFuMBTGVxlmgfRco1RHS/k3cRFTHX50rFpEHjdNoPx8z2GX
 kgjKlrg+/G+mzgSu269CcbPHqKO0lBKsTxH/ESH8DSQS9aU+FOyU5yZGKDN6hPD4piwYCO1WIcg
 hHBLY6zuXuHyMLRrqoUbUn3K3iUESbaal6Q/jQXEzBV+VPhODEt7
X-Google-Smtp-Source: AGHT+IEfIHdpd89JaVwlTM/AGXe8B8kzbbAuR6dyvezVVfRZM889UfFZi69UtNF0tlggbvHI85QVTA==
X-Received: by 2002:a05:6e02:20e2:b0:3cf:b365:dcf0 with SMTP id
 e9e14a558f8ab-3d13df549f7mr56163035ab.19.1739034731344; 
 Sat, 08 Feb 2025 09:12:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/29] video: Use a local mode_info struct in the EFI driver
Date: Sat,  8 Feb 2025 10:11:23 -0700
Message-ID: <20250208171154.1305761-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

