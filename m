Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6B4C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 22:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A24087C7F;
	Tue,  6 Feb 2024 23:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC6FD8718A; Tue,  6 Feb 2024 23:32:00 +0100 (CET)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF3D2876AE
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 23:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-51156cf5766so530784e87.0
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 14:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258718; x=1707863518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qsutu8er/cIaJyQ/yayCF3FWojj90NlbsFvFkdl93vQ=;
 b=nMQOYRn7HBEwy0BsgIKcsXvRP2N7d4cX1hQ9TvnzH4JjyEiEYY0XvDD6n3hfNFEctB
 ROFGVkZ4GCdoWla/I7X5+0GJxzhzxA3rGco1S4EBXwKruhT3GClhS1x4DHRdhkT3qCck
 Odxl8Lg70hOjVM+byQdoi0+RWLS9OJdINo8b+9x7zuXhUHD38F0CvXtpKQBjI1pcWgOc
 lIQpZvLw/cbB/FZOzzMCL7moDDgjgoMrnLcJ6/vkH2GBi10MUIDbPEjwPmqX0J9Ehjb1
 3PsuVrcofKQncpPK0AFHRCLtwBjCbjDt5bVExCFcSxLrCIP8p/3Qshe/7NBlHJypqfRJ
 apxw==
X-Gm-Message-State: AOJu0YxzErcx5KkL+FYoRIVyRT+5VnbgEDxjennQMlAKZqsNOVg1fcIc
 2yt+opRdeymwwIyiUFjyxq1jJ9PIsXi+jDw8N4LJ4ajYyqkRQeQt1tJakxNoCfHX8w==
X-Google-Smtp-Source: AGHT+IGF4/J376rH+TC9wMFzctYta1QCmNSrWXkBPnofa4HKtLUhv1STw4umnRbwjoVIQhdZcAfERQ==
X-Received: by 2002:a19:9114:0:b0:511:63eb:8cea with SMTP id
 t20-20020a199114000000b0051163eb8ceamr400346lfd.4.1707258717393; 
 Tue, 06 Feb 2024 14:31:57 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUa2o7DKeSk4uoDgkDKYBvUJTT6KXMoBScYZLckEko7XbaJnSnJuhVsyyyR/YpT0wUMfaE3/FbtLflBti2EqPjHF7BUIK5ZBlzqXN1vEycvSTRFTZQh7WhZjf0748wW+BTfrliPc7mgkrOgGL4byDjK7Tnt+GXISe4KBVgrkLxXxQM9Ftzd3TUd44m4PdsGWDDOzAj77yXtm6wlwSkwcKpAQ4chSq2tqb2//HnPwwXX4JiOVIUhApuoY9ggaztuH3eCb4MByTgmy9IYX/UAEja5dBdL5XseY5jYAZGtRiQcSfTqCkl6KQ7o793+vMQWJ5LmPCRTUSjn2g==
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 w19-20020a19c513000000b00511510cb561sm353047lfe.79.2024.02.06.14.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 14:31:56 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/7] AVB: cosmetic adjustments/improvements
Date: Tue,  6 Feb 2024 23:31:46 +0100
Message-Id: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
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

This patch series include:
- Simplify and add more context for debug/error prints where it's needed.
- Move SPDX license identifiers to the first line, so it conforms
  to license placement rule.
- Use mmc_switch_part() only for eMMC.
- Rework do_avb_verify_part, take into account device lock state for setting correct
  androidboot.verifiedbootstate.
- Adjust AVB documentation, add info about slot_suffix param.

Igor Opaniuk (7):
  common: avb_verify: don't call mmc_switch_part for SD
  avb: move SPDX license itdentifiers to the first line
  common: avb_verify: rework error/debug prints
  cmd: avb: rework prints
  common: avb_verify: add str_avb_io_error/str_avb_slot_error
  cmd: avb: rework do_avb_verify_part
  doc: android: avb: add slot_suffix param details

 cmd/avb.c                              | 206 ++++++++++++-------------
 common/avb_verify.c                    |  89 +++++++++--
 doc/android/avb2.rst                   |   8 +-
 include/avb_verify.h                   |   7 +-
 test/py/tests/test_android/test_avb.py |   3 +-
 5 files changed, 177 insertions(+), 136 deletions(-)

-- 
2.34.1

