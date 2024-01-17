Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2FAC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 10:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF1887B47;
	Wed, 17 Jan 2024 11:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E4J9Spej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1399187B4F; Wed, 17 Jan 2024 11:56:29 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAA3F878A5
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 11:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50ea9e189ebso12530656e87.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 02:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705488985; x=1706093785; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q6o/i52t+uEiNzpCr0fWRRb1g8QT4LdKhNQe/UmC4wM=;
 b=E4J9Spejt0MeBmTTINv1k16eR43Q8UHg2mCSLF/oRPaUybSODhEpgqNjRRhtO4oBgZ
 fbWvOAEEWuTOwg6abnZD4TXPdNxoOjeJN7Izh6GNlKpFUP4rWiL+8hGPmIJjCD7X9QGT
 M5OtxBSf4l0BrqLkRTvS6lAqToeze+5IhnPR9POf0JcJU/obqRMscuX0Yr+xyrHUjGru
 8h2Yqw1LTz1zkEF9RyvKIpiJsGVZiXaw10Wxsmubtl8VpSvMk+P/24y24b5GKTYKhlRI
 PP/7WjxnmzLCnZ11b5273kGzme/yt5fjTsHS0ZCJu8fUGhIu620B6qofOYRtMRtzTlag
 a9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705488985; x=1706093785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q6o/i52t+uEiNzpCr0fWRRb1g8QT4LdKhNQe/UmC4wM=;
 b=m1261mARS2e19QzzHGp368SjFY/aFkZ2m+s2OAdEqlgyXxNozxckXln7HswbK18cik
 Xc09Bx+TvmY7xQP9JrsH/nl/22ALEOTsEnEhhNZ4H4LloNWBYJ7RpxmH5l63viUTyMh1
 PnlGQesoGVws/nrcr5t9QBJkagZvrPTCHriiDUASxrHMqsRzR+72xmAo+vhTFBuxNWsJ
 mb4HPumJhmKg868DWth98JhxS6Lb0FfrFHa/FMHyc2XX9a7bG0l5A/DHh2pYwQfml4ao
 riJKWW6hs13wOOifT099QAx3VoIUc7SdSDIu2tNUREB3T5x8ak9o/uOJuPDl6wDGxXWh
 mtnQ==
X-Gm-Message-State: AOJu0YzzpQ5FqLDti/OOYF98qD98vCnP3jNn2BF1pQaNyPzdtRhHic/l
 pzZs0/DbAe9XsLiEAgh1anE=
X-Google-Smtp-Source: AGHT+IHG15jnAkUZLSiGbRjB0fj1D/KYZh463f3HEN0PMmONaCgZN3FlDmNzqheVuZrNsK1Jc6b/xA==
X-Received: by 2002:a19:ca55:0:b0:50e:b713:6d9e with SMTP id
 h21-20020a19ca55000000b0050eb7136d9emr3644664lfj.131.1705488984721; 
 Wed, 17 Jan 2024 02:56:24 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 wr8-20020a170907700800b00a2e08b24ea3sm2967838ejb.174.2024.01.17.02.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 02:56:24 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/1] bootmenu: rename U-Boot console to Exit
Date: Wed, 17 Jan 2024 12:55:45 +0200
Message-Id: <20240117105546.7282-1-clamor95@gmail.com>
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

---
Changes in v2
- fixed typo in commit message
- slightly modified comments in the code
---

Svyatoslav Ryhel (1):
  cmd: bootmenu: rename U-Boot console to Exit

 cmd/bootmenu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.40.1

