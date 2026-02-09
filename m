Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F527E7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A69B783CDC;
	Mon,  9 Feb 2026 19:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fo7x4hdS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C0CB83CB5; Mon,  9 Feb 2026 19:12:03 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 891BE805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59e4993e00aso2619560e87.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770660720; x=1771265520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HOrgJM1N6QLrBjGHjVy2JbucTi2mIzrtiR4GsyIy6C0=;
 b=Fo7x4hdSjtSVRu1A+qsYnbHt4n7bjCoDsek7vWHOeXnxw+eaqveVhLt68lWtF7gH9q
 klrNwYM1ttGyYvuIM4qd2hpzZ0z5uve70hvTP/j/tURPS8uhLLBbqVRxIEUdn2wbI0K1
 oDJoiMH6mVVkD9T3MxBmT/Rszpuuxj7h/uLFdIEw/dQf6AvYKw1qGsQZ/mJNH7SVDV6G
 /2Ez8oWmrDgRILcB5/AmMhHu//LIxRRO4BXc1BJGG99zUBJI4qgxIV+YHUY0uWilbBTQ
 1RAqbXfwYrKZ3yXaPgTHS1LzFmkIZz4RwaJfqDkrwsd+YkdP3uR1mB4lnM6yza0ayRQ0
 I76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660720; x=1771265520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOrgJM1N6QLrBjGHjVy2JbucTi2mIzrtiR4GsyIy6C0=;
 b=UyTZUhMwOUvsIqU5wJIhGPASk5NvR78TuJ22CQ8TuPKfensZlPPO1YCllNzn9mRdxF
 AGVExdMhmkoYhgE+0wEsQT6p296UxJ1s+e+FMU6f8gNTRLz8icT/aaTL/WazeZ0WktTu
 2MZT5RqfVFOMwVQvTx8CffXd4E7OLQCZBd0fMMrvesZnsiqdXP585E/2PbztQFauBTZM
 SfEIrN1Jq2f2DzAYc/2+FbalvEzSr68JRhseeCk81BoOiu+sWA7nxFtY3rrmBJJms+n7
 3jnxoTTciKgVx/27uCanK0uvLxE/+P5bEkxSLZp35zPBdNYxpN/sn6fZl3Cil1sP9TCG
 v9hg==
X-Gm-Message-State: AOJu0YwizgZBHZPcfZqYJlChagFGMsBzNu93rDX/7Kzn0VjT3gmCYYmk
 TP1BQ/V81ymkizGdaCn2mpMjEYv2ctaejGAZPXUR2Pk0usxsdRli7E9v
X-Gm-Gg: AZuq6aKRtenweS8pxzNCrKjcKr+gkzQbigR5NhWvYQNjjg6aPycnnC5B02tXaPwBzg4
 L52OjidDZiR0v0Pv5bHogtQykvBn+w/ZUu2K4Nwgv7xUKpN9uQhY09nlKd38Z4wQIhbJSSgOaH1
 Urd9uE5a0Kmc7XQk8hz1KRw4PyqXy+NnqNh5G3zvnFLC4RwtRJrjzmAznZpbW23I+zC5EPr6EoW
 f72hqRFlBsPYI4OjuZj4vRKFWGpNfXgQPTrA/KGao28kXuUXQQFEyeP+s01iatAdg3Ig4uigNC8
 5v3jMVNBDtXq0Nc6RhAxqdIIq7IFHWbS2V5PxloiBNc55WJ5dKJ0jD6EWENKrIJzDDKQDy6VDmZ
 Id7J++FT1Fwv1CfPJVOEZVrg+HpKpjEVyCGBTzh7mgpcvX4zNglsRcAZfOYSG5txeDDSyzvcdwk
 CQ
X-Received: by 2002:a05:6512:3da1:b0:59d:f46f:fe4a with SMTP id
 2adb3069b0e04-59e450444d5mr3834074e87.10.1770660719573; 
 Mon, 09 Feb 2026 10:11:59 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44e25e4bsm2792801e87.88.2026.02.09.10.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:11:59 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/5] cpcap: adjustments of PMIC and subdevices
Date: Mon,  9 Feb 2026 20:11:44 +0200
Message-ID: <20260209181149.32714-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Minor improvements and alignments for CPCAP PMIC and it's subdevices.

Svyatoslav Ryhel (5):
  power: regulator: cpcap: remove bit_offset_from_cpcap_lowest_voltage
  power: pmic: cpcap: add Mapphone and Mot compatibles
  power: cpcap: make regulator node names case independent
  input: cpcap_pwrbutton: set default keycode fallback
  input: cpcap_pwrbutton: simplify parent verification

 drivers/input/cpcap_pwrbutton.c           |  6 +--
 drivers/power/pmic/cpcap.c                |  4 ++
 drivers/power/regulator/cpcap_regulator.c | 55 +++++++++++------------
 include/power/cpcap.h                     | 48 +++++++-------------
 4 files changed, 47 insertions(+), 66 deletions(-)

-- 
2.51.0

