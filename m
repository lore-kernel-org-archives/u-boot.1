Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BCCCA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 17:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC20F83214;
	Mon, 11 Aug 2025 19:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N1HoRPP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2AAC83257; Mon, 11 Aug 2025 19:03:42 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D0B802C1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 19:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b7910123a0so4248566f8f.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754931820; x=1755536620; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nm1CGe9/20WBUvlIGgJAQqKuxI8eAEMP2hELYqC7/MY=;
 b=N1HoRPP0DayNgjer5vMoW1ylRIevj1lcnutYJzT0CBCiqvH5DrF5sw28Nu3ERS8f/x
 xDIYCQHwgTP2J1WoOvB/kp3XoQ5feLVkkDop2yXmC5YoF7NMK1L9jtCSgDKvhw/hIHnV
 eaB4htlsrUEDS2w0VOAZVTQB+UOeJfpgHtYo3/owKruTXLEbC6JO3mOM7TeXMZgGcolV
 tx1xJVzjPXY+SU+3P6LMyhIVS3MeFWIg34FXzvXfM4PF4sQdvQZ9AUXIyl95qcQRqyoB
 w1tU2Eth7tDhW9gLm8LJLRLud0LI0pToHavJIDLXOLUae6h5OydOiy9kVUszdLQpoNNq
 idhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754931820; x=1755536620;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nm1CGe9/20WBUvlIGgJAQqKuxI8eAEMP2hELYqC7/MY=;
 b=Y857Xsesrnp28EXk5PsyHAqAz+We6GV1hHsTwWXwEE2CGlKsIeEGKrP9CFYuMs2lEQ
 XBtGnrbNf+gY7jLxbovNt4ud0c01iy94ImEjl7ICSvbB4zuN47pFsDxUH+18yjeCot1A
 01bl9nlqvU/FHVkv+Sn0sjZRHVBPcbKqrPSNSsqFS/ezXCQ6ppM6Lp8r/njxxhs9/u/5
 K1rs566KDHQ2Ju/x3CvV2gGjJ/rFYTmiuBo7jTzO4NeCur1HYqSuWOX25fiiOfK1CPZA
 ykd3UaThQO/K3lJ16DwEiKeis4GsiO6OW2/Qr9ARZwqCRdoDT80cn6bjP/uxXolVVtIj
 g9Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRnbYL4wTW0cRIOgasM3PZQRZhcbUhEKBx14YPyRCjxqa8Xp97hqkp3MbFHCveLmdHqVriLbU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyrs8ZkOZ1r8Hm4SHFiPZ122518oxq7rQGRMmpAkDi/xXkKhCxC
 pQQloFm/k+djmUg9cO5vWg8ngOBrRjS88UCGxW+jCpM7N/sshmY9Ws4MMYvyEkWx4EM=
X-Gm-Gg: ASbGncvEeROmy8TroT+kpPSNzt49+HmKFqH5unmvz8P3S1GMkJ/mwTUhtR2NaA+cFx2
 m/tXwDWJpZsvCv1qabXI95B3JYwNpVxgZVXLMHagSLWjMLo/OjmwvPYARSU4RZVemXLQgGYetiE
 0o+bgNESJfwPEKw9vuymq9ZEJHl8zBRihAkGGx96+Gbkgb+q+xFKowERqCN/PCv6MH4VwyDGw/0
 3dJ8OZNuuce/MyzjGPY5jzscayGDVBMCsTKUlToFLFDqtCCr4PxywOP/bKr+eBWRlpXb26Ri0i4
 AbXbpI198YmutUplgWLreQp7BFsftN7ZtQy7QyDXKVMK8ydYb8AlwQojSCe/9r682RqFQgCewNp
 2n+9JmS5aZjS1ISdIOhSXdWGlFwkcj3M8hx/4DHBs4ZHSoHcaK/A=
X-Google-Smtp-Source: AGHT+IEiz1+/+rYF2YHg5HgfzcNMQgXpLP3OaA6qbBWbNGNha48koz05fVAK0gz0P5xT9+TjcFXyKg==
X-Received: by 2002:a5d:588b:0:b0:3b8:d493:31f4 with SMTP id
 ffacd0b85a97d-3b91100ef86mr392133f8f.48.1754931820080; 
 Mon, 11 Aug 2025 10:03:40 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:3e73:96b1:418e:3053])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c45346asm41215266f8f.39.2025.08.11.10.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 10:03:39 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] serial: msm-geni: Fix Smatch reported issues
Date: Mon, 11 Aug 2025 18:03:38 +0100
Message-Id: <20250811-serial_msm_geni-v1-0-4499179491bc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGoimmgC/x2NUQqEMAwFryL53oIVF6pXkUXSGjWwrZKICOLdt
 93PYd7wblASJoW+ukHoZOUtZbCvCsKKaSHDU2Zo6uZdO2tN2eN3jBrHhRIbnCeHtnOt7wLkyqO
 S8YIprKWLqAdJEbvQzNf/avg8zw/Dq3fPegAAAA==
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported issues with an uninitialised variable and inconsistent
treatment of a pointer that had a NULL check for only a small part of
its usage.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      serial: msm-geni: Detect error from get_clk_div_rate
      serial: msm-geni: No need to NULL check priv

 drivers/serial/serial_msm_geni.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)
---
base-commit: 83ce0b483c1680cb39565a9d91c6ef113a309c38
change-id: 20250811-serial_msm_geni-afd8a1984b9c

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

