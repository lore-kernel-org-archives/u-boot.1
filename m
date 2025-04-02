Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCBFC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 06:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 906F281703;
	Wed,  2 Apr 2025 08:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VKng1/gY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D967E8171B; Wed,  2 Apr 2025 08:27:06 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4930080584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 08:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-301e05b90caso10899299a91.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 23:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743575223; x=1744180023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VJqmWAMDmUmyiqFwJgRcCgshT08h6XyD0w71Mhe6zrc=;
 b=VKng1/gYDPwONAP+mDEivBmv+E9YLqJrYcr8ec23v3kcvcDrT7pjWaoHQKUfmqZixC
 l5XVjaHmjs94c5/DB57icDws+FWRcbeQDWp6NPwb5m/GqDfPYP2TXy1tsI4Wk1P6g8ii
 Gk5n9bvd/S2zkYopgyTl+XZmi2KcRivaCUr7XRGmkrgC5NwPrzoju/CFfNTYMLYlWbYo
 tbPXjNFVf+XEwPLF6WeopPCMlwRD5LgQqrLShtjb46JHAqHxY+ROm7a8C00lD3I3MfP7
 QIUs9Ehbk4lOf+qovNVFNj3Tfw0+NlnY9owHMPzC0QpJBCyVz2pLRj2oqVeQVw4Kt3FG
 AIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743575223; x=1744180023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJqmWAMDmUmyiqFwJgRcCgshT08h6XyD0w71Mhe6zrc=;
 b=rxr91nr1zvYVV1ykiv99h03JLT40GaQ9lheS4dGh5JIOTyvdolMQgT/VbP7Idy79Cs
 3KLrzIc0TqSMgAjtJsKVu09kNYU91xe5izyTSlCXxjIh4ECknp7HVE16JMVc+ErW8QmF
 OoXGRbRYvpmpn0+kcOE8/jQPhtlDdZzcpI5aO03bUoRMAkMdUecR40J6wefVbA3FLQ1C
 5t0hCwOMWiYPV7huoed5C7OoOflpOOWC+884wrchOFhIcAL1VVNCRW7qAV+9/8/tFiCV
 aQ9BO5D+G4Fx0DbksNZlMqFqCJWcApxBoa74Wg6js/wry5EzeQeS6Q/xeGWmMkQZTSRD
 My3Q==
X-Gm-Message-State: AOJu0YxZXfnwHvjTJLX34gRQMHu1P6yJghB/rVuZBaUGTETjEOQGSoS0
 XzgamYsCaxSc8KroJgGXVRnp7N3DxCo5jC1+M5lcukN+s+fyyorK9BgttQ==
X-Gm-Gg: ASbGnct6sAtgaciDJ26Oe7Kosn9rxMx2Pf7Ro504rRcQZNuKF/0y/QMrn4+dGrKVgWv
 7Idnk4q8jaNc/bH8K8Ph/iK5QClexSidIKya5sNvGGel3GbrzvYjRoDZQVC9OWqFSbPMMMVhDGv
 Kviq/qBzKMU3CHzjNRoFxZwkNacQdCxWjXQFMuqXbjs667VHCmYrdSyTryjzzlezuQvujzMnwLI
 aLS9BPFb045+o92n0arfGYT949KlmBqmW3rlTrNDz1wHV22polUlq0X5AmL1vvBuX+ed9jheNHz
 3e2brztwi2FjzMBN3GfSoi5ipyvG30+TXwEG3QcOeooUCvaaRw8JQDzU5s6uyBiAx2vUg22GMQk
 Q19UkyV0B0fpN1msu8Z9Gh+Cy2MDKfCrb/ReQ0MJ1oyHvhEj/
X-Google-Smtp-Source: AGHT+IGvTGGllcoFn8ypHAXppJ9XtMlOzySAYF4C0VIpNEcAFoDj9qar9L81LcLMF/sMSHJtrTn2cg==
X-Received: by 2002:a05:6a21:3482:b0:1f5:5b2a:f629 with SMTP id
 adf61e73a8af0-2009f75b1damr29994502637.30.1743575222740; 
 Tue, 01 Apr 2025 23:27:02 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b8acdb4sm9115661a12.59.2025.04.01.23.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 23:27:02 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [2nd RESEND PATCH 0/2] Add support for Infineon S28HL256T and
 S28HL02GT
Date: Wed,  2 Apr 2025 15:26:39 +0900
Message-Id: <cover.1743575001.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Those are 3.0V, 256Mb/2Gb NOR Flash devices with Octal interface.
Same fanctionalities with 1.8V version that are already supported.

Takahiro Kuwano (2):
  mtd: spi-nor-ids: Add support for S28HL256T
  mtd: spi-nor-ids: Add support for S28HL02GT

 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1

