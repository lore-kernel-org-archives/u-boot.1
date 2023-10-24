Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF81FC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B98587985;
	Tue, 24 Oct 2023 20:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZaF5ieyw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCAE587985; Tue, 24 Oct 2023 20:18:39 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967138748C
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c9de3f66e5so30361055ad.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698171514; x=1698776314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dfRMPoL8zpCeXrh4fraZAayuYOV1RgkzyrvD0b5AGfg=;
 b=ZaF5ieyweJG1dKv/wwb0BON/OwBxda2wk7s6+Rj3xs3l/8norVszvqKf8V32cg0iRI
 XppQhIn2koHMzXkfR8ufpCnSlzl/bJtJIYfHzA5bpSOJN1yz5Wi39ym10U8o+wik0MtW
 hiS1ZF/ChXiFQr2G2eQWnq+pihDzC1mOipiPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698171514; x=1698776314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dfRMPoL8zpCeXrh4fraZAayuYOV1RgkzyrvD0b5AGfg=;
 b=YQaYON6Wn/HiHouzQKvzBFtwSz7LKzI9DVpG5FGrvFBb9anLr138YtMzdBITWWTJUM
 YIjE8JRYO7xrjBWl91kYhArNqlUlLuDPqVP9zy4s+eWmqhotDgdgC1/GeM6+ZbLyBtMy
 g7pvwSbqzu3DAekq+yR+57pk/y1YujmmfKw9cl7vZryxQ5jdtlFZY49ev43wmWRylE7m
 2C8AjBFRIMeOGIl5sS7GyZnDEl0R/IgQFVX2VZSO6IxOqvSkA3cJeZaB0tEvOtyhoLsn
 ylY3z1maJCDrO6GFnAaJ3aFfqbI3VKrM7snATvYuAkjZMqDHu41cvxg4nAcT8oqNYFN9
 tQ6g==
X-Gm-Message-State: AOJu0YzGBBnvoXMS77BHAHn6wxkXN3HoZIKyTcGzeohTI+hFUy7pjuAW
 1y84MdgDVI0poSgVuHWzPjzOJ0dj4tVuAtZI/OJRdw==
X-Google-Smtp-Source: AGHT+IGvk8I0/NgQ7i5FzZWxTCvV3kjsYhTzfAmRVHGd/zg6PuCI2KRqRVo05CWZ8KdjwEN37x1pug==
X-Received: by 2002:a17:902:ab52:b0:1c9:d61a:f4a4 with SMTP id
 ij18-20020a170902ab5200b001c9d61af4a4mr9029829plb.60.1698171513861; 
 Tue, 24 Oct 2023 11:18:33 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c62c9d7289sm7718691pld.104.2023.10.24.11.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 11:18:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/2] bootstd: Fix a few minor bugs
Date: Wed, 25 Oct 2023 07:17:35 +1300
Message-ID: <20231024181740.1938934-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
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

This series fixes a few bugs noticed recently:
- handling of certain command-line updates with 'bootflow cmdline'
- support for 'bootflow read' in ChromeOS


Simon Glass (2):
  bootstd: Handle a few special cases in cmdline_set_arg()
  bootstd: cros: Correct condition for read method

 boot/bootflow.c      |  5 +++--
 boot/bootmeth_cros.c |  8 ++++----
 test/boot/bootflow.c | 20 ++++++++++++++++++++
 3 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.42.0.758.gaed0368e0e-goog

