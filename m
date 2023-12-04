Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDBBC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 12:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93FAB8754A;
	Mon,  4 Dec 2023 13:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m8j2r7U7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F417387626; Mon,  4 Dec 2023 13:07:13 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B95875B6
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 13:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50bfd7be487so452377e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701691631; x=1702296431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RT7RsSzsdLSxuFFY+pzbV0GIbjwfPtWfJC6y2Apj2w=;
 b=m8j2r7U7Tlu78+KcI5M5vECTV3ttOHGJc+aNKKm4PfmMldtgQCQzhOSnt17TyeiOz+
 JWc9GJXcMZTu5aCumEXcmajpHhUNGTI8A3Q6Oww/xUwCMaNUfPSVKuEJI/JX5nEHoF20
 jnrJKCH/TJ5JCE1gK/PH21rqPAuRRpWzxbXFoBvO/bsLAkV/Qqgz3kGlIxOngN5R5e/A
 acGLeYctznlQCCbrUuJNo7yjHETpCFSWEBR6Sd54rkdLKtQ0A55qmcdLSpMMdXtbiG5n
 ccH04cVNhF46b7yrg/Gz/WCttFrVQvNE4sY//5UAMEeGvoOETP2QivJGkQE7s4ufK+Kn
 ph9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701691631; x=1702296431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RT7RsSzsdLSxuFFY+pzbV0GIbjwfPtWfJC6y2Apj2w=;
 b=wGlK9wzmwsyRU5jgB5reRDw3EvCnHBtBHoUVC6jr/NBrSPnZxLhkjEmeEx4ZBi9+JK
 x8MsIduLklYpRVFYg3ga3SCihpi3db1mwgc+IJQzXXnCeJH5J2gte3mxSM96qNbJO2Nd
 ZuSJ9p28781NrxSil5s57DHkYDTTYSWahPtEVTvzQyujKN52TD9FSJeS2BV18+nmfXIk
 1U+ZJYvQ5H3tT2eKfTz060skR4CLmWxksH1t7i+8L1ALFcEpJtV2rwyocs19NHXK020x
 dOwlyUUGBVwVRL/oKtl7idJxZPotKABY77t+1ujCgQrzYi/5S7tw69+fGlopmChrq6ko
 b5uQ==
X-Gm-Message-State: AOJu0YyBn0U9Uvs+nB/mVZuMwfkCE8AYjql80Kr99K26yzbhOscyOUDY
 9Wlap8Kk9Smy+w6AxSX+GxqT93ZgL1lWsHxWP7xntw==
X-Google-Smtp-Source: AGHT+IF+1UW8USJZcM+nf+e7Otwf7fmozD88cg+h292cPaSAbaatJ3Naa1CF9foUz+MWloc1pdIcVg==
X-Received: by 2002:ac2:5185:0:b0:50b:fb28:4530 with SMTP id
 u5-20020ac25185000000b0050bfb284530mr461861lfi.119.1701691631158; 
 Mon, 04 Dec 2023 04:07:11 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a0565123ba100b0050befebf0ccsm541675lfv.292.2023.12.04.04.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 04:07:10 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv1 3/9] net/smc911x: fix return from smc911x_send
Date: Mon,  4 Dec 2023 18:04:40 +0600
Message-Id: <20231204120446.3277-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231204120446.3277-1-maxim.uvarov@linaro.org>
References: <20231204120446.3277-1-maxim.uvarov@linaro.org>
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

return value of smc911x_send is ignored, but on sucesseful
send we need return 0 and or error -ETIMEOUT, not opposite.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 drivers/net/smc911x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
index 5c5ad8b84a..616b7ce174 100644
--- a/drivers/net/smc911x.c
+++ b/drivers/net/smc911x.c
@@ -403,7 +403,7 @@ static int smc911x_send(struct udevice *dev, void *packet, int length)
 
 	ret = smc911x_send_common(priv, packet, length);
 
-	return ret ? 0 : -ETIMEDOUT;
+	return ret ? -ETIMEDOUT : 0;
 }
 
 static int smc911x_recv(struct udevice *dev, int flags, uchar **packetp)
-- 
2.30.2

