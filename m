Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892A3C47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 13:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 547E487CC8;
	Sat, 20 Jan 2024 14:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZTWjpXhi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A3C987D2F; Sat, 20 Jan 2024 14:27:37 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A046B87D4B
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 14:27:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=resch.max@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e800461baso19433825e9.3
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 05:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705757254; x=1706362054; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RxvJgxfWdPWl1D3iXor50U3PK/i0mlQtAePZHggmGMg=;
 b=ZTWjpXhi0XGJKjoQTnHdL+2PwR6SBnps6QKKwNE2z2+OBXmnrU31X2P4pjOOS//e97
 zcxm30aCTxCr+HHOV6ga5YJK3ZGzFnVf/3XIZRL30egdpCA5qauFP60yMV/nlcBf5Ah1
 9tefeUqsUyICOw2HcGRAstxyxmrjQ/gy3c4TnZs7QXjHWGq3KTapgtvMCZHYzF2fylls
 l5ghfrxEADPwcUfZ9gnP+fYwfqEsWLBtPyfnbp5d+Fb5F9ZQEQnCseSRB8ZW+O7lHoSv
 W8RBDFXnTgz4ahrW3dsf2usqpCArHyMBHmpGRdOiUmMXkBTdgULvoDKNYuSmVNjMeSVS
 GDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705757254; x=1706362054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RxvJgxfWdPWl1D3iXor50U3PK/i0mlQtAePZHggmGMg=;
 b=BJOukXGBeL3pgy1IDpcVNzMC327kYujxLkAH6Mo2Cu8q9Oz4FEioS1UkvkGNhaHGAq
 Q5IKQnfDmGXQjTNGCVZRCfwPnCndWnV028bq58OQf1FpbC6EUDKOu1xF5z1DR/rQxJ+q
 Hk5OXCxbCA4kjn4Aj7tsD+9nafTs30Q0hfsdr+gkbN3tNBR22ACYijew7J9N61gHavje
 PJz5CELHZD3jWkpgDFymxD4/D1Q6If0ZJh83FNkXTaYWwM4iMwY/zoaFxnHfvDg8thQ2
 Q8bklcOomhtGlG3BlNLj7UKmA8FtoVL8cpo8Tokaej2frhZz8e7+KmHsmTiBot6HozIR
 DSuA==
X-Gm-Message-State: AOJu0YyIk5nx5mx55v7ATdlGjwNbZNr/9AzN7VNJX+NLIbCaADVZHn/k
 nye8IzSJ1YB4ZEUW4ie9kMBbyFwRjbm4O+PSg/CKVxSQKAWBsilrTWpxlIME
X-Google-Smtp-Source: AGHT+IEpgust2b05kNoEKLRA6CQIYM3UyQi7gwMVsMcZ+LvySaU9DmG2iA46qntmCxhLuM3rLIhcjA==
X-Received: by 2002:a05:600c:2182:b0:40e:6b84:ee71 with SMTP id
 e2-20020a05600c218200b0040e6b84ee71mr426566wme.336.1705757253970; 
 Sat, 20 Jan 2024 05:27:33 -0800 (PST)
Received: from niflheim.lan ([2001:871:223:517:1bcd:a630:f42f:3edc])
 by smtp.gmail.com with ESMTPSA id
 fl19-20020a05600c0b9300b0040ea8d346e4sm300331wmb.37.2024.01.20.05.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 05:27:33 -0800 (PST)
From: Max Resch <resch.max@gmail.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de,
	Max Resch <resch.max@gmail.com>
Subject: [PATCH 0/1] This patch adds support for the entropy generator present
 in
Date: Sat, 20 Jan 2024 14:27:22 +0100
Message-ID: <20240120132731.35321-1-resch.max@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Jan 2024 14:38:26 +0100
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

the Armada3700 Secure Processor. This rng is onlt accessible
to the rWTM firmware. Currently the CZ.NIC Turris Mox firmware
exposes this.

For the Linux kernel a driver called turris-mox-rwtm exists that
makes use of this feature. This RNG driver for U-Boot tries to do the
same.

For efficiency I chose to cache 4k of enthropy in a ringbuffer.


Max Resch (1):
  add turris-rwtm-rng from CZ.NIC rWTM Firmware

 drivers/rng/Kconfig           |   8 ++
 drivers/rng/Makefile          |   1 +
 drivers/rng/turris_rwtm_rng.c | 143 ++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 drivers/rng/turris_rwtm_rng.c

-- 
2.43.0

