Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F286E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 04:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4C3801F5;
	Fri, 10 Jan 2025 05:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H1LTBAWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5879780196; Fri, 10 Jan 2025 05:03:59 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B74B8001F
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 05:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christianshewitt@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436249df846so11994595e9.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 20:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736481837; x=1737086637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K9Bo1wufBfvDp17xEGdBsgVq8YY1KmqG+B+4M+rmsTk=;
 b=H1LTBAWph0K6V1tHC9NI6Gz05nXmBT50746QANptDrWHwBJEFbWw7VSusnVS7F7AWy
 OM8fCzqNTAXyMv6cAWH4dUEGtrX/N5HFX8ldb7LfqpTTbc5FBeUoUfVEjQR1mbven6eA
 VXN4qsmLNfRnVYCuKVs4aP7zKTrAf21w51AASDPmUFrHvneNZnNWzZrf1vCN3Zc4Z5nv
 yy7CGe76gVgpGuX/GO4OWGCluK75E/lp1cSLjiSujY7Sx7Geaxx1FHJF8NVR3gvcSxXr
 AVbB7G9Hu7Cf4DpQ+gZmJXaJvflZsOpwxEG2nlrQ6r+eDWZ/CMIJQE1rYT3fYopuBruc
 kGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736481837; x=1737086637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K9Bo1wufBfvDp17xEGdBsgVq8YY1KmqG+B+4M+rmsTk=;
 b=jy2pA+TBEDiLOsYn2pQc5K4L8QspMAzMXxSypJyMA0QwnT+dHbHohhHJpHhAj4albv
 FUbeP8KJVQO97WVwQWf9hqVHLtGyqzLYTH3ClBQ2qnOHiqq2AINxGKmyC4dVMwRLqXCJ
 /64e/QWUYoFhkuoV+kJh/T84Py87eIMUu+A7Cd080N5EbYlyFqV5dyczMNaC2JiPRlM1
 Gddecx80XJLSFYWQBDqx1mQ9XZsVs245a3mNxgaiE3CkTb6t1+LbInT8/JdG6gwWB1Kg
 NlqYrPslWTutYrZKredcE1a9NUt+S471LOWNnXywGGFk3l6IdAYfx6pe5UzFUFaHko1z
 HVCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCIL9coEgWln5+t3sFxeNOqCAOgSSxaX50q36mifgKdKgr3FCj5XAANYxFz5WO2diWdr2GwAM=@lists.denx.de
X-Gm-Message-State: AOJu0YzPwWuslZLnrYz6nem5wPQ1b3uYLk+JfZefXT6fQ79Vz5MAwMIV
 ITE16zXg3ja/3YBnQGhu0kyXFj3JFPzytU+RSk4XYRxLtW9jxBu/
X-Gm-Gg: ASbGnct9/ZK1Ufqn8Ylqp2WcI/ww34nVRN1SF19UANDoW9jz01wHSCvMuITPD08o5Ou
 lsxYmxs1ilkKa734waNmSzFD9d4vaL2OqtXXkNS8hhwZijJLxteYUs2husTN5yQr1rLjHDbpO4K
 dJpvV+piMy7l0bbUeMl8D5wYUBHf3NoJwFtObNIOpnCLdyvnnhwUvnA8Xu1rdcBNed7eOrlBxCk
 PDwU44c5i88oQMTwrEexwpb21ASI0yCRXs4GeUNfIOtcAQK9ZSe2bKLAU7rlA==
X-Google-Smtp-Source: AGHT+IHiy+F2Jl4v5xbpj+sHo2KV7tlexhqY548aspvjHj4DdDRLp+zVYDo51bSm0OoUyQn9/eyrcw==
X-Received: by 2002:adf:b1dc:0:b0:38a:88bc:ace1 with SMTP id
 ffacd0b85a97d-38a88bcadc9mr5438179f8f.34.1736481836597; 
 Thu, 09 Jan 2025 20:03:56 -0800 (PST)
Received: from toolbox.. ([87.200.95.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37d69sm38686505e9.30.2025.01.09.20.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 20:03:56 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] board: amlogic: odroid-n2: remove amlogic prefix from fdtdir
 path
Date: Fri, 10 Jan 2025 04:03:53 +0000
Message-Id: <20250110040353.3424412-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 834e7c8136c6 ("dts: meson-g12a: Switch to using upstream DT")
changed Amlogic configs to contain the default /amlogic device-tree
path prefix, e.g. for odroid-n2:

CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-odroid-n2"

The board files also prefix amlogic when using fdtdir resulting in
an /amlogic/amlogic/meson-g12b-odroid-n2.dtb path which is invalid
with most distro packaging. Drop the prefix here to align with the
board configs. This resolves fdtdir boot on Odroid N2/C4/HC4.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 board/amlogic/odroid-n2/odroid-n2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
index ae953d0e4ba..e98580631ec 100644
--- a/board/amlogic/odroid-n2/odroid-n2.c
+++ b/board/amlogic/odroid-n2/odroid-n2.c
@@ -62,7 +62,7 @@ static void odroid_set_fdtfile(char *soc, char *variant)
 {
 	char s[128];
 
-	snprintf(s, sizeof(s), "amlogic/meson-%s-odroid-%s.dtb", soc, variant);
+	snprintf(s, sizeof(s), "meson-%s-odroid-%s.dtb", soc, variant);
 	env_set("fdtfile", s);
 }
 
-- 
2.34.1

