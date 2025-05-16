Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C24C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 18:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96F8982A8B;
	Fri, 16 May 2025 20:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DzMgPjjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FED382AE2; Fri, 16 May 2025 20:54:54 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3073C8059D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 20:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-54fd1650afdso3025918e87.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747421691; x=1748026491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aMDzfWZxaRTi2PfoBscREAp2R2js5MYuWOhLW6WtaEU=;
 b=DzMgPjjMIYdj7KoD5X3O6aDPizizK7w+5ieFPmNY3uMUFY2NH2V24Lf3R64JbROBdE
 3Y4NT71W30LJ0g36vyrrGdlkX/cBItKTHTKEh9BxK7FfzVd1l7SsoUoK1+6tbCm9nooh
 HZDaLUhatMpQtafbsdoXBqWHIgjlP1cbFzn56BGx6NA/Tt7DvmePU3K9LVFueXKiWxar
 S1QuN2CzrFrlO/I4ROcVhHvEd8QUMv8nnPF2DGErkivRpAlLCPrIdKfGHIpgzPlcYqn+
 seolmMZE+fBRDX5Ygw9jAiSOfVmwIhfyOL3tmWPayZt02i4jgpRGleivQxTa+uYg2lkg
 s+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747421691; x=1748026491;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aMDzfWZxaRTi2PfoBscREAp2R2js5MYuWOhLW6WtaEU=;
 b=EiMhh6EXCgvFr2doWSpby0tUpoGv8PMfnpo6LQ2vNDwURjvMXHbsLtIU+pznl+9aKE
 rR4QAsiGFW3PUfnOrydiy1STiFTXrKvIfVVtv7kXLNWVsoQ3ds1Eyjl8habgmPei9Wo/
 wkcz2nAUN24KpPH21/UouS2gQ7uLuvImwG/xyORb9XISJSwS+RCA1bECbRMy+pPDqho+
 gbbQZkLw3fci9ddebfvGBg+FSmQ7kRyz1bY9qcD0+I8SasAXMsQZ64966GhCMKxOAkY2
 0vAQ/HrtcOGPXd767wN+8Dv8T2SedZhI5gnLml7Uz5PazIMdV9wCO504NTJJQ4goavTa
 PEXA==
X-Gm-Message-State: AOJu0YwVMm6Nym7gH0kFTjmcBFsWj+/Ava9R5Dl9gJ1vrF7/0IpOFFhQ
 KIeN9P7uFDgjLZY5gkXQL5uz94O6/55KpUU5eN43x36guNm1hnZ0vGR6lPX5Ly88
X-Gm-Gg: ASbGncvBfgOcBXbD/5ms+KpgbmgpBnuf1sJh/4FBZLwlyr17ZBGfTNANeedcYzDWcV5
 RVj3V8MAwxiiLb8uH1HtbC3ctrvlVzeO0P756QVMxoV/vNNx+1VV2ZltHF1BQAW7LIqCq765B68
 PH/UBc2+9d/ki8LZRhlf+B2dxbmclf0iQrDS3YMSwwgi4KK7WkzKFZvzsQCVj2Ifcb05yHEMc3T
 GyccCVldADkJXqyn66E54402X+ttmDjHq+4hFFRu9Y2VqiaQXYB3z5Myz378A9fG0igySFpPieA
 BTKDoyiWhSng0Tl9W/fH7EhGci3+hlYalvY444ncYNM+sSZQg7u/+SzxgQb0BsLwmztXr0JxMSM
 p2U6uLkwk6eDCZVVgnw==
X-Google-Smtp-Source: AGHT+IFGPedGw9haRPqyzYcH0l+2vy7zAzQ+mI2jT86UiBHMzh/jNi2XktxRLmv4u/ciOtRH2fiO+g==
X-Received: by 2002:a05:6512:2616:b0:549:86c8:1132 with SMTP id
 2adb3069b0e04-550e97845f3mr1180237e87.17.1747421690412; 
 Fri, 16 May 2025 11:54:50 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-550e6f30eaesm549552e87.59.2025.05.16.11.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 11:54:49 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] lib: add NULL pointer check for %s format
Date: Fri, 16 May 2025 21:54:47 +0300
Message-Id: <20250516185447.141540-1-ant.v.moryakov@gmail.com>
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

From: Anton Moryakov <ant.v.moryakov@gmail.com>

Handle NULL pointer case in string formatting (%s) by printing '(null)'
instead of dereferencing NULL pointer. Makes behavior consistent with
standard printf implementations and prevents potential crashes.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>"
---
 lib/tiny-printf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index faf55d7f327..da596d72050 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -306,6 +306,8 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 				break;
 			case 's':
 				p = va_arg(va, char*);
+				if (!p)
+					p = "(null)";
 				break;
 			case '%':
 				out(info, '%');
-- 
2.30.2

