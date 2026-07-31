Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE1FC55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 10:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6801940F65;
	Fri, 31 Jul 2026 10:20:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6WdN29ohCmUn; Fri, 31 Jul 2026 10:20:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E83B40FB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785493203;
	bh=F0pizMGeNCojOpT1357N6Wh837+7y3xuVd7/Ez0KT1U=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=h1Hf2sWQUERV/HfUVAKMJWRMxYplIB5ZDJdwsaeMP06cfaJGQry5Zh3n9j/jfgB9p
	 +918hWlJKBTm/5onBbqmV5bntvRFx7WADX0WYSHcnsURi1EdF1KKjhbfUB/weWE2er
	 hrEqyPlna2ysmgg5Z5FAqs/y4CV4Q7IEB9r1te2TrPDkqMEoLC+bkhd51FnNvGpnNN
	 CNbz59prMqaL96NA4lFG59pQiSWHeaR7PFeU5dTHDCIL22D+xja9HvuhtMyzOteTnt
	 5uCRSUh3s3aHPRFuLnOfBFGPJ39lTn7HUbDQBPElbhW+K+/raRC809Uysxo8UNvlqX
	 Dv3Y6/yvogzkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E83B40FB8;
	Fri, 31 Jul 2026 10:20:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 784BA197
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5EA9240FB8
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:20:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DQalyPiPOjmJ for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 10:20:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.121;
 helo=smtp-relay-canonical-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3445940F65
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3445940F65
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3445940F65
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:20:00 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6F17B403B3; 
 Fri, 31 Jul 2026 10:19:57 +0000 (UTC)
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lib: correct list_guid[] array
Date: Fri, 31 Jul 2026 12:19:50 +0200
Message-ID: <20260731101950.82084-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785493197;
 bh=F0pizMGeNCojOpT1357N6Wh837+7y3xuVd7/Ez0KT1U=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=bCgL8TagQ79LbSrjHVr250DQZp6PrZPUyuxUT8KzIBQFzw3rX111X7OjZpMSGdjju
 hETLY7TfryJYjWyIjsKmS5jfJ0ZgIGjsNcsJbbP+g6hStZriJC96KPMqnXgEiZRrfh
 ZMuvuLCcZQaAolO/YDaadGmXDGAbOsGqDzufcAEAwM8n1KVxSAy4g8pwX8XVg9lx43
 4PsRPDVqkIh9VrYyA6Cv0ssPgpKCDKPSBbd/+p6EHGADVmWG5fIvTbuA2W+BUJdKSr
 fi/kWbitEG5XENwKzULIXeS78mz9c5w0EIOXVSNuqg9oHlDraTtDP1zIQJR5um9EYK
 3lYb/0GpIHTAaDymYlA0gZMMJdg+ceZrzc4bgddwvXiVJsl+SqUn7AtaqYhaiH76/H
 qzfjQ0XmYsc8KFENRjYhWnj8vsQhap7J31y90W76S4IRkkolpxkNSNYQvD7fdBHX75
 4WYceAW2GiVHrMLcpF8rrp9p6ZojVmdhgUS8/d08vhzA0gf0pm6SdYF9gm44E6o5Xo
 19X3RqN5kRLcOJSZ1yg5n/eDbU1snOSKGlt8OL0arPia99QfNgehYe4p+1AFqWhsPx
 Jw7hCEubO9y6k1BEzC02wght/kP33V0wCRenPCSoqW7SQI3wQlRK3L4DUbgH2GjZP/
 d3TPNteurwv0OcCptyASHv/E=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=bCgL8Tag
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
From: Heinrich Schuchardt via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The #endif for #if CONFIG_IS_ENABLED(EFI_PARTITION) was misplaced.
CONFIG_EFI_PARTITION=n disabled all entries in list_guid[].

CONFIG_EFI_PARTITION must only control the translation of GUIDs for GPT
partition tables.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/uuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index d7c164ea06b..16ca8f37751 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -95,6 +95,7 @@ static const struct {
 		"system", "EFI System Partition",
 		PARTITION_SYSTEM_GUID,
 	},
+#endif /* EFI_PARTITION */
 #if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_CLIENT)
 	{
 		NULL, "Device Path",
@@ -304,7 +305,6 @@ static const struct {
 	{ "EFI_MEM_STATUS_CODE_REC", NULL, EFI_MEM_STATUS_CODE_REC },
 	{ "EFI_GUID_EFI_ACPI1", NULL, EFI_GUID_EFI_ACPI1 },
 #endif
-#endif /* EFI_PARTITION */
 #endif /* !USE_HOSTCC */
 };
 
-- 
2.53.0

