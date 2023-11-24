Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815B9C61DF4
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 10:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E5886F64;
	Fri, 24 Nov 2023 11:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Oz2zg1wg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 307B186E81; Fri, 24 Nov 2023 11:39:44 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA8E786F64
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 11:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c88b7e69dfso21339011fa.0
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 02:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700822381; x=1701427181;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bSKPv1V6WVfuBcg8yPFdS0ahZqhnECWSr/E1Wf9zq8g=;
 b=Oz2zg1wgE/hXqfQ8EWdRm2iDx9hcTubxYsT0+stBrywZoe0v7X58d+IyJbmJJpNeZ0
 OlSBvVDkmqZVYOWoFjRfaoXbTwDjYiXlWYyBkoDyUFba+fOmHYfSPRtccPw81CSszL94
 ZsVaKqP0eM08rwE7Fqfdj1WhlJe2kJzNJoFCkazyON7P4dVsF0Pw+N1yZNR7j3lhlN2U
 wuSG+PWkaJrXwhCqgWAFfl5yc1roGdWEbsdmkAyc9h2RrcKSEqTfd/R8MgFF8yhaP1Tw
 fn7EsuSapZQhQ95fdfy7OxET2bC1MMMeYr4PW5GaIJr70CN1YhVW8bVisu9f73Y/cNgW
 vKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700822381; x=1701427181;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bSKPv1V6WVfuBcg8yPFdS0ahZqhnECWSr/E1Wf9zq8g=;
 b=Czwcdopipn5vpxf0hQUpDE1OF7H2hJzqQSca7ZEqRgILxrFDSNZj7h/8Z55hKg3IbG
 0I/yBsKxLDfXTp5zb8W332KsJsUZis+Z9VJO9fZZf95KJJ7YZ0CPqfU8T7Wxrtm1asG6
 6S7JYsrjLrKyL3J5d7GyFaq4jWSRADgwk2lPhHy+JJuiPVid7TtHqxXaLWU0ToifBBlS
 qitrAJuFgnZpXdcXGnu8FWTTWL9WrdBu/AeFvNBISuMIc7b9uOAWIM2uZM3YufW1Rr5u
 E2FAU/ioHOmgWfgMmu3DHuV+b9taTp+uELQyaMG9K3it3f4MXr4ygFdxK75oa6/noJXI
 bWnQ==
X-Gm-Message-State: AOJu0YyJCs7GIVS6qNCtr7qgpbj+QLlgPwJRtW1evguWpV4mAqTyiYTY
 Oy+FagNZ6KAuAo0sV7ml2icT4qC1AlmFlvYov9M=
X-Google-Smtp-Source: AGHT+IG0T2IygqMJInAO910NiGjre/MMqanO8tgmOu6r5yTBQ20J/q1IxO9A/7IiwxAPA5001+602Q==
X-Received: by 2002:a2e:8e81:0:b0:2c5:14eb:1080 with SMTP id
 z1-20020a2e8e81000000b002c514eb1080mr1544928ljk.21.1700822381086; 
 Fri, 24 Nov 2023 02:39:41 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 s11-20020adfeccb000000b003316b38c625sm3981922wro.99.2023.11.24.02.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 02:39:40 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-dfu-20231124
Date: Fri, 24 Nov 2023 11:39:39 +0100
Message-ID: <87il5rbfkk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Here are some fixes for master including:

- Fix reinit for ChipIdea controller
- Add missing newline in fastboot error handling

This CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/18703

Thanks,
Mattijs

The following changes since commit 24ca49b33af98d54d6cd2e845f071f6565345ffd:

  Prepare v2024.01-rc3 (2023-11-20 08:43:46 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20231124

for you to fetch changes up to 6f68dcd0259f9f1c03f097669e9490b13b5325c7:

  usb: fastboot: Add missing newline in pr_err (2023-11-21 09:19:48 +0100)

----------------------------------------------------------------
u-boot-dfu-20231124

- Fix reinit for ChipIdea controller
- Add missing newline in fastboot error handling

----------------------------------------------------------------
Simon Holesch (2):
      usb: ci: Fix gadget reinit
      usb: fastboot: Add missing newline in pr_err

 drivers/usb/gadget/ci_udc.c     | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/f_fastboot.c |  2 +-
 2 files changed, 39 insertions(+), 1 deletion(-)
