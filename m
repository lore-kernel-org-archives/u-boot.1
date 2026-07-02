Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6BFC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 15:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B42AD84A0A;
	Thu,  2 Jul 2026 17:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="JqC72si8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5F284A0A; Thu,  2 Jul 2026 17:26:51 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D0A8841F2
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 17:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493c1950518so4039205e9.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783006009; x=1783610809; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X5r6zeXnWvdvsxAGT59JbGld0s7nkgm1yXkQ5Nahpho=;
 b=JqC72si8x+zSFso/v5nG74ymAZoWLanpILQhzWCopf6EzCEdG4kgadOIZK3ZwzWGjb
 k9/XLmssMK2xHc1HY5txxRdNfjB/sApTdvXNBpVxajVYc1xs9v04A6q90zAOZY86J+fi
 GHdMuEoIxG9E7TFjY4Rm0KTqs8Fx+pCpztEqak+Fore1iyupOLajSCorlcc5JOQeK0sY
 O60TRzc76QlmLZvdPLbJUt4+58zRw8I2P7nJouduIBpZy85WV996ezlIyW5qHCLYoS5D
 tIn9V3FVjFifPsWs1AJOOi6yd/zAi+JjtmJ8qkBGTiuDrYm3KohD/XMov8gMd3BIG8Fb
 jnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783006009; x=1783610809;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5r6zeXnWvdvsxAGT59JbGld0s7nkgm1yXkQ5Nahpho=;
 b=rcCfxoEylrIhVzsvKCvzIxMGF4cisI5zQuKn9PIbG82IIPegSVKd5craBpd01APcp4
 UBgrct1BEvpGJ5uNjxt54xRSv0mn2M4eFPOxuwEd9VIugUbHmVWpcUs7XQUcOGP2sE0E
 8JAyRSjoECHJk4ZeZ22Nd1MglvDU2TQ5cJXBHhlcOwgnmrd8iAk4LAnPVH4MwrTiJ7L3
 SvfcwXwXoTsrmzM7bsFVHEwwRQ7oOgwv5rGNC3nv31ln3s3kVh+mp4Me+SFChKT5sFqO
 rVwYL2MR+2W9kf5kVmLBFbmtS+5xSLIPOFuY5ndUwL7MaQmr3RTCYVcNABjOboScdt9w
 bkHg==
X-Gm-Message-State: AOJu0YyQC+mPhHgMY3xJyrbfzW0T2VTYfi3wCxcPmhZRhgCkkX6Mvp85
 nEr5YFl2nmDU6pmHp3uAqAPvB1yMgGnQH3jj4ksIuMVvJSU1N3jwEWr1ATE7pz4YziI=
X-Gm-Gg: AfdE7ckrerP6ls7oJOJBeKo+OExIYBPjAS2VvHATM+him762GD0qm/nm2DW+WsoHr5N
 RT7kJB8Ifil67+OpUT0VE99ubNUr511aOUVRj5uNTiYc4egYeTo/rfyopsRUDOxhdEhksrTBteu
 h8EVe0SkWnbitlNB+HeNKnthFVac/BvIWWDHt3nWjqPFtnLiOPfGA+mHddVwol6zKPn49f5K7gS
 YKzwkAmvhy+pHwclh6tWU7bWatF2710KvsemygA2WFV/is0cNrXac9mUngLmwi/KfWuDu9scype
 HtMP6TuTWKqAnTopj2kpYkIPZ8wj74GNnvlPv0LrBsKJhQvPN3atc4K1x3lT+RDpsVtZurga4Eq
 tfQ+PoNy6Kz/67T7bggTcRL/ycCigMNck+nUadc7NhcUodzylABIpC+WFGykQ3BQRUrroc3bioc
 B6CQiznfWzge2YFlmbBN8zLY853rfF9u7uRmWxMY9bUGqbHcFm2u6ECn8vqZAeq0Qo7hOcEdu0H
 jJLn8cc/xN8zg3rAdNpvgfRBPwjwr8Tb3F517b7frx9FV7HGf9K2haLl+s024sJAQAK3/rdD0et
 me7AbQ==
X-Received: by 2002:a05:600c:c047:b0:490:5000:917 with SMTP id
 5b1f17b1804b1-493c9b448dfmr3844425e9.1.1783006008634; 
 Thu, 02 Jul 2026 08:26:48 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c635c41dsm107761515e9.5.2026.07.02.08.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 08:26:48 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 02 Jul 2026 17:26:57 +0200
Subject: [PATCH v2] cmd: kconfig: i2c: add missing I2C API dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-cmd-i2-add-dm-i2c-dependency-v2-1-e048ab426191@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7ZhSjIIr72FYtJ1BxkghLRIJ4
 e4WvID5m/+Sn/cXiByEI1yzBQJPEqX3CfQhA9ca/2AUSgxa6bO6qBxdRygaDRFSl5pD4oE9sXc
 zUmmLU2WrRlkNSTEEbuSz6+/1j+PbPtmNm3NbtBLHPsz7/5Rvuz+vphxTKrZkClOqprxZM7/EB
 j66voN6XdcvxJyhI90AAAA=
X-Change-ID: 20260701-cmd-i2-add-dm-i2c-dependency-d8b349b9f0b2
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

CMD_I2C relies on either the Driver Model I2C API or the legacy I2C
API, but its Kconfig currently does not enforce either dependency.

As a result, enabling CMD_I2C without DM_I2C or SYS_I2C_LEGACY can lead
to link errors due to unresolved i2c_* symbols.

Require either DM_I2C or SYS_I2C_LEGACY to prevent unsupported
configurations while preserving support for legacy platforms.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
CMD_I2C relies on either the Driver Model I2C API or the legacy I2C
API, but its Kconfig currently does not enforce either dependency.

In order to not break some legacy I2C board, we need to keep
SYS_I2C_LEGACY in the depends on logic

$ ./tools/qconfig.py -f CMD_I2C ~DM_I2C
15 matches
MPC837XERDB cl-som-imx7 d2net_v2 db-88f6720 db-88f6820-gp inetspace_v2 ls2080aqds_nand ls2080aqds_qspi ls2080ardb_nand net2big_v2 netspace_lite_v2 netspace_max_v2 netspace_mini_v2 netspace_v2 work_92105
---
Changes in v2:
- Add SYS_I2C_LEGACY in the depends on logic
- Link to v1: https://patch.msgid.link/20260701-cmd-i2-add-dm-i2c-dependency-v1-1-19ebda3a80f8@baylibre.com

To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 032e55e8127..8303884084f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1392,6 +1392,7 @@ config CMD_IOTRACE
 
 config CMD_I2C
 	bool "i2c"
+	depends on DM_I2C || SYS_I2C_LEGACY
 	help
 	  I2C support.
 

---
base-commit: 1a3a5c30a253031257b4738e7b1dba635d93b241
change-id: 20260701-cmd-i2-add-dm-i2c-dependency-d8b349b9f0b2

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

