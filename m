Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B591BD2F031
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D331840DE;
	Tue, 27 Jan 2026 14:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hOnn4uKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 014D483FE1; Tue, 27 Jan 2026 11:14:45 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 117A083F50
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 11:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so5233775f8f.3
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 02:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769508882; x=1770113682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hP/PMtpYEX43MS3Q07hwbBmi5uDyp+U3meArlF4+24E=;
 b=hOnn4uKaLgNy/mdBN7UPIGPdnhQ2PCvRqqMI0dQiVCA883mj+IzX3sdhK83qJonHu4
 DNNiHAXneQ+yMfrn9xbks/5NdR9TtVMMze3YWdJMqKi+WpvrG6RwFHgmXX/4LkoDqdiI
 7hkMWAsT+NGMv65HSulFhq7Vne5UKYoSlFp/hiGtL/zSLHLCwavZI3Tc0BadiFtSM8io
 qOGkp7Cy9c7A3FGg6z4gTCtkUPMPXh4uSvPsNLSUGD+/4MeoSJbEK/5xto3aSAnWj8wY
 H1Ian5I7k+ifBZtVcQO3+NdJeSIHwFEmnt1kVmFx5NSZ0hJRByE7aFaPQAOQzeT6cBo5
 AURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769508882; x=1770113682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hP/PMtpYEX43MS3Q07hwbBmi5uDyp+U3meArlF4+24E=;
 b=vj5u57Gy/Sb8RoNiy/I8jw8wUJRelh59QyI8qkavhGl/IRKcvVo1z7nvHBkdisl1OP
 NofUKN9g8d4F7c+YdjIQn569v6Wm8loRVLnAiEBPJisKmsqIY6lJU7DmBlS953Kxz1yY
 sYTgCrFsQTDoMJzRbo+w04NjJ+CQ1CTQktYzyD8Edoh6aznlEboqbzIzq3kcIGyLHM9k
 +8lnZwrpb/N5NWo1AbOBoz7Jj7O4xfosvjl9JG9dyS4vS2o3Eqh6Zzhh3OfwURNtiCZe
 Bs1NdlG9S1TrMgXmtmQNcULlakmtwiCwRnjPzY6dS3lbRVsd6Vu06WMpzYGqkh15W/+v
 K9qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfnPDy2ugXfYDZsHmdOZ1LDEZW5c23HdTwQuFiWplKbsBD2+Eit2aWReIU2ij28ZQ4JvcNNWA=@lists.denx.de
X-Gm-Message-State: AOJu0YyZfiUHGgLbUaOAQCUY/nwcgGvg+QNV885xgW/vBEk+ebpMgHps
 tlI7OhHm0pOBzwkzk9MXHN+SRmA/RPqG4rC/ZSw+ixiH7ZXwRV3sY8lNraBdBA==
X-Gm-Gg: AZuq6aI11xLerQ8h83QXBFBsVKv7PSdCiOQoyy599W5zTMFVB7hiUOHBsTfhomOo+wk
 tSK2Cr2XTjO33xFFOE5mrEfM4Ei8zhSxZ35QSY6pZEUUQQMfuevLa91vkHjfoAb0iw12V3BxDX+
 hV7t+QOy6XAQVD8snJPfUn1YTT9bdLTYPhh668QTOrR63ecORW3KLf/0aLbbAWrBJNSm8RyMp7V
 HXx8kV2B0Y0P7zOmsEf50Tp7fqUCdWKetEgvJjlVPwfXNmUZggYULUEr2xIA5fX9PLXtsTl5qr7
 8jBeObmzOFgSNGa1VIc+ldTdd+Xn9VhRuX/HQLEp1oR1XMcR6ozyeZT5JMcYWD9rWd/HBTofZVn
 KnYDmoq9UOqfedcFgwDk69n0+jxZLtgxSNVEZUvWeDGsnA9GxFGrA+FgpWu9Aj8AmPSfL/By+sD
 NpESHWn5+6HACxd1Dr3olOVVGGtnO8+UPmf6f9JzHp+DYA1EQ6HKz7QhMNvvbjKjJvcNhRSVDSQ
 2W4VBiS0zDFg8rWOus06es=
X-Received: by 2002:a05:6000:26c7:b0:435:9691:d525 with SMTP id
 ffacd0b85a97d-435dd02bd66mr1626292f8f.13.1769508882166; 
 Tue, 27 Jan 2026 02:14:42 -0800 (PST)
Received: from ernest.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c0179bsm36744525f8f.1.2026.01.27.02.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 02:14:41 -0800 (PST)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH v1 0/2] toradex: aquila-am69: fix SPL USB DFU,
 drop obsolete clock
Date: Tue, 27 Jan 2026 11:14:10 +0100
Message-ID: <20260127101413.2812815-1-ernestvanhoecke@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Jan 2026 14:54:50 +0100
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

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

This is a small, board-specific series for Aquila AM69.

Patch 1 fixes intermittent SPL USB DFU gadget enumeration.
Patch 2 drops a stale MCU_CLKOUT0 enable for ETH_1. V1.1 hardware uses
an external 25 MHz crystal, and support for earlier revisions was
already removed from the DT before upstreaming.

Ernest Van Hoecke (2):
  arm: dts: k3-am69-aquila: Fix SPL USB DFU gadget failures
  board: toradex: aquila-am69: Remove ETH_1 MCU_CLKOUT0

 arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi | 1 +
 board/toradex/aquila-am69/aquila-am69.c     | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

-- 
2.43.0

