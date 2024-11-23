Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74ADE66887
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8953890B9;
	Sat, 23 Nov 2024 22:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mS4kO2lx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0024689117; Sat, 23 Nov 2024 22:36:59 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63BBB8905E
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21269c8df64so33866365ad.2
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 13:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732397816; x=1733002616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3IWETRviJrRdUJ9SL2PhPwiPXo2X/57by4Ci9+W/hRA=;
 b=mS4kO2lxRo0/ov3kXsp14o11keQz8l8p0MA6HZtLx0KwIv6Di5k1dOMzsgWHxEOnha
 UVptj6tcWO6Gf8dDIxwTgFsqN7IPb30QoPluvTWlEqlolNm+J6vf/lprZYTOlk5ssDcB
 CeqFhbrXQQntyjucL6s/bKiihRu88lWO37WH3MDLRHD3KsVKT7n3kDCWu5hbwZaPHaMT
 X5BUgWZ1M59QajoOesD/yaBPALyMa+0G6sRNkETdyt1UpIr1yBd5oXjcBdHvpTITCE8p
 C18HmFHPx/SC1GX0gh5twLknDpo7Tpd0IioiLWw/pShCNIfdBcKqniv64+wdutuOCAFX
 5W7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732397816; x=1733002616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3IWETRviJrRdUJ9SL2PhPwiPXo2X/57by4Ci9+W/hRA=;
 b=qtmyHwKcUzdyBqX/wS6Wa78TXB9d635N41Xi2+lbQPU9qkaakE39sAmX3Mhvn7R+ev
 BRgjEx2ej1cbuNe5yJ5lh55fschymxZKsaONAXqvT1Br6ChNeL9ng8qNZevuMb4B0klB
 D1h95TIYkYoquV0soC8v5VE4eUluoD+Sb0AAz+Xg/wo/t86pDw1dALrlf2HFjj7j2ykT
 TeVn5d0C/Deo8vslv6xQ+gP0d7j6BCSritsFcy3qcGLYwqrKLLsW3PQWLGAP/DF3o1Ja
 /EjEJk7xk/SnOWMsyArqtaTmBJiEPnb96c34yBiS50TSLgO5dD/IqKO3xZEa7trgzCNH
 3Lmg==
X-Gm-Message-State: AOJu0Yw4ig6eTPd3ppwe/FMD9X+qx3nNR0OFqj57rRS1JhmAv3xZs2ki
 FAiLN8LcUFSoWswUhW54XqD7Xd6RTOFH6/rY3dko6dEB1yXxQ2HflGSZWw==
X-Gm-Gg: ASbGncsKAnHCV1l7zf1Y8YNKloztYjQ/GJigVT0Q3PQp6ebBhrZyegTizLYEYQSpUX5
 7TOGyrSKlvvceQEPyXBFH6WjP0gL729aGGuxgn2/P944t4vxcaOorKG/Pc96reecl7JkjKK0zCc
 qCP3OpLWjE7EDkKaMDlYdZGPcdLyBf8ZsBfOme4NGZKVcxRZCuCa9y6G0cx6oO32WkvjPqMQ5UP
 85vTJzirrDuHJNGbVV4frNn3nCGXHcDXLk5LcuTJY0PNoM/4uUpyS/LUq+KmsVv
X-Google-Smtp-Source: AGHT+IFS3ZM72ez3BaAE3RMBESXcDm70HTKqsgnHJgZ0cG4Qs76AK5KwEoeOFlJeYjYc0hGO5Lb5gA==
X-Received: by 2002:a17:902:e741:b0:212:7f4a:6d5d with SMTP id
 d9443c01a7336-2129f781144mr113854755ad.35.1732397815800; 
 Sat, 23 Nov 2024 13:36:55 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:7625:338b:7307:57ff])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dba274csm37004155ad.70.2024.11.23.13.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 13:36:55 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20241123
Date: Sat, 23 Nov 2024 18:36:51 -0300
Message-Id: <20241123213651.670462-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit 52c0e5f8a39ef022ee5ab2dfd67661d1d34941c7:

  Merge branch '2024-11-22-assorted-fixes' (2024-11-22 15:04:54 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20241123

for you to fetch changes up to c02cdd41877bab89ab17f922f1e19c1c4237e83a:

  arm64: dts: imx8mn: Include 32kHz oscillator clock in SPL DTs (2024-11-23 15:46:34 -0300)

u-boot-imx-master-20241123
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/23523

- Fix a imx8mn clock driver regression where the 32kHz clock can not be
found in SPL.
----------------------------------------------------------------
Marek Vasut (1):
      arm64: dts: imx8mn: Include 32kHz oscillator clock in SPL DTs

 arch/arm/dts/imx8mn-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)
