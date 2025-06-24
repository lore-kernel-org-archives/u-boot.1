Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CB4C7EE30
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 14:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C136B82C2F;
	Tue, 24 Jun 2025 16:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="l9PayQ4W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 767B382C4C; Tue, 24 Jun 2025 16:51:33 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DBF682BCD
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 16:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EC64C3F57C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 14:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1750776689;
 bh=0IhCOuAdLYyEAQ82nzEQtYEA0mHESctUhoQkI2qet4Q=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=l9PayQ4WHsPIP94NM0fxys5+Jk/KkcOhtk3thT00dp9NB6EeUUQ0doZlXh/67zDTE
 gielMn+zQXXgV+WOr44uuR5xZMJQ3iYVyJazu4yN8VimApMzPrLwzTsS/YyJxuxzd8
 vtLhYamTjsKCG+LzuBMb4c3RIfxnjLahAscket3eno/qok0It3a4KxVWpyjgaGTNDq
 q87kYHREE0jkeN7NhR6wHIVT27WmKol92mE64u7NJggzIZ1AO8COYWxe0rRxY8XNbG
 dKJxUsW0xTbwIPfTGaHFqq0j+Rwef1teSW+qv4dJW0VjZJPr6dLafaDB6om86ricvf
 tAYQV4gryBoSw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a6d1394b07so326215f8f.3
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 07:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750776689; x=1751381489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0IhCOuAdLYyEAQ82nzEQtYEA0mHESctUhoQkI2qet4Q=;
 b=NMmd8anZgDvoNLiefatzFGHB/y4tbwNj39KfcDb6UBtPIqMsGCM19UGYaCvN1BONn2
 RRWNLxRw7N6/xBJqbcimGU4ZMSWUOm2W0r/p3K9gB2jb+YDObUtWzYjRXK94JSVkN1jd
 jt5wLGu8rFUxOkwmun/DgaT9S+BKVO2PWS17mO3cIdQFo2Ii5m5+1cOih7LFyw5wEHqI
 gMo0TO4I4EyTPEICUF7cxgZGQIROTsjiMKZ4ip+kccuVQv3lH9TMNULTL0vd2YDBD5Dx
 PKbb55GzzrpgMtLTmPjEudkhfthxWU3JmfekhaokT6Aa+WPTWEA8rIv2PuLLo5WO9y34
 BEzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7OagnqC6hrxPevpjRn9AA+JHlQ1ZMIiesIUSbD1Cx6JEnCoNP/xOd64Xs+2g8iKIlXYlc5ww=@lists.denx.de
X-Gm-Message-State: AOJu0YyQPuI2oQaBj1KkT9XTUuBcqRElCTUK6uVpxKW4Q6pd+tq23Hch
 n58PXL/LApRO2k+9EJvrlbRDaV1zEEdBtesPI+SzsqSglPlWaDgqYkTYAiLvPPNcaupXc1U252u
 WCgRydi6xyX2sVWLtGtY10RIIsCiGVnxp1p5d1J910Na8fyBLzRy3dEzUtc7cTuI+/ZbLUjQ=
X-Gm-Gg: ASbGncsB0zW2t77VpY0wWLgjhyIG+9DhDSHEP4l1bhX6clFFfwgXF+tVtRFc/pquc3J
 txIP6DFvNMkGLf2+uRIzV/ww7xF2c3tmEXrVeXO0QfAlzyfq/Bpay2nkABIDBhkk0KaoXU9S3rT
 Uz6FYfdQa8eab9pcL4UjooL95cA/Tj66KW52QVo58t03f99rHNIhtExn0wen3mUyajZC+INhMfQ
 G2e/hxiFnMyR5ULgKzKRWksvooB/rRGVPAHKnRE7lPYIYVzWr2dM+yKLX2JnA2GqlThThfqs3ib
 LLWRGCzuOH3VIjwnVz71BOwAyQPQB8GuYgvFAIfVgRxqBRLS7hR+o2Sc
X-Received: by 2002:a05:6000:288c:b0:3a5:300d:5e17 with SMTP id
 ffacd0b85a97d-3a6d12fc0acmr14282429f8f.29.1750776689330; 
 Tue, 24 Jun 2025 07:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbXjzEvOsYFeMW8NJRbbmSvpUDvx4svc4eExDY5BCQCGeo8uEVZxsWvootrUur+DX02J4Mbg==
X-Received: by 2002:a05:6000:288c:b0:3a5:300d:5e17 with SMTP id
 ffacd0b85a97d-3a6d12fc0acmr14282408f8f.29.1750776688900; 
 Tue, 24 Jun 2025 07:51:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:6e0:9801:7335:789f:7f15:8b3b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80f2977sm2195266f8f.63.2025.06.24.07.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 07:51:28 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Sam Edwards <cfsworks@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] spl: fix error handling in spl_fit_get_image_name()
Date: Tue, 24 Jun 2025 16:51:13 +0200
Message-ID: <20250624145115.43684-1-heinrich.schuchardt@canonical.com>
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

