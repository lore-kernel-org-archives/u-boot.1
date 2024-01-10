Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F12C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 05:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 966678784B;
	Wed, 10 Jan 2024 06:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="tdW059v0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5FBD878C8; Wed, 10 Jan 2024 06:05:01 +0100 (CET)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65127877FD
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 06:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3eiWeZQcKBnEbdgXioUVddVaT.Rdbj-QddiaXhih.STcm.ST@flex--moritzf.bounces.google.com
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5e9074bb7c5so52766217b3.0
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 21:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704863098; x=1705467898; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=VBjgB0cEwRCkpZHI8IW5ySXpOL+WH1a12AKJ9FO6kQU=;
 b=tdW059v0b1uWz7W9HvyvrIHCAqzyngiYy/1QfmAIcuB6k/POTeEE9joUsBrst7hGgV
 1sNO5qBqg/cJzpgUqg2ZFLegnHX2z0+UReANOUjcjx/HLDQ9xM7igANXkhB/0e2/ccVY
 FADkI7lkjWx3oljQXhJ747i76sB7jz31eSUSmOK/kL+ATMS9kXpOCJGrsdnrLcGxL8Zt
 xc/ASa9VSadJYezSGxePrTSfWhmnnsrPVyKciPcUhXyL885KWEavIJI3jk5gun9VcYno
 ozg81pCT11hXx9xxi5I7X0L4Bva1zEjAeX1+RYWoxn4+UJtDCnKrqAOMyosf2M59BicQ
 RBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704863098; x=1705467898;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VBjgB0cEwRCkpZHI8IW5ySXpOL+WH1a12AKJ9FO6kQU=;
 b=NzUBH1nkkQ0sxxT1/F7toQZ9IVoi4mcaditfczcmy9BSVzkhy9SYXtrH4ptK05Kv/H
 dpPe/Xz98FUwxGtA0h/Ww/RncQI3mfBMaqjy2LLax9BsKHhHoTd0LNR6p0oXXpv4IOCn
 wO2PKoCnMpcjqffy3f2Nirrzgmk7Vh49ESGErV8q8+i9au8rivoHiKa8pY3T3Yvhk0u+
 RICKELjMpa62zWgqJUhYrECl7cWBBk9U6NB2iS8QPcuL9rFIWvgXPZInaxHxJ03NuYk3
 G0mDEgrOmCinLw8V17761z1gMpMF7DVHm6I2aM4++MCy3mXVO+ATq8LPfdzhibYQdeG0
 v+nw==
X-Gm-Message-State: AOJu0YxZGcZ16QqdGG4cnHIs52+C4A28OwVflMCdEQwAncZNrmgoHhGq
 3/JnuyC3EI4geetNwMZmvHqOPJZEiqghjyEoo+0=
X-Google-Smtp-Source: AGHT+IEQxHC+a9vm5OFxBSVcIyGB4ZwPoTm1Svhcs90NM3E4r88qDS6YLtbZevV1UVlOxv1n49nbUx1B7v+V
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a05:690c:b03:b0:5e3:2a36:b4d
 with SMTP id
 cj3-20020a05690c0b0300b005e32a360b4dmr215440ywb.1.1704863098231; Tue, 09 Jan
 2024 21:04:58 -0800 (PST)
Date: Wed, 10 Jan 2024 05:04:48 +0000
In-Reply-To: <20240110050448.1441657-1-moritzf@google.com>
Mime-Version: 1.0
References: <20240110050448.1441657-1-moritzf@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240110050448.1441657-2-moritzf@google.com>
Subject: [PATCH v2 RESEND 2/2] nvme: Update nvme_scan_namespace to keep trying
 on busy
From: Moritz Fischer <moritzf@google.com>
To: bmeng.cn@gmail.com, sjg@chromium.org, wenbin.song@nxp.com, 
 u-boot@lists.denx.de, trini@konsulko.com
Cc: mdf@kernel.org, patrick@blueri.se, Moritz Fischer <moritzf@google.com>
Content-Type: text/plain; charset="UTF-8"
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

A busy controller shouldn't be game-over for all controllers,
so keep trying on hitting -EBUSY.

This change brings the actual behavior of the routine in line
with what the descriptions says.

Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Moritz Fischer <moritzf@google.com>
---
 drivers/nvme/nvme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index ec45f831a3..59a139baa0 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -695,7 +695,9 @@ int nvme_scan_namespace(void)
 		if (ret) {
 			log_err("Failed to probe '%s': err=%dE\n", dev->name,
 				ret);
-			return ret;
+			/* Bail if we ran out of memory, else keep trying */
+			if (ret != -EBUSY)
+				return ret;
 		}
 	}
 
-- 
2.43.0.472.g3155946c3a-goog

