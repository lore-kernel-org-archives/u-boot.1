Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1B1606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bb4B//kW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iEviuBuc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E9E8406EE;
	Thu, 29 Oct 2026 06:07:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4HKvz16hNAJt; Thu, 29 Oct 2026 06:07:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B70A540708
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793254021;
	b=mb++xO99KBtaFOLy/3x5nwTspTNnTkbNRxLpdjLarxgq63Wq6meR86diTH8Vpzh+U6SQ
	 7jpTXI3fIo5LXSzZ8+gyJQtBOcj+1Q5N3c/6lL0wzBdIyVTEpqwO+3TFWZ8rQqGeeDP6B
	 0QdZefh2Jupq2BnKn8P5B8dTNdbsBIky3lchM3FeqWq5iPQ7Ovd5jX8vPeg9UxUNlp3V/
	 JNuFj1nAlAS1M9ejrLzYBJKLlmXZdllJC5eCOuaSCih729tLMDl2eKcPXWS4CggFI+Hbo
	 25JCSE3VXpIbfy/HNJpCfe/p6VTsw3X108RDNucsBWvxoZ7s2TQ4CpFyFPzZCcWaITQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793254021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vPYeea9Ltpuv4kSp+bgCMtd7s8EsJOUk+Tu2jQQA+II=;
	b=RPGJ2zcam0fppaz5Hke8pjEG1ZLl6cuAqekcOCGr+Qn1amHCVgQ2ovHB9TKBtahsWCKj
	 U+gv3erThd1JCjubmXKEV2MY/FbWDWEl6aB+fYec365XB4iW0oo2j8hI9o8somfUz0lTu
	 zK/qJs3eqXPjFjwW+gi81zan+PZAhQC0TH6jtMfvOIZpNK5TiyKvopdIvYv2OpWeGyn5F
	 k4JHkh0/mD7izmDTDQfGbZAUOnhLWoQGf/zPsBwlfQOrD2J10E/Xtlgxf5BRmiLfJFYC5
	 OZlhGWFlp5oRiJKDcttaBP58D307iu9Gya3Pc+KKyso1j6CHDhfJbM5wrIyfS/UQh+Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793254021;
	bh=vPYeea9Ltpuv4kSp+bgCMtd7s8EsJOUk+Tu2jQQA+II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bb4B//kWLoAZloXFdEXjctcYfLZfLNXqSD2H4jyoN5i7RA72ExakLXeaeVp5jSJ3s
	 JWQ0rHysqyZ0cEgeohwVFEO1CjNP+qS5FXG3NKFaIBWlszU852OOXoqU9sRbX6JAyZ
	 jv/65cgkz3+oKgWm6gCxNJq3EKo8KK1nW8kmn6TIG31BReGFVBAak2eB6QNq6PfW5X
	 LgaYoYIXCfyh5UMDf6QRZw6xRw1SetvouXtae3CUST3CLUCYuMRFMPI5UnbqHN8HFI
	 f4YFIJr1drnnhwQy6IOh7RICCUdU+i0j9oVetrTrryyNTgBYGXKVrFDA3U8/pQKR7o
	 fr07cWemGaMrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B70A540708;
	Thu, 29 Oct 2026 06:07:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 465FB120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C9FC40176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:07:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PWHTkkok2ARv for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:06:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 443BB40080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793254019;
 b=sFTlZweJVba/fJmrdESdxCCgocDllKI+cCYjNHIcdhDmhQ2eZvmvq8w01SmGuRfldAlS
 4nhm+dSffRTaUyQe3EcaHgpfyfsPzkrIRlRm4mZmUz37XrebvrHB5xq5YGOGZJbx1PgLB
 tQ4LVEIxe/xaep5kSRxSWxHuU7Mwo2psuqZNe7SLOJAp/WUPpgwu646SIuKOD6vxhtwV8
 WzCmbzrEbodSFG5ZmduxXYAyC3rZEG+dOUA3xL1WW29rIGu5NRUzT2xEMYheI5GL/W4FR
 rmsDgJHGoW+IZjZ4PTeQv06JBN66AkN8wL3zVwf1oxExXoCBihudU8P6SiM/g4HZqew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793254019;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References;
 bh=vPYeea9Ltpuv4kSp+bgCMtd7s8EsJOUk+Tu2jQQA+II=;
 b=BwwimblwyKWlR3XQsBn8u2T37BfK0FxA+9oagST04ZGyVNekIInV9ILBrJY1IjoV6M1Z
 5tEybUqWZNmRoesXUsUmlKC90lI68JxuQFm1EzEE3v9NwQ1KWNQdKuosETANxIuziP8WD
 IJx8bja8nR5eH+5CjI3QKPoGMMLxOcws8gI4GtaITRWptCxWw1b2XPpC+wX60EYC73qtM
 Z9ibPDkoNu/TzuVzZrMf8mKvkoDz/cAn68SI4aiAXKbJ51jYQigJO4I05Reo5eo1MdIOI
 LyR4OWMTlQU4pC7opWhKFccWSCzzWtz40ad2Up8SZvBtGrs0HYjvfx5FQUT0feNcyTQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=iEviuBuc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=iEviuBuc
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 443BB40080
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:06:57 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso911266f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 23:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793254016; x=1793858816;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vPYeea9Ltpuv4kSp+bgCMtd7s8EsJOUk+Tu2jQQA+II=;
 b=iEviuBucXG4aJYGuOxIGgL+PW06i1L9aXd+3e9cvK8LD1p4Qanns1Z1ydEu3oCDb37
 l0I4kIt7piM/OAHnnfDVC8a5KEjWCK9OJI2AQ/zo/efQDreVse9iraQa3I+GRN3Pu1LL
 5k8DWmhMaKz3kAGigtcY5EyYn5ysCrmT0CilT5yPDn5GQ8wZJKRX4eoKiNWveEXgLad8
 /15owPKFpdBHbWrC2K82bIIj5S2hACaQIWr1LRyzId6eHDqgAuDJsNi3mhsbmBpsXVXL
 oS6w4LhXvbItS9iTtfM34evTouAbH3+CtsJlrhHcVBQzzkYqb8kELlxDQKjt5g0AL3u2
 EVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793254016; x=1793858816;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vPYeea9Ltpuv4kSp+bgCMtd7s8EsJOUk+Tu2jQQA+II=;
 b=TmvLzzGwi8+RvK9+wXGVaXMQEYbphBKZAtNopXc4SgA3qTsvsGwfOrwkeqUfVA34Sk
 QQpoh/Qa9UtIt2pHd+VTGrIrTVtOkqIPUcFsGxoyw7KayS+xGQkmUaA1QPZkTZ4WaD7I
 vX4QqIU/REvSa1MAKgliKoF7IKgfyPMWo1zFFY9yBE8tEr4ogVbMmAllZdSTuMCn5Xxx
 BeXlHNp2MXKVKH0fCwKVIlv6wa/97z1N/OueSUwgyefgdw6iRPQGEyvwKoRIPtYw+48D
 XRmcGnznoO5+bzpx0qqWKrBx4Q2zemA4fBe/YglKbTj1pqXqVX+HlCnQ2WjgQ+UeHQMQ
 skAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdCG9Wqk/Zhnn6pBdyXlwIo0Wwuz6ZWzF78o/RKtHldC7dYZQnFL9ZUzZfkyZOK0kWX6YCILI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI1nmCBK/LemHm/R01bVO7SeeOZ0/NQGizazrIzWKQKYpYEENtH
 KRM3bUTj7N2AwtvpHYXSfqF1i1okoMsY92zieOEVBDiKFBwIMh8wlRqt
X-Gm-Gg: AYBFou1FIApSHKdwvY8YkfB36yeRnmQcSjEFJKod2t8VGL9uTtK08jVYli+8CPNOAjo
 23M8xPDz+j2CEIZhnc/KPENNY4CL0U5O2gcm/dJF+z8UCLxX0fVWruysUTmbTxEGqxpf/TE4SJJ
 ZzHjNAhbkuUIFvU/TAXYOjmr3ACeFncMkiN+nUUn6/l3OmJe+ko2GEXZZDpQbZTifI8plC6uY9u
 e5kX3WfVk3NDQpcJvdEj/NF5C8wGDxnrDJoQOjgfpDAzML7dwOpt8/CjB28lSsShZuCoySd2YC9
 0nQvz1rHyKs7/WUqjj66b6RoHMcNRJM3Gbq8ygdzugSsgajJjmluC1PFMDOHCtvT6GGkfH+TIjV
 6hjzNgTF/zCD1u1K/GuzcNlDbw39xDukEK9ORqVf2FYXFPwNW+r9g2H5NvSUWP6XJsfKLWGVfli
 plv9rb0Vt1llrznwfiwr+LfqDWtIF3IUEeJdSGOwgXJY7Czh9NeqKQCZSlWStdrNcemhcp9OnZQ
 tWfhX4ZR4P0NphXmfjskeppu4w+i0Kxlipbdw33PuCCjlTvMFCpEMEFiRCnFrP7BROchUIOvELT
 oPpA5xe9x5lPcNwLHobiELYk5r8DucA=
X-Received: by 2002:a05:6000:29ce:b0:48d:f7c0:97c0 with SMTP id
 ffacd0b85a97d-48e5d5b3ed1mr6643597f8f.50.1793254015776; 
 Wed, 28 Oct 2026 23:06:55 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3705sm39077352f8f.45.2026.10.28.23.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 23:06:55 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org
Subject: [PATCH RESEND 2/4] usb: eth: asix88179: Bound the rx packet headers
 and packets
Date: Thu, 29 Oct 2026 06:06:54 +0000
Message-ID: <466e9376-f65d-4dd7-881f-61362539c3a7@gmail.com>
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

ax88179_eth_recv() takes the packet count and the offset of the packet
headers from the rx header at the end of the transfer, and checks only
that the offset lies inside the transfer. The count is not bounded, so
the driver walks packet headers past the rx header and the received
data, and no packet length is bounded either, so a packet, and the
start of the next one, can run past the received data.

Check what Linux ax88179_rx_fixup() checks since commit 57bc3d3ae8c1
("net: usb: ax88179_178a: Fix out-of-bounds accesses in RX fixup"): the
packet headers must fit between their offset and the rx header, and each
packet with its padding in front of the packet headers. Keep the end of
the packet data in asix_private for that, and drop the rest of the
transfer when a packet does not fit.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/usb/eth/asix88179.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 69d3073b669..4c6c9b2796e 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -204,6 +204,7 @@ struct asix_private {
 	struct ueth_data ueth;
 	unsigned pkt_cnt;
 	uint8_t *pkt_data;
+	uint8_t *pkt_end;
 	uint32_t *pkt_hdr;
 	int flags;
 	int rx_urb_size;
@@ -543,6 +544,7 @@ void ax88179_eth_stop(struct udevice *dev)
 	usb_ether_advance_rxbuf(ueth, -1);
 	priv->pkt_cnt = 0;
 	priv->pkt_data = NULL;
+	priv->pkt_end = NULL;
 	priv->pkt_hdr = NULL;
 }
 
@@ -595,14 +597,16 @@ int ax88179_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 			return 0;
 		}
 
+		/* The packet headers must lie in front of rx_hdr */
 		hdr_off = (u16)(rx_hdr >> 16);
-		if (hdr_off > len - 4) {
+		if (hdr_off + 4 * pkt_cnt > len - 4) {
 			usb_ether_advance_rxbuf(ueth, -1);
 			return -EIO;
 		}
 
 		priv->pkt_cnt = pkt_cnt;
 		priv->pkt_data = ptr;
+		priv->pkt_end = ptr + hdr_off;
 		priv->pkt_hdr = (u32 *)(ptr + hdr_off);
 		debug("%s: %d packets received, pkt header at %d\n",
 		      __func__, (int)priv->pkt_cnt, (int)hdr_off);
@@ -611,6 +615,13 @@ int ax88179_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	le32_to_cpus(priv->pkt_hdr);
 	pkt_len = (*priv->pkt_hdr >> 16) & 0x1fff;
 
+	/* The packet and its padding must lie in front of the packet headers */
+	if (((pkt_len + 7) & 0xFFF8) > priv->pkt_end - priv->pkt_data) {
+		priv->pkt_cnt = 0;
+		usb_ether_advance_rxbuf(ueth, -1);
+		return -EIO;
+	}
+
 	*packetp = priv->pkt_data + 2;
 
 	priv->pkt_data += (pkt_len + 7) & 0xFFF8;
