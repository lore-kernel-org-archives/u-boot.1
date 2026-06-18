Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17222CD98F9
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 23:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6061B849BD;
	Fri, 19 Jun 2026 01:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D2dGzrFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04BB084671; Fri, 19 Jun 2026 01:55:07 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E75FF8460E
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 01:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A0B1601E3;
 Thu, 18 Jun 2026 23:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3423C2BCB0;
 Thu, 18 Jun 2026 23:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781826902;
 bh=nHFgMFWwOjqnmFmXMHbQRHkLSvdLTzaO1FJbdAgIDKg=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=D2dGzrFkpuViHOhK/YwJcU4YWi2iLePsmnTvWV6AC3AzWZ0HIG1BFYxAx9T2i/lyB
 ewbwh/+iTBLzv8btTf0nSME9OTpfWKjzUbQ93iJVqiER7rDhk6E3xw3u0G4Iv57Z1K
 SkcONHsRKsS1s6UzOba7mpkfmqk7Laz6/DZrJ/3SIkpUtjwRgsz5C4uWJG9Z8OXYnC
 08WQdLLXkAOZpVtCRtiVHALvj80Yc2Hx+EIwMnIwZMRXKhg1AJUVIHddQvNAxYHmJf
 tMcV5Jut54wm6gQFHsMbTv8/LKbQ2IiJbsvTNEx4Nkc7Quv8EcE34Ak7XQh/xwS7RK
 53iDTptTYA7WQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D3B7BCD98FA;
 Thu, 18 Jun 2026 23:55:01 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Subject: [PATCH v2 0/2] Fastboot abort key support
Date: Fri, 19 Jun 2026 09:54:59 +1000
Message-Id: <20260619-fastboot-abort-keyed-v2-0-684e53949a42@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WPz07EIBDGX6Xh7BiglHZ78j1MD8MwuER3UcDGZ
 tN3F7sHvXn8ZvL9+d1E4Ry5iLm7icxrLDFdm9APnaAzXl8Yom9aaKmttFJDwFJdShXQpVzhlTf
 2oKQ1TGTH0bNo1vfMIX4dsc9L0+dYasrb0bKqn+s/gasCCUYZRBpQWjc9FbyQx+2R0kUs+70j8
 8dnW1zvRcJhYWj/S6xzp3iSzC3CKLJKBzmM04in3jkOhi0brVmfvBJ/SRv4MUsNv7N8IqCa34C
 gD0hjP6iJAs+NY9n3b0P5eF1BAQAA
X-Change-ID: 20260602-fastboot-abort-keyed-1064ecc677de
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781826900; l=1491;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=nHFgMFWwOjqnmFmXMHbQRHkLSvdLTzaO1FJbdAgIDKg=;
 b=J+c3y3ps5WmNZMurdORBM1TxLo06lKhr+kYvcnrko8Sd6EKNfIG61ZkuUd9WSD0123ypeIBXs
 M5lqFhtgfEsCZCD5K9IEP9bCExaTM5qfz8JrJK06b31DbK8xn34a52y
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

UMS already offers CONFIG_CMD_UMS_ABORT_KEYED, which makes it possible
to bail out of that mode by pressing any button, rather than only
responding to ctrl-c. This is particularly useful for phones, where it's
not possible (yet... hmmmmm...) to send a ctrl-c command with the
available phone buttons.

This simple patch series introduces equivalent behaviour for fastboot,
and enables it in the qcom-phone.config fragment where it's most useful.

Signed-off-by: Sam Day <me@samcday.com>
---
Changes in v2:
- Fixed helpstring for new kconfig option to span 2 lines, in order
  to please checkpatch.pl
- Added a note about the new config option to doc/android/fastboot.rst
- Link to v1: https://lore.kernel.org/r/20260602-fastboot-abort-keyed-v1-0-414aac5a06b8@samcday.com

---
Sam Day (2):
      cmd: fastboot: Add keyed abort option
      board: qualcomm: phone: enable CMD_FASTBOOT_ABORT_KEYED

 board/qualcomm/qcom-phone.config | 1 +
 board/qualcomm/qcom-phone.env    | 2 +-
 cmd/Kconfig                      | 7 +++++++
 cmd/fastboot.c                   | 9 ++++++++-
 doc/android/fastboot.rst         | 4 ++++
 5 files changed, 21 insertions(+), 2 deletions(-)
---
base-commit: 1e80ee41441c612f05787a93bbef4e6e422e29d1
change-id: 20260602-fastboot-abort-keyed-1064ecc677de
prerequisite-change-id: 20260615-fastboot-doc-ctrl-c-3fac73518cfe:v1
prerequisite-patch-id: b948dead04c3a24a47a8d8dd7f03590565a8ff6c

Best regards,
-- 
Sam Day <me@samcday.com>


