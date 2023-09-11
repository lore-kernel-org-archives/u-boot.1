Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C27EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 15:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B3FF86E22;
	Mon, 11 Sep 2023 17:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ppQskmyC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD9EE86759; Mon, 11 Sep 2023 17:34:48 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D9686E4C
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 17:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jamipkettunen@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b962c226ceso76804301fa.3
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694446485; x=1695051285; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93UECTs9XzlamG9jijnsUBQ8iq0jj1aFUGDrvUpmlSI=;
 b=ppQskmyCz9lx75U1QEO+Hpd4dCS/OTvQRG9om922is7MK+sCL7fcqc4b7LDEops9Zq
 O2MhvL+eNtoZ0mPwsIgciHHmKl3yPgae86HvWhYfJkoRYr5tRo4pgeQD5DxLaSzTIDI2
 ZrC5u4H1Ij6BjW48UDcRdCVoccVWhxwCgtho5lODdQADyXUElzclASpmdfT5BcMSlWHx
 r9/WLYeecYZxZ4iIzR/Z06kFjVkGtQtTwlHyeZ6byGtpXi2drBHUgk/CpKAHii169uGE
 1E5gku8wdifmqrTrIvZdcHCfhaqYxZ2JtLO+c8L2SoTE8zrbgzsQWUG3iggKR+3XWhkz
 SgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694446485; x=1695051285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=93UECTs9XzlamG9jijnsUBQ8iq0jj1aFUGDrvUpmlSI=;
 b=SQ9BzivLnvtEKgEBpaLBreol79pgVC6hA1Tr8VSmOPqpdwGLEOKOMKEH/UfhoO8PxT
 5uYRLXtVO/xg4EAl0pu0WZ7XTMnYCHY6ezJzfq7OYpDVvs0qeSYuntYKRksf4uHDNUJ6
 HZQ1ozbJnyxYfOb/wgnt6/ZBoRPwtCezvpFp7wUONvHOANunUkps3b4//0Aaddyx0vFF
 Epg9pU6gF5dNGloBSI8lKJD3ks37jm9A5Rg+rZY1l/MLSGf2M4uO4Y45GhMZc4E4vWNR
 WfB2LfeHogOJJgaxXjAJShzq3BVEYU3zl5oq+IyJ4VmnLN7JOqE+2wyleNow+8BYwIS7
 1qhA==
X-Gm-Message-State: AOJu0YxhnkGjOKgBGJwRU2PthzWqeMT/v7IzixollUIWTBq6VsJzwymq
 JFfQUQ9Lt0lxT56pDh1GmCWxeFpGDGbd4w==
X-Google-Smtp-Source: AGHT+IF7WuOCII4S3EPBIZpm2cvWciuQt7jojyEGwo/EB2efL1TjCD65Nbw4Om30Hg3JvZImbJzLfA==
X-Received: by 2002:a2e:b708:0:b0:2bd:1264:ffc0 with SMTP id
 j8-20020a2eb708000000b002bd1264ffc0mr8170217ljo.29.1694446485229; 
 Mon, 11 Sep 2023 08:34:45 -0700 (PDT)
Received: from localhost.localdomain (62-78-201-188.bb.dnainternet.fi.
 [62.78.201.188]) by smtp.gmail.com with ESMTPSA id
 x20-20020a05651c105400b002bcebc7713bsm1572280ljm.120.2023.09.11.08.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 08:34:44 -0700 (PDT)
From: Jami Kettunen <jamipkettunen@gmail.com>
To: u-boot@lists.denx.de
Cc: Mason Huo <mason.huo@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Shengyu Qu <wiagn233@outlook.com>, Jami Kettunen <jamipkettunen@gmail.com>,
 Jami Kettunen <jami.kettunen@protonmail.com>
Subject: [PATCH RFC 2/2] configs: visionfive2: Enable MISC_INIT_R
Date: Mon, 11 Sep 2023 18:32:36 +0300
Message-ID: <20230911153253.20701-3-jamipkettunen@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911153253.20701-1-jamipkettunen@gmail.com>
References: <20230911153253.20701-1-jamipkettunen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Sep 2023 17:46:53 +0200
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

From: Jami Kettunen <jami.kettunen@protonmail.com>

Used to select mainline kernel fdtfile based on board revision.

Signed-off-by: Jami Kettunen <jami.kettunen@protonmail.com>
---
 configs/starfive_visionfive2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index e9b63e5b84..33f9ec8ad6 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -125,3 +125,4 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_PCI=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_MISC_INIT_R=y
-- 
2.42.0

