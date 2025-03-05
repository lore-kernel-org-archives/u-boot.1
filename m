Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF251C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 11:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9E8808A2;
	Wed,  5 Mar 2025 12:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LUETJSTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37BE280F56; Wed,  5 Mar 2025 12:07:39 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BE248003E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 12:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-30bd473770bso12575291fa.3
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 03:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741172856; x=1741777656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ir1lP6gEm5bHF3Q0+C/fQI/FRR/le4Xb3wD5PbqhjA0=;
 b=LUETJSTa3vpIp7DBXMuTw5fY0mWA+3f4RxLBMeRm3rabRthls+2AE3V5NgmmH/9ZHC
 QppAmwbRgnstINXI3rFuMvmOe/NrsOqhKFgFAC2HE2NoCEKHU5QWs5sIu6VsA0uDELUn
 npwsNbFNfT+6oa9Yt1rbP+Af5tDwOeS1GIPzruTFP3Sxoe4s5ElJOvoHnLSpMx+KMwCd
 tjpi/fyEF3LuOM1hCuFvSdloJNbBKujPUu8Mwrsw/FspDFjFq1aDWEAWQLK/2CdCYDQ8
 qN8qoUh/R0U5u/YYbX2+HMjADPueRXUcZrU12iR+zvalICZUc4hhRiGS/7d1tasiTYBB
 6ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741172856; x=1741777656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ir1lP6gEm5bHF3Q0+C/fQI/FRR/le4Xb3wD5PbqhjA0=;
 b=fXu3CVwlHTJLDUMgP7xKr7yBNqW8/NLwCesq/BTZ8eg56snZsTpDc1uT2o8Z5ryjjC
 eXEhy7uz1+W0Vdji3vI85nQpPwWwIIKBy7JKhKHkiWclBeCV0/94vz529fsS9acmQILA
 ae2pqcW36rIsKRmP8o/q0L8P0UPUi/bQaMYLZBmpJ2tJ2aTwMW1rSdj9b63H7oUhoNKM
 blCOnJ5WYjmzorh0mH1bZdNrVuCeXiL3EgBscn/f+exdfnGUVhPwrWrk9UalRdjZ60EG
 cqsA4dQsKQJ+XenlarRFL0/Oyu/cSV5baom46NvipPeNv+feioCPpNC4Nv5WxMuKu04F
 n2Wg==
X-Gm-Message-State: AOJu0Yz2w6mcncitJ01S+lk1sWN2P2mYsU5HrbZb1qgeCQ2dUYQjh2w2
 SWBkdXsweHBBJnjbPtmE9tVtzJ2f46kcM1N016ZFgQkX7hgIOZc7LGdV2w==
X-Gm-Gg: ASbGnctFIJbJqNct+L8rYqXMMeyMbcjWdDhdh9HDb7qjiuVdBnU5QxtU3OFB/R10jGw
 a3cQhJYl0Z/4DNSgNuohAG7bWoD2qQTQJDlCEt2clurFveoJsXp/aIEJPGrCFlqpZW/PhcivXTK
 SSIJlUZXVZpdSOZlzALdCLYKsGhYWgsy1G9qMAGhlyxTCua2PSjsa0FFQy9ThLTXkCO16mJKBLj
 XJPg4tswqWTD/+VgqXoj5ml88N8dmWrzW6wx8qjDfPevzA1fxmFtO449tR8vPu4BxCyoUgORznh
 FjbfIKxIb/75+dGlMKQkpMgvFzu6xEGGN0Pd
X-Google-Smtp-Source: AGHT+IGnP2i3PqOW1KZ7F7bLDizaZY4dzj5FMPievEWYRvh0XzqpD3FFNcyvIBuM4Il/hfGGIGDlRg==
X-Received: by 2002:a2e:990e:0:b0:30b:a98f:9cb2 with SMTP id
 38308e7fff4ca-30bd7a628b1mr9325981fa.19.1741172856113; 
 Wed, 05 Mar 2025 03:07:36 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30bbae78e73sm9335701fa.75.2025.03.05.03.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 03:07:35 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] common: edid: update timing selection logic
Date: Wed,  5 Mar 2025 13:07:08 +0200
Message-ID: <20250305110709.162972-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Older EDID timing algorithms relied solely on detailed timings, typically
optimized for a display's native resolution. This caused issues with newer
4K panels on older hardware, which couldn't handle those high resolutions.
To address this, the algorithm now also considers standard timings, offering
lower, compatible resolutions. Future improvements may include checking
established timings for even broader compatibility.

Jonas Schwöbel (1):
  common: edid: update timing selection logic

 common/edid.c | 233 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 233 insertions(+)

-- 
2.43.0

