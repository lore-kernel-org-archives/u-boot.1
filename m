Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D899C54788
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 16:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F09687C6A;
	Thu, 22 Feb 2024 17:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ScRF6TeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6448E87C7F; Thu, 22 Feb 2024 17:09:31 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 306CB87C63
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 17:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41241f64c6bso14624325e9.0
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 08:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708618165; x=1709222965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p2gMXxXNLFZJVYGxMeM0mr43fhBKTmOoctPVRxYCbxM=;
 b=ScRF6TeQwBVRwRt0f24E1TYBwfv93K+WAtmGgLmrm39yBrLoMOdxDKVOXqDmLCBDhB
 LnKQ3vnMWzUwr9d3XXQ33TF9Rc3I/styu+0tY1KDNh3PzFwtPai6EIOOkA6yYaASlxar
 3otDMC3bFrZHbcaP8cFMUmglfBdBI97KzAvFQHpKY6OexL6cyjj7YUQI0kI6rq3usDCj
 dknOHQAlMwqroUEcwjUhexJ0fzrt+KE6bUEhz7wKeIY0j36EcpUipHUOF4I1oLwgxp7m
 5/H950xW5T0kirLg4AOB0WE+QcUzbRwxGks0nbScssP4bxPtFFgX9ldudVWlzZ0M06AD
 FUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708618165; x=1709222965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p2gMXxXNLFZJVYGxMeM0mr43fhBKTmOoctPVRxYCbxM=;
 b=VW2c+vm1TYFZReQYS7N5Bef3Mwi8lOO/Hm3TghIbC85vmneypRnFyzbyCipDduvLbR
 3q15+UCaPjvmeBNbUPSY9TvkvcOvA6KfMiQY5fSqNCK4nJNf+iaWWhlm/67LgUoTB1DD
 RoGtJbmMYEra7zcI2yd/lXNsCyEkhj7E+xeOBrFQU6ykJ+ajQnZxkur3tf4uuUvTdZXD
 K2AIOdrgWPhdljRCaobmSKjUM8rj4xYvzo56STropRfNX5tMfRBW94tZoSE4ITrAbk1n
 qN3xUYcX8e94PaWqaQHCTySVPyWF5BKcj9MUrprK9vbvGHkN62IfETefUzfXlsk6lWF8
 MvbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG+sBE8zeDhGPhELY159eT7IAzxwXz358aty7Js2t9saaoO2Jg0wd78BLUuBFyXsSRsIhpR1e4zhb6oLazZB7bgM7o8g==
X-Gm-Message-State: AOJu0YwC9BcqOnusb1w3Emajz998EH4mAwoOu9l2EvagGROiyf9W1Iij
 rQDDOLz+qekFCtEgOt4Llg+uG+PPHcYVdxM0mjPNoyIFuQU2riB/vXu2gBzcMms=
X-Google-Smtp-Source: AGHT+IETpzcSYErUhRWVa683oAfYOjaoD9o3zCvRnCiB37Rr3Wyt9Ulx55z+d2EIbzMJZYthCFzheA==
X-Received: by 2002:adf:e912:0:b0:33d:29d3:1aa6 with SMTP id
 f18-20020adfe912000000b0033d29d31aa6mr9119590wrm.54.1708618165610; 
 Thu, 22 Feb 2024 08:09:25 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 r3-20020adfce83000000b0033d2541b3e1sm19221287wrn.72.2024.02.22.08.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 08:09:25 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom/qcom-fixes-2024.04
Date: Thu, 22 Feb 2024 16:08:45 +0000
Message-ID: <20240222160915.3196313-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.43.1
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

Just a few button fixes that I realise should probably make it in.

The following changes since commit 37345abb97ef0dd9c50a03b2a72617612dcae585:

  Prepare v2024.04-rc2 (2024-02-13 18:16:57 -0500)

are available in the Git repository at:

  git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git qcom-fixes-2024.04

for you to fetch changes up to 22f391e8be11986bae824509470cf11e7bac31b0:

  button: qcom-pmic: demote "unknown button" message to debug (2024-02-14 17:21:50 +0000)

----------------------------------------------------------------
Caleb Connolly (1):
      button: qcom-pmic: demote "unknown button" message to debug

Dan Carpenter (1):
      button: qcom-pmic: fix some error checking

 drivers/button/button-qcom-pmic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
