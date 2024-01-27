Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030ACC46CD2
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 16:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FCDA87F1A;
	Sat, 27 Jan 2024 17:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GYtMqrgi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6C0687F1B; Sat, 27 Jan 2024 17:40:07 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1F1387E3B
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 17:40:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4854=JG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1706373579;
 bh=qxEvz5RmGrCbAcgJ/2pj1mk5CCnH7tKyvQiPnviDwG0=;
 b=GYtMqrginRLA1m5WyEyQgRiMdP26qJFFlidVAgRdrZkmsdO2x6ohaJ1g8be+X2Sn0E7HyXCPU
 F1BHVKXYWr93dnYkDQA6LCfC76WVJbXtEX7jgjKgNwBV4twlMGpxI8wsmqWyiZoZmqWWUq1hFy+
 B44BXcVRrvaRB5Qe8cCIw5QQYo2+Xz1BeDv0iAbr7Nalv7l7gh4y9y0XW5OmMAjWdMS+DtJxshN
 fuXeW7IzZY/LoXA8/lYkg6RqYmIkhWBtmMshO/YJOtEMJ+X9XzXsjMarJclSrkrxME8iZlfgD8C
 S4afiaXjIMTR8zMTdmkpRiAtiQGdBfCLTHm8Bs8I27gw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2] mmc: Remove alignment hole for cmdidx in struct mmc_cmd
Date: Sat, 27 Jan 2024 16:29:21 +0000
Message-ID: <20240127162922.284598-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65b52f676797215511302433
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

The alignment hole caused by cmdidx in struct mmc_cmd cause strange
issues together with the peephole2 optimization on Amlogic SoCs.
Following was observed while working on SPL support for Amlogic SoCs.

sd_get_capabilities() normally issue a CMD55 followed by a CMD51.
However, on at least Amlogic S905 (Cortex-A53) and S905X3 (Cortex-A55),
CMD55 was instead followed by CMD8 (and a few reties) in SPL.

Code from the call site:

  cmd.cmdidx = SD_CMD_APP_SEND_SCR; // 51
  ...
  data.blocksize = 8;
  ...
  err = mmc_send_cmd_retry(mmc, &cmd, &data, 3);

Running the code with MMC_TRACE enabled shows:

CMD_SEND:55
                ARG                      0x50480000
                MMC_RSP_R1,5,6,7         0x00000920
CMD_SEND:8
                ARG                      0x00000000
                RET                      -110

Removing the alignment hole by changing cmdidx from ushort to uint or
building with -fno-peephole2 flag seem to resolve this issue.

CMD_SEND:55
                ARG                      0x50480000
                MMC_RSP_R1,5,6,7         0x00000920
CMD_SEND:51
                ARG                      0x00000000
                MMC_RSP_R1,5,6,7         0x00000920

Same issue was observed building U-Boot with gcc 8 - 13.

Remove this alignment hole by changing cmdidx from ushort to uint.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Drop use of -fno-peephole2 flag

Link to RFC: https://patchwork.ozlabs.org/patch/1841495/
---
 include/mmc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/mmc.h b/include/mmc.h
index 1022db3ffa7c..031ea0fb3545 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -413,7 +413,7 @@ struct mmc_cid {
 };
 
 struct mmc_cmd {
-	ushort cmdidx;
+	uint cmdidx;
 	uint resp_type;
 	uint cmdarg;
 	uint response[4];
-- 
2.43.0

