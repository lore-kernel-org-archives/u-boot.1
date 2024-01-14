Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855CEC4707B
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 10:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D9087848;
	Sun, 14 Jan 2024 11:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E+L+VpNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E4387848; Sun, 14 Jan 2024 11:17:30 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E8B487707
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 11:17:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e60e137aaso31730675e9.0
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 02:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705227447; x=1705832247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Jf59cILl8GxXvg6YOdGc8UpEyGYCUMbm4aR3syxsrM=;
 b=E+L+VpNUEKgWF6xahcWWTP7uBkFyPiiDnb0TNpKXP2ejMD4YLJvPJZEID3CCjzKBi6
 xDjsxl2XvclyJN5aNIEvpgbzDSzzz9Llv+W2pzPOVtriOOQH5YWw244VHk5SNU3UkhHe
 Ww6GJJGerdR3gcSaaUKBBX9h+gpxBwb1YQq132kWu8PTmF0OwwTCQ0IEnhJcN3vumGRu
 0brsg7yXaqluYNlA85SHhnvXs+TR9c3Km8mtLASywUY0LvG2Kc2MRZk/xGvx9iECfEAp
 E7c41tQiwueOdOsNfODw72DrnAAO1ImnrNRG/Kw0Qw0NvG4IsTWifUe33r+WXA25aLyn
 GbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705227447; x=1705832247;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Jf59cILl8GxXvg6YOdGc8UpEyGYCUMbm4aR3syxsrM=;
 b=IxhBONeedFiTzAvQh6TN+weSLL81arYvkjYrYVN4+BKo5e/inlaYlicfxqyMHgzBDi
 i/rclgOjOd4Fq4PVM+6Z1YD/pE1PvQAeikny7jO++68V47w2kCgHTZz3L2cUKu3y6nXa
 GRCQ6PgFK5WtHTpRib/huT2CSL7UtjANq9ibtQyLqcc5f4utAjQbIya9e/hyx9hv1V3Y
 qBMEgL6czxtWOwEjo4qwrphobRARLAJ3HckXRJoni13Fd21RP42SYtcat1E4EhJ6HUwM
 BcI71bqQGl3Y6hwweIa6nsQ8IIayv9MwPaEJ1+svbLMIjXKnYSxmJYy3S2koAa4mIMsc
 iZ/Q==
X-Gm-Message-State: AOJu0YwVfUigxZDZUia7oDFJdego6PStbJTU/HTGF6du4GInhbz0Fg6s
 opYKDhBO0nDPefXWj3f9438=
X-Google-Smtp-Source: AGHT+IHLWfLuWnVCN6Cz2Jbz5C4qI0ugfa9D8dPg8YC8/xX4GWpQ7v0up74++uOZzigRUt7PST+kaQ==
X-Received: by 2002:a05:600c:6541:b0:40e:74ea:2a27 with SMTP id
 dn1-20020a05600c654100b0040e74ea2a27mr279120wmb.116.1705227447059; 
 Sun, 14 Jan 2024 02:17:27 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 cf12-20020a170906b2cc00b00a28116285e0sm3906165ejb.165.2024.01.14.02.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 02:17:26 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] bootmenu: rename U-Boot console to Exit
Date: Sun, 14 Jan 2024 12:17:00 +0200
Message-Id: <20240114101701.23070-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

It seems that the U-Boot console entry of the bootmenu has lost
its original meaning. Now, even if it is chosen, the probability
that you will enter the actual U-Boot console is quite low.
Boot env, bootflow, bootcommand script may appear, but not the
actual console. Hense, let's remove ambiguity and name this
entry by what it actually does: 'Exit' the bootmenu.

Svyatoslav Ryhel (1):
  cmd: bootmenu: rename U-Boot console to Exit

 cmd/bootmenu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.40.1

