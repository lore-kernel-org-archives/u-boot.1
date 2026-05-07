Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71650CD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B263E84A7D;
	Thu,  7 May 2026 17:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="UE1tAAri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F28A84B23; Thu,  7 May 2026 17:04:27 +0200 (CEST)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [IPv6:2001:1600:19:e38::bc08])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1896284A7B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gBFs454tZzVHg;
 Thu,  7 May 2026 17:04:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1778166264;
 bh=9K602GnPIwULVUaJqDl4oPOFeYkc7D8MBA17pTBM3og=;
 h=From:Subject:Date:To:Cc:From;
 b=UE1tAAripX7joqu/hdOrARF/YYnVWd+7+Mah0YAHiobPi/yWztfnkNytmTm3nGjf1
 lKCYaqiHffubIma0Cfj2ik3UOy4U5wSceBvcaJajz5Q5kSALdqSJvrWvXzdAIUiXvI
 G9VqAGTSUeNrJP7KXm9RbZmnrQZN+MiEs2oB9dtgkLgZ4ie171j165RTbzLxOE+of6
 KirI0/PhkZ2tK/k8ZlD6ookb+YtnkHp+udnVeGvS4aCM7vUWIY7L6SQdeWNOXx3TUZ
 FAJXVQRJqc6+4ht2+JWa9POasssS9gHiNrKs4rBiDJZb/KjOqP0g2WhBYNe6ucUInF
 SHKxor53T4Hnw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gBFs35kjvzTll; Thu,  7 May 2026 17:04:23 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v2 0/3] cmd: reset: fixes related to Qualcomm's edl
Date: Thu, 07 May 2026 17:04:04 +0200
Message-Id: <20260507-doc-sysreset-qcom-v2-0-37fef7a9cf92@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7RjaVARX3sOwqO1UaiLVGSQS0
 rsLuHf5kvffn0GIIwmcihmYxigx9QvoXQGus/2NMPqFQZe6Ko2u0SeHMgmT0IAvlx4YDl4ra2u
 jjIZl92QK8bM1L+2P5X29kxvW0Gp0UYbE03Y6qtX71x8VKmwq44MhOjahObuOmKe9J2hzzl9Dh
 0dPxAAAAA==
X-Change-ID: 20260428-doc-sysreset-qcom-f5d21aa84142
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

Fix a missed dependency on the edl reset command option for deciding
when to show the option in the help text.

Fix typo in reset command usage documentation.

Fix missing edl reset option in reset command usage documentation.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- added patch 1, fixing edl option being shown even when not usable,
- added patch 2, fixing "Do warm WARM" typo,
- added -edl to the synopsis,
- added requirement on CONFIG_SYSRESET_CMD_RESET_ARGS=y to docs,
- added info that an error message will be printed on unsupported
  platforms but that the command will still succeed,
- Link to v1: https://patch.msgid.link/20260428-doc-sysreset-qcom-v1-1-964df4ee79f9@cherry.de

---
Quentin Schulz (3):
      cmd: boot: fix edl being shown when not supported
      doc: usage: cmd: reset: fix typo
      doc: usage: cmd: reset: specify when the -edl option is available

 cmd/boot.c              |  3 +++
 doc/usage/cmd/reset.rst | 12 +++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)
---
base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
change-id: 20260428-doc-sysreset-qcom-f5d21aa84142

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

