Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ADFC54E49
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 02:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F38DD87FA4;
	Tue,  5 Mar 2024 03:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="knYxwTY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1691287FB1; Tue,  5 Mar 2024 03:11:33 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9C5887E4F
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 03:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=twoerner@gmail.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-42efdd24302so911721cf.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 18:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709604687; x=1710209487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5WIZJ13QKaB257SqcfBqN1MWTgFTwSIgHOaHY4VpQj8=;
 b=knYxwTY24oDSlmXBoaJU0GGqKCTt1Qlfq1PoAnw+9FXkw5eORNaxMQHFrt1f5dgC5P
 Q2RMrnpeCr+X63VYoVaXaZQ+ht1U5hP0JJfoNnxthCKIvH0o6GQO3obdv1gAtBEstVg+
 9skxFzpfrSUNkD21bbYTAESzZZEOqrPxOu6dS2jAnN0ELhHcFBe6RKX5TwVTUjEyY/Ju
 xyqFNJ9WzkU5C8VhMXU7QcLZr+85g3vcSZuGKA3OQ2kI0wqLPd1Apemst7KX3MH0INKh
 xm08rgeVjVi8aLuc2M/QKkpRDQRk+Rjx1z8xyzrsaJfnB5cnLh8rn0iKeNxtyJm92ZvN
 6M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709604687; x=1710209487;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5WIZJ13QKaB257SqcfBqN1MWTgFTwSIgHOaHY4VpQj8=;
 b=en3iNsJ4VIT3I2F+ZysmnRFs22RI8rRvWgagNuhNEGs6om6XFbvq6A/jymuaQXGhUV
 dflvh4VL7K45/875WIFQi30/eG8LgJ9q99tOfC7NXBo7Zgo24m8bTm2Fes2V25+ebnjf
 u5zCU+RmTyVO+vlbywfQGvYp9Q2kVQvR2DYd+DeRZoIjMQpGeSsK8OqcZ4W+1K+Ry4Mo
 TN2556C5z/KqcLJBFGQoYxfqSRPQltOz2MdZDvws/Cmv0DQemRhjcsLMNyX0cPsTYFag
 BYdZVH1YAuJdbYAbXDIKUChXRNDXkWXWdyIPz01mv0DlElfxMvj8Efp37Xj2/ZuAelG2
 v34Q==
X-Gm-Message-State: AOJu0YzrBAlB98POJUqVPax9DNxkcnoHFzjkPONmfeMC49U+ELo9bjFc
 EhOyMdwBUo8ldGceNQPZ+p4Ik+FteuOYnvGJW2y/r8npIfrbe3y4BLN/w0PgUD4=
X-Google-Smtp-Source: AGHT+IEczRuVRyYxBbz9DCZHOSEMTsEFXgOCTndTh1918KgiprHyw0p38Xx+zUfE6deVYpTv/AnpZQ==
X-Received: by 2002:ac8:5bc3:0:b0:42e:cf0d:c9e7 with SMTP id
 b3-20020ac85bc3000000b0042ecf0dc9e7mr647572qtb.44.1709604687261; 
 Mon, 04 Mar 2024 18:11:27 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca.
 [209.91.167.254]) by smtp.gmail.com with ESMTPSA id
 i19-20020ac860d3000000b0042ef122e15asm1558534qtm.12.2024.03.04.18.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 18:11:26 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Akash Gajjar <gajjar04akash@gmail.com>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Simon Glass <sjg@chromium.org>, Pegorer Massimo <Massimo.Pegorer@vimar.com>
Subject: [PATCH] configs: rockchip: rock-pi-s: enable environment
Date: Mon,  4 Mar 2024 21:10:43 -0500
Message-ID: <20240305021051.22405-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.43.0.76.g1a87c842ece3
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

Following the pattern of other Rockchip devices, enable the U-Boot environment
to be stored in MMC. This patch specifically assumes the environment will be
stored on the SDcard.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 configs/rock-pi-s-rk3308_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index 9908a4b4f457..af2cddcc2553 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -54,7 +54,9 @@ CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
-- 
2.43.0.76.g1a87c842ece3

