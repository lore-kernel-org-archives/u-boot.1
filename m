Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF1EC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7014260890;
	Tue, 28 Jul 2026 12:59:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZ7xO8EFgYHm; Tue, 28 Jul 2026 12:59:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50A0560882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243590;
	bh=VHd7IYQiVKX7BTky55QoF/azf64UUHLmomek2PdBh0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZJKtg/xyTxrNtzz2hqCbq+Wu5k0r6YxYyEXrX496UK4kI7jDTIo0if6dlDqlNhDoG
	 UBX6Q1S8J1Bj/I0369jCicYkFzODmHpGQ1TatRfB3wOd/JlHCueGAChcVa8KtVHirZ
	 EI1vFY2uaCj13KH6gnJMbloYtoSRHv84QIncFnM+PZHNfcS/yZKFamB7Rgmjdloim6
	 K07o4Kp/19IPxjk96IY2yYAzLsp7Aspu4E9/d1EgfXPDiLmtPXKL/U+2pSRRK6zEVR
	 L8mZqNivJQcZTzS+lTt2SLs6sNhg/8FJ5TxGc1IkOtjFoYbS/sRC5wINPFZsbZhaPI
	 Jp9GvG5GNj6ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50A0560882;
	Tue, 28 Jul 2026 12:59:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C805C23F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ADEE140245
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U1T3lOpGVfvP for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:50:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=shahriyar@byteray.co.uk;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1547C40042
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1547C40042
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1547C40042
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:50:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 028C98494B; Tue, 28 Jul 2026 08:50:26 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F39C184873
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 08:50:23 +0200 (CEST)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69ff40d9cbcso2734217a12.0
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 23:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221423; x=1785826223;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VHd7IYQiVKX7BTky55QoF/azf64UUHLmomek2PdBh0k=;
 b=R+HM7G2x1Mzws3mUMR24UprkKbLyrVtuO8CaibedeiSpsl1uYkT0V5f4Tsz3Oof074
 9CwIoFW7cfovp6woeptHeDQKBtxamTLBEw9q2f9gwrxiYafqCsbRBn6r3EjSJYkEsrm8
 dKU7tFZGZsWdU8OwggHvZsYw0YzBK+iODB0kvKmRNJ0B3RI+dP6sQ1uMW1Moq/vqPpvo
 oHC1JOEkUL/+QsXKogIppGiNS5MNmZNFCEgFD+bKlU8Z6ZFuoNTgyWQIRJt4WDMwRp1R
 iGegQ2cLtoaqV1ZTTHV+QP0wjhhTWREmoEhMcmBRTR+flwwLSFp3Z38ID77B3q3DGWHU
 Xsww==
X-Gm-Message-State: AOJu0YxkrJ8CJvubPInRLzgFfaqSoRZKg+vInMlEGp6YSqZPDn0M4QsJ
 uK1NQbYpxbJ5vF/Mkt+T1+Nrepqa/HA/xM0OOh1gfgFysVYJ2CHBd/EyczP7p/ftudw=
X-Gm-Gg: AR+sD117zicfQQmoewqFsyTfChc2et5qBK4RNdDIPqm7Pafgj24V1qc+ceQkRWgS+z1
 VKTsfNhJDZA4iWzF89wWeFqE92sYdLP7lEJk8Nt4D80YviHa8bQM1yXLPxM7oU4sMJda1iEmVOU
 FHsOoSe2Wze98x7kR1BI2FmMlNzIVdxNImowFb1ShKVk27NA4WVbluf7GJHHoOly6RGRMDNQUon
 zR4ReTsWIpYcKHd5HTFhk+Hkv723XORIkoIjoxh+UggVu6mh2V2LGfFZGqDQEkOEQI3iTiq0sL7
 SG4/ZHaYg0uID7DWHlpY7h7AxzTfh8EDqOL8FtQnxYHza6mCe6zsYtEQ4+BPYuByKXGuxjxVefL
 MVuauIeOuk/QZo72XPLMDURKyIT7afrxzQYQJU8rwBBnROm1LypRjOdmS3wqwymy49BDbsOS/UX
 pdz2Rc8tN7yCxXIZWzXLHBm/zouywT4KnNrZ6vSiU40BYBw7iWCtX/HsUN71F/+p7aVGQ=
X-Received: by 2002:a05:6402:26d6:b0:69f:aca0:3bb6 with SMTP id
 4fb4d7f45d1cf-6a034a99f36mr422559a12.40.1785221423332; 
 Mon, 27 Jul 2026 23:50:23 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00d97d5688120f3c08.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:d97d:5688:120f:3c08])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb55438easm3557725a12.18.2026.07.27.23.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 23:50:23 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Tue, 28 Jul 2026 08:50:07 +0200
Subject: [PATCH v2 1/2] net: fix out-of-bounds write in IP fragment reassembly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-net-oob-fix-v2-1-eae61b883ed8@byteray.co.uk>
References: <20260728-net-oob-fix-v2-0-eae61b883ed8@byteray.co.uk>
In-Reply-To: <20260728-net-oob-fix-v2-0-eae61b883ed8@byteray.co.uk>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Argus <argus@byteray.co.uk>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785221423; x=1785826223;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VHd7IYQiVKX7BTky55QoF/azf64UUHLmomek2PdBh0k=;
 b=R3T29iDdPHSXErR8rL+OwaiR8i87ac6LAU50jVX0vxoDE94gfa71d/Zj2wsfzIaehA
 pfBb1zTjl5bNNb/lTIv/wQ8dCYDjNcunKE/c3amltLIPkPd6UF5nIpx0nqxmMC3j0KC7
 qcQWkiW7DzIXv0HNFt+5t/vuj20hiI3lMA+sSvlyOX7Yj2ELxSj+Eh2K5mmTtPda1S5Y
 hahxqWtS0bD7tp4Jk6ROfeyEiAjn6QvBHfhk7LE+75+r0NNNyLVIpBDwU1OfYnpqaqT3
 htmj41ChB6Q8ryQtvj+Gaol/RHHH7yd62x2tVd7KnzDTFXaHtiID9CBkbJTDN2OlvTP5
 yKqw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org; spf=none
 smtp.mailfrom=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=R3T29iDd
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="R3T29iDd"; 
 dkim-atps=neutral
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

__net_defragment() reassembles IP fragments into the static buffer
pkt_buff[CONFIG_NET_MAXDEFRAG].  The bounds check

	if (start + len > IP_MAXUDP)
		return NULL;

only covers the fragment data copy.  The split-hole and move-hole
branches additionally write an 8-byte struct hole via "*newh = *h" at
newh = thisfrag + len / 8, which can land up to sizeof(struct hole)
bytes past the end of pkt_buff.  A single fragment with a non-zero
fragment offset and the More-Fragments flag set reaches this path, so
a crafted fragment received during netboot overflows the buffer.

Reject any fragment whose trailing hole descriptor would fall outside
pkt_buff.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Acked-by: Jerome Forissier <jerome.forissier@arm.com>
---
 net/net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/net.c b/net/net.c
index 61c5a6ef6c4..71666eb1113 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1076,6 +1076,8 @@ static struct ip_udp_hdr *__net_defragment(struct ip_udp_hdr *ip, int *lenp)
 	} else if (h >= thisfrag) {
 		/* overlaps with initial part of the hole: move this hole */
 		newh = thisfrag + (len / 8);
+		if ((uchar *)(newh + 1) > pkt_buff + IP_PKTSIZE)
+			return NULL;	/* hole descriptor would overflow pkt_buff */
 		*newh = *h;
 		h = newh;
 		if (h->next_hole)
@@ -1088,6 +1090,8 @@ static struct ip_udp_hdr *__net_defragment(struct ip_udp_hdr *ip, int *lenp)
 	} else {
 		/* fragment sits in the middle: split the hole */
 		newh = thisfrag + (len / 8);
+		if ((uchar *)(newh + 1) > pkt_buff + IP_PKTSIZE)
+			return NULL;	/* hole descriptor would overflow pkt_buff */
 		*newh = *h;
 		h->last_byte = start;
 		h->next_hole = (newh - payload);

-- 
2.43.0

