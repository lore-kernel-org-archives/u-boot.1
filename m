Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B8606A32D
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PpC344Ul;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c5BQYmKd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FC0880DF5;
	Wed,  4 Nov 2026 07:18:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qrBLAUnmNIaa; Wed,  4 Nov 2026 07:18:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5435B80DB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793776697;
	b=H/p0PVAIsMUTtUIK2yTnwgY4MYK4VqpnK93HxcGU9Do4EEDdbEOkmDCy+xkeNAgoBOvT
	 kIIAcswACpavg1XoZtdbJRmJ6zl7laWA6Tww3+zFg+X7mFq+4QlFnttWwFlWsEWt/FpFd
	 TAnU5xg1ff6QGqLJLchYTqqGWRpxtPjZsfgbezvUQ5goGUKBhs6suHIpox/Ztp6ftVI/l
	 nPZARJz0oi8UuXxGyv3X1bpXO4xOtuR6kf9t+c4Z7ok3SUhWKf8rm5SoGQaTIjCWnR6kr
	 oEeJA9idor2P1CcER40V/D7tIZDY9zJ3rFiPB77rrBWPSt2jFq2DFDilDdVkg6lKnbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793776697;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dW6kJa9sMKqG945ie51LYx09qM4ukuM1/VKihNxLTyI=;
	b=Z+UsIJMHQ2s8DCw3Xm5suGxJ+M0H2TRA+sT/fC+vVC0fyn2S3MT/8kRxDeqaUAoictR8
	 4+1TTwZItoVmvscgilyXXVpcU5vHgKIPhv0lAXBeOeMJf89BtfRVcCufevkjqYyJIsHGO
	 6JJ+wHHekNYV6WsMoi5tMQmUxxPCetPYerPCcugU6WVGsdKh9ekwX1UUP010zkYDGt7rM
	 Xp4xo34eCfND3qrrkkGq+glsVwfFwjo3C+ysvSuz4wOYRR0WsJYU8U3Zfab9bhWzWbjzX
	 EQKinfUrUMBLZwOkCWUC5ZAFYppzN8ZOugjgre5ZaEcthAoTDdxHURb6Qv6brnTHXgg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793776697;
	bh=dW6kJa9sMKqG945ie51LYx09qM4ukuM1/VKihNxLTyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PpC344UlelKXNPNIfnzn73RHYP+A0K1W9AukIss1GnCCT4+JWV/G9ACfQQPwOmkVZ
	 ABGEyU4j6Gtyv1Y4o3EwdhG5Or/8dmnKGuua+PMWbpRugOyPBvCraIBW2z0benmEWj
	 FnEv83RdJb+N7MChOonvFJfQWnHLacjZ56VgtIMeBhcp7bmy8enFsPfTNfcxHTZIIj
	 qjx6v/8L6s9XQpRq8ssakC4fVwScw6K9xgqt++PuZ0CPVRPxUKsdbEJDHL5MN/4lwv
	 2yccFVhkmyJ16fh1sIM+CJjaqd6JAG6OGss0cgXLJGStmsT1PqwjwmdrQkoRu6F7zN
	 /AF+RKjUuIPDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5435B80DB0;
	Wed,  4 Nov 2026 07:18:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0759D435
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED6A940176
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f-hF7JrvinOc for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 07:18:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 183964004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793776695;
 b=o4VQLfhTnNYAAZC+8wLJBaPeFYzDr0YT1bdYOILtjAxTgHX1m5XIohzmP37ufVNlwWMy
 Ffx+xykddKmI9zuiIwHUMUGAocQo6fvZBfR1bNsTgoCRP2O32N0Cx4FxrOY25fTMMM3tg
 tG0RtNbwAW/D+Z64r/pn/ELQu/ZjlObzzvgCDGBs6SSnhDTXIYDtrH+I237VyWX88WjDf
 3MjfE4k7ZIQWg2hBIBOE+5MJsisXAGAwIwhx1+DZ19JX3yLjRTnCUQaHbF1rPveoYrEvb
 G1zdT7LmEZgYDvAf7+pOoi4f6qFOm0e5rulT/EOLQX/4YGk2s+fgnSCus6wrcOHwdcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793776695;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=dW6kJa9sMKqG945ie51LYx09qM4ukuM1/VKihNxLTyI=;
 b=DNzNFTUKHIA2jV2F8c0FmzdPxMiox7IpKdd0GN1nYCGjTu+p/0ECSVGh/OaLEep4IioM
 8PO2L5xWNGAR+5MgLDxpbx+0475zqO0Enq1iycCxpUbX2I4fTe+6Fqt/GklLe06afHkI3
 SZ7e1gY0QGkD6OK8ZbybmOVt9nJyMOy6gniBVo269D6hqw+qAjAmQ5dIOOoJ77mxDay7w
 S8pJYHaRxk44ScCqhi1c4U/beAGQTMiYY0IhNqNxgKJmOFEpJdNnI5PwwNFfTnPHBk/F6
 gDL9EOIXz2bWBNn+Wn/+NCNU09+hVenIY71pv6h05C8/6N2762mlIr3ip7mY7umXkXg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=c5BQYmKd; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=c5BQYmKd
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 183964004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:14 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so1980495e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 23:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793776693; x=1794381493;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dW6kJa9sMKqG945ie51LYx09qM4ukuM1/VKihNxLTyI=;
 b=c5BQYmKdlUEDmaAktvySzlI0g+si8osfKMJw+mE7G17LhlZpIRW7hpBjlxeD69Dps6
 +UXdAgn8zZju/fs2wp7HYxKnvTCSB3aSEJGI9eedV7i5bP1CpIJAKW7/M/ooMTPVsRoz
 6choX97ev0fAFpOZ8f1IuxzTeZs6Dwf+nPWvVXXgC84uGCbcjYLORwhQB8q20pX81Ecd
 mLcgjOlSp6XQ9iB2WY1j6MLRvVMgiQef+oZRPy10kculfh+7MGcmdNf1XtwrNR8+F5Qc
 hmVza6aNPiQnP9DNEVZWkFit/kqhmu3hQeF0DiNQ1w9YGxAGq1tCnZIXujyZRffaJ/jM
 RfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776693; x=1794381493;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dW6kJa9sMKqG945ie51LYx09qM4ukuM1/VKihNxLTyI=;
 b=Uro9upDlqM+CfNqrexY9UO3bFiZS5MjiTYulAtbTaUqCmEiSIasW1PafQhZs+eudVg
 hjZq3cOYvdtDd2joCMaj5gahArZIQkiXVAQE4Cdc4rKim5FjpyOlwNbbIuGDd8Uvx8d9
 Bw0BvpHQlHs6gP1ZUNI9jMa/rxuG5Cjcqsg/DJf18YXBq4qUkKLqpMnQbqsWczY0HvbF
 1UUqI0s0V9AI1hX9cgruQfG6MXqmvpxeWlnvDFru0UEqn9N0q0RUnCQSbg43iy4XZg8d
 gezouPzZN1OiZRTmSnpA8l74gYSY7bvFigcyuyIyAta7NCDMVpeV9mCFQb1VeX+h5+Pj
 LYpA==
X-Gm-Message-State: APuU4Z/C2YyPluphjd+TN2hThDdztpcqSY0s4GcIMuvuO0NU+UhvbaOs
 zLaUB+Z821sW/kUy0g8QhbQPo+UUmPoMGN7Yt+7TLhJDGGKgwrJCCnFqURi7nj5Lk1I=
X-Gm-Gg: AYBFou01T7T76tgpwAX+2Jk37ia7MpHcms2Fwuk8L7sn4VNs4KRf0L66E9SYlmTosII
 7urSfZaQtmoyT+M7jvCDAJfepuSjFrNbhYVNAFLfNb6GExa53HaZYH2bPOusSbXEh8dq4KrkK1r
 YoZUgayeYz99poNBdO+5RyxXiTkoZudmIClYUaNrOk1V36n6a+lAzU3rqe5+9gfAc+I/+5FxYrY
 SgaTOF6VrVloWJcZ8EGtOX/I0wSFHsJSE6p+Gm6G2La47T4tGgLfP+Jnf92/RiGl3mPffO8yV5S
 OGY7BwjOIz4g8+n5y30/x/bCR0Sk0QaQf/l/QOMk95Ano4O3P5B+gSdjhbw37F/10OHM78caG76
 SGXlc/4WCjpy//JBrJ70+4JifGL8+k7UBzS1iJA4LafdBfezTYn92OvmW6bhOpojgWQ+oau3j0H
 KIka2xAh7U33n0n0R5N9bCQSeoL1EdLG4XpPuhVAMnGf9KyB5HezMeeahOmE+lI2o2PbW7adC7d
 UEvlb8C7WaPPMlzE46kdTg2PmwcI8sYsqZREcbyhAkQkDI58uOmKLoW0wJisTvJl+IJQJkjB8fJ
 JsBlj31KUjBAaTv6PCpbuZigzavuzOo/H90i9id+2PNUQC3C4NI1
X-Received: by 2002:a05:600c:5246:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4ac1889c7bdmr349518615e9.24.1793776692617; 
 Tue, 03 Nov 2026 23:18:12 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4320efc7csm14997655e9.2.2026.11.03.23.18.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 23:18:12 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 4/6] usb: gadget: f_sdp: decode the command's address and
 count once
Date: Wed, 04 Nov 2026 07:18:10 +0000
Message-ID: <86dbb40f-372d-4894-bdd2-b45f38b28e94@gmail.com>
In-Reply-To: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

sdp_rx_command_complete() converts the big-endian addr and cnt fields
of the command in each case that uses them. struct sdp_command is
packed and starts one byte into the report, so every conversion is a
run of byte loads: six of them across four commands.

Convert both fields once, before the switch. No functional change: an
addr of zero still selects CONFIG_SDP_LOADADDR. This takes 96 bytes
off the SPL of imx6dl_mamoj, room the closed-part checks later in this
series need to stay within that board's SPL size limit.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/usb/gadget/f_sdp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 9af411f16ec..aff69c3a138 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -306,10 +306,11 @@ static void sdp_rx_command_complete(struct usb_ep *ep, struct usb_request *req)
 	}
 
 	struct sdp_command *cmd = req->buf + 1;
+	u32 addr = be32_to_cpu(cmd->addr);
+	u32 cnt = be32_to_cpu(cmd->cnt);
 
 	debug("%s: command: %04x, addr: %08x, cnt: %u\n",
-	      __func__, be16_to_cpu(cmd->cmd),
-	      be32_to_cpu(cmd->addr), be32_to_cpu(cmd->cnt));
+	      __func__, be16_to_cpu(cmd->cmd), addr, cnt);
 
 	switch (be16_to_cpu(cmd->cmd)) {
 	case SDP_READ_REGISTER:
@@ -317,8 +318,8 @@ static void sdp_rx_command_complete(struct usb_ep *ep, struct usb_request *req)
 		sdp->error_status = 0x0;
 
 		sdp->state = SDP_STATE_TX_SEC_CONF;
-		sdp->dnl_address = be32_to_cpu(cmd->addr);
-		sdp->dnl_bytes_remaining = be32_to_cpu(cmd->cnt);
+		sdp->dnl_address = addr;
+		sdp->dnl_bytes_remaining = cnt;
 		sdp->next_state = SDP_STATE_TX_REGISTER;
 		printf("Reading %d registers at 0x%08x... ",
 		       sdp->dnl_bytes_remaining, sdp->dnl_address);
@@ -328,8 +329,8 @@ static void sdp_rx_command_complete(struct usb_ep *ep, struct usb_request *req)
 		sdp->error_status = SDP_WRITE_FILE_COMPLETE;
 
 		sdp->state = SDP_STATE_RX_FILE_DATA;
-		sdp->dnl_address = cmd->addr ? be32_to_cpu(cmd->addr) : CONFIG_SDP_LOADADDR;
-		sdp->dnl_bytes_remaining = be32_to_cpu(cmd->cnt);
+		sdp->dnl_address = addr ? addr : CONFIG_SDP_LOADADDR;
+		sdp->dnl_bytes_remaining = cnt;
 		sdp->dnl_bytes = sdp->dnl_bytes_remaining;
 		sdp->next_state = SDP_STATE_IDLE;
 
@@ -349,14 +350,14 @@ static void sdp_rx_command_complete(struct usb_ep *ep, struct usb_request *req)
 		sdp->error_status = SDP_WRITE_REGISTER_COMPLETE;
 
 		sdp->state = SDP_STATE_RX_DCD_DATA;
-		sdp->dnl_bytes_remaining = be32_to_cpu(cmd->cnt);
+		sdp->dnl_bytes_remaining = cnt;
 		sdp->next_state = SDP_STATE_IDLE;
 		break;
 	case SDP_JUMP_ADDRESS:
 		sdp->always_send_status = false;
 		sdp->error_status = 0;
 
-		sdp->jmp_address = cmd->addr ? be32_to_cpu(cmd->addr) : CONFIG_SDP_LOADADDR;
+		sdp->jmp_address = addr ? addr : CONFIG_SDP_LOADADDR;
 		sdp->state = SDP_STATE_TX_SEC_CONF;
 		sdp->next_state = SDP_STATE_JUMP;
 		break;
