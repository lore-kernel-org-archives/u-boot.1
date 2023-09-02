Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F19C71153
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 16:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 106C8866DC;
	Sat,  2 Sep 2023 18:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qhmm8BCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EE5E866CF; Sat,  2 Sep 2023 18:31:50 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90205866CF
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 18:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31977ace1c8so40303f8f.1
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 09:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693672307; x=1694277107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=nFq1UxNMhes97nL7OY3Gvr0vHp+el/xlYgqY4JQpE70=;
 b=Qhmm8BCxPLjvaye9MZsw9j4ys1uLOoPKBazP+/lehctrAFZ8X0P67sJ+XX2dF8C4pm
 Q1wHNmy2ZE2oQLTZuVZt7Qu4yYNolO5fk3pwQjWodUG21HbWMc7Scchk72p70eEySDJc
 euqrpEiAkBuwywBFNqfQTRHo8xjn2udV24pKlSmH+ceAYRl403G3RZQcJTLL4n92CPSy
 Fz5I63u4hBHtyIECXyGbZw5WgTnRFuBHMyQ8g1HOzdsRk48HsPb0jFiVTLxG0MCJr+P/
 dq7S9qPoQI6ABTVz4MXDDhjhmJJxw7hNRDblwt+wfbUMG6EPpmZBiEzMO7h3ngmvTbLa
 BN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693672307; x=1694277107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFq1UxNMhes97nL7OY3Gvr0vHp+el/xlYgqY4JQpE70=;
 b=Z9/9nOEbaV5sBXgNg9RvYOxlvd5M877zyzziy9qHRGTyzsm7LcDusKC43yQqFiiyo6
 MB1ZASkrlBJsEPIhytt6hxyqaPbq2Gv0HP2HIpjC7FzatmKAuVM5t9JuP9cvU5W26X7V
 VNSlEOEX9/00MGpPFUOsNzOSkzPwZ9N8x/jf5u7/N+BEGzGAQah9ZLYIecehvI3b/49s
 kr/nZMAN7uhD7xHr+PZVR7EdmjWqgyuKeZNfwz4/GomNbLhZVNPlno4A04FcXE3S2oEw
 ioy5iYsn+6be8Vc3zn7Wh/GYRAgVdW6GdRiKFOex5v3gOn8rSZNDIHrMsFQiayARgzY2
 KlCQ==
X-Gm-Message-State: AOJu0Yzq7R/pTYzbN1JntYmorby4QXwGDjreYAlOWnsZiCc4ASaZEpgd
 ITEc1VuwWn+JVj+SFN2AEU8Zb/ipJBy4IQ==
X-Google-Smtp-Source: AGHT+IHYSyYT5eQRn6+msCSGyetN5i6FdOOuEke4fcx+3tdHFJbzojDO3KsBrXX6BoUEAntaTEeDxQ==
X-Received: by 2002:a5d:4e42:0:b0:317:7062:32d2 with SMTP id
 r2-20020a5d4e42000000b00317706232d2mr3886784wrt.54.1693672306737; 
 Sat, 02 Sep 2023 09:31:46 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.71.185.187])
 by smtp.gmail.com with ESMTPSA id
 i14-20020adfdece000000b003142e438e8csm8965313wrn.26.2023.09.02.09.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 09:31:46 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@edgeble.ai>, FUKAUMI Naoki <naoki@radxa.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 0/2] rockchip: Use an external TPL binary on RK3308
Date: Sat,  2 Sep 2023 18:31:33 +0200
Message-Id: <20230902163133.343644-1-massimo.pegorer+oss@gmail.com>
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

There is no support to initialize DRAM on RK3308 SoC using U-Boot
TPL and therefore an external TPL binary must be used to generate
a bootable u-boot-rockchip.bin image.

Imply ROCKCHIP_EXTERNAL_TPL by default for RK3308.
Remove useless TPL_SERIAL for RK3308.
Update documentation about build steps for RK3308.
Add ROCK Pi S in the list of supported boards.

Massimo Pegorer (2):
  rockchip: Use an external TPL binary on RK3308
  doc: rockchip: Update and complete info about RK3308

 arch/arm/mach-rockchip/Kconfig  |  2 +-
 doc/README.rockchip             |  4 ++--
 doc/board/rockchip/rockchip.rst | 10 ++++++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.34.1

