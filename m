Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A772CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 09:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8564B88366;
	Tue,  2 Apr 2024 11:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p2g0pil5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384DF88376; Tue,  2 Apr 2024 11:36:44 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7860488366
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 11:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a4a3a5e47baso571170366b.2
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 02:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712050600; x=1712655400;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MGpKf/H6YHwViSJzpvb+izxMJ9Ac52yTm0FQH3d0rFk=;
 b=p2g0pil5BCeqfVLb+KeAhgHT1aNLDqXosh+6WTfzcFd63c6ZpLyDmmS1SVYOQJVru3
 LGhDslkLNJLFKNzPFojR+jn7JM3j4GRePD1m5hN3eFqZlgt5ptaUUB+TCse5oS4swrH9
 t8bEgSCaj3IoUR0ezZBOibAIDba5iPoOhjSHcAhZZrIq/AOKGJ4qoSYFfDmjZHZ9FxGJ
 91/v340IP8SdK/bQiPNFI0njrgX/kWeaQtYRVvkvplUWUfHYC6ysF7nbck+mPe3v/4Ip
 39txSgl/6Jq3izAshFuvcjjc5GxBMl62NZ1QJUni3+kBmzBcKx6N6Qn9P7ms/oPARQrj
 XX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712050600; x=1712655400;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MGpKf/H6YHwViSJzpvb+izxMJ9Ac52yTm0FQH3d0rFk=;
 b=pjwOJX3W5ipLn3fLWD1wQNC1MNUE+nCf3A6qZIhfyk7IjMGV+fTjNG8NCaFdVEF5y6
 rNUXKMQw+2fpn7+Wlc3w6QRXfM8dpWdrkKkWJzQVYPPODSZgQq4eOcwPYoHn7VM4b4rH
 43cpIUjmlNuxav6tGiP0LhwL3rj3zB0w2Xk9RMNaY4o3yGIpPC6KmaYmfFJLUribP2KB
 CtmpTNMEj39K/dBKixa89FfccwEL4r3xXHo4ytcIbm36jPAPWdS+d9M7T7wpGQA13pxY
 aqlu+mLrlr8oFTNfxBaxl9mUcq6PJdMFDQJ7ZEpAfYTaDPyomrKdOv3HOoU0MqXzOLKr
 zeAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJs9GY6Ykig0c1l7tU2WTmiHvc61L1qOrCRm3aVgXLRGWN5tS90fKNMQb3QV/DBkvK1liHZ4PzbpDVkjfkcPAD/6hKog==
X-Gm-Message-State: AOJu0YxKUJHksTSsEc0+Pmea8s9RLDkhvhJn8CB7dHLJVYP127HALRoG
 54qqqh59wEe4XtOWZmHrxtYxK+IgmJwn2DFh1K/OkpNWy0vZYg+gaAIkDL8Tr3U=
X-Google-Smtp-Source: AGHT+IG3jRObeIzrvPxnSZtfKpOrnQFq1TGAcHKXXB2fv2NEKqdXGg/9d4n+oL7+Bfs1L0XIQVHfKg==
X-Received: by 2002:a17:907:94c5:b0:a4e:226a:cda2 with SMTP id
 dn5-20020a17090794c500b00a4e226acda2mr11675310ejc.60.1712050599770; 
 Tue, 02 Apr 2024 02:36:39 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 v18-20020a170906339200b00a4df78425dbsm6246032eja.36.2024.04.02.02.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 02:36:39 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, Colin McAllister
 <colin.mcallister@garmin.com>, u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-dfu-20240402
Date: Tue, 02 Apr 2024 11:36:36 +0200
Message-ID: <875xx0gl7f.fsf@baylibre.com>
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

- Fix #if logic in android_ab command
- Fix ANDROID_AB_BACKUP_OFFSET in android_ab

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/20142

Thanks,
Mattijs

The following changes since commit 425dc46a2c8ebe6d1a5a7d2d7ac5506aa7783409:

  Merge tag 'u-boot-imx-master-20240330' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-03-30 14:07:37 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240402

for you to fetch changes up to 7a0cfb87672f727b089844dc635bef01d512816f:

  android_ab: Fix ANDROID_AB_BACKUP_OFFSET (2024-04-02 09:09:58 +0200)

----------------------------------------------------------------
u-boot-dfu-20240402

- Fix #if logic in android_ab command
- Fix ANDROID_AB_BACKUP_OFFSET in android_ab

----------------------------------------------------------------
Colin McAllister (2):
      android_ab: Add missing semicolon
      android_ab: Fix ANDROID_AB_BACKUP_OFFSET

 boot/android_ab.c | 97 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 52 deletions(-)

