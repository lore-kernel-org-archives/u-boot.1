Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D603C44525
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 09:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7725983E76;
	Mon, 20 Jul 2026 11:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="gfyQsSEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E5A284119; Mon, 20 Jul 2026 11:42:20 +0200 (CEST)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::42ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B42DF80517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h3bCF1xsHzX0n;
 Mon, 20 Jul 2026 11:42:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1784540537;
 bh=vOyAKwWyPQFzK5Ra3UClQc6lH9UYd/TbKvR9cjl8Rpo=;
 h=From:Date:Subject:To:Cc:From;
 b=gfyQsSEeg6zsvLQzuyzJYDdgbae3ooMRDSNVa4kryHvTZCuE4a6oYNerMbXpDHSP0
 BGDue/ZadT1S2PoImlzLhFtmq9fgzKNRNXfUkGZq6UBd3oOc21Q0QnQeIct00/qUyf
 mDKtetaYZdrvWyd2qCkEE9feGBI12sHPyh5Nye3iYgUakMdntZqF6F1WPinKbO9YRR
 +CGDwDoJYDQXhixYtyXV5pXaUIMb+FlkgL8tZPQ29Ug+37rlpw7vza1/6Fg71AERxd
 3s3AL5AJhi8sPkDyssjAT2uwu/Z4n8k6fe66Ac6hAuTpoqx7I9I2tk5FP12XoA/Pz/
 HHRPUyVQosXEg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4h3bCD40PKzMZS; Mon, 20 Jul 2026 11:42:16 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 20 Jul 2026 11:42:01 +0200
Subject: [PATCH] MAINTAINERS: update ARM ROCKCHIP entry to list Simon as
 reviewer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-sjg-no-rk-cust-v1-1-38eebe54c349@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAxA0atI1hOopVTxKoOLWqNGoQ6NFUG8u
 9VZvsX/JwhFJoGmOCHSzsJryCg/BfjJhZGQ+2zQSltVaYUyjxhWjAv6JBs60ytnytpa4yFHv0g
 DH+/w2/4tqZvJb88FrusGtzaiK3IAAAA=
X-Change-ID: 20260720-sjg-no-rk-cust-a4d0a418664c
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16-dev
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

From: Quentin Schulz <quentin.schulz@cherry.de>

From his own recollection[1], Simon hasn't done PRs since Kever took
over, 7 years ago. Moreover, he doesn't have rights to push to the
Rockchip custodian tree on the old source.denx.de or the new
git.u-boot-project.org.

Therefore, let's reflect the reality and make Simon a reviewer as
requested on the mailing list[1].

We thank him for the many years of being a custodian and reviewer for
anything-Rockchip.

[1] https://lore.kernel.org/u-boot/CAFLszTjXkx0Jw0yjNXXwdXrQYre7Lcs59m_Bc27QW0n0c+WaJw@mail.gmail.com/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5b2a2e373cf..d9ff6b4f8282 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -554,9 +554,9 @@ F:	drivers/sysinfo/rcar3.c
 F:	drivers/usb/host/xhci-rcar*
 
 ARM ROCKCHIP
-M:	Simon Glass <sjg@chromium.org>
 M:	Quentin Schulz <u-boot@0leil.net>
 M:	Kever Yang <kever.yang@rock-chips.com>
+R:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-rockchip.git
 # Exclude from N: px5 matches

---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260720-sjg-no-rk-cust-a4d0a418664c

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

