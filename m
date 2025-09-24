Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD6FCAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 15:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4062E83631;
	Wed, 24 Sep 2025 17:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="LrhajL0N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCBE580107; Wed, 24 Sep 2025 13:31:35 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF8F8833ED
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 13:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b3164978f11so238364566b.3
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 04:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758713488; x=1759318288; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2qhq8t5kUdq0wm6f86bhcitDAwpCrtkxQfSBX/sfgWY=;
 b=LrhajL0NbPtH4KgkDTC8TVDZQbnoEDqCefb3sjY/NQT/RsI/Fb51VywzWaJogkJHES
 ojh+ENao+k4wagJMOsjT4cNlmd+24mEFTzAs4i+nJpAQVfmkSJeWmJNxpFKyNk7P6M6I
 HvuALvGNb0eBxNGabm6wDQuh3wvxea3go36xE68FGRNW01IJCTYsyaXycE/A/xuvsj8+
 MFoKe2U3s55z3Dv1cZDXvoInooXfITND++u8bJzXw57q8+pjFPw0VZWuLyJBRnrrym+Q
 3wmeeSRoxF/VFXnP6CDfK4e/xjEWqOqHzr/R7VYQG2ttYwoR1fhOJRArZ/U3XEU+Vw5L
 GL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758713488; x=1759318288;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2qhq8t5kUdq0wm6f86bhcitDAwpCrtkxQfSBX/sfgWY=;
 b=TazMCxNgXbMPfl7+9IlVRZ4bRa1g9ydN3M3CVFLwvuTTvyhnqI6GgOCe1xFJW/45bi
 zA8lgFbNcu9MGMpoJ5oRhJrHewWmc2ZuEl2rzb8IQPE7ztJ5O++pgGaHebqAG2u32lAN
 UCY5iExN++JyAjtcpAd+JLfsqXmuvP4CYeErQF0dsPmEx1TxfldJgg8/XmdMWhxgqO3C
 LqQw1DAYfmY6GqeAEAwZ3tSMbpPia6yfjee2TU/hEFMtm8tgXpD5/z7apKN6WAKI0SUD
 wINC2sOfh6iseZlHXYHJVR7TmZC03r4o0eHQzVdP4lNH98nm7BjF7dGl8UlHHG7D8NDz
 ycbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqBxbPpTUN1OhqCufn8AZz4FfFkhXTmiu9J09UeUXJxTVynAJjUbXyQzM85qFZ6XnMH35OpCU=@lists.denx.de
X-Gm-Message-State: AOJu0YxQX1NHfp+FvED/rmU4HydDOMQk5kcqiShbnGPBvLT0RubgGIHk
 Kr9fOSzfPOcptukNUXV+GWMYMspMQAEAk9Sg+16gwmfR0OfidN//KjgU+Jve97s8RhE=
X-Gm-Gg: ASbGncs/st6bFx7JHw1HoGNmcFrV/WvRCYonptvXMWt4Iw8dX3SYJ/xswgtjWUF6sb5
 324ewDplHI3bIJn2B6fplD8ZvMBUe++4ruKIVvXC5rh0XRvL/i+PkgpeP2AWGfzfN2mA8/S2fQm
 GM0cO5G6HBC5XoEQuDkmklmLTl8zfM4l97qg50mh4kedoE3olNj0EFT7rleNbmVOGl3Cc+BuaIH
 p4X8b60jSzE1geeeLOX7Dj3JVZX3mr8mqQ/5GHXzi7CeQclpVHW/u9MdFa7c3UCdOx1hTVzbfO6
 q8hEWjC0+a0YB+27S1GDbwIUcW1oYYSJVbKI7gKYhJCv7WyXbpQIoWW3illS3Cac5Ood41X3pSG
 43PLhZkUk1IV2+NYCsHPHZUO5c17NjxuK2CuNhH9M+qoayQvnq/q6f9Uyun04tTUhP7GBsA==
X-Google-Smtp-Source: AGHT+IELy5wFdPubBYeS/6rI9SUAddJmL0uAUTRIpdF4NgSib0x4AFdyoZvnGjVDMQx76QI1y8EOpg==
X-Received: by 2002:a17:907:3d12:b0:b04:25e6:2ddc with SMTP id
 a640c23a62f3a-b30264adbbbmr550418166b.8.1758713488373; 
 Wed, 24 Sep 2025 04:31:28 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3339789812sm96698266b.17.2025.09.24.04.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 04:31:28 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 24 Sep 2025 13:30:11 +0200
Subject: [PATCH 5/5] board/qualcomm: add debug config fragment for MSM8953
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-2025-10-misc-v1-5-7e75842ca714@fairphone.com>
References: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
In-Reply-To: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758713484; l=637;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=yjFCnxn7w2qBf5fk1VA544PPLA46Bi4Z58kGZnicZzA=;
 b=+K/xsPKiriUiG6+ml2dbR8UpHGfsea0vphzQ5dqPJrEH2UFFbNE7gfVWL/HhzRdCtcqw80h16
 Cd13XTZt8alCmqEQayDmsFZOcj/1QFv0gYwIIId/mccrbOfUz2GT1nL
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 24 Sep 2025 17:25:44 +0200
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

Add a fragment similar to others to enable earlycon.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 board/qualcomm/debug-msm8953.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/qualcomm/debug-msm8953.config b/board/qualcomm/debug-msm8953.config
new file mode 100644
index 0000000000000000000000000000000000000000..1ccd70d0d3f4209ad1dc323d59f9d4ba581dcb91
--- /dev/null
+++ b/board/qualcomm/debug-msm8953.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x78af000
+CONFIG_DEBUG_UART_MSM=y
+CONFIG_DEBUG_UART_CLOCK=7372800

-- 
2.51.0

