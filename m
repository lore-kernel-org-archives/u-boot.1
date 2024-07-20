Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D00BC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D484388C67;
	Sat, 20 Jul 2024 14:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HDygR2AK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eIAs9mHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 335DE88BAE; Sat, 20 Jul 2024 14:43:48 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D91888655
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WR5nZ0wQgz9sRn;
 Sat, 20 Jul 2024 14:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=taYDq55o7jIdf37j1ccOteZNWHtzk8VJ25IINrLAm3s=;
 b=HDygR2AKAPR4tbDLOezsuyah9JyBLzVvXFkqPB/oM23n++l3/xNMgorkg2mjaYHRYwOvce
 ZpsA0HiIsM8I7nLW19QVbZiyLKpiGWpTmOYdoJvPZqnft77mnFgdMUP+3Igv3Nj0TOcnrk
 atwFNo3uj9TIiVTqIhbXiwi0Lwtusq+GC1aARewXw9jDZhUZJrnxBF3mSZgKss7GGCiUm6
 7DXbXC5taieV8x0WZfr2UiCHOD6+zKLG7nAXrONPeLkLfzd7ICSq9SPoxRiKYVF6n9q1kd
 Nkj2TZwUEh2OeZzm1CbU4iCqY22H0wMQzyGlcQkmf1Dc2GEEQEs3S2ijRxotEg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=taYDq55o7jIdf37j1ccOteZNWHtzk8VJ25IINrLAm3s=;
 b=eIAs9mHC7mor8Yx+i/PTwsDEDO93KjfFIDYW07W8m+vgQ6HnFwtXZnCFCxMes1J8XlkmqK
 0IoVgpatGIxiYtxOopxxyIWG+2Iq+Js9tqy+o/bg0IW+WIyw9G6MumjbXymtHmlz4AKxu3
 fvAuSmr6IOG9at38RlFwgqQIX8AyhwMYg2UWnWazvm8X9jNQ7bBknRR/FJk4evRz+PAAYY
 +8xVZikSd1GpFKjVHW5PpnKbfAfcI3XFSDdMuy+wSu1Y0wbK2dQUjxHAo3YIB0jty25fRL
 yRtlAEHds2/z/yUgNklznU1U7Rb+hEOFlEDmT1CN/CwGRwEcshjSQvdRsVdotA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 15/40] drivers: input: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:40 +0200
Message-ID: <20240720124239.7553-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0314f1dce14ae11558a
X-MBO-RS-META: eydjw7gg8c4pshqr7foo8ezr37gpw3bc
X-Rspamd-Queue-Id: 4WR5nZ0wQgz9sRn
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/input/cros_ec_keyb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/cros_ec_keyb.c b/drivers/input/cros_ec_keyb.c
index 0917ee20fed..dd1e1bc468e 100644
--- a/drivers/input/cros_ec_keyb.c
+++ b/drivers/input/cros_ec_keyb.c
@@ -28,7 +28,6 @@ struct cros_ec_keyb_priv {
 	int ghost_filter;		/* 1 to enable ghost filter, else 0 */
 };
 
-
 /**
  * Check the keyboard controller and return a list of key matrix positions
  * for which a key is pressed
-- 
2.43.0

