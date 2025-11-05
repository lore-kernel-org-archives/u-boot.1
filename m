Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797CFCCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 23:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05BCB83A15;
	Thu,  6 Nov 2025 00:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ms65hFtd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A22583AC5; Thu,  6 Nov 2025 00:32:28 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B65839FA
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 00:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B0DEF401CC; 
 Wed,  5 Nov 2025 23:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762385545;
 bh=l2LLEYugGtLxkjUaMIGTgp1Z5MNoLj0KsssfkbUjmQI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ms65hFtd6fO8e8uY5JKHAYMa94dQmL0jRMd/MT2LdH24VTrEq8OIlEnuYDn2Wlc8/
 kERuaBPyTZgSnnV+ePYQS1Xd8xipX30YULLctntMCEylqQLGzo637DnXKOOM6D3k4Z
 n1UUKJWuzhpyPxUM6RcM9/In37xPP2jeXfUAp4HgQ+4SceRODUWu+X9j0ifTxfSTCv
 uEcx1V7iJ9LGFWEAJ0jC/vJhf3HydBMpWowNiEbHlWWuVZfiy9D8zVvdSTo2C43A2G
 xC9kuNPnrkcjSlT49D+51gVQnReIh4y//RJLuz1wvnflhr8CG422r3O6cBT1lb3c9w
 xIcsfS7UoHcDFZK+GdftNC5K2L2yRhap9V6YcxLKRZLHpow4wwznfHYBUdh9NYQqZ/
 Hn0/UYTTmzboyhxWwePlFpGFvukj0Bo270YcRL3z7l3rwKOgQM79sIBCbqe/g1hZ9p
 jJ4uBVM4JpIddzmR4iz+D+orUJGfgYJp6/MNUuUfLbaLj063/LowQ91r45RgAEDWig
 tm7pK3QUugQiCwDbnrnBSgyWL9N+4JXou7otO7DQpnC/21052Kjy3T4PdaSSrK+igK
 eAgtm4j141fMSrEsDXLcQBHbEsqCuDeEySi/pFcAxGU+lW1qJiqQyW4ryGIeSbnDJp
 OeR+iFKlCTuf3CnfHXlgz/vc=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: fdt_test_apply requires CONFIG_OF_LIBFDT_OVERLAY
Date: Thu,  6 Nov 2025 00:32:17 +0100
Message-ID: <20251105233217.124892-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

The `fdt apply` sub-command is only available if CONFIG_OF_LIBFDT_OVERLAY
is enabled.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/fdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index 6b07999c88f..1b5f8d92249 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -1323,6 +1323,9 @@ static int fdt_test_apply(struct unit_test_state *uts)
 	char fdt[8192], fdto[8192];
 	ulong addr, addro;
 
+	if (!IS_ENABLED(CONFIG_OF_LIBFDT_OVERLAY))
+		return -EAGAIN;
+
 	/* Create base DT with __symbols__ node */
 	ut_assertok(fdt_create(fdt, sizeof(fdt)));
 	ut_assertok(fdt_finish_reservemap(fdt));
-- 
2.51.0

