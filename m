Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF14AC77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 15:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CDBD82D17;
	Tue, 24 Jun 2025 17:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VohCR4IE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC17482D5E; Tue, 24 Jun 2025 17:35:11 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EB782C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 17:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DCC683F27F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 15:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1750779306;
 bh=0IhCOuAdLYyEAQ82nzEQtYEA0mHESctUhoQkI2qet4Q=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=VohCR4IEBMcKOBmZ13e7aoVUaqDYNXtruRyId5hzBh5PVNCCv2c8mJuPat/dzGCx3
 6lCuKYloUZ3nnev2Yptq/8QE0IC/qotp9MjkNq32YzIw+uTh214FGbH8jJ20aR/t1C
 3RxC8XZ3fhK77VHGcsDhQDvHnscPec9bTB1UulkSDaaBDGaFWlfpJBujU1RrWg+Bqv
 Oqf0WUSzSCNz1L69r6dc/luo6tt3PLBT6D89UH66yXOqx0msBFmyLJdSaIrZ0/BIUU
 KNAoL+a0ZyhJ7VFPjPx8r3ANgS52HI3oiZscZ/xH1o5BtTBtpVMm6nOfSSDaSqlRbh
 JJfbKiYEFLhpw==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso3465257f8f.1
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 08:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750779306; x=1751384106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0IhCOuAdLYyEAQ82nzEQtYEA0mHESctUhoQkI2qet4Q=;
 b=V9qqNiGjFj5UYc4GCpzkmYU3A/wxUc15DpcakUx7OigZn5FyF/zsllkN3PqWz/2kcU
 DV1vInN6+kyVUURyPQ2gz7/0MH9E66sN/anpMD+1qWx2BqIgDxO3EgqzwOXvds4x6low
 wcKpcMNtcR4PaH7ORDwoE9TK8/tUqtgm7TPf4T2PkYPHKAcY3S486TWe4M56veU5v8R7
 +cUouu2sDBjcX5Npp1ZuIBgAxXfL9SLnHemasUMY6/hOLWfNpZc1xVDEwZQug3XL1+81
 0EJsI4V+FIzCP5cDhntQ7fEBjlDn9yX4VVtE9/dUBQ8UBc1hcAx1c7fZ7fwIVMGqnat9
 8w0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCURA8b6BBS8kiK59GP40PSSmB1KiZVi4XKZeVam/0msd1fjM1oSUB4boVgkQWzfv8stklmaWkE=@lists.denx.de
X-Gm-Message-State: AOJu0YxGN4d9SbJYOffXvFbZgJ3KmrRSHmybGvF3nAsFrQMBGdiyL8a3
 qRZqfks1bkXRX7tcsFcddTfm9EMmdG/rplXUtorfNFMDyWoTyvFsNgCERfHO45b8Yqr+2szEWK9
 Z8CfUjN5IPE/dvkNnFoLXvOtM/o0c6NAj5nWX2B+kB7rBNSh0zn+U63/zIDvlMq0ltLwFks0=
X-Gm-Gg: ASbGncs/Yh5vFyH/zVBq6M3eSCi76IUx8D3jPT0mTa1FOAE8zTYYoNzuy/XRFwPDlF4
 +tLJ+Nf6zAo1QPAlXphg7ODcVh0Yfvqciqbbalky1yTK3cspY+8EZ/ElJi4Eg2DjDfXt+5jGwFe
 4UcEXYKdcZo8SGf2YEoLAuEXO7QgKP8DlQ05UV3X9YVob7wbcTL4x8sFg7nn90WLPwT++QNp2T3
 CsyqgVrEazEczSUqAYQH8MjZel9f4WSqpCGtuacFCDkBGqPRa5dkJlIHPG5dW7F7f+UTz/JlSkw
 0oEWcBzbF7HCCdm29cfcxJ/YylbX/NvEyVErkUdUuqpYIOxtNbUqExef
X-Received: by 2002:a05:6000:310e:b0:3a4:d31e:4af3 with SMTP id
 ffacd0b85a97d-3a6d1307038mr14158836f8f.37.1750779306461; 
 Tue, 24 Jun 2025 08:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM7c1ZRjsFkdnlXUIZfaXlo9FyfIDHmOWeSmX0sMHN+uvYW8uUhuIrbXOOOgpEMn9JRQHM+A==
X-Received: by 2002:a05:6000:310e:b0:3a4:d31e:4af3 with SMTP id
 ffacd0b85a97d-3a6d1307038mr14158817f8f.37.1750779306083; 
 Tue, 24 Jun 2025 08:35:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:6e0:9801:7335:789f:7f15:8b3b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8113b00sm2277019f8f.96.2025.06.24.08.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 08:35:05 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Sam Edwards <cfsworks@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] spl: fix error handling in spl_fit_get_image_name()
Date: Tue, 24 Jun 2025 17:34:29 +0200
Message-ID: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

spl_fit_get_image_name() used to lack a detection of malformed image name
properties in FIT images. The change in commit 3704b888a4ca ("common/spl:
fix potential out of buffer access in spl_fit_get_image_name function")
tried to fix this  but led to function spl_fit_get_image_name() no longer
detecting if a property at index > 1 does not exist.

This patch is reverted.

An explicit check for malformed image name properties is introduced.

Cf.
[BUG] [PATCH v5 1/3] common/spl: fix potential out of buffer access in
spl_fit_get_image_name function
https://lore.kernel.org/u-boot/38f5d078-3328-4bdb-9c95-4fb5fe89ddc2@gmx.de/T/#u

Heinrich Schuchardt (2):
  common/spl: Revert fix potential out of buffer access in
    spl_fit_get_image_name function
  common/spl: guard against buffer overflow in spl_fit_get_image_name()

 common/spl/spl_fit.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.48.1

