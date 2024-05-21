Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC28C25B78
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 15:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6C6988329;
	Tue, 21 May 2024 17:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A1YldRD0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 650928833D; Tue, 21 May 2024 17:46:01 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D9B58824A
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 17:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5b2a66dce8fso3375922eaf.1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716306358; x=1716911158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=69Xmox1xGzU1/8AkMryoPh7/AQb6bYVl5QR23SLQX8o=;
 b=A1YldRD0nmLzhXBwwvkgYnCDEz7yapL0JQ6Yo2x+ToFUUGIBlTR6hn+0nmy9B4q2+N
 WT5g2b7rz4yUdiadelswMEdpADOh3K6RYR/ZZXOqa1HDKZ2BEwjUaRDJ197vpq8AoUDF
 sWgeU+Cajkjqk9EQqctqXFoqUm5Hd8zq0eBVKn2PcIWa7feOvqE1CAnNHD2d7qZZUBOf
 KS4+qsH8pew6RgG8AYl2h5DPH1a0426wHVNCaHF5XEuKavuK8IW3EOclK9NWweBdsWwT
 e4eeyouk06Sk7G/fQs1OeZEX+7BweB5xazdXK6IV3iUrkUh8sobJ9FUuRqGvODpPHkGx
 PMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716306358; x=1716911158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=69Xmox1xGzU1/8AkMryoPh7/AQb6bYVl5QR23SLQX8o=;
 b=cm/BoNsgigcEcuQpzPBhkM4a2rIez/9+Pwoit8S41XVQ2YT7RPCNbVNBD0UzFlM5VN
 svwdQ8uF1YwITkiXRXSYGybJjmzvk0o1hraN61yIaEY3E2UyKu12hfb4gPqSCibxiKE3
 SGck3M3SC7t1FBIUqRBnJLXS+g/orS7Brlt+8EasIJPGN8WhVUpHmL2HmhBsWQWoqmNJ
 ML6MFP+9ImXLViUH1dGwNWPaBzJho6Y2v1O/yZbvBc2GXZH2g+dbg7QzoAn1sImz7jT/
 USgZyYdTeEkB78B5zWGoGwpmlrIEqq6/7Rf62Rx7t1r8CX4SuMgsm711M6CyVo0P/+Ig
 /PUA==
X-Gm-Message-State: AOJu0YzemSzskMAEHSCqwAg9Xl+tvLRgrzpjlSSSK/YPZCu/p8ltjLOD
 dCmpsyOhzu9o3V0SclHLNQUGLEtSzqD+oov85c3ZldUGuuLDhtxgYGJkSw==
X-Google-Smtp-Source: AGHT+IELydG0dmhVnahBsHPkqduSr+z3Buy2zL87Hog4hADK1iSKazNSVKtlHa6DrxXIJoneesrj3g==
X-Received: by 2002:a05:6820:1c87:b0:5b6:3b6f:bf80 with SMTP id
 006d021491bc7-5b63b700f19mr670219eaf.2.1716306357760; 
 Tue, 21 May 2024 08:45:57 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5b5390b9c54sm676960eaf.0.2024.05.21.08.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 08:45:57 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/2 V2] RGXX3: Set boot order for mmc0 first
Date: Tue, 21 May 2024 10:45:47 -0500
Message-Id: <20240521154549.255607-1-macroalpha82@gmail.com>
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

Set the rgxx3 device to boot from mmc0 first. This serves as a fallback
to allow us to recover from a bad U-Boot (or later) stage in a worst
case scenario. The code for an ADC button appears to have broke some
board revisions; this solution is much simpler and allows users to
continue to program the adc button as they see fit.

Changes from V1:
 - Removed sdmmc1, as long as we have sdmmc0 we should be safe.
 - Clarified that the expectation is that we can prevent a bad
   U-Boot stage with a valid FIT signature by looking at removable
   storage first.

Chris Morgan (2):
  Revert "board: rockchip: Add early ADC button detect for RGxx3"
  board: rockchip: rgxx3: Use sdmmc0 as first device

 .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi |  2 +-
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c    | 64 -------------------
 2 files changed, 1 insertion(+), 65 deletions(-)

-- 
2.34.1

