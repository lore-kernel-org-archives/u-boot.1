Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC6EC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1BFF88D13;
	Wed,  7 Aug 2024 16:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZKTUqr0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3385888D0F; Wed,  7 Aug 2024 16:17:29 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50BA188BBC
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7aa4ca9d72so210571066b.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723040247; x=1723645047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WS3IYlrGKc0P3qC6C3RlGUvdKaX5aeguKQcS5QIN7EA=;
 b=ZKTUqr0/lyQ3+JPVp8K2v9wsLad0/kmkcL8CKprseEfWtyYP8jZlKiQN2pqWOi/nYE
 DikaDnspodXnzw60flG1zLPIL14i3ru6YLDsPggq9w7Cfhi0ZskFVB3tiJ2idLG3kbOe
 4h4sEiBgWNpDOxJAKs1MP+W1DwMC+Wk5zYvN9b2v0l34nrW943KjBUySJnbp6vPZVwzr
 SLvB+NjEHspioRkV+nZRVTWZbym19NRnhDTJdeJszv1/6Od9q56eWvl96YiH0psM4LxG
 w6se8d+ujGX9rmhVU6+TVOoQtkwSf/ikGqNstxu23M/euYo9kUtzi4Bq0Pp8g5K9LN4w
 tJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723040247; x=1723645047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WS3IYlrGKc0P3qC6C3RlGUvdKaX5aeguKQcS5QIN7EA=;
 b=MtVBoNOmIdyC6sRQW+T8ux+KbEfPnj9danQs0YRDuYQVwZ2frmpnEmf4+cRrGbB5JC
 04VmTzw9Krq+xhpcjAkkaOJnSSSie/ekL0tN/kMzyWmWBYI8rRb71Cr4crc75B3mX7Wh
 bZOAlJyx5i6JBzIIjtyrecTnzY0bLF8S5MlVQIWDpDfbrKuaONhfpHmZsPZzVnliRWEb
 0bQVtEayopmAqr+grckW6uybfb58KrjanrefhTr5T65x6/6ywY20c/1m/RDt7//ce4jo
 28sYu50KWIjJUXwjGVj2fpO5xwtdgC3JJP6sQRcMDob/NUVP9UbTguuV/eKGlDIEXQoH
 obiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP66hXTlc4u2k75KmZbObX8zbA+HUnHV3Bln/k8esOwtvRxtyeKLGK9ij8MIjt9qEEjQyqjYtKykzqtgEay8sfGOmVhw==
X-Gm-Message-State: AOJu0YxsYO87uNA4aTUiYUcpW3I0X0bRsYgn0qjZwstgMvFgVmWyrBJx
 opyJBR8LlqMGtqObLhZbDxnRSNKk2CPd1GZtnzXVdDWXXtIXNcJt
X-Google-Smtp-Source: AGHT+IHIoVh4a4Xx4KDSwKztMPJBRhmgLjXVujKUeoMeDhjNH3bNMZan8vH3w5e03ft7ZmoPzQ23mQ==
X-Received: by 2002:a17:907:d29:b0:a7a:c812:36bb with SMTP id
 a640c23a62f3a-a7dc4da6efdmr1573597866b.8.1723040246384; 
 Wed, 07 Aug 2024 07:17:26 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec8dafsm644945766b.220.2024.08.07.07.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 07:17:26 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1 0/4] apalis/colibri imx8: enable additional features
Date: Wed,  7 Aug 2024 16:16:16 +0200
Message-ID: <20240807141655.4165667-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
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

From: Max Krummenacher <max.krummenacher@toradex.com>


Enable and use additional features which have been added to U-Boot
on the Apalis iMX8QM / Colibri iMX8X boards.



Andrejs Cainikovs (4):
  board: apalis-imx8: add reset code
  apalis-imx8: enable i.MX specific BOOTAUX
  colibri-imx8x: enable i.MX specific BOOTAUX
  colibri-imx8x: enable i.MX specific SNVS configuration

 board/toradex/apalis-imx8/apalis-imx8.c | 8 ++++++++
 configs/apalis-imx8_defconfig           | 1 +
 configs/colibri-imx8x_defconfig         | 2 ++
 3 files changed, 11 insertions(+)

-- 
2.42.0

