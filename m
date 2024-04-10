Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6E4CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 19:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B6288120;
	Wed, 10 Apr 2024 21:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=loftorbital.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=loftorbital.com header.i=@loftorbital.com header.b="Z/avKSfQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 195EB87B71; Wed, 10 Apr 2024 21:50:22 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E36A1881B8
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 21:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=loftorbital.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=charlie.johnston@loftorbital.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e2bbc2048eso58746875ad.3
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=loftorbital.com; s=google; t=1712778618; x=1713383418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k/KTFe/Z1CXT6MkzJMyXd1h6QbGYMOHgiOplKT5oCRA=;
 b=Z/avKSfQPgFEDHE3V/BeUJ2YfXgXHxU1IfQxK3TknESabrpctMrcxp6ABvL+14CDAQ
 cwl6tYgU8b3p/FpqanSU15Tw5cc4yjChiU6ckrXNC/VTihBCPsABdD5VssEG3bblpVxf
 q1fEfrK2uY04vB+Gl5yCd72Zr0vnFwKgfaq/MaGsqpb6tlAcMzZY3wqg3awtwUr9f0vs
 +besFk3FR+PngKDQOMvrh8ZiURUWyVmAzxycXNcC/OoiiJtxHwLxDZRYrVpuCL3ZGVHo
 rz7p17zkYwv4ZKCOV3SUsiJWbjKfYV/9Baq5a26gBj5QE7HPjbI3vE1a+srGvs1iN6z1
 vZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712778618; x=1713383418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k/KTFe/Z1CXT6MkzJMyXd1h6QbGYMOHgiOplKT5oCRA=;
 b=H0iTIgiHcGoSW4BiA7ODGvdof4RGE+z9PnWQ9ZakpJH9drcJce4quvLOxEi3SnZ05M
 eyLJ/vl75iJmAu79HnATTsxuP0q3zhz9wxCiug6Kv09y55k3+a+zjbTTdZUHFn1Bnmn0
 kum+N9ute7rLNNbASZOYXGHLcwEJEdSdFmFOLbeF1QGtu6rJE4d2C5WB0Dkx2bU8udez
 y8uO264EQDtiMGjjg891aWxOO4PkO4TnPilF+IGB6jAdBOh7ufVyhe2GtoUtL85LwvGs
 DCu2dqCBjGFN+EMzBeZFzqmp6I5Kin8gr0P7DTH9/jVz6EJhWfOiwwMcrU7IBuUyuEXk
 vO/Q==
X-Gm-Message-State: AOJu0Yz3Xxz9AXdw63S4EQ01SCjV2pTNa8Ubt6xUTaWTAxQqfvC6T+99
 cGBZhDfPFQ9GV2AUdVFSm3o6vEUAA/ZPhyVPtWUs92CIf7Nr9inROcnxIpP/SpTi6WM5yUR7o5/
 m
X-Google-Smtp-Source: AGHT+IF+1h7cxAQxhzSVK5ty5j8dku1nBh3TrXqPp3ywln42sClkOwH1UE69xQevviRV+Tm4EKGPzw==
X-Received: by 2002:a17:903:41cf:b0:1e2:616e:2883 with SMTP id
 u15-20020a17090341cf00b001e2616e2883mr4238842ple.24.1712778618098; 
 Wed, 10 Apr 2024 12:50:18 -0700 (PDT)
Received: from cjohnsto-vivado-vm.. ([12.172.216.189])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a17090311cc00b001e223b9eb25sm11131932plh.153.2024.04.10.12.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 12:50:17 -0700 (PDT)
From: Charlie Johnston <charlie.johnston@loftorbital.com>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com
Subject: [PATCH v2 0/1] arch: zynqmp: Make zynqmp command more accessible.
Date: Wed, 10 Apr 2024 12:50:07 -0700
Message-Id: <20240410195008.405061-1-charlie.johnston@loftorbital.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Apr 2024 21:50:58 +0200
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

While working on a third-party board using a ZynqMP, I was unable to use
the zynqmp command even with the proper config definitions. While that
command appears tied to the architecture, it was being included based on
the board selection instead.

This patch series moves the command to be accessible to any ZynqMP arch
based board.

Changes since v1:
- Squash into a single commit
- Command is now moved into arch tree instead of cmd tree



