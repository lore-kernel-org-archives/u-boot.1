Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728FCC44512
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 02:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E1A847AF;
	Fri, 17 Jul 2026 04:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kleiner.pro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kleiner.pro header.i=@kleiner.pro header.b="GBTr81PF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E9C84DA2; Fri, 17 Jul 2026 02:06:49 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CA2384D68
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 02:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kleiner.pro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris@gracedigital.studio
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-667b9bee563so861069d50.3
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 17:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kleiner.pro; s=google; t=1784246806; x=1784851606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w+Cuy9XdD4okEqKJGFTd6ccked1Vup5+fbMXEy8pgYk=;
 b=GBTr81PFeL9N2MmbwQOSoKDW3sAsBaGQVWvB1U6xxQKyESyF52cGZXryUy0hr2N537
 w8jdq3VWWx3vaQeDRol34FyyUm+XuL8ygAaRqz/G/7Cdj/k22mTXHrQdQXFJMX8oT3UE
 Ybf8Siamb7FrqEl2hwnWN1G1DMtLOMUAPKhgZysO9/b9VnM4nj4L50LP6YC4/La1Roqd
 cMmjLqdUOVxBHy0i8LJK3Xx0BAj3rW4w5OCLgZUfC3sh+NA09I6rHoxDGQ11lelEKVgl
 vRxkdQgwkMhN4FkYY2T6H+7alc4qvNx8NJea1YevnH3olv4YYRF7PKxdbKc+bNvc1KVs
 OApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784246806; x=1784851606;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w+Cuy9XdD4okEqKJGFTd6ccked1Vup5+fbMXEy8pgYk=;
 b=NTVGQlFtew2PEpMgKnvrHHrcfLz9dzZ9Pvn5A/2UlFSMORILCWB/CQYZ5BCv2H8CPs
 PMtcRIIIKWLWOpjKbT9+oXQXh1ddbYy/TeIa//z6VpjLh2yRKiwU0Os0JMFh53K0HxZ/
 AT4CC7abWr18qwRf3Ly2L3F0ZHGDiAZR93xzqr3zjehUKQz/5Cn6RtstBxApHLol9/VX
 IgNBMDCwWfP3yrce1WyIcB1jF1TS+X0YEfDEYOGSWYqnFlJj34ARhQDEGqiXdN8JmfSN
 4ajgN1EHKmmGtTxXSqMHRlvzNMMHmLkrib9GbIgDUbOBBXwmHO5tD83YIO6ciFq/gRCQ
 c5Vw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmKiNnO73UxM0DrxixEoYg4RiHOw/DtUW/9Rm9RLmemjF30/oIUmd3LvPjx9/6Ny9ZSvkQNhw=@lists.denx.de
X-Gm-Message-State: AOJu0YyHRJ7qbZNU1dzmTu27obWf8H5Z+HcPRTI8srS3OZ6J9rde4Zcx
 N5kIAq3S3Njv/dRfsLIp17mtFH+66m00sFkYUNRffu4sudFTIgSIcVdHTpHqUOK9GAeSK7PsYfZ
 h6AlvlSBf
X-Gm-Gg: AfdE7cnbPeNgHb5V43OGYEkKWUAlEVKXmTIfDPan6LyyxjVZB1mQsDYAtj46JguQGPB
 d4/4BndTGCpSIccN//ZjLi6/a9D0KFSg8Q15R0k57fyVJpKa7hrAMcH/I8kX5MRcPQTr3Agu/KX
 nUhsQLf3DfcOFQw0/85qU0Z6i92fE5G8bRMqAbZb4PllWdfRDSHxCIgAOHCLwF3EBehkfzg9CNF
 ln0BGTwIIQooneUqImR7XEpQgG3H10DjzgWIEYOcFmlgsioZxkW7fC34s/jQYLs5DNsNPPEDFii
 VSbR4A4/1x8a9AwKbnHXjhBY0VXman0TX0fdwaju98h7QRoAs+GdKYovSBmbxpH+UlH1+hm++RB
 KttKcAOw8StUoftYg3ePlyZwuZZoGum4JsPs+RQ2JI8nxkBfOejcC8U+uDm90jJcZMswwTRLVPS
 SuiDzDzvLjdb6yFuIyIYxodGEl
X-Received: by 2002:a05:690c:e28d:20b0:7fd:6d19:5a8d with SMTP id
 00721157ae682-81e902bd271mr122998817b3.8.1784246805600; 
 Thu, 16 Jul 2026 17:06:45 -0700 (PDT)
Received: from localhost.localdomain ([217.180.197.172])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6683b8cd3aasm36755d50.21.2026.07.16.17.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 17:06:45 -0700 (PDT)
From: Christopher Kleiner <chris@kleiner.pro>
To: trini@konsulko.com,
	u-boot@lists.denx.de
Cc: tharvey@gateworks.com
Subject: [PATCH] board: gateworks: fsa: bound FSA EEPROM gpio descriptor count
Date: Thu, 16 Jul 2026 20:06:44 -0400
Message-ID: <20260717000644.61897-1-chris@kleiner.pro>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jul 2026 04:10:26 +0200
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

fsa_user_info.gpios[] is a fixed 20-element array, but the number of
descriptors iterated and indexed comes from the FSA add-on board EEPROM:
board_info.sockgpios and board_info.ioexpgpios are u8 fields (up to 255
each) read via dm_i2c_read() with no upper bound.

fsa_config_gpios(), invoked automatically at boot from fsa_init(), loops
over info->gpios[i] for i < sockgpios + ioexpgpios, reading past the
20-element array (an out-of-bounds stack read whose contents are then
used to configure GPIOs and build names). do_fsa_gpio() validates the
console-supplied index only against the same EEPROM counts, so
"fsa gpio <i> ..." can memcpy() a descriptor to user_info.gpios[i] for i
up to 254 -- an out-of-bounds stack write that is then written back to
the EEPROM.

A malicious or swapped FSA add-on board EEPROM (only a valid checksum is
required, which the attacker can compute) thus yields OOB accesses on the
boot path and via the console command.

Clamp the descriptor count to ARRAY_SIZE(info->gpios) before iterating,
and reject any console index outside the array.

Fixes: da9e2218afc2 ("board: venice: add FSA support")
Signed-off-by: Christopher Kleiner <chris@kleiner.pro>
---
 board/gateworks/fsa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/gateworks/fsa.c b/board/gateworks/fsa.c
index 1af8021057..126a897ee2 100644
--- a/board/gateworks/fsa.c
+++ b/board/gateworks/fsa.c
@@ -140,6 +140,9 @@ static int fsa_config_gpios(int fsa, struct fsa_user_info *info, int gpios, stru
 	int i, ret, flags;
 	char name[32];
 
+	/* clamp EEPROM-supplied descriptor count to the array size */
+	if (gpios > ARRAY_SIZE(info->gpios))
+		gpios = ARRAY_SIZE(info->gpios);
 	/* configure GPIO's */
 	for (i = 0; i < gpios; i++) {
 		desc = &info->gpios[i];
@@ -637,6 +640,11 @@ static int do_fsa_gpio(struct cmd_tbl *cmdtp, int flag, int argc, char * const a
 	memset(&desc, 0, sizeof(desc));
 	i = simple_strtoul(argv[0], NULL, 10);
 
+	if (i < 0 || i >= (int)ARRAY_SIZE(user_info.gpios)) {
+		printf("invalid index %d", i);
+		return CMD_RET_FAILURE;
+	}
+
 	if (i >= 0 && i < board_info.sockgpios) {
 		desc.offset = i;
 		desc.source = 0xff;
-- 
2.43.0

