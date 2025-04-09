Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A379CC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 12:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B1B835D8;
	Wed,  9 Apr 2025 14:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a8GN9ewt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B475F836A4; Wed,  9 Apr 2025 14:20:32 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D8A283061
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 14:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso419804f8f.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744201229; x=1744806029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dYlv0O+ieTqbbf6VDswxmDaMgkLv6GpSm3WnEkZGIM0=;
 b=a8GN9ewtd2cD4yJtLjTxky0NOfMQ+Rl9cwWw0Ii+AXcliTnDwCZcga/hpENHlqsvnb
 2AE5flKldogWbDOzGUeb8AHq4rjn7OP0lkc26Z7PWx5fXJDEbz555UgMAe0yGt315pJm
 Cdy0DFneT78+DKD9HcJOEEJTEOfJhrBEIX5ySTpA90bih5NVIejV0+G73vHJSb1s1YuA
 HYEy/9SdjJWawo5AB/ShJCBAH27XZ1hNQKG/tghHGE40EAWrhDI34PXkHJiVcvnqCA1e
 +UMtzd4E8k4xV1xu6BPhQMPi6H/e106g0j4Zi7F5AsoDh2s0mKCwvPymBggHASc3YkN7
 Sldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744201229; x=1744806029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dYlv0O+ieTqbbf6VDswxmDaMgkLv6GpSm3WnEkZGIM0=;
 b=pQhRcla7O7l1R8GvqZWvqKxsu2HJi/dqaB4XWbVa9Le0AWLYnmGkgBIOx9zdnRjVDV
 r5PR+0was5pr+pa5cc75BY8WSe5ctjUA+pSJz/mQlyRb2V7ArSuy9jTnEzosA4/d8Iry
 gCLIIyR7l0SLQFR8JXUt+wnHBfgPwBr7gdU1A9pPAYiBGSOgjiECuXG4FSJrtaKrtick
 8T+7Q25DnrkPgaTgtB5yQgHEh0VZr9ALtwdTnROthPKSwpS3b6PYcY/bFZbpsIwSAjAp
 JYcxbxvKnTnOOhPOqGo+0hD+8EcCT/w8osA19tPWuPWl7c/LOqpD/pL0Nr9ru/L0Dzw+
 EPqQ==
X-Gm-Message-State: AOJu0YzYbzGrnwjfhZshRAsqYSYk3LB48mJtuQ0xSWeGzDoHOSgZbbUz
 500giHfmfw/VPD63GArd/SFWhpQW87PQmnr1WvKqtKwt4V3j3+0B4MiwBttCMQMn/R8bbTVndoQ
 TOdd4885I
X-Gm-Gg: ASbGncuYrwG0Kkx4aVlhsyxr9fRkHPsOFRTw79/TI/HjeaxHuMOoO3fhS8Q63fTyII9
 9MpcEmKeCig06KzWxlcYVosSltMcWFCLZSlHFy6TQcPrOFj/u8mJ34Wb5dFeDT2EUfZ8Bi3oJoc
 96EcEUQZc68Z74I9ED1x674AxG3C+REi1gxC0SiFGKXYowwoUz+Dttxa1bfD2hNfgDY8g9rivWV
 82HOXOSFiKxQPmzWeuKqW2/ig8KMcaYa0U1kYlOBjk9N4GF6xVs1IF/lSGeh3DhUndqbTwo843U
 Rh7XDnyERHAXYnnIb9rMoM5/KbOLEdgrcOIB1sPyyJfnCB4Z
X-Google-Smtp-Source: AGHT+IF9BhO/2spi0XmaCO+ECJ7Oyc9nuSuepgIoHt6sCmRPgMC9pJBEdaeP4Do+qQEG2BcJQQx0WQ==
X-Received: by 2002:a5d:598f:0:b0:39c:e0e:b7ea with SMTP id
 ffacd0b85a97d-39d87ff0753mr2016645f8f.20.1744201229018; 
 Wed, 09 Apr 2025 05:20:29 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7528:8f22:ca44:64f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d89389f72sm1464169f8f.42.2025.04.09.05.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 05:20:28 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2 0/2] NET_LWIP LMB fixes
Date: Wed,  9 Apr 2025 14:20:04 +0200
Message-ID: <20250409122007.2560668-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Two small patches fixing issues with tftp and wget when the network
stack is NET_LWIP and LMB is enabled.

Changes in v2:
- The wget patch adds a call to altcp_abort(). Otherwise the transfer
continues and we try to write later blocks which makes no sense if one
has been rejected already. Thanks Sughosh G. for testing and reporting.
- The tftp patch is unchanged.

Jerome Forissier (2):
  net-lwip: wget: add LMB and buffer checks
  net-lwip: tftp: add LMB and buffer checks

 net/lwip/tftp.c | 45 ++++++++++++++++++++++++++++++++++-----------
 net/lwip/wget.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 75 insertions(+), 19 deletions(-)

-- 
2.43.0

