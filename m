Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38948C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 14:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E2D80805;
	Fri,  7 Feb 2025 15:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CCY4Fr3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE74E806FB; Fri,  7 Feb 2025 04:48:08 +0100 (CET)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92637801DE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 04:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonathanbaror@gmail.com
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4affbb7ef2dso1116569137.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 19:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738900085; x=1739504885; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1jpz1i8MfVeSxQCQMCLpXCitQ/I+b6gU8cvxWEfEisE=;
 b=CCY4Fr3qRYdXfc3y9JCj5sP791PoAqP93wHxjccXglZ7xBoVqxQa8ePTcytkdtfaKJ
 0pQlzZ7NohmmciiTjhbMV3PugaBsMCS9iTPpdQ6ZKXzAJZNTDYROj0wqtD8uEpLVk3ek
 QbP9YXB/CNM90XASWqViyixB+X+zW5GDz5oh/BuuFuBSQsOC/B0kwWTLLFbdHZVFvsBw
 ZtGSB1jYiSmpv37SFqU3umhwi/z8DtveTgFU2HTbcKoysrDVRDNaOkx7vz7ttP+Gxgwj
 NO6bDnzcK1rjgtyuMswC4e9Lpj5gZjf3j874cqTKaVXj86jkLkx6+Kq59iD3s323S7b9
 0iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738900085; x=1739504885;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1jpz1i8MfVeSxQCQMCLpXCitQ/I+b6gU8cvxWEfEisE=;
 b=pO2c7WvTd8IChVe0iwbTjPKrcML3Nk7/GXNxYYkB3wlDlG/zLekf9mLvMd7GARlqOF
 Z0I/JVp9L9hOlzzlx5YI2rRPyABrFXDbqeQfZdNRokcNX4//2HY0v9LaiWg5v/6aI1cK
 MOOlMO6/JpbRmBUtIdzbZsKoWs3YJGkjnpDQwKiN+bthiY3ce/+xwoKOKUL7Bq8O6rph
 ALtqWfSBHybAvOgoEyGn7tasND9Sej2PCLYu8qz/1EojqNQH6wZBnfWHxxzCAQQWBPoA
 AVvo6/t4hcrIk8u7PXs+Jm6StDwjCn7B8sNcKaR28d+YSCOptBTDFdtpGXiYAqPbRRwN
 BsZA==
X-Gm-Message-State: AOJu0YxGLJmjIxHvAFlnJjgcVaiZXVUIaqMyqnwbIvFRBINqxM/1kuF6
 Zoj5RV5+eJLH04Ldd19mYvB568kJNRwRIG4DWy7cyVCBPUeYrl/ZcCwCLPmquAIO6wZUkbgmYd9
 hhL3NyT8+5pIlWV6mmSsrzGdPKz73+NlYl90=
X-Gm-Gg: ASbGncsA56E6cE2AMj2nTWYtHh5vz1GUmYzxKxu+yJcsq7nRY8tU0BTUY2cppnGHf21
 YkyiFTqEKemeWJz5u8Nt4LhGr1X7tW/InMIpyly74ZwfdmP1lssOpBnyYPSVP/StghMk+R3s+9J
 DD4DmsiXe62KeqWErRBi70AJrHPwkO
X-Google-Smtp-Source: AGHT+IFoFsmuv+UkiDNN6U69hhhdvVoCKiZo6P/lDzIPOtPux4OBinx5bz7YtZ7RU+s/r7/cISMiTalyZoogf0ajx/E=
X-Received: by 2002:a05:6102:2d08:b0:4b9:bd43:97a0 with SMTP id
 ada2fe7eead31-4ba85efdf4bmr1358805137.24.1738900085268; Thu, 06 Feb 2025
 19:48:05 -0800 (PST)
MIME-Version: 1.0
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Thu, 6 Feb 2025 19:47:54 -0800
X-Gm-Features: AWEUYZlTJEbv1KOf8hldJsijv4BXMmEcb-oijni_n_1LDTabiqJSQS9tEUo7Jyg
Message-ID: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
Subject: Security vulnerabilities report to Das-U-Boot
To: u-boot@lists.denx.de, trini@konsulko.com
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:27:24 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear U-boot maintainers,

What is the best way of reporting security vulnerabilities (memory
corruption issues) to Das-U-Boot? Is there a PGP key I should be using?
I have 4 issues that I think are worth fixing (with very easy fixes).

Best regards,
            Jonathan
