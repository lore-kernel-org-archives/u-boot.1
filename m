Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0B2EE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77F6886A1A;
	Wed,  6 Sep 2023 23:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Rhfp/HpB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YoE4luM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 274D286A0C; Wed,  6 Sep 2023 23:30:50 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF97869EB
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RgwXR1FHLz9sn0;
 Wed,  6 Sep 2023 23:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fgbuYyeBPwouVBlOEQO6RR7qNO3iVX+NDO4ExBKCfs=;
 b=Rhfp/HpBKymaND/05q6UwEIVv7ydoZihZUHa72lcOTL0GldD5A1/R1HDkzVVmiEns7gP9J
 lkEuVqwOUgwzF4Ohfx8ndkx4k7dfweyQYU0y7Z+CwC5GMrRrlWdyRDdmKQ+hRWPNhKIN/U
 v8N5CxzxELhO7O3TbFCYzqgxXA39UDG+Y7XSaesH9anFLmGKh0GVJ+GMeXU2VnuESylaZG
 rB4Nm7e1/9BxrzDwVMGlzZZinejzRU9PfNqtFqfDmpUchJJ0P62z4+M+C54yFpiuMZ1zlk
 1Fw1hnoBXSDGacKBKbPMBajp5F6qcAbdhHTkaIMO0X7BEAAYlzgNNB4F8CdAZA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fgbuYyeBPwouVBlOEQO6RR7qNO3iVX+NDO4ExBKCfs=;
 b=YoE4luM0g7au8PHx9Wt4Mp4Vv8qrs5fXTB2kRY/K/gwxjRmjLP6kDQeKKFqtIHWJJF8LGk
 kXuSTXt/xBO01mpe741dw9SzEM7T4Bj8C+4zcXAhlZelEv4n+wKlX1fcyAgLzQOR7E+v0L
 j3nOurdo3H0Mi9D3eFoNTmGnq1vvKNhQbPPmfQ2Q37rOVAWa61Kgs2NKIGPjb1wJu0QLgl
 C+zNPokS09QsSB8S2hNJQChnqG0zdd1cS9bLKHNMjKeo6tXCEXmtzRWbx8Ce2CbhQzOzwf
 gx2Rd6MwH/mYcETEl0c+BJUGPLQIVZf/T/yoNjZVJj1hsoDUObt0W2ux2Ni5BQ==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 11/35] cmd: date: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:51 +0200
Message-Id: <20230906213015.203437-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c6557ea3d60047ea547
X-MBO-RS-META: g7tsz13apaxfr6ugjncsexeaans3z6ws
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 cmd/date.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/cmd/date.c b/cmd/date.c
index fe9c8c6534e..4f98b470ca2 100644
--- a/cmd/date.c
+++ b/cmd/date.c
@@ -20,12 +20,6 @@ static const char * const weekdays[] = {
 	"Sun", "Mon", "Tues", "Wednes", "Thurs", "Fri", "Satur",
 };
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-#define RELOC(a)	((typeof(a))((unsigned long)(a) + gd->reloc_off))
-#else
-#define RELOC(a)	a
-#endif
-
 int mk_date (const char *, struct rtc_time *);
 
 static struct rtc_time default_tm = { 0, 0, 0, 1, 1, 2000, 6, 0, 0 };
@@ -113,7 +107,7 @@ static int do_date(struct cmd_tbl *cmdtp, int flag, int argc,
 		printf ("Date: %4d-%02d-%02d (%sday)    Time: %2d:%02d:%02d\n",
 			tm.tm_year, tm.tm_mon, tm.tm_mday,
 			(tm.tm_wday<0 || tm.tm_wday>6) ?
-				"unknown " : RELOC(weekdays[tm.tm_wday]),
+				"unknown " : weekdays[tm.tm_wday],
 			tm.tm_hour, tm.tm_min, tm.tm_sec);
 
 		break;
-- 
2.40.1

