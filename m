Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EBBC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 08:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A7487929;
	Wed,  3 Jan 2024 09:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PD9QrJnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8377A87980; Wed,  3 Jan 2024 09:07:37 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E62786FD8
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 09:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 54C123F722; 
 Wed,  3 Jan 2024 08:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704269253;
 bh=yK1IbKgJ6Udhq4s9X6oVP0DebD4VXsWt8AHs6HAKQoM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=PD9QrJnUZaw3WJkSK8/96/Yok+/BH25g4RhQLfKZD3w0ztWmtqnRUJHbf4rYgXWBR
 mrAppyCrAaFIfrMSMr687oGaqVqUeB7jxaRzg54srJ2CtRDpDJI2cvzugqjoKrshrv
 jynO6XhKSgnnsHK8ZxQUgGUr6/oYXa1ZQltu7MREybJSXs6cMzkpyQpbAp8AlAodGn
 uIcgymGiOqLh12KAIoxutrmiYIH8wtlxV2i0/vM5dI44gsy6fz1a96xxxTs7E8CvwU
 l8nJozf3yAvgaNXtHukTWfckqn25bulaTK6rkWJDRY8d88cinNKx+BEJ1cjyfs44rN
 Te0BJNr1QQDCQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/2] efi_loader: provide tool to dump SMBIOS table
Date: Wed,  3 Jan 2024 09:07:19 +0100
Message-ID: <20240103080721.22292-1-heinrich.schuchardt@canonical.com>
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

An EFI binary smbiosdump.efi is provided that can be used to check the
SMBIOS table for consistency and to dump it as a file.

As a prerequisite remove superfluous include from smbios.h.

v3:
	rename the tool
	restructure the code
	catch missing load option argument
v2:
	remove dm/ofnode.h from smbios.h
	fix a wrong variable usage on dmidump.efi

Heinrich Schuchardt (2):
  smbios: smbios.h should not import ofnode.h
  efi_loader: provide tool to dump SMBIOS table

 include/smbios.h            |   6 +-
 lib/efi_loader/Makefile     |   7 +
 lib/efi_loader/efi_smbios.c |   3 +
 lib/efi_loader/smbiosdump.c | 622 ++++++++++++++++++++++++++++++++++++
 lib/smbios-parser.c         |   3 +
 5 files changed, 636 insertions(+), 5 deletions(-)
 create mode 100644 lib/efi_loader/smbiosdump.c

-- 
2.43.0

