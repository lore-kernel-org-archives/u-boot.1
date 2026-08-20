Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBB9C5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39FE1607EF;
	Thu, 20 Aug 2026 12:45:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XlPB40qMMpYS; Thu, 20 Aug 2026 12:45:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787229925;
	bh=5V7w6kPwSDpe3iLO7pCsDAObGzeDpRSDdk7ftpjG8iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RIRjFnysV31mc/91iWMhWjfPWle4997SdELlPrL4ATi4RMEJq6XpzkFdvz3KEAv75
	 3IR+po5fz8UTj5VBTWT3rztMOiJR+A2dhNdHY08ubRM+VE6vZL6+I3JWTthlyPjMQn
	 P0koyOkV9J7oTRS3hMY1ENW/WQUdVAw3zE12KZM18hiIPTiy3VVWH7U0b18Rr//zNW
	 iaFnhRUrtzc0o0UGxDO5AwYLzTz3k41xd+fPAlfVfaN35Y97v7ySjMsRtVFOcOa4dL
	 XALfRnIalOoIsI8yzeUd84lM3J9eXf4f232csbhT/YYx0U5FIs9hvgQB//+Sn6r7Vt
	 po6xsFMptVtGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A2B3607E2;
	Thu, 20 Aug 2026 12:45:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F68040B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 75D4B40558
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id evKrEoXqa7yC for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:33:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qvrUOM2B
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AB0A4034F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:33:21 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so24226075e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787229199; x=1787833999;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5V7w6kPwSDpe3iLO7pCsDAObGzeDpRSDdk7ftpjG8iU=;
 b=qvrUOM2BSUFb9rhEfqUA0El5Tab6RMRhWvU5+1zJyISXnNrDHn7sfn61Zo1EAAMRLd
 mGHzZMP3aVhyGZ92F/SwDjqZJU1W3hdAiPGhEqZXWzmJre4DyEM1tFEDT7jLqqIQhED6
 8g/hEn/t9vJ3ZBep/ZEU5iUcfqnDEI5ul6dP8EDsca12zss4eqPHMz+YC5F7FBoAZX1r
 HrS6VPmDNs2z8EW5dae1FwO+obaCyPQYSJ2vSRTHCWxkvB6TD4pRVXliq7EBaoVjvSew
 YR7w1TlosHzEymsL8C16DGbCcTWeVl97eskqXLR0OlVoEHm+fBllQX/WzMWLHeIPirWK
 GATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787229199; x=1787833999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5V7w6kPwSDpe3iLO7pCsDAObGzeDpRSDdk7ftpjG8iU=;
 b=M6AmLP0oWDqCxUfmzNm2r5uUVaG+ANNG6X5A4cK+HCSdXd2KlkneswW1tUBfXNd5D9
 p4nc1CXg6RvRpqGRqlOgTe8A4MgjKa87M/2MVNM3bCIDoJPohQuvawITKczvo8gJVaOJ
 UH5WVArkCyfiVfWLCABDopW3MHFxjA0Br0NBd7rB1ql8AqSLDyVskLa7wEhzKF8T6RwX
 ELe0WSHTwemidUEacX7rQrNdqQDdbc/54mhggrOflAQb0kbC8iG3CT4N0CK3/OfoRxYK
 VbR20vzFb3hoGtA5D3eX3lq84xilOeG4kHTyaFDaPCvXfmmQRGj5OYJHHpd0MyR+/NQE
 o3rA==
X-Gm-Message-State: AOJu0YxKiPd3C2AoK+y66+zEQtHQC3Cwv5vAk8nB0ujmzwymrfP3FBby
 7xwkRslMWGXvFCaUCyID89rkjLa2x7S2ysev3JdQ2w+IgQq4TAQlUfVQo3x6lrZx
X-Gm-Gg: AR+sD11+HAs6c9ruUolNutYgMVUSx7YN7Jxkp47sGL/s2HKZfNZMOH7iidyXAPlQ0Wu
 gENIQcQb+yOIy6OsCseST4Nm97YjqoW0yy6Yeczc+ybuRLE8N5esNx9De5rZXeDNg/PPKUHzbLM
 FD3PHGxUmpaQ93rOQQv8UPnr6qbspaggUB8RiqVmS1l3qQD3wquvP6p9YYX17y1NjFOs8Civj2E
 Dn5JuqK/Z73T6PBYRSeyZhiO0QeDYLobJ4/104Fq/AkDtasy02cGUgc2alovTgEev96IQUBksbJ
 PvbHhOgJ0LTi9CLRS6tChPcP7denDU4cFPBeFk9TevY3eHibeMV1cN+d5LDC1EJcs5afnnpbmFV
 uluHUaGdlXE0LgMhAgWeqBkIdkkjLbXzbIMC60Z7aCIzT/gOUewfP2mML0zwCnoAOVIlSy8nBlS
 jPN+Ma5v9bx1TdbWG1u9rgNtlrNedjWY3pEuwCx10R22F+Yte52mnVBeyc7J3Ks036GPlnb6Az/
 o7WyGWuH0OnzccjU1CM1mdEz2tMBtLMJn/CPjn3WqlTfZ4gsB6mKkvXGW1CIAsCE/34xQQRaZY/
 XLGK3uCYvz5Z7HdPJvxvMH0W
X-Received: by 2002:a05:600c:3f19:b0:499:51f0:a9b2 with SMTP id
 5b1f17b1804b1-499aa1499ecmr239734865e9.1.1787229198196; 
 Thu, 20 Aug 2026 05:33:18 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e784a4sm139126845e9.1.2026.08.20.05.33.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 05:33:17 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v2 2/2] net: bootp: bound DHCP option parsing by the received
 packet length
Date: Thu, 20 Aug 2026 13:33:15 +0100
Message-ID: <20260820123315.9272-3-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260820123315.9272-1-pranavkasthuri@gmail.com>
References: <20260815220817.11754-1-pranavkasthuri@gmail.com>
 <20260820123315.9272-1-pranavkasthuri@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 12:45:19 +0000
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

dhcp_packet_process_options() derives the end of the option area from
BOOTP_HDR_SIZE, a compile-time constant, rather than from the length of
the packet that was actually received:

	uchar *popt = (uchar *)&bp->bp_vend[4];
	uchar *end = popt + BOOTP_HDR_SIZE;

Since popt already starts near the end of the header, 'end' lands
sizeof(struct bootp_hdr) bytes beyond it, so a short reply leaves
dhcp_process_options() walking off the end of the received data and
into whatever the receive buffer held before - typically the remains of
earlier packets.

That is not only a disclosure: the options found there are acted on
like any others, so stale bytes that happen to parse as an option can
influence the boot file name, the DNS server or the root path.

The BOOTP path already gets this right and passes the real length to
bootp_process_vendor(), and both callers here have the length in scope
- they hand it to dhcp_message_type() on the lines above. Pass it in
and use it as the limit. The overloaded 'file' and 'sname' areas are
clamped the same way, as a truncated packet need not contain them
either.

Fixes: 774c3e05ec0a ("net: parse DHCP options from overloaded file/sname fields")
Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
---
v2: No change, rebased on top of the new patch 1/2 which fixes the
    inner option-length validation gap Jerome raised against v1.

 net/bootp.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/bootp.c b/net/bootp.c
index eafbe9e3bb4..06083092875 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -977,32 +977,43 @@ static void dhcp_process_options(uchar *popt, uchar *end)
 	}
 }
 
-static void dhcp_packet_process_options(struct bootp_hdr *bp)
+static void dhcp_packet_process_options(struct bootp_hdr *bp, unsigned int len)
 {
-	uchar *popt = (uchar *)&bp->bp_vend[4];
-	uchar *end = popt + BOOTP_HDR_SIZE;
+	uchar *pkt_end = (uchar *)bp + len;
+	uchar *popt, *end;
+
+	if (len < offsetof(struct bootp_hdr, bp_vend) + 4)
+		return;
 
 	if (net_read_u32((u32 *)&bp->bp_vend[0]) != htonl(BOOTP_VENDOR_MAGIC))
 		return;
 
+	popt = (uchar *)&bp->bp_vend[4];
+
 	dhcp_option_overload = 0;
 
 	/*
 	 * The 'options' field MUST be interpreted first, 'file' next,
 	 * 'sname' last.
 	 */
-	dhcp_process_options(popt, end);
+	dhcp_process_options(popt, pkt_end);
 
 	if (dhcp_option_overload & OVERLOAD_FILE) {
 		popt = (uchar *)bp->bp_file;
 		end = popt + sizeof(bp->bp_file);
-		dhcp_process_options(popt, end);
+		if (end > pkt_end)
+			end = pkt_end;
+		if (popt < end)
+			dhcp_process_options(popt, end);
 	}
 
 	if (dhcp_option_overload & OVERLOAD_SNAME) {
 		popt = (uchar *)bp->bp_sname;
 		end = popt + sizeof(bp->bp_sname);
-		dhcp_process_options(popt, end);
+		if (end > pkt_end)
+			end = pkt_end;
+		if (popt < end)
+			dhcp_process_options(popt, end);
 	}
 }
 
@@ -1133,7 +1144,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 				debug("got BOOTP response; transitioning to BOUND\n");
 				goto dhcp_got_bootp;
 			}
-			dhcp_packet_process_options(bp);
+			dhcp_packet_process_options(bp, len);
 			if (CONFIG_IS_ENABLED(EFI_LOADER) &&
 			    IS_ENABLED(CONFIG_NETDEVICES))
 				efi_net_set_dhcp_ack(pkt, len);
@@ -1160,7 +1171,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 
 		if (dhcp_message_type((u8 *)bp->bp_vend, (u8 *)pkt + len) == DHCP_ACK) {
 dhcp_got_bootp:
-			dhcp_packet_process_options(bp);
+			dhcp_packet_process_options(bp, len);
 			/* Store net params from reply */
 			store_net_params(bp);
 			dhcp_state = BOUND;
-- 
2.50.1 (Apple Git-155)

