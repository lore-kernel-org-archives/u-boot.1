Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4ACCA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 340E381291;
	Fri,  2 Oct 2026 16:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VyHcjRHfEM31; Fri,  2 Oct 2026 16:36:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6C3E181227
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790958968;
	b=quRs6BsUTqOU1QpN0sxLWdfv/ATAWQPyGYhOh0b5JRRCNxMvP4SuUeP4V5r90uL6a15Y
	 rR/aENYTc6Cx5feDFXREkLHNklLWfcimC1t/hp7vUMiUBBEAyzGXD2Q9V/4NNOEI5gheZ
	 sJcVmugn3IsIcidh14LTj+K8KO3pOtv8+p1VSlnM37+nL28he5wzSJ1gd4bqRsh2n9zm1
	 7n5l9sKIb9HSIbnPQT8fJ+8xc1RzgwZx+e7Yc6LJJpTQooVd32xbnUr2PrWmpyd4LjhfO
	 xNceRs9CKdp2j/rRD1n5SXgslvpfVEXOYBFZMoeBa7F+R6IxHk/D70CHcxe8iE7kKUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790958968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1waFEHBWzai1c2Hmu5q/5u8sB2G913irXgNIXxvc9lI=;
	b=cSn4mrg21ygZz5txRhSEqt1rQy1iEmq7N7EhZrLsgnsTRa9G/pw8JL7c9ncSListSDef
	 tGuJWMH341TDxkwGnhEl/TlNzcGtFghefhGjtPt9H+lohhx4UCuLpRIHHd496lMRbAQTG
	 myXo0vp3iucLi78cMZTBOKoKGG6NAz3iYEWL/oh+pLXBjXN4FI0P7Bn6DlaVokerdSjXb
	 //Rxr2H3dzOilIE77HAopQYXUpyRyHS56DE5lrsGM0Gp6pZVnJwjmRAFAxJSPb6iVNuEc
	 T+f5e15gjTxr3FzDV/XWNZY+ioo2rkZdlZHvS6QAN/Dl+TD6BNvVgHgPkT8rpEV83LQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F0IAz4Iy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790958968;
	bh=1waFEHBWzai1c2Hmu5q/5u8sB2G913irXgNIXxvc9lI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C3nguHRCd4JSKBoXnFX5nckCcAySIK7KhI/1IlVC4m8gqQMHWx5q/RvgV4lOFbJlM
	 ogHbEQGa8jla+gNLMG8+IERxk/UQUISv1T2am6ZGR4pVUzzcjUrQS2n51V/udxJcC3
	 5YuSszkpIBYmriddiJUq/yYWEJbmCDUjT8XfQO+yf4Pe2RqvWIpGuslnomokdXcwuE
	 YqTEq2Y6leMpwl/drAe768TIX4MMojCfnjmMng+yHG0WyM+I4XeknQ3Eu87GuCFj4i
	 r9uG2XZ5HUgfAG0tVRltuq5G/xTMT1xLongJRYmOzFENofasQY+HT3aj08Kuv2GfVo
	 9Bhd8ReWepvyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C3E181227;
	Fri,  2 Oct 2026 16:36:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FF36282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4525381227
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nxkapOLUo6qD for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 16:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 541858103B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790958966;
 b=oZvn5nwRaMRjpk/C2OfyrJPlxp7zQgFMW/2nrci4wLZ9OnLDVpycwuJpmPBz9aRWnPpK
 RZALBQyv/D4whvDQrhGx4ESwDjK23jbhD2WCOf3Vn7km1g2OFhP05ObwgLIfry4sZV8dJ
 /qTc4J4IpBiwSyd2WSjPbm/DpTeVkKh1cSU5rcY4GU4k8X8UfGvsncAYwOHW6/7E5b21Q
 n3L9n1JdUxybalbK6Ypa3UXB1m0TEyRFVCo8OX6NwjPc8740HR9D8aoAIQV0b3sUscxo4
 AN+oKCNS36ku67nAMdXMPW0zTUeYLW9/N0iMdzIFq82F7c37xvGlksZyhfgqyLEpc3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790958966;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=1waFEHBWzai1c2Hmu5q/5u8sB2G913irXgNIXxvc9lI=;
 b=IbYjBFD4lJcqA2XtDPMoyMp/fHsb73qeEDQh03ftHlyl0Hbez14UKuVwAkUVRt9Le09U
 nxlnCo+pjkliEgGYKFyS6gCIE21ts808RV5tJeyVI5EnmMI1f9PlE8p3+dnMCl3wSVDpP
 ZhFPfzzedlGyXx8CiMS7AoU1Fo43ukcKQtosN/7fsoWPIMIMaK4P/iYsCiCKxDmP1LwTi
 fbyPr7BK3oPlXo74spsUN+whAn/Lf/UDkxs8jiQRKVmVmU+UFoQwQrp/W03cr+FBHR7Qj
 DuCw72aV7M1EHUoV0BQggkA5eazxf5xD7z6tN95F3NU6XGHDj6PQmNOWL6MZ0oZkNfg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=F0IAz4Iy; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=F0IAz4Iy
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 541858103B
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:04 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f63546c3so6174497f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790958963; x=1791563763;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1waFEHBWzai1c2Hmu5q/5u8sB2G913irXgNIXxvc9lI=;
 b=F0IAz4IyIMlRbDcLd57kNd9oo7avFhPMFWlqqhOnZw547KOt+Vuh6YoqIaDf650nSU
 lAUT+yI49lAFRZp6i1DUN78ZbUtGn7fx38lOrMICKYJbebk13kWAarXFS3LvY6IH8paK
 oqJurF6B+R3/piknqi8lSF8mSXUG/F/cJ2PluyW9NTnuaoRSmWfy/ntGTE90e6mzhv68
 3CrAx1/oevEfJWG1wl3CL0NXdyZnFOIp+dDTAyBR6335N653ScEPnVgfZYRFq6uwecDW
 WtUqpa9YZkOhjLPKsigPlL8J5G3OlcEhcQgiNqUmbmHsbCzIANrVnPnZc+I/sUTQot5f
 1WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790958963; x=1791563763;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1waFEHBWzai1c2Hmu5q/5u8sB2G913irXgNIXxvc9lI=;
 b=h6E47OUibyPxnFTHABBQa+E0WsntFDzZEX9LUSrNdc4hDNZuRs/FD2uCjcqP/T15wc
 TJt6Zz+Z6kUGn8sbHNiK/Xldumd03Iz2RhswCyqD5XGjFNQbY4vnRPvWvdvt3PCdaoQg
 tXFpC4lXyw5/1fExeL5GWdU8nW81zCDIa1WwuDzOVX1GPa77ZsG+zaV7ZPpaxyx0W+6c
 8pQfq8tBbP7Cx8p+jSxM6nTAySYMclSPD65smJvJZxwSEWJ8rk/m9KylKFsqA7cab+gr
 IlKCCxeedD5cft+RPY1+dU8V0cdeQ9oqjOGywe/fXNMgLUME+U/O6vmT9Q/+j2eQrVVg
 mQ8g==
X-Forwarded-Encrypted: i=1;
 AKwUvByMd9RQgL4p7xtOGpT2ITpjjvrJDc0ElIinf+q8TCh7IhRTZmMZ+gwuvpBvMKEB5epFRhrtqAc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJchxXCZwWmKxyOsbB6cmPPNjx/+3/BaSdvMAdFyoSQJs0NdXMC
 cRqh2fHJpDj49lZReNrUOYASsvTfs92+h8teEMZNr0CNk141N+f1kCuI
X-Gm-Gg: AYBFou2IoqPHUlGJ61OTQ+LGFHDTtKFvGdwMqYynGJK4tTUyNKRqrdNQnUsR57juDCx
 N1QhrRfT62ubznzazBCxty46Lz14PQ0gJ3ALF4sptgKrQGpU/SNgMubHnB19BfU6IlkKpzSMAcZ
 wfT2u00i8NcUs3P1ojrG8wkHWXVRANWxe9mj6F15ck551sTG9X787t8av42hVuBokoG0ihkO7NP
 KEMOu7KxKzKGtFhziebq19HK2+3tutTa+YGr/Q2oOtmn1q1/QjC1efQiHeQDevf+pE1ChAb8bsl
 5XmNtw6uGbUGPYWuUmamWrqtHkj81t+Pe35kTmrb/fNQdeD9x/LFE+0TST/CFHLa7LteYsXyLsr
 Y91aChhyLSSqVu1FrjovEIW2iaAnqD9Bizhi+Wd31Ytoya7uZvF2ljpbbLynKtyE9Tol1AMuFhi
 NFmRO8utmSnhg/F4oECh877JXMZ2a0dDjq6htySa7V9/VHMFzet54Y1LTqpvgffXvaKNhHgKKPi
 W/xihFoHw==
X-Received: by 2002:a05:6000:46da:b0:48b:a4b:5a2c with SMTP id
 ffacd0b85a97d-48b126f6321mr4499607f8f.3.1790958962765; 
 Fri, 02 Oct 2026 09:36:02 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.234.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ae1sm7135338f8f.39.2026.10.02.09.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 09:36:02 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 0/4] arm: rockchip: TPL/SPL config options minor fixes
Date: Fri, 02 Oct 2026 18:35:57 +0200
Message-Id: <20261002-config-v1-0-11bb20983682@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG3dv2oC/yXMQQ5AMBCF4avIrDWpQZu4ilhQo8ailRaRiLsrl
 l/yv3dBpMAUockuCHRwZO8SijwDM/fOkuAxGVCiKqREYbyb2IpS1VgprXstEVK8Bpr4/I7a7nf
 ch4XM9q7hvh+0qWY7agAAAA==
X-Change-ID: 20261002-config-36524677a702
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The series fixes some minor issues in TPL and SPL configuration options
handling, improving configurations consistency. Neither functional nor
binary changes intended.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Massimo Pegorer (4):
      arm: rockchip: rv1126: Remove useless TPL_LDSCRIPT default
      arm: rockchip: Avoid TPL_LDSCRIPT configuration when unneeded
      arm: rockchip: Avoid BSS SPL config options when unneeded
      arm: rockchip: Remove useless SPL_SHARES_INIT_SP_ADDR check

 arch/arm/mach-rockchip/Kconfig        | 4 +++-
 arch/arm/mach-rockchip/px30/Kconfig   | 2 +-
 arch/arm/mach-rockchip/rk3328/Kconfig | 2 +-
 arch/arm/mach-rockchip/rk3399/Kconfig | 2 +-
 arch/arm/mach-rockchip/rv1126/Kconfig | 3 ---
 5 files changed, 6 insertions(+), 7 deletions(-)
---
base-commit: a000f2af240eaa996cec92f8d44bad96fdf3f898
change-id: 20261002-config-36524677a702

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

