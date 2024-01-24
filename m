Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84748C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 20:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFC0587C80;
	Wed, 24 Jan 2024 21:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VRzP82Vm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3922B87C7F; Wed, 24 Jan 2024 21:27:56 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 609EB87C80
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 21:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5100fdd37f7so1746033e87.2
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 12:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706128073; x=1706732873; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h0lJpGtFq4RBI23PKDkcypMtF+Gz45ziD1X2ainXstI=;
 b=VRzP82VmQ/WkW75DTDicw0XQI7PF9a+yFoUjs5Yx/zp9npjGva6PwAx6kDt00eDQqK
 NcQ48YFqLh7smfInKvQD0dx/zUV1CuYtoy6ezMF3lyY/g/J26VKOoj5IiIQGqFW73SbF
 9/sQKaGJTNmpSf4usxQO+rZuyi92BdNG0HBL+XwsM1PxH4fYHETS4dMLRr9Wpn8YYmKs
 ok9Jd7NucD3RpDHsm126op0zj1SdgutMGnWc+/1sTEDnvrGfj2Ps9otzpg1iVTJrSlej
 tM2PQcxq95DcKcvF2IcW8tRjrt0as7blSM7eXHEew7OqMwUqPf45UjPfBVdewprl++cc
 QQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706128073; x=1706732873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h0lJpGtFq4RBI23PKDkcypMtF+Gz45ziD1X2ainXstI=;
 b=WBkvU7Q/RSl78CbxyyOEeZvGa1D+PEhV9MoggacNhMG2lOaRqeWD6mHk0Y+8QcBV1b
 K48xUsFeyP1Bes1HaaWoAz5wSNL2862jMOMPNfyuljgB26SuA9O69vwArYsNYKcBht/s
 SNEHaQYsMBhVRVizS7xX9Nv21DpAwTJTIxvveYBxuNLcu/cdvKs9Qq23ezYE6Y5agG05
 AV1zpTKCO5AyHUKnVZGWX9wQS6RuBdT1suZjVZ9C8XMUWKICXUm5IomIwQJQPahJJnFJ
 0+ALAZC0EYEXEMABpmbEoOQ6WMR76W+seL9JD+NmRJkzL98TYcZ8pxOxbvS+r7ofPW5e
 hMIA==
X-Gm-Message-State: AOJu0YzomJlPIt2skqDq6AlGYCGfb/kvl6c53Cwgyn5kxlhrmIVXFM2f
 qlQGXaS7qtl65A/631FYu8Q5bjryEzaFro2BiIhWJH6KJSNW+SDn
X-Google-Smtp-Source: AGHT+IGH2O1YHM0laFjt1f7cijBcYF3rsZGI8KKTXyc8F9KSK/L/sTNrARdGQJp7000p8eEWGh3cRA==
X-Received: by 2002:a05:6512:401c:b0:50e:246d:7566 with SMTP id
 br28-20020a056512401c00b0050e246d7566mr5385850lfb.7.1706128073314; 
 Wed, 24 Jan 2024 12:27:53 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 dm24-20020a05640222d800b0055c1433be60sm4656763edb.50.2024.01.24.12.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 12:27:53 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] Fix booting kernels with ATAGS and extlinux
Date: Wed, 24 Jan 2024 22:27:30 +0200
Message-Id: <20240124202731.39212-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Currently, if boot with extlinux.conf and do not set the fdt
U-Boot will provide its own device tree. This behavior is
beneficial if the U-Boot device tree is in sync with Linux,
but it totally halts the booting of pre-dtb kernels (3.4 for
example) since it uses ATAGs. To fix this, pass `-` in the
fdt extlinux field as a signal that no tree should be used.

Tested with 3.4 legacy kernel and mainline 6.7 kernel on
P895 (lg_x3 board).

Svyatoslav Ryhel (1):
  boot: pxe_utils: skip fdt setup in case legacy kernel is booted

 boot/pxe_utils.c       | 8 +++++---
 doc/develop/distro.rst | 3 +++
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.40.1

