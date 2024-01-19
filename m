Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E00BC47422
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 00:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B253087B89;
	Fri, 19 Jan 2024 01:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FP1SiQAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3436687B89; Fri, 19 Jan 2024 01:47:50 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E302876C8
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 01:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-29026523507so287246a91.0
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 16:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705625265; x=1706230065; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JiTY+v26P5IFOjmyDJ9mQlv29CycynZfR50VMsGIMhw=;
 b=FP1SiQAPh80nkN4D0UVewnBAI4Y3U9iea0kwhLIrrE7vWX0PBAC0xw7LM8OpNxGGP1
 aoVI3VYChGWCHSh3c67KfxXHfDZkRc14cVoJt3Wn1AcyFIxvkm3O2BNmWFvydQLvAszO
 J2j/Q8jFhrIqOP87zkmFkXOzvNfFrTsbxY2ikbIFB0Ag96saVb7ayGpD4lay7a6eGBt0
 i+94nREqx0sz3fQoX1NDNFrDBDH5sY4XlJpBIl4+Fr3UARB5sSZpvfzG3W9804aX2UyO
 KHhxhia9P/mKulsiK8EJHqZ70EPFRNw0TIysyBrLjUrVwv99uH3UYFuR7xgGqfDEgPce
 oUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705625265; x=1706230065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JiTY+v26P5IFOjmyDJ9mQlv29CycynZfR50VMsGIMhw=;
 b=pSoJNCdgTPAe86sqYl1h9tGsJBg8qtJADMZ6yrNyuELf3IdrPh5IVzws/jh4XVyPy7
 wuomemc61j+tK4wNW39WGRUB4y0za+JJEjnFWwXYmGWhgLFM99dbUiD+9fmpcRrAfAeO
 TjPElErFsVapBtD6SP22fXtDg7AJRb1zBB3H28iHhJbpwceqPZ34eiU4oJaLp6cuIS8O
 eyWXAOKWg1vPWOMzCGmkTPY7Z7H0a1vwL1xp5XxyNFxGpOHNMZwP0+7K1JD1UWX3xcZ5
 ilOLD0h1FEHDmpl1rwGrXFBQFCEZHZbB5d0Jv7m9bFhs1+et2iUydN2So1vPe5+pTIhm
 0Jkw==
X-Gm-Message-State: AOJu0Yz4Bt/0PPAa4xBxrYg4xOENZYJjFdEURAccK2pGYxtduz1NDdYL
 ZyBy4Hn9pZykhFKiODuoD9wctnK2oh61gchVVb+sr/uyZuS+jPeLQuFs6u3SVajFZRtEhMSYNId
 8
X-Google-Smtp-Source: AGHT+IEzAxS2N6ws4i3XB5p6cT7wHvDRJUKfIBq5eYduCWNRtVfRNRAL9rcVv7KlVPG8ZkJLolYZ9A==
X-Received: by 2002:a17:90a:348b:b0:28c:d0ab:adf0 with SMTP id
 p11-20020a17090a348b00b0028cd0abadf0mr1430589pjb.96.1705625264810; 
 Thu, 18 Jan 2024 16:47:44 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 sz14-20020a17090b2d4e00b0028db69af4a4sm2513515pjb.4.2024.01.18.16.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 16:47:44 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 0/3] fix and refactoring of efi_disk.c
Date: Fri, 19 Jan 2024 09:45:43 +0900
Message-Id: <20240119004546.1084018-1-masahisa.kojima@linaro.org>
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

This series fixes the memory leak issue in lib/efi_loader/efi_disk.c
and refactor the efi_disk_remove() implementation.

[Changelog]
v2 -> v3
- remove unnecessary NULL check

v1 -> v2
- remove already merged patch
- remove container_of() calls
- add TODO comments
- return immediately in UCLASS_EFI_LOADER removal

Masahisa Kojima (3):
  efi_loader: avoid pointer access after calling efi_delete_handle
  efi_loader: create common function to free struct efi_disk_obj
  efi_loader: return immediately in UCLASS_EFI_LOADER removal

 lib/efi_loader/efi_disk.c | 52 ++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 14 deletions(-)

-- 
2.34.1

