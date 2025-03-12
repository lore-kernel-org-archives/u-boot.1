Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7313EC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 102A481898;
	Wed, 12 Mar 2025 19:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mzioN1sD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD63481BEE; Wed, 12 Mar 2025 19:23:22 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF9EB8141D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso119824a12.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803800; x=1742408600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v7cvREAqBjxEsD3XA0VU/Fab3imYDnhnUb5281qGwPw=;
 b=mzioN1sDFtYX+fAPf6DlNggiuc5o6YavfQAYvH9Hb6/dc3dQP2LBFAUrAKvNmmhNxZ
 uDqxUjXlmopdIjP6e3iLukb2lLW+ymF8y1VXg63IRMKyINFkStHbwIsJSCPwusCR8oXB
 GGQLpyIyjTWLrrSll6zO7O/MCL0So+pw/aU+2iGSPvwa9DrxkdAUiVC70+uHteTfsLNe
 GPaAGwCm+rdTtGQ3JRnbxRbQ+QIkE1bs+QBsU3E2RIZ9ogMr9ehXr6fDYky6C/P1D4Wl
 JW92RUn4rHqwtAS0qog73kJ+CD5/nq2rPp7qykuQ0YJyGer5FUVMXGrKKfeJswM0PQLB
 AeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803800; x=1742408600;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v7cvREAqBjxEsD3XA0VU/Fab3imYDnhnUb5281qGwPw=;
 b=siXJavHmyi598vJ8A6NO8Fy4WUy1UK5+EOYkfWyG/Y50tMl9bUB/Ks5wYiD+X4i+fx
 pSjUs1Vlk0SHtDifhn7M6bx3kucNpSoPJAf6/6bbdQlvWtEm5sxw5zm5acoXrVrrw7au
 g+NmazMAZUiMjw2PHvJTAkFtSMPY33gOy1yxngtR1w0DmpAZPbNsneauuM9Hr7HvgPmX
 1gY2pzVmMla2FWBpC3z357OpoZ/Q4PmEY4tAas7zJFUvYnVly5nbvUrkTYRz/NRkk2oK
 4OhU+Nt1gl+ApfO3FgSQmBn/I7sKcCgI51peY/PIS/E1jWnaLbzQOgplOiLlAhiqH9Wz
 b0CQ==
X-Gm-Message-State: AOJu0YyG1fHYWiA9w5RxPNlkemlqB9V1q09uSUQo7pEl5PpADxnrvszD
 QEFmnJK3dMPC6iO7zX+IyXD8ni72O3zsYNwXsi+6NEBLjNGvT0ri
X-Gm-Gg: ASbGnctKKPnMfZ++UEcyONLyt+vpYWi0dXg/PrPlEK5VrJK+fo4ozr/6S9HG0vB37Bb
 kxmyqS3999Jogevb/XZXoSuzQ+6Jc3IkCTMijn4P50ZG/BIYGavOVdvU5K/sU+lTi4ehTHvJ2wp
 lRC459A/wdsVJYjz4tCTqnJJ7t6xP3YVK0A6qJf+KK9dMd24apS1GDUqvOPJghdVxSJm8H3QPBn
 ifFa7FNFNC8RxnVaE/FyP0p06z79XF3ekyqOAGo8NLv2cLhxLiChPA0xHoWMencwJ5Eyhwjd+nA
 GPhCUDmDOZf1G/IENXPZuqKculxAFKY2Og8WHG1jvAP5Gtc=
X-Google-Smtp-Source: AGHT+IG7a97uPR/4+PGxE1qHbbRXga00OEcHlizE7H0+CMl0XlfopNNs1UikedSASvpHK5T8/apjiA==
X-Received: by 2002:a50:858d:0:b0:5e6:134e:2321 with SMTP id
 4fb4d7f45d1cf-5e6134e63ecmr20067697a12.11.1741803800166; 
 Wed, 12 Mar 2025 11:23:20 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c7669ff1sm9851674a12.53.2025.03.12.11.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:23:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/3] video: backlight: lm3533: improve configurability of
 device
Date: Wed, 12 Mar 2025 20:20:11 +0200
Message-ID: <20250312182014.121568-1-clamor95@gmail.com>
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

Improve configurability of LM3533 mfd, especially backlight which now can
be flexibly adjusted via device tree.

Svyatoslav Ryhel (3):
  video: backlight: lm3533: add more flexibility with device tree
  video: backlight: lm3533: configure core in the probe
  video: backlight: lm3533: set up backlight according to device tree

 drivers/video/lm3533_backlight.c | 142 ++++++++++++++++++++++++-------
 1 file changed, 112 insertions(+), 30 deletions(-)

-- 
2.43.0

