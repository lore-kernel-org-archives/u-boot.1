Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891B4C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 10:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D99187F19;
	Wed, 13 Mar 2024 11:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OLQPzkNq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 992A687B82; Wed, 13 Mar 2024 11:27:38 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A4687D9D
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 11:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ppighouse@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ddcec424a6so3757395ad.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 03:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710325652; x=1710930452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R6I+qAvjriIhZpqTRPosft+26w34QnmoHMX0+mS+KQ4=;
 b=OLQPzkNqGsdCE6+opKueB4niriNNBpgA/XthGitq1rF0osVp3gYgNV8a0bnmnlX71x
 UTTt6IVpptK/I6Q4VuULvL4C0VonCO/hI9hGrXciz6B47sySw6vGW6eNJSaJ/+qvIMuI
 YsV5RZsn4RvcJDHgsPsBxjbIQcg3CHvMXUTBB/Z8Y1eNg3p/0XeLq2GT0LA/YtIWR4GH
 Xyombd2D1wbAHe0Io1ycjq2vLtW3V4HqKRumodelS+3ispPiBwSgsv+ksETJtI43cgAY
 QHW3qPrvn2LuYuca2hwkhKSHwC9dr4Uo0sjBB0tieKkdmjtOyf45q6z57lqHi7HDala+
 8xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710325652; x=1710930452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R6I+qAvjriIhZpqTRPosft+26w34QnmoHMX0+mS+KQ4=;
 b=ouEvYrzcY1WgVn2GzaFQEbONi+DwNNNOxfHb5WZ/OKyHTp8Fn4epHGTZuRN2k8zHvm
 uyXKVL71xEZEzM2xjkeyMX26IudfDqaHflBtLUa722dsQG2LC44lXHO6ZO8fqm9LohpA
 LRwhoqC7cXnTesZ2W0YhX5ZaGMBHAUl7LxRCR+rxownuT6aVQoSDHM9fE3l7K2ntdbS7
 Q3R0uQBsqxB3od6fo8tSOBXE6yQm3Qh+a5c79dNLKWGOW5J7rcaRVAgFpn7EGQfxSPf5
 9YvigqnOEyGSFUN05oQYgVaHM/puGOaqPVsh5KDaUkJgDplb9yQ6iCoZQv9p8KBvSJ1H
 y9yw==
X-Gm-Message-State: AOJu0YzX6J56ksYtPw+N0mytEHBPZKg1QIj9Oauo4r8r8x+zd8lGgoVY
 DYhKhwtSI5P7imTfKXDWHKMiNIMyISrqgRiMW9O+ofMzeMVTDw+26ynLA+EXMEg=
X-Google-Smtp-Source: AGHT+IFz/PcYK+7iAlI0rAb2eLk4kxpGfZxHON8x8DkcBYjeQWhhbtobZ6sqWsCvPLDvSd+2NEsXoA==
X-Received: by 2002:a17:902:e54c:b0:1dd:2b9b:8898 with SMTP id
 n12-20020a170902e54c00b001dd2b9b8898mr14437697plf.14.1710325651983; 
 Wed, 13 Mar 2024 03:27:31 -0700 (PDT)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net.
 [125.229.150.10]) by smtp.gmail.com with ESMTPSA id
 jz3-20020a170903430300b001db63cfe07dsm8249282plb.283.2024.03.13.03.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 03:27:31 -0700 (PDT)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, kever.yang@rock-chips.com, michal.simek@amd.com,
 marex@denx.de, neil.armstrong@linaro.org, jonas@kwiboo.se,
 cnsztl@gmail.com, clamor95@gmail.com, hai.pham.ud@renesas.com,
 naoki@radxa.com, patrick.delaunay@foss.st.com, christianshewitt@gmail.com,
 openbmc@lists.ozlabs.org, kelly_hung@asus.com, Allenyy_Hsu@asus.com,
 Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH next v1 0/1] Add new bmc dts for ASUS X4TF server
Date: Wed, 13 Mar 2024 18:27:24 +0800
Message-Id: <20240313102725.2067651-1-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 Mar 2024 11:56:10 +0100
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

Add bmc dts to ASUS X4TF server, we also submitted dts to linux place.
Please refer to here, https://lore.kernel.org/lkml/?q=x4tf.

Kelly Hung (1):
  arm: dts: ast2600-x4tf: Add new dts for ASUS X4TF

 arch/arm/dts/Makefile         |   4 +-
 arch/arm/dts/ast2600-x4tf.dts | 161 ++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/ast2600-x4tf.dts

-- 
2.25.1

