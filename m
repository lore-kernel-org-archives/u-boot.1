Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09E0C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 16:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF6E986F88;
	Sun, 19 Nov 2023 17:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="iBx/hetX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5997870E2; Sun, 19 Nov 2023 17:56:18 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A68586F1A
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 17:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso11683845e9.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 08:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700412973; x=1701017773;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvCg6qpaw1hpJVPAIQHJMErdLSKb667oWyOkSuDAoR0=;
 b=iBx/hetXQ52yP8E/z/cDGay3l1nM8HPqNz7WLcp72im9N5AdnMeIN2vBOzgCqD9rHs
 TVFSlcwqNxDbong8cvxlSEKNjgTLyHM4km6nfGiaCWStjkh+vgTF41Sd9yTIFo6qr6+J
 5hcaaozztlEpUZiJcnyZRfSjV8RY7RcctFYDySpUZh+t5Wf7R1SoPr/1JJUyMON/+hGY
 5IftWu7zjJw5vfuG/TAhV7w84uzCI/b5nQiFS0u3y0ZXmXDa8SbvH8+8rF+tVWmDt1iZ
 vCc50K5obOGEOdIv6jyjLULozndx8hHu+0WN6QRMuXPjE0kN0eaHSZutplMG0kJxuZlL
 +/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700412973; x=1701017773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZvCg6qpaw1hpJVPAIQHJMErdLSKb667oWyOkSuDAoR0=;
 b=umFzYjOmQb/l3a1kjDcUqhMzswN8epipAA0gLYRR/Irhi9tjK4GKaBcrS3J3gQdc/k
 I/G5x70bcyfSByTVsVXD+jBUAHg9a0CcQ1Vl8cKlB0KtKssZCY2XUMluLEM3DCPnseW3
 sPqBqQPZhN152K5unFKHJJNdlHZU9k8ywRxDLRxL5rA/bTmia9EqWys65cFYyE10O6IZ
 5bHow+6NL8LlrZBXr6h4l8ZPwAEOmacdrxZIhbUNq60Ny0iuS1l6peU2tB0hV+IWWPkH
 W924W7+lwcBICKuPtdhyNUERf+awlulk6ITVgKIOQc+Tvr9aziOt3eAcDYro8puH3wO1
 o0ng==
X-Gm-Message-State: AOJu0YxE/kS4wWCzSAYcSKcswhbo1N/ETmlbDpHVc++lLlitqVEis9Zg
 g1IWHY8sMk60YmnrAwTbO3yDSjBhdX3vyvlSjCA98pcU
X-Google-Smtp-Source: AGHT+IHSkGxjFubesZHdmImmt+y6X7eoVM8Ot0ybtOKGr0CGdEvveg8qyNGBZo8Q+0LgBG1mzOO7Ug==
X-Received: by 2002:a05:600c:1ca0:b0:406:7029:c4f2 with SMTP id
 k32-20020a05600c1ca000b004067029c4f2mr4515319wms.26.1700412973197; 
 Sun, 19 Nov 2023 08:56:13 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 x7-20020a1c7c07000000b0040684abb623sm14483754wmc.24.2023.11.19.08.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 08:56:12 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Shantur Rathore <i@shantur.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 1/4] bootflow: bootmeth_efi: Set bootp_arch as hex
Date: Sun, 19 Nov 2023 16:54:58 +0000
Message-Id: <20231119165501.1305136-2-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231119165501.1305136-1-i@shantur.com>
References: <20231119165501.1305136-1-i@shantur.com>
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

bootmeth_efi sets up bootp_arch which is read later in bootp.c
Currently bootp_arch is being set as integer string and being
read in bootp.c as hex, this sends incorrect arch value to dhcp server
which in return sends wrong file for network boot.

For ARM64 UEFI Arch value is 0xb (11), here we set environment as 11
and later is read as 0x11 and 17 is sent to dhcp server.

Setting it as hex string fixes the problem.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Shantur Rathore <i@shantur.com>
---

(no changes since v1)

 boot/bootmeth_efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 9ba7734911..682cf5b23b 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -339,7 +339,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	ret = env_set("bootp_vci", str);
 	if (ret)
 		return log_msg_ret("vcs", ret);
-	ret = env_set_ulong("bootp_arch", arch);
+	ret = env_set_hex("bootp_arch", arch);
 	if (ret)
 		return log_msg_ret("ars", ret);
 
-- 
2.40.1

