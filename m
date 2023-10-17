Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE10CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 18:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159D686F22;
	Tue, 17 Oct 2023 20:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bs8gGKof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A919486F2C; Tue, 17 Oct 2023 20:24:27 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 103C9865A2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b2e330033fso299795b6e.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697567060; x=1698171860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rPuo6gRr/JYvnCTuNFxOB5QEyTjkETSD9wmQ1N56ErA=;
 b=Bs8gGKofQPh0QWyaadzodq4V/J7LZ9OzSAn/2+ukPQMb/qDyQp94acjHt09CFiZBC1
 WhItKSSzAA6JWrRc+aiox7wAusVYudzIiVV6YYxrJPRrlYg+zoMh2hJi08pSZbXUqet3
 6+LLVmZZpzAmHGzfLK6CUJK1Wcuz535hXkauQ5E+OOqtEyFCx/iitl7dXlw+QgSf02Lw
 XsvGXVeDlLNUylYVNmcFjWSXaHNIZj1L81JCSm2mDw6p9V4xMjwC8CFpyXek/eZf/dkO
 BjvVx77MkqOx+LQHxGb6+ssqR/ZVE5ghKFD6/SZZ80hviAzNe48I669Lh8r97G0oSfDM
 ZgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697567060; x=1698171860;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rPuo6gRr/JYvnCTuNFxOB5QEyTjkETSD9wmQ1N56ErA=;
 b=SinTQmpo6RPsQSn5WkTn14vHtrKIETZQw315OXyHDWUZVQX0sGDT41H1anWpcLl+p7
 8GFpHniIJErt1bd2gN/LN+zxqdziZlcF2+Ig3R/lwAceS+NtpdX8H5WiV6Ip3Dht9HOh
 a26N739PQL805cr9u+loIK0HALdwO1sZaTv5yTbwvAP+UHq4rvJ97k+723nvhtnRAxNJ
 XW9GpcvtmH3qg8Hr5Jzz9A3imswqoXo+KGO6IuJY4Tss2tEYxutuuGTkNVhmO0PSpUSg
 f+y/YORBTvuL79kTFr5l8T5KOPMV/X5/gQwBEDqv0vdcHsCHX57YHPsJQiWIlSFbc2uI
 Xszw==
X-Gm-Message-State: AOJu0Yx4n1weaIlBSneL2C835B4P+vKvn9MZfihpedY074NRB6BA/3wP
 B0Yy1HZ/kkbC1VhkRLK1aLjTfYIBHFI=
X-Google-Smtp-Source: AGHT+IGMhly0n+zvWobQD1674D8I8oNgelXKNlqqdSKrodKspS32i5OnBF5tLVwBWKmXgufYSfDyeA==
X-Received: by 2002:a05:6808:1a9d:b0:3af:611c:c74f with SMTP id
 bm29-20020a0568081a9d00b003af611cc74fmr2709134oib.5.1697567060428; 
 Tue, 17 Oct 2023 11:24:20 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 6-20020aca0b06000000b003a3860b375esm340312oil.34.2023.10.17.11.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 11:24:20 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/3] Add Additional Boards and Features to RGxx3
Date: Tue, 17 Oct 2023 13:24:11 -0500
Message-Id: <20231017182414.321411-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

The RGxx3 is a pseudo-device for U-Boot that works for every Anbernic
RGxx3 series device on the market. Add support for another series of
very similar devices from Powkiddy.

Chris Morgan (3):
  board: rockchip: Refactor panel auto-detect code
  board: rockchip: Add Maskrom Mode for Anbernic RGxx3
  board: rockchip: Add support for RGB30 and RK2023 to RGxx3

 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 195 ++++++++++++++++-----
 1 file changed, 154 insertions(+), 41 deletions(-)

-- 
2.34.1

