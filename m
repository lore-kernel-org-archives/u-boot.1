Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2509DD6ACE9
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 11:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9328783D00;
	Thu, 18 Dec 2025 12:44:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09F8D83DA6; Thu, 18 Dec 2025 12:44:52 +0100 (CET)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 920EF83C54
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 12:44:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dX83P1rWCzFqc;
 Thu, 18 Dec 2025 12:44:49 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dX83N3x9zzd3M; Thu, 18 Dec 2025 12:44:48 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v2 0/3] cmd: bdinfo: further document
Date: Thu, 18 Dec 2025 12:44:40 +0100
Message-Id: <20251218-b4-bdinfo-doc-v2-0-2fb328750026@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNOw7CMBAFrxJtzaKs+ThQcQ+UIrbXZJsY7BARR
 b47JhRUlDPSm7dA4iic4FwtEHmSJGEooDYV2L4bboziCoOq1YEUaTR7NE4GH9AFi02tSXNnldM
 KyuYe2ctr7V3bL0d+PEt2/Mle0hjivH5O9LH/8hNhjc3OeO2doeOJLrbnGOetY2hzzm97x1nyv
 wAAAA==
X-Change-ID: 20251217-b4-bdinfo-doc-80717eac2d72
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

bdinfo is missing a long help text for the additional -a, -e and -m
options so let's add them.

While at it, update the sphinx docs to add missing requirement for the
devicetree field to appear in the output.

Finally, update the sphinx docs to provide an example of bdinfo -a, -e
and -m as well as make their Kconfig dependencies explicit.

This depends on v2 (but will apply without!!!!):
- https://lore.kernel.org/u-boot/20251218-bdinfo-lwip-v2-1-f6188a2f376a@cherry.de/

Do not apply if another version than v2 for the dependency is merged as
the symbols may have changed and then the docs are wrong.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- fixed bdinfo cmd unit tests,
- changed series dependency on v2 of the dependency,
- Link to v1: https://patch.msgid.link/20251217-b4-bdinfo-doc-v1-0-83bf7fdb1691@cherry.de

---
Quentin Schulz (3):
      cmd: bdinfo: provide long help with all options
      doc: cmd: bdinfo: specify required dependency for some info
      doc: cmd: bdinfo: document options

 cmd/bdinfo.c             | 16 ++++++++++++-
 doc/usage/cmd/bdinfo.rst | 60 +++++++++++++++++++++++++++++++++++++++++++++++-
 test/cmd/bdinfo.c        | 11 +++++++++
 3 files changed, 85 insertions(+), 2 deletions(-)
---
base-commit: 6e483607bdfdd85c3cd5281be700fd5b28bd4ec6
change-id: 20251217-b4-bdinfo-doc-80717eac2d72

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

