Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D480C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D762B8137E;
	Tue, 28 Jul 2026 12:59:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P-anbOdgbyoH; Tue, 28 Jul 2026 12:59:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31F5F81380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243592;
	bh=akCy1CPMtN7HnHZsQKn5TkV2DRiqxy14VJPBJT+Y/O4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uDemXVRQoBbpdYMCExt5ukn8SSVrUvh9e5io2iHBrNVl/uKA14n966Hm7ICsJFWr6
	 qSph3lvN/BYVfK2vSYC+KgZjmr5hPn9VU+MnuHBPb1wKYgbXIDdngQPwvgrseOsA35
	 zr75KpqzqOHir4HcY3/qJblLKYkGmHheo2nK0+kM6NhOva5S0IKajxNfmuFRYpL46X
	 lA5HQCjXF7doFqzJ1+6UkAb8zbU2j1eDugBGbGro+WDfBW9TCFehH0z3oC2hj6dAsh
	 n382pH9rLY00rBPBdcPsw4IopyoHk+IcCnon6IMLC+rp+k9j4td1QmMbWYzUUY5eJy
	 951RXtzU5i04A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31F5F81380;
	Tue, 28 Jul 2026 12:59:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 98D04357
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F7614088B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:50:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Px9N4XUP8Bwv for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:50:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4211D40889
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4211D40889
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4211D40889
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:50:29 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9315684873; Tue, 28 Jul 2026 08:50:27 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93F2C82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 08:50:25 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69fe3cd5ee6so3598592a12.2
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 23:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221425; x=1785826225;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=akCy1CPMtN7HnHZsQKn5TkV2DRiqxy14VJPBJT+Y/O4=;
 b=WsJVLIhkxSF+JJmC1ThN9PhJ9SJrQllz3QZoOiSBvwXVJASacJzyQ4uMsfbfSo6QB3
 352vdeNb3zFg7cqJMnSBGDMNhma3UqRACITuna24l7SlKMSGokV6YSXCA2OKOCxqKPa4
 ZKR1YxgJAfY6EqnuwjuXaVbkvSI2wKT6zp4gO/34OMYgnbaUCOS0G/JHVmCGcLkRJ6tw
 Bj/KAO+GA8qDX0Lt+NeRAAJA5waVHPc2Zgw7h1eV+vuszMcdSP9Gcwqnnnb6ehYvL5KI
 hUhENcFOrmwYZQBN6Gbxd2ejyiUqpOewXjGdCbAsFEYTFBW3Ysd5Q2BzBykf4L125toj
 adlg==
X-Gm-Message-State: AOJu0Yy8dzcZONd/RaWxbD98+0UQVI+HvQ3UHMpzXvnR4D5AFhG/s1+l
 4+ULAuKQ2I4GXhu/kKgoiq6elY5zsOi6qaHgP2FHTeFNA0ZxRlFNOQcZAecar8puZTM=
X-Gm-Gg: AR+sD12yF9LPTqWQymjb+A688ARzVhMC8G7Xdte5CUEgBBQUBXXEa5lfOfe8+JxwOPR
 6/Yyz4fk8wK5HD7zBnEpj+0LKKE8xxDmH+zEce0b7EJIJGiAvvpCCS68fEsWEKX77GM8XMm9OaR
 LZiJVZxE8JWZRgSX5ZeDqnY+/6NiCT9mTVTU82eiaGsQErAb45i5wmv3yQ5jzEIpfrCUyzc0TPk
 BB/gLm4p0qpLRL+92ioJSdJVlmVXRug8/twdYB6H5jWQssGAW3t1H701e3/uDEGezxs7Mtfjbk4
 Uwj/NmeUwgwZvzqZK7ud858+IV+gn3qhKpjmh/YfYIek1uub3a8wTGlbU3aZrvKbKWJT+d6d3/g
 xpvwiyOSho94XFkHxSIwbJcpoJQTzqI273I5o4jZjjAcVSRhG/CozwXY66JcKL/sjxRSH5sCUrk
 n6uXh40mqjwHlWhZIGuYTG653n/hJxJTfe73y6GB7RP9bU+OpcchM4Ko1mfccDo9hKGAM=
X-Received: by 2002:a05:6402:2696:b0:698:3469:fa99 with SMTP id
 4fb4d7f45d1cf-6a03492545emr474020a12.0.1785221424848; 
 Mon, 27 Jul 2026 23:50:24 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00d97d5688120f3c08.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:d97d:5688:120f:3c08])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb55438easm3557725a12.18.2026.07.27.23.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 23:50:23 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Tue, 28 Jul 2026 08:50:08 +0200
Subject: [PATCH v2 2/2] test: net: add regression test for IP reassembly
 overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-net-oob-fix-v2-2-eae61b883ed8@byteray.co.uk>
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
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785221425; x=1785826225;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=akCy1CPMtN7HnHZsQKn5TkV2DRiqxy14VJPBJT+Y/O4=;
 b=jMLriMis0gdTLFP5PAgsxdOEy2xiv+ezhLwvUr3KcGxVoX9Qawm2H+Lz/zE4/fFP2C
 /LwT4wS/DAb+Iav2W7BWlf+IZykR7MRqyXeSHAKjK/KNSn/P2ubymfxZ8m/QhkPbnpq1
 xkFFSaDprNfgaTprGgZAlQ5SBhWSVi4KuA+WRCS+Q6JVAwiGNjbG8FLxAh1HPUe769VI
 1pGTzr8GX257mjvf2+ou+f7jmH5aznjljBadcg14+ukxLZ5uEMc39A3jSeVnPEcWfdqg
 idMVsAh6zmtDSsTwLpC1vYO3LRlbme5/1/CzjmNdUzhn+qvme/usr2Xz7vAfU2h0dJkr
 SoYg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=none
 smtp.mailfrom=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=jMLriMis
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="jMLriMis"; 
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

Add a DM test that feeds __net_defragment() a single crafted fragment
whose trailing hole descriptor lands just past pkt_buff.  Without the
preceding fix the 8-byte hole write goes out of bounds; with it the
fragment is dropped and no datagram is delivered.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Acked-by: Jerome Forissier <jerome.forissier@arm.com>
---
 test/dm/net_defrag.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/test/dm/net_defrag.c b/test/dm/net_defrag.c
index 3fd40de90cd..7501b252db9 100644
--- a/test/dm/net_defrag.c
+++ b/test/dm/net_defrag.c
@@ -80,3 +80,39 @@ static int dm_test_net_ip_defrag_dup_last(struct unit_test_state *uts)
 }
 
 DM_TEST(dm_test_net_ip_defrag_dup_last, 0);
+
+/*
+ * A fragment placed at the very top of the reassembly buffer takes the
+ * split-hole branch, which writes an 8-byte "struct hole" at
+ * pkt_buff + IP_HDR_SIZE + (offset8 + len / 8) * 8. With start + len equal to
+ * IP_MAXUDP that write reaches the end of pkt_buff and spills past it. pkt_buff
+ * is a static array, so this is flagged under AddressSanitizer; the fix rejects
+ * such a fragment instead. The datagram is incomplete, so nothing is delivered
+ * either way.
+ */
+static int dm_test_net_ip_defrag_oob(struct unit_test_state *uts)
+{
+	rxhand_f *saved_handler = net_get_udp_handler();
+	uchar frame[FRAME_LEN];
+	struct ip_udp_hdr *ip = (struct ip_udp_hdr *)(frame + ETHER_HDR_SIZE);
+	u16 payload[4] = { 0, 0, 0, 0 };
+	/* Offset (8-byte units) so that start + FRAG_LEN == IP_MAXUDP. */
+	u16 off8 = (CONFIG_NET_MAXDEFRAG - IP_HDR_SIZE - FRAG_LEN) / 8;
+
+	udp_rx_count = 0;
+	net_set_udp_handler(defrag_udp_handler);
+
+	build_frag(frame, IP_FLAGS_MFRAG | off8, payload);
+	/* A distinct id forces a fresh reassembly independent of earlier tests. */
+	ip->ip_id = htons(0x7abc);
+	ip->ip_sum = 0;
+	ip->ip_sum = compute_ip_checksum(ip, IP_HDR_SIZE);
+	net_process_received_packet(frame, FRAME_LEN);
+
+	ut_asserteq(0, udp_rx_count);
+
+	net_set_udp_handler(saved_handler);
+
+	return 0;
+}
+DM_TEST(dm_test_net_ip_defrag_oob, 0);

-- 
2.43.0

