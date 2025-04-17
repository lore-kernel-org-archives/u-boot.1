Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14D5C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 17:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27397830B3;
	Thu, 17 Apr 2025 19:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iPiuM4SV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA71E8309D; Thu, 17 Apr 2025 19:06:44 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 880458300B
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 19:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-60288fd4169so489699eaf.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744909601; x=1745514401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AlzOWLJ2G/RGzyd0kDFxFyDq1wDY0dPwQmbxkDa21VU=;
 b=iPiuM4SVBDWNzaE4xmsHcgOXUiWGFB5lpDzDb2r1yQ+nxvoOwfusOogCDVICUeMce8
 ZpK83cFcMDLvk6yFscvntjIHpjWoSPG3hjdlAOZ/a+mDV0BnKUVPAs2FgwA8eamNNW38
 Lank/WVfJMKt+z6+AABTv3+UVms5yrYpG21BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744909601; x=1745514401;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlzOWLJ2G/RGzyd0kDFxFyDq1wDY0dPwQmbxkDa21VU=;
 b=mBSFa2YoJA1mnzA8eBxeKBTm2SPmCnJsCyq8WyJuiHdPLbnNoQ64bAVyF3WjluuWQT
 N+vdwj3dkHmiRDFGiRBcUa6GUHtIyfyWaTXn1uLfw8Jh5CSX5pWJTlV1T3BljTjxqyhF
 UJzuLZ9BA9InAarIKU7apGwyBeJrpjA7If8EqKZwf/sooLIMVZL4GxVDHLhaWpuGOdVV
 oYd22rSVdnKNFWXlKkuErJQA8xWK2+CiIVsE6w7s93IaxlKLrnxf0ayhQ5+LdznTZ0SD
 qwqqTCED6P47C0rEopQp/w3i/vvm045g2/rWIdl6wWGyM5UYTuHC/fMQ/FZVwJ/0K4zs
 iStw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFZmbYDqj5v0aR6Jj3cWky0XpyVvFG3Mh76k99ls/g6B2Vtzg+6PYQAcmfc73rfqPFMMp3bSs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/m4QFaQFxAtUpKDp6D1pt7PQMfBMRSAXL3FgTVcog+G6hXbmo
 k1JgBoNU/RIqrxFktLqQ0mjWUqd/X9oVACKup76vSXr7fmJ/Ki/sz5Uvp22nC7M=
X-Gm-Gg: ASbGnctc3N587j9ME+xxJhGxKCi6jo/DO340IkuMTSlHiq8E72iWf3AUnYmIQfuWISz
 5iyBSuqdYsfh5rbZWjdOhm+L50+LUFaLXTjLCAgXzbLktmPjbBfU1/au9Yj2U68Tyby993+WfVh
 hNfW+x0uBiF3XBt72drYGipg+nXM6kXMmlg+V144V0YBfRx5EsplMYaC3BpI0pvKTB93RnI7zIj
 h1m9pWnOgiZABdkyvMqsOGQmbFQYpd3xRv4w7LER+kkywE4VMkBXZ8V7K07Urt/UAUm1gaYwsy4
 LME9GYu9EZNRRcvlTzM7nFoyK7XXjLJY9tMF/rQ/aPomfb1a+uxF3zZSvwIp3eWH1AdEN/wyydh
 J
X-Google-Smtp-Source: AGHT+IGN80EuaiLG9Lbfht2PtoaWoOfDvQYSpfiP6ktI3bvRHQtgDQBoB0V5oArcmphnkQ6caMQorA==
X-Received: by 2002:a05:6820:134f:b0:604:ae66:1e86 with SMTP id
 006d021491bc7-605ffaec9fdmr116962eaf.0.1744909601296; 
 Thu, 17 Apr 2025 10:06:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff6aacf5sm28411eaf.39.2025.04.17.10.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 10:06:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Bruce Suen <bruce_suen@163.com>, u-boot@lists.denx.de, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250407200208.25594-1-ansuelsmth@gmail.com>
References: <20250407200208.25594-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 00/14] airoha: add support spi/mmc/ethernet
Message-Id: <174490959978.2996754.300244773077884640.b4-ty@konsulko.com>
Date: Thu, 17 Apr 2025 11:06:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 07 Apr 2025 22:01:44 +0200, Christian Marangi wrote:

> This is continuation of the initial patchset for airoha
> support.
> 
> Some are trivial fix for spi.
> A new concept to setup SPI from detected NAND.
> 
> Sadly DTS node still need to be merged upstream so we
> are currently adding them to u-boot dtsi and it's planned
> to be dropped once they are accepted in upstream kernel.
> 
> [...]

Applied to u-boot/master, thanks!

[01/14] arch: arm: dts: an7581: add Chip SCU node
        commit: 60cbbbb11250743856a89bb8d1c743d859c650de
[02/14] net: airoha: Add Airoha Ethernet driver
        commit: 74fcb6a7a7e9a89d27acd7e41b3223276b6be4a7
[03/14] airoha: Add Ethernet config to defconfig
        commit: c6b0544a9416c991b454e68f361efb47cec0770a
[04/14] arch: arm: dts: an7581: Add Ethernet nodes
        commit: 28891f1214fd32a2afd2151c3d95f4630650a454
[05/14] mmc: mediatek: permit to also build for Airoha arch
        commit: 8b4253a85a2bba1c939e0b3bc1dcbad575dfb20d
[06/14] arch: arm: dts: an7581: Add eMMC nodes
        commit: 132f80803e7ab85f11db5c6a7f5c464504e66a99
[07/14] airoha: Add eMMC config to defconfig
        commit: 92c8047f24d571a34f8159ee48211d1014797c9d
[08/14] regmap: Add regmap_set/clear_bits shorthands
        commit: 53e83caa870f45a8470dba85e9bd627f6b3d010d
[09/14] spi: drop unneeded spi.h header include from spinand.h
        commit: 225d1ec702b5092cc514932378e810e5e9e92bf7
[10/14] spi: Introduce setup_for_spinand()
        commit: ef45b9c395f92d9239d6c363b1f5a89f6a53f2e6
[11/14] spinand: call SPI setup_for_spinand if supported
        commit: 5ff602a3519b2efd9aa84b3bb364f782349e7fa2
[12/14] spi: airoha: Add Airoha SPI NAND driver
        commit: 6134e4efd432f1be74d48f46d2843bde8a8eb7f3
[13/14] arm: dts: an7581: Add SNAND node
        commit: 96ee9dd53afba2082f34f5db6b27051f4b0676d9
[14/14] configs: airoha: an7581_evb: Enable Airoha SNFI SPI config
        commit: d74728d8ed28fddc7ada266a9ece2cb858420cde
-- 
Tom


