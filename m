Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE088C2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F1C588590;
	Fri, 21 Jun 2024 01:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CdvzKGaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD74A8857E; Fri, 21 Jun 2024 01:06:50 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1DF0883F2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7ea0b5e0977so56531039f.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924807; x=1719529607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJXFsCW6LCl1bXkmZ8sKbXEiUPqgjCbPoT+lGmHDHLY=;
 b=CdvzKGaPU+bCrOC3SDkb/0c+tPIbLRWpbxlgVHveqAVXslKc9d1WdKFn9dtUedyKW+
 olest1mAVMf0bD7aZcZpNyae70CoKrIMAayK20uIpWDEVF+qKu8o5kxNcLcew6Mh/8uq
 +UR3tPfe/18Fvbl1+qASdwdpSn6be/4dgRxdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924807; x=1719529607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJXFsCW6LCl1bXkmZ8sKbXEiUPqgjCbPoT+lGmHDHLY=;
 b=vw3L79Hwo79EtHCX7Qic1wvHYORMZ6cylYmlg4v5VvOEQpLjB8sIcD0eKrW23YBgRO
 2GkEx6Is8EoSZ2fBX6TdW5nVn4KMVm+YZKGV/WTAxZ8ExF/NgqLzuCwvRqDJ7RxGEldf
 c+wz8uvKalo3TLIVZR37j0E+P5TzQfFXFG40U/QIZ9tyczR8ep25UvsOppbWW3QlLkah
 ntUGwJDMYMyQwC3vMwohNK+LoeWIWY4+FuVzr3Iy/pQS5DeOursJhGajGqkrBpZwhA8o
 zj+K7eI+ClCMP22K7vgoavqNoFAidPqrAufjm/UdtjaeBaCErNS9ATE6vy8Dcb6apfrZ
 3ygw==
X-Gm-Message-State: AOJu0Yz9bR7XyORH30hB6YEUEYEM/aU9zERhT8+t/sgV4LJ+QPU6zkm/
 Yfhe1mY328XgjV1+dOneCJVS/SqGO83GYyyXAinwg+ZwZZ9I5gbjv2wUxPJDW/Nnz6FTOdk5KeJ
 imQ==
X-Google-Smtp-Source: AGHT+IHszklWeWJyugW7BqqRA4xKPSuzvgNMacX1FBngAbvhAFgp9gx5DwjumMIevx4iUu07TYi6Dg==
X-Received: by 2002:a05:6602:2d86:b0:7eb:7bc9:7fe2 with SMTP id
 ca18e2360f4ac-7f13edde98amr735623439f.8.1718924807311; 
 Thu, 20 Jun 2024 16:06:47 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <l.majewski@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 12/18] power: regulator: Handle autoset in
 regulators_enable_boot_on()
Date: Thu, 20 Jun 2024 17:06:19 -0600
Message-Id: <20240620230625.1797397-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

With a recent change, regulators_enable_boot_on() returns an error if a
regulator is already set. Check for and handle this situation.

Fixes: d99fb64a98a power: regulator: Only run autoset once for each regulator
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/power/regulator/regulator-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 77d101f262e..d9e1fb68295 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -518,7 +518,7 @@ int regulators_enable_boot_on(bool verbose)
 	     dev;
 	     uclass_next_device(&dev)) {
 		ret = regulator_autoset(dev);
-		if (ret == -EMEDIUMTYPE) {
+		if (ret == -EMEDIUMTYPE || ret == -EALREADY) {
 			ret = 0;
 			continue;
 		}
-- 
2.34.1

