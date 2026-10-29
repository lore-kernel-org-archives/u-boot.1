Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36D606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 06:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lORCTHsR;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vn+a1/gt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAAA9606BD;
	Thu, 29 Oct 2026 06:06:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r9BVLUCZzbVI; Thu, 29 Oct 2026 06:06:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 20AB260697
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793254015;
	b=AeYSWnqL0a0QLCO3lTvUvNYScuZJYMrerE3FoFJID9Hf+NTqYVNsaUIb1Lfyu0f6JbCo
	 UBRdW0TkuStFaWvDkEIYhygtwGZeTb3cEjgwtU5eEc0QgPlXq0TqvFtXWYGBJtjIchS65
	 5PPxxNKHhoVVE37S0hp6ZEFiLXgsSGatS8jnnxvmqKSNqGnDaULYbytQzrxRp2idopSEy
	 pFFuKA8EsorxWZo7N8Ul8kem9QhBHgovprtN5QzzfvLTnsUdLdSOR0NtThIYRjKGyY5z1
	 Br5Rsj0HXYt8hlWFANdaZRw1sC+4LPRHLykQ5vW9eySgdZiydWyjWf1tQQBv2TvVqlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793254015;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=J7s2Z8eM+ohIP1Nx20wIYFL7ka5szkwi2x+eobqgIn4=;
	b=EdjYEy/31oxvWq80IwV/Gha4SFcKnsnTuSgR0liHFM6Rr5ifxLk/rOg71P2Yw9E2Hct1
	 CjmtE/3naAD9LLxSJhSu8zJOkgCy+9BsdHEIRajtoe9UYxTr/uSnhijQhdCn3ratfDsbE
	 jrj6PxXEwD176f7iJ15rdKABJUn4SrWVWMk47pby14MQQwDi8Rsb0dvEl90Bmb0myNKv3
	 EYMNbYsH78+9JkpOVYLd7v81P0TZbZSshQQ5otjfg9ZOkW7wwZsLD3TTgqtSWLJUSZ4i1
	 0G8YKwxCKr8daAO0rYL1sXqwOR+HIWi48ZkDoKmuKiHQwFYpyhd3gf89w84ahRpLgGQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793254015;
	bh=J7s2Z8eM+ohIP1Nx20wIYFL7ka5szkwi2x+eobqgIn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lORCTHsR2VOiR6ORJSC0B704d+mExXzfcuKfDj5yaeAd7Ids0FHMHA1frmmHbkmVQ
	 NDvwKu1iBy6Q9styeTe6Z6LPlr6y0CUy+QWJgG9ie5X/keCenaWp2qh7INC6q2+bYL
	 wsRqzkO3otq4AvNlRHCPuBBTu0q26cf1R4ZCEeofrS8kSPRLtGg2OB07EfdP76x5Fx
	 nlLyG1eR+cT4xvX3fibkcqPvDpEih1Ol3twI4St8CoDxQJ6FKOTY2OLRcfwScU7m5P
	 567Om0foLbFRVqrwrAvaWF4/TWGPcA3XUE3sLPPsQV4RWG8UyhscDPsFOqWuG7wigi
	 GFgYh2axrVZww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20AB260697;
	Thu, 29 Oct 2026 06:06:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 83CB0472
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69A0D80E2A
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:06:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LOM-SbXod8yP for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:06:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8500180DAB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793254012;
 b=r3oxNlR5JzAsIJnYbc+yCXDoqeTpY57iAfVJI+l+dOTEry74/oHPJS8xLBWpDD6mvq7Y
 3e6L/FTWyfxwIvjmkYnEyXGa24DDiuaNuhqoHXwdk0wToz+2ejfEdUwm5qOPLTvgW22sU
 x2jS5Z/+b/MPwqKDX+MMjEy6I905IZYMJXPcNn5vwxAbQWb4mA8OmjhVaLgVHFuRszOVo
 A5T62vWyn/c1TJ4R0DhvhUyY5PJCanI4TLY7EzQTPyzj5zrEoVf1/A4fkHT4R92GdP7BD
 QYilvQmFieS0skcox3gtzAacWFSOht0PKEU1w1i4PlU3mubr/MY5WR6iGZ5hx8wJZZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793254012;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References;
 bh=J7s2Z8eM+ohIP1Nx20wIYFL7ka5szkwi2x+eobqgIn4=;
 b=A3pueFc9pgTM5dcCGsWYoi/H02JY6HVPEgIF/FNGgaDTgkoraG6FClkrPc7OcjAvP/G5
 5JdQD6709a/CSO+X3PRLrN+pUK5Lme65thDKNBu4Zw00JzPaT6dAdrGS2sFeeAv585moC
 Ywb1WGyEges5KGglgO2wFG59xtdjs3ryniZG0L1trPaLFkNBtnsKr+zP6z39EnkRpSA+M
 UDZgndllPKQAEblrcb/2ht1EneR2wM9HdDYlPubq9AhRibIBQCMNMimIPq+Zs3yn4i5o3
 OQvxKUC2fe+r6z8hlz7FrVD1SIRu29rvhSA7uS5dF7B/RYMFpWlGWpTJOsnfqWWx1uQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="vn+a1/gt"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=vn+a1/gt
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8500180DAB
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:06:51 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so1641205e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 23:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793254010; x=1793858810;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=J7s2Z8eM+ohIP1Nx20wIYFL7ka5szkwi2x+eobqgIn4=;
 b=vn+a1/gtUPl2XXywmrvc77c1BbLefZ7dZ3ZodFrKwnHtq0mzOQyqelDanusbBaVhAZ
 nPJi63F+pPtrtLxCfgBaj7mOo9hrdnT+DXFjkJwOFIdzZk5tHCg02BPuHMvI5dpZHRtO
 yNVRmxwcSyXLQBC/ELZBS1m72RJIl/bacOJD8y0DcHRWUxGrgY7bxJpU0LFy8KFM8dtD
 3F0PqtnhzlHdtTCAxTMgs4c7+ufYp4XQ06EHBGrZ3qPbfe2ZZL8UbOpxFesg+MKyTL2D
 ipsJ3pVc/KwbpHDVUojxiajRQRuuuedp/eKHb9Qua7E6VNiSdwBjrdWTk5CpCN6AEvEd
 KMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793254010; x=1793858810;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J7s2Z8eM+ohIP1Nx20wIYFL7ka5szkwi2x+eobqgIn4=;
 b=NlDzyQknkGDHtjYZmw/OWOGOTWC/WRQSFb/wEP5NxSba9r2x++OSOU6pgRMc30pbFl
 rLbPcZN1Etx37pvdoJcsl4CF1sFSOsNSH2/xiFDXaUZuwOZeVG2lSksrgU8fOplA55bI
 c0ipjYUo9+FjVgoAC/bgRetVJY/VlZBL9dGR+NyVeEr9yIZLN5yTMNNsi1J0H6te/Lg2
 vZdqyiol2Doh8PoWOC9OFZo9/nrFrzy1e0yWwfQnLaQ6GVoo75iSJ7qcrEmXR1Qq2+6W
 uWKt9GECRD++sr8LbjN3Q9fYKOpjjgRDNfzRzv5Sx9HaMBiUGcLa+bk5krrX8VVCewCA
 X7hg==
X-Forwarded-Encrypted: i=1;
 AKwUvByJWlZs9zqbQnyN219kr3Ayrvtb7DMoMhMRoBXpE9WFuxrk3n4QVmLgNStP7xhSS1sNpKGmHZA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLyVOMXptA+S3DIqmHoeNwU0TT4/rjdVkMzzd0sXZGMOTK9/MT7
 nnJyx/ZpsgU1ouj4mou6kxgy2hlnRnVMgV74Q/lDHoFRTOfp2xqLmNG9
X-Gm-Gg: AYBFou1vIKNGyAgnOtAJtJt0o3tUVqTzplOn8NYlB2uM/L4w0BLNNZbzSjtMYCgGbob
 aZZxVfC+q8KzIeQp0MGdIZXwSR5bcEhubbfNdNIMAabhRvEDl4JyfSweKb19xRL3YyyLtMf/6H2
 H+eTlL//FmVY05beAt4Bpf0gyCj7r64iMm08PI98avVo+niSvfN5CBYbLH5cwjuia8b9pAERoRl
 GCGJiQbdUe8xoJ70QQ3TVLfx6hs/egXaws1p5f8iHU+eyz3RM2FPngExwuzC6Yitb9SvWwKSimF
 YRmR6Xx/UppDDaWh6IUZbHStcQNWOPl9wrY+ImqvsZS2UO9k8O1Mwnlj3EIQtb4sXhq78c2W8I/
 5iPKGyx2p9kbYxPEtQCasMJDpQSnMonYomr3XWFJ+PE5pO5JsJclxeCi4Kj30/lTVNPOhtZbDs7
 V0Too0Q9ulsqnNFx6SyW3NmDCoysElthsy85oapia4wPT+KnJx7XGgbhA8MfKEFVjo9DNo1eQFi
 x5yGJ3+jkTHbX4Muko4RxekmQsidn/pZcnOfUSKzBQd7NwTM7UYoafrsWYbyFo1wpdt7rI3czDX
 heSqildZLrdEpkdDZBh38pGnf7OdNzBq3LnlBgQ3G/3WLWpeFto0Iw==
X-Received: by 2002:a05:600c:1546:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4aa86a42518mr36864835e9.2.1793254009783; 
 Wed, 28 Oct 2026 23:06:49 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm40901995f8f.49.2026.10.28.23.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 23:06:49 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org
Subject: [PATCH RESEND 1/4] usb: eth: r8152: Check the rx descriptor fits in
 the transfer
Date: Thu, 29 Oct 2026 06:06:48 +0000
Message-ID: <a9853b68-9331-4b1d-b202-847b8829c468@gmail.com>
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

r8152_eth_recv() reads the rx descriptor at the start of what is left of
the transfer without checking that a whole descriptor is there, and then
bounds the packet length with

	if (packet_len > len - (sizeof(struct rx_desc) + CRC_SIZE))

which is evaluated in size_t: when fewer than 28 bytes are left it wraps
and lets any packet length through, including one that wrapped in its
u16 because the descriptor gave a length below CRC_SIZE. A short
transfer from the adapter then hands the network stack a packet whose
start and length run past the received data, and past the end of the
2 KiB receive buffer.

Require a whole descriptor and CRC before reading the descriptor, and
work in int so that neither length can wrap.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/usb/eth/r8152.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/eth/r8152.c b/drivers/usb/eth/r8152.c
index e3f20e08c33..19b3f0bc22a 100644
--- a/drivers/usb/eth/r8152.c
+++ b/drivers/usb/eth/r8152.c
@@ -1471,9 +1471,8 @@ int r8152_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	struct r8152 *tp = dev_get_priv(dev);
 	struct ueth_data *ueth = &tp->ueth;
 	uint8_t *ptr;
-	int ret, len;
+	int ret, len, packet_len;
 	struct rx_desc *rx_desc;
-	u16 packet_len;
 
 	len = usb_ether_get_rx_bytes(ueth, &ptr);
 	debug("%s: first try, len=%d\n", __func__, len);
@@ -1488,12 +1487,18 @@ int r8152_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 		debug("%s: second try, len=%d\n", __func__, len);
 	}
 
+	if (len < (int)(sizeof(struct rx_desc) + CRC_SIZE)) {
+		debug("Rx: incomplete packet: %d\n", len);
+		goto err;
+	}
+
 	rx_desc = (struct rx_desc *)ptr;
 	packet_len = le32_to_cpu(rx_desc->opts1) & RX_LEN_MASK;
 	packet_len -= CRC_SIZE;
 
-	if (packet_len > len - (sizeof(struct rx_desc) + CRC_SIZE)) {
-		debug("Rx: too large packet: %d\n", packet_len);
+	if (packet_len < 0 ||
+	    packet_len > len - (int)(sizeof(struct rx_desc) + CRC_SIZE)) {
+		debug("Rx: bad packet length: %d\n", packet_len);
 		goto err;
 	}
 
