Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9038AC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 292AA836CE;
	Thu, 24 Jul 2025 11:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B2b18EQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E0AD83826; Thu, 24 Jul 2025 11:03:04 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC2D83666
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4563bc166a5so4664655e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753347781; x=1753952581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SHqTQ9LcUnHgVlRlaZcj3lSq7If1i46b9dgiIeEVS0w=;
 b=B2b18EQi5RhsKs2swvoyh15TiGEsYXtJme5wxXYItLrLpmhRYyD7qC+wk3YYT0xg4H
 ZWZt9NyoGWmnfZdKY1YZ9fP0fcXlhUm1KH9pZvktoIrucp4/raMbb9+0OzjcCdygRBmL
 DRq54aZSkZHYpyJ0QB5obEYK7YzaqHpEhRnq79FZbRzzHmVCOIoe4h1s/kG8ZnPVxT+A
 d/Xlmx+6WC50lTOnyVQWGNGTSGxXw5gxwa/nfNwZR0w4wVab3Ip3GWIb9iK9JLTdsRjP
 u3rpgtDbEdHPy5TmedTQWGOaZRI4il4YnItmvpjXtkc9WuXCbfzTI4Zn7yunG14pb9EU
 56hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347781; x=1753952581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SHqTQ9LcUnHgVlRlaZcj3lSq7If1i46b9dgiIeEVS0w=;
 b=wCDOnN1MiKnsYr+CzIqo66CoSvnM7ITAD4hP3Xhu8nskWEOWVwmbeQessGxAvZjtVy
 kkcf4WgYzy9L7A9fgzLqNpJ/RG9TFk38+bx229JhguoY8/sNTdOHAr4ucdWkIHMqOBrT
 SuWm3BtNfVxG90qtBw6Xz9E8f3iNlyOj+TVh+HcnsWbZXDFJkC5D0IGnga3WER4+S6PI
 phAGjQXU/l4StBTQa7E/jxWUZ4EaCGh+pqSfJAO/+TGsKvF3aaMYf+aNr7jnqTQb8CTP
 L8T9EX+i02QdyjaYfGlAxIhX59ELSv9G5X1ZZ2qFQRe+/iDMgxUXyWlv0ZZv6go/WaL1
 kaaw==
X-Gm-Message-State: AOJu0YzOomRL4TjbDTVX5g14uqFl5u5VBhnnqGh7MSFs2vt2DPmgsbGi
 ePV2JRX/MyZgU3iJ+fBq23CqlR/yjBNuI5Zula2MJbG68Q0dUEcc094PCkzwOFx2iRLy6qezvU3
 BWg4M/tPNFw==
X-Gm-Gg: ASbGncuiFzRrBTFPaTtSOV32AkMpPqfdPMhMwbnx/bwv/Xb2D7BdDBtg6fc4kPY3yg5
 JY+KESCgEBGYN+KHPzMfu1lHIGXnzQQz4fBGsuKG+odoOVS/ifzbzD+bQuatsut75C/qTcZLHWe
 LioCTFXEk5E+QJv1L684vUUDV9A4MZApFoKXQt24fH5c2nVS77FeaWPz3Tg91IDe11l/JnNnqfp
 HDkYymKye+TrAGxKOnVo6fXMqFJ8VSLaJAeYV+pNW5tBYzUDIn4JCylYEebOzlv8VdYSeUSiKe1
 oa/J3BJ7d/YURDQOnvRPf31et+TilCUOyS8DoMcUKWlzw1/43H5MUfLzVY6RggeFipP4qLQkNED
 Wz9UDmIg1njz1DdofzOKOG/eLe+RBzA==
X-Google-Smtp-Source: AGHT+IEJxLW1qWXJDUmwHtGz56IQ8nudFucnvWuuTSQSC9GQdoYiiY8tHpiNAcx5LYfMni4/HZ/nmg==
X-Received: by 2002:a05:600d:19:b0:456:1d06:f37d with SMTP id
 5b1f17b1804b1-4587058a757mr11294065e9.16.1753347780144; 
 Thu, 24 Jul 2025 02:03:00 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bcf7:2df7:a82:bef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870577af8sm11958715e9.32.2025.07.24.02.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 02:02:59 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/2] bintool fixes
Date: Thu, 24 Jul 2025 11:02:34 +0200
Message-ID: <20250724090247.59221-1-jerome.forissier@linaro.org>
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

Two small fixes for binman (bintool). The first patch avoids a warning,
the second one makes sure the APT package list is up-to-date when
running apt_install(). That one fixes a CI issue I encountered.

Changes in v2:
- Use apt-get instead of apt

Jerome Forissier (2):
  binman: bintool: use apt-get instead of apt
  binman: bintool: run 'apt-get update -y' on first invocation of
    apt_install()

 tools/binman/bintool.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.43.0

base-commit: 3532f1f5edfc97c9dcea723cdeb732eda44bc669
branch: bintool-apt-fixes
