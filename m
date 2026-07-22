Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82188C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 20:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C46A809EE;
	Wed, 22 Jul 2026 20:43:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9T5WZhkWP-5g; Wed, 22 Jul 2026 20:43:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A0DB80BAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784753012;
	bh=m/hMIM7dswxNtSvk4e5KvUPSmadHFJxNXGFkshBe7zE=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=aNprbKzetjjp3amw4DnlXG+nc8S6Cb855jd/h4QAjhRMt2E51fV/KsA34Dsafe8ll
	 xRdpewbFKJazNCJu5CiY3b6Y2KPubosoEzO1e+UXxsCncH8Vuw4I/biBp2ZBWvRtye
	 DYL7a+FDyAYGykfAxtjaXMztkDqwh7ZEZzFR1fFq1UDzWMzOoBGbyfcomt6iSBIemB
	 xEWh1FQYnWqtdVGl0H6zZruXyuYiW7iGRRjUG/kb/PcItdLYQUyneoxU6i34H6APEs
	 iOVKP/QJ/5oww7avShJnOGaUp+cBMK1Lx1jHV/wqy26f967cUQWQEJNQFF9xePQA/j
	 iCUy7GsQd9QJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A0DB80BAE;
	Wed, 22 Jul 2026 20:43:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 884A0224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A224605E9
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wh74-HBKHAhg for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 20:43:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::8;
 helo=mail-wm2-x08.google.com; envelope-from=ccaione@baylibre.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D9C006071E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D9C006071E
Received: from mail-wm2-x08.google.com (mail-wm2-x08.google.com
 [IPv6:2a00:1450:4864:31::8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9C006071E
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:29 +0000 (UTC)
Received: by mail-wm2-x08.google.com with SMTP id
 5b1f17b1804b1-4956bc73c0eso3906015e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784753007; x=1785357807;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m/hMIM7dswxNtSvk4e5KvUPSmadHFJxNXGFkshBe7zE=;
 b=J+BuW5xWXxRKGagC9EHfelyzzGI1Ae6ego4C2ARgGGdVcq6du+c49QOFTIlcEM9qfZ
 3hiXZWe+MUGs23YIc2XOrmP0FQyDr+/HxDuxlueKeG89R1gtujRR0JjGbrMewdZ4JL5O
 e47aPpdqH9zyEVeAr9mCgAw86ndAKpVVezTeA2TgdCtltd0id2KWgrC4rYmvHByedn34
 BXgDwGuHeh8XAdHuuCn9wex/g2PzGLTrBakie4gTJ1RZ0haNyhGGXBhVIj4fxwwgxik0
 G7lxwPI1D+H+B2AC+dqVH7K0XvlWqE5j+IZ13BF5HBmQuImhzkzBmqK3aJ+1zFqBiNMl
 LRdw==
X-Gm-Message-State: AOJu0YxHSYDfQJXGBn7C/K5fP0xdWna5ed4M4IwxXeWGZKYX1jC9tel9
 mmDah+PPQjHDt1cqkg+lQeRC3yL7LO0HkBmJBMwc6xDkEBFrL5Qr1gnP8xsVo6lCrF4=
X-Gm-Gg: AR+sD13zGujC2rDK8IJJpzi5IMs/p0YlrhIUbZoI1TpqUjj+GlI4VjiFyZZXHf3Egqa
 C2YycfwGQ39iJkN+du+yVGvSz9gQ/j1ELSFsnAxRBVfg78r7j9mjAbyd+lr0RKEnJHGmV14YDu4
 6Cih/iZFE1SzYS+mIh3TcISlA6hID4BSUU3XN/5jhY73ASqvEQIipcJ2+yqBXZ6jeBxpkOVs1MJ
 qGKLhjhp6hBjYPkUhXIOStm4MiaWm4xo2ykapl6qX3KXZqXcDkEFP+PQgJZPkYA1U1HVIE4H5Gr
 0pyD81pXJyI6md/i/tZzg/BW0YRQL5lLoDxA0hITf84fIP+Nvl4Lgb4EKjQ0z8uzFqWjz+cwj9B
 dKYLFZxHOty5RGHqTunJoGYVoanA9K3QYVZy5zar5nF+srbPDVW8E8pYsiFivXV84qPfSyO7FIe
 /eYettFTv6EPmPKAZZDxAqfQB8HXo/KrXz1XyXZbBpSGtkZ/l/rA9Z7Irji1Dn0EadLsnEKg==
X-Received: by 2002:a05:600c:470a:b0:495:4572:21af with SMTP id
 5b1f17b1804b1-49573cc966emr2805525e9.9.1784753007304; 
 Wed, 22 Jul 2026 13:43:27 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b4e8885sm60775195e9.0.2026.07.22.13.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 13:43:26 -0700 (PDT)
Subject: [PATCH RFC v2 0/5] Add fastboot to SPL
Date: Wed, 22 Jul 2026 22:43:02 +0200
Message-Id: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOzW7CQAyEXwX5jGl2lfJ3QkLiAbhWHOyt0ywi2
 Wi9RI1Q3r2bAOcefBj788w8QCV6UdgvHsCkghypdXXWcO80RaHmoyHfwnIBUXqvPrT5aLN0NbU
 /gv57gm1h18XGbNE5yojg+xu1u2FFmjiEhKasyPKa85STZRel8r9z/hecT0e4PJd656u4NDlPW
 O01hTjMLXszw6/A3T+BvUGDbsfEn1wwbeyBabh5jrJyoYHLOI5/5Fo6hQQBAAA=
X-Change-ID: 20260718-ccaione-upstream-spl-fastboot-14fa2b6b2b64
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Sam Day <me@samcday.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784753007; x=1785357807;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m/hMIM7dswxNtSvk4e5KvUPSmadHFJxNXGFkshBe7zE=;
 b=FlowgeTx8/0219OzY85ghfSLVnlvU7GfZbdWDj23MRZL21EgWbhTYIjMsxnWAtjnag
 VDegBQP+agmP4IYgkgPJihgqrngAZPmbb2e+r+3EGwkLc6CKvkPE+E41/7uJodvq8YGP
 +e4yBRaeAq8ICR9/Ix3pxRbSMKXQ8rnKxFf2TXrreKeUp80BWdRIEE2rWLABKKpqczve
 jcm656eZJVVKI7nlsnrs8j1LjUz0rqAnALuPYFxsHrIVuHqLHs/QpUMHL73pfs2aU0Ne
 lh+DLrEe/EX+yVJmOqxTxZB7RLoj5/iAYEGYcKmtIY8FhksQcey0bmKGvikgpQOmG+eE
 nlrg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FlowgeTx
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Some recovery and initial-provisioning flows need a standard host protocol
before usable firmware is available in persistent storage. U-Boot already
provides fastboot, but the implementation can currently be started only
from the U-Boot-proper command line.

This series makes USB fastboot available as an opt-in SPL service,
including MMC partition flashing and Android sparse images. The interface
is kept deliberately narrower in SPL: it does not support the boot command
or filesystem probing, and reboot support remains platform-dependent.

The first four patches separate the generic preparation from SPL
enablement. They factor out the USB session runner, route USB reboot
through the common handler, make shared fastboot configuration phase-aware,
and add phase-aware sparse-image support. The final patch then contains the
SPL-specific Kconfig, gadget behavior, and documentation.

No fastboot code or supporting library is added to SPL when SPL_FASTBOOT is
disabled, so the feature has no size cost for existing SPL builds.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v2:
- Split the common USB session runner into a prerequisite patch.
- Route USB reboot through the common fastboot handler separately.
- Split phase-aware fastboot configuration and build rules.
- Split phase-aware Android sparse-image support.
- Keep SPL-specific behavior in the final patch.
- No functional change from v1.
- Link to v1: https://patch.msgid.link/20260719-ccaione-upstream-spl-fastboot-v1-1-c9bab5b0ba72@baylibre.com

---
Carlo Caione (5):
      fastboot: factor out the USB session runner
      fastboot: use the common handler for USB reboot
      fastboot: make shared configuration checks phase-aware
      image: sparse: add phase-aware SPL support
      fastboot: add SPL support

 cmd/fastboot.c                  | 60 +++++----------------------
 doc/android/fastboot.rst        | 27 ++++++++++++-
 drivers/Makefile                |  2 +-
 drivers/fastboot/Kconfig        | 89 ++++++++++++++++++++++++++++++++++++++++-
 drivers/fastboot/Makefile       | 13 ++++--
 drivers/fastboot/fb_block.c     |  9 ++---
 drivers/fastboot/fb_command.c   | 58 +++++++++++++++++++--------
 drivers/fastboot/fb_common.c    | 25 +++++++++++-
 drivers/fastboot/fb_getvar.c    | 19 +++++----
 drivers/fastboot/fb_mmc.c       | 36 ++++++++---------
 drivers/fastboot/fb_usb.c       | 68 +++++++++++++++++++++++++++++++
 drivers/usb/gadget/Makefile     |  1 +
 drivers/usb/gadget/f_fastboot.c |  6 ++-
 include/fastboot.h              | 10 +++++
 lib/Kconfig                     | 11 +++++
 lib/Makefile                    |  3 +-
 lib/image-sparse.c              |  2 +-
 17 files changed, 328 insertions(+), 111 deletions(-)
---
base-commit: 1b8283bd3220e898d338fb98929f0b06ed63da84
change-id: 20260718-ccaione-upstream-spl-fastboot-14fa2b6b2b64

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

