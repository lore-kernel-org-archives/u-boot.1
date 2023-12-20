Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A668C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 10:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9991E87646;
	Wed, 20 Dec 2023 11:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hjdvivoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E7D5876E9; Wed, 20 Dec 2023 11:39:15 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F1F87646
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-54c77e0835bso6864898a12.2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 02:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703068750; x=1703673550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wC9he3ZG7my7Q3lf9JBdlFYK0XXrpye85w1EGDGBQmA=;
 b=hjdvivoHfRIw7IXr6di7vl+r6dOLAz2Hjc/yxq/SZza667VzMzTBIsXt7F2kovez1k
 beukwd0jX6cDd3PMZcfu++fq8jV30cqXY6MUgRDuzU1/tRlc51cEATlSBb+HsXjDzhJz
 T9QfZftKSlalmVOT66N0DRtzn2oocVbASj2n9iu6WJPysUmOc8MWLlrx42IMt/KeZ88G
 8P0Uipzlhzz1BtoOZLHOon6GvAzde0tfiCXOfqKnZ72rlAzHbfSub+9sUDWgjY4cUguw
 6lKBgAQ1D2sFD9cqWX17TfPl3TUSfDLVz+Pg8nbGpv4AZA9GknjZkYMPj0sVz3vLBbpK
 ZGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703068750; x=1703673550;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wC9he3ZG7my7Q3lf9JBdlFYK0XXrpye85w1EGDGBQmA=;
 b=t8X7L8Jg4pRzfYvm/V3u1Kyd9ysL4vIMkGHohKhbuOGyNcmSEoUQCQ2HzFTY5wzLTF
 a/0KfywDxob4pUIg6muGCsKv6oQfc685K3RMngVWOER0fOymTvdNvwKh+GV/Suj2K1ga
 u/IHcD/1c+usXchi2sK3S+YfoTPgpEprKGZoe1lTn3xdDSr4XqvzX0DkRMdZt3pSnGkO
 zUdmmK/6mPfHxdH7qIn0bVvmuxnxhkRoUXOv5rTGomtRctg+lNOxGzRBKf92gKymwwy4
 +4V0+L+iGMyQqwpfjbyPe6qUp+VgAEgRjvWeuQg6c4K67vbrVgWkRgENiDNOqvhzu+IJ
 Ishg==
X-Gm-Message-State: AOJu0YzagL1yuINyz9prymHTDi+vJeSbonpl9yfM0Ut/fMVKyBKTJ65s
 HqswJLlWMm7jvAPzdYH7kK7YEwDrgEGLTQ==
X-Google-Smtp-Source: AGHT+IFkL3iX8Z/+wnLeblNztfhEx4ES4yCQQ2BXSnt+1J5WSmqgg5H5cG1aGRRpwHX4Mo05zigwPg==
X-Received: by 2002:a50:9e29:0:b0:553:6c99:22 with SMTP id
 z38-20020a509e29000000b005536c990022mr2127885ede.2.1703068749892; 
 Wed, 20 Dec 2023 02:39:09 -0800 (PST)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch.
 [77.59.154.235]) by smtp.gmail.com with ESMTPSA id
 f19-20020a056402195300b005537b00132asm2259932edz.91.2023.12.20.02.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 02:39:09 -0800 (PST)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: u-boot@lists.denx.de,
	"NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 0/3] colibri-imx8x: configure module usb hub to bypass mode
Date: Wed, 20 Dec 2023 11:38:08 +0100
Message-Id: <20231220103811.228515-1-andrejs.cainikovs@gmail.com>
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

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

This series:
- Drops -u-boot.dtsi includes in apalis-imx8 and colibri-imx8x device
  trees. This file is included automatically since quite some time now.
- Configures Toradex Colibri iMX8X SoM USB hub to bypass mode,
  and brings out of the reset state.

Andrejs Cainikovs (3):
  apalis-imx8: remove -u-boot.dtsi include
  colibri-imx8x: remove -u-boot.dtsi include
  colibri-imx8x: configure usb hub to bypass mode

 arch/arm/dts/fsl-imx8qm-apalis.dts           |  1 -
 arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi | 15 +++++++++++++++
 arch/arm/dts/fsl-imx8qxp-colibri.dts         |  3 ---
 configs/colibri-imx8x_defconfig              |  1 +
 4 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.34.1

