Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A96AE65D0B
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 00:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C86C6894AE;
	Fri, 22 Nov 2024 01:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EyxFdctJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89077896EC; Fri, 22 Nov 2024 01:31:23 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 523F4896F8
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 01:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21116b187c4so12442745ad.3
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732235480; x=1732840280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXy2r/cThp7W/2+s9DSFua1zwg2NRNhm0gAYwffKJHM=;
 b=EyxFdctJ6OooMZEyqZc4rC5wu805sLl1IIN8/VDouSJ6uFZRgPRiOmQarEsILHGESW
 jZAE5CZ9aJuLZamrLoMzlJF56FMOP71b+hNVOvnTG799QqNALCkEgLb0FkUsUtwEq6WF
 XTKpqnd0tS9Sx1zoQhjJspqdYC1/KyrtRNlTegB6lgYdOtcpQH6GeuksRhXpnyw3ZNOY
 slwKiu5Bb9GZfdnD3gxCOzWI0YwDZwepW7n57HRwxnTLTxn43HmDhcvDL9C74hAXOeLK
 aHAe1p7IvjanfpraTT5aMw8qU6gNPqUY11kz1fuYgYAjtelhdtRoAV5Uvf4RILKLQJD2
 ZXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732235480; x=1732840280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXy2r/cThp7W/2+s9DSFua1zwg2NRNhm0gAYwffKJHM=;
 b=k1XcGjoluh5RbcmM8+jJ3CT4LEAKF+n58mx8nOcsr4g/TOGwKwSyLwD1kwU09OWQWF
 OZBOzlVLTE6dv5rgodBch1UhpF4smuIHX48unhIp0dRvkbCfZBQE0t98GNVsuN2ds7JK
 eF4dn7AvpmtYNxoCovrTlHTgRDxPAj8hK+9nTH+RrRH43T+VZuhX6UCBaLeJWT58NWcy
 bq/kBSRYEBN3z14fpb2CB1dptBLPLzemCA/hFLUs24xijd72y+a5ZAPNE9wCyzIh9WO8
 zCyFyiZP67dfwP7ZmT3f2akylBgJS2Cc5QUStyl5BRmfDji2pbdg4OgWPsPlAm1JEnbU
 UNvA==
X-Gm-Message-State: AOJu0YyyYvu1jjomVgkxGuokBLJNFAG6Y6uu07bEDgY6Stu46zD5rKzB
 TW8GTAIJMgX7Bnu6WQkCNGOlNjd7AFo/S0HU7zK7DIZdjad3ZtKyi8K3wQFQ
X-Gm-Gg: ASbGncuo9e0Y/J3agsH5r7ctUm5znt5ToWxDAEj3R+V1SeQQfYbkoCKh0bxsmR8U9AP
 2nYfznVoA/HpYXOvotDIkfSV8Vr7BcmxVtb/jkPrv5Ekrnd1UkBjE2I5QEOiZas6doszBMkL/x/
 +4KulsiBLGLMOYuwRt70pbX6M38e2lw++Db+MLTL6TQ8Vl8Jbign3kfWQ4zX2tqcQUgEMtOSY6y
 FR2FDskm7v/jEMskQ31iXX9tOonT5yXvLlOHB664LVxXdg54ZZs1NhI2fAcFMlO
X-Google-Smtp-Source: AGHT+IFNMijvzHpe1uHJUnFAuMp7ueLOhychfefM/ft++ZJ3tODIWTiMrMES4huSEEJd7ZQDG1X2wA==
X-Received: by 2002:a17:902:e54c:b0:211:e4c4:a565 with SMTP id
 d9443c01a7336-2129f2208bemr13939855ad.7.1732235479695; 
 Thu, 21 Nov 2024 16:31:19 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:db1b:7332:ce96:46a7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc225d5sm4181075ad.258.2024.11.21.16.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 16:31:19 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/7] arm: mvebu: x240: Don't build mkeficapsule
Date: Fri, 22 Nov 2024 13:30:17 +1300
Message-ID: <20241122003058.270163-4-judge.packham@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122003058.270163-1-judge.packham@gmail.com>
References: <20241122003058.270163-1-judge.packham@gmail.com>
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

The x240 board doesn't use EFI and our toolchains don't include gnutls
so disable the tool in the defconfig.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 configs/x240_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/x240_defconfig b/configs/x240_defconfig
index 4fca1096e740..5e5b467b7bac 100644
--- a/configs/x240_defconfig
+++ b/configs/x240_defconfig
@@ -77,3 +77,4 @@ CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
 # CONFIG_FAT_WRITE is not set
 # CONFIG_SMBIOS is not set
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.47.0

