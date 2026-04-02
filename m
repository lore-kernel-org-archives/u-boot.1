Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56955D7308A
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 04:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A1FB84020;
	Fri,  3 Apr 2026 06:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ago8jh9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C6B8408D; Thu,  2 Apr 2026 19:14:00 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35EA583F7D
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 19:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jzhang918@gmail.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-8cfc40e4158so122573585a.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 10:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775150037; x=1775754837; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OROsGLtLhs1EG01h4OAy4lBUiHrsBxMBuKOI+hPTpEU=;
 b=Ago8jh9KmboW8hRmeP8dKFggoqFnasdfkVmgM9G1B3hk60h4aEkH1iHZJJNxz+TsWZ
 J9zLaWECImqUm7ruYaBygrHq9CCPYiVh6/5h2/baNIqyXZ1TMgDV+4/kvFb0NhxKQfss
 y6vbCYLEcy8FGSx+UsWx+1rd1OKvE/NgjcnfkyIQI3IbFGFygO4KS4uyVY56T6QN7kPK
 6Ze8tpSHfWtkunu2RE8oJ+S6B4tIguhC9WC6w8No1n9YL/dpAVmHmZGxpkeAinA4Byat
 qrjCV5cPgVY1Rmp3IREnncWHTncnoQLfFShw+CF9XE74mWuQ1q/ZNba9vkUfkpo0EAzF
 mWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775150037; x=1775754837;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OROsGLtLhs1EG01h4OAy4lBUiHrsBxMBuKOI+hPTpEU=;
 b=NcDEYaxXORXPAiyWVaUiGuE+wcfC8fVH9fF0K5LPb+LnzCu58OLgJSDCEooUyJL/Bm
 y7yZPCJsmHJRGsyRVnWeMVlvXgufTv/F+4z6N8iYxs04DaMkcg7jp8qt3NE4gLj4jGmH
 j15Nb2p0gmjznz/x0dAetrUE1v8bNQYLgBMjEzDTY0KAtd3OQXHj2V8XrXQ/pVkdgOc8
 fBIPwZ3NvWqte5FY8y7f/qj9Geh/eoeX2i5Q/sL0UlfWEX6c3KL/T4iILCFK5yPs9H02
 KsfcAM+LnCBqpanXs0EZDX6PVODBlgGAV5bXCMkUPiG2TY//t92xjUSX61PFFu76LvoA
 w3+A==
X-Gm-Message-State: AOJu0YyxBaNAIPZ3sG7HsGXwZDsZ//SDLR/Oqq6XyZBSUUz7bbsOBlw6
 FSdBI7hEAnHBDYOU8BMXj0KtitofM8++b46eTuzZbH2ZXqyMP1JlAZMlBXX1Aa5F
X-Gm-Gg: AeBDieu8pucLjlDXfztWYRwwcd6izr3JIlDDuOXUD+IS9qb4Pb1NkwPQexQE51/Go45
 s1eRZdLFcrEkrcMWqOP92nTvfSzTFSkLw/d40ojyYAyGX0lFhv/d6FqE3RCJnf4L93Sf9QjhU1q
 lcD8nra6uzMbfBBT4gEa/5YVJlrok55rhec/IrsfEsvfIRhJ5NzVaX0+ZR1jIEmPoXPjEjAyto4
 Ck0wmXsIE4IpOrJ4Gw6elO5DrX87KW5MGvbC/j0P3D6zeFLDRD6PyvVUIbQA3SwNckqFf3MdCCh
 yPCaP2JECLwUJhWCphGLT9ix15GJWTW3AmZRrsmt6LJLefngprwiev13DI2s+HpiW4MBca0vj6Y
 X+q4mrmVOqhENHMxtu/b/lHz2HjnyMyTWHy74K/yH1XFzas6DDVLrY/UyK8E16jxVBVJQvJJR1O
 WVyVdqr1MjG6itKFrZrcRshFoY2yz2Q1NePLFfz7PzpkMHj60RHS/pIElVbeSPDSx/
X-Received: by 2002:ad4:5d6c:0:b0:8a1:6509:9cb5 with SMTP id
 6a1803df08f44-8a43b321a40mr132557566d6.59.1775150036643; 
 Thu, 02 Apr 2026 10:13:56 -0700 (PDT)
Received: from P5510 (h96-61-12-172.cntcnh.broadband.dynamic.tds.net.
 [96.61.12.172]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a5977e00b4sm27112226d6.47.2026.04.02.10.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 10:13:53 -0700 (PDT)
From: Jie Zhang <jzhang918@gmail.com>
To: u-boot@lists.denx.de
Cc: jzhang918@gmail.com, Jie Zhang <jie.zhang@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Tom Rini <trini@konsulko.com>, Caleb Ethridge <caleb.ethridge@analog.com>,
 Ozan Durgut <ozan.durgut@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Philip Molloy <philip.molloy@analog.com>, linux@analog.com
Subject: [PATCH 0/1] arm: dts: add/fix I2C controllers for sc5xx
Date: Thu,  2 Apr 2026 13:13:15 -0400
Message-ID: <20260402171330.165754-1-jzhang918@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Apr 2026 06:52:30 +0200
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

From: Jie Zhang <jie.zhang@analog.com>

This patch depends on Caleb's patch set:

https://lore.kernel.org/u-boot/cover.1775143241.git.jcethrid@gmail.com/


Jie Zhang (1):
  arm: dts: add/fix I2C controllers for sc5xx

 arch/arm/dts/sc573-ezlite.dts    |  2 ++
 arch/arm/dts/sc584-ezkit.dts     |  2 ++
 arch/arm/dts/sc589-ezkit.dts     |  2 ++
 arch/arm/dts/sc594-som.dtsi      | 13 +++++++++++++
 arch/arm/dts/sc598-som-revD.dtsi |  2 ++
 arch/arm/dts/sc598-som-revE.dtsi |  2 ++
 arch/arm/dts/sc598-som.dtsi      | 12 ++++++++++++
 arch/arm/dts/sc59x.dtsi          | 30 ++++++++++++++++++++++++++++++
 arch/arm/dts/sc5xx.dtsi          | 12 ++++++------
 9 files changed, 71 insertions(+), 6 deletions(-)

-- 
2.53.0

