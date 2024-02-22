Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0D8C54788
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 15:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D8FA880B7;
	Thu, 22 Feb 2024 16:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="0knYx0v8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8552F87C56; Thu, 22 Feb 2024 16:21:43 +0100 (CET)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B91C879FE
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 16:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3fmbXZQYKBt0A9QM9RFNNFKD.BNLT-ANNSKHRSR.CDMW.CD@flex--barnas.bounces.google.com
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-608852fc324so33152387b3.2
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 07:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708615295; x=1709220095; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=tVuWNUWAtuREb+XecFFPGUP4A/T9jN4i08eg1zjGT1o=;
 b=0knYx0v8OR9RhasuWvlJ5xO9YdVFjvKby+UjTLBaIkFhozhlY3UWMYvpPufSIT+thT
 bLBnnTaIK7Ve3lm4sC7C9WhMn336hS2SeG7gXvGXfXHVriJNcEbUWpvjNpbK98Gh49zh
 7ct3ml8ZZI+XF7ep02dOG+CJgzlFB4t0hr+BEMPrutvCLvFQmL/9rglmaNAaMZb0sPCU
 NMENeRtbiw1GQiOdwA1sgFxkN9J1EBwakiMFC+vsoQp2uwCd9e/Est7EDn6looSiAJhO
 kVAm0QilUjgtCYsWIbvbEYvuP2T77Mn0XSAIaWgtgh2u1qbwEliE9tOuzWxok7U3xk0M
 8llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708615295; x=1709220095;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tVuWNUWAtuREb+XecFFPGUP4A/T9jN4i08eg1zjGT1o=;
 b=I7W9W9LljoKa+T+5Cf3Em8yKDBCjvUrfq2bAgLAzXbLJZBez547OeDU4ts7y95vTs2
 +jd6gW5+LFmzCvUtrZ1a+nzxnImZ3j2TlfQ0fYgzu51+20zDa6nzJYifqd2qyS2S0YvK
 v+sywaQRleN56rBd27OQFV2e3VSwuiY0qwJgy/GyFzRIiNsIoGOASvuEFzRicXKdj7Wc
 gy8G9wkfLfa0i+TY28t6tCvmIRYZA7knIESfpfaq5T4dH4jTc1VT6sjauDqXod0mTB8K
 JD6kBblRGGmPLdJnZrgssRZf6ToXx69a4Jb3AZQA2iBWxJQ0u0te7/107bvBMxqzC1e6
 +CuQ==
X-Gm-Message-State: AOJu0YxvoHGGyZRHER+4vIufAP3mZofzTYgGtJ4p6IlNUypk8zMDw2h+
 MdB8+FF1/tFFi8waCJ3cJjDPjt9jn6NIVoZM08O9gGpR8SQIj01+7Cg9ViAmD4Rq8CzCQ4N8E42
 X4wVfkwt6jC+ig9S6jGjCEez+OlLtG5jUcgUcynGb1I2m9gfAFlwzjd4PStRgfo7oWY8s67yotE
 ZQlDMCFn2nVuKp53WqxfRkvYEEppuddg==
X-Google-Smtp-Source: AGHT+IERl82hc+caVfC0y+M+D5PJa+v9mSwPijkoDQNO3WLq3a7+2SqIcTw0JLG5c3UdDW2qIL5VkCqL33M=
X-Received: from zombine.c.googlers.com
 ([fda3:e722:ac3:cc00:68:949d:c0a8:7f3e])
 (user=barnas job=sendgmr) by 2002:a05:6902:150c:b0:dc6:e1ed:bd1a with SMTP id
 q12-20020a056902150c00b00dc6e1edbd1amr687711ybu.2.1708615294984; Thu, 22 Feb
 2024 07:21:34 -0800 (PST)
Date: Thu, 22 Feb 2024 15:20:57 +0000
In-Reply-To: <20240222152102.1677445-1-barnas@google.com>
Mime-Version: 1.0
References: <20240222152102.1677445-1-barnas@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222152102.1677445-3-barnas@google.com>
Subject: [PATCH 2/2] chameleonv3: set in defconfig for FPGA to reprogram every
 reboot
From: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>
To: u-boot@lists.denx.de
Cc: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <pan@semihalf.com>,
 Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 22 Feb 2024 16:23:55 +0100
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

Set CONFIG_TARGET_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM as enabled in
chameleon v3 board's defconfig.

Signed-off-by: Micha=C5=82 Barna=C5=9B <barnas@google.com>
---

 configs/socfpga_chameleonv3_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_chameleonv3_defconfig b/configs/socfpga_chamel=
eonv3_defconfig
index 6ea61ca6ea..25615bb4b4 100644
--- a/configs/socfpga_chameleonv3_defconfig
+++ b/configs/socfpga_chameleonv3_defconfig
@@ -7,6 +7,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_arria10_chameleonv3_4=
80_2"
 CONFIG_SPL_TEXT_BASE=3D0xFFE00000
 CONFIG_SPL_DRIVERS_MISC=3Dy
 CONFIG_TARGET_SOCFPGA_CHAMELEONV3=3Dy
+CONFIG_TARGET_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM=3Dy
 CONFIG_SPL_FS_FAT=3Dy
 CONFIG_FIT=3Dy
 CONFIG_SPL_FIT=3Dy
--=20
2.44.0.rc1.240.g4c46232300-goog

