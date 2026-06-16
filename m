Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEF0CD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 19:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA33184910;
	Tue, 16 Jun 2026 21:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D0U0Iz+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF92E848DF; Tue, 16 Jun 2026 21:18:56 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B39848BF
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 21:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so34676895e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781637534; x=1782242334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ncf5CGqxvO5twq8XmgDTVmMycW8ixnJNHA/TGHwyw7Q=;
 b=D0U0Iz+CkXK1NC3xn6k81S9YTBOBdRtwLZxPC7CXkwANeHdmmWe9hNpHwmXCHV5Sre
 Iy+cZqsnunaXKOKWMQW93QVQE+XGRKIvNqrEgt9hwhRV/VMU6+VL95uoi29BaihxmiXk
 6AHa5BT+s/1GdxxN1Mn+jjxx8bN+j09HPHVJgCWPflVGhmYHUv2TD5mQfTTYI7PAH0S1
 BDzKmSZF2LaD1YPM7XpXDiXjn7iB6VzLKbzBt/No91fwQFEvjto3czw28qzIorOrymBv
 /XjO/fjpDmqcxjD+6nRmUPoeKVN1BqOs0vniBd8v302MJmCPFReW6Mx66QhTY7KKdpdi
 fj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637534; x=1782242334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ncf5CGqxvO5twq8XmgDTVmMycW8ixnJNHA/TGHwyw7Q=;
 b=WYDQAEM1OdUduPEhHUW/yBE8IecoyucYc7ar/LIR0TT5fbQNOuonLVaJtI6A2x7VLe
 iLAtd4IJ+EAF+Gee8Mj6o36Sh93id0itlabB+ycpn0Kkj4KZmLOXZX/H57mtQdZfbu/Y
 zJx7RKAWxcTxidkhzjHVGWs/qPis8mo7bwKHRu5kro03R2zNje+UWvu9bol2D9laEriH
 PizQ/Tn6ZKPU/ydwON9IMEa7xCd3z59qQ38x2LWZQOipirBPadg35a3oGRyADjHt8VWM
 dGe2FSw7nhViuLvRYvjnVMmZL5Tp/6/ofeyp6JbMDJAJusoGmNaJ4ZvI02jHH9C3QBiL
 5e+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ89kWbkrW2YHvDlDMD6N+5uroNeCCm4WJwFf7ORQ1Cy1/ny4b2/D08gGFNMzbU/jQnkWCgAUW8=@lists.denx.de
X-Gm-Message-State: AOJu0YyyBIbEPhaPOkmAL5ulfnhdbI0p3S7rjOkq+a02Rm0CRD5uOUOr
 G31ytCeXSROk+RnhF4wUIQfyYo7eMDrUHr+HkBHWDtZt2nAqfBbQHQS2
X-Gm-Gg: Acq92OEgf89BTTFmsc5QJp4ZnqokD0F6UDUojkF7A01OiiSN6qDUDjyHOWgkg6hQ7lZ
 CYsMLWamXae1M6T+fxMThaXwfilatgdwwYp+5cdGe06c2MIOwHcDdA08YhrWRmMdr4uktKE6QhX
 U4ph9kQrr9UxGvl51ojVDeVkVFTTkracoYYV6p1JM0B5uT+FMz1d7LJaBeCZ12FaPULS6HSq0tp
 Yrua0PRQdaWglOS+ViXwaHnHlV/F3bCYd0do87ah2oIL7dURvbBRIG9bbIV7PADIYBzpjSXdhTq
 C/eOP7Nf7q6gPxruZpzUsTDjwtJCODfC5QSX86/SQ8e6/FwUpkpjqkuVow+sVo/GmJ6K8ogIJt8
 vE+AG6v925PwD3TjEZoKi62+MRpLSNext86EJBf4tbFLBMdaig9NJ2UiddCURHxUNNk8O8d7xNs
 ZkMvRE47xz5aPcfIJtsM5RVlznP8ELEEw4lqVXIWt/BL3B+TibyKILBW0=
X-Received: by 2002:a05:600c:190a:b0:490:af90:f9c2 with SMTP id
 5b1f17b1804b1-492333a8e16mr13052375e9.12.1781637534219; 
 Tue, 16 Jun 2026 12:18:54 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4922f9cd140sm91326895e9.0.2026.06.16.12.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:18:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, Randolph Sapp <rs@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH v7 1/7] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
Date: Tue, 16 Jun 2026 21:18:36 +0200
Message-ID: <20260616191845.6182-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616191845.6182-1-ansuelsmth@gmail.com>
References: <20260616191845.6182-1-ansuelsmth@gmail.com>
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

