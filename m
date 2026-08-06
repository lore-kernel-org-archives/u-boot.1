Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543B6C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C47360831;
	Thu,  6 Aug 2026 13:05:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s4NvZKAao-_q; Thu,  6 Aug 2026 13:05:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82B3260818
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021516;
	bh=30xqExoGF3YNLAvlxU+JZRjh/hqllmZMEGSSKU/vl30=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=foEPu4sHq4QoiMa7rAVG8yyJ2FROdICvxyBACBD446r7+PT0/RaD6ClaKqALT0o/1
	 SNh8fiPE8j98oaSryz0WvfsbMlbCY4P2QdCpiDnpEti/7QZX6UA7boGL9VMtvVli5H
	 fXpSZfVjNtqAwFdE3NhYMWtYsd/t76A8XDWhgdgjp7p0gQFkLo5+V9iVh6JrPoBKqN
	 NsZNwOUeYEABgr0f7BlS1Jiqw1c7Wazggx6PorEWIz0/Sah/qZ2fWU0PgM7GgzrdU5
	 9MvBMKBDssiJk2QIr1fcxZtD/QYZ0KNylLuS4J7PS/aGJfdJXitkVXcOOo5DICWiDM
	 M2Jb1vMGrXBdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82B3260818;
	Thu,  6 Aug 2026 13:05:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B649A194
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7D59405A3
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:48:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UQ-Fr04SA4yi for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:48:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CDD8A4059A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDD8A4059A
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDD8A4059A
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:48:03 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso1436203f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 05:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786020481; x=1786625281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=30xqExoGF3YNLAvlxU+JZRjh/hqllmZMEGSSKU/vl30=;
 b=ajCVYOaENXeo7vjq1/MtvsdKsx7/Ap84g5ThRZU+lQLDmwvWNhvj2Py7KSNk/6uHkR
 QIaJx4iN4tL49E73oeI3ftVx/y0fkdKCNSF4sGkCcQIPO6A7d92tQ2fWZHkIashMmwes
 GK0LrI3o2prygS3oNfFUSznMcZetySERkrPFbMphLwwb09bJtfLo8eoq2F5b2m/+6EuZ
 rq2LLikcxgYfhBVosXZgKrBisJVkChwhiC8zu2QzPC9QplVlB6TpuqerK+bSfDptnhDH
 iG8WreS5P1RX2qjIZC8Qmoik/Trww7SxISlem9rLR7PaFZRVtF3Zz8HyIgSy4ZplR+57
 lZiw==
X-Gm-Message-State: AOJu0YxedlhcspyIXIOqioSWvAFP7aJ2ndH2jbMIWi1sh3Ikvske9D8p
 kPH75CHYeCLVQ85w7P6VPaCc8pvQJB4ldLKzR2JqRH+ZYY48rm5gsUh7vzvg6pMV
X-Gm-Gg: AR+sD13wb/EdC8PgmFE8JDmczuNEb8lkTmMtG5X7bg91xSTh7yb6Lit2ERgrfC3E1ZT
 FnuA7yUqCEmRCYGL4B1RRIRIgzjgdHLv80pK8FXqCdrZbti37KSOfiuXEWIDypWhgEy0J2RE947
 hTOOM3I2y1MXpjxI4P07zZFslvikWTWGq/4fT7rHAag+aX6a2kWrkRmyTyKSnbEKNuWHTdqHfSM
 VJn2OOspXYV63K1gZcoYUtG7juoAl5trAmOANRyJZvC9loMP/wlSS73Zyd3zn0CpVNTuaAxSAN0
 0ecd4D5I3RAdwM5ihHLrFjsqVjfKs3tX6AAT1O4ChAT7u7aYrXedeseXfQEPNEFGjUUS17ulkl6
 DZvtFBCacAr7tkaGW+3KW7pLTxwCcp8RrJf5ufQinLRJHMPChRWJEuQqEZzCoHBSk6Utlm7GrNq
 /3I13UuedVAYG6n1/BHfHCWPaVvyPUbt+VsUQ0oZ+hn8aZqaIxUTRj51ONfeY3p6QrUxk=
X-Received: by 2002:adf:f4cf:0:b0:47f:776f:3838 with SMTP id
 ffacd0b85a97d-47fec5030e5mr19952063f8f.6.1786020481318; 
 Thu, 06 Aug 2026 05:48:01 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b183b2sm6662832f8f.24.2026.08.06.05.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 05:48:00 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 0/2] vf610: fix GPIO output and console input
Date: Thu,  6 Aug 2026 14:47:58 +0200
Message-ID: <20260806124800.262013-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 13:05:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786020481; x=1786625281;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=30xqExoGF3YNLAvlxU+JZRjh/hqllmZMEGSSKU/vl30=;
 b=ZbFZD1UUy2reA4eaMXUh8GChfPaRP5LE/5XrealdLLsx2E19gJ8soHcGm3EOwxqqoD
 VKrCSAv/5PmzTBpCqvcCxKzlfn3AH8sOIv8W7xHAlii6vK0AUGTyWPBeiy64hVv70rEB
 YbbDDGMc5uJx/3nvlgewW+4hw09o1slf6JxO/cFqZco5Xo22Qn9XAbszXBVOZ5YQa7Pp
 CajW+y0ZghM6zweXj7xJuuSXRLllx+iEzvGjCmQphCRQaLscMop8xnco7A1SnftONgvA
 tGdB7KJGGN4Jq8jRZEJSdyi1xHB02LSgqjykxNa3s8w3S8ed1RVj0wwddCgR6PKQuT4a
 ayLA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZbFZD1UU
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Two independent vf610 fixes found while moving a Colibri VF50 product from
the Toradex 2015.04 fork to mainline U-Boot.

Both are long standing and both fail silently, which is why they are easy
to miss: the gpio command reports success on a pin whose level never
changes, and the console keeps printing while it accepts no input at all.
On a current mainline the module therefore drives no GPIO and cannot have
its autoboot interrupted.

Tested on a Colibri VF50 (vf610, VF500 SoC) booting from NAND, with the
display reset, data/command and backlight lines on GPIOs and the console on
UART0.

Mehmet Fide (2):
  gpio: vybrid: read and write the GPIO block, not the PORT block
  serial: lpuart: test the receive flag, not the FIFO counter

 drivers/gpio/vybrid_gpio.c     | 8 +++++++-
 drivers/serial/serial_lpuart.c | 9 +++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.54.0

