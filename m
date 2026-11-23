Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8E8606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=flVq2zM4;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=EiEMjx8t
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB96E40695;
	Mon, 23 Nov 2026 12:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pazbvDbXZ3s4; Mon, 23 Nov 2026 12:07:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD85A405F4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795435648;
	b=Pm6OAV+4nfhq1ceYH6YWSsMFWAQAR+mp2WNk1mCaBi9XJHBPyp0NlMPLIF91jZ1DJ50S
	 cJ1u/kUHxp1p1WCOt0wpNY66iK4kBRkuQp8ZPVwOd2vM77W+5DO5gUkwAIPRRyobYtDTT
	 ikOkaR1y07tuxrC9x7oA1LDAJ+5PSP/pzT2o0U1dyvctorxZwuw0otCF7pnTIAghYNaO1
	 RYddHbG05YeWVeof8wMN0hklJxNVgXC7D8lKEltj41hqNc/tsD9nF8Z1tV62+Iwr+QopI
	 97cLnxn0q4KM7RDnkZ7EmTAgHjNQvbEXDUlBcsMKbDQ1xG+dxXxmBujD4YRg+RyWGcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795435648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K0FnyW2TQ1qgvH9wIXqYteYZMooGkWBNcMVkAHd+9RU=;
	b=h8vT36Ot8kZar2UV4U3XMjyaXxGW2VcFPB1BtygdP24H1xinBeLJjU1rAMjuEr1e4hev
	 uJcJ51+4pn2Sj1xcYumxnqWi115BDPhj5hKGVY/Br8EHEFFyl2eJsMqnc7izDbmxO+QtS
	 rbH3JI2WCaA2qN7upkR2cPVSj7szBgKisouWefViDB9OVtA6Q6dsLan7S4mkJg9CAHsCD
	 wGca9LMS/OVtNeUAOFIe1sd2HAwBOjoVROqjli5cCLhbUMD9+eWw32YtFQ5L9hSn+lY10
	 a687JnD7l+6xUMXfXsg7DyE11hzm3Ctf5YeNx3/lSZXHPIrLaRx6NngrvBl4ai1M0Ww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795435647;
	bh=K0FnyW2TQ1qgvH9wIXqYteYZMooGkWBNcMVkAHd+9RU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=flVq2zM40KTUyqdN1NuQ3XiplUqQZer/RveL2qeXLoAS9YRrrUl8f6at1xUcXp0VF
	 CzSDX+YxFR2nZ7WAsq7QXLsg+2k6b4Fy5R8zusHw6UzrgMXKzkIILUiQkxf8EQMlt+
	 J6hhOd+ru72F2IPZEX3P+rbh0Mz7DAdcG/IcFZRyL6oStz2FGMUsQ7XyZ3roCv0UEj
	 qcEpOFGMaLVgJdbDUA7rEDIWys3lmXxilSQ6gW/DSrDPAlbPU/9hIcLRxd9TEUOnxN
	 jacIg2873DZSnAzAA9hrpxbwAYEyXJwqTEHWoTmgQIFJpUq2GrJR/G0u/TwtLPUwjS
	 lqaC0pL4uQ2AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD85A405F4;
	Mon, 23 Nov 2026 12:07:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CDB2315D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3B3240259
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8qVwEKCVk-14 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 12:07:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 63AD1400A9
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=lists@steffen.cc;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=EiEMjx8t
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63AD1400A9
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:07:24 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jY4ST4H1xzKnh9;
 Mon, 23 Nov 2026 13:07:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795435641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=K0FnyW2TQ1qgvH9wIXqYteYZMooGkWBNcMVkAHd+9RU=;
 b=EiEMjx8tI5dFFErHJ+LJYOJ0mWpzdgEUMLiAMi1AO6HirT+RyXAmk0OaLWDIxCYkrbFFi5
 0tYm2KpPjgvfVbt6PL/7nvdszjvyTFqEZSxRUCCae6KBQv3p3E4X5x+i9Ows4XbG8litEa
 mzYHCMw+NYE1bnPKlMQV63jmWv2Gqm7xU+7GUMA7B8vrLMxJRXF2/AbB34NQHspNBs933u
 j/1cfBz53KgbF7zZSu9G5WZc0LR6fA6R6TGU38EwqM8YpU0D6PCXTa97A/tAp+6/9aW2+g
 eGn18d4i06rLhqdVEMFlZAkmiCuB0QeQC4ptpZS/MEHp2s5PYsa+VCZA0/8xfw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 23 Nov 2026 13:07:16 +0100
Subject: [PATCH] mtd: spi-nor: service the watchdog while waiting for the flash
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-std-upstream-spi-nor-wdt-v1-1-97a7cf1c51d4@beckhoff.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB0wsa3gVYqLmIztFIxhJmpBv
 HvTdvkW/x+gJEwKfXWA0MbKSywwdQX+6eKDkEMx2MbejDEdag64Js1CbkZNjHER3EPGqaVLc20
 768cAJU9CE79/6/vwt67ji3z+/uA8PxzeROF8AAAA
X-Change-ID: 20261117-std-upstream-spi-nor-wdt-f3e405372cbd
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Alexander Koch <akoch@initse.com>, Marek Vasut <marex@nabladev.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Yuho Choi <oss.patchbox@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795435639; l=1339;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=hkr7wzEi3gZOhKjDn484SLD9XbEdyJ+tKOoJR8LZm1Y=;
 b=pEQQGSXeQ85prDeNOpy0ILLXYVHp2G7O7IKphqCkqqYkEyHVF0V/k5kmOR3/oRpRWHLW4T7xM
 //ledSnqC3pC/NCm0xmHsPoiGI6oIqSVZt1IEPI9/lwNPGXHT+sXlG1
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY4ST4H1xzKnh9
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

spi_nor_wait_till_ready_with_timeout() polls the status register until
the flash is ready, without calling schedule(). A chip erase is a single
flash operation, which can take longer than the watchdog timeout. The
board then resets in the middle of the erase.

The MediaTek watchdog cannot be set to more than 16 s. Erasing a fully
programmed 8 MiB GD25LQ64C on an MT8370 board with "sf erase 0 0x800000":

  before    board resets after 15.7 s
  after     erase done after 20.9 s

Call schedule() in the loop, as the erase and write loops already do.

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/mtd/spi/spi-nor-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 7bc889c9629e..68c292ecb131 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -898,6 +898,7 @@ static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
 	timebase = get_timer(0);
 
 	while (get_timer(timebase) < timeout) {
+		schedule();
 		ret = spi_nor_ready(nor);
 		if (ret < 0)
 			return ret;

---
base-commit: 2f83ef8a7dd4a409b534ea68cd13b17b686cc53c
change-id: 20261117-std-upstream-spi-nor-wdt-f3e405372cbd

Best regards,
--  
Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

