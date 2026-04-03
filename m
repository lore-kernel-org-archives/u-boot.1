Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E324CE85367
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 981F5840AB;
	Fri,  3 Apr 2026 15:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gMBMS2Ml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00A33840AB; Fri,  3 Apr 2026 15:52:20 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C0983642
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 15:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so15561055e9.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775224337; x=1775829137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ncf5CGqxvO5twq8XmgDTVmMycW8ixnJNHA/TGHwyw7Q=;
 b=gMBMS2Mlo9IJhi25spn93pYfO2HsrRjQYK8KHa9XFe46fShqAk/rrr5p3ggJKJssG4
 At5DAPEblx6xX3my34oZpK64P/5gLyJwgvyIh1hTncjROhqEWDbwgJdQED2EyezIDuKh
 ItG/WXAHmHWbQbtkz2ycreNV/QWFMghu6S09Ydyy8pmlBZDs8Wd1iQSAfQO+I2QlHxsI
 v8LenTaUASqGQvtzVQoB//6gAKyAal5ILUmJmd2cOggskXWrkynFczWhvIoDh+aZuZIK
 nQZjZ5HZEmManZgxJrK+ho/2jevwgbU9pmKbfE4Lmy+ZofjOUQ/Bs2pHR9R1DcFiiyJz
 qJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775224337; x=1775829137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ncf5CGqxvO5twq8XmgDTVmMycW8ixnJNHA/TGHwyw7Q=;
 b=TCM83qDfLKjFv8naszU83dChfzv6dZTX63QnGECT4sb8fcN+GW4foXmUpA39Wj9Z6I
 GP1jL6oo/KvL26GZjZXdNRAnu0EOAzDtiSw5VsvTKKFNJneYM7lDmIW+GmlO+eFsz7kb
 gmVgSmTkRMk2h5nU1X2dUw5Ug7QCfJgY2YTZVmYaC8MbxDb7snGEZklhD2w4FSActY6j
 Vx1SDYcQj1ciqqwofQgIBqHfTAKSZruH5MhnM+Pyaq3IE+3usQUbUPnWe321vqenHLM2
 5rvnYT7G9Hc47XF0i/zPlxDvQylyy7ph8fuo65X0jD0qqWUfOji/BULNCkSXK3bLPLf2
 Cj3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx0ClPgxlZLKsuVHNt6B5TKo5eVRVmVbXKNj9LJMDNRhMGLQjA+nZuJxmCFgVxPzP+UcC+nRg=@lists.denx.de
X-Gm-Message-State: AOJu0YyA+pYsR3XJbscxYVEDU9Aj3sFJaYsngmTXwmCkN1YuBsai5wXU
 9aXvRrpRshUf9hs0b1gc1+EXwtvWD1/94HxsKCEDMkWsykDzwGc0O0WX
X-Gm-Gg: ATEYQzz1inixKVqaob9nLE/n+Be7Q/phSZofWFejplZ9LXqUsZ2TJToTl4GXqbrB0SW
 /wM1Bl+MxNTDQS49qOPPul5Pf/FOG0lE0qv4CDBTAY0wXMatzjyaeiN+E+Fmox0nspUgcBgjJpe
 VfT0H8C93u7GZtjtgsIkl6fV5hFk7tlX64im00/D18xcWMCP/nKTALtMmaKJfsD1WI4Du+e/Jbh
 M3GR1W3jBTt3mIL2mjqLTLuEAG5MZuz561S58vau/begj2kprlBMcDUvnNPP4UGiSmgY3duoJZE
 5VuO3LkoUh26qebICA9j9ipdHQcoSmXEyCRyg1fiCesgzahyrfDe/UJIQP2IYxz1zZGN947/bza
 gkUC0lVABXX3Mekg4DGbvy33u+9G06vx2BXDJDcfnXfzZWUS8HApd7T4iJkSU8hNoJh99kNsRh9
 rKDSN+TieM/IW/owlv54XNyeg=
X-Received: by 2002:a05:600c:1381:b0:487:1108:48af with SMTP id
 5b1f17b1804b1-488996a351bmr47496555e9.4.1775224337114; 
 Fri, 03 Apr 2026 06:52:17 -0700 (PDT)
Received: from Ansuel-XPS24 ([217.202.87.54])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4888a7162cesm196732895e9.13.2026.04.03.06.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 06:52:16 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Harsha Vardhan V M <h-vm@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 1/6] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
Date: Fri,  3 Apr 2026 15:51:58 +0200
Message-ID: <20260403135205.26979-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403135205.26979-1-ansuelsmth@gmail.com>
References: <20260403135205.26979-1-ansuelsmth@gmail.com>
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

When dev_get_priv errors out, the ubifs is not umounted (if used).

Correctly handle this handle condition and while at it also return -EINVAL
instead of -ENOMEM as a better error since no memory is allocated but is
actually an invalid scenario for fw_get_filesystem_firmware().

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/misc/fs_loader.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 6af4c7f15e7b..cd4695b08eea 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -175,8 +175,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 
 	struct firmware *firmwarep = dev_get_priv(dev);
 
-	if (!firmwarep)
-		return -ENOMEM;
+	if (!firmwarep) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
 			firmwarep->offset, firmwarep->size, &actread);
-- 
2.53.0

