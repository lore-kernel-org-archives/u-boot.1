Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FEAC369B4
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 11:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CDE9829CF;
	Tue, 15 Apr 2025 13:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r0i5SBeF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D97CC82A27; Tue, 15 Apr 2025 13:17:07 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6647380584
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 13:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so820237266b.0
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 04:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744715825; x=1745320625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=x1U84izIV3PICK6O2eeQWmQNgQ6c2s8cMBSwoHOcHRc=;
 b=r0i5SBeFNj3J2X4t3Q2SakDMexQVxKYXWp88GhS7v2/SjwAnNzXg2CJigmYT5nT2gx
 URdYriWcr+c5XBhO3HUXig4QWefha6coMBFJ7/78nDmlVq+Mud+kFRybEgwAY108Lm87
 5iwCSyED7VnZG80BNAnNFmnhxf+G9n2I/K0fo2g3QnIN5THtZXB2FPLtx//Mz/ToYb8h
 t4UF8UPI8h6tlCJ3h26kMLw7qzq7Vsftwh9VKh2Myc6klFL5DfOfo6t3RBaV8E1cE1xr
 VlRmZcbTE3SmNUKK+UBaRPmB8B/a6XR3qcU1srGdHnO8q+OQTsB9vycOO11g82g+Cj2v
 GNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744715825; x=1745320625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x1U84izIV3PICK6O2eeQWmQNgQ6c2s8cMBSwoHOcHRc=;
 b=ZtPJoQDpjfopqP64GHVRopGkjoz7m11mv4M5B2W26GUkQHsk8jjvk9/BO/hxCpGzBe
 8ymdhFaMH6gn8AcoHUJbpXEOVET8dprlYOaeg2QTYiI7q+T+tk+uSrlL0YanoME+4TYa
 M3WfGgHT+ep0zDgo4OaeP22xTwjiH3Ij6VzmxiycLE4fd+08iOphAZIPUQJBJkOzaqXq
 /YDwDJDIq0W7Tc+3B4y6jtrS1FKaxaEpu277s0ThT85S/WffoaSg5ZauqPXx022ZaYMw
 eKZMH9GyNSPA/rqtnjMj9z7iMRAjR4fVb00MWLU76nPbIbaeGNLX/0I5xsidkl3N1PIU
 GoGQ==
X-Gm-Message-State: AOJu0YzknG85WP3biWc7ZaClvYYzTBzvcmG65elAFqlaCiK7pUiOtIVU
 6BGimOmV0VxNjXNrCfSyj6SOSNifXXIaMzrVUey7g/nBBOO3ktOwnkodNgXi4bgxCmEP4p64Le+
 T
X-Gm-Gg: ASbGncuZ73XItP3/OD+Nw1NutPRvusdgoMWsB3bGNNNPxL2iQoJcgR70cAMlhAFe8Ow
 wZNMjTEznTU6JvD217x1DKJYbUsTjBvj0Qshme0OVmnHFIGfD/fVSca/ODwxnyXhipsA1y/jmEW
 ++0DQJQwKg8QIBFXeytIrNy9yQfLyw0qRt6IDazPG5kj/6smJX3bJk0x8EdIRDELgm+RYijW/rD
 x/UmbskLHkNS2M3BLrRX/wSQsKnJYjTgIrzG24r7yMryXvAcr+vj0jzhhkxIAn4g9MNMzkexblY
 aFqZLiy6RGS8oY19ZLUXxer5lFembko7raJENZZZbIvnU/s5nQsSE/Cc4kCj3A63
X-Google-Smtp-Source: AGHT+IEQhbL1kr4JpcxbscMkfl0UfDLE1ltjPyWzQH7fKN5WS6Bdsk/2bqrWSrR7HuvFjY6wWbQD/Q==
X-Received: by 2002:a17:907:60c8:b0:abf:4bde:51b1 with SMTP id
 a640c23a62f3a-acad348809bmr1284720966b.21.1744715824629; 
 Tue, 15 Apr 2025 04:17:04 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1cb40e3sm1059515166b.122.2025.04.15.04.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 04:17:04 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Subject: Pull request for tpm-master-14042025
Date: Tue, 15 Apr 2025 14:16:57 +0300
Message-ID: <20250415111657.3265406-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Hi Tom
A small fix for the CR50 which moves testing of hardware a few steps ahead.
Simon tests still fail later down the road, but I don't have a hardware to debug
it

The following changes since commit 739ad58dbee874a3ad3bddd116e995212a254e07:

  efi_loader: Moved the generated ESL file to objtree (2025-04-13 08:09:17 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-14042025

for you to fetch changes up to 275777bc94cf1673b38d4d5438dfb07df7902603:

  tpm: cr50: Support opening the TPM multiple times (2025-04-14 22:59:01 +0300)

The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/25691
completed with no issues

Please pull!
/Ilias

----------------------------------------------------------------
A small fix for the cr50 which is a TPM but doesn't support all
the TPM functionality. Since it deviates from our normal TIS compliant
TPMs it can't be started twice since running the selftests twice hangs.

----------------------------------------------------------------
Simon Glass (1):
      tpm: cr50: Support opening the TPM multiple times

 drivers/tpm/cr50_i2c.c | 4 ++++
 1 file changed, 4 insertions(+)
