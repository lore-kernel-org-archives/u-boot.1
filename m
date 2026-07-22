Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3EBC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 08:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D77864080F;
	Wed, 22 Jul 2026 08:15:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 20J9hIImxB7Z; Wed, 22 Jul 2026 08:15:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 64FF9407FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784708140;
	bh=c74wL3uum1KzOEz9sOB4xmhPy+i/DbUz481zWZoi7lE=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=r6LSmNchTQLDmkH4VS79kc6mkqcMAK9CWjoE0VoKzx1m0KMQvSmEsSRxCQm41B5hg
	 4svKP8gBLn5bOifWNSnNKHst8KjUmofMCpndfVAdejGF+clPXNDFVCL+urpWPgGDn0
	 u64OXNBQpJFI8twa4vwyAOwm/m7cignesPEiaHldbN0NkYaDBbGSEPLxDDFWEpqCTV
	 MCnl5k04iCRAZ4B2uN2GIpKT9tdVbwSyLZvtUWuC6io28ydseVoCR2vwq+ZD4hObus
	 lH0e3FRcjblmvq/UQZLFTPV26JRc0ZaDkOMeFe3Gflb/iosW8rDV6k9CUyxr2YVHdT
	 d6YeqaPQSp80w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64FF9407FA;
	Wed, 22 Jul 2026 08:15:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30CDD10A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16FE5406F1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:08:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ubmNWNOn2t4z for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:08:24 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BCCBA406F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCCBA406F6
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCCBA406F6
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:08:23 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7613F846A4; Wed, 22 Jul 2026 09:08:21 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F5B8494B
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:08:18 +0200 (CEST)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so14421642a12.3
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 00:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784704098; x=1785308898;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c74wL3uum1KzOEz9sOB4xmhPy+i/DbUz481zWZoi7lE=;
 b=BFz8x9ebQevAOdAXsvgGeNFwNVL0Q1qWNk4IJhHz+TPb9Hdm5/q1ech/kj3XTOUBfz
 ranVxP4LD7gMu+k855MmtsmgEZsAlouDO0CuXiXMxKp2eWcRpidFuUCDD4O7VR3k6PpL
 JAZIOxlWf+pDOZC5oRWcSR932a5zSIQkoa4uX3XAWtYYR733UfVBr/rJGE14FC6yjjfD
 MxPDJ3P11gDALMNQ+ZTEUz0ge6qhOPQDO8WiMJXq9KffS9aIT8JXHZF8XmY8iL5Mpjmn
 Vja8dMPPIsYTWEkFoFg4v9Rm3MM+q7mOgPCjQJ58BQE+NKybtwJpldDjnE8W5e0n7+y+
 RwTA==
X-Gm-Message-State: AOJu0YzGoH3G+oiCPe/7u0z+kdoFGPuzNPrBGQYGbtLJ/L2PYQt0Vu8x
 pauAUasuRRxpTeK7u22CTqKPo8XCHgignSMerDONme2VA+oC4g3rBAMtOIPVURElWKs=
X-Gm-Gg: AR+sD12D6HmG+N6vdxKM3ws+dQ9BoOmkcefTo825yjyoPS2gvlOY8iZmXk0Yl01NU22
 tX2j5pClqCG4ZkdRkhJfBSEi66qszVpZV2LazuxnBhf9rL0XWrd3gcJPeyqII6VsvSUab1xTEwY
 kXTRxx6Nsk0dg11JuB9nD7eRDYULstXp/Ra9MzTcEWo9/9eNiMH0OiB0DAcCUyJ2uynpi2k1tiX
 uBWruVvG7/Yo/CEFt1acSvS8Pdfxpl9YjfPkFU+GhB6rfnDBdbi62c+Yq+JlGU9YiDieq8ulBBh
 9TSrEZieEG/pS61ui80D1bW8ZCF3JVjeGTxlHzUalfxwBoYybf1P/dpO/+envlZ3zern9AiaJF6
 qMvuBSGu3rSylz+atTSwPJXJQsB2ms+e4UeUKjVMIhkH1ZPBgkGsXxl1sTOI0sbkSvEp/GzU+M8
 fXUrKiqcS9WKz9nu/C+ADbmbnz50BX9Nm/14JuoPA90s/lotPGqFSpifBaNEZA0wUC5g==
X-Received: by 2002:a05:6402:530a:b0:69a:9355:ec35 with SMTP id
 4fb4d7f45d1cf-69e6534ab55mr8181778a12.41.1784704097983; 
 Wed, 22 Jul 2026 00:08:17 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed000709884cf8c8be3b.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:709:884c:f8c8:be3b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69f35039aa1sm501347a12.30.2026.07.22.00.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:08:17 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:06:00 +0200
Subject: [PATCH 2/2] test: net: add regression test for IP reassembly overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-net-oob-fix-v1-2-2c711321540c@byteray.co.uk>
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
 bh=c74wL3uum1KzOEz9sOB4xmhPy+i/DbUz481zWZoi7lE=;
 b=n8/c45g2KhqYoYPq7W2ba0E3vOO3CKDBR98KMI6vvocr92loIuqNeZXN9B/65/X6ah
 9/m0xP8KkDDfpXv+hZlgvtLaP4ukvSYf67kaQw6OEwQvJXnhMEQm9Q6wdprVKB9l6rf/
 yi2ttf6gmQadKlHIb/86CLRdzu+xCUJCLQseS/RltQCOjM6A/A5tBiCLHPxnh3iV/gxm
 zTqv7SRel3Y7KVvULeOGoMHryuXKlFBoCYA+/BqXK8ooqx0Y+zlH0zbT5fQRihg2E45o
 T0ZxEGyA22TOOR5CyKIZGqvj+d/GPrn6uwsYEeAfZY4jcONhS7gClzz/rZsz7odt7/fy
 KBlA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=n8/c45g2
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="n8/c45g2"; 
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

Add a DM test that feeds __net_defragment() a single crafted fragment
whose trailing hole descriptor lands just past pkt_buff.  Without the
preceding fix the 8-byte hole write goes out of bounds; with it the
fragment is dropped and no datagram is delivered.

Signed-off-by: shj <shahriyar@byteray.co.uk>
---
 test/dm/net_defrag.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/test/dm/net_defrag.c b/test/dm/net_defrag.c
index 3fd40de9..7501b252 100644
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

