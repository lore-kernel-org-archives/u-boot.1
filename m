Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47055C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 17:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDC6686EDF;
	Sat, 11 Nov 2023 18:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fmlE8bPE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 846D186EDF; Sat, 11 Nov 2023 18:33:02 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB15986ED6
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 18:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6c320a821c4so2728799b3a.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699723978; x=1700328778; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A4wKlojmSrfn4VLb7HgyMgUoqj9icJIfrU+vWX0ffMQ=;
 b=fmlE8bPEFLFuqUTG/jvei6jmmv78IrQyZw2CEE6OUyBydDOIkDbhXTQ6i0oA9+5fl6
 xgCRxtaCHyKj/fLpRzijyBKAxs5CPSYUBdaq84IHRt5Ir+W25QY0AJAKXQO3aWfgWe1K
 obUn96gz7Tr+UKYR3EE2DCcnb5Z5/hK6bjcpjNcn5DgqttKei/CmE/fjBbJYn6TQmv/J
 WFip0X9FiCd9dAVrLzbnE0xv0j0AxDlGitOIuqmsynJvAL4A2r8zZs4o4ZtKS/KJZtA3
 S/gP1HrcoeRurPeKBo+2fouv/s9ahuqlBoRlkXfh8vbNMnZe4HNyIPJRR1uvBERfJj/+
 4TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699723978; x=1700328778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A4wKlojmSrfn4VLb7HgyMgUoqj9icJIfrU+vWX0ffMQ=;
 b=h2HQViqGAtfUCbDvcGRwvDosrwmuULibHhyUuE0cwPjAHmUJ0UxPn1Bvw6ScnG408D
 yaGg9HVidCVPkSdo7O42q1Wk8+eqW07ZfXbE8cJUgJjUN0WniVXx+2ZWnbz5bjVSlV1n
 cMGADLfqpd/DCRuMZbxsLtr8IDvnPqhMphlUoSX/bZP5IyasezRgSnesa3Ouwdh1NFm0
 ngi102qwGFjbP+EyZweO+rx2X4PnB26ZjRdFbo9RlMS3sIWVR585i3YNAkp9pUU0d8T2
 xsj+e+B+Z7ytPov1Vrue4eWfx3TGDSb2kGJwNUvNJLk0Og7PjGlEbq72pIR/2BWNCf+f
 hLPw==
X-Gm-Message-State: AOJu0YxfPlxq3SkHZETeWJJW8kh2T1lD15wDqo0Np7vhWTVv+ohX7ar2
 w0x/arhfsEYbrMJowPAQGhJOFA==
X-Google-Smtp-Source: AGHT+IGzOyvpTkO6p8rPvtbDaw4vom+XLxU/RC9NCTyt54T5oqejqPnTCgRDEs9shVYXdBmH7sgexQ==
X-Received: by 2002:a05:6a20:7da1:b0:136:ea0e:d23 with SMTP id
 v33-20020a056a207da100b00136ea0e0d23mr2009027pzj.11.1699723978035; 
 Sat, 11 Nov 2023 09:32:58 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com ([223.233.86.194])
 by smtp.googlemail.com with ESMTPSA id
 c64-20020a17090a494600b0027cf8869ee7sm3772218pjh.0.2023.11.11.09.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 09:32:56 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/3] Xilinx SPI driver enhancements
Date: Sat, 11 Nov 2023 23:01:18 +0530
Message-Id: <20231111173121.92889-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
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

This series makes the Xilinx XPS SPI driver compatible with the MMC_SPI
driver and also includes an enhacement from the corresponding Linux driver.

Mayuresh Chitale (3):
  drivers: xilinx_spi: Use udevice in start_tranfer
  drivers: xilinx_spi: Add xfer callback
  drivers: xilinx_spi: Probe fifo_depth at runtime

 drivers/spi/xilinx_spi.c | 68 ++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 16 deletions(-)

-- 
2.34.1

