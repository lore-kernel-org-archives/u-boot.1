Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486F2C48BC4
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 00:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86C0B87EE3;
	Mon, 19 Feb 2024 01:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dOCSZAyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6476387971; Mon, 19 Feb 2024 01:00:20 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9230987EB9
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 00:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41262e0475bso4840045e9.3
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 15:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708300785; x=1708905585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09L+fqwxbcHLtuvp2p+ttxeLWQRKi7KlJi0fDY2uj8c=;
 b=dOCSZAyD7LgTTkqT+8DJs4HNPqQ7SS5Oksa0SveLYusYCrge6zxYXUeIYmwcGY0LzR
 Q0Lxy4gQMT/s1GSThvaWQQ7rPR7n5lZxWzbCEanHxx2b7YT9M+qg6G8diDTfso66kEWl
 B2A1eIfgLP33AGIW333iN0NRg3au1j+zcJnHFuUgYo86PohbznDnwFKSF4AhgUhjdodX
 ADbUj9fkaNbLUQi7u+zsUzHzfVW35wf+VXhzt8eLngj5fXT71bjhpbHr8fz9+IWp3kBc
 vsACKqXMbnJYH7ogFuwy3WM8EiHLiX9xMjaJc08LHNXqrqOZlEgDOpjW6u1xdJ+UPmj9
 Lerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708300785; x=1708905585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09L+fqwxbcHLtuvp2p+ttxeLWQRKi7KlJi0fDY2uj8c=;
 b=B4WWVw9LNfdquwA0H5PQ50/LjHW7C1hsctv07cxI5xmruBQIUVI4bAwTkeYt7DGr+S
 OpdV0UWQ01/a9/6oVZwBsK4AS9SB1qP28y50NWROx0s3E+thSqwH/bMB89HOJShU/hv1
 n/AeRvlXu4mqwzhUjk8mRKK2BwlCWadDu4sEXpeZVF3G/iNoCSi/f3jk7TGTNHg3KFyF
 ZVA+bNHRibakZgVrkd+YepRly5N4IvQRZOzP8BiHW6WNmqBH4WyNpXCPUVdqm/Xgd3ar
 jFrJnJmCucqsA9ocnLTS+/XlPPLeRrmTLKNMtGQ2UPXxkJaUS7X6aKihYNT4vlhrwFCW
 WY1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7GKmfi2xcRBlE32nK+zQC+rE0rkULbB7jtr6QaqRRBJi7FpKokCUhxY3yQbWVewZ+GIhMdHvHGYuL4YTWFppze9j8Dw==
X-Gm-Message-State: AOJu0Yw90jD8goN8IAHIBAfSCppXTVBg79TjQ2qqsMINQW+bhTmfFHZM
 4delPGbZRtePutHLcG8ztkhk+jM94GqGD5exlomktk+l7fyKpEJy4OBFNSwx
X-Google-Smtp-Source: AGHT+IECLTcMXfF3jO+PAraJycCoemC9AmcaKrhmfrcdxmzAReb/oOxlzF2gYJTFet3Ugs/QajfdUQ==
X-Received: by 2002:a05:600c:4f14:b0:411:eb4f:7fb6 with SMTP id
 l20-20020a05600c4f1400b00411eb4f7fb6mr8599191wmq.8.1708300784701; 
 Sun, 18 Feb 2024 15:59:44 -0800 (PST)
Received: from morpheus.home.roving-it.com.com
 (8.c.1.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681::1c8]) by smtp.googlemail.com with ESMTPSA id
 p18-20020a05600c359200b0041256523bf8sm6854124wmq.31.2024.02.18.15.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 15:59:44 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
	egnite GmbH <info@egnite.de>
Subject: [PATCH 1/2] configs: ethernut5: Drop reiserfs
Date: Sun, 18 Feb 2024 23:59:34 +0000
Message-ID: <20240218235940.987876-2-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240218235940.987876-1-pbrobinson@gmail.com>
References: <20240218235940.987876-1-pbrobinson@gmail.com>
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

This is the only board that enables it, and looking generally I don't
believe it's used. All use cases I could fine for the board rub by
default off jffs on the nand and it doesn't enable USB storage.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Cc: egnite GmbH <info@egnite.de>
---
 configs/ethernut5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/ethernut5_defconfig b/configs/ethernut5_defconfig
index bdd8f4db8b7..cc2f567c8a8 100644
--- a/configs/ethernut5_defconfig
+++ b/configs/ethernut5_defconfig
@@ -53,7 +53,6 @@ CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=atmel_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=atmel_nand:-(root)"
-CONFIG_CMD_REISER=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.43.1

