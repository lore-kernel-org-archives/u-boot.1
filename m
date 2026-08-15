Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F67C5CFC1
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 22:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24F03606C5;
	Sat, 15 Aug 2026 22:48:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O1xUxJ_Ez1N0; Sat, 15 Aug 2026 22:48:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5620B606BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786834135;
	bh=1W5HnbwutTY0Q9hl3TM87IB7pM2Y1kzPyYPUS+mc4i8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sC23NNy/t+FddwNAKo9whpObP9LF8h6uaa5g4tXTCKdYNy2pTaOc9mL1atsX1Ka0d
	 y1M6hTo6SoktkybJsElAHkheJpUzp9MA0k9rK2darZ3OCRJZ6SgGXHpMY4wHgijUc5
	 IuF/Uu9W0lMhEd8+xuEsFX8uzO84L3MPlXjRDG6XZmwqj2zLpCpPV9FDZjHus+YkU1
	 eivLmE4RHZVVGVuGAQMGLBliuvgcYHl4qvtUA1cZG7vmOqcFf/qXqczGbnZGaqY4Z+
	 sr0Q0a+RikVe1TEzhvdepD7d1fkPBvh1XKYixnh0D12WWQd37/dFAQCKUNOvQhqk89
	 6MY67NjcZeOaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5620B606BE;
	Sat, 15 Aug 2026 22:48:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5893E333
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A85480E52
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R1G50fRDc4jK for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 22:08:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7381180E47
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7381180E47
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ql7zWx7i
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7381180E47
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:23 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47fecbbafdaso654513f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 15:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786831701; x=1787436501;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1W5HnbwutTY0Q9hl3TM87IB7pM2Y1kzPyYPUS+mc4i8=;
 b=ql7zWx7iFfvDKC7ExLGBU/Y7QDZ5OU0hKkyN+Uie6/6ZMfWDxDSHpR+Fh9yFPVoO59
 PTx6a14lcHi71u4YeiY73WXxhxIDNQoFWIJwrMsS+H952fSh9YBixAzjRqEwJSYiblp3
 aEpbmxIczGmZJhO0O3kCUXFrtNrWtRIpolxpwQ2qFgQK4nxGK2BHZjjZpDerQAxCfOMs
 xZ5wikOnyaBZ75Xhe3G+cfIU6RiMVED/1JdDWrJxJzWR/UN775YhCSbRut5d0Iwdw+AR
 FG1y28SMc2B4GkLRyYA91nQa8A9y6JGCBnZ/IAJL7Gfd4Le4mVz0iwFxvcbxjX4zDSVE
 FTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786831701; x=1787436501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1W5HnbwutTY0Q9hl3TM87IB7pM2Y1kzPyYPUS+mc4i8=;
 b=ONfQBGLOV0Wczlfw9MjJbmt2So6uBV9hzvw86W6jPW+DtPgjtLpg5Zt+Vili7x7hmH
 SrJT1JU0ER+0cmeEsExQGH84ZBf1aa3Otn6lWG0PZ8zMnYHL4bnfP/QHEglzMQ4Jv4Oa
 6HHMNLKi5eeSt3m86eSVhENqmd0NdKf//LSKzjiejXzjf/p9hPA22M0odgDZtmjGhbXT
 Xb3FcI/K/yVOT1EQ5KRt8uv7hMO60/lARUnrpyg4Rqktzr2J7Om6X7fKDdlU+0ngMLw1
 ERg02aYWrvUyPSBFGSMH9RreoF3VuBkItyjERAAzQLwK9pWzNAnT3OPL+XhB5BWy0jEJ
 THjQ==
X-Gm-Message-State: AOJu0YwJYxgm3y4RmZWuAm7pQ1sMoWozclhfXxTG9/EPBrySBhUMggH1
 FPUa2tuR8oKVSf1yggLqiudGtzhdlq1v9DI8fJ+S3gpReAB+esyiuUXe8IhMuyCXSoU=
X-Gm-Gg: AR+sD13MFyfQ/8qgMGYTUh9hiQ5tXB4qJL5N1uhh17WjwKr6ce6cdE9YlqQtPXQ6zap
 zMzROl1JzUmmojMj3Fnr+3O4wsLLU0129dteHObDkgMiBzYk0uCzWjWNB0vZ0LshJpTvG+WqWj6
 YbA+2RzoZ69uvvGOKUlw4A3vo73uZ/ae01GtPK0HE8sU4omCzYSyNFzLAg2kNiKKQbJcr9Z3JX/
 fEJcgij3JO+0smQmgfMm4ArJQxkDVlWxjv9ylmgq6inADXHwe+UycKdHaRFJCe2Ag8XNbFMfncv
 NsR/q9KCCN+6jkP5FF1kgscGrRNz09HI1u2Im6pjKVAJr+ETn1JG+52tQy3CpptPiF5f1PQTQ6D
 xPd/M8zcaHdRUsfxPmk2KrqtAogcCKxxGaX/Mey2o1MWtsxOAIQPOifQVD5mgBrl/QdSGRiVNKX
 SKq21aTGZGDB/OOiVZ2k7BS2qR8ROz0S40NpmsIxheGOHxG8GHItJTCgWXXcZDauSF3BHzrxhs6
 DmR9gLy9XQQBX0oZU4HDtFlZRzDue6mhXcCptOgVEFOH4u5h+nANCoCiuBKgSjdbYEhckGLH+RN
 NiXyUI2yemlUxZUO29sfag39QIx8VA==
X-Received: by 2002:a5d:5f4c:0:b0:481:3db1:a62f with SMTP id
 ffacd0b85a97d-481607627bamr21630600f8f.17.1786831700959; 
 Sat, 15 Aug 2026 15:08:20 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c6115sm19344046f8f.32.2026.08.15.15.08.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 15 Aug 2026 15:08:19 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, trini@konsulko.com,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v1] net: bootp: bound DHCP option parsing by the received
 packet length
Date: Sat, 15 Aug 2026 23:08:17 +0100
Message-ID: <20260815220817.11754-1-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 15 Aug 2026 22:48:45 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
 net/bootp.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/bootp.c b/net/bootp.c
index f0dc329d6e4..fdedecb3f50 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -968,32 +968,43 @@ static void dhcp_process_options(uchar *popt, uchar *end)
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
 
@@ -1124,7 +1135,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 				debug("got BOOTP response; transitioning to BOUND\n");
 				goto dhcp_got_bootp;
 			}
-			dhcp_packet_process_options(bp);
+			dhcp_packet_process_options(bp, len);
 			if (CONFIG_IS_ENABLED(EFI_LOADER) &&
 			    IS_ENABLED(CONFIG_NETDEVICES))
 				efi_net_set_dhcp_ack(pkt, len);
@@ -1151,7 +1162,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 
 		if (dhcp_message_type((u8 *)bp->bp_vend, (u8 *)pkt + len) == DHCP_ACK) {
 dhcp_got_bootp:
-			dhcp_packet_process_options(bp);
+			dhcp_packet_process_options(bp, len);
 			/* Store net params from reply */
 			store_net_params(bp);
 			dhcp_state = BOUND;
-- 
2.50.1 (Apple Git-155)

