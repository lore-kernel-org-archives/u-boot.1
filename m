Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193ADC4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 08:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56C86407CE;
	Wed, 22 Jul 2026 08:15:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tqVmNV1O1TdI; Wed, 22 Jul 2026 08:15:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E0714079D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784708136;
	bh=LZ0DNTwhzWl++k7e6BcNfjygqsSxw2BEaDq0UFBH4aU=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QwLUdK6lZ7S9P+4nBQEaJ4KVl3OPyBtoj0uiB4WRPc+DEVmIgg6I3xrrdbkhKozXr
	 onQcNFcQTXSrr4YdXGsC1TGdn0YMJdnVX10/2UomHFzbvq5q3Z75TSBCcaIkwPhmAu
	 LrTHrgVeFV+K3HPluMqcNpx//jpsIX4ryIwrLGfN2mCtiFvtnWAE5+Gc44GfFuO3is
	 +4RXm5mQ0q8FOiHXrHM6rNh+U8uVCVKZJz62f8OK7/jmJjMCBVrSloX9FAHgH4pjZS
	 1CQVDx0SyYXnEyctg7iR/lISZCo1gkCEqnRJQVn5RRuwAZ98EJ+nPOSvI7CraQ560K
	 9a8hhD6cIuf/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E0714079D;
	Wed, 22 Jul 2026 08:15:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A103442A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91793605EE
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:08:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7trOHXN6bMCK for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:08:23 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F1450605D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1450605D8
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1450605D8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:08:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FF49803F6; Wed, 22 Jul 2026 09:08:20 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A43E848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:08:18 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15c42a45adso887677566b.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 00:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784704098; x=1785308898;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LZ0DNTwhzWl++k7e6BcNfjygqsSxw2BEaDq0UFBH4aU=;
 b=Qyl4fMfjow08zfet6QCS5ajEYaaOaYTLmHZf5IZWBZkW/wDTJunqmNCLDm9Iiiwgn6
 nwXyjQHPiYNQlO5Mi7vGtIGWlitYl2g8LdIlGV1DvhR5GPM0YD5O+Jzh5/5N7V4Z6i3f
 sDHXCN567HQV26SdMMhG7UPJp+9gObVixlZbyj9BdZukMMgY9JWqQNbiQOsmBJYKy3AL
 Bg0JOLeNTa+cGxkoYgWV4TuzfMUuClRsxiwzoIiv2kQ6aC1oG7w6sKLoNla8iJwOCJ5y
 1vYwvOV05rrdkxp3fYJJBOJrcxVNMqFEoQPLney1HmvjQ05JZB1bJ8PEDURxflfKdJmL
 +0xg==
X-Gm-Message-State: AOJu0YxD6/5UXefA630Hv+ZlD/jMqgVCgLNSESjzq33tU/mllVcwFdgB
 lEmZAQ4JHZPdVDkiIVbphfFM9zpK23fwaJeZ6Ku9SWJWk9UGWL09VffQ6YUW3rW0QXs=
X-Gm-Gg: AR+sD10Zak7iJ7zZdSS7J5Qi92hoSIlmJIrtiyZb4lGH03AQfYDbbqtw54/0oarEG/G
 Lbv9uK5C5GTl0lTQsNc+cPhvHNgWmwkPCxiFvv2AXRae9j9cl/uLey52nR5KHcbViBLSUfViLXb
 bdlFcUhKd8ulbHzwJZy/VnaKDpyDZuUAaf9kUbXbSsrW8LspG0DEmBY1a9RwC/Kgf0Rq3gjsPgZ
 veLx6pdECHAdvkpcj9T6UWnk5+Ip/gkdXtIFl6FZepB2i8wP7NYaOIAFZP1SbhE4AFEip3YoOAa
 I+7Gn32rTn7YiQJsh1eGP4/gdtY+8KFwScfi1yg2zIvdOAI+ZBLL2gC7IFuvqbVXAcuMgAL7WU6
 5BTW57VG4CFmUxM/de9iFD/6HCdiyobSpMnJ6VaH0MTIl7HvZbfbQ4NW80O4rEeuJ6JwgrjZK7z
 N0MScDnAGRGWcIM37NJHo5on0tht6o1MgT1GbiFjKGn9Kesae74ZHFFHW/4tnkKUV3+A==
X-Received: by 2002:a17:906:f5a8:b0:c15:fdfc:afa4 with SMTP id
 a640c23a62f3a-c1c310a46e7mr106646066b.23.1784704096665; 
 Wed, 22 Jul 2026 00:08:16 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed000709884cf8c8be3b.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:709:884c:f8c8:be3b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69f35039aa1sm501347a12.30.2026.07.22.00.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:08:16 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:05:59 +0200
Subject: [PATCH 1/2] net: fix out-of-bounds write in IP fragment reassembly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-net-oob-fix-v1-1-2c711321540c@byteray.co.uk>
References: <20260722-net-oob-fix-v1-0-2c711321540c@byteray.co.uk>
In-Reply-To: <20260722-net-oob-fix-v1-0-2c711321540c@byteray.co.uk>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Argus <argus@byteray.co.uk>, 
 shj <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 22 Jul 2026 08:15:34 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784704098; x=1785308898;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LZ0DNTwhzWl++k7e6BcNfjygqsSxw2BEaDq0UFBH4aU=;
 b=kClpbmM5qTniYstT2sTVf8MHzfJeU3rViKCbeU49GjplStYbSSknhHeELFX5avJ6J5
 fryDvHpG3RzmoRiL6VxjqipHfplJhNYc8TQf50GCZrngl/OeJm0LKelmVjZfrnxbKiJF
 Lbd0DYP/8NW88ajXtYt6gZqxQ6qnWqdXSnBFrP/2+TxHar4UQPvs/p2kVpFoGGoMJpFR
 YIdoj9HGRHg5UZTqJi9VY7/sDT7TzML6/kAKzv254hYe2CCLmuFvlFrbVuTar2Yssiyn
 74W4PymLi3n/c3ioPidCGQ4z36BoeypsC6i9GTwdts/1U5yrTeO/Y6W5BhD2CsKp4JDt
 bVcQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=kClpbmM5
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="kClpbmM5"; 
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
From: shj via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: shj <shahriyar@byteray.co.uk>
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

Signed-off-by: shj <shahriyar@byteray.co.uk>
---
 net/net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/net.c b/net/net.c
index 61c5a6ef..71666eb1 100644
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

