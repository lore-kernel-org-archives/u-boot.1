Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3C606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qc/+aJiZ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X4n8mGnX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17C25407C8;
	Thu, 29 Oct 2026 06:07:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bkif2fZj-cUp; Thu, 29 Oct 2026 06:07:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FD05407C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793254026;
	b=afsOCyD1z9d1XAV4sGTWya1ZDwjQIXhG3kMib+xpqZUK/UzD37xDhLs23CL2dvIWW32M
	 BCoGHC2ZGehpG7CNWy4Hp2v0W8gQSH65tLzSTVAfkw8VhR8xRqE3hP4BZ6WoOD4JlsjBQ
	 aD+Z/+YxIJlZl7W9JIoqo1WAFjJZGr0XVF5mkFV6N1AnEkiPjztFteTE29jNkLq/6XuWA
	 Duqqb0UOLrMQzD68mBk3nc71vjrFU0HtVr4VE7QFENnz3EiENrBYBkL3bpiEcA4SOiYB6
	 P6Bpze1V8HenAVIRNpOisZPZFX+95nXUuVDwHLCBq7Eku1GXbpIZS1fGkyJiTEREnDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793254026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Vdg1pFX2ckCpIviElOgtDEyYxQiZUYuHFvlsawYNfzs=;
	b=splJzqMHgBed9rGYiHpGBbPZvkB5yLta+JWUKiSl/qVUOVP+xCuUghc34gYb6Jcg/iMf
	 NilywVYzH6B/YYNOkDRI0G9SDDBLnvkNSDgKWmng5iFR3S6T2N46rTibQH4ovSZUlqaYN
	 Dt0P/duFZvAZV+VS7B8nNhTsKaoDaSDRZGbIGihURBV3gFUDttysPUpecZIhFIGcnW55G
	 5ziMhenDwE8cylC3SAOgcJY/vpoVGSxhFYdxT0aDHwy9Q7wSM9G8nnM7feTRVRgahj1Aw
	 0G6SLG6mthDI9mg9cOnIYxyKzvVBNlD894fCYdWrHP4WmTpniuCt1GTCAO5MNsR4big==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793254026;
	bh=Vdg1pFX2ckCpIviElOgtDEyYxQiZUYuHFvlsawYNfzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qc/+aJiZ1wA93pUD833uAYK1qLL9piv1AQGoHU+TswkuTLMV7TKDDXoxgvZo9HUqr
	 Wo9nAY5PU66s//ReDSuqIdCQhaW4QHH33GYyDM+KHoabUMgqHozojNgTo3+mHukk2c
	 uX/dQYNW0Toj8UOKuNmJXDFp3s2/cpC9A3TtXYY7FJHRmARtPKPrjsWe98fb1kGMDB
	 CAON4XqhP8XJFGuqDtpAATt5TLeqBR0nu7b8KYsydEQ2ajAsetekFuxAJt2M4R6vJL
	 e29KZZMzGwcpz6I4WYUchodOpi4ZTNUDJVZVSOgzxsBKSrmjGvIwYvrDUEQmDJjBiL
	 v9aNDUQRxz3/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FD05407C7;
	Thu, 29 Oct 2026 06:07:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 138B6120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:07:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED9C680E2A
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:07:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o5m52GFcVuqP for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:07:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB8E380DAB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793254024;
 b=YIAaDEbFOZkjLfCAksWffa4pWX4HHCFoKvYgZWWsckpHVMMK9kotvDf7X05OHzed1LLZ
 aZTPaqL83DuGqJTAe193izz+ggEFmZlDwHs4aEpljBKiKyC/QZEh6iaHrY/kLu8ZSPx+8
 Qm+XGwOjoMJzRS+qk78BVfI4b2iB9v5zg8GwM6kQTYT7a7k8G8VAZlj/Lu85K1UbR/JZj
 nU00yceka1lDb70EuZeSzqGLj1FjDojNDPQ4sqvDBgp3XXCf71fqgABFnJQxXfCvbw5q8
 IYbyUG67mPbYLhLjQmH1OyujQXmNiVD6FWo1Vs4ZH6cfj6JHpVa2Q0DCGDBvZ8rVUZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793254024;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References;
 bh=Vdg1pFX2ckCpIviElOgtDEyYxQiZUYuHFvlsawYNfzs=;
 b=QFs9p1QYP4OcEjwj7aBt3K8/I5iXxiJqKg4pnY1+PPK0FsWvoXTU0cI0Ce6I6uXaV7Qr
 jTYw4BtdDbVKSMXSblehKFuDMa/Z6/Y4da2IG9imbNkLE1O77Qsl1Zm64kY2FqgeCowzv
 n8+NuYgTlUV1HAsMXgaW03I/4WWWGHRS1HVuUQ1/Pz/4wXE6COTpe8lxIO7mznex66nAN
 V4PkBBsMvNtd02YVx0j/JI73K2aLzFHaJBmK1g12pUVGlcRzpJWHlB14Kz3sZ8T0VlA9r
 TMKd1NJPv7X0COoTT3ABhx1nnC5HdiDZai8QArjQzWTEc/YD2SfcPR/vZPbjhvoOmmg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=X4n8mGnX; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=X4n8mGnX
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB8E380DAB
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:07:03 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso11685555e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 23:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793254021; x=1793858821;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vdg1pFX2ckCpIviElOgtDEyYxQiZUYuHFvlsawYNfzs=;
 b=X4n8mGnXfw4FbiaOm3rVA50lM+OB4WlpVaNZKjF3PDEcCtVsMr40kI3YMuUqENSmTR
 oBJVf3soH31CE11hvXI1EGZR1Hpp1df7SenalEVtzPO9Eas+DdSGWvJSNrVKNkjyOH85
 /DjXx1h7jla60smQxhNNJBaeM5JQ01FmiOW5Rz3Ez1ZElfUS5B8zuXpJ1qcAcb2fMuJn
 52PHPc5GcV6rNusuf2SEWdfxx5DFMtwRJ/NkN2ODpux/QVpMjYR17OIG54IrzkXfO/0v
 k0b9kw7MTnkUyMJRBYYt/xOn1y2Wb3eqcdelziT1XHEFrXMQhmi0WH9pnSQSaHV6BmvH
 I41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793254021; x=1793858821;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vdg1pFX2ckCpIviElOgtDEyYxQiZUYuHFvlsawYNfzs=;
 b=hOE/0cSfbll/MWm154fhDiAMYT05mEn6W/S47K2EybvtFyo71Ar86lFwDSJeBjSIHH
 UIVeZ7FzEQE3dUGmNpbNg/sowhQYnXnYJascEV9RRbMpG7HpdNMWZzZwQkNGOYFbj9bn
 4jBiFxOL7lmlHA3eGyY5wxmo0lM7j4iwj+Hz6JDWvVl8raV7LAmPfVn62ZjiPZY+o20d
 GMm7cLHbmx2UqzBT2+M3t6FjGYMG5ZbSCpR0qJ3uL7OoKN4/anFK2gAvQgMNonIPYHG+
 Cv71adIX7q5D5hDuAn2gnPq9ARIxbcStEpIV5PmLLIGDW3Xzxy1HnGbtV/e/5UCbIoTv
 kK7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNdQXwbUyhEd+JsMN3eTCVtkve1VmTPQPgHxllLylN8SEL+n3XX1DDNq6HocppGc0683NbJ8Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI6muXxulOWqyEJFZ/nKrt4O5R+slrvY6PikGVnlnkN09KVmTlX
 8NM0iXHdL6rsPkGLz8g2uPwNSByVGeZwbEMQ7gOt4YoLyQBytU33Hoyi
X-Gm-Gg: AYBFou3aY5XP2Vi4PY9cLbbJWyGM1NDVMfkr5cj+tyvTsTqMBlAz2WxugV29gJARZaJ
 Lph6XlsJ5xa3i5dOVyDVY6+IMVK8zwbCX8Q7EiSGKlK0rr6Uyf87KuY/cEoZ48x+YA1M4E9Qjgi
 inuFzaq5CZhSth+GmMnHa76gZNYdSg0/D3ReoDiUMAcyHl2eRQNls/OAM6dZ5/UqX8sTe6sX9DQ
 P6+cSxOrYdJ3V4syfxTKaH06Y3cErSSKtbtHooMe4U/+SrMDh8FAKdjrvU/78D2I6RU4ceb570O
 eIF+zdN2MprpMOKrKBV/bNgR44t4goCNrRf3gyyTHxiufdJ4+c1coar7NUKXAEVgPe8r8vJr6LE
 4+kGU4C5YeAAYjwkI9WzV3AZ/32HpSnYtqVFeExu5exGluU2gE46HrDY/x6vf6GuvRdeHcFk8DW
 j3y/9Uut5GFlzOZPswbitbAFUQoBH+v0TXjnFYMMoYOQ1T5BMqXHPZJsbg7Eu/SthsQDxgK0AIh
 iVuA2Rxqgs4aMnRpXRM1WR53LfB97N+q7DKKvkucL0mV/uTsx2QCGJuq4jTa9Ql3eXC8GL5nrTb
 BdPtZNm2V0oElJCWAIKYIVNq2YIkCy8=
X-Received: by 2002:a05:600c:8184:b0:4a1:d087:f6ab with SMTP id
 5b1f17b1804b1-4a967016ae6mr92610865e9.18.1793254021116; 
 Wed, 28 Oct 2026 23:07:01 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee575e2sm41445685e9.1.2026.10.28.23.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 23:07:00 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org
Subject: [PATCH RESEND 3/4] usb: eth: lan7x: Account for the whole rx command
 header
Date: Thu, 29 Oct 2026 06:06:59 +0000
Message-ID: <4e514187-efe2-47ba-8a86-de4ba3c25cd1@gmail.com>
In-Reply-To: <f9afa215-645f-400f-8743-eaeca3f6a2f5@gmail.com>
References: <f9afa215-645f-400f-8743-eaeca3f6a2f5@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

lan7x_eth_recv() returns the frame that follows rx command A, B and C,
10 bytes into the transfer, but checks only that the transfer holds
command A and that the frame fits in what follows command A. A transfer
of 4 to 9 bytes, or a frame length up to 6 bytes longer than what
follows the header, hands the network stack a frame that runs past the
received data.

On LAN75xx, command A and B are followed by 2 bytes of padding rather
than command C, and the length in command A counts them, as Linux
smsc75xx_rx_fixup() has it: the frame handed up was 2 bytes longer than
the one received, running past the transfer. Take the padding out of the
length there, so that the frame can be bounded by what follows the
header on both.

lan7x_free_pkt() also steps over only 4 bytes of header, so the tail of
a frame is parsed as the header of another. Step over the 10 bytes of
header, the frame and the padding that aligns the next header to
4 bytes, as Linux lan78xx_rx() and smsc75xx_rx_fixup() do.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/usb/eth/lan7x.c | 31 ++++++++++++++++++++-----------
 drivers/usb/eth/lan7x.h |  4 ++++
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/eth/lan7x.c b/drivers/usb/eth/lan7x.c
index 0a283619ae5..14c3ace4cc9 100644
--- a/drivers/usb/eth/lan7x.c
+++ b/drivers/usb/eth/lan7x.c
@@ -446,8 +446,8 @@ int lan7x_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	 * 1st 4 bytes contain the length of the actual data plus error info.
 	 * Extract data length.
 	 */
-	if (len < sizeof(packet_len)) {
-		debug("Rx: incomplete packet length\n");
+	if (len < RX_CMD_LEN) {
+		debug("Rx: incomplete packet header\n");
 		goto err;
 	}
 	memcpy(&rx_cmd_a, ptr, sizeof(rx_cmd_a));
@@ -458,18 +458,26 @@ int lan7x_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	}
 	packet_len = (u16) (rx_cmd_a & RX_CMD_A_LEN_MASK);
 
-	if (packet_len > len - sizeof(packet_len)) {
-		debug("Rx: too large packet: %d\n", packet_len);
-		goto err;
-	}
-
 	/*
 	 * For LAN7x, the length in command A does not
 	 * include command A, B, and C length.
-	 * So use it as is.
+	 * On LAN75xx, command A and B are followed by 2 bytes of
+	 * padding instead, which the length does include.
 	 */
+	if (priv->chipid == ID_REV_CHIP_ID_7500) {
+		if (packet_len < RX_LAN75XX_PADDING) {
+			debug("Rx: too small packet: %d\n", packet_len);
+			goto err;
+		}
+		packet_len -= RX_LAN75XX_PADDING;
+	}
+
+	if (packet_len > len - RX_CMD_LEN) {
+		debug("Rx: too large packet: %d\n", packet_len);
+		goto err;
+	}
 
-	*packetp = ptr + 10;
+	*packetp = ptr + RX_CMD_LEN;
 	return packet_len;
 
 err:
@@ -481,8 +489,9 @@ int lan7x_free_pkt(struct udevice *dev, uchar *packet, int packet_len)
 {
 	struct lan7x_private *priv = dev_get_priv(dev);
 
-	packet_len = ALIGN(packet_len, 4);
-	usb_ether_advance_rxbuf(&priv->ueth, sizeof(u32) + packet_len);
+	/* Skip command A, B and C, the frame and its padding to 4 bytes */
+	packet_len = ALIGN(RX_CMD_LEN + packet_len, 4);
+	usb_ether_advance_rxbuf(&priv->ueth, packet_len);
 
 	return 0;
 }
diff --git a/drivers/usb/eth/lan7x.h b/drivers/usb/eth/lan7x.h
index 9480f4f6d15..29f06c076c5 100644
--- a/drivers/usb/eth/lan7x.h
+++ b/drivers/usb/eth/lan7x.h
@@ -23,6 +23,10 @@
 #define RX_CMD_A_RXE			BIT(18)
 #define RX_CMD_A_LEN_MASK		0x00003FFF
 
+/* Rx Command A, B and C (or padding) in front of each received frame */
+#define RX_CMD_LEN			10
+#define RX_LAN75XX_PADDING		2
+
 /* SCSRs */
 #define ID_REV				0x00
 #define ID_REV_CHIP_ID_MASK		0xFFFF0000
