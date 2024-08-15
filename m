Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18C9C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35AA688B12;
	Thu, 15 Aug 2024 22:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gsjka2jb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88D1088B49; Thu, 15 Aug 2024 22:30:33 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 254B488B23
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5da6865312eso829137eaf.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753826; x=1724358626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w5mK5iCn5s3A0VjB12P3XY7NGJJ5FNsIhGGHew80QoQ=;
 b=gsjka2jb7+Wz2NoqCvCVBI+UtNevGQ8hZestjLvb6cURS3ho56MeoWF/t8KNf5BXk8
 QB3fkyx7vpDwteUCdmGtI8xFUXnAvFwpyVv9rlqlVOcD54kFu0NVh7LSmIg/uXhovVOW
 ZksNddZFZmmZ78ryJ90ddG/3q1UyQQtSwcQMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753826; x=1724358626;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w5mK5iCn5s3A0VjB12P3XY7NGJJ5FNsIhGGHew80QoQ=;
 b=FbbGHMTR04wsOS/1IRf0PYUnKbmQTFJedst69shu6pQ6loJ4W8yON4mg+qTQbkrEuG
 MMaIDVueT6iaFIADG6IzvWCevzjajWdN21K++wMHO5a6mRIdenDD49zD5F2HB35fL6d1
 kNIBXaNGRMB32Jv3zMX2pgWgcS0iAWqQRigB5LKiAkO02+Z/TzU421PRwfxDggzIvrhk
 yVB7rj4XJpz4LXwFqeS6YOfqsKpv+xPdDI5VzMHVWoNUq1/BE+IhRjl226BwQVyqYqB+
 GCpqCXaOmhlhTp6lO7JZdgkHCVcQAfSMZWS27OUVKEKKDeSZN4lPADmKyQv/DOyCcrbH
 PDkA==
X-Gm-Message-State: AOJu0YwsXjY7Obah4ojPOGBBrQn3Cvy3fIlSD9ZvPzmZp6RtAyFWcZH5
 9EGUHskKhIZJ9jsXeCjady/sJlnz9rQe5K2i/6YqIt7XiEXSSOhHqtCk3x17QgchXgApBK9xw8R
 YEg==
X-Google-Smtp-Source: AGHT+IEANUofBSLdlts25xAc27ARLsOV+kJ4GiU1pr8Lrbz0L/AdFyVofja3+L6ChazLnPHa6PLLSw==
X-Received: by 2002:a05:6820:2228:b0:5ba:ec8b:44b5 with SMTP id
 006d021491bc7-5da9800d2e4mr1258241eaf.3.1723753825985; 
 Thu, 15 Aug 2024 13:30:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ccd6f3db48sm711114173.106.2024.08.15.13.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:30:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v4 0/2] bootstd: Try again to resolve infinite-loop bug
Date: Thu, 15 Aug 2024 14:30:20 -0600
Message-Id: <20240815203022.771615-1-sjg@chromium.org>
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

This little series tries to resolve a problem found with an earlier
fix.

Changes in v4:
- Split bootstd patches into a separate series

Changes in v3:
- Update commit message to describe how the problem will be addressed
- Fix 'virtual' typo

Changes in v2:
 - Add many new patches to resolve all the outstanding test issues

Simon Glass (2):
  Revert "bootdev: avoid infinite probe loop"
  bootstd: Make bootdev_next_prio() continue after failure

 boot/bootdev-uclass.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

-- 
2.34.1

