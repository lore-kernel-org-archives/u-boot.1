Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C6AC47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 21:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F3F187B77;
	Mon, 29 Jan 2024 22:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="f2b96Dd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFF8187B1D; Mon, 29 Jan 2024 22:05:06 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E891087B77
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 22:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DA4F83F27D; 
 Mon, 29 Jan 2024 21:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706562296;
 bh=LdqwQ3v14DOJ8Gl0TewUvW0g/9QSitsz+qatYuOAkxU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=f2b96Dd37UIx00EoaNhhVq4y+Jvlco2x6NOH3yDC5XorxhHtroAZRWs2SmccHAGLX
 f/x4XjmrBNGmG/GPgRCRFuCPlNhwrxM0y8Fce/gHS9rSU3BurcK1y032bqHiqL+L8P
 zp+lR/GPg7ygmNlQNO/e0m+Ms9m8/YZ4Pgva+XtZ4kU0VCMSW0lUDnnkiOnxMyhfZf
 2Xu6xQ0wvT/iyZBbkaILY3QAGcMJObcUA+AHEYWzMqzpTfSfEewlKSB9AL8UNgmbbs
 97a6t+uccEB86QN+lQ0OlwNcTy1oASpw3cHj4+2+NJeOzm2fXJmioAYDpyJ3Z2R6OT
 k9vJv9OcEdUWA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/7] smbios: missing strings, RISC-V processor ID
Date: Mon, 29 Jan 2024 22:04:46 +0100
Message-ID: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

When a string value cannot be provided we should not create a string
'Unknown' but just set the string index to 0 as suggested by the
SMBIOS specification. Program dmidecode will render this as
'Not Specified'.

Set the chassis handle in the type 2 structure.

In the type 4 structure fill the RISC-V SMBIOS Processor ID.

Correct the output formatting of the smbios command:

* Add a missing colon after UUID.
* Format handle references consistently.
* Render missing strings as 'Not Specified'.

Heinrich Schuchardt (7):
  cmd: smbios: always use '0x%04x' for printing handles
  cmd: smbios: add missing colon after UUID
  cmd: smbios: replace missing string by 'Not Specified'
  smbios: string table always needs two terminating NUL bytes
  smbios: if a string value is unknown, use string number 0
  smbios: provide type 4 RISC-V SMBIOS Processor ID
  smbios: correctly fill chassis handle

 cmd/smbios.c            | 12 ++++++++----
 drivers/cpu/riscv_cpu.c | 12 ++++++++++++
 lib/smbios.c            | 38 +++++++++++++++++++++++---------------
 3 files changed, 43 insertions(+), 19 deletions(-)

-- 
2.43.0

