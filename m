Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBE8C369A6
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 22:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D737083E20;
	Fri, 11 Apr 2025 00:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OBY/a29z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A479983E19; Fri, 11 Apr 2025 00:16:09 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8685183E19
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 00:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2c818343646so803950fac.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744323366; x=1744928166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJ9y36pY6zxqlluTlZKbxG+hEGPeAXsCX9xpAkndi0E=;
 b=OBY/a29zXcEErjTFYPzsNGutpH0BICWekjpXx/ctqA0mdlDuL4pOM5SBgrThVbjGQS
 u8GkA/IDg1VAm+WpQb1H4FFSH5PslehhYcekl81OGx0k85wPY/yHWI3nzVT+PVtZO3L8
 WfjkuQX3dBAwJuIn4qgipDkts8I5HBpQ27Zj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744323366; x=1744928166;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJ9y36pY6zxqlluTlZKbxG+hEGPeAXsCX9xpAkndi0E=;
 b=BwlXPl+pROAXbWrweIKSVV7FiqjN48Ggm3JC4+d5arOZ6Q4F0Qiog5OJ2vcr3LAcu+
 slJAJ2ZX4M8dU9PKgSeEyfzjJyQw+4fJjRR+KDRETHgcvlf6xVC7GHAw5UFxyCE5+M8g
 pGVgFzQQQSuTUW7GeXqgULVgWSMD5wa95nXVuQhd9jtok8+bOjEtlU2zRGGyT/p3SEt8
 +U46WgGz6IeL0J25zs/aairFBYwA6MbNF2e8ikH3L8yUlxYQpfnZ8el1ODJPfh6ooTA2
 dh4TaYu3XvP4dAldxAtxjZDBJbc1GekuAiRAkfgeUOdew2oZAJqj7mxXYnzJasTI6Xut
 +gEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu4Q5EmGBYoZBUhjm6DzNgoW9gdTRUaw+WKHYnrB5L7nSInF9hOlqOFvjFiZv0paK2oHAMaN8=@lists.denx.de
X-Gm-Message-State: AOJu0YwsByjmRUwIKdY6aHvHD+jGB8sFd0aaYfiXcotZlQieuI9iKsL4
 0ORn9g9CdxwNAsa6MmXAP4VdS31zqLZigniLViUg70BEZs+oWg+RRo8qLmtsmjM=
X-Gm-Gg: ASbGnctw9GHxZYRGXmIYnfeePZjMYg8Y0YU34dCrB9GqAyIXq3dKgPOxnLY/sWMSMaj
 75v8z+PpTb36FTkSKNJY2BqmEx2ZFpQBEWIe76olnGFlAyXfUHKXmRuPhnttOVduN+UgrJPTrsk
 hiaMIhbPai4f8gOKET3gQ/qa0bn5/uXLLNsK7HUO99pYErMYbvbZREWsNJoUExshzIF0pDtlVnq
 dXH3RVlyM9Lch7/EBdf3X3FgfWR6vFf4hBKHbTrRLtI/aRByHqy2ZHGcq8GbN5FVWKTsJ/SNuKP
 MArRsiPF5rSkkZymd4oNlVuclpv+VyLLu78CNuZ2xaL8tjnM5w+zqvWVPzao2GHNWr4zZLR5+J1
 6
X-Google-Smtp-Source: AGHT+IH3QjsyNOuA1k+hsLr9lOLqnAj9Mj+zd+9JYe/rAuJTN3+Ou9ijz0EpeejlEHKiRaR0+Mq/nw==
X-Received: by 2002:a05:6870:6e16:b0:2c1:461f:309a with SMTP id
 586e51a60fabf-2d0d5c070b1mr276254fac.8.1744323366304; 
 Thu, 10 Apr 2025 15:16:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096961127sm838499fac.20.2025.04.10.15.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 15:16:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
In-Reply-To: <20250326-scsi-sync-on-write-v2-0-12ab05bd464b@linaro.org>
References: <20250326-scsi-sync-on-write-v2-0-12ab05bd464b@linaro.org>
Subject: Re: [PATCH v2 0/3] scsi: ensure writes are flushed to disk
Message-Id: <174432336489.3115550.15247349264780307435.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 16:16:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 26 Mar 2025 13:24:07 +0100, Caleb Connolly wrote:

> SCSI devices like UFS may maintain their own cache to speed up writes,
> however this is lost on board reset (and may be lost on device removal
> or reset by OS drivers).
> 
> Currently this can be worked around by "waiting for a while" after
> writing data to disk, but of course this is not an acceptable solution.
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] scsi: fix typo in setup_read_ext()
      commit: 0cd3c1e7d0201cf9e4dbcac1e0179604f4461062
[2/3] scsi: sync cache on write
      commit: ffe4e6ab42d2534302be825e49a2d085acf80f30
[3/3] ata: ahci: implement SCSI_SYNC_CACHE
      commit: 77c13f30b67c1a30b33b4dd4820c5a2528c3a3bb
-- 
Tom


