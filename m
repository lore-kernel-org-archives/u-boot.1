Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAD3C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 14:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1B748785E;
	Thu, 21 Dec 2023 15:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SgAjuApW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 268BF8784D; Thu, 21 Dec 2023 15:24:43 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 527E9876AE
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 15:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsankouski@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e44c1b35fso1097696e87.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 06:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703168679; x=1703773479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cpAvPOO+cTCE1+i/kdYvbAbJjNmRj4akotQOgDTfYDg=;
 b=SgAjuApWet16jm3dGGi1nspdmMCxwxDYAvGG/Ok2k9457YfHspbVQP2jb7O4PxnjAf
 vQaXxPFK5SlOOalUiI/RThcZcPqHtw+MJEwNp5AkJylNJlqLDSd4LjsA6LMw7umj2oBa
 jUZJ8RiR+Fw4gPLJRqCioMrTFRcR7b7mBbr/oFUnvWIswXEhmF5PB7w7kAMje0ZHLdJe
 arhfLkdVUexnx6zbvwFvJCJWnABzVuoX8d0OSwYTD5kcgAv18eIUquPzi0SEysMk1shD
 ojNh2+ZzBcNHDnbOweQrLXZu22W98hJ/NksOHPp9BXxhvOJgnpwbOPG+uLxIDLL0FIPr
 OtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703168679; x=1703773479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cpAvPOO+cTCE1+i/kdYvbAbJjNmRj4akotQOgDTfYDg=;
 b=xJ6jzqCfU9/+v4ZAR1c0do3v9WlaterQFH2aqVjZDiLbBXuY189moRK/giZPRIbkOg
 gJeRJJaR2NTjDmyMhOs116iYRLVWX9zcJrSaVKs6UmC8/W1KTT0J7qXZvxUw2UTMt/Jt
 zrbGdDWQMIb6Y92b2u0hirhjx8IgJqQTrzoOpz7TP6D8Kv7c6ebIzgZv3FhPjV+Sst0R
 hCXKzAbdPH/T28Basiy8dj1Qwci2CQWy8IxpeFRomCuT7InOE1B73pecwVKKqhZs0gu8
 ZzDeBevQ9Eb2QsY+7p0koWYl31h8QYUB0OIPw7atfeNEdm4mYZJX+lIXoKZlIMnq8SQM
 OWjA==
X-Gm-Message-State: AOJu0Ywx82HBRqqPqUPn+TvRKJZ8gJ92qG8j7cmZHdbKPbq+QBZS+GUd
 6XVZ5yoSOMCen6I0hdICHHKkud3kC94=
X-Google-Smtp-Source: AGHT+IEv46YXh8OHhVUNC787QoQhrg2oeVbs2uCqAlkh4beFcuKuGzQcIroYnIHwTsLmARmfFLxevw==
X-Received: by 2002:a05:6512:401e:b0:50e:4f60:7c8e with SMTP id
 br30-20020a056512401e00b0050e4f607c8emr1680213lfb.118.1703168679060; 
 Thu, 21 Dec 2023 06:24:39 -0800 (PST)
Received: from debian.localdomain ([37.45.245.217])
 by smtp.googlemail.com with ESMTPSA id
 q17-20020ac25fd1000000b0050e3719148fsm280653lfg.235.2023.12.21.06.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 06:24:38 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
To: u-boot@lists.denx.de
Cc: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 0/4] This enables more recently added drivers for starqltechn.
Date: Thu, 21 Dec 2023 17:24:05 +0300
Message-Id: <20231221142409.82877-1-dsankouski@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Series is based on top of caleb work [1] and should
be merged after that.

[1]: https://lore.kernel.org/u-boot/20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org/


Dzmitry Sankouski (4):
  arm: dts: starqltechn: 4K align memory
  arm: dts: starqltechn: add ufs support
  arm: dts: starqltechn: add buttons
  arm: dts: starqltechn: add muic i2c interface

 arch/arm/dts/starqltechn.dts | 38 ++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

-- 
2.39.2

