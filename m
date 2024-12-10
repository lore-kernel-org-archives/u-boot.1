Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FE3E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 22:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E83880274;
	Tue, 10 Dec 2024 23:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="tlI1wKrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDEA680224; Tue, 10 Dec 2024 23:40:19 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3E58021D
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 23:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eabachinin@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 566E410000C;
 Wed, 11 Dec 2024 01:40:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 566E410000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1733870414;
 bh=MboFfhZ/DRAH8MESMYwMfEV1jP5vnfXn7wWYVe3yKTA=;
 h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:From;
 b=tlI1wKrQgtY8d7bl1kpC1QoHDYEeNi3O2y/IWXPvKtJ+RfvRHMEVK6dvs61Hx7RUu
 nlNoVFUMJHuxKhwPkqRMGBGLoI4QvXLd0WB3ybZuOpkh4+1wcFVj9XIpz0szrwq8zp
 dgkuhKbCTnKgbwBR7hIH2yMi44f56WRwL4kUp/XnguaeK3551VVrWtYbwbq5QkDNNq
 eaXxbgORGCxSdHF4XilgcqP3orh3fHbdKiA2H9/YcGxFo1HrRodXkER5yBWqnnRvmW
 epizVrxkSPiOpma8mIduFG/yJ8HCK7POHc//NBOIsmJU7ZF7oBAXf9ALLU7847BhFY
 Q7Lnga5gvrPmA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 11 Dec 2024 01:40:14 +0300 (MSK)
From: Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: [PATCH 0/2] Keep the access to dtb_dt_embedded() within fdtdec
Date: Wed, 11 Dec 2024 01:39:56 +0300
Message-ID: <20241211-dtb_dt_embedded_within_fdtdec-v1-0-7840469f0084@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADzDWGcC/x3MQQqDMBAF0KvIrA0kwZLSq4gEzfzUWTSVJNiCe
 HeDy7d5BxVkQaFXd1DGLkW+qcH0HYV1Tm8o4Way2g7Gaqe4Lp6rx2cBM9j/pK6SfOTKCMo9zDz
 oEKJ7OmrHlhHlf//jdJ4XgaH4+m8AAAA=
X-Change-ID: 20241207-dtb_dt_embedded_within_fdtdec-751a40ccf787
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Rasmus
 Villemoes" <rasmus.villemoes@prevas.dk>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Christian Marangi <ansuelsmth@gmail.com>, "Lad
 Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, Evgeny Bachinin
 <EABachinin@salutedevices.com>
CC: <kernel@salutedevices.com>, <evgen89bachinin@gmail.com>,
 <u-boot@lists.denx.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.28.224.238]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189752 [Dec 10 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 44 0.3.44
 5149b91aab9eaefa5f6630aab0c7a7210c633ab6, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 github.com:7.1.1; lore.kernel.org:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/12/10 21:49:00
X-KSMG-LinksScanning: Clean, bases: 2024/12/10 21:49:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/10 16:39:00 #26956987
X-KSMG-AntiVirus-Status: Clean, skipped
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

The 1st patch addresses comments from the post-review, available by
link [1].

  The 2nd patch fixes problems of dtb_dt_embedded() with checkpatch.

Links:
[1] https://lore.kernel.org/u-boot/CAFLszTgEKamsa6FTnjzrEWQBLkqAR7EBbZqffx09AKgQ7ppuVA@mail.gmail.com/#t

To: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Raymond Mao <raymond.mao@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: kernel@salutedevices.com
Cc: evgen89bachinin@gmail.com
Cc: u-boot@lists.denx.de

Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
---
Tested:
* scripts/kernel-doc -v -none include/fdtdec.h
* on production board with Amlogic AXG SoC & OF_EMBED=y
* CI: https://github.com/u-boot/u-boot/pull/710

---
Evgeny Bachinin (2):
      fdtdec: encapsulate dtb_dt_embedded() within
      fdtdec: dtb_dt_embedded: replace ifdefs by IS_ENABLED()

 common/board_r.c |  4 ++--
 include/fdtdec.h | 24 +++++++-----------------
 lib/fdtdec.c     | 26 ++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 21 deletions(-)
---
base-commit: b841e559cd26ffcb20f22e8ee75debed9616c002
change-id: 20241207-dtb_dt_embedded_within_fdtdec-751a40ccf787

Best regards,
-- 
Evgeny Bachinin <EABachinin@salutedevices.com>

