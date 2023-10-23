Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B555C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7692887874;
	Mon, 23 Oct 2023 09:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NaZwsGre";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 189C787891; Mon, 23 Oct 2023 09:02:48 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033768784F
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cace3e142eso14346275ad.3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698044564; x=1698649364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XqTA0Izmpd2TZ/pY3Z6YeweQ8kGwEDjY+azdTKfHWUc=;
 b=NaZwsGre7/xXHmUR5jiN6lreciZnxloqs+uxLuDQQLVdY4A4fgZ/5NOL5ERHCDqXr1
 +JcoEtZxkdZGtb6oMYvJVAl/bEpOFRILqJTMuPxubs3T/7M/pW7iKhovlxQZoqFZFzVX
 3LGFu2JNy8HpdBhOZNrMn82E2IMF4bpk4HYYJ7lfJcKfSzNnwwQXSIE4IS+wcuaKiR/L
 CVlDHEh8h1Gnq7qsCF1JfCFPll4GYLjwyE7pUJOKf2wFNR/A5sdRgaiOuCIz8pwvrDbV
 ApdEoEuRNjCvWyz2HiVDgWDqUIOlNnDDXrWtk/kEUX/SII7Iw+/xpPvNjajy1+6gXzE4
 7+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044564; x=1698649364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XqTA0Izmpd2TZ/pY3Z6YeweQ8kGwEDjY+azdTKfHWUc=;
 b=D8R7JRLLTIpaoNHcLrC42U8oBlqjVM7ViTf7IPG0Sz8uWzo0xK+fy9ia49LQYNfYoY
 F8hszI1psVSyatew7ooENX7KWFofBXfRGmNXPZ98HI931IcCMKwH2hhGjCVgBpjXYqlY
 h/0z8Es0A5D9mGjTBTGjoj0Nefzhcsuw9h6jiiQE2ANjDkaTt52eP/CTdmysFXi9gvEA
 i5kloir1tQCnjBvaA32nZTpksbsJ/2YecuS7BhMcLmRfkQtIb6ft8PzJjf7GCL/ZAQj2
 MOCe9aC45rqaBDhPIMxkyrI4g1YjcpQF46AyauaxM3iP7egU16gzfdf2PK5q+WSyZw1w
 YN3A==
X-Gm-Message-State: AOJu0YzfvheuAyt2MRnA0GrgyNDA0X4TVSbnRcV2k2v+LUrkX68Y+9Ug
 pev5PdHM7/B0iMhKpf1KBFQ=
X-Google-Smtp-Source: AGHT+IERUFmMCk3JX5KgXXgXkL73eqAxUR5kAMyDFbU9zYMakjCTP8Kt0xwB1dWbQePxG7D2JBXUow==
X-Received: by 2002:a17:903:244f:b0:1ca:495c:77d with SMTP id
 l15-20020a170903244f00b001ca495c077dmr7387354pls.18.1698044564250; 
 Mon, 23 Oct 2023 00:02:44 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.144.223])
 by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001c74876f018sm5368432plg.18.2023.10.23.00.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 00:02:43 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 trini@konsulko.com, jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 0/4] fix npcm bmc error
Date: Mon, 23 Oct 2023 15:02:21 +0800
Message-Id: <20231023070225.3142578-1-JJLIU0@nuvoton.com>
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

1. Add name for gpio pinctrl function
2. Add baud rate table
3. Fix ecc ram size
   - ECC ram size
   - Fix wrong place to set dram bank size

4. Modify configs

Jim Liu (4):
  pinctrl: npcm8xx: add name for gpio function
  configs: npcm: support more uart baud rate
  board: nuvuton: arbel: fix incorrect ram size
  configs: nuvoton: npcm8xx: disable CONFIG_SPI_FLASH_USE_4K_SECTORS

 board/nuvoton/arbel_evb/arbel_evb.c       | 36 +++++++++++------------
 configs/arbel_evb_defconfig               |  1 +
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c |  1 +
 include/configs/arbel.h                   |  5 +++-
 include/configs/poleg.h                   |  2 ++
 5 files changed, 26 insertions(+), 19 deletions(-)

-- 
2.25.1

