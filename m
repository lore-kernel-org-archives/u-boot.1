Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EC6E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 18:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 336FF89726;
	Mon,  9 Dec 2024 19:20:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oRBpm149";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87CBA89726; Mon,  9 Dec 2024 19:20:15 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6441489251
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 19:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-841a9c504d4so332516139f.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 10:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733768411; x=1734373211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqB7uAZpwwuovR7NYms5L0m8n128jnw+EH7hO8OUO7M=;
 b=oRBpm149HIv3khLTLQKF70FmsVITBGtMmp5L8/5sTCATtFOWjELPLTA0QAg0z4/kDl
 PrwkdKpgimqbFDfHxjwqggXnkS+B8HYLxcIenESJdhQvHjbxPCjQMzm1vpGBtBj6Ydd/
 nozq7kqDLotM3ev5XwIEOdf1Ve2kX6dh3TkEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733768411; x=1734373211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqB7uAZpwwuovR7NYms5L0m8n128jnw+EH7hO8OUO7M=;
 b=NtSrTo8IF9u7V0kBA2WPoJnG/Nqu5mPh7xzT3BLC2TLlvQjGUEpFYX1iD1DoLpLOqL
 3szkYx4KjCo23u9+85/ltPgPZmxNtr2I3/5QkTSfmmxFE5lYeK/Cd8+vc4Tm0ljnEtsI
 fRkqdvvPM3VeNFEYjP9bRjP+rqyvlncWHIGHunOC28PVK6fHV8zam27HEF4NYIbm289r
 uiNuYLboNsRfOdQeCLIEE+AT/uOWu7y9c4XJ2TnRJw2kSaCPes9exrlQBImb1/pLvwhx
 4PNDtimib/SotowQa+xoiU1KNo/F8Q5kHjV5xroZIAj+aCqeJ9d6iIroDbT1V6Rsr/aQ
 2oOg==
X-Gm-Message-State: AOJu0YzUQoOMhbsQcs/JJDigX9UZEP2l6LiLvEsQvsIzhoqMqRceyF7n
 cwocvrgw3kmqbJu0xMOZ91YK/yhXheWsKz72iOFQwRhIaqK4jEUqKl+VWCrD7oSNc4qTMxBqSTo
 =
X-Gm-Gg: ASbGncts2clCCiemEckYOGRco1YuUlEi8VdrpnGn4TPwhLx/AFBn+C2ze85U5ORDhdT
 NeJWHlUzvyPn+P5ALK22hLFOtHr/66Z3CBUb4NHhTakszxTZCscNUus5j6d2gohr/KrPLZNmZAY
 59HahW9EI7IvCc/k4cAPXh+Pda6AGUfrLW5ufmioUpAvOlY4Qu75YF6tQ2qi27HQJcxVyZCL47Y
 Hhjze2jYxS/2fvOSxa5KA146SZIUNUdQKqAvunP0F+59+bsmMgTHtKfDg4VOIzNS1QL4b/clkFM
 FRoZK52id9o=
X-Google-Smtp-Source: AGHT+IH14DBu5YEe0YsyZ1xdBpGhkQSA/9scy0XwCkRbybXJ4mYBZEkpil0cRceF1xvHqbPzxH/q0g==
X-Received: by 2002:a05:6602:27c6:b0:82c:e4e1:2e99 with SMTP id
 ca18e2360f4ac-844b5217c5emr187554239f.11.1733768411637; 
 Mon, 09 Dec 2024 10:20:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d8845sm2390429173.83.2024.12.09.10.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 10:20:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 1/5] rpi: Add myself to the list of maintainers
Date: Mon,  9 Dec 2024 11:19:57 -0700
Message-Id: <20241209182002.671953-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209182002.671953-1-sjg@chromium.org>
References: <20241209182002.671953-1-sjg@chromium.org>
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

Add my own name to the list, since existing maintainers are fairly busy.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to make myself an rpi maintainer

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c6c0c2a4bc..4b9bb9ef3f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -210,6 +210,7 @@ N:	aspeed
 ARM BROADCOM BCM283X / BCM27XX
 M:	Matthias Brugger <mbrugger@suse.com>
 M:	Peter Robinson <pbrobinson@gmail.com>
+M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	arch/arm/dts/bcm283*
 F:	arch/arm/mach-bcm283x/
-- 
2.34.1

