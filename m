Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54831FCC065
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 19:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F1A83FA3;
	Fri,  6 Mar 2026 20:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b2bOzPq1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69B883F9D; Fri,  6 Mar 2026 20:06:00 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C44783F75
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 20:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so1118824f8f.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 11:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772823958; x=1773428758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=384t6T1nGRmxfLiclgtoX+qLyIvt/gwDrg79ckH3R18=;
 b=b2bOzPq1NN8SDxO7YykpHLPlaBYDkdOij+jI0lIOx/iTzIQXKuzLBV9gPYAZVJH2C8
 ggM+Zvzs6r6Zwz2QAavqgXvF0QQdL5jUYxp4axc7M5/lkzUzupmrprJ35ZXJN/X54NpP
 1Z6Nxrq9t1QjWc6dsQtacC1dCYBByh+zQueMi8drktRkGDR4O3nCdC1r3NAeyq7eeBjg
 IWXKHzGa2aEW9k/dz4hCosmaLEozv+GGignaZXKCTphn3Hq/IpW+JEgjPsK6m1RP4b15
 ujM6ooiWUqhQSoQV85og17+gbpTkGpOdOlbglJCPnkHTYjv1lDVHdhIFg5QFJjuyAmwI
 uNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772823958; x=1773428758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=384t6T1nGRmxfLiclgtoX+qLyIvt/gwDrg79ckH3R18=;
 b=AYsy9CcyEV8n/Jqp49fkFos+erC01CUCcQ533lgKYDrk1OMlSkF+J6f7MX56PSIS+K
 TnunLunYgkr2+wEJIetKuhpG5KPlRPBd1nDJ4628f8SlDwZ9E3NbXFG8zdmdre9s+Xgd
 35TIKfHVq2PhK362wt0foFbBhs9Wo9EuJN/11IBE0ZsFXlCYgf+dSL1Ab5Ypw4smaA1V
 9990/J1I0Lk7XZSefNt3W7BjlutVi1WDkYs8KENzGTondAfVMVS1ybGu5c6s4mzgHy5a
 YPz3bjCUiQPMmHXIwjl2h3gG/UNjxFpJLzPAAYtTzBicOAYj6+jQ1KPp61Eeg6xuXxO0
 zU9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9zWNENCMJRcya7In+QnflvrxR00/rOwGNqddjsT3eChdkb7RYnEICmMJgrrAM5XYqf/PUU5Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzgGfvZwZ5Q4BuZBoP+4vDgYDekILGF0UgY6dT3FvCPpj7eZZwz
 cP5XHrl80uUTr1ENV4xTxLHPX0For6Z9LzW/peW1DXLIjpndN8LsTadV
X-Gm-Gg: ATEYQzxz++Oqp01OF/Skbk2nOn/adOlskHOxBQIujQvUzhiM9QiumnWRp6K1IVOt8Hv
 STALEPiQMlkZEefoyNHu5swhVA6fqC21Sdd4vpaR6s7IEOhOkz8UZ1biC+Z4OMrxkkH6hWT447a
 UWjA4d5ma/e3lMVZnP1nGY1eVFoItNrevzOmPHcPqbcSAKAMRzRDBXqETwOnY041tIa/QH640CW
 X+bk9tLvuKubutOInter3fRkGJe9YUtbG4lO3GRvjSuWlsfRU1PP8/zeyZZmjRcBZcI0OQVXKM7
 vTpQgvC4OuhMhbL2X+Id2J41TxQCm96tJY4Qwsi7WxILcf107WQjK69uB23mNm2IfBbYZl8BVJg
 qvAT2Ea1/rx+lGTd4pV5XcsujyNueS54jIKk+i7jYwtHbpf6VX+nCI22AGp/RP3QKad3m70RH0p
 2QO558bC0/iBGwWuh7igIrpYWcQRMPaG8kwycGZR3ONDHDXvlF2scfYjs=
X-Received: by 2002:a05:6000:4310:b0:439:cd26:ce0c with SMTP id
 ffacd0b85a97d-439da35fa66mr5984819f8f.17.1772823958283; 
 Fri, 06 Mar 2026 11:05:58 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-439dae45786sm6701065f8f.32.2026.03.06.11.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:05:57 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Paul Kocialkowski <paulk@sys-base.io>, Chen-Yu Tsai <wens@kernel.org>,
 Justin Klaassen <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/5] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
Date: Fri,  6 Mar 2026 20:05:35 +0100
Message-ID: <20260306190542.22920-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306190542.22920-1-ansuelsmth@gmail.com>
References: <20260306190542.22920-1-ansuelsmth@gmail.com>
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
---
 drivers/misc/fs_loader.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 2928cf75f89e..7e432a7ebd62 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -178,8 +178,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 
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
2.51.0

