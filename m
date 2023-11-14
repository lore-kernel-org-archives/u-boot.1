Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40DEC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 09:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA53B870BC;
	Tue, 14 Nov 2023 10:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MCGF3JnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85543871ED; Tue, 14 Nov 2023 10:26:36 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3855586FB2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 10:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc7077d34aso40546265ad.2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 01:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699953992; x=1700558792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U+ZH3F+k+xghG6wIoUX7OP2z4eyS8oScizml+z/15XU=;
 b=MCGF3JnKGYp1W1hdt2TPEmRJRVMi7GEBsZRzU+fDmaeCI0IQ8hC7ooj4YR2RENUQzp
 9yPw1CPhYKPcut7b/OFkXORXLJ76x79o6DCIR7wc078lb41aa5um7Bzm2EjvzMTgw9Pp
 E8p2zjE27M8rWNtWU/SzDvHf+hnfz1NdfshtS0wSY/nn2eC8tc5iUbVCcZkFbmw4cHdS
 kVmPQdVzIiJbeED1HambNoVTMcJnqqly4EGFcrjkP6nvn5vk7t2fR+8CoT6SV6MXbztb
 TpP5dDjXw5gEoaPzLYZ4lXuzvRMvKRYRWBrMzalnVu+i214afDEtIwCmDwOSY8ixDazy
 QibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699953992; x=1700558792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U+ZH3F+k+xghG6wIoUX7OP2z4eyS8oScizml+z/15XU=;
 b=pCYwwZrUy9wJNmzhd/Q4FAFFcm4Ansie8SkjFpVepF0uB3tTQi24MAIQjkD+CAS/M1
 KnyM3xkE78bFbvLrhOGUFCKzavveAYen0ETWljlT7g5tfM1SCcH2dGNNkwrdazoblQhj
 jqhNsDzi1B3LxhabsV5+0ERMuf7FBtNrOo/nwKhPe/HYsoMXOfJTf0fKmIg06EaM+U9k
 EcTfFWgaVNU8mF55zV//TKI/p890OECqaGQTIB4ck7X4T7P1N80B/rY0IaqmKh/itbo2
 Qy8DgEEEZZOm9vmEba8EsX9+WqtMp7fyES9FTyBf9Q+EtcrY8IzlqiJ0mqBh3Vkj7UIz
 ycaw==
X-Gm-Message-State: AOJu0YyGypmbG15LERRXpaFAFXD/PlwT+aftNcqLdYjCHcC1GAPPdY//
 NnnALkrb/hAuRUhTwggE5M7xVUAVeXdnPW1bCQs=
X-Google-Smtp-Source: AGHT+IGlI3I1wgrVCQq1UQT6D2Jo5MfuIem+qnyo+81t051nWsUEaoqOn6Y7gvM70lgMXnafsp/Iag==
X-Received: by 2002:a17:902:d4c6:b0:1cc:339e:c228 with SMTP id
 o6-20020a170902d4c600b001cc339ec228mr2102140plg.58.1699953991708; 
 Tue, 14 Nov 2023 01:26:31 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 j18-20020a170902759200b001c0ce518e98sm5261199pll.224.2023.11.14.01.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 01:26:31 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 0/2] fix FMP versioning for FWU multi bank update
Date: Tue, 14 Nov 2023 18:25:06 +0900
Message-Id: <20231114092508.3955838-1-masahisa.kojima@linaro.org>
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

The current FMP versioning does not work when CONFIG_FWU_MULTI_BANK_UPDATE
is enabled. This series aims to support FMP versioning
for FWU multi bank update.

Masahisa Kojima (2):
  efi_loader: use original image_index for FMP versioning
  efi_loader: support FMP versioning for FWU multi bank update

 lib/efi_loader/efi_firmware.c | 65 ++++++++++++++++++++++++++---------
 lib/fwu_updates/Kconfig       |  1 +
 2 files changed, 50 insertions(+), 16 deletions(-)

-- 
2.34.1

