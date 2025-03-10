Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A38C28B28
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 01:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0217810EB;
	Mon, 10 Mar 2025 02:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BX15Gjb+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F51810EB; Mon, 10 Mar 2025 02:45:47 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 879CA80107
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 02:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so5048819a91.2
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 18:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741571139; x=1742175939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VJqmWAMDmUmyiqFwJgRcCgshT08h6XyD0w71Mhe6zrc=;
 b=BX15Gjb+kz7xTgF1a1qt81bSvMWnAsYrohienbooTlB5ffaVvqzNk+3+EiIJKBvGu4
 OHJDWNTt6AvUt5Ylmv1vIw8J3ZOUDTDtpKKUpEfc/etASGLsrwPSPer1MqiQnI52IZVq
 kZFyy3REeB8/qOU7+lg4kLYcyix0V7PtwB8ZMnuPLwAIitm9eT3j0YMxm8AeJUVaJBHx
 AjS0mL03f8GZld+dd8dic5vuikIlfCai7DC+zIMo9H7ijnIKM1h8RrMDPK1pPmh+tJDH
 //HbEgNKB6LT/G+9Hk+FszdhV0O/WaIT1emouRT2FldSOqYwLjsBObZu/ebI0ZhwvJRh
 yONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741571139; x=1742175939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJqmWAMDmUmyiqFwJgRcCgshT08h6XyD0w71Mhe6zrc=;
 b=bXQgTPzk3zJGeh84HtWEZIW89n+2iqj3RtGbj2qOn/kQrj2RyLIbzjhH2Ebpf06J7b
 R0MuM/ROWbXiFZgCUM3TUWcHC/eCawZjOZ8h8XOGijomAcjfZUadbNXWxpZh1BGFGm6J
 G/Hg1LI3Mxw/R5yHAYWh00Bi+Txw7dBkg62HnjnzlsSMU9B2Pk61Bd74V1oZuFIq/O/x
 qcLIiENe1SU3uFF7fa5rQQ9xGC4qTPKTnEOZPUzrrh0cSiFQmJA6xMKuw+qgVkKyDEn1
 X4NxJTBCoIjevtbiZhhWf9rv2S2X3BFjTrl4gOppZFxe9/nSQBbTq+9NnoUA1UPd2od6
 8KDA==
X-Gm-Message-State: AOJu0YwKYctz5seqHLKbhXtWgki9E661gnl8N9N4YMN5hwW9Bbu/UN3l
 hjYPHtliPda3xGsyZ5KsRPe3RMSpsWFKrTA9Sz8rNnMg6KWv+6eqfLMVdw==
X-Gm-Gg: ASbGncu4UWAwb5PPXWAl6bLU4eKgTGs/p6n9f6ygNOzoNontGZmtsDXqr9AJkWMtaqM
 +fcyrFEmNJL1na6EIveOLUKVI60ObBx2w++EG3/yjAzRzTGygV2DW87AB83IcUryAw6+oSloaRH
 k5dkQD3TgPRiHadqMFm9uRWdO0zAfEE6KgP+CUkuAROoRouDsv5KtKIzioQVmf2F1z4R0QvXnHi
 WRJhwUfLWPkgQ+HVdYqDjGIsJKl3P+pIS+KVxxu5JSpXydEq3DLxlk3SqN2HzvbdImBhatp9FqC
 dvCfAVr739fU087ebqS0kZuK8UI5R3GL05tJO4iP2ZzApQdi6In2TZue1VIrLIXpAhURPpJKe4A
 1+ke9AW1OJSeaWTXuy+GnNRw8mxTNs6JLNmmE6A==
X-Google-Smtp-Source: AGHT+IFGiMN1HMLZ3DYiZiYZryAEFlNYQ2azJIi2zYjnF5s1U2IcSYN7OQunpy5PMcmpEAi5LaU47Q==
X-Received: by 2002:a17:90b:4c12:b0:2fe:b8ba:62e1 with SMTP id
 98e67ed59e1d1-2ff7cf0b4a1mr17636866a91.28.1741571138849; 
 Sun, 09 Mar 2025 18:45:38 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff69181d13sm6696049a91.0.2025.03.09.18.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 18:45:38 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH 0/2] Add support for Infineon S28HL256T and S28HL02GT
Date: Mon, 10 Mar 2025 10:44:27 +0900
Message-Id: <cover.1741570750.git.Takahiro.Kuwano@infineon.com>
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

