Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E56C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA1B8810F9;
	Wed,  9 Sep 2026 20:44:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v9WdOHc-tNZG; Wed,  9 Sep 2026 20:44:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DEB8281107
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788986697;
	b=WK754sadEDv/9kZNO0ttDAg1hxrWNmXMP6WtSdFqOKachNCbiotHZZD5U7qKNoDWGY35
	 XldPlVwB4rcAvB5n7F1xoeht+nKPUjfnwq2RNwgsajpi0kO/XSvBiav6DcBCCUH9b0Slz
	 uX7m5LNwGGrX8PToP6EE2JAyATY7ppagoyP7wTCDLgf05EjuRUNFTsdLDhfQiJ8ePHPNT
	 a1gYbwawBbZJg374v9Nj+6yylerwZwVSaZI/PDaiY2XrwGQmhGL3T6id/B2lCvTOXIEyT
	 3W1WvGkgnAII8iNd4bWpHF8pavc1skQEqMuSeJDqkdRCsl0bEM7FOPE/lJgdWrQAOAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788986697;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uCQd8fkXlaZpBZcF7zAus1yAWUW37JtNdt3H1sDi1FE=;
	b=WERs3ts+1tKAAi8mYi+egZOP49Xw7b7T+0sH7znaYz7i/fCSN+PxtlRpp8Rv1Ovgg8tz
	 QnoO4VdyRgdPKjWAHIgBEyotmQtuFaUfchglPZdYfQBk2JIVQs16rk2/1YscUPOLo0Dm6
	 /z7SlYdeYtkVJzfXPCt02oI8YYU2k+QKejS+xHEsZ34tF+ARHjWtGdo4ncRXJ/G4yaHVJ
	 u63WHMRZASz71uNoCE99hUDF5TbyDhbdwq0qcXF3SuJg7rVeUYMdtBygtVXuLhJLBe9DJ
	 qsOjbvDrsaQbZHBnd7PTA1IPo+9/tGVhVzCX2iDZDraEXMd/BqQ2OxDxYVtFdqNZyag==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788986697;
	bh=uCQd8fkXlaZpBZcF7zAus1yAWUW37JtNdt3H1sDi1FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P3Xg7+gA6DsnsPVHjvLSg7qr2VUbt5gPx3OSJds0xOVdATjcABwRcQ+Ur5nSgX54q
	 jEgx/8+dKGkgOvh6VsQ6t32ieIdWCxH/W1n7INVnNi3svMSsKlXJI6Q4nJJy4s/2Vb
	 jy4TTEl6ocSQ3y+w0pz+oBYQa/PowAGUoSpus/TGF1q8ePftTfPDHxwU00dC1NUeBA
	 W8/JdWxKfDEg9HlMP4P7c9dU/z5dqIEQsEtw2bsQsG/XQW2ScCpl5VqDwxGtvogX3n
	 Ax2dSdw+NFVbx11L7eX92uF9hpxtvUsD4j3PW1R1wMfIU8ruItpW3ZoyIt7Zim+eBp
	 Sv1ujr8yb/VBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEB8281107;
	Wed,  9 Sep 2026 20:44:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 173D7432
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08C8A60A5E
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q6tZrzkHDgbo for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 19:20:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6B18660847
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788981633;
 b=T4JblKz3nzENTbkEIl2e+ywG4Y0xAzWq7Q0ZtikvR4AW12R6Pid8kCoww7qYVSsCq5VS
 bVw3+JUfu3kzjXNqsT/uAgCyXKa6ARcSIFU7Tu24AqeRodiUmPfOOcN1upJqqITbAHJXE
 xesHD1m1Zrc/Ukz9D1Ve2PNxHv46x5Kg+By80kkxr6OxMe95qPyvg0Txt/bueJqmywRyo
 MGaz2sKCGNyTPzFvyxjZploJZs4B+dKOJxH+aGmbrXKwUzYp/SYLO+PtCwxSi3KO+KhVZ
 oaNyb0X8Eq/N1JSI6bAtzOlExKta8i6SplhGFqF4r1wy2ZiaGDjT4keMADMjjputdnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788981633;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
 bh=uCQd8fkXlaZpBZcF7zAus1yAWUW37JtNdt3H1sDi1FE=;
 b=lWtcxgQGgqt2ZhfTZTH8XMPB+5eINaj3HK2Yd0ilSw6XB/w+BZwTHUVSYloNYoaQduTp
 3/DX142afmiA7KjPwqawiHejJDU9EkGUtfdH9XDbRBouK5uL4hMRrL9zrpK/pJ31a2CdN
 3km7D3NEywYR8HtfkptCCAgXoohsNZIh0cvFDi+ixbAkAYvBupvtTgN+wSwS3DTYaDr8P
 oPhpFqYQSZHJKkXMCG7z50xfph0SGv/ZNC2uyxTAX2kHG3y46/ZFXfZSrOyA7oWULLRAZ
 Czw9US0ejYLNDmTZoYamKH/2hXtSZNqxFgos1Okfo2YZMgfl8p4q/BCRmpaN5l3OCzQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=TrV65MJL; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux.microsoft.com
 header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default
 header.b=TrV65MJL
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B18660847
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:32 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id C570320B716B;
 Wed,  9 Sep 2026 12:19:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C570320B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1788981592;
 bh=uCQd8fkXlaZpBZcF7zAus1yAWUW37JtNdt3H1sDi1FE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TrV65MJLz4nedGxpwajBPPKZMf47tzRpGaGb2HZFzw270KkfL051CU0cgOl6W30wR
 mnQo0847exYIfE+FoFMBPD5gq8YODV2kNxXfRGFFDG0V6tIirfq0uS88jAzbJQv8gr
 eLJn6aAnoMX2iWzQSgLSl1jpSpshpqx/jfsAx/dk=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH 3/4] net: tftp: use bounded string compare for OACK option
 parsing
Date: Wed,  9 Sep 2026 12:20:15 -0700
Message-ID: <20260909192016.217183-4-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 20:44:50 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Drew Kluemke <ankluemk@microsoft.com>

The TFTP OACK handler matches option names in the received packet with
strcasecmp(), which scans until a NUL byte. A malformed or truncated
OACK packet may not contain a NUL within the received length, causing
an out-of-bounds read past the packet buffer.

Replace each strcasecmp() with a strncasecmp() bounded to the option
name length plus an explicit check that the name is NUL-terminated at
the expected position. For the "windowsize" option, whose name and
value extend beyond the loop's "i + 8 < len" guard, add an explicit
"i + 11 < len" bound before the comparison.

Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
---
 net/tftp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/tftp.c b/net/tftp.c
index beb9d08f5a2..35693e2a93e 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -544,7 +544,8 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 		 * something like "len-8" may give a *huge* number
 		 */
 		for (i = 0; i+8 < len; i++) {
-			if (strcasecmp((char *)pkt + i, "blksize") == 0) {
+			if (!strncasecmp((char *)pkt + i, "blksize", 7) &&
+			    pkt[i + 7] == '\0') {
 				tftp_block_size = (unsigned short)
 					dectoul((char *)pkt + i + 8, NULL);
 				debug("Blocksize oack: %s, %d\n",
@@ -555,7 +556,8 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 					tftp_state = STATE_INVALID_OPTION;
 				}
 			}
-			if (strcasecmp((char *)pkt + i, "timeout") == 0) {
+			if (!strncasecmp((char *)pkt + i, "timeout", 7) &&
+			    pkt[i + 7] == '\0') {
 				timeout_val_rcvd = (unsigned short)
 					dectoul((char *)pkt + i + 8, NULL);
 				debug("Timeout oack: %s, %d\n",
@@ -567,14 +569,17 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 				}
 			}
 #ifdef CONFIG_TFTP_TSIZE
-			if (strcasecmp((char *)pkt + i, "tsize") == 0) {
+			if (!strncasecmp((char *)pkt + i, "tsize", 5) &&
+			    pkt[i + 5] == '\0') {
 				tftp_tsize = dectoul((char *)pkt + i + 6,
 						     NULL);
 				debug("size = %s, %u\n",
 				      (char *)pkt + i + 6, tftp_tsize);
 			}
 #endif
-			if (strcasecmp((char *)pkt + i,  "windowsize") == 0) {
+			if (i + 11 < len &&
+			    !strncasecmp((char *)pkt + i, "windowsize", 10) &&
+			    pkt[i + 10] == '\0') {
 				tftp_windowsize =
 					dectoul((char *)pkt + i + 11, NULL);
 				debug("windowsize = %s, %d\n",
-- 
2.49.0

