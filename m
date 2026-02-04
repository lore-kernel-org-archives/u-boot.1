Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F584E9D407
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 16:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D4583A64;
	Wed,  4 Feb 2026 17:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HeFjoZv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE0E483015; Wed,  4 Feb 2026 17:11:22 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 886EA80086
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 17:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-34c708702dfso3877831a91.1
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 08:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770221479; x=1770826279; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KYgosmtEABEMRCWrCyqXsb2qxnQxNCUza6JgzWEDlV0=;
 b=HeFjoZv3op7sdJLwUBXqq/6qiZpY2mGsPIuwOmfPcOsvgGxlEYfbc6uc/FdjUGmY88
 +2WHuz9ZuMWT3ea0v5Vn2kpZ37/vGKbzOKoYN4WOrjy+B4LCHLFYOjLTboyO/4HynQZ9
 /IuaOYpMOMdIzLrh/znfMZN3xDqYbP+9irKjT8z54Pll+K2zv7QPdrBTFvYI9mrZftOE
 yIJJ0RfDkiSWx8KaHxo1T56aAOTgHzD+89YZyu5vYdVAcIVWgm0A3BWw/uTz3MSY6wSU
 xfusuS0G3f5WDnFqty2VRPa0sI+6hPkyn4l9kUpH3a2SrWoCB+2lXEyCD4Dvckz+g1k5
 mEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770221479; x=1770826279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KYgosmtEABEMRCWrCyqXsb2qxnQxNCUza6JgzWEDlV0=;
 b=LQuufy2oRUDW59HDJFycNHea0glQ00IIp5qFqWoS3vKDW+C1nznItlQckUAFkub4+P
 j+5reEXkTmAZAB578q4MCX8ruhgt8z+s+W4KW6XUb3v0ZrxJ6zQD+IXZ2ovFj1cm8jQf
 9TNd226uabRvf+3gqitZiEjXzee6EHKSquCpWQsGwysMAvZiaVgL2tdhgGtvy0q+gHIP
 C7nvvfI7XCQHyi8sjnzfnbHCW10EVO/CsMV8nwxnzLabJ+64Fh5UGkVWWc4jxLvKIqfb
 qPexiC7DbXkGojYsLJgLFU2n1I5mSZmmaPc7XzI0DE9stKKljcrrwr642tLEd5TJdN4x
 vomw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsvKcQziNy0Dl2JdmGRobsPd5WBNp1wjRI+ZK4SJoem3fjbNjiwM8r0o4ECqVlSjsYEZtx0L8=@lists.denx.de
X-Gm-Message-State: AOJu0YxBMVpo8WhJjDIxYFy/9D9i4OMxftEb6Rfb9lVopH3hgDsXop0T
 dT6yIn0EsGZCQXl3kdjluJ4aAwIB4KDz7B+5D4VLvFkGD1AVAMtdaK2u
X-Gm-Gg: AZuq6aKV30wELiUrO5oHGi8Ww2/khzRdzvvboKL4wFfiwDRa1fF49akcOUxCuA/yLGr
 rEOrP0E4uxhROx7hQQG7ZywMO148vVadaCNyHZGrm/W5dDw0s2pM/U/TTXmVZ7sTe4GrOmO89Jb
 E89Mx3o+m/WB8NQqKJGnBaS0p17d/0mg6+YOIOZPt+cyZXWWeLX++0kqZ0iLBWbJmxzW05IUPVs
 Togz3bAV2qPqEs2AY51VIj4/2u52fOp2Qwme8aEkTQRccyqMVtnK657TTgRHz96CVMY+FwMEFTl
 uuaq+KBFPtS/B25fd2lQDgGEnejc1MeyGE/4fhdpxSMBvCJbMvbamnk79J7YG4ABM9pxXGws+nj
 HKMPgCFYFMC3kswQ97xEbRILa2h0ar4L/dESINgAru6zFRTLdHK/BgjtcodC8KETI1iRFaD9A+u
 q/KTw0AWJ9VemWf9ED
X-Received: by 2002:a17:90b:1d8f:b0:353:5c16:aa7 with SMTP id
 98e67ed59e1d1-354871ba033mr2963463a91.25.1770221479016; 
 Wed, 04 Feb 2026 08:11:19 -0800 (PST)
Received: from [192.168.0.103] ([43.226.31.128])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35485efa3d5sm2968364a91.17.2026.02.04.08.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 08:11:18 -0800 (PST)
From: Biswapriyo Nath <nathbappai@gmail.com>
Date: Wed, 04 Feb 2026 16:10:53 +0000
Subject: [PATCH RFC 2/3] qcom_defconfig: Enable SM6125 clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-sm6125-clk-pinctrl-v1-2-9cf4c556557a@gmail.com>
References: <20260204-sm6125-clk-pinctrl-v1-0-9cf4c556557a@gmail.com>
In-Reply-To: <20260204-sm6125-clk-pinctrl-v1-0-9cf4c556557a@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Bryan Brattlof <bb@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770221464; l=607;
 i=nathbappai@gmail.com; s=20260118; h=from:subject:message-id;
 bh=Dy5QRVU9t3KikUnGdtxetG0lSHBM1fhPm/CCtK8QD8M=;
 b=t9/zk9hxYfSJL1JMVoVyOX0SgdPIjXd3CaTIIZaWdmx2YI9luMZtnWtXTdh29jkQald8kjNYJ
 qruL9hDKoZ3B/3LnmZTzOyT2x3AB7WHK+WWH8joavhXhO0rV0JLB9UC
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=slmb/9yXbet+KTiT3EYLCp0p0MEOYa3EdjUXP+HXfjg=
X-Mailman-Approved-At: Wed, 04 Feb 2026 17:11:52 +0100
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

Enable the driver so that SM6125 devices can boot with qcom_defconfig.

Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index fe5880de1..fc21aa5fd 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -63,6 +63,7 @@ CONFIG_CLK_QCOM_QCS8300=y
 CONFIG_CLK_QCOM_SA8775P=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
+CONFIG_CLK_QCOM_SM6125=y
 CONFIG_CLK_QCOM_SM6350=y
 CONFIG_CLK_QCOM_SM7150=y
 CONFIG_CLK_QCOM_SM8150=y

-- 
2.53.0

